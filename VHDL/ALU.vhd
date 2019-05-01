library ieee;
use ieee.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;

entity ALU is
	port (
	clk  : in  std_logic;
        in1  : in  std_logic_vector(15 downto 0);
        in2  : in  std_logic_vector(15 downto 0);
        result   : out std_logic_vector(15 downto 0);
        sel : in std_logic_vector(4 downto 0);
	flags : out std_logic_vector(2 downto 0)
    );
end ALU;

architecture a_ALU of ALU is

    signal cout : std_logic;
    --signal input1 : std_logic_vector(15 downto 0);
    --signal input2 : std_logic_vector(15 downto 0);
    signal A : std_logic_vector (15 downto 0);
    signal B : std_logic_vector (15 downto 0);
    signal AluSelect :std_logic_vector(2 downto 0);
    signal outAdd : std_logic_vector (15 downto 0);
    signal carryadd : std_logic ;
    signal CIN : std_logic;
    signal r : std_logic_vector(15 downto 0);
    signal carryShift : std_logic;
    signal tempShift : std_logic_vector(15 downto 0);
    signal carryFlag :std_logic := '0';
    signal negFlag :std_logic := '0';
    signal zeroFlag :std_logic := '0';


    begin
        u3: entity work.AddOperations PORT MAP (A,B,CIN,AluSelect(0),AluSelect(1),AluSelect(2),outAdd,carryadd);
		process ( clk, in1 , in2 , sel,outadd,A,B,CIN,AluSelect,carryShift,tempShift)
			begin 
                if(rising_edge(clk)) then
                    if (sel = "00001") then 
                        cout <= '1';     --set carry 

                    elsif (sel = "00010") then 
                        cout<= '0';    -- clear carry 

                    elsif  (sel ="00011") then 
                        r <= not in2;  -- not  
                    
                    elsif (sel = "00100")    then 
                        A <= in2;   
                        B<= x"0000";
                        CIN <='0';         -- inc
                        AluSelect <="100";
                    
                    elsif  (sel = "00101")    then 
                        A <= in2; 
                        B<= x"0000";
                        CIN<='0';             -- dec 
                        AluSelect <="101";
                    
                    elsif (sel = "00110") then 
                        r <= in2;        --rdst
                    elsif (sel = "00111")  then
                        r <= in1 ;        --rsrc 
                    elsif (sel ="01000") then 
                        A <= in1 ;
                        B<= in2;
                        CIN<='0';             -- add 
                        AluSelect <="000";
                    
                    elsif (sel ="01001") then 
                        A <= in1 ;
                        B<= in2;
                        CIN<='0';             -- sub 
                        AluSelect <="010"; 
                    
                    elsif (sel = "01010")   then 
                        r <= in1 and in2 ; --and

                    elsif (sel = "01011")  then 
                        r <= in1 or in2 ;  --or 

                    elsif (sel = "01100") then -- shift left 

                        tempShift <= std_logic_vector(shift_left(unsigned(in2),natural(to_integer(unsigned(in1)) -1  )));
                    
                        carryShift <=tempShift(15);

                    elsif (sel = "01101") then -- shift right 

                        tempShift <= std_logic_vector(shift_right(unsigned(in2),natural(to_integer(unsigned(in1)) -1  )));

		                carryShift <= tempShift(0);

                    elsif (sel ="10000") then 
                        A <= in1;   
                        B<= x"0000";
                        CIN <='0';         -- inc
                        AluSelect <="100";
                    elsif (sel = "10001") then 
                        A <= in1;   
                        B<= x"0000";
                        CIN <='0';         -- dec
                        AluSelect <="101";  
                    end if;
                end if;                 
        end process;
        result <= outAdd when sel = "00100" or sel = "00101" or sel = "01000" or sel = "01001" or sel ="10000" or sel = "10001"
        else r  when sel = "00011" or sel = "00110" or sel = "00111" or sel = "01011" or sel = "01010" 
	else tempShift(14 downto 0) & '0' when sel="01100" 
	else '0' & tempShift(15 downto 1) when sel ="01101"; 


----------------------------------------------------------------------------------------- flags
	process (in1 , in2 , sel,outadd,A,B,CIN,AluSelect,cout,carryAdd,carryShift,tempShift,r)
	begin
------------------------------FLAGS DEFAULT VALUE
	carryFlag<='0' ; negFlag<='0'; zeroFlag<='0';
------------------------------ carry
	if (sel = "00001" or sel = "00010") then 
		carryFlag <= cout ;
	elsif (sel = "00100" or sel = "00101" or sel = "01000" or sel = "01001" or sel = "10000" or sel = "10001")then -- arithmatic op
		carryFlag <= carryAdd;
	elsif ( sel = "01100" or sel = "01101")then -- shfift op
		carryFlag <= carryShift;
	end if;
------------------------------ Negative
        if ((sel ="00100" or sel ="00101" or sel ="01000" or sel ="01001" or sel ="10000"or sel ="10001")and outAdd(15) = '1') then --arithmatic op
		negFlag <= '1' ;
	elsif  ((sel ="00011" or sel ="01010" or sel ="01011") and r(15) = '1')then --logical op
		negFlag <= '1' ;
	elsif  ((sel ="01100" or sel ="01101" )and tempShift(15) = '1')then  -- shift op
		negFlag <= '1' ;
	end if;
------------------------------ Zero
	if ( (sel ="00100" or sel ="00101" or sel ="01000" or sel ="01001" or sel ="10000"or sel ="10001")and outAdd = x"0000" ) then --arithmatic op
		zeroFlag <= '1';
	elsif  ((sel ="00011" or sel ="01010" or sel ="01011") and r = x"0000")then  --logical op
		zeroFlag <= '1';
	elsif  ((sel ="01100" or sel ="01101") and tempShift = x"0000")then -- shift op
		zeroFlag <= '1';

	end if;
	end process ;


	flags <= carryFlag&negFlag&zeroFlag;


end architecture;



