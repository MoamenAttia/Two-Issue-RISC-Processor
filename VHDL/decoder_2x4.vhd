library ieee;
use ieee.std_logic_1164.all;

entity decoder_2x4 is
    port(
        decoder_enable      : in  std_logic;
        decoder_selector    : in  std_logic_vector(1 downto 0);
        decoder_output      : out std_logic_vector(3 downto 0)
    );
end entity;

architecture a_decoder_2x4 of decoder_2x4 is
begin
    decoder_output <= "0000" when decoder_enable = '0' else
                      "0001" when decoder_enable = '1' and decoder_selector = "00" else
                      "0010" when decoder_enable = '1' and decoder_selector = "01" else
                      "0100" when decoder_enable = '1' and decoder_selector = "10" else
                      "1000" when decoder_enable = '1' and decoder_selector = "11";
end a_decoder_2x4;