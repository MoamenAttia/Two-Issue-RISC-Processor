
LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY Register_File IS
GENERIC ( n : integer := 16);
PORT( 
	Clk,Rst : IN std_logic;
-----------------------------------------------
	i1_Rsrc : in std_logic_vector(3 downto 0);
	i1_Rdst : in std_logic_vector(3 downto 0);
	i1_Rsrc_data_out_1 : out std_logic_vector(15 downto 0);
	i1_Rdst_data_out_1 : out std_logic_vector(15 downto 0);
	i1_Rdst_data_in : in std_logic_vector(15 downto 0);
	i1_Rdst_write_back : in std_logic_vector(3 downto 0);
	i1_write_back_signal : in std_logic ;
-----------------------------------------------
	i2_Rsrc : in std_logic_vector(3 downto 0);
	i2_Rdst : in std_logic_vector(3 downto 0);
	i2_Rsrc_data_out_1 : out std_logic_vector(15 downto 0);
	i2_Rdst_data_out_1: out std_logic_vector(15 downto 0);
	i2_Rdst_data_in : in std_logic_vector(15 downto 0);
	i2_Rdst_write_back : in std_logic_vector(3 downto 0);	
	i2_write_back_signal : in std_logic; 
------------------------------------------------
	hazard_sel : in std_logic_vector(3 downto 0) ;
	hazard_data : out std_logic_vector(15 downto 0) ;
	MEM_sel : in std_logic_vector(3 downto 0) ;
	MEM_data : out std_logic_vector(15 downto 0) ;
------------------------------------------    in and out signals 
	IN_bus : in std_logic_vector (15 downto 0);
	OUT_bus : out std_logic_vector (15 downto 0);
	--------
	PP_signal : in std_logic_vector(1 downto 0);
	------------
	pc_data  : in std_logic_vector(31 downto 0)

);

END Register_File;

ARCHITECTURE my_Register_File OF Register_File IS


signal i1_Rsrc_data_out :  std_logic_vector(15 downto 0);
signal	i1_Rdst_data_out :  std_logic_vector(15 downto 0);

signal i2_Rsrc_data_out :  std_logic_vector(15 downto 0);
signal 	i2_Rdst_data_out:  std_logic_vector(15 downto 0);
-- clk
signal clk_inv : std_logic;

------------------------------------------------- En Signals
signal R0_En :std_logic;
signal R1_En :std_logic;
signal R2_En :std_logic;
signal R3_En :std_logic;
signal R4_En :std_logic;
signal R5_En :std_logic;
signal R6_En :std_logic;
signal R7_En :std_logic;
-------------------------------------------------- data in
signal R0_data_in :std_logic_vector(15 downto 0);
signal R1_data_in :std_logic_vector(15 downto 0);
signal R2_data_in :std_logic_vector(15 downto 0);
signal R3_data_in :std_logic_vector(15 downto 0);
signal R4_data_in :std_logic_vector(15 downto 0);
signal R5_data_in :std_logic_vector(15 downto 0);
signal R6_data_in :std_logic_vector(15 downto 0);
signal R7_data_in :std_logic_vector(15 downto 0);
-------------------------------------------------- data out
signal R0_data_out :std_logic_vector(15 downto 0);
signal R1_data_out :std_logic_vector(15 downto 0);
signal R2_data_out :std_logic_vector(15 downto 0);
signal R3_data_out :std_logic_vector(15 downto 0);
signal R4_data_out :std_logic_vector(15 downto 0);
signal R5_data_out :std_logic_vector(15 downto 0);
signal R6_data_out :std_logic_vector(15 downto 0);
signal R7_data_out :std_logic_vector(15 downto 0);
-----------------------------------------------
signal bus_out :std_logic_vector (15 downto 0);
--------------------------------------------------SP
signal sp:std_logic_vector (15 downto 0);

BEGIN

i1_Rsrc_data_out_1 <= sp when i1_Rsrc = "1000" else i1_Rsrc_data_out;
i1_Rdst_data_out_1 <= sp when i1_Rdst = "1000" else i1_Rdst_data_out;
i2_Rsrc_data_out_1 <= sp when i2_Rsrc = "1000" else i2_Rsrc_data_out;
i2_Rdst_data_out_1 <= sp when i2_Rdst = "1000" else i2_Rdst_data_out;

