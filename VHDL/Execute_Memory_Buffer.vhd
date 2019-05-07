LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY Execute_Memory_Buffer IS
GENERIC ( n : integer := 49);
PORT( Clk,Rst : IN std_logic;
	--------------------------------------
	instr_1_Rdst_in :in std_logic_vector (3 downto 0);
	instr_1_write_back_in :in std_logic;
	instr_1_stall_long_in :in std_logic;
	instr_1_mem_read_in :in std_logic;
	instr_1_mem_write_in :in std_logic;
	instr_1_alu_result_in :in std_logic_vector (15 downto 0);
	--------------------------------------
	instr_2_Rdst_in :in std_logic_vector (3 downto 0);
	instr_2_write_back_in :in std_logic;
	instr_2_stall_long_in :in std_logic;
	instr_2_mem_read_in :in std_logic;
	instr_2_mem_write_in :in std_logic;
	instr_2_alu_result_in :in std_logic_vector (15 downto 0);

	--------------------------------------
	instr_1_Rdst :out std_logic_vector (3 downto 0);
	instr_1_write_back :out std_logic;
	instr_1_stall_long :out std_logic;
	instr_1_mem_read :out std_logic;
	instr_1_mem_write :out std_logic;
	instr_1_alu_result :out std_logic_vector (15 downto 0);
	--------------------------------------
	instr_2_Rdst :out std_logic_vector (3 downto 0);
	instr_2_write_back :out std_logic;
	instr_2_stall_long :out std_logic;
	instr_2_mem_read :out std_logic;
	instr_2_mem_write :out std_logic;
	instr_2_alu_result :out std_logic_vector (15 downto 0);
	--------------------------------------
	En:in std_logic;
	
	-- MOAMEN
	ret_flush_in : in std_logic;
	ret_flush_out : out std_logic
	
	);
END Execute_Memory_Buffer;

ARCHITECTURE my_Execute_Memory_Buffer OF Execute_Memory_Buffer IS
signal  d : std_logic_vector(n-1 DOWNTO 0);
signal 	q : std_logic_vector(n-1 DOWNTO 0);

BEGIN
-- 0~3 : Rdst -- 4 : write_back -- 5 : stall_long to be changed -- 6 : mem_read -- 7 : mem_write 
-- 8~23 : alu_result 

n_dff:entity work.my_nDFF  generic map (49) port map (clk,  rst , d ,q ,EN);
------------------------------------------------------------------------------
d<= ret_flush_in & instr_1_alu_result_in & instr_1_mem_write_in & instr_1_mem_read_in & instr_1_stall_long_in & instr_1_write_back_in & instr_1_Rdst_in &
instr_2_alu_result_in & instr_2_mem_write_in & instr_2_mem_read_in & instr_2_stall_long_in & instr_2_write_back_in &  instr_2_Rdst_in ;


	ret_flush_out <= q(48);

---------------------------------------------
	instr_1_Rdst <= q(27 downto 24);
	instr_1_write_back <= q(28);
	instr_1_stall_long <= q(29);
	instr_1_mem_read <= q(30);
	instr_1_mem_write <= q(31);
	instr_1_alu_result <= q(47 downto 32);
	----------------------------------------
	instr_2_Rdst <= q(3 downto 0);
	instr_2_write_back <= q(4);
	instr_2_stall_long <= q(5);
	instr_2_mem_read  <= q(6);
	instr_2_mem_write <= q(7);
	instr_2_alu_result <= q(23 downto 8);
	----------------------------------------

END my_Execute_Memory_Buffer;