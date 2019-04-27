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
        
	    output    : OUT   std_logic_vector(15 DOWNTO 0)
    );
    
END ENTITy mux;

architecture behavioural of mux is

begin
	output <= input_1 when sel = "000"
	else input_2 when sel = "001"
	else input_3 when sel = "010"
	else input_4 when sel = "011"
	else input_5;

end behavioural; 