library ieee;
use ieee.std_logic_1164.all;

entity register_level is
    generic(n: integer := 16);
    port(
        clk, rst, en    : in  std_logic;
        din             : in  std_logic_vector(n-1 downto 0);
        dout            : out std_logic_vector(n-1 downto 0)
    );
end entity;

architecture a_register_level of register_level is
begin

    process(clk, rst, , en, din)
    begin
        if rst='1' then
            dout <= (others => '0');
        elsif en='1' and clk='1' then
            dout <= din;
        end if;
    end process;
end a_register_level;