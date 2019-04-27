LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY MEMORY IS
	PORT (
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
		
		instr_1_Rdst_in 		:out std_logic_vector (3 downto 0);
		instr_1_write_back_in 	:out std_logic;
		instr_1_mem_read_in 	:out std_logic;
		instr_1_stall_long_in 	:out std_logic;
		instr_1_alu_result_in	:out std_logic_vector (15 downto 0);
		instr_1_mem_result_in 	:out std_logic_vector (15 downto 0);
		--------------------------------------
		instr_2_Rdst_in 		:out std_logic_vector (3 downto 0);
		instr_2_write_back_in 	:out std_logic;
		instr_2_mem_read_in 	:out std_logic;
		instr_2_stall_long_in 	:out std_logic;
		instr_2_alu_result_in 	:out std_logic_vector (15 downto 0);
		instr_2_mem_result_in 	:out std_logic_vector (15 downto 0);
		------------------- ram signals-----------------
		clk               : in std_logic;
        clk_inv           : in std_logic;
        rst               : in std_logic;
		data_in			  : in std_logic_vector (15 downto 0)
    );
END MEMORY;

ARCHITECTURE a_MEMORY OF MEMORY IS

signal enable_write : std_logic;
signal enable_read	: std_logic;
signal address		: std_logic_vector(15 downto 0);

signal enable_mar_in     : std_logic;  
signal enable_mdr_in     : std_logic;

signal mdr_data_in	: std_logic_vector(15 downto 0);
signal mdr_data_out		: std_logic_vector(15 downto 0);
signal data_out 	: std_logic_vector(15 downto 0);
signal mar_out  	: std_logic_vector(15 downto 0);

    BEGIN
    
--also connected to reg file with data
---data ram here 

	enable_read <= '1' when instr_1_mem_read = '1' or instr_2_mem_read = '1'
					   else '0';
	
	enable_write <= '1' when instr_1_mem_write = '1' or instr_2_mem_write = '1'
						else '0';

	address <= instr_1_alu_result when instr_1_mem_write = '1' or instr_1_mem_read = '1'
								  else instr_1_alu_result when instr_2_mem_write = '1' or instr_2_mem_read = '1';

	enable_mar_in <= '1' when instr_1_mem_write = '1' or instr_1_mem_read = '1' or instr_2_mem_write = '1' or instr_2_mem_read = '1'
						 else '0';

	enable_mdr_in <= '1' when instr_1_mem_write = '1' or instr_1_mem_read = '1' or instr_2_mem_write = '1' or instr_2_mem_read = '1'
						 else '0';

	mar    : entity work.n_dff generic map (16) port map ( clk , rst , enable_mar_in , address , mar_out );

	mdr    	: entity work.n_dff generic map (16) port map ( clk , rst , enable_mdr_in , mdr_data_in , mdr_data_out );

	data_ram : entity work.ram port map ( clk_inv , enable_write , enable_read , mar_out , mdr_data_out , data_out);	

	mdr_data_in <= data_out when enable_write = '0' and enable_read = '1'
				else data_in when enable_write = '1' and enable_read = '0';

	instr_1_mem_result_in <= mdr_data_out when instr_1_mem_read = '1'and instr_2_mem_read = '0';	
	instr_2_mem_result_in <= mdr_data_out when instr_1_mem_read = '0'and instr_2_mem_read = '1';
			
END a_MEMORY;