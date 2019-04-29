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
        flush : in std_logic
    );
end Control_Unit;

architecture a_Control_Unit of Control_Unit is

    begin 
    process ( opcode , func, Rsrc,Rdst,flush)
        begin 
            if (opcode = "00" and flush = '0')   then     -- one operand 
                if (func = "000")  then  -- no op 
                    AluFunc <= "00000";
                    dest <= "0000";
                    WB <= '0';
                    MR <= '0';
                    MW <= '0';
                    regOut1 <= "0000";
                    regOut2 <= "0000";
                elsif (func = "001") then -- set carry 
                    AluFunc <= "00001";
                    dest <= "0000";
                    WB <= '0';
                    MR <= '0';
                    MW <= '0';
                    regOut1 <= "0000";
                    regOut2 <= "0000";
                elsif (func = "010") then -- clear carry )    
                    AluFunc <= "00010";
                    dest <= "0000";
                    WB <= '0';
                    MR <= '0';
                    MW <= '0';
                    regOut1 <= "0000";
                    regOut2 <= "0000";
                elsif (func = "011")  then  -- not 
                    AluFunc <= "00011";
                    dest <= Rdst;
                    WB <= '1';
                    MR <= '0';
                    MW <= '0';
                    regOut1 <= "0000";
                    regOut2 <= Rdst;
                elsif (func = "100") then  --increment
                    AluFunc <= "00100";
                    dest <= Rdst;
                    WB <= '1';
                    MR <= '0';
                    MW <= '0';
                    regOut1 <= "0000";
                    regOut2 <= Rdst;
                elsif (func = "101") then  --decrement 
                    AluFunc <= "00101";
                    dest <= Rdst;
                    WB <= '1';
                    MR <= '0';
                    MW <= '0';
                    regOut1 <= "0000";
                    regOut2 <= Rdst;
                elsif (func = "101") then  --in 
                    AluFunc <= "00000";     --
                    dest <= "0000";
                    WB <= '0';
                    MR <= '0';               ---change destination and write back iif in instructions
                    MW <= '0';
                    regOut1 <= "0000";
                    regOut2 <= Rdst;   ---------------change if out in decode 
                elsif (func = "110") then  --out  
                    AluFunc <= "00000";
                    dest <= Rdst;
                    WB <= '0';
                    MR <= '0';
                    MW <= '0';
                    regOut1 <= "0000";
                    regOut2 <= Rdst;   ---------------change if out in decode     
                end if;

            --elsif (opcode = "01" and flush =0 )   then )   --  two operand 


            -- else then     AluFunc <= "00000";
                  --  dest <= "0000";
                   -- WB <= '0';
                    --MR <= '0';
                    --MW <= '0';
                    --regOut1 <= "0000";
                    --regOut2 <= "0000";
            end if;  
         end process; 
		src<=Rsrc;    
end architecture;


