
LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

 
     
  Entity nadder is 
  Generic (n:integer :=8);
  port (a,b :in std_logic_vector(n-1 downto 0);
       cin :in std_logic;
       s:out std_logic_vector (n-1 downto 0);
       cout :out std_logic);
       
  end nadder;
  
  architecture a_nadder  of nadder is
    
    component my_adder is 
       PORT( a,b,cin : IN std_logic;
     s,cout : OUT std_logic); 
   end component ;
   signal temp :std_logic_vector (n-1 downto 0);
   
   begin 
     f0 :my_adder port map (a(0),b(0),cin,s(0),temp(0));
     loop1 :for i in 1 to n-1 generate 
       fx:my_adder port map (a(i) , b(i),temp(i-1),s(i),temp(i));
       end generate ;
  cout<= temp (n-1);
  
end a_nadder ;
  