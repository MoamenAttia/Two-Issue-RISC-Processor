library ieee;
use ieee.std_logic_1164.all;

entity hazard_unit is
	port (
        -- first instruction
        TEMP_IF_ID_opCode1 : in std_logic_vector(1 downto 0);
        TEMP_IF_ID_func1   : in std_logic_vector(2 downto 0);
        TEMP_IF_ID_Rsrc1   : in std_logic_vector(3 downto 0);
        TEMP_IF_ID_Rdst1   : in std_logic_vector(3 downto 0);
        
        -- second instruction
        TEMP_IF_ID_opCode2 : in std_logic_vector(1 downto 0);
        TEMP_IF_ID_func2   : in std_logic_vector(2 downto 0);
        TEMP_IF_ID_Rsrc2   : in std_logic_vector(3 downto 0);
        TEMP_IF_ID_Rdst2   : in std_logic_vector(3 downto 0);

        -- Buffer between Decode and Execute
        ID_EXE_branch_taken1 : in std_logic;
        ID_EXE_branch_taken2 : in std_logic;
        ID_EXE_MemoryRead1   : in std_logic;
        ID_EXE_MemoryRead2   : in std_logic;
        ID_EXE_Rdst1         : in std_logic_vector(3 downto 0);
        ID_EXE_Rdst2         : in std_logic_vector(3 downto 0);


        -- Buffer between Memory and write back
        MEM_WB_Rdst1 : in std_logic_vector(3 downto 0);
        MEM_WB_Rdst2 : in std_logic_vector(3 downto 0);
        MEM_WB_WB1   : in std_logic;
        MEM_WB_WB2   : in std_logic;
        
        -- flags
        flags        : in std_logic_vector(2 downto 0);

        -- stall_long
        ID_EXE_late_flush : in std_logic; -- stall_long_output_buffer.
        
        -- output
        clear_first        : out std_logic;
        clear_second       : out std_logic;
        RST_IR             : out std_logic;
        PC_selector        : out std_logic_vector(2 downto 0);
        new_address        : out std_logic_vector(3 downto 0);
        structural_hazard  : out std_logic;
        branch_taken1      : out std_logic;
        branch_taken2      : out std_logic;
        late_flush_ID_EXE  : out std_logic -- stall_long_input_buffer.
    );
end hazard_unit;

architecture a_hazard_unit of hazard_unit is

signal temp : std_logic;

-- SIGNALS RESET

-- first instruction
signal IF_ID_opCode1 : std_logic_vector(1 downto 0);
signal IF_ID_func1   : std_logic_vector(2 downto 0);
signal IF_ID_Rsrc1   : std_logic_vector(3 downto 0);
signal IF_ID_Rdst1   : std_logic_vector(3 downto 0);
        
-- second instruction
signal IF_ID_opCode2 : std_logic_vector(1 downto 0);
signal IF_ID_func2   : std_logic_vector(2 downto 0);
signal IF_ID_Rsrc2   : std_logic_vector(3 downto 0);
signal IF_ID_Rdst2   : std_logic_vector(3 downto 0);

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

-- JMP
signal jmp_first_in_packet_handle    : std_logic;
signal jmp_second_in_packet_handle   : std_logic;

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

-- DATA INNER HAZARD
signal data_inner_hazard              : std_logic;

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

-- Structural Hazard
signal SIG_structural_hazard   : std_logic;
signal structural_first        : std_logic;
signal structural_second       : std_logic;

-- Branch Taken Calcualtion
signal SIG_branch_taken1 : std_logic;
signal SIG_branch_taken2 : std_logic;


-- ALU Operation
signal first_alu_operation : std_logic;

