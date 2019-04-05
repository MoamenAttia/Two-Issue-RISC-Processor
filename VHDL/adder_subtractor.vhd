library ieee;
use ieee.std_logic_1164.all;
--------------------------------------------------
entity adder_subtractor is
    port (	
        inp_1    : in  std_logic_vector(15 downto 0);
        inp_2	 : in  std_logic_vector(15 downto 0);
        sel      : in  std_logic;
        cin      : in  std_logic;
        alu_out  : out std_logic_vector(15 downto 0) ;
        cout     : out std_logic
    );
			
end entity adder_subtractor;

architecture a_adder_subtractor of adder_subtractor is

signal alu_input_1 : std_logic_vector(15 downto 0);
signal alu_input_2 : std_logic_vector(15 downto 0);
signal alu_carry_in : std_logic;

begin
    process( inp_1 , inp_2 , cin , sel )    
    begin   
    
    if(sel = '0') then
	    alu_input_1 <= inp_1;
        alu_input_2 <= inp_2;        --a+b
	    alu_carry_in <='0';
    elsif (sel = '1') then
      	alu_input_1 <=  inp_1;
        alu_input_2 <= not inp_2;    --a-b
        alu_carry_in <='1';  
	end if;
    
    end process;
    n_adder :entity work.nadder port map ( alu_input_1 , alu_input_2 , alu_carry_in , alu_out , cout );
end architecture;