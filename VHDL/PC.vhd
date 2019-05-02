LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY PC IS
GENERIC ( n : integer := 32);
PORT( Clk,Rst : IN std_logic;
in_address : in std_logic_vector(31 downto 0);
out_address : out std_logic_vector(31 downto 0);
sel : in std_logic_vector(2 downto 0)
);
END PC;

ARCHITECTURE my_PC OF PC IS
signal d,q : std_logic_vector(31  downto 0);
signal input2 :std_logic_vector(31 downto 0);
signal temp :std_logic;
signal f : std_logic_vector(31 downto 0 );
signal o: std_logic_vector(31 downto 0 );
signal cout :std_logic;
begin

n_dff:entity work.my_nDFF  generic map (32) port map (clk,  rst , d ,q ,'1');
process (clk , rst , sel,in_address)
begin 
if(sel="000") then 
input2 <= x"00000002";
temp <= '0';
elsif(sel="001") then 
temp <= '1';
input2 <= x"FFFFFFFE";
elsif(sel="010") then 
o <=in_address;
elsif(sel="011")  then  
o <=q;
elsif(sel = "100") then
temp <= '1';
input2 <= x"FFFFFFFD";   
end if;
end process;
n_add: entity work.nadder GENERIC MAP (32) port map (q ,input2,temp,f,cout);
d <= f when sel = "000" or sel = "001" or sel = "100"
else o when sel = "010" or sel = "011";
out_address <= q;
END my_PC;