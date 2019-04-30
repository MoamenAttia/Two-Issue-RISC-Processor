
LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY Register_File IS
GENERIC ( n : integer := 16);
PORT( Clk,Rst : IN std_logic;
-----------------------------------------------
	i1_Rsrc : in std_logic_vector(3 downto 0);
	i1_Rdst : in std_logic_vector(3 downto 0);
	i1_Rsrc_data_out : out std_logic_vector(15 downto 0);
	i1_Rdst_data_out : out std_logic_vector(15 downto 0);
	i1_Rdst_data_in : in std_logic_vector(15 downto 0);
	i1_Rdst_write_back : in std_logic_vector(3 downto 0);
	i1_write_back_signal : in std_logic ;
-----------------------------------------------
	i2_Rsrc : in std_logic_vector(3 downto 0);
	i2_Rdst : in std_logic_vector(3 downto 0);
	i2_Rsrc_data_out : out std_logic_vector(15 downto 0);
	i2_Rdst_data_out: out std_logic_vector(15 downto 0);
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
---------------------------------------------------  from control unit
	i1_IN_signal:in std_logic;
	i1_OUT_signal:in std_logic;
----------------------------------
	i2_IN_signal:in std_logic;
	i2_OUT_signal:in std_logic;
	-------------------------
	i1_in_out_dest : in  std_logic_vector (3 downto 0);
	i2_in_out_dest : in  std_logic_vector (3 downto 0);
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
process(clk ,rst,i1_Rsrc,i1_Rdst,i2_Rsrc ,i2_Rdst ,i1_Rdst_write_back,i2_Rdst_write_back)
	begin
	--------------------------------------------------------- instr 1 write back
	if (i1_Rdst_write_back = "0001" and i1_write_back_signal = '1') then 
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
	--elsif (i1_Rdst_write_back = "1001") then 
	--	SP_data_in <= i1_Rdst_data_in;
	--	SP_En <= '1';
	--elsif (i1_Rdst_write_back = "1010") then 
	--	PC_data_in <= i1_Rdst_data_in;
	--	PC_En <= '1';
	--elsif (i1_Rdst_write_back = "1011") then 
	--	flag_data_in <= i1_Rdst_data_in;
	--	flag_En <= '1';
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
	--elsif (i2_Rdst_write_back = "1001") then 
	--	SP_data_in <= i2_Rdst_data_in;
	--	SP_En <= '1';
	--elsif (i2_Rdst_write_back = "1010") then 
	--	PC_data_in <= i2_Rdst_data_in;
	--	PC_En <= '1';
	--elsif (i2_Rdst_write_back = "1011") then 
	--	flag_data_in <= i2_Rdst_data_in;
	--	flag_En <= '1';
	end if;
end process;	

process(clk ,rst,i1_Rsrc,i1_Rdst,i2_Rsrc ,i2_Rdst ,i1_Rdst_write_back,i2_Rdst_write_back,IN_bus,OUT_bus)
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
	--elsif (i1_Rsrc = "1001") then
	--	i1_Rsrc_data_out <= SP_data_out;
	--elsif (i1_Rsrc = "1010") then
	--	i1_Rsrc_data_out <= PC_data_out;
	--elsif (i1_Rsrc = "1011") then
	--	i1_Rsrc_data_out <= flag_data_out;
	elsif (i1_Rsrc = "0000") then 
		i1_Rsrc_data_out <= x"zzzz"
	end if;
	-------------------------------------------------------- instr 1 Rdst data out

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

		--elsif (i1_Rdst = "1001") then
		--	i1_Rdst_data_out <= SP_data_out;

		--elsif (i1_Rdst = "1010") then
		--	i1_Rdst_data_out <= PC_data_out;

		--elsif (i1_Rdst = "1011") then
		--	i1_Rdst_data_out <= flag_data_out;
		elsif (i1_Rdst = "0000") then 
			i1_Rdst_data_out <= x"zzzz"

		end if;
			
	--------------------------------------------------------
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
	--elsif (i2_Rsrc = "1001") then
	--	i2_Rsrc_data_out <= SP_data_out;
	--elsif (i2_Rsrc = "1010") then
	--	i2_Rsrc_data_out <= PC_data_out;
	--elsif (i2_Rsrc = "1011") then
	--	i2_Rsrc_data_out <= flag_data_out;
	elsif (i2_Rsrc = "0000") then 
		i2_Rsrc_data_out <= x"zzzz";
	end if;

	-------------------------------------------------------- instr 2 Rdst data out
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

	--elsif (i2_Rdst = "1001") then
	--	i2_Rdst_data_out <= SP_data_out;

	--elsif (i2_Rdst = "1010") then
	--	i2_Rdst_data_out <= PC_data_out;

	--elsif (i2_Rdst = "1011") then
	--	i2_Rdst_data_out <= flag_data_out;

	elsif (i2_Rdst = "0000") then 
		i2_Rdst_data_out <= x"zzzz";
	end if;
	--------------------------------------------------------

end process;
-------------------------------------------------------- hazard sel data out process
process(clk ,rst,hazard_sel)
begin
-------------------------------------------------------- instr 1 Rsrc data out
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
	--elsif (hazard_sel = "1001") then
	--	hazard_data <= SP_data_out;
	--elsif (hazard_sel = "1010") then
	--	hazard_data <= PC_data_out;
	--elsif (hazard_sel = "1011") then
	--	hazard_data <= flag_data_out;
	elsif (hazard_sel = "0000") then 
		hazard_data <= x"zzzz";
	end if;

end process;
-----------------------------------------------------memory sel data out process
process(clk ,rst,MEM_sel)
begin
----------------------------------------------------instr 1 Rsrc data out
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
	--elsif (MEM_sel = "1001") then
	--	MEM_data <= SP_data_out;
	--elsif (MEM_sel = "1010") then
	--	MEM_data <= PC_data_out;
	--elsif (MEM_sel = "1011") then
	--	MEM_data <= flag_data_out;
	elsif (MEM_sel = "0000") then
		MEM_data <= x"zzzz";

	end if;
end process;
--------------------------------------------------------
process(clk ,rst,IN_bus ,OUT_bus ,i1_IN_signal,i1_OUT_signal,i2_IN_signal,i2_OUT_signal,i1_in_out_dest,i2_in_out_dest )
begin

if (i1_IN_signal='1') then
	if (i1_in_out_dest = "0001" ) then 
		R0_data_in <= IN_bus;
		R0_En <= '1';
	elsif (i1_in_out_dest = "0010") then 
		R1_data_in <= IN_bus;
		R1_En <= '1';
	elsif (i1_in_out_dest = "0011") then 
		R2_data_in <= IN_bus;
		R2_En <= '1';
	elsif (i1_in_out_dest = "0100") then 
		R3_data_in <= IN_bus;
		R3_En <= '1';
	elsif (i1_in_out_dest = "0101") then 
		R4_data_in <= IN_bus;
		R4_En <= '1';
	elsif (i1_in_out_dest = "0110") then 
		R5_data_in <= IN_bus;
		R5_En <= '1';
	elsif (i1_in_out_dest = "0111") then 
		R6_data_in <= IN_bus;
		R6_En <= '1';
	elsif (i1_in_out_dest = "1000") then 
		R7_data_in <= IN_bus;
		R7_En <= '1';
	end if;
end if;

if (i2_IN_signal='1') then
	if (i2_in_out_dest = "0001" ) then 
		R0_data_in <= IN_bus;
		R0_En <= '1';
	elsif (i2_in_out_dest = "0010") then 
		R1_data_in <= IN_bus;
		R1_En <= '1';
	elsif (i2_in_out_dest = "0011") then 
		R2_data_in <= IN_bus;
		R2_En <= '1';
	elsif (i2_in_out_dest = "0100") then 
		R3_data_in <= IN_bus;
		R3_En <= '1';
	elsif (i2_in_out_dest = "0101") then 
		R4_data_in <= IN_bus;
		R4_En <= '1';
	elsif (i2_in_out_dest = "0110") then 
		R5_data_in <= IN_bus;
		R5_En <= '1';
	elsif (i2_in_out_dest = "0111") then 
		R6_data_in <= IN_bus;
		R6_En <= '1';
	elsif (i2_in_out_dest = "1000") then 
		R7_data_in <= IN_bus;
		R7_En <= '1';
	end if;
end if;
-----------------------------------------------------------------
if (i1_OUT_signal='1') then
	if (i1_in_out_dest = "0001") then
		OUT_bus <= R0_data_out;

	elsif (i1_in_out_dest = "0010") then
		OUT_bus <= R1_data_out;

	elsif (i1_in_out_dest = "0011") then
		OUT_bus <= R2_data_out;

	elsif (i1_in_out_dest = "0100") then
		OUT_bus <= R3_data_out;

	elsif (i1_in_out_dest = "0101") then
		OUT_bus <= R4_data_out;

	elsif (i1_in_out_dest = "0110") then
		OUT_bus <= R5_data_out;

	elsif (i1_in_out_dest = "0111") then
		OUT_bus <= R6_data_out;

	elsif (i1_in_out_dest = "1000") then
		OUT_bus <= R7_data_out;
	elsif (i1_in_out_dest = "0000") then
			OUT_bus <= x"zzzz"";	

	end if;
	
end if ;

if (i2_OUT_signal='1') then
	if (i2_in_out_dest = "0001") then
		OUT_bus <= R0_data_out;

	elsif (i2_in_out_dest = "0010") then
		OUT_bus <= R1_data_out;

	elsif (i2_in_out_dest = "0011") then
		OUT_bus <= R2_data_out;

	elsif (i2_in_out_dest = "0100") then
		OUT_bus <= R3_data_out;

	elsif (i2_in_out_dest = "0101") then
		OUT_bus <= R4_data_out;

	elsif (i2_in_out_dest = "0110") then
		OUT_bus <= R5_data_out;

	elsif (i2_in_out_dest = "0111") then
		OUT_bus <= R6_data_out;

	elsif (i2_in_out_dest = "1000") then
		OUT_bus <= R7_data_out;

	elsif (i2_in_out_dest = "0000") then
			OUT_bus <= x"zzzz"";
	end if;
	
end if ;

end process
END my_Register_File;