clk_inv <= not(Clk);
R0:entity work.my_nDFF  generic map (16) port map (clk,  rst , R0_data_in ,R0_data_out ,R0_EN);
R1:entity work.my_nDFF  generic map (16) port map (clk,  rst , R1_data_in ,R1_data_out ,R1_EN);
R2:entity work.my_nDFF  generic map (16) port map (clk,  rst , R2_data_in ,R2_data_out ,R2_EN);
R3:entity work.my_nDFF  generic map (16) port map (clk,  rst , R3_data_in ,R3_data_out ,R3_EN);
R4:entity work.my_nDFF  generic map (16) port map (clk,  rst , R4_data_in ,R4_data_out ,R4_EN);
R5:entity work.my_nDFF  generic map (16) port map (clk,  rst , R5_data_in ,R5_data_out ,R5_EN);
R6:entity work.my_nDFF  generic map (16) port map (clk,  rst , R6_data_in ,R6_data_out ,R6_EN);
R7:entity work.my_nDFF  generic map (16) port map (clk,  rst , R7_data_in ,R7_data_out ,R7_EN);
SP_1:entity work.sp port map (clk, PP_signal,sp);
------------------------------------------------------- 

process(clk ,rst,i1_Rsrc,i1_Rdst,i2_Rsrc ,i2_Rdst ,
	i1_write_back_signal,i2_write_back_signal,
	i1_Rdst_write_back,i2_Rdst_write_back,
	IN_bus ,i1_Rdst_data_in,i2_Rdst_data_in)
	begin
	--------------------------------------------------------- instr 1 write back and in from bus
	if (i1_Rdst_write_back = "0001" and i1_write_back_signal = '1' ) then 
		R0_data_in <= i1_Rdst_data_in;
		R0_En <= '1';
	elsif (i1_Rdst_write_back = "0010"and i1_write_back_signal = '1') then 
		R1_data_in <= i1_Rdst_data_in;
		R1_En <= '1';
	elsif (i1_Rdst_write_back = "0011"and i1_write_back_signal = '1') then 
		R2_data_in <= i1_Rdst_data_in;
		R2_En <= '1';
	elsif (i1_Rdst_write_back = "0100"and i1_write_back_signal = '1') then 
		R3_data_in <= i1_Rdst_data_in;
		R3_En <= '1';
	elsif (i1_Rdst_write_back = "0101"and i1_write_back_signal = '1') then 
		R4_data_in <= i1_Rdst_data_in;
		R4_En <= '1';
	elsif (i1_Rdst_write_back = "0110"and i1_write_back_signal = '1') then 
		R5_data_in <= i1_Rdst_data_in;
		R5_En <= '1';
	elsif (i1_Rdst_write_back = "0111"and i1_write_back_signal = '1') then 
		R6_data_in <= i1_Rdst_data_in;
		R6_En <= '1';
	elsif (i1_Rdst_write_back = "1000"and i1_write_back_signal = '1') then 
		R7_data_in <= i1_Rdst_data_in;
		R7_En <= '1';
	elsif (i1_Rdst_write_back = "1111"and i1_write_back_signal = '1' ) then 
		 OUT_bus<= i1_Rdst_data_in;	 
		
	end if;
	-------------------------------------------------------- instr 2 write back 
	if (i2_Rdst_write_back = "0001"and i2_write_back_signal = '1') then 
		R0_data_in <= i2_Rdst_data_in;
		R0_En <= '1';
	elsif (i2_Rdst_write_back = "0010"and i2_write_back_signal = '1') then 
		R1_data_in <= i2_Rdst_data_in;
		R1_En <= '1';
	elsif (i2_Rdst_write_back = "0011"and i2_write_back_signal = '1') then 
		R2_data_in <= i2_Rdst_data_in;
		R2_En <= '1';
	elsif (i2_Rdst_write_back = "0100"and i2_write_back_signal = '1') then 
		R3_data_in <= i2_Rdst_data_in;
		R3_En <= '1';
	elsif (i2_Rdst_write_back = "0101"and i2_write_back_signal = '1') then 
		R4_data_in <= i2_Rdst_data_in;
		R4_En <= '1';
	elsif (i2_Rdst_write_back = "0110"and i2_write_back_signal = '1') then 
		R5_data_in <= i2_Rdst_data_in;
		R5_En <= '1';
	elsif (i2_Rdst_write_back = "0111"and i2_write_back_signal = '1') then 
		R6_data_in <= i2_Rdst_data_in;
		R6_En <= '1';
	elsif (i2_Rdst_write_back = "1000"and i2_write_back_signal = '1') then 
		R7_data_in <= i2_Rdst_data_in;
		R7_En <= '1';
	elsif (i2_Rdst_write_back = "1111"and i2_write_back_signal = '1' ) then  --out
		OUT_bus<= i2_Rdst_data_in;
			
	end if;
	end process;	
