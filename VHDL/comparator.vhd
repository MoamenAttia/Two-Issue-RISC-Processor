library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;
entity comparator is
    port (
        inp_1         : in    std_logic_vector(15 downto 0);
        inp_2         : in    std_logic_vector(15 downto 0);
        decision      : out   std_logic_vector( 1 downto 0)
    );
end entity comparator;

architecture a_comparator of comparator is

signal alu_sel   : std_logic := '1';
signal alu_cin   : std_logic := '0';
signal alu_cout  : std_logic := '0';
signal alu_out   : std_logic_vector(15 downto 0);
signal zero_vec  : std_logic_vector(15 downto 0) := (others => '0');

begin
    decision <= "00" when alu_out = zero_vec else
                "01" when alu_out(15) = '0' else
                "10" when alu_out(15) = '1';
    alu_subtractor_adder : entity work.adder_subtractor port map ( inp_1 , inp_2 , alu_sel , alu_cin , alu_out , alu_cout );
end a_comparator;