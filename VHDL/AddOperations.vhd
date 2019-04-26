LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;
--------------------------------------------------
entity AddOperations is
Port(	A,B	:in	std_logic_vector(15 downto 0);
	Cin,S0,S1,S2 :in  std_logic;
	F:out	std_logic_vector(15 downto 0) ;
	cout :out std_logic);
			
end entity AddOperations;
-------------------------------------------------------
Architecture AddBehavioral of AddOperations is----------
-----------------------------------------------------
 component nadder is 
        Generic (n:integer :=8);
  port (a,b :in std_logic_vector(n-1 downto 0);
       cin :in std_logic;
       s:out std_logic_vector (n-1 downto 0);
       cout :out std_logic);
         end component ;
---------------------------------------------------------         
signal input1 : std_logic_vector(15 downto 0);
signal input2 : std_logic_vector(15 downto 0);
signal temp : std_logic;
signal temp2 : std_logic_vector(2 downto 0);
--------------------------------------------------------------
begin----------------------------------------------
------------------------------------------------------
  temp2 <= S2&S1&S0;
   PROCESS(A,B,Cin,S0,S1,S2,temp2)    
          BEGIN   
	IF(temp2 = "000") THEN  
		  input1 <=  a;
         input2 <= b;              --a+b
		 temp <='0';
------------------------------------		 
    ELSIF (temp2 = "001") THEN 
	     input1 <=  a;
         input2 <= b;   --a+b+carry
		 temp <=Cin;
---------------------------------------		 
    ELSIF (temp2 = "010") THEN 
      	 input1 <=  a;
         input2 <= not b;    --a-b
         temp <='1';  
---------------------------------------

    ELSIF (temp2 = "011") THEN 
         	input1 <=  a;
         	input2 <=  not b;             --a-b-carry   a+notb +notcarry
		temp<=not(Cin); 
-----------------------------------------				 
    ELSIF (temp2 = "100") THEN 
         	input1 <=  a;
         	input2 <=   x"0000";     --a+1
         	temp<='1';
-------------------------------------------
    ELSIF (temp2 = "101") THEN 
         	input1 <=  a;
         	input2 <=  "1111111111111110";   --a-1
         	temp<='1';
-----------------------------------------				
        ELSe      
        	input1 <=  x"0000";
         	input2 <=  x"0000";
         	temp <='0';
--------------------------------------
	END IF;
    END PROCESS;
----------------------------------------
 n: nadder GENERIC MAP (16) port map (input1 ,input2,temp,f,cout);
---------------------------------------------------------------
end Architecture;
