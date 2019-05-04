library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity data_ram is
    generic ( n : integer := 16; ram_size : integer := 2**16; address_size : integer := 16 );
    port (
        clk          : in  std_logic;
        enable_write : in  std_logic;
        enable_read  : in  std_logic;
        address      : in  std_logic_vector(address_size - 1 downto 0);
        data_in      : in  std_logic_vector(n-1 downto 0);
        data_out     : out std_logic_vector(n-1 downto 0)
    );
end entity data_ram;

architecture a_data_ram of data_ram is
    type ram_type is array(0 to ram_size -1) of std_logic_vector(n-1 downto 0);
    signal my_ram : ram_type;
begin
    process(clk)
        begin
            
            if falling_edge(clk) and enable_write = '1' then
                my_ram(to_integer(unsigned(address))) <= data_in;
            elsif enable_read = '1' then
                data_out <= my_ram(to_integer(unsigned(address)));
            end if;

    end process;
end a_data_ram;
