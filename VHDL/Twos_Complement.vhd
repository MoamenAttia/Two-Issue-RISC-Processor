LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY Twos_Complement IS
Generic (n:integer :=8);
	PORT (R : IN  std_logic_vector (n-1 downto 0);
	R_tows_complement : OUT std_logic_vector(n-1 downto 0) );
END Twos_Complement;

ARCHITECTURE my_Twos_Complement OF Twos_Complement IS
Signal ones_complement : std_logic_vector (n-1 downto 0);
Signal zeros_second_operand : std_logic_vector (n-1 downto 0);
signal temp_cout : std_logic;
BEGIN
ones_complement <= not R;
zeros_second_operand <= (R'length-1 downto 0=>'0');
adder:entity work.nadder  generic map (n) port map ( ones_complement, zeros_second_operand , '1' ,R_tows_complement,temp_cout);
END my_Twos_Complement;