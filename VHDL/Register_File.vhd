
LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY Register_File IS
GENERIC ( n : integer := 16);
PORT( Clk,Rst : IN std_logic;
-----------------------------------------------
	instr_1_Rsrc : in std_logic_vector(3 downto 0);
	instr_1_Rdst : in std_logic_vector(3 downto 0);
	instr_1_Rsrc_data_out : out std_logic_vector(15 downto 0);
	instr_1_Rdst_data_out : out std_logic_vector(15 downto 0);

	instr_1_Rdst_data_in : in std_logic_vector(15 downto 0);
	instr_1_Rdst_write_back : in std_logic_vector(3 downto 0);
-----------------------------------------------
	instr_2_Rsrc : in std_logic_vector(3 downto 0);
	instr_2_Rdst : in std_logic_vector(3 downto 0);
	instr_2_Rsrc_data_out : out std_logic_vector(15 downto 0);
	instr_2_Rdst_data_out: out std_logic_vector(15 downto 0);

	instr_2_Rdst_data_in : in std_logic_vector(15 downto 0);
	instr_2_Rdst_write_back : in std_logic_vector(3 downto 0)
------------------------------------------------
);
END Register_File;

ARCHITECTURE my_Register_File OF Register_File IS
------------------------------------------------- En Signals
signal R0_En :std_logic;
signal R1_En :std_logic;
signal R2_En :std_logic;
signal R3_En :std_logic;
signal R4_En :std_logic;
signal R5_En :std_logic;
signal R6_En :std_logic;
signal R7_En :std_logic;
--signal SP_En :std_logic;
--signal PC_En :std_logic;
--signal flag_En :std_logic;
-------------------------------------------------- data in
signal R0_data_in :std_logic_vector(15 downto 0);
signal R1_data_in :std_logic_vector(15 downto 0);
signal R2_data_in :std_logic_vector(15 downto 0);
signal R3_data_in :std_logic_vector(15 downto 0);
signal R4_data_in :std_logic_vector(15 downto 0);
signal R5_data_in :std_logic_vector(15 downto 0);
signal R6_data_in :std_logic_vector(15 downto 0);
signal R7_data_in :std_logic_vector(15 downto 0);
--signal SP_data_in :std_logic_vector(31 downto 0);
--signal PC_data_in :std_logic_vector(31 downto 0);
--signal flag_data_in :std_logic_vector(15 downto 0);
--------------------------------------------------
-------------------------------------------------- data out
signal R0_data_out :std_logic_vector(15 downto 0);
signal R1_data_out :std_logic_vector(15 downto 0);
signal R2_data_out :std_logic_vector(15 downto 0);
signal R3_data_out :std_logic_vector(15 downto 0);
signal R4_data_out :std_logic_vector(15 downto 0);
signal R5_data_out :std_logic_vector(15 downto 0);
signal R6_data_out :std_logic_vector(15 downto 0);
signal R7_data_out :std_logic_vector(15 downto 0);
--signal SP_data_out :std_logic_vector(31 downto 0);
--signal PC_data_out :std_logic_vector(31 downto 0);
--signal flag_data_out :std_logic_vector(15 downto 0);
--------------------------------------------------
BEGIN
 
R0:entity work.my_nDFF  generic map (16) port map (clk,  rst , R0_data_in ,R0_data_out ,R0_EN);
R1:entity work.my_nDFF  generic map (16) port map (clk,  rst , R1_data_in ,R1_data_out ,R1_EN);
R2:entity work.my_nDFF  generic map (16) port map (clk,  rst , R2_data_in ,R2_data_out ,R2_EN);
R3:entity work.my_nDFF  generic map (16) port map (clk,  rst , R3_data_in ,R3_data_out ,R3_EN);
R4:entity work.my_nDFF  generic map (16) port map (clk,  rst , R4_data_in ,R4_data_out ,R4_EN);
R5:entity work.my_nDFF  generic map (16) port map (clk,  rst , R5_data_in ,R5_data_out ,R5_EN);
R6:entity work.my_nDFF  generic map (16) port map (clk,  rst , R6_data_in ,R6_data_out ,R6_EN);
R7:entity work.my_nDFF  generic map (16) port map (clk,  rst , R7_data_in ,R7_data_out ,R7_EN);
--sp:entity work.my_nDFF  generic map (32) port map (clk,  rst , SP_data_in ,SP_data_out ,SP_EN);
--pc:entity work.my_nDFF  generic map (32) port map (clk,  rst , PC_data_in ,PC_data_out ,PC_EN);
--flag:entity work.my_nDFF  generic map (16) port map (clk,  rst , flag_data_in ,flag_data_out ,Flag_EN);
-------------------------------------------------------
------------------------------------------------------- 
process(clk ,rst, instr_1_Rdst_write_back,instr_2_Rdst_write_back)
begin
--------------------------------------------------------- instr 1 write back
if (instr_1_Rdst_write_back = "0001") then 
	R0_data_in <= instr_1_Rdst_data_in;
	R0_En <= '1';
