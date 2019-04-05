library ieee;
use ieee.std_logic_1164.all;

entity nadder is 
    port (
        inp_1 : in std_logic_vector(15 downto 0);
        inp_2 : in std_logic_vector(15 downto 0);
        cin   : in std_logic;
        sum   : out std_logic_vector (15 downto 0);
        cout  : out std_logic
    );
end nadder;

architecture a_nadder  of nadder is
signal temp :std_logic_vector (15 downto 0);

begin 
    f0 : entity work.one_bit_adder port map ( inp_1(0) , inp_2(0) , cin , sum(0) , temp(0) );
    loop1 : for i in 1 to 15 generate 
        fx : entity work.one_bit_adder port map ( inp_1(i) , inp_2(i) , temp(i-1) , sum(i) , temp(i) );
    end generate ;
    cout <= temp (15);
end architecture;