-----------------------------------------------------------------------------------
process(
clk ,rst,
i1_Rsrc,i1_Rdst,i2_Rsrc ,i2_Rdst ,
i1_Rdst_write_back,i2_Rdst_write_back,
IN_bus,
R0_data_out,R1_data_out,R2_data_out,R3_data_out,
R4_data_out,R5_data_out,R6_data_out,R7_data_out,
pp_signal,sp)
begin
-------------------------------------------------------- instr 1 Rsrc data out
	if (i1_Rsrc = "0001") then
		i1_Rsrc_data_out <= R0_data_out;
	elsif (i1_Rsrc = "0010") then
		i1_Rsrc_data_out <= R1_data_out;
	elsif (i1_Rsrc = "0011") then
		i1_Rsrc_data_out <= R2_data_out;
	elsif (i1_Rsrc = "0100") then
		i1_Rsrc_data_out <= R3_data_out;
	elsif (i1_Rsrc = "0101") then
		i1_Rsrc_data_out <= R4_data_out;
	elsif (i1_Rsrc = "0110") then
		i1_Rsrc_data_out <= R5_data_out;
	elsif (i1_Rsrc = "0111") then
		i1_Rsrc_data_out <= R6_data_out;
	elsif (i1_Rsrc = "1000") then
		i1_Rsrc_data_out <= R7_data_out;
	elsif 	(i1_Rsrc = "1110") then --out 
		i1_Rsrc_data_out <=IN_bus;
	elsif 	(i1_Rsrc = "1000" ) then 
		i1_Rsrc_data_out<= sp;
	elsif (i1_Rsrc = "0000") then 
		i1_Rsrc_data_out <= "ZZZZZZZZZZZZZZZZ";
	end if;

	if (i1_Rdst = "0001") then
		i1_Rdst_data_out <= R0_data_out;

	elsif (i1_Rdst = "0010") then
		i1_Rdst_data_out <= R1_data_out;

	elsif (i1_Rdst = "0011") then
		i1_Rdst_data_out <= R2_data_out;

	elsif (i1_Rdst = "0100") then
		i1_Rdst_data_out <= R3_data_out;

	elsif (i1_Rdst = "0101") then
		i1_Rdst_data_out <= R4_data_out;

	elsif (i1_Rdst = "0110") then
		i1_Rdst_data_out <= R5_data_out;

	elsif (i1_Rdst = "0111") then
		i1_Rdst_data_out <= R6_data_out;

	elsif (i1_Rdst = "1000") then
		i1_Rdst_data_out <= R7_data_out;

	elsif 	(i1_Rdst = "1110") then --in 
		i1_Rdst_data_out <=IN_bus;
	elsif 	(i1_Rdst = "1000" ) then 
		i1_Rdst_data_out<= sp;	

	elsif (i1_Rdst = "0000") then 
		i1_Rdst_data_out <= "ZZZZZZZZZZZZZZZZ";

	end if;
	-------------------------------------------------------- instr 2 Rsrc data out
	if (i2_Rsrc = "0001") then
		i2_Rsrc_data_out <= R0_data_out;
	elsif (i2_Rsrc = "0010") then
		i2_Rsrc_data_out <= R1_data_out;
	elsif (i2_Rsrc = "0011") then
		i2_Rsrc_data_out <= R2_data_out;
	elsif (i2_Rsrc = "0100") then
		i2_Rsrc_data_out <= R3_data_out;
	elsif (i2_Rsrc = "0101") then
		i2_Rsrc_data_out <= R4_data_out;
	elsif (i2_Rsrc = "0110") then
		i2_Rsrc_data_out <= R5_data_out;
	elsif (i2_Rsrc = "0111") then
		i2_Rsrc_data_out <= R6_data_out;
	elsif (i2_Rsrc = "1000") then
		i2_Rsrc_data_out <= R7_data_out;
	elsif 	(i2_Rsrc = "1110") then --in 
		i2_Rsrc_data_out <=IN_bus;
	elsif 	(i2_Rsrc = "1000" ) then 
		i2_Rsrc_data_out<= sp;
	elsif (i2_Rsrc = "0000") then 
		i2_Rsrc_data_out <= "ZZZZZZZZZZZZZZZZ";
	end if;

	if (i2_Rdst = "0001") then
		i2_Rdst_data_out <= R0_data_out;

	elsif (i2_Rdst = "0010") then
		i2_Rdst_data_out <= R1_data_out;

	elsif (i2_Rdst = "0011") then
		i2_Rdst_data_out <= R2_data_out;

	elsif (i2_Rdst = "0100") then
		i2_Rdst_data_out <= R3_data_out;

	elsif (i2_Rdst = "0101") then
		i2_Rdst_data_out <= R4_data_out;

	elsif (i2_Rdst = "0110") then
		i2_Rdst_data_out <= R5_data_out;

	elsif (i2_Rdst = "0111") then
		i2_Rdst_data_out <= R6_data_out;

	elsif (i2_Rdst = "1000") then
		i2_Rdst_data_out <= R7_data_out;

	elsif 	(i2_Rdst = "1110") then --in 
		i2_Rdst_data_out <=IN_bus;

	elsif 	(i2_Rdst = "1000" ) then 
		i2_Rdst_data_out<= sp;
		
	elsif (i2_Rdst = "0000") then 
		i2_Rdst_data_out <= "ZZZZZZZZZZZZZZZZ";
	end if;
