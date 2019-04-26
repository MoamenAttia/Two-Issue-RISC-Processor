LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY Decode_Execute_Buffer IS
GENERIC ( n : integer := 102);
PORT( Clk,Rst : IN std_logic;
	---------------------------------------------
	instr_1_Rdst_in: in std_logic_vector(3 DOWNTO 0);
	instr_1_Rsrc_in: in std_logic_vector(3 DOWNTO 0);
	instr_1_branch_taken_in : in std_logic;
	instr_1_load_use_in : in std_logic;
	instr_1_Rsrc_data_in: in std_logic_vector(15 DOWNTO 0);
	instr_1_Rdst_data_in: in std_logic_vector(15 DOWNTO 0);
	instr_1_stall_long_in :in std_logic;
	instr_1_write_back_in :in std_logic;
	instr_1_mem_read_in:in std_logic;
	instr_1_mem_write_in :in std_logic;
	instr_1_alu_operation_in :in std_logic_vector (4 downto 0);
	------------------------------------------------
	instr_2_Rdst_in: in std_logic_vector(3 DOWNTO 0);
	instr_2_Rsrc_in: in std_logic_vector(3 DOWNTO 0);
	instr_2_branch_taken_in : in std_logic;
	instr_2_load_use_in : in std_logic;
	instr_2_Rsrc_data_in: in std_logic_vector(15 DOWNTO 0);
	instr_2_Rdst_data_in:in std_logic_vector(15 DOWNTO 0);
	instr_2_stall_long_in :in std_logic;
	instr_2_write_back_in :in std_logic;
	instr_2_mem_read_in:in std_logic;
	instr_2_mem_write_in :in std_logic;
	instr_2_alu_operation_in : in std_logic_vector (4 downto 0);

	------------------------------------------------
	instr_1_Rdst: OUT std_logic_vector(3 DOWNTO 0);
	instr_1_Rsrc: OUT std_logic_vector(3 DOWNTO 0);
	instr_1_branch_taken : OUT std_logic;
	instr_1_load_use : OUT std_logic;
	instr_1_Rsrc_data: OUT std_logic_vector(15 DOWNTO 0);
	instr_1_Rdst_data: OUT std_logic_vector(15 DOWNTO 0);
	instr_1_stall_long :out std_logic;
	instr_1_write_back :out std_logic;
	instr_1_mem_read :out std_logic;
	instr_1_mem_write :out std_logic;
	instr_1_alu_operation :out std_logic_vector (4 downto 0);
	------------------------------------------------
	instr_2_Rdst: OUT std_logic_vector(3 DOWNTO 0);
	instr_2_Rsrc: OUT std_logic_vector(3 DOWNTO 0);
	instr_2_branch_taken : OUT std_logic;
	instr_2_load_use : OUT std_logic;
	instr_2_Rsrc_data: OUT std_logic_vector(15 DOWNTO 0);
	instr_2_Rdst_data: OUT std_logic_vector(15 DOWNTO 0);
	instr_2_stall_long :out std_logic;
	instr_2_write_back :out std_logic;
	instr_2_mem_read :out std_logic;
	instr_2_mem_write :out std_logic;
	instr_2_alu_operation :out std_logic_vector (4 downto 0);
	------------------------------------------------
	En:in std_logic);
END Decode_Execute_Buffer;

ARCHITECTURE my_Decode_Execute_Buffer OF Decode_Execute_Buffer IS
signal  d :std_logic_vector(n-1 DOWNTO 0);
signal 	q :std_logic_vector(n-1 DOWNTO 0);
BEGIN
-- 51 bit instr_1 -- 51 bit instr_2
-- 0~3 : Rdst -- 4~7 : Rsrc -- 8 : Branch_taked -- 9 : load_use -- 10~25 : Rsrc_data -- 26~41 : Rdst_Data -- 42 : stall_long_to be changed 
-- 43 : write_back -- 44 : mem_read --45 : mem_write -- 46~50 : alu_operation 
n_dff:entity work.my_nDFF  generic map (102) port map (clk,  rst , d ,q ,EN);
-------------------------------------------------------
d<= instr_1_alu_operation_in & instr_1_mem_write_in & instr_1_mem_read_in & instr_1_write_back_in & instr_1_stall_long_in &
instr_1_Rdst_data_in & instr_1_Rsrc_data_in & instr_1_load_use_in & instr_1_branch_taken_in & instr_1_Rsrc_in & instr_1_Rdst_in &

instr_2_alu_operation_in & instr_2_mem_write_in & instr_2_mem_read_in & instr_2_write_back_in & instr_2_stall_long_in & 
instr_2_Rdst_data_in & instr_2_Rsrc_data_in & instr_2_load_use_in & instr_2_branch_taken_in & instr_2_Rsrc_in & instr_2_Rdst_in;


-------------------------------------------------------
	instr_1_Rdst <= q(54 downto 51);
	instr_1_Rsrc  <= q(58 downto 55);
	instr_1_branch_taken <= q(59);
	instr_1_load_use <= q(60);
	instr_1_Rsrc_data<= q(76 downto 61);
	instr_1_Rdst_data<= q(92 downto 77);
	instr_1_stall_long <= q(93);
	instr_1_write_back <= q(94);
	instr_1_mem_read <= q(95);
	instr_1_mem_write <= q(96);
	instr_1_alu_operation <= q(101 downto 97);
-------------------------------------------------------
	instr_2_Rdst <= q(3 downto 0);
	instr_2_Rsrc <= q(7 downto 4);
	instr_2_branch_taken <= q(8);
	instr_2_load_use <= q(9);
	instr_2_Rsrc_data <= q(25 downto 10);
	instr_2_Rdst_data <= q(41 downto 26);
	instr_2_stall_long <= q(42);
	instr_2_write_back <= q(43);
	instr_2_mem_read <= q(44);
	instr_2_mem_write <= q(45);
	instr_2_alu_operation <= q(50 downto 46);

END my_Decode_Execute_Buffer;