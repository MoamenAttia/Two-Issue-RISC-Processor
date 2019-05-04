library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity SP is
    port( 
        clk : in std_logic;
        pp_signal : in std_logic_vector(1 downto 0);
        out_address : out std_logic_vector(15 downto 0)
    );
end SP;

architecture my_SP of SP is
signal sp : std_logic_vector(15 downto 0):="1111111111111111";
signal sp_minus : std_logic_vector(15 downto 0):="1111111111111110";
begin
process(clk,pp_signal)
begin
if(rising_edge(clk))then
    if (pp_signal = "01")then
        sp <= std_logic_vector(to_unsigned(to_integer(unsigned(sp))-1,sp'length));
        sp_minus <= std_logic_vector(to_unsigned(to_integer(unsigned(sp_minus))-1,sp_minus'length));
    elsif (pp_signal = "10")then 
        sp <= std_logic_vector(to_unsigned(to_integer(unsigned(sp))+1,sp'length));
        sp_minus <= std_logic_vector(to_unsigned(to_integer(unsigned(sp_minus))+1,sp_minus'length));
    end if;
 end if;
end process;
out_address <= sp when pp_signal="01" or pp_signal = "00"
else sp_minus when pp_signal="10";



end my_SP;