elsif (instr_1_Rdst_write_back = "0010") then 
	R1_data_in <= instr_1_Rdst_data_in;
	R1_En <= '1';
elsif (instr_1_Rdst_write_back = "0011") then 
	R2_data_in <= instr_1_Rdst_data_in;
	R2_En <= '1';
elsif (instr_1_Rdst_write_back = "0100") then 
	R3_data_in <= instr_1_Rdst_data_in;
	R3_En <= '1';
elsif (instr_1_Rdst_write_back = "0101") then 
	R4_data_in <= instr_1_Rdst_data_in;
	R4_En <= '1';
elsif (instr_1_Rdst_write_back = "0110") then 
	R5_data_in <= instr_1_Rdst_data_in;
	R5_En <= '1';
elsif (instr_1_Rdst_write_back = "0111") then 
	R6_data_in <= instr_1_Rdst_data_in;
	R6_En <= '1';
elsif (instr_1_Rdst_write_back = "1000") then 
	R7_data_in <= instr_1_Rdst_data_in;
	R7_En <= '1';
--elsif (instr_1_Rdst_write_back = "1001") then 
--	SP_data_in <= instr_1_Rdst_data_in;
--	SP_En <= '1';
--elsif (instr_1_Rdst_write_back = "1010") then 
--	PC_data_in <= instr_1_Rdst_data_in;
--	PC_En <= '1';
--elsif (instr_1_Rdst_write_back = "1011") then 
--	flag_data_in <= instr_1_Rdst_data_in;
--	flag_En <= '1';
end if;
-------------------------------------------------------- instr 2 write back 
if (instr_2_Rdst_write_back = "0001") then 
	R0_data_in <= instr_2_Rdst_data_in;
	R0_En <= '1';
elsif (instr_2_Rdst_write_back = "0010") then 
	R1_data_in <= instr_2_Rdst_data_in;
	R1_En <= '1';
elsif (instr_2_Rdst_write_back = "0011") then 
	R2_data_in <= instr_2_Rdst_data_in;
	R2_En <= '1';
elsif (instr_2_Rdst_write_back = "0100") then 
	R3_data_in <= instr_2_Rdst_data_in;
	R3_En <= '1';
elsif (instr_2_Rdst_write_back = "0101") then 
	R4_data_in <= instr_2_Rdst_data_in;
	R4_En <= '1';
elsif (instr_2_Rdst_write_back = "0110") then 
	R5_data_in <= instr_2_Rdst_data_in;
	R5_En <= '1';
elsif (instr_2_Rdst_write_back = "0111") then 
	R6_data_in <= instr_2_Rdst_data_in;
	R6_En <= '1';
elsif (instr_2_Rdst_write_back = "1000") then 
	R7_data_in <= instr_2_Rdst_data_in;
	R7_En <= '1';
--elsif (instr_2_Rdst_write_back = "1001") then 
--	SP_data_in <= instr_2_Rdst_data_in;
--	SP_En <= '1';
--elsif (instr_2_Rdst_write_back = "1010") then 
--	PC_data_in <= instr_2_Rdst_data_in;
--	PC_En <= '1';
--elsif (instr_2_Rdst_write_back = "1011") then 
--	flag_data_in <= instr_2_Rdst_data_in;
--	flag_En <= '1';
end if;
	

-------------------------------------------------------- instr 1 Rsrc data out
if (instr_1_Rsrc = "0001") then
	instr_1_Rsrc_data_out <= R0_data_out;
elsif (instr_1_Rsrc = "0010") then
	instr_1_Rsrc_data_out <= R1_data_out;
elsif (instr_1_Rsrc = "0011") then
	instr_1_Rsrc_data_out <= R2_data_out;
elsif (instr_1_Rsrc = "0100") then
	instr_1_Rsrc_data_out <= R3_data_out;
elsif (instr_1_Rsrc = "0101") then
	instr_1_Rsrc_data_out <= R4_data_out;
elsif (instr_1_Rsrc = "0110") then
	instr_1_Rsrc_data_out <= R5_data_out;
elsif (instr_1_Rsrc = "0111") then
	instr_1_Rsrc_data_out <= R6_data_out;
