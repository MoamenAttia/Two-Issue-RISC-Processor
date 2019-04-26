LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY IR_Buffer IS
GENERIC ( n : integer := 32);
PORT( Clk,Rst : IN std_logic;
	d : IN std_logic_vector(n-1 DOWNTO 0);
	--------------------------------------------
	instr_1_opcode : OUT std_logic_vector(1 DOWNTO 0);
	instr_1_function: OUT std_logic_vector(2 DOWNTO 0);
	instr_1_Rsrc : OUT std_logic_vector(3 DOWNTO 0);
	instr_1_Rdst : OUT std_logic_vector(3 DOWNTO 0);
	--------------------------------------------
	instr_2_opcode : OUT std_logic_vector(1 DOWNTO 0);
	instr_2_function: OUT std_logic_vector(2 DOWNTO 0);
	instr_2_Rsrc : OUT std_logic_vector(3 DOWNTO 0);
	instr_2_Rdst : OUT std_logic_vector(3 DOWNTO 0);
	--------------------------------------------
	En:in std_logic);
END IR_Buffer;

ARCHITECTURE my_IR_Buffer OF IR_Buffer IS
signal q : std_logic_vector(n-1 downto 0);
BEGIN
-- 16 bit IR_1 -- 16 bit IR_2
-- 0~1 : opcode -- 2~4 : func -- 5~8: Rsrc -- 9~12 Rdst
n_dff:entity work.my_nDFF  generic map (32) port map (clk,  rst , d ,q ,EN);
-------------------------------------------------
	instr_1_opcode <= q(17 downto 16);
	instr_1_function <= q(20 downto 18);
	instr_1_Rsrc <= q(24 downto 21);
	instr_1_Rdst <= q(28 downto 25);
-------------------------------------------------
	instr_2_opcode <= q(1 downto 0);
	instr_2_function <= q(4 downto 2);
	instr_2_Rsrc <= q(8 downto 5);
	instr_2_Rdst <= q(12 downto 9);
-------------------------------------------------

END my_IR_Buffer;