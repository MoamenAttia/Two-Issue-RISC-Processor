library ieee;
use ieee.std_logic_1164.all;

-- note
-- in the D/E Buffer we need to augment a signal called jump instruction.

entity hazard_unit is
	port (
        -- first instruction
        IF_ID_opCode1 : in std_logic_vector(1 downto 0);
        IF_ID_func1   : in std_logic_vector(2 downto 0);
        IF_ID_Rsrc1   : in std_logic_vector(3 downto 0);
        IF_ID_Rdst1   : in std_logic_vector(3 downto 0);
        
        -- second instruction
        IF_ID_opCode2 : in std_logic_vector(1 downto 0);
        IF_ID_func2   : in std_logic_vector(2 downto 0);
        IF_ID_Rsrc2   : in std_logic_vector(3 downto 0);
        IF_ID_Rdst2   : in std_logic_vector(3 downto 0);

        -- Buffer between Decode and Execute
        ID_EXE_branch_taken1 : in std_logic;
        ID_EXE_MemoryRead1   : in std_logic;
        ID_EXE_MemoryRead2   : in std_logic;
        ID_EXE_Rdst1         : in std_logic_vector(3 downto 0);
        ID_EXE_Rdst2         : in std_logic_vector(3 downto 0);
        
        -- Buffer between Execution and Memory
        EXE_MEM_stall_long   : in std_logic;  
    
        -- output
        clear_second : out std_logic;
        stall_long   : out std_logic;
        RST_IR       : out std_logic;
        PC_selector  : out std_logic_vector(2 downto 0);
        new_address  : out std_logic_vector(3 downto 0);

    );
end hazard_unit;

architecture a_hazard_unit of hazard_unit is


------------------ one operand hazard detection ---------------------
-- NOP 
signal nop_first_in_packet_handle  : std_logic; -- nop is an exception because rsrc and rdst are x"0" which can make hazard if we didn't handle it.
signal nop_second_in_packet_handle : std_logic; -- nop is an exception because rsrc and rdst are x"0" which can make hazard if we didn't handle it.

-- SETC
signal setc_first_in_packet_handle  : std_logic; -- setc is an exception because rsrc and rdst are x"0" which can make hazard if we didn't handle it.
signal setc_second_in_packet_handle : std_logic; -- setc is an exception because rsrc and rdst are x"0" which can make hazard if we didn't handle it.

-- CLRC
signal clrc_first_in_packet_handle  : std_logic; -- clrc is an exception because rsrc and rdst are x"0" which can make hazard if we didn't handle it.
signal clrc_second_in_packet_handle : std_logic; -- clrc is an exception because rsrc and rdst are x"0" which can make hazard if we didn't handle it.

-- IN
signal in_first_in_packet_handle    : std_logic; -- we cannot use two in instructions at the same packet.
signal in_second_in_packet_handle   : std_logic; -- we cannot use two in instructions at the same packet.

-- OUT
signal out_first_in_packet_handle    : std_logic; -- we cannot use two out instructions at the same packet.
signal out_second_in_packet_handle   : std_logic; -- we cannot use two out instructions at the same packet.

-- MEMORY
signal memory_first_in_packet_handle  : std_logic;
signal memory_second_in_packet_handle : std_logic;

signal memory_hazard                  : std_logic; -- hazard due to memory ( structural ).

-- IN/OUT
signal in_hazard                      : std_logic; -- hazard due to in.
signal out_hazard                     : std_logic; -- hazard due to out.

-- MOV EXCEPTION
signal mov_first_in_packet_handle     : std_logic; -- dealing with move is slightly different. 
signal mov_second_in_packet_handle    : std_logic; -- dealing with move is slightly different.

-- Load EXCEPTION
signal load_first_in_packet_handle     : std_logic;
signal load_second_in_packet_handle    : std_logic;


-- RAW HAZARD
signal raw_hazard                     : std_logic; -- read after write.
signal waw_hazard                     : std_logic; -- write after write.
signal jmp_inner_hazard               : std_logic; -- no jump in 2nd in packet.

signal exception_data_inner           : std_logic;

-- DATA INNER HAZARD
signal data_inner_hazard              : std_logic;



signal flush_due_to_branch            : std_logic;
signal flush_due_to_load_immediate    : std_logic;
signal flush_due_to_data_outer        : std_logic;

signal exception_mov_first  : std_logic;
signal exception_mov_second : std_logic;

signal exception_out_first  : std_logic;
signal exception_out_second : std_logic;

signal exception_load_first  : std_logic;
signal exception_load_second : std_logic;


signal exception_data_outer_first : std_logic;
signal exception_data_outer_second : std_logic;

signal first_depend_outer_first   : std_logic;
signal second_depend_outer_first  : std_logic;
signal first_depend_outer_second  : std_logic;
signal second_depend_outer_second : std_logic;


signal src1_depend_outer_dst1 : std_logic;
signal src2_depend_outer_dst1 : std_logic;
signal src1_depend_outer_dst2 : std_logic;
signal src2_depend_outer_dst2 : std_logic;

