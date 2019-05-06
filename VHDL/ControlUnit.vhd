library ieee;
use ieee.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;

entity Control_Unit is
	port (
        opcode : in std_logic_vector(1 DOWNTO 0);
        func: in std_logic_vector(2 DOWNTO 0);
        Rsrc : in std_logic_vector(3 DOWNTO 0);
        Rdst : in std_logic_vector(3 DOWNTO 0);
        AluFunc : out std_logic_vector (4 downto 0);
	    src :out std_logic_vector(3 downto 0);
        dest : out std_logic_vector (3 downto 0);
        WB : out std_logic;
        MR : out std_logic;
        Mw : out std_logic;
        regOut1 : out std_logic_vector (3 downto 0);
        regOut2 : out std_logic_vector (3 downto 0);
        flush : in std_logic;
        -----------------------------
        IN_signal:out std_logic;
        OUT_signal:out std_logic;
        immediate : out std_logic;
        ----------------------
        PP_signal :out std_logic_vector(1 downto 0)
    );
end Control_Unit;

architecture a_Control_Unit of Control_Unit is
    
    begin 
    process ( opcode , func, Rsrc,Rdst,flush)
        begin 
            if (opcode = "00" and flush = '0' )   then  
                    immediate <= '0';   -- one operand 
                    PP_signal <= "00";
                    MR <= '0';
                    MW <= '0';

                if (func = "000")  then  -- no op 
                    AluFunc <= "00000";
                    dest <= "0000";
                    WB <= '0';
                    regOut1 <= "0000";
                    regOut2 <= "0000";
                    IN_signal <= '0';
                    OUT_signal <='0';
                    src<=Rsrc;

                elsif (func = "001") then -- set carry 
                    AluFunc <= "00001";
                    dest <= "0000";
                    WB <= '0';
                    regOut1 <= "0000";
                    regOut2 <= "0000";
                    IN_signal <= '0';
                    OUT_signal <='0';
                    src<=Rsrc;
               
                elsif (func = "010") then -- clear carry  
                    AluFunc <= "00010";
                    dest <= "0000";
                    WB <= '0';
                    regOut1 <= "0000";
                    regOut2 <= "0000";
                    IN_signal <= '0';
                    OUT_signal <='0';
                    src<=Rsrc;
              
               
                elsif (func = "011")  then  -- not 
                    AluFunc <= "00011";
                    dest <= Rdst;
                    WB <= '1';
                    regOut1 <= "0000";
                    regOut2 <= Rdst;
                    IN_signal <= '0';
                    OUT_signal <='0';
                    src<=Rsrc;
            
                elsif (func = "100") then  --increment
                    AluFunc <= "00100";
                    dest <= Rdst;
                    WB <= '1';
                    regOut1 <= "0000";
                    regOut2 <= Rdst;
                    IN_signal <= '0';
                    OUT_signal <='0';
                    src<=Rsrc;
                  
                elsif (func = "101") then  --decrement 
                    AluFunc <= "00101";
                    dest <= Rdst;
                    WB <= '1';
                    regOut1 <= "0000";
                    regOut2 <= Rdst;
                    IN_signal <= '0';
                    OUT_signal <='0';
                    src<=Rsrc;
              
                elsif (func = "111" ) then  --in 
                    AluFunc <= "01111";
                    dest <= Rdst;
                    WB <= '1';
                    regOut1 <= "0000";
                    regOut2 <= "1110";  -- this takes from in bus
                    IN_signal <= '1';
                    OUT_signal <='0';
                    src<=Rsrc;
           
                elsif (func = "110") then  --out
                    AluFunc <= "00111";
                    dest <= "1111"; --this writes to out bus
                    WB <= '1';
                    regOut1 <= Rdst;
                    regOut2 <= "0000";   
                    IN_signal <= '0';
                    OUT_signal <='1';
                    src<=Rdst;
               
                end if;

            elsif (opcode = "01" and flush ='0' )   then 
                    src<=Rsrc;
                    IN_signal <= '0';
                    OUT_signal <='0';
                    PP_signal <= "00";
                    MR <= '0';
                    MW <= '0';
                if (func = "000") then   -- mov 
                    AluFunc <= "00111";  --pass rsc
                    dest <= Rdst;
                    WB <= '1';
                    regOut1 <= Rsrc;
                    regOut2 <= "0000";
                    immediate <= '0'; 

                elsif  (func = "001") then   -- add  
                    AluFunc <= "01000";  
                    dest <= Rdst;
                    WB <= '1';
                    regOut1 <= Rsrc;
                    regOut2 <= Rdst;
                    immediate <= '0';

                elsif  (func = "010") then   -- sub 
                    AluFunc <= "01001"; 
                    dest <= Rdst; 
                    WB <= '1';
                    regOut1 <= Rsrc;
                    regOut2 <= Rdst;
                    immediate <= '0';

                elsif  (func = "011") then   -- and
                    AluFunc <= "01010";  
                    dest <= Rdst;
                    WB <= '1';
                    regOut1 <= Rsrc;
                    regOut2 <= Rdst; 
                    immediate <= '0';

                elsif  (func = "100") then   -- or
                    AluFunc <= "01011";
                    dest <= Rdst;  
                    WB <= '1';
                    regOut1 <= Rsrc;
                    regOut2 <= Rdst;
                    immediate <= '0';

                elsif   (func = "101") then   -- shift left  (need immediate value ) 
                    AluFunc <= "01100";  
                    dest <= Rdst;
                    WB <= '1';
                    regOut1 <= "0000";
                    regOut2 <= Rdst;   
                    immediate <= '1'; 

                elsif   (func = "110") then   -- shift right (need immediate value ) 
                    AluFunc <= "01101";  
                    dest <= Rdst;
                    WB <= '1';
                    regOut1 <= "0000";
                    regOut2 <= Rdst;  
                    immediate <= '1'; 
                end if ;          
            
        elsif (opcode = "10" and flush ='0' )   then --memory
        
                IN_signal <= '0';
                OUT_signal <='0';

            if (func ="000")    then   -- push ()
                AluFunc <= "00111";  
                dest <= Rdst;
                WB <= '0';
                MR <= '0';
                MW <= '1';
                regOut1 <= Rsrc;
                regOut2 <= "0000"; 
                immediate <= '0'; 
                src<="0000";
                PP_signal <= "01";
            elsif (func ="001")    then   -- pop ()
                AluFunc <= "00111";  
                dest <= Rdst;
                WB <= '1';
                MR <= '1';
                MW <= '0';
                regOut1 <= "1000";
                regOut2 <= "0000"; 
                immediate <= '0'; 
                src<="0000";
                PP_signal <= "10";
            elsif (func ="010")    then   -- load immediate (done)
                AluFunc <= "00111";  
                dest <= Rdst;
                WB <= '1';
                MR <= '0';
                MW <= '0';
                regOut1 <= "0000";
                regOut2 <= "0000"; 
                immediate <= '1'; 
                src<=Rsrc;
                PP_signal <= "00";
            elsif (func ="011")    then   -- load from memory 
                AluFunc <= "00111";  --pass rsrc
                dest <= Rdst;
                WB <= '1';
                MR <= '1';
                MW <= '0';
                regOut1 <= Rsrc;
                regOut2 <= "0000"; 
                immediate <= '0'; 
                src<=Rsrc;
                PP_signal <= "00";
            elsif (func ="100")    then   -- store
                AluFunc <= "00111";  
                dest <= Rsrc;
                WB <= '0';
                MR <= '0';
                MW <= '1';
                regOut1 <= Rdst;
                regOut2 <= "0000"; 
                immediate <= '0'; 
                src<=Rdst;
                PP_signal <= "00";
            end if;

        elsif (opcode = "11" and flush ='0' )   then --branch
            IN_signal <= '0';
            OUT_signal <='0';
            src<=Rsrc;
            PP_signal <= "00";
    
            if (func ="000" or func ="001" or func ="010" or func ="001")    then  
                AluFunc <= "00000"; 
                dest <= "0000";
                WB <= '0';
                MR <= '0';
                MW <= '0';
                regOut1 <= "0000";
                regOut2 <= "0000"; 
                immediate <= '0'; 
            end if;

    else     
        AluFunc <= "00000";
        dest <= "0000";
        WB <= '0';
        MR <= '0';
        MW <= '0';              --flush
        regOut1 <= "0000";
        regOut2 <= "0000";
        immediate <= '0';
        IN_signal <= '0';
        OUT_signal <='0';
        PP_signal <= "00";
        src <= "0000";
       
    end if;  
	end process; 
   
end architecture;
