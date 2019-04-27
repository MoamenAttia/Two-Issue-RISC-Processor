LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY EXECUTE IS
	PORT (   --these signals from the decode execute buffer
	instr_1_Rdst: in std_logic_vector(3 DOWNTO 0);
	instr_1_Rsrc: in std_logic_vector(3 DOWNTO 0);
	instr_1_branch_taken : in std_logic;
	instr_1_load_use : in std_logic;
	instr_1_Rsrc_data: in std_logic_vector(15 DOWNTO 0);
	instr_1_Rdst_data: in std_logic_vector(15 DOWNTO 0);
	instr_1_stall_long :in std_logic;
	instr_1_write_back :in std_logic;
	instr_1_mem_read :in std_logic;
	instr_1_mem_write :in std_logic;
	instr_1_alu_operation :in std_logic_vector (4 downto 0);
	------------------------------------------------
	instr_2_Rdst: in std_logic_vector(3 DOWNTO 0);
	instr_2_Rsrc: in std_logic_vector(3 DOWNTO 0);
	instr_2_branch_taken : in std_logic;
	instr_2_load_use : in std_logic;
	instr_2_Rsrc_data: in std_logic_vector(15 DOWNTO 0);
	instr_2_Rdst_data: in std_logic_vector(15 DOWNTO 0);
	instr_2_stall_long :in std_logic;
	instr_2_write_back :in std_logic;
	instr_2_mem_read :in std_logic;
	instr_2_mem_write :in std_logic;
	instr_2_alu_operation :in std_logic_vector (4 downto 0);

	---these signals are connected with memory execute buffers
	instr_1_Rdst_in :out std_logic_vector (3 downto 0);
	instr_1_write_back_in :out std_logic;
	instr_1_stall_long_in :out std_logic;
	instr_1_mem_read_in :out std_logic;
	instr_1_mem_write_in :out std_logic;
	instr_1_alu_result_in :out std_logic_vector (15 downto 0);
	--------------------------------------
	instr_2_Rdst_in :out std_logic_vector (3 downto 0);
	instr_2_write_back_in :out std_logic;
	instr_2_stall_long_in :out std_logic;
	instr_2_mem_read_in :out std_logic;
	instr_2_mem_write_in :out std_logic;
	instr_2_alu_result_in :out std_logic_vector (15 downto 0);


	---------------forward signals----------------
	ex_mem_regWrite_1         :in  STD_LOGIC;
	ex_mem_registerRd_1       :in  STD_LOGIC_VECTOR(3 downto 0);
	mem_wb_regWrite_1         :in  STD_LOGIC;
	mem_wb_registerRd_1 	  :in  STD_LOGIC_VECTOR(3 downto 0);
	ex_mem_regWrite_2         :in  STD_LOGIC;
	ex_mem_registerRd_2       :in  STD_LOGIC_VECTOR(3 downto 0);
	mem_wb_regWrite_2         :in  STD_LOGIC;
	mem_wb_registerRd_2 	  :in  STD_LOGIC_VECTOR(3 downto 0);

	ex_mem_Rd_data_out_1	  :in std_logic_vector(15 downto 0);
	mem_wb_Rd_data_out_1	  :in std_logic_vector(15 downto 0);
	
	ex_mem_Rd_data_out_2	  :in std_logic_vector(15 downto 0);
	mem_wb_Rd_data_out_2	  :in std_logic_vector(15 downto 0)
	
	);
END EXECUTE;

ARCHITECTURE a_EXECUTE OF EXECUTE IS
    
signal forwarda   : std_logic_vector(2 downto 0);
signal forwardb   : std_logic_vector(2 downto 0);
signal forwarda_2 : std_logic_vector(2 downto 0);
signal forwardb_2 : std_logic_vector(2 downto 0);
signal opa_1	: std_logic_vector(15 downto 0);
signal opb_1	: std_logic_vector(15 downto 0);
signal opa_2	: std_logic_vector(15 downto 0);
signal opb_2	: std_logic_vector(15 downto 0);

BEGIN

   ---- 2 alus
   ---- forwarding unit 
   fu : entity work.forwarding_unit port map (
		ex_mem_regWrite_1,
   		ex_mem_registerRd_1,
		mem_wb_regWrite_1,
		mem_wb_registerRd_1,
		ex_mem_regWrite_2,
		ex_mem_registerRd_2,
		mem_wb_regWrite_2,
		mem_wb_registerRd_2,
		instr_1_Rdst,
		instr_1_Rsrc,
		instr_2_Rdst,
		instr_2_Rsrc,
		forwarda,
		forwardb,
		forwarda_2,
		forwardb_2
    );
   ---- muxs
   mux1 : entity work.mux port map 
   		(forwarda, instr_1_Rdst_data, ex_mem_Rd_data_out_1, ex_mem_Rd_data_out_2, mem_wb_Rd_data_out_1, mem_wb_Rd_data_out_2, opa_1);
   mux2 : entity work.mux port map 
   		(forwardb, instr_1_Rsrc_data, ex_mem_Rd_data_out_1, ex_mem_Rd_data_out_2, mem_wb_Rd_data_out_1, mem_wb_Rd_data_out_2, opb_1);
   
   mux3 : entity work.mux port map 
   		(forwarda_2, instr_2_Rdst_data, ex_mem_Rd_data_out_1, ex_mem_Rd_data_out_2, mem_wb_Rd_data_out_1, mem_wb_Rd_data_out_2, opa_2);
   mux4 : entity work.mux port map 
   		(forwardb_2, instr_2_Rsrc_data, ex_mem_Rd_data_out_1, ex_mem_Rd_data_out_2, mem_wb_Rd_data_out_1, mem_wb_Rd_data_out_2, opb_2);
END a_EXECUTE;