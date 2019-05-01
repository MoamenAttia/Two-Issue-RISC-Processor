LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

ENTITY mux is
    PORT
    (
        sel       : IN    std_logic_vector(2 DOWNTO 0);
        
	    input_1   : IN    std_logic_vector(15 DOWNTO 0);
        input_2   : IN    std_logic_vector(15 DOWNTO 0);
        input_3   : IN    std_logic_vector(15 DOWNTO 0);
        input_4   : IN    std_logic_vector(15 DOWNTO 0);
        input_5   : IN    std_logic_vector(15 DOWNTO 0);
        
	    output_1    : inOUT   std_logic_vector(15 DOWNTO 0)
    );
    
END ENTITy mux;

architecture behavioural of mux is

begin
process(sel,input_1,input_2,input_3,input_4,input_5)
begin
	if sel = "000" then
		output_1 <= input_1;
	elsif sel = "001" then
		output_1 <=input_2 ;
	elsif sel = "010" then
		output_1 <=input_3 ;
	elsif sel = "011" then
		output_1 <=input_4 ;
	else
		output_1 <=input_5 ;
	end if;
end process;
end behavioural; 