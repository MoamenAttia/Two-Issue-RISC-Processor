library ieee;
use ieee.std_logic_1164.all;

entity decoder_4x16 is
    port(
        decoder_enable      : in  std_logic;
        decoder_selector    : in  std_logic_vector(3 downto 0);
        decoder_output      : out std_logic_vector(15 downto 0)
    );
end entity;

architecture a_decoder_4x16 of decoder_4x16 is
begin
    decoder_output <= "0000000000000000" when decoder_enable = '0' else
                      "0000000000000001" when decoder_enable = '1' and decoder_selector = "0000" else
                      "0000000000000010" when decoder_enable = '1' and decoder_selector = "0001" else
                      "0000000000000100" when decoder_enable = '1' and decoder_selector = "0010" else
                      "0000000000001000" when decoder_enable = '1' and decoder_selector = "0011" else
                      "0000000000010000" when decoder_enable = '1' and decoder_selector = "0100" else
                      "0000000000100000" when decoder_enable = '1' and decoder_selector = "0101" else
                      "0000000001000000" when decoder_enable = '1' and decoder_selector = "0110" else
                      "0000000010000000" when decoder_enable = '1' and decoder_selector = "0111" else
                      "0000000100000000" when decoder_enable = '1' and decoder_selector = "1000" else
                      "0000001000000000" when decoder_enable = '1' and decoder_selector = "1001" else
                      "0000010000000000" when decoder_enable = '1' and decoder_selector = "1010" else
                      "0000100000000000" when decoder_enable = '1' and decoder_selector = "1011" else
                      "0001000000000000" when decoder_enable = '1' and decoder_selector = "1100" else
                      "0010000000000000" when decoder_enable = '1' and decoder_selector = "1101" else
                      "0100000000000000" when decoder_enable = '1' and decoder_selector = "1110" else
                      "1000000000000000" when decoder_enable = '1' and decoder_selector = "1111";
end a_decoder_4x16;