library ieee;
use ieee.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;

entity ALU is
	port (
        in1  : in  std_logic_vector(15 downto 0);
        in2  : in  std_logic_vector(15 downto 0);
        result   : out std_logic_vector(15 downto 0);
        sel : in std_logic_vector(4 downto 0)
    );
end ALU;

architecture a_ALU of ALU is

    signal cout : std_logic;
    signal input1 : std_logic_vector(15 downto 0);
    signal input2 : std_logic_vector(15 downto 0);
    signal A : std_logic_vector (15 downto 0);
    signal B : std_logic_vector (15 downto 0);
    signal AluSelect :std_logic_vector(2 downto 0);
    signal outAdd : std_logic_vector (15 downto 0);
    signal carryadd : std_logic ;
    signal CIN : std_logic;
    signal r : std_logic_vector(15 downto 0);

    begin
        u3: entity work.AddOperations PORT MAP (A,B,CIN,AluSelect(0),AluSelect(1),AluSelect(2),outAdd,carryadd);
		process ( in1 , in2 , sel,outadd,A,B,CIN,AluSelect)
			begin 
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

                elsif (sel ="10000") then 
                    A <= in1;   
                    B<= x"0000";
                    CIN <='0';         -- inc
                    AluSelect <="100";
                elsif (sel = "10001") then 
                    A <= in1;   
                    B<= x"0000";
                    CIN <='0';         -- inc
                    AluSelect <="101";

    
                end if;    
                 
                
        end process;
        result <= outAdd when sel = "00100" or sel = "00101" or sel = "01000" or sel = "01001" or sel ="10000" or sel = "10001"
        else r  when sel = "00011" or sel = "00110" or sel = "00111" or sel = "01011" or sel = "01010" ; 

end architecture;



