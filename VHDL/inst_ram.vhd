library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity inst_ram is
    generic ( n : integer := 16; ram_size : integer := 64; address_size : integer := 32 );
    port (
        clk          : in  std_logic;
        enable_write : in  std_logic;
        address      : in  std_logic_vector(address_size - 1 downto 0);
        data_in      : in  std_logic_vector(n-1 downto 0);
        data_out     : out std_logic_vector(n-1 downto 0);
        address_2    : in  std_logic_vector(address_size - 1 downto 0);
        data_out_2   : out std_logic_vector(n-1 downto 0)
    );
end entity inst_ram;

architecture a_inst_ram of inst_ram is
    type ram_type is array(0 to ram_size -1) of std_logic_vector(n-1 downto 0);
    signal my_ram : ram_type;
begin
    process(clk)
        begin
            if (clk'event and clk = '1') then
                if enable_write = '1' then
                    my_ram(to_integer(unsigned(address))) <= data_in;
                end if;
            end if;
    end process;
    data_out <= my_ram(to_integer(unsigned(address)));
    data_out_2 <= my_ram(to_integer(unsigned(address_2)));
end a_inst_ram;