begin


    -- LOGIC RESET
    IF_ID_opCode1 <= (others => '0') when (jmp_hazard = '1' or ID_EXE_late_flush = '1') else TEMP_IF_ID_opCode1;
    IF_ID_func1   <= (others => '0') when (jmp_hazard = '1' or ID_EXE_late_flush = '1') else TEMP_IF_ID_func1;
    IF_ID_Rsrc1   <= (others => '0') when (jmp_hazard = '1' or ID_EXE_late_flush = '1') else TEMP_IF_ID_Rsrc1;
    IF_ID_Rdst1   <= (others => '0') when (jmp_hazard = '1' or ID_EXE_late_flush = '1') else TEMP_IF_ID_Rdst1;
        
    -- second instruction
    IF_ID_opCode2 <= (others => '0') when (jmp_hazard = '1' or ID_EXE_late_flush = '1') else TEMP_IF_ID_opCode2; 
    IF_ID_func2   <= (others => '0') when (jmp_hazard = '1' or ID_EXE_late_flush = '1') else TEMP_IF_ID_func2; 
    IF_ID_Rsrc2   <= (others => '0') when (jmp_hazard = '1' or ID_EXE_late_flush = '1') else TEMP_IF_ID_Rsrc2; 
    IF_ID_Rdst2   <= (others => '0') when (jmp_hazard = '1' or ID_EXE_late_flush = '1') else TEMP_IF_ID_Rdst2; 



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
    
    -- Jmp
    jmp_first_in_packet_handle  <= '1' when (IF_ID_opCode1 = "11" and (IF_ID_func1 = "000" or IF_ID_func1 = "001" or IF_ID_func1 = "010" or IF_ID_func1 = "011")) else '0';
    jmp_second_in_packet_handle <= '1' when (IF_ID_opCode2 = "11" and (IF_ID_func2 = "000" or IF_ID_func2 = "001" or IF_ID_func2 = "010" or IF_ID_func2 = "011")) else '0';
    
    -- ALU Operation
	first_alu_operation <= '1' when ( IF_ID_opCode1 = "00" and ( IF_ID_func1 = "001" or IF_ID_func1 = "010" or IF_ID_func1 = "011" or IF_ID_func1 = "100" or IF_ID_func1 = "101" ) ) or ( IF_ID_opCode1 = "01" and ( IF_ID_func1 = "001" or IF_ID_func1 = "010" or IF_ID_func1 = "011" or IF_ID_func1 = "100") ) else '0';
	
    -- Memory HAZARD
    memory_hazard <= '1' when (memory_first_in_packet_handle = '1' and memory_second_in_packet_handle = '1') else '0';
    
    -- JMP INNER HAZARD
    jmp_inner_hazard <= '1' when (IF_ID_opCode2 = "11" and  (IF_ID_func2 = "000" or IF_ID_func2 = "001" or IF_ID_func2 = "010" or IF_ID_func2 = "011") and (jmp_first_in_packet_handle = '0' and first_alu_operation = '0') ) else '0';

    -- IN HAZARD
    in_hazard <= '1'  when (in_first_in_packet_handle = '1' and in_second_in_packet_handle = '1') else '0';
    
    -- OUT HAZARD
    out_hazard <= '1' when (out_first_in_packet_handle = '1' and out_second_in_packet_handle = '1') else '0';
   
    -- RAW HAZARD
    raw_hazard <= '1' when (IF_ID_Rsrc2 = IF_ID_Rdst1 and IF_ID_Rdst1 /= "0000") else '0'; 
    waw_hazard <= '1' when (IF_ID_Rdst2 = IF_ID_Rdst1 and IF_ID_Rdst1 /= "0000") else '0';

    -- DATA INNER HAZARD
    data_inner_hazard <= raw_hazard or waw_hazard or memory_hazard or in_hazard or out_hazard or jmp_inner_hazard or load_immediate_hazard;
    
    

    -- DATA OUTER HAZARD DETECTION

    ------ EXCEPTION MOV, LOAD, OUT -----------
    src1_depend_outer_dst1 <= '1' when IF_ID_Rsrc1 = ID_EXE_Rdst1 else '0';
    src2_depend_outer_dst1 <= '1' when IF_ID_Rsrc2 = ID_EXE_Rdst1 else '0';
    src1_depend_outer_dst2 <= '1' when IF_ID_Rsrc1 = ID_EXE_Rdst2 else '0';
    src2_depend_outer_dst2 <= '1' when IF_ID_Rsrc2 = ID_EXE_Rdst2 else '0';

    dst1_depend_outer_dst1 <= '1' when IF_ID_Rdst1 = ID_EXE_Rdst1 else '0';
    dst2_depend_outer_dst1 <= '1' when IF_ID_Rdst2 = ID_EXE_Rdst1 else '0';
    dst1_depend_outer_dst2 <= '1' when IF_ID_Rdst1 = ID_EXE_Rdst2 else '0';
    dst2_depend_outer_dst2 <= '1' when IF_ID_Rdst2 = ID_EXE_Rdst2 else '0';

    -- EXCEPTION MOV
    exception_mov_first   <= '1' when mov_first_in_packet_handle = '1' and src1_depend_outer_dst1 = '0' and src1_depend_outer_dst2 = '0' else '0';
    exception_mov_second  <= '1' when mov_first_in_packet_handle = '1' and src2_depend_outer_dst1 = '0' and src2_depend_outer_dst2 = '0' else '0';
    
    -- EXCEPTION LOAD
    exception_load_first  <= '1' when load_first_in_packet_handle  = '1' and src1_depend_outer_dst1 = '0' and src1_depend_outer_dst2 = '0' else '0';
    exception_load_second <= '1' when load_second_in_packet_handle = '1' and src2_depend_outer_dst1 = '0' and src2_depend_outer_dst2 = '0' else '0';
    
    -- EXCEPTION OUT
    exception_out_first   <= '1' when out_first_in_packet_handle  = '1' and src1_depend_outer_dst1 = '0' and src1_depend_outer_dst2 = '0' else '0';
    exception_out_second  <= '1' when out_second_in_packet_handle = '1' and src2_depend_outer_dst1 = '0' and src2_depend_outer_dst2 = '0' else '0';

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
    jmp_hazard <= '1' when ID_EXE_branch_taken1 = '1' or ID_EXE_branch_taken2 = '1' else '0';
    
    -- LOAD IMMEDIATE HAZARD
    load_immediate_hazard <= '1' when (IF_ID_opCode2 = "01" and (IF_ID_func2 = "101" or IF_ID_func2 = "110")) or (IF_ID_opCode2 = "10" and IF_ID_func2 = "010" ) else '0';

    control_hazard <= jmp_hazard or load_immediate_hazard;
    
    -- Structural Hazard
    structural_first  <= '1' when (IF_ID_Rdst1 = MEM_WB_Rdst1 and MEM_WB_WB1 = '1') or (IF_ID_Rdst1 = MEM_WB_Rdst2 and MEM_WB_WB2 = '1') else '0';
    structural_second <= '1' when (IF_ID_Rdst2 = MEM_WB_Rdst1 and MEM_WB_WB1 = '1') or (IF_ID_Rdst2 = MEM_WB_Rdst2 and MEM_WB_WB2 = '1') else '0'; 
    SIG_structural_hazard <= structural_first or structural_second;

    -- Branch Calculation
    SIG_branch_taken1 <= '1' when ( jmp_first_in_packet_handle  = '1' and ( (IF_ID_func1 = "000" and flags(0) = '1') or (IF_ID_func1 = "001" and flags(1) = '1') or (IF_ID_func1 = "010" and flags(2) = '1') or (IF_ID_func1 = "011")) ) else '0';
	SIG_branch_taken2 <= '1' when ( jmp_second_in_packet_handle = '1' and first_alu_operation = '0' and ( (IF_ID_func2 = "000" and flags(0) = '1') or (IF_ID_func2 = "001" and flags(1) = '1') or (IF_ID_func2 = "010" and flags(2) = '1') or (IF_ID_func2 = "011")) ) else '0';
	
    --------------------------------------------------------------------

    -- OUTPUTS
    clear_first  <= data_outer_hazard or jmp_hazard or ID_EXE_late_flush;
    clear_second <= data_inner_hazard or data_outer_hazard or load_immediate_hazard or SIG_branch_taken1 or jmp_hazard or ID_EXE_late_flush;
    -- RST_IR       <= jmp_hazard or ID_EXE_late_flush;
    PC_selector  <= "010" when SIG_branch_taken1 = '1' or SIG_branch_taken2 = '1' else
                    "001" when data_inner_hazard = '1' else
                    "100" when data_outer_hazard = '1' or SIG_structural_hazard = '1' else
                    "000";
    RST_IR <= '0';
    structural_hazard <= SIG_structural_hazard;
    branch_taken1 <= SIG_branch_taken1;
    branch_taken2 <= SIG_branch_taken2;

    late_flush_ID_EXE <= temp;
    temp <= data_inner_hazard  or SIG_structural_hazard or data_outer_hazard;
    -- comments
    -- data_inner_hazard, load_immediate_hazard does not need to flush anything. just clear_second.
    -- data_outer_hazard need flush signal (necessary).
    -- jmp_hazard need async reset.

    new_address <= ID_EXE_Rdst1; -- an input to entity that takes 4 bits ( register ) and returns its data.
    



   -- assumnption
    -- 010 => PC = R[new_address]
    -- 000 => PC = PC + 2
    -- 001 => PC = PC - 1
    -- 100 => PC = PC - 2
end architecture;