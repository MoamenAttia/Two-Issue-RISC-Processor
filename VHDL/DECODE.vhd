LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY DECODE IS
	PORT (
	clk ,rst :in std_logic;
        --this data is directly from ir buffer 
    instr_1_opcode : in std_logic_vector(1 DOWNTO 0);
	instr_1_function: in std_logic_vector(2 DOWNTO 0);
	instr_1_Rsrc : in std_logic_vector(3 DOWNTO 0);
	instr_1_Rdst : in std_logic_vector(3 DOWNTO 0);
	instr_1_write_back_data : in std_logic_vector(15 downto 0);
	instr_1_write_back : in std_logic_vector(3 downto 0);	
	--------------------------------------------
	instr_2_opcode : in std_logic_vector(1 DOWNTO 0);
	instr_2_function: in std_logic_vector(2 DOWNTO 0);
	instr_2_Rsrc : in std_logic_vector(3 DOWNTO 0);
    instr_2_Rdst : in std_logic_vector(3 DOWNTO 0);
	instr_2_write_back_data : in std_logic_vector(15 downto 0);
	instr_2_write_back : in std_logic_vector(3 downto 0);
    --this data is output of entitys below 
    -- connected to the decode execute buffer 
    instr_1_Rdst_in: out std_logic_vector(3 DOWNTO 0);
	instr_1_Rsrc_in: out std_logic_vector(3 DOWNTO 0);
	instr_1_branch_taken_in : out std_logic;
	instr_1_load_use_in : out std_logic;
	instr_1_Rsrc_data_in: out std_logic_vector(15 DOWNTO 0);
	instr_1_Rdst_data_in: out std_logic_vector(15 DOWNTO 0);
	instr_1_stall_long_in :out std_logic;
	instr_1_write_back_in :out std_logic;
	instr_1_mem_read_in:out std_logic;
	instr_1_mem_write_in :out std_logic;
	instr_1_alu_operation_in :out std_logic_vector (4 downto 0);
	------------------------------------------------
	instr_2_Rdst_in: out std_logic_vector(3 DOWNTO 0);
	instr_2_Rsrc_in: out std_logic_vector(3 DOWNTO 0);
	instr_2_branch_taken_in : out std_logic;
	instr_2_load_use_in : out std_logic;
	instr_2_Rsrc_data_in: out std_logic_vector(15 DOWNTO 0);
	instr_2_Rdst_data_in:out std_logic_vector(15 DOWNTO 0);
	instr_2_stall_long_in :out std_logic;
	instr_2_write_back_in :out std_logic;
	instr_2_mem_read_in:out std_logic;
	instr_2_mem_write_in :out std_logic;
	instr_2_alu_operation_in : out std_logic_vector(4 downto 0)

    );
END DECODE;

ARCHITECTURE a_DECODE OF DECODE IS


--  1.entity for hazard detection
--  2.entity for branch detection and calculation address 
--- 3.entity for reg file (done)
--  4.entity for control unit (done)
BEGIN
control1_unit:entity work.Control_Unit  generic map (32) port map (instr_1_opcode, instr_1_function,instr_1_Rsrc,instr_1_Rdst);		
control2_unit:entity work.Control_Unit  generic map (32) port map (instr_2_opcode, instr_2_function,instr_2_Rsrc,instr_2_Rdst);		
Register_file:entity work.Register_file  generic map (16) port map (clk , rst , instr_1_Rsrc , instr_1_Rdst , instr_1_Rsrc_data_in , instr_1_Rdst_data_in , instr_1_write_back_data ,instr_1_write_back,
instr_2_Rsrc , instr_2_Rdst , instr_2_Rsrc_data_in , instr_2_Rdst_data_in, instr_2_write_back_data ,instr_2_write_back);

END architecture;