library ieee;
use ieee.std_logic_1164.all;

entity tri_state is
  generic ( n : integer := 32);
    port ( 
        tri_enable : in  std_logic;
        tri_input  : in  std_logic_vector (n-1 downto 0);
        tri_output : out std_logic_vector (n-1 downto 0)
    );
end tri_state;

architecture a_tri_state of tri_state is
begin
    tri_output <= tri_input when (tri_enable = '1') else (others => 'Z');
end a_tri_state;