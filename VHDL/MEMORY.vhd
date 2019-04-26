LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY MEMORY IS
	PORT (instr_1_Rdst :in std_logic_vector (3 downto 0);
	instr_1_write_back :in std_logic;
	instr_1_stall_long :in std_logic;
	instr_1_mem_read :in std_logic;
	instr_1_mem_write :in std_logic;
	instr_1_alu_result :in std_logic_vector (15 downto 0);
	--------------------------------------
	instr_2_Rdst :in std_logic_vector (3 downto 0);
	instr_2_write_back :in std_logic;
	instr_2_stall_long :in std_logic;
	instr_2_mem_read :in std_logic;
	instr_2_mem_write :in std_logic;
	instr_2_alu_result :in std_logic_vector (15 downto 0)
	
	
	instr_1_Rdst_in :out std_logic_vector (3 downto 0);
	instr_1_write_back_in :out std_logic;
	instr_1_mem_read_in :out std_logic;
	instr_1_stall_long_in :out std_logic;
	instr_1_alu_result_in:out std_logic_vector (15 downto 0);
	instr_1_mem_result_in :out std_logic_vector (15 downto 0);
	--------------------------------------
	instr_2_Rdst_in :out std_logic_vector (3 downto 0);
	instr_2_write_back_in :out std_logic;
	instr_2_mem_read_in :out std_logic;
	instr_2_stall_long_in :out std_logic;
	instr_2_alu_result_in :out std_logic_vector (15 downto 0);
	instr_2_mem_result_in :out std_logic_vector (15 downto 0);

	
	);
END FETCH;

ARCHITECTURE a_MEMORY OF MEMORY IS
    BEGIN
    
--also connected to reg file with data
---data ram here 
END a_MEMORY;