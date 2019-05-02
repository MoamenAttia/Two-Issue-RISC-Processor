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
        ----------------------------------
        -------------------------
        in_out_dest : out std_logic_vector (3 downto 0);
        ---------------------------------
        immediate : out std_logic;
        -----
        structural_hazard : in std_logic 
    
    );
end Control_Unit;

architecture a_Control_Unit of Control_Unit is

    begin 
    process ( opcode , func, Rsrc,Rdst,flush)
        begin 
            if (opcode = "00" and flush = '0' )   then  
                    immediate <= '0';   -- one operand 
                if (func = "000")  then  -- no op 
                    AluFunc <= "00000";
                    dest <= "0000";
                    WB <= '0';
                    MR <= '0';
                    MW <= '0';
                    regOut1 <= "0000";
                    regOut2 <= "0000";
                    IN_signal <= '0';
                    OUT_signal <='0';
                    in_out_dest <= "0000";

                elsif (func = "001") then -- set carry 
                    AluFunc <= "00001";
                    dest <= "0000";
                    WB <= '0';
                    MR <= '0';
                    MW <= '0';
                    regOut1 <= "0000";
                    regOut2 <= "0000";
                    IN_signal <= '0';
                    OUT_signal <='0';
                    in_out_dest <= "0000";
                 
                elsif (func = "010") then -- clear carry )    
                    AluFunc <= "00010";
                    dest <= "0000";
                    WB <= '0';
                    MR <= '0';
                    MW <= '0';
                    regOut1 <= "0000";
                    regOut2 <= "0000";
                    IN_signal <= '0';
                    OUT_signal <='0';
                    in_out_dest <= "0000";
               
                elsif (func = "011")  then  -- not 
                    AluFunc <= "00011";
                    dest <= Rdst;
                    WB <= '1';
                    MR <= '0';
                    MW <= '0';
                    regOut1 <= "0000";
                    regOut2 <= Rdst;
                    IN_signal <= '0';
                    OUT_signal <='0';
                    in_out_dest <= "0000";
            
                elsif (func = "100") then  --increment
                    AluFunc <= "00100";
                    dest <= Rdst;
                    WB <= '1';
                    MR <= '0';
                    MW <= '0';
                    regOut1 <= "0000";
                    regOut2 <= Rdst;
                    IN_signal <= '0';
                    OUT_signal <='0';
                    in_out_dest <= "0000";
             
                elsif (func = "101") then  --decrement 
                    AluFunc <= "00101";
                    dest <= Rdst;
                    WB <= '1';
                    MR <= '0';
                    MW <= '0';
                    regOut1 <= "0000";
                    regOut2 <= Rdst;
                    IN_signal <= '0';
                    OUT_signal <='0';
                    in_out_dest <= "0000";
        
                elsif (func = "111" and structural_hazard = '0') then  --in 
                    AluFunc <= "00000";
                    dest <= "0000";
                    WB <= '0';
                    MR <= '0';
                    MW <= '0';
                    regOut1 <= "0000";
                    regOut2 <= "0000";  
                    IN_signal <= '1';
                    OUT_signal <='0';
                    in_out_dest <= Rdst;
           
                elsif (func = "110") then  --out
                    AluFunc <= "00000";
                    dest <= Rdst;
                    WB <= '0';
                    MR <= '0';
                    MW <= '0';
                    regOut1 <= "0000";
                    regOut2 <= "0000";   
                    IN_signal <= '0';
                    OUT_signal <='1';
                    in_out_dest <= Rdst;     
                end if;

            elsif (opcode = "01" and flush ='0' )   then 
                    IN_signal <= '0';
                    OUT_signal <='0';
                    in_out_dest <= "0000";
                if (func = "000") then   -- mov 
                    AluFunc <= "00111";  --pass rsc
                    dest <= Rdst;
                    WB <= '1';
                    MR <= '0';
                    MW <= '0';
                    regOut1 <= Rsrc;
                    regOut2 <= "0000";
                    immediate <= '0';  
                elsif  (func = "001") then   -- add  
                    AluFunc <= "01000";  
                    dest <= Rdst;
                    WB <= '1';
                    MR <= '0';
                    MW <= '0';
                    regOut1 <= Rsrc;
                    regOut2 <= Rdst;
                    immediate <= '0';
                elsif  (func = "010") then   -- sub 
                    AluFunc <= "01001"; 
                    dest <= Rdst; 
                    WB <= '1';
                    MR <= '0';
                    MW <= '0';
                    regOut1 <= Rsrc;
                    regOut2 <= Rdst;
                    immediate <= '0';
                elsif  (func = "011") then   -- and
                    AluFunc <= "01010";  
                    dest <= Rdst;
                    WB <= '1';
                    MR <= '0';
                    MW <= '0';
                    regOut1 <= Rsrc;
                    regOut2 <= Rdst; 
                    immediate <= '0'; 
                elsif  (func = "100") then   -- or
                    AluFunc <= "01011";
                    dest <= Rdst;  
                    WB <= '1';
                    MR <= '0';
                    MW <= '0';
                    regOut1 <= Rsrc;
                    regOut2 <= Rdst;
                    immediate <= '0';  
                elsif   (func = "101") then   -- shift left  (need immediate value ) 
                    AluFunc <= "01100";  
                    dest <= Rdst;
                    WB <= '1';
                    MR <= '0';
                    MW <= '0';
                    regOut1 <= "0000";
                    regOut2 <= Rdst; -- immediate here  
                    immediate <= '1'; 
                elsif   (func = "110") then   -- shift right (need immediate value ) 
                    AluFunc <= "01101";  
                    dest <= Rdst;
                    WB <= '1';
                    MR <= '0';
                    MW <= '0';
                    regOut1 <= "0000";
                    regOut2 <= Rdst; -- immediate here  
                    immediate <= '1'; 
                end if ;          


            elsif (opcode = "10" and flush ='0' )   then 
                    IN_signal <= '0';
                    OUT_signal <='0';
                    in_out_dest <= "0000";

                if (func ="000")    then   -- push 
                     AluFunc <= "100001";  
                    dest <= "0000";
                    WB <= '0';
                    MR <= '0';
                    MW <= '1';
                    regOut1 <= "1000";
                    regOut2 <= "0000"; -- immediate here  
                    immediate <= '0'; 


            else     AluFunc <= "00000";
                    dest <= "0000";
                    WB <= '0';
                    MR <= '0';
                    MW <= '0';              --flush
                    regOut1 <= "0000";
                    regOut2 <= "0000";
                    immediate <= '0';
                    IN_signal <= '0';
                    OUT_signal <='0';
                    in_out_dest <= "0000";
            end if;
	    end if;
         end process; 
		src<=Rsrc;    
end architecture;


