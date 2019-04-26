LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY EXECUTE IS
	PORT (   --these signals from the decode execute buffer
	instr_1_Rdst: in std_logic_vector(3 DOWNTO 0);
	instr_1_Rsrc: in std_logic_vector(3 DOWNTO 0);
	instr_1_branch_taken : in std_logic;
	instr_1_load_use : in std_logic;
	instr_1_Rsrc_data: in std_logic_vector(15 DOWNTO 0);
	instr_1_Rdst_data: in std_logic_vector(15 DOWNTO 0);
	instr_1_stall_long :in std_logic;
	instr_1_write_back :in std_logic;
	instr_1_mem_read :in std_logic;
	instr_1_mem_write :in std_logic;
	instr_1_alu_operation :in std_logic_vector (4 downto 0);
	------------------------------------------------
	instr_2_Rdst: in std_logic_vector(3 DOWNTO 0);
	instr_2_Rsrc: in std_logic_vector(3 DOWNTO 0);
	instr_2_branch_taken : in std_logic;
	instr_2_load_use : in std_logic;
	instr_2_Rsrc_data: in std_logic_vector(15 DOWNTO 0);
	instr_2_Rdst_data: in std_logic_vector(15 DOWNTO 0);
	instr_2_stall_long :in std_logic;
	instr_2_write_back :in std_logic;
	instr_2_mem_read :in std_logic;
	instr_2_mem_write :in std_logic;
	instr_2_alu_operation :in std_logic_vector (4 downto 0)

	---these signals are connected with memory execute buffers
	instr_1_Rdst_in :out std_logic_vector (3 downto 0);
	instr_1_write_back_in :out std_logic;
	instr_1_stall_long_in :out std_logic;
	instr_1_mem_read_in :out std_logic;
	instr_1_mem_write_in :out std_logic;
	instr_1_alu_result_in :out std_logic_vector (15 downto 0);
	--------------------------------------
	instr_2_Rdst_in :out std_logic_vector (3 downto 0);
	instr_2_write_back_in :out std_logic;
	instr_2_stall_long_in :out std_logic;
	instr_2_mem_read_in :out std_logic;
	instr_2_mem_write_in :out std_logic;
	instr_2_alu_result_in :out std_logic_vector (15 downto 0);
	);
END FETCH;

ARCHITECTURE a_EXECUTE OF EXECUTE IS
    BEGIN
    

   ---- 2 alus
   ---- forwarding unit 
   ---- muxs
		
END a_EXECUTE;