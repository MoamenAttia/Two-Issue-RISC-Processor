library ieee;
use ieee.std_logic_1164.all;

entity decoder_3x8 is
    port(
        decoder_enable      : in  std_logic;
        decoder_selector    : in  std_logic_vector(2 downto 0);
        decoder_output      : out std_logic_vector(7 downto 0)
    );
end entity;

architecture a_decoder_3x8 of decoder_3x8 is
begin
    
    decoder_output <= "00000000" when decoder_enable = '0' else
                      "00000001" when decoder_enable = '1' and decoder_selector = "000" else
                      "00000010" when decoder_enable = '1' and decoder_selector = "001" else
                      "00000100" when decoder_enable = '1' and decoder_selector = "010" else
                      "00001000" when decoder_enable = '1' and decoder_selector = "011" else
                      "00010000" when decoder_enable = '1' and decoder_selector = "100" else
                      "00100000" when decoder_enable = '1' and decoder_selector = "101" else
                      "01000000" when decoder_enable = '1' and decoder_selector = "110" else
                      "10000000" when decoder_enable = '1' and decoder_selector = "111";
end a_decoder_3x8;
