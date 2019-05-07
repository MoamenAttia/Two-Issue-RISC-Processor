LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY Memory_write_back_Buffer IS
GENERIC ( n : integer :=47);
PORT( Clk,Rst : IN std_logic;
	--------------------------------------
	instr_1_Rdst_in :in std_logic_vector (3 downto 0);
	instr_1_write_back_in :in std_logic;
	instr_1_mem_read_in :in std_logic;
	instr_1_stall_long_in :in std_logic;
	instr_1_result_in:in std_logic_vector (15 downto 0);

	--------------------------------------
	instr_2_Rdst_in :in std_logic_vector (3 downto 0);
	instr_2_write_back_in :in std_logic;
	instr_2_mem_read_in :in std_logic;
	instr_2_stall_long_in :in std_logic;
	instr_2_result_in :in std_logic_vector (15 downto 0);


	--------------------------------------
	instr_1_Rdst :out std_logic_vector (3 downto 0);
	instr_1_write_back :out std_logic;
	instr_1_mem_read : out std_logic;
	instr_1_stall_long :out std_logic;
	instr_1_result :out std_logic_vector (15 downto 0);

	--------------------------------------
	instr_2_Rdst :out std_logic_vector (3 downto 0);
	instr_2_write_back :out std_logic;
	instr_2_mem_read :out std_logic;
	instr_2_stall_long :out std_logic;
	instr_2_result :out std_logic_vector (15 downto 0);

	--------------------------------------
	En:in std_logic;
	
	-- MOAMEN
	ret_flush_in : in std_logic;
	ret_flush_out : out std_logic
	
	);
END Memory_write_back_Buffer;

ARCHITECTURE my_Memory_write_back_Buffer OF Memory_write_back_Buffer IS
signal 	d : std_logic_vector(n-1 DOWNTO 0);
signal 	q : std_logic_vector(n-1 DOWNTO 0);
BEGIN

n_dff:entity work.my_nDFF  generic map (47) port map (clk,  rst , d ,q ,EN);
----------------------------------------------------------------------------
d<= ret_flush_in & instr_1_result_in & instr_1_stall_long_in & instr_1_mem_read_in & instr_1_write_back_in & instr_1_Rdst_in
 & instr_2_result_in & instr_2_stall_long_in & instr_2_mem_read_in & instr_2_write_back_in & instr_2_Rdst_in;

	ret_flush_out <= q(46);
----------------------------------------------------------------------------
	instr_1_Rdst <= q(26 downto 23);
	instr_1_write_back <= q(27);
	instr_1_mem_read <= q(28);
	instr_1_stall_long <= q(29);
	instr_1_result <= q(45 downto 30);

	----------------------------------------
	instr_2_Rdst <= q(3 downto 0);
	instr_2_write_back <= q(4);
	instr_2_mem_read  <= q(5);
	instr_2_stall_long <= q(6);
	instr_2_result <= q(22 downto 7);

	----------------------------------------

END my_Memory_write_back_Buffer;