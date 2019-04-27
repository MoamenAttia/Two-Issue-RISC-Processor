library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fetch is
	port (
        clk               : in std_logic;
        address           : in  std_logic_vector (31 downto 0);
        instruction1      : out std_logic_vector (15 downto 0);
        instruction2      : out std_logic_vector (15 downto 0)
    );
end fetch;

architecture a_fetch of fetch is

    ----fetch works like 
    ---the output of the pc is directly connected to address 
    ----componant from  instruction ram here 
    ----get the data from ram and put it in instruction 1 and 2 
    --output is connected to ir buffer 

    signal dummy    : std_logic_vector(15 downto 0);
    signal address_2 : std_logic_vector(31 downto 0);
    
    begin
	
	address_2 <= std_logic_vector(to_unsigned(to_integer(unsigned( address )) + 1, 32));

        inst_ram : entity work.inst_ram port map ( clk , '0' , address , dummy , instruction1 , address_2 , instruction2 );
		
end a_fetch;