elsif (instr_1_Rsrc = "1000") then
	instr_1_Rsrc_data_out <= R7_data_out;
--elsif (instr_1_Rsrc = "1001") then
--	instr_1_Rsrc_data_out <= SP_data_out;
--elsif (instr_1_Rsrc = "1010") then
--	instr_1_Rsrc_data_out <= PC_data_out;
--elsif (instr_1_Rsrc = "1011") then
--	instr_1_Rsrc_data_out <= flag_data_out;
end if;

-------------------------------------------------------- instr 1 Rdst data out
if (instr_1_Rdst = "0001") then
	instr_1_Rdst_data_out <= R0_data_out;

elsif (instr_1_Rdst = "0010") then
	instr_1_Rdst_data_out <= R1_data_out;

elsif (instr_1_Rdst = "0011") then
	instr_1_Rdst_data_out <= R2_data_out;

elsif (instr_1_Rdst = "0100") then
	instr_1_Rdst_data_out <= R3_data_out;

elsif (instr_1_Rdst = "0101") then
	instr_1_Rdst_data_out <= R4_data_out;

elsif (instr_1_Rdst = "0110") then
	instr_1_Rdst_data_out <= R5_data_out;

elsif (instr_1_Rdst = "0111") then
	instr_1_Rdst_data_out <= R6_data_out;

elsif (instr_1_Rdst = "1000") then
	instr_1_Rdst_data_out <= R7_data_out;

--elsif (instr_1_Rdst = "1001") then
--	instr_1_Rdst_data_out <= SP_data_out;

--elsif (instr_1_Rdst = "1010") then
--	instr_1_Rdst_data_out <= PC_data_out;

--elsif (instr_1_Rdst = "1011") then
--	instr_1_Rdst_data_out <= flag_data_out;
end if;
--------------------------------------------------------
-------------------------------------------------------- instr 2 Rsrc data out
if (instr_2_Rsrc = "0001") then
	instr_2_Rsrc_data_out <= R0_data_out;
elsif (instr_2_Rsrc = "0010") then
	instr_2_Rsrc_data_out <= R1_data_out;
elsif (instr_2_Rsrc = "0011") then
	instr_2_Rsrc_data_out <= R2_data_out;
elsif (instr_2_Rsrc = "0100") then
	instr_2_Rsrc_data_out <= R3_data_out;
elsif (instr_2_Rsrc = "0101") then
	instr_2_Rsrc_data_out <= R4_data_out;
elsif (instr_2_Rsrc = "0110") then
	instr_2_Rsrc_data_out <= R5_data_out;
elsif (instr_2_Rsrc = "0111") then
	instr_2_Rsrc_data_out <= R6_data_out;
elsif (instr_2_Rsrc = "1000") then
	instr_2_Rsrc_data_out <= R7_data_out;
--elsif (instr_2_Rsrc = "1001") then
--	instr_2_Rsrc_data_out <= SP_data_out;
--elsif (instr_2_Rsrc = "1010") then
--	instr_2_Rsrc_data_out <= PC_data_out;
--elsif (instr_2_Rsrc = "1011") then
--	instr_2_Rsrc_data_out <= flag_data_out;

end if;

-------------------------------------------------------- instr 2 Rdst data out
if (instr_2_Rdst = "0001") then
	instr_2_Rdst_data_out <= R0_data_out;

elsif (instr_2_Rdst = "0010") then
	instr_2_Rdst_data_out <= R1_data_out;

elsif (instr_2_Rdst = "0011") then
	instr_2_Rdst_data_out <= R2_data_out;

elsif (instr_2_Rdst = "0100") then
	instr_2_Rdst_data_out <= R3_data_out;

elsif (instr_2_Rdst = "0101") then
	instr_2_Rdst_data_out <= R4_data_out;

elsif (instr_2_Rdst = "0110") then
	instr_2_Rdst_data_out <= R5_data_out;

elsif (instr_2_Rdst = "0111") then
	instr_2_Rdst_data_out <= R6_data_out;

elsif (instr_2_Rdst = "1000") then
	instr_2_Rdst_data_out <= R7_data_out;

--elsif (instr_2_Rdst = "1001") then
--	instr_2_Rdst_data_out <= SP_data_out;

--elsif (instr_2_Rdst = "1010") then
--	instr_2_Rdst_data_out <= PC_data_out;

--elsif (instr_2_Rdst = "1011") then
--	instr_2_Rdst_data_out <= flag_data_out;
end if;
--------------------------------------------------------

end process;
END my_Register_File;