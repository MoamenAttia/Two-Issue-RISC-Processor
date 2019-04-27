library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fetch is
	port (
        clk               : in std_logic;
        clk_inv           : in std_logic;
        rst               : in std_logic;
        enable_mar_in     : in std_logic;
        enable_mdr_in     : in std_logic;
        enable_write      : in std_logic;
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
    
    signal data_out   : std_logic_vector(15 downto 0);
    signal mar_out    : std_logic_vector(31 downto 0);
   
    signal data_out_2   : std_logic_vector(15 downto 0);
    signal mar_out_2    : std_logic_vector(31 downto 0);
    
    signal address_2  : std_logic_vector(31 downto 0);
    begin
	
	    address_2 <= std_logic_vector(to_unsigned(to_integer(unsigned( address )) + 1, 32));

        mar_1    : entity work.n_dff generic map (32) port map ( clk , rst , enable_mar_in , address , mar_out );

        mdr_1    : entity work.n_dff generic map (16) port map ( clk , rst , enable_mdr_in , data_out , instruction1 );

        mar_2    : entity work.n_dff generic map (32) port map ( clk , rst , enable_mar_in , address_2 , mar_out_2 );

        mdr_2    : entity work.n_dff generic map (16) port map ( clk , rst , enable_mdr_in , data_out_2 , instruction2 );

        inst_ram : entity work.inst_ram port map ( clk_inv , enable_write , mar_out , dummy , data_out , mar_out_2 , data_out_2 );
		
end a_fetch;