LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY EXECUTE IS
	PORT (   --these signals from the decode execute buffer
	i1_Rdst: in std_logic_vector(3 DOWNTO 0);
	i1_Rsrc: in std_logic_vector(3 DOWNTO 0);
	i1_branch_taken : in std_logic;
	i1_load_use : in std_logic;
	i1_Rsrc_data: in std_logic_vector(15 DOWNTO 0);
	i1_Rdst_data: in std_logic_vector(15 DOWNTO 0);
	i1_stall_long :in std_logic;
	i1_WB :in std_logic;
	i1_MR :in std_logic;
	i1_MW :in std_logic;
	i1_alu_op :in std_logic_vector (4 downto 0);
	------------------------------------------------
	i2_Rdst: in std_logic_vector(3 DOWNTO 0);
	i2_Rsrc: in std_logic_vector(3 DOWNTO 0);
	i2_branch_taken : in std_logic;
	i2_load_use : in std_logic;
	i2_Rsrc_data: in std_logic_vector(15 DOWNTO 0);
	i2_Rdst_data: in std_logic_vector(15 DOWNTO 0);
	i2_stall_long :in std_logic;
	i2_WB :in std_logic;
	i2_MR :in std_logic;
	i2_MW :in std_logic;
	i2_alu_op :in std_logic_vector (4 downto 0);
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
	mem_wb_Rd_data_out_2	  :in std_logic_vector(15 downto 0);
	---these signals are connected with memory execute buffers
	i1_Rdst_Exec_out :out std_logic_vector (3 downto 0);
	i1_WB_Exec_out :out std_logic;
	i1_stall_long_Exec_out :out std_logic;
	i1_MR_Exec_out :out std_logic;
	i1_MW_Exec_out :out std_logic;
	i1_alu_result_Exec_out :out std_logic_vector (15 downto 0);
	--------------------------------------
	i2_Rdst_Exec_out :out std_logic_vector (3 downto 0);
	i2_WB_Exec_out :out std_logic;
	i2_stall_long_Exec_out :out std_logic;
	i2_MR_Exec_out :out std_logic;
	i2_MW_Exec_out :out std_logic;
	i2_alu_result_Exec_out :out std_logic_vector (15 downto 0);
	-----------------------------------------------
	flags: out std_logic_vector(2 downto 0):="000"
	);
END EXECUTE;




------------------------------------------
ARCHITECTURE a_EXECUTE OF EXECUTE IS
 ------------------------------------------   