signal dst1_depend_outer_dst1 : std_logic;
signal dst2_depend_outer_dst1 : std_logic;
signal dst1_depend_outer_dst2 : std_logic;
signal dst2_depend_outer_dst2 : std_logic;


-- DATA OUTER HAZARD
signal data_outer_hazard_one   : std_logic;
signal data_outer_hazard_two   : std_logic;
signal data_outer_hazard_three : std_logic;
signal data_outer_hazard_four  : std_logic;

signal data_outer_hazard       : std_logic;

-- CONTROL HAZARD
signal jmp_hazard              : std_logic;
signal control_hazard          : std_logic;
signal load_immediate_hazard   : std_logic;

signal stall : std_logic;

begin


    -- NOP EXCEPTION.
    nop_first_in_packet_handle      <= '1' when (IF_ID_opCode1 = "00" and  IF_ID_func1 = "000") else '0';
    nop_second_in_packet_handle     <= '1' when (IF_ID_opCode2 = "00" and  IF_ID_func2 = "000") else '0';

    
    -- SETC EXCEPTION.
    setc_first_in_packet_handle     <= '1' when (IF_ID_opCode1 = "00" and  IF_ID_func1 = "001") else '0';
    setc_second_in_packet_handle    <= '1' when (IF_ID_opCode2 = "00" and  IF_ID_func2 = "001") else '0';

    -- CLRC EXCEPTION.
    clrc_first_in_packet_handle     <= '1' when (IF_ID_opCode1 = "00" and  IF_ID_func1 = "001") else '0';
    clrc_second_in_packet_handle    <= '1' when (IF_ID_opCode2 = "00" and  IF_ID_func2 = "001") else '0';

    -- IN
    in_first_in_packet_handle       <= '1' when (IF_ID_opCode1 = "00" and  IF_ID_func1 = "111") else '0';
    in_second_in_packet_handle      <= '1' when (IF_ID_opCode2 = "00" and  IF_ID_func2 = "111") else '0';

    -- OUT
    out_first_in_packet_handle      <= '1' when (IF_ID_opCode1 = "00" and  IF_ID_func1 = "110") else '0';
    out_second_in_packet_handle     <= '1' when (IF_ID_opCode2 = "00" and  IF_ID_func2 = "110") else '0';

    -- LOAD
    load_first_in_packet_handle     <= '1' when (IF_ID_opCode1 = "10" and  (IF_ID_func1 = "010" or IF_ID_func1 = "011")) else '0';
    load_second_in_packet_handle    <= '1' when (IF_ID_opCode2 = "10" and  (IF_ID_func2 = "010" or IF_ID_func2 = "011")) else '0';
    
    -- MOV
    mov_first_in_packet_handle  <= '1' when (IF_ID_opCode1 = "01" and  IF_ID_func1 = "000") else '0';
    mov_second_in_packet_handle <= '1' when (IF_ID_opCode2 = "01" and  IF_ID_func2 = "000") else '0';

    -- Memory
    memory_first_in_packet_handle   <= '1' when (IF_ID_opCode1 = "10") else '0';
    memory_second_in_packet_handle  <= '1' when (IF_ID_opCode2 = "10") else '0';

    -- Memory HAZARD
    memory_hazard <= '1' when (memory_first_in_packet_handle = '1' and memory_second_in_packet_handle = '1') else '0';
    
    -- JMP INNER HAZARD
    jmp_inner_hazard <= '1' when (IF_ID_opCode2 = "11" and  (IF_ID_func2 = "000" or IF_ID_func2 = "001" or IF_ID_func2 = "010" or IF_ID_func2 = "011")) else '0';

    -- IN HAZARD
    in_hazard <= '1'  when (in_first_in_packet_handle = '1' and in_second_in_packet_handle = '1') else '0';
    
    -- OUT HAZARD
    out_hazard <= '1' when (out_first_in_packet_handle = '1' and out_second_in_packet_handle = '1') else '0';
   
    -- RAW HAZARD
    raw_hazard <= '1' when (IF_ID_Rsrc2 = IF_ID_Rdst1 and not(IF_ID_Rdst1 = "0000")) else '0'; 
    waw_hazard <= '1' when (IF_ID_Rdst2 = IF_ID_Rdst1 and not(IF_ID_Rdst1 = "0000")) else '0';

    -- DATA INNER HAZARD
    data_inner_hazard <= raw_hazard or waw_hazard or memory_hazard or in_hazard or out_hazard or jmp_inner_hazard;


    -- DATA OUTER HAZARD DETECTION

    ------ EXCEPTION MOV, LOAD, OUT -----------
    src1_depend_outer_dst1 <= '1' when (IF_ID_Rsrc1 = ID_EXE_Rdst1) else '0';
    src2_depend_outer_dst1 <= '1' when (IF_ID_Rsrc2 = ID_EXE_Rdst1) else '0';
    src1_depend_outer_dst2 <= '1' when (IF_ID_Rsrc1 = ID_EXE_Rdst2) else '0';
    src2_depend_outer_dst2 <= '1' when (IF_ID_Rsrc2 = ID_EXE_Rdst2) else '0';

    dst1_depend_outer_dst1 <= '1' when (IF_ID_Rdst1 = ID_EXE_Rdst1) else '0';
    dst2_depend_outer_dst1 <= '1' when (IF_ID_Rdst2 = ID_EXE_Rdst1) else '0';
    dst1_depend_outer_dst2 <= '1' when (IF_ID_Rdst1 = ID_EXE_Rdst2) else '0';
    dst2_depend_outer_dst2 <= '1' when (IF_ID_Rdst2 = ID_EXE_Rdst2) else '0';

    -- EXCEPTION MOV
    exception_mov_first   <= '1' when (mov_first_in_packet_handle = '1' and src1_depend_outer_dst1 = '0' and src1_depend_outer_dst2 = '0') else '0';
    exception_mov_second  <= '1' when (mov_first_in_packet_handle = '1' and src2_depend_outer_dst1 = '0' and src2_depend_outer_dst2 = '0') else '0';
    
    -- EXCEPTION LOAD
    exception_load_first  <= '1' when (load_first_in_packet_handle  = '1' and src1_depend_outer_dst1 = '0' and src1_depend_outer_dst2 = '0') else '0';
    exception_load_second <= '1' when (load_second_in_packet_handle = '1' and src2_depend_outer_dst1 = '0' and src2_depend_outer_dst2 = '0') else '0';
    
    -- EXCEPTION OUT
    exception_out_first   <= '1' when (out_first_in_packet_handle  = '1' and src1_depend_outer_dst1 = '0' and src1_depend_outer_dst2 = '0') else '0';
    exception_out_second  <= '1' when (out_second_in_packet_handle = '1' and src2_depend_outer_dst1 = '0' and src2_depend_outer_dst2 = '0') else '0';

    -- EXCEPTION DATA OUTER
    exception_data_outer_first  <= exception_mov_first  or exception_load_first  or exception_out_first;
    exception_data_outer_second <= exception_mov_second or exception_load_second or exception_out_second;

    first_depend_outer_first   <= src1_depend_outer_dst1 or dst1_depend_outer_dst1;
    second_depend_outer_first  <= src2_depend_outer_dst1 or dst2_depend_outer_dst1;
    first_depend_outer_second  <= src1_depend_outer_dst2 or dst1_depend_outer_dst2;
    second_depend_outer_second <= src2_depend_outer_dst2 or dst2_depend_outer_dst2;


    data_outer_hazard_one   <= '1' when  ID_EXE_MemoryRead1 = '1' and exception_data_outer_first  = '0'  and first_depend_outer_first   = '1' else '0';
    data_outer_hazard_two   <= '1' when  ID_EXE_MemoryRead1 = '1' and exception_data_outer_second = '0'  and second_depend_outer_first  = '1' else '0';
    data_outer_hazard_three <= '1' when  ID_EXE_MemoryRead2 = '1' and exception_data_outer_first  = '0'  and first_depend_outer_second  = '1' else '0';
    data_outer_hazard_four  <= '1' when  ID_EXE_MemoryRead2 = '1' and exception_data_outer_second = '0'  and second_depend_outer_second = '1' else '0'; 

    data_outer_hazard <= data_outer_hazard_one or data_outer_hazard_two or data_outer_hazard_three or data_outer_hazard_four;

    -- CONTROL HAZARD
    
    -- JMP HAZARD
    jmp_hazard <= '1' when ID_EXE_branch_taken1 = '1' else '0';
    
    -- LOAD IMMEDIATE HAZARD
    load_immediate_hazard <= '1' when (IF_ID_opCode2 = "01" and (IF_ID_func2 = "101" or IF_ID_func2 = "110")) or (IF_ID_opCode2 = "10" and IF_ID_func2 = "010" ) else '0';

    control_hazard <= jmp_hazard or load_immediate_hazard;


    flush_due_to_branch <= jmp_hazard;
    flush_due_to_load_immediate <= '1' when (IF_ID_opCode1 = "01" and (IF_ID_func1 = "101" or IF_ID_func1 = "110")) or (IF_ID_opCode1 = "10" and IF_ID_func1 = "010" ) else '0';
    flush_due_to_data_outer <= data_outer_hazard;
    --------------------------------------------------------------------

    -- OUTPUT
    stall <= data_inner_hazard or data_outer_hazard or control_hazard; 
    stall_long  <= flush_due_to_branch or flush_due_to_data_outer; -- to reset IR twice. one in the decode buffer ( which has branch_taken ) and one in the Exe Buffer why!? EL PC mal724 el data and memory loaded another packet.
    new_address <= ID_EXE_Rdst1; -- an input to entity that takes 4 bits ( register ) and returns its data.

    clear_second <= stall or flush_due_to_load_immediate or flush_due_to_branch;

    RST_IR <= '1' when stall_long = '1' or EXE_MEM_stall_long = '1' else '0';

    PC_selector <= "100" when jump_hazard = '1' else
                   "001" when stall = '1' else
                   "000";

    -- assumnption
    -- 100 => PC = R[new_address]
    -- 000 => PC = PC + 2
    -- 001 => PC = PC - 1
end architecture;