LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY Decode_Execute_Buffer IS
GENERIC ( n : integer := 107);
PORT( Clk,Rst : IN std_logic;

	-- MOAMEN MAGIC BIT
	late_stall_long_in  : in std_logic;
	late_stall_long_out : out std_logic;
	--------------------------------------------- 
	i1_Rdst_in: in std_logic_vector(3 DOWNTO 0);
	i1_Rsrc_in: in std_logic_vector(3 DOWNTO 0);
	i1_branch_taken_in : in std_logic;
	i1_load_use_in : in std_logic;
	i1_Rsrc_data_in: in std_logic_vector(15 DOWNTO 0);
	i1_Rdst_data_in: in std_logic_vector(15 DOWNTO 0);
	i1_stall_long_in :in std_logic;
	i1_WB_in :in std_logic;
	i1_MR_in:in std_logic;
	i1_MW_in :in std_logic;
	i1_alu_op_in :in std_logic_vector (4 downto 0);
	------------------------------------------------
	i2_Rdst_in: in std_logic_vector(3 DOWNTO 0);
	i2_Rsrc_in: in std_logic_vector(3 DOWNTO 0);
	i2_branch_taken_in : in std_logic;
	i2_load_use_in : in std_logic;
	i2_Rsrc_data_in: in std_logic_vector(15 DOWNTO 0);
	i2_Rdst_data_in:in std_logic_vector(15 DOWNTO 0);
	i2_stall_long_in :in std_logic;
	i2_WB_in :in std_logic;
	i2_MR_in:in std_logic;
	i2_MW_in :in std_logic;
	i2_alu_op_in : in std_logic_vector (4 downto 0);

	------------------------------------------------
	i1_Rdst: OUT std_logic_vector(3 DOWNTO 0);
	i1_Rsrc: OUT std_logic_vector(3 DOWNTO 0);
	i1_branch_taken : OUT std_logic;
	i1_load_use : OUT std_logic;
	i1_Rsrc_data: OUT std_logic_vector(15 DOWNTO 0);
	i1_Rdst_data: OUT std_logic_vector(15 DOWNTO 0);
	i1_stall_long :out std_logic;
	i1_WB :out std_logic;
	i1_MR :out std_logic;
	i1_MW :out std_logic;
	i1_alu_op :out std_logic_vector (4 downto 0);

	------------------------------------------------
	i2_Rdst: OUT std_logic_vector(3 DOWNTO 0);
	i2_Rsrc: OUT std_logic_vector(3 DOWNTO 0);
	i2_branch_taken : OUT std_logic;
	i2_load_use : OUT std_logic;
	i2_Rsrc_data: OUT std_logic_vector(15 DOWNTO 0);
	i2_Rdst_data: OUT std_logic_vector(15 DOWNTO 0);
	i2_stall_long :out std_logic;
	i2_WB :out std_logic;
	i2_MR :out std_logic;
	i2_MW :out std_logic;
	i2_alu_op :out std_logic_vector (4 downto 0);

	------------------------------------------------
	En:in std_logic);
END Decode_Execute_Buffer;

ARCHITECTURE my_Decode_Execute_Buffer OF Decode_Execute_Buffer IS
signal  d :std_logic_vector(n-1 DOWNTO 0);
signal 	q :std_logic_vector(n-1 DOWNTO 0);
BEGIN
-- 51 bit i1 -- 51 bit i2
-- 0~3 : Rdst -- 4~7 : Rsrc -- 8 : Branch_taked -- 9 : load_use -- 10~25 : Rsrc_data -- 26~41 : Rdst_Data -- 42 : stall_long_to be changed 
-- 43 : WB -- 44 : MR --45 : MW -- 46~50 : alu_op 
n_dff:entity work.my_nDFF  generic map (103) port map (clk,  rst , d ,q ,EN);
-------------------------------------------------------
d <= late_stall_long_in & i1_alu_op_in & i1_MW_in & i1_MR_in & i1_WB_in & i1_stall_long_in &
i1_Rdst_data_in & i1_Rsrc_data_in & i1_load_use_in & i1_branch_taken_in & i1_Rsrc_in & i1_Rdst_in &
i2_alu_op_in & i2_MW_in & i2_MR_in & i2_WB_in & i2_stall_long_in & 
i2_Rdst_data_in & i2_Rsrc_data_in & i2_load_use_in & i2_branch_taken_in & i2_Rsrc_in & i2_Rdst_in;


	late_stall_long_out <= q(102);


-------------------------------------------------------
	i1_Rdst <= q(54 downto 51);
	i1_Rsrc  <= q(58 downto 55);
	i1_branch_taken <= q(59);
	i1_load_use <= q(60);
	i1_Rsrc_data<= q(76 downto 61);
	i1_Rdst_data<= q(92 downto 77);
	i1_stall_long <= q(93);
	i1_WB <= q(94);
	i1_MR <= q(95);
	i1_MW <= q(96);
	i1_alu_op <= q(101 downto 97);
-------------------------------------------------------
	i2_Rdst <= q(3 downto 0);
	i2_Rsrc <= q(7 downto 4);
	i2_branch_taken <= q(8);
	i2_load_use <= q(9);
	i2_Rsrc_data <= q(25 downto 10);
	i2_Rdst_data <= q(41 downto 26);
	i2_stall_long <= q(42);
	i2_WB <= q(43);
	i2_MR <= q(44);
	i2_MW <= q(45);
	i2_alu_op <= q(50 downto 46);
---------------------------------------
END my_Decode_Execute_Buffer;