signal forwarda   : std_logic_vector(2 downto 0);
signal forwardb   : std_logic_vector(2 downto 0);
signal forwarda_2 : std_logic_vector(2 downto 0);
signal forwardb_2 : std_logic_vector(2 downto 0);
signal opa_1	: std_logic_vector(15 downto 0);
signal opb_1	: std_logic_vector(15 downto 0);
signal opa_2	: std_logic_vector(15 downto 0);
signal opb_2	: std_logic_vector(15 downto 0);
------------------------Flgas
signal alu_1_flags : std_logic_vector(2 downto 0);
signal alu_2_flags : std_logic_vector(2 downto 0);
signal flags_1 : std_logic_vector(2 downto 0) := (others => '0');
signal flags_2 : std_logic_vector(2 downto 0) := (others => '0');
--------------------------------------
----------testing 
signal temp1,temp2 :std_logic_vector(15 downto 0);
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
		i1_Rsrc,
		i1_Rdst,
		i2_Rsrc,
		i2_Rdst,
		forwarda,
		forwardb,
		forwarda_2,
		forwardb_2,
		i1_alu_op,
		i2_alu_op
	);
	
   ---- muxs
   mux1 : entity work.mux port map 
   		(forwarda, i1_Rsrc_data, ex_mem_Rd_data_out_1, ex_mem_Rd_data_out_2, mem_wb_Rd_data_out_1, mem_wb_Rd_data_out_2, opa_1);
   mux2 : entity work.mux port map 
   		(forwardb, i1_Rdst_data, ex_mem_Rd_data_out_1, ex_mem_Rd_data_out_2, mem_wb_Rd_data_out_1, mem_wb_Rd_data_out_2, opb_1);
   
   mux3 : entity work.mux port map 
   		(forwarda_2, i2_Rsrc_data, ex_mem_Rd_data_out_1, ex_mem_Rd_data_out_2, mem_wb_Rd_data_out_1, mem_wb_Rd_data_out_2, opa_2);
   mux4 : entity work.mux port map 
   		(forwardb_2, i2_Rdst_data, ex_mem_Rd_data_out_1, ex_mem_Rd_data_out_2, mem_wb_Rd_data_out_1, mem_wb_Rd_data_out_2, opb_2);
 
   alu1: entity work.alu port map 
		(opa_1,opb_1,i1_alu_result_Exec_out,i1_alu_op,alu_1_flags);
   alu2: entity work.alu port map 
		(opa_2,opb_2,i2_alu_result_Exec_out,i2_alu_op,alu_2_flags);


		i1_Rdst_Exec_out<= i1_Rdst;
		i1_WB_Exec_out <= i1_WB;
		i1_stall_long_Exec_out <= i1_stall_long;
		i1_MR_Exec_out <= i1_MR;
		i1_MW_Exec_out <= i1_MW;

		i2_Rdst_Exec_out<= i2_Rdst;
		i2_WB_Exec_out <= i2_WB;
		i2_stall_long_Exec_out <= i2_stall_long;
		i2_MR_Exec_out <= i2_MR;
		i2_MW_Exec_out <= i2_MW;
-----------------------------------------------------------Flags Logic !!!!!!!!!!!!!!!!!!!! hal lw 3mlt inc w dec ll sp l flags tt8yr ??!!!
flags_1 <= alu_2_flags when i2_alu_op = "00001" or i2_alu_op = "00010" or i2_alu_op = "00011" or i2_alu_op = "00100" or i2_alu_op = "00101"
	or i2_alu_op = "01000"or i2_alu_op = "01001"or i2_alu_op = "01010"or i2_alu_op = "01011"or i2_alu_op = "01100"or i2_alu_op = "01101"
	or i2_alu_op = "10000"or i2_alu_op = "10001"

else alu_1_flags when i1_alu_op = "00001" or i1_alu_op = "00010" or i1_alu_op = "00011" or i1_alu_op = "00100" or i1_alu_op = "00101"
	or i1_alu_op = "01000"or i1_alu_op = "01001"or i1_alu_op = "01010"or i1_alu_op = "01011"or i1_alu_op = "01100"or i1_alu_op = "01101"
	or i1_alu_op = "10000"or i1_alu_op = "10001"
else "000" when i1_alu_op = "11000" or i1_alu_op = "11001" or i1_alu_op = "11010" or i2_alu_op = "11000" or i2_alu_op = "11001" or i2_alu_op = "11010";
------------------------------------------------------------	
flags_2 <= flags_1(2)&flags_1(1)&'0' when i2_alu_op = "11000"
else flags_1(1)&'0'&flags_1(0) when i2_alu_op ="11001"
else '0' & flags_1(1)&flags_1(0)when i2_alu_op ="11010"
-----------------------------
else flags_1(2)&flags_1(1)&'0' when i1_alu_op = "11000"
else flags_1(1)&'0'&flags_1(0) when i1_alu_op ="11001"
else '0' & flags_1(1)&flags_1(0)when i1_alu_op ="11010";
----------------------------------------------------------------------
flags <= flags_2 when i1_alu_op = "11000" or i1_alu_op = "11001" or i1_alu_op = "11010" or 
					  i2_alu_op = "11000" or i2_alu_op = "11001" or i2_alu_op = "11010"
else flags_1;

END a_EXECUTE;