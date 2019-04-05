library ieee;
use ieee.std_logic_1164.all;

entity register_rising is
    port ( 
      clk : in  std_logic;
      rst : in  std_logic;
      en  : in  std_logic;
      d   : in  std_logic_vector(15 downto 0);
      q   : out std_logic_vector(15 downto 0)
    );
end entity register_rising;

Architecture a_register_rising of register_rising is
  Begin
    Process(clk , rst , en)
      Begin
        if(rst = '1') then
           q <= (others => '0');
        elsif (clk'event and clk = '1') then -- rising edge
          if en = '1' then     
            q <= d;
          end if;
        End if;
    End process;
End a_register_rising;