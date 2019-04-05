library ieee;
use ieee.std_logic_1164.all;

entity one_bit_adder is
	port (
        inp_1  : in  std_logic;
        inp_2  : in  std_logic;
        cin    : in  std_logic;
        sum    : out std_logic;
        cout : out std_logic 
    );
end one_bit_adder;

architecture a_one_bit_adder of one_bit_adder is
	begin
		process ( inp_1 , inp_2 , cin )
			begin 
                sum <= inp_1 xor inp_2 xor cin;
				cout <= (inp_1 and inp_2) or (cin and (inp_1 xor inp_2));
		end process;
end architecture;