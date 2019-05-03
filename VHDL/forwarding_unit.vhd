library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity forwarding_unit is
    Port ( 	
			ex_mem_regWrite_1         :in  STD_LOGIC;
			ex_mem_registerRd_1       :in  STD_LOGIC_VECTOR(3 downto 0);
				
			mem_wb_regWrite_1         :in  STD_LOGIC;
			mem_wb_registerRd_1 	  :in  STD_LOGIC_VECTOR(3 downto 0);

			ex_mem_regWrite_2         :in  STD_LOGIC;
			ex_mem_registerRd_2       :in  STD_LOGIC_VECTOR(3 downto 0);
				
			mem_wb_regWrite_2         :in  STD_LOGIC;
			mem_wb_registerRd_2 	  :in  STD_LOGIC_VECTOR(3 downto 0);
				
			id_ex_registerRs_1 	:in  STD_LOGIC_VECTOR(3 downto 0);
			id_ex_registerRt_1 	:in  STD_LOGIC_VECTOR(3 downto 0);
			id_ex_registerRs_2 	:in  STD_LOGIC_VECTOR(3 downto 0);
			id_ex_registerRt_2 	:in  STD_LOGIC_VECTOR(3 downto 0);
				
			forward_a_1 		:out STD_LOGIC_VECTOR(2 downto 0); -- rsrc
			forward_b_1 		:out STD_LOGIC_VECTOR(2 downto 0); -- rdst

			forward_a_2 		:out STD_LOGIC_VECTOR(2 downto 0); --rsrc
			forward_b_2 		:out STD_LOGIC_VECTOR(2 downto 0)  --rdst	
	);
end forwarding_unit;

architecture a_forwarding_unit of forwarding_unit is

begin

	process(ex_mem_regWrite_1, ex_mem_registerRd_1, mem_wb_regWrite_1, 
		mem_wb_registerRd_1, id_ex_registerRs_1, id_ex_registerRt_1,
		ex_mem_regWrite_2, ex_mem_registerRd_2, mem_wb_regWrite_2, 
		mem_wb_registerRd_2, id_ex_registerRs_2, id_ex_registerRt_2 ) is
	begin
		
		-- first operand in first instruction
		if ((ex_mem_regWrite_1 = '1') -- EX HAZARD
			and (ex_mem_registerRd_1 /= "0000")
			and (ex_mem_registerRd_1 = id_ex_registerRs_1)) then
				forward_a_1 <= "001"; 

		elsif((ex_mem_regWrite_2 = '1')
			 and (ex_mem_registerRd_2 /= "0000")
			 and (ex_mem_registerRd_2 = id_ex_registerRs_1)) then
				forward_a_1 <= "010";
				
		elsif ((mem_wb_regWrite_1 = '1') -- MEM HAZARD
			and (mem_wb_registerRd_1 /= "0000")
			and not(ex_mem_regWrite_1 = '1'
				and (ex_mem_registerRd_1 = id_ex_registerRs_1))
			and (mem_wb_registerRd_1 = id_ex_registerRs_1)) then
				forward_a_1 <= "011";

		elsif ((mem_wb_regWrite_2 = '1')
			and (mem_wb_registerRd_2 /= "0000")
			and not(ex_mem_regWrite_2 = '1'
				and (ex_mem_registerRd_2 = id_ex_registerRs_1))
			and (mem_wb_registerRd_2 = id_ex_registerRs_1)) then
				forward_a_1 <= "100";  
		else 
			forward_a_1 <= "000";
		end if;
		
		-- second operand in first instruction
		if ((ex_mem_regWrite_1 = '1') -- EX HAZARD
			and (ex_mem_registerRd_1 /= "0000")
			and (ex_mem_registerRd_1 = id_ex_registerRt_1)) then
				forward_b_1 <= "001"; 

		elsif((ex_mem_regWrite_2 = '1')
			 and (ex_mem_registerRd_2 /= "0000")
			 and (ex_mem_registerRd_2 = id_ex_registerRt_1)) then
				forward_b_1 <= "010";
				
		elsif ((mem_wb_regWrite_1 = '1') -- MEM HAZARD
			and (mem_wb_registerRd_1 /= "0000")
			and not(ex_mem_regWrite_1 = '1' 
				and (ex_mem_registerRd_1 = id_ex_registerRt_1))
			and (mem_wb_registerRd_1 = id_ex_registerRt_1)) then
				forward_b_1 <= "011";

		elsif ((mem_wb_regWrite_2 = '1')
			and (mem_wb_registerRd_2 /= "0000")
			and not(ex_mem_regWrite_2 = '1'
				and (ex_mem_registerRd_2 = id_ex_registerRt_1))
			and (mem_wb_registerRd_2 = id_ex_registerRt_1)) then
				forward_b_1 <= "100";  
		else 
			forward_b_1 <= "000";
		end if;

		-- first operand in second instruction
		if ((ex_mem_regWrite_1 = '1') -- EX HAZARD
			and (ex_mem_registerRd_1 /= "0000")
			and (ex_mem_registerRd_1 = id_ex_registerRs_2)) then
				forward_a_2 <= "001"; 

		elsif((ex_mem_regWrite_2 = '1')
			and (ex_mem_registerRd_2 /= "0000")
			 and (ex_mem_registerRd_2 = id_ex_registerRs_2)) then
				forward_a_2 <= "010";
				
		elsif ((mem_wb_regWrite_1 = '1') -- MEM HAZARD
			and (mem_wb_registerRd_1 /= "0000")
			and not(ex_mem_regWrite_1 = '1' 
				and (ex_mem_registerRd_1 = id_ex_registerRs_2))
			and (mem_wb_registerRd_1 = id_ex_registerRs_2)) then
				forward_a_2 <= "011";

		elsif ((mem_wb_regWrite_2 = '1')
			and (mem_wb_registerRd_2 /= "0000")
			and not(ex_mem_regWrite_2 = '1'
				and (ex_mem_registerRd_2 = id_ex_registerRs_2))
			and (mem_wb_registerRd_2 = id_ex_registerRs_2)) then
				forward_a_2 <= "100";  
		else 
			forward_a_2 <= "000";
		end if;
		
		-- second operand in second instruction
		if ((ex_mem_regWrite_1 = '1') -- EX HAZARD
			and (ex_mem_registerRd_1 /= "0000")
			and (ex_mem_registerRd_1 = id_ex_registerRt_2)) then
				forward_b_2 <= "001"; 

		elsif((ex_mem_regWrite_2 = '1')
			 and (ex_mem_registerRd_2 /= "0000")
			 and (ex_mem_registerRd_2 = id_ex_registerRt_2)) then
				forward_b_2 <= "010";
				
		elsif ((mem_wb_regWrite_1 = '1') -- MEM HAZARD
			and (mem_wb_registerRd_1 /= "0000")
			and not(ex_mem_regWrite_1 = '1' 
				and (ex_mem_registerRd_1 = id_ex_registerRt_2))
			and (mem_wb_registerRd_1 = id_ex_registerRt_2)) then
				forward_b_2 <= "011";

		elsif ((mem_wb_regWrite_2 = '1')
			and (mem_wb_registerRd_2 /= "0000")
			and not(ex_mem_regWrite_2 = '1' 
				and (ex_mem_registerRd_2 = id_ex_registerRt_2))
			and (mem_wb_registerRd_2 = id_ex_registerRt_2)) then
				forward_b_2 <= "100";  
		else 
			forward_b_2 <= "000";
		end if;
		
	end process;

end a_forwarding_unit;