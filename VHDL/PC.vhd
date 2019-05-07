library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity pc is
    port( 
        clk : in std_logic;
        rst : in std_logic;
        in_address : in std_logic_vector(31 downto 0);
        out_address : out std_logic_vector(31 downto 0);
        sel : in std_logic_vector(2 downto 0);
	    reset_address : in std_logic_vector(15 downto 0);

        pc_rdst : in std_logic_vector(3 downto 0);
        pc_address_rdst : in std_logic_vector(15 downto 0)
    );
end pc;

architecture my_pc of pc is
signal temp : std_logic_vector(31 downto 0);
begin
    process (clk , rst , sel)
    variable cnt : std_logic_vector(31 downto 0) := (others => '0');
    begin
        if(rst = '1') then
            cnt := X"0000" & reset_address;
        elsif(rising_edge(clk)) then
            if (pc_rdst = "1010") then
                cnt := pc_address_rdst;
            elsif(sel = "001") then
                cnt := std_logic_vector(to_unsigned(to_integer(unsigned(cnt)) - 1 , cnt'length));
            elsif(sel = "010") then
                cnt := in_address;
            elsif(sel = "100") then
                cnt := std_logic_vector(to_unsigned(to_integer(unsigned(cnt)) - 2 , cnt'length));
	        elsif(sel = "000") then
		        cnt := std_logic_vector(to_unsigned(to_integer(unsigned(cnt)) + 2 , cnt'length));
            elsif sel = "111" then
                cnt := std_logic_vector(to_unsigned(to_integer(unsigned(cnt)) , cnt'length));
            elsif sel = "110" then
                cnt := std_logic_vector(to_unsigned(to_integer(unsigned(in_address)) - 2 , cnt'length));
            end if;
        end if;
    temp <= cnt;
    end process;
    out_address <= temp;
end my_pc;