end process;
-------------------------------------------------------- hazard sel data out process
process(clk ,rst,hazard_sel)
begin
	if (hazard_sel = "0001") then
		hazard_data <= R0_data_out;
	elsif (hazard_sel = "0010") then
		hazard_data <= R1_data_out;
	elsif (hazard_sel = "0011") then
		hazard_data <= R2_data_out;
	elsif (hazard_sel = "0100") then
		hazard_data <= R3_data_out;
	elsif (hazard_sel = "0101") then
		hazard_data <= R4_data_out;
	elsif (hazard_sel = "0110") then
		hazard_data <= R5_data_out;
	elsif (hazard_sel = "0111") then
		hazard_data <= R6_data_out;
	elsif (hazard_sel = "1000") then
		hazard_data <= R7_data_out;
	elsif (hazard_sel = "0000") then 
		hazard_data <= "ZZZZZZZZZZZZZZZZ";
	end if;

end process;
-----------------------------------------------------memory sel data out process
process(clk ,rst,MEM_sel,R0_data_out,R1_data_out,R2_data_out,R3_data_out,R4_data_out,R5_data_out,pc_data,R6_data_out,R7_data_out)
begin
	if (MEM_sel = "0001") then
		MEM_data <= R0_data_out;
	elsif (MEM_sel = "0010") then
		MEM_data <= R1_data_out;
	elsif (MEM_sel = "0011") then
		MEM_data <= R2_data_out;
	elsif (MEM_sel = "0100") then
		MEM_data <= R3_data_out;
	elsif (MEM_sel = "0101") then
		MEM_data <= R4_data_out;
	elsif (MEM_sel = "0110") then
		MEM_data <= R5_data_out;
	elsif (MEM_sel = "0111") then
		MEM_data <= R6_data_out;
	elsif (MEM_sel = "1000") then
		MEM_data <= R7_data_out;
	elsif (MEM_sel = "1001") then
			MEM_data <= pc_data(15 downto 0);
	elsif (MEM_sel = "0000") then
		MEM_data <= "ZZZZZZZZZZZZZZZZ";

	end if;
end process;
END my_Register_File;