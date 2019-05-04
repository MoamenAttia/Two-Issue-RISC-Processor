LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY MEMORY IS
	PORT (
		------------------- ram signals-----------------
		clk               : in std_logic;
        clk_inv           : in std_logic;
        rst               : in std_logic;
		data_in			  : in std_logic_vector (15 downto 0);
		reg_sel			  : out std_logic_vector (3 downto 0);
		-----------------------------
		instr_1_Rdst 		:in std_logic_vector (3 downto 0);
		instr_1_write_back  :in std_logic;
		instr_1_stall_long 	:in std_logic;
		instr_1_mem_read 	:in std_logic;
		instr_1_mem_write 	:in std_logic;
		instr_1_alu_result 	:in std_logic_vector (15 downto 0); --address
		--------------------------------------
		instr_2_Rdst 		:in std_logic_vector (3 downto 0);
		instr_2_write_back 	:in std_logic;
		instr_2_stall_long 	:in std_logic;
		instr_2_mem_read 	:in std_logic;
		instr_2_mem_write 	:in std_logic;
		instr_2_alu_result 	:in std_logic_vector (15 downto 0); --address

		
		instr_1_Rdst_out 		:out std_logic_vector (3 downto 0);
		instr_1_write_back_out 	:out std_logic;
		instr_1_mem_read_out 	:out std_logic;
		instr_1_stall_long_out 	:out std_logic;
		instr_1_result_out	:out std_logic_vector (15 downto 0);

		--------------------------------------
		instr_2_Rdst_out 		:out std_logic_vector (3 downto 0);
		instr_2_write_back_out 	:out std_logic;
		instr_2_mem_read_out 	:out std_logic;
		instr_2_stall_long_out 	:out std_logic;
		instr_2_result_out 	:out std_logic_vector (15 downto 0)

    );
END MEMORY;

ARCHITECTURE a_MEMORY OF MEMORY IS

signal enable_write : std_logic;
signal enable_read	: std_logic;
signal address		: std_logic_vector(15 downto 0);

signal data_out 	: std_logic_vector(15 downto 0);
    BEGIN
    
--also connected to reg file with data
---data ram here 

	enable_read <= '1' when instr_1_mem_read = '1' or instr_2_mem_read = '1'
					   else '0';
	
	enable_write <= '1' when instr_1_mem_write = '1' or instr_2_mem_write = '1'
						else '0';

	address <= instr_1_alu_result when instr_1_mem_write = '1' or instr_1_mem_read = '1'
								  else instr_2_alu_result when instr_2_mem_write = '1' or instr_2_mem_read = '1';

	data_ram : entity work.data_ram port map ( clk , enable_write , enable_read , address , data_in , data_out);	

	instr_1_result_out <= data_out when instr_1_mem_read = '1'
									else instr_1_alu_result when instr_1_mem_read = '0';	
	instr_2_result_out <= data_out when instr_2_mem_read = '1'
								   else instr_2_alu_result  when instr_2_mem_read = '0';

	reg_sel <= instr_1_Rdst when instr_1_mem_write = '1'
							else instr_2_Rdst when instr_2_mem_write = '1'
							else "0000";

	
							
	instr_1_Rdst_out <= instr_1_Rdst;
	instr_1_write_back_out <= instr_1_write_back;
	instr_1_mem_read_out <= instr_1_mem_read ;
	instr_1_stall_long_out <=   instr_1_stall_long;
	
	instr_2_Rdst_out <= instr_2_Rdst;
	instr_2_write_back_out <= instr_2_write_back;
	instr_2_mem_read_out <= instr_2_mem_read ;
	instr_2_stall_long_out <=   instr_2_stall_long;


			
END a_MEMORY;