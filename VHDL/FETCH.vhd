LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY FETCH IS
	PORT (address : IN  std_logic_vector (31 downto 0);
          instruction1 : OUT std_logic_vector (15 downto 0);
          instruction2 : OUT std_logic_vector (15 downto 0));
END FETCH;

ARCHITECTURE a_FETCH OF FETCH IS
    BEGIN
    

    ---- fetch works like 
    ---the output of the pc is directly connected to address 
    ---- componant from  instruction ram here 
    ----get the data from ram and put it in instruction 1 and 2 
    --output is connected to IR buffer 
		
END a_FETCH;