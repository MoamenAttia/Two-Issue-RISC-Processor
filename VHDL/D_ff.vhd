library ieee;
use ieee.std_logic_1164.all;

entity D_ff is
    port ( 
      d   : in  std_logic;
      clk : in  std_logic;
      rst : in  std_logic;
      en  : in  std_logic;
      q   : out std_logic
    );
end entity D_ff;

Architecture a_Dff of D_ff is
  Begin
    Process(clk , rst , en )
      Begin
        if(rst = '1') then
           q <= '0';
        elsif (clk'event and clk = '1') then
          if en = '1' then     
            q <= d;
          end if;
        End if;
    End process;
End architecture;
