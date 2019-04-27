library ieee;
use ieee.std_logic_1164.all;

entity n_dff is
generic ( n : integer := 32);
  port ( 
    clk : in  std_logic;
    rst : in  std_logic;
    en  : in  std_logic;
    d   : in  std_logic_vector(n-1 downto 0);
    q   : out std_logic_vector(n-1 downto 0)
  );
end n_dff;

architecture a_ndff of n_dff is
  begin
    loop1: for i in 0 to n-1 
      generate
        fx:entity work.d_ff port map( d(i) , clk , rst , en , q(i) );
      end generate;
end a_ndff;
