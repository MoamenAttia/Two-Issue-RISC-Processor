LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY Memory_write_back_Buffer IS
GENERIC ( n : integer := 78);
PORT( Clk,Rst : IN std_logic;
	--------------------------------------
	instr_1_Rdst_in :in std_logic_vector (3 downto 0);
	instr_1_write_back_in :in std_logic;
	instr_1_mem_read_in :in std_logic;
	instr_1_stall_long_in :in std_logic;
	instr_1_alu_result_in:in std_logic_vector (15 downto 0);
	instr_1_mem_result_in :in std_logic_vector (15 downto 0);
	--------------------------------------
	instr_2_Rdst_in :in std_logic_vector (3 downto 0);
	instr_2_write_back_in :in std_logic;
	instr_2_mem_read_in :in std_logic;
	instr_2_stall_long_in :in std_logic;
	instr_2_alu_result_in :in std_logic_vector (15 downto 0);
	instr_2_mem_result_in :in std_logic_vector (15 downto 0);

	--------------------------------------
	instr_1_Rdst :out std_logic_vector (3 downto 0);
	instr_1_write_back :out std_logic;
	instr_1_mem_read :out std_logic;
	instr_1_stall_long :out std_logic;
	instr_1_alu_result :out std_logic_vector (15 downto 0);
	instr_1_mem_result :out std_logic_vector (15 downto 0);
	--------------------------------------
	instr_2_Rdst :out std_logic_vector (3 downto 0);
	instr_2_write_back :out std_logic;
	instr_2_mem_read :out std_logic;
	instr_2_stall_long :out std_logic;
	instr_2_alu_result :out std_logic_vector (15 downto 0);
	instr_2_mem_result :out std_logic_vector (15 downto 0);
	--------------------------------------
	En:in std_logic);
END Memory_write_back_Buffer;

ARCHITECTURE my_Memory_write_back_Buffer OF Memory_write_back_Buffer IS
signal 	d : std_logic_vector(n-1 DOWNTO 0);
signal 	q : std_logic_vector(n-1 DOWNTO 0);
BEGIN

n_dff:entity work.my_nDFF  generic map (78) port map (clk,  rst , d ,q ,EN);
----------------------------------------------------------------------------
d<=instr_1_mem_result_in & instr_1_alu_result_in & instr_1_stall_long_in & instr_1_mem_read_in & instr_1_write_back_in & instr_1_Rdst_in &
instr_2_mem_result_in & instr_2_alu_result_in & instr_2_stall_long_in & instr_2_mem_read_in & instr_2_write_back_in & instr_2_Rdst_in;
----------------------------------------------------------------------------
	instr_1_Rdst <= q(42 downto 39);
	instr_1_write_back <= q(43);
	instr_1_mem_read <= q(44);
	instr_1_stall_long <= q(45);
	instr_1_alu_result <= q(61 downto 46);
	instr_1_mem_result <= q(77 downto 62);
	----------------------------------------
	instr_2_Rdst <= q(3 downto 0);
	instr_2_write_back <= q(4);
	instr_2_mem_read  <= q(5);
	instr_2_stall_long <= q(6);
	instr_2_alu_result <= q(22 downto 7);
	instr_2_mem_result <= q(38 downto 23);
	----------------------------------------

END my_Memory_write_back_Buffer;