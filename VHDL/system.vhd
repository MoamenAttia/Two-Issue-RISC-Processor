LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
ENTITY system IS
     PORT(
		  clk,rst : IN std_logic;
		  En : in std_logic;
		  IN_bus : in std_logic_vector (15 downto 0);
		  OUT_bus : out std_logic_vector (15 downto 0);
		  interupt : in std_logic   -- to decode file 
		  );
END system;

ARCHITECTURE my_system OF system IS
---------------------------------------signals connecting each componant
signal clk_inv :std_logic;
signal  i1,i2 : std_logic_vector(15 downto 0);
signal  pc_out : std_logic_vector(31 downto 0); -- input to fecth
signal  ir_input : std_logic_vector(31 downto 0);
------------------------------------ IR outputs
signal  i1_opcode :  std_logic_vector(1 DOWNTO 0);
signal	i1_function: std_logic_vector(2 DOWNTO 0);
signal	i1_Rsrc : std_logic_vector(3 DOWNTO 0);
signal	i1_Rdst : std_logic_vector(3 DOWNTO 0);
--------------------------------------------
signal	i2_opcode :  std_logic_vector(1 DOWNTO 0);
signal	i2_function:  std_logic_vector(2 DOWNTO 0);
signal	i2_Rsrc : std_logic_vector(3 DOWNTO 0);
signal	i2_Rdst : std_logic_vector(3 DOWNTO 0);
------------------------------------ -------------------------Decode outputs
signal	i1_Rdst_DEC_out:  std_logic_vector(3 DOWNTO 0);
signal	i1_Rsrc_DEC_out: std_logic_vector(3 DOWNTO 0);
signal	i1_branch_taken_DEC_out : std_logic;
signal	i1_load_use_DEC_out : std_logic;
signal	i1_Rsrc_data_DEC_out: std_logic_vector(15 DOWNTO 0);
signal	i1_Rdst_data_DEC_out: std_logic_vector(15 DOWNTO 0);
signal	i1_stall_long_DEC_out : std_logic;
signal	i1_WB_DEC_out : std_logic;
signal	i1_MR_DEC_out:std_logic;
signal	i1_MW_DEC_out : std_logic;
signal	i1_alu_op_DEC_out : std_logic_vector (4 downto 0);
	------------------------------------------------
signal	i2_Rdst_DEC_out: std_logic_vector(3 DOWNTO 0);
signal	i2_Rsrc_DEC_out: std_logic_vector(3 DOWNTO 0);
signal	i2_branch_taken_DEC_out : std_logic;
signal	i2_load_use_DEC_out :  std_logic;
signal	i2_Rsrc_data_DEC_out:  std_logic_vector(15 DOWNTO 0);
signal	i2_Rdst_data_DEC_out:std_logic_vector(15 DOWNTO 0);
signal	i2_stall_long_DEC_out : std_logic;
signal	i2_WB_DEC_out : std_logic;
signal	i2_MR_DEC_out:std_logic;
signal	i2_MW_DEC_out : std_logic;
signal	i2_alu_op_DEC_out :  std_logic_vector(4 downto 0);
------------------------------------------------------------------- Execute Input
signal	i1_Rdst_Exec_in: std_logic_vector(3 DOWNTO 0);
signal	i1_Rsrc_Exec_in:  std_logic_vector(3 DOWNTO 0);
signal	i1_branch_taken_Exec_in :  std_logic;
signal	i1_load_use_Exec_in :  std_logic;
signal	i1_Rsrc_data_Exec_in:  std_logic_vector(15 DOWNTO 0);
signal	i1_Rdst_data_Exec_in:  std_logic_vector(15 DOWNTO 0);
signal	i1_stall_long_Exec_in : std_logic;
signal	i1_WB_Exec_in : std_logic;
signal	i1_MR_Exec_in : std_logic;
signal	i1_MW_Exec_in : std_logic;
signal	i1_alu_op_Exec_in: std_logic_vector (4 downto 0);
	------------------------------------------------
signal	i2_Rdst_Exec_in:  std_logic_vector(3 DOWNTO 0);
signal	i2_Rsrc_Exec_in:  std_logic_vector(3 DOWNTO 0);
signal	i2_branch_taken_Exec_in :  std_logic;
signal	i2_load_use_Exec_in :  std_logic;
signal	i2_Rsrc_data_Exec_in:  std_logic_vector(15 DOWNTO 0);
signal	i2_Rdst_data_Exec_in:  std_logic_vector(15 DOWNTO 0);
signal	i2_stall_long_Exec_in : std_logic;
signal	i2_WB_Exec_in : std_logic;
signal	i2_MR_Exec_in : std_logic;
signal	i2_MW_Exec_in : std_logic;
signal	i2_alu_op_Exec_in: std_logic_vector (4 downto 0);

---------------forward signals---------------- 
--signal	ex_mem_regWrite_1_Exec_in         :  STD_LOGIC;
--signal	ex_mem_registerRd_1_Exec_in       :  STD_LOGIC_VECTOR(3 downto 0);
--signal	mem_wb_regWrite_1_Exec_in         :  STD_LOGIC;
--signal	mem_wb_registerRd_1_Exec_in 	  :  STD_LOGIC_VECTOR(3 downto 0);
--signal	ex_mem_regWrite_2_Exec_in         :  STD_LOGIC;
--signal	ex_mem_registerRd_2_Exec_in       :  STD_LOGIC_VECTOR(3 downto 0);
--signal	mem_wb_regWrite_2_Exec_in         :  STD_LOGIC;
--signal	mem_wb_registerRd_2_Exec_in 	  :  STD_LOGIC_VECTOR(3 downto 0);
--signal	ex_mem_Rd_data_out_1_Exec_in	  : std_logic_vector(15 downto 0);
--signal	mem_wb_Rd_data_out_1_Exec_in	  : std_logic_vector(15 downto 0);
--
--signal	ex_mem_Rd_data_out_2_Exec_in	  : std_logic_vector(15 downto 0);
--signal	mem_wb_Rd_data_out_2_Exec_in	  : std_logic_vector(15 downto 0);
------------------------------------------------------------------------------------------ Execute Outputs 
signal	i1_Rdst_Exec_out : std_logic_vector (3 downto 0);
signal	i1_WB_Exec_out : std_logic;
signal	i1_stall_long_Exec_out : std_logic;
signal	i1_MR_Exec_out : std_logic;
signal	i1_MW_Exec_out : std_logic;
signal	i1_alu_result_Exec_out : std_logic_vector (15 downto 0);
	--------------------------------------
signal	i2_Rdst_Exec_out : std_logic_vector (3 downto 0);
signal	i2_WB_Exec_out : std_logic;
signal	i2_stall_long_Exec_out : std_logic;
signal	i2_MR_Exec_out : std_logic;
signal	i2_MW_Exec_out : std_logic;
signal	i2_alu_result_Exec_out : std_logic_vector (15 downto 0);
signal  MEM_sel : std_logic_vector (3 downto 0);
signal  MEM_data : std_logic_vector (15 downto 0);
----------------------------------------------------------------------------------  Execute Memory Buffer outputs
signal	i1_Rdst_Mem_in : std_logic_vector (3 downto 0);
signal	i1_WB_Mem_in : std_logic;
signal	i1_stall_long_Mem_in : std_logic;
signal	i1_MR_Mem_in : std_logic;
signal	i1_MW_Mem_in : std_logic;
signal	i1_alu_result_Mem_in : std_logic_vector (15 downto 0);
--------------------------------------
signal	i2_Rdst_Mem_in : std_logic_vector (3 downto 0);
signal	i2_WB_Mem_in : std_logic;
signal	i2_stall_long_Mem_in : std_logic;
signal	i2_MR_Mem_in : std_logic;
signal	i2_MW_Mem_in : std_logic;
signal	i2_alu_result_Mem_in : std_logic_vector (15 downto 0);
-------------------------------------------------------------------------------------- MEMORY OUTPUTS
SIGNAL	i1_Rdst_MEM_out : std_logic_vector (3 downto 0);
SIGNAL	i1_WB_MEM_out 	: std_logic;
SIGNAL	i1_MR_MEM_out 	: std_logic;
SIGNAL	i1_stall_long_MEM_out 	: std_logic;
SIGNAL	i1_result_MEM_out	: std_logic_vector (15 downto 0);

SIGNAL	i2_Rdst_MEM_out 		: std_logic_vector (3 downto 0);
SIGNAL	i2_WB_MEM_out 	: std_logic;
SIGNAL	i2_MR_MEM_out 	: std_logic;
SIGNAL	i2_stall_long_MEM_out 	: std_logic;
SIGNAL	i2_result_MEM_out 	: std_logic_vector (15 downto 0);

------------------------------------------------------------------------------------------ mem write back buffer outputs
signal 	i1_Rdst_WB_out : std_logic_vector (3 downto 0);
signal 	i1_WB_WB_out : std_logic;
signal 	i1_MR_WB_out :  std_logic;
signal 	i1_stall_long_WB_out : std_logic;
signal 	i1_result_WB_out : std_logic_vector (15 downto 0);

 	--------------------------------------
signal 	i2_Rdst_WB_out : std_logic_vector (3 downto 0);
signal 	i2_WB_WB_out : std_logic;
signal 	i2_MR_WB_out : std_logic;
signal 	i2_stall_long_WB_out : std_logic;
signal 	i2_result_WB_out : std_logic_vector (15 downto 0);
--------------------------------------------------------------------------------------
BEGIN----------------------------------------------
----------------------------------------------------fetch ---------  fetch & pc & ir
fetch:entity work.FETCH  port map (clk, pc_out ,i1 ,i2);
ir_input <= i1&i2;
IR_BUFFER:entity work.IR_Buffer  generic map (32) port map (clk,  rst , ir_input,
i1_opcode ,i1_function , i1_Rsrc ,i1_Rdst,i2_opcode,i2_function,i2_Rsrc,i2_Rdst,En); --enable IR to be changed
pc:entity work.PC  generic map (32) port map (clk,  rst ,x"00000000" ,pc_out ,"000");-- HAZARD !! sel to be changed , in_address to be changed 
---------------------------------------------------decode --------decode 
--------------------------------------------------------------
deocode : entity work.DECODE PORT map  (
	clk ,rst,
    --this data is directly from ir buffer 
    i1_opcode ,
	i1_function,
	i1_Rsrc ,
	i1_Rdst ,
	i1_result_WB_out ,  -- from last buffer
	i1_Rdst_WB_out,
	i1_WB_WB_out,
	--------------------------------------------
	i2_opcode,
	i2_function,
	i2_Rsrc ,
     i2_Rdst ,
	i2_result_WB_out ,  -- from last buffer
	i2_Rdst_WB_out ,
	i2_WB_WB_out,
	---------------
    i1_Rdst_DEC_out,
	i1_Rsrc_DEC_out,
	i1_branch_taken_DEC_out,
	i1_load_use_DEC_out ,
	i1_Rsrc_data_DEC_out,
	i1_Rdst_data_DEC_out,
	i1_stall_long_DEC_out ,
	i1_WB_DEC_out ,
	i1_MR_DEC_out,
	i1_MW_DEC_out,
	i1_alu_op_DEC_out,
	------------------------------------------------
	i2_Rdst_DEC_out,
	i2_Rsrc_DEC_out,
	i2_branch_taken_DEC_out,
	i2_load_use_DEC_out ,
	i2_Rsrc_data_DEC_out,
	i2_Rdst_data_DEC_out,
	i2_stall_long_DEC_out ,
	i2_WB_DEC_out,
	i2_MR_DEC_out,
	i2_MW_DEC_out ,
	i2_alu_op_DEC_out,
	--------
	MEM_sel,
	MEM_data,   ---- to memory stage for store 
	----------
	IN_bus,
	OUT_bus       ----- to in and out circuit

    );
 ----------------------------------------buffer decode/execute
 -------------------------------------------------------------------
dec_exec_BUFFER:entity work.Decode_Execute_Buffer port map (
	clk,  rst , 
    i1_Rdst_DEC_out,
	i1_Rsrc_DEC_out,
	i1_branch_taken_DEC_out,
	i1_load_use_DEC_out ,
	i1_Rsrc_data_DEC_out,
	i1_Rdst_data_DEC_out,
	i1_stall_long_DEC_out ,
	i1_WB_DEC_out ,
	i1_MR_DEC_out,
	i1_MW_DEC_out,
	i1_alu_op_DEC_out,
	------------------------------------------------
	i2_Rdst_DEC_out,
	i2_Rsrc_DEC_out,
	i2_branch_taken_DEC_out,
	i2_load_use_DEC_out ,
	i2_Rsrc_data_DEC_out,
	i2_Rdst_data_DEC_out,
	i2_stall_long_DEC_out ,
	i2_WB_DEC_out,
	i2_MR_DEC_out,
	i2_MW_DEC_out ,
	i2_alu_op_DEC_out,
	-------------------------------------------- output
	i1_Rdst_Exec_in,
	i1_Rsrc_Exec_in,
	i1_branch_taken_Exec_in ,
	i1_load_use_Exec_in ,
	i1_Rsrc_data_Exec_in,
	i1_Rdst_data_Exec_in,
	i1_stall_long_Exec_in ,
	i1_WB_Exec_in,
	i1_MR_Exec_in ,
	i1_MW_Exec_in ,
	i1_alu_op_Exec_in,
	------------------------------------------------
	i2_Rdst_Exec_in,
	i2_Rsrc_Exec_in,
	i2_branch_taken_Exec_in ,
	i2_load_use_Exec_in ,
	i2_Rsrc_data_Exec_in,
	i2_Rdst_data_Exec_in,
	i2_stall_long_Exec_in,
	i2_WB_Exec_in ,
	i2_MR_Exec_in ,
	i2_MW_Exec_in ,
	i2_alu_op_Exec_in,
	En
 );
 -------------------------------------------------------------------------------------- Execute
 -------------------------------------------------------------------------------
 Execute :entity work.EXECUTE port map (
 	i1_Rdst_Exec_in,
	i1_Rsrc_Exec_in,
	i1_branch_taken_Exec_in,
	i1_load_use_Exec_in ,
	i1_Rsrc_data_Exec_in,
	i1_Rdst_data_Exec_in,
	i1_stall_long_Exec_in ,
	i1_WB_Exec_in,
	i1_MR_Exec_in ,
	i1_MW_Exec_in ,
	i1_alu_op_Exec_in,
	------------------------------------------------
	i2_Rdst_Exec_in,
	i2_Rsrc_Exec_in,
	i2_branch_taken_Exec_in ,
	i2_load_use_Exec_in ,
	i2_Rsrc_data_Exec_in,
	i2_Rdst_data_Exec_in,
	i2_stall_long_Exec_in,
	i2_WB_Exec_in ,
	i2_MR_Exec_in ,
	i2_MW_Exec_in ,
	i2_alu_op_Exec_in,
	
	i1_WB_Mem_in     ,
	i1_Rdst_Mem_in, 
	i1_WB_WB_out     ,
 	i1_Rdst_WB_out ,
	i2_WB_Mem_in     ,
	i2_Rdst_Mem_in   ,
	i2_WB_WB_out     ,
	i2_Rdst_WB_out ,

	i1_alu_result_Mem_in,
	i1_result_WB_out,

	i2_alu_result_Mem_in,
	i2_result_WB_out  ,

 ------------------------------------------
	i1_Rdst_Exec_out ,
	i1_WB_Exec_out  ,
	i1_stall_long_Exec_out ,
	i1_MR_Exec_out ,
	i1_MW_Exec_out ,
	i1_alu_result_Exec_out ,
	-----------------------,
	i2_Rdst_Exec_out ,
	i2_WB_Exec_out ,
	i2_stall_long_Exec_out ,
	i2_MR_Exec_out,
	i2_MW_Exec_out ,
	i2_alu_result_Exec_out 
);
-------------------------------------------------------------- Exexcute/Memory Buffer
-----------------------------------------------------------------
exec_mem_BUFFER:entity work.Execute_Memory_Buffer port map ( 
	Clk,Rst,
	i1_Rdst_Exec_out ,
	i1_WB_Exec_out  ,
	i1_stall_long_Exec_out ,
	i1_MR_Exec_out ,
	i1_MW_Exec_out ,
	i1_alu_result_Exec_out ,
	-----------------------,
	i2_Rdst_Exec_out ,
	i2_WB_Exec_out ,
	i2_stall_long_Exec_out ,
	i2_MR_Exec_out,
	i2_MW_Exec_out ,
	i2_alu_result_Exec_out,
	-----------------------------------------------
	i1_Rdst_Mem_in, 
	i1_WB_Mem_in,
	i1_stall_long_Mem_in,
	i1_MR_Mem_in,
	i1_MW_Mem_in,
	i1_alu_result_Mem_in ,
	-------------------------
	i2_Rdst_Mem_in ,
	i2_WB_Mem_in,
	i2_stall_long_Mem_in,
	i2_MR_Mem_in,
	i2_MW_Mem_in,
	i2_alu_result_Mem_in ,
	En
 );
 ------------------------------------------------------------ MEMORY
clk_inv <= not(clk);
 MEM :entity work.MEMORY port map (
	clk , clk_inv ,rst , MEM_data, MEM_sel,
	i1_Rdst_Mem_in, 
	i1_WB_Mem_in,
	i1_stall_long_Mem_in,
	i1_MR_Mem_in,
	i1_MW_Mem_in,
	i1_alu_result_Mem_in ,
	-------------------------
	i2_Rdst_Mem_in ,
	i2_WB_Mem_in,
	i2_stall_long_Mem_in,
	i2_MR_Mem_in,
	i2_MW_Mem_in,
	i2_alu_result_Mem_in ,
	-------------------------------------------- outputs

	i1_Rdst_MEM_out,
	i1_WB_MEM_out ,
	i1_MR_MEM_out,
	i1_stall_long_MEM_out,
	i1_result_MEM_out,
	--------------------------------------
	i2_Rdst_MEM_out ,
	i2_WB_MEM_out ,
	i2_MR_MEM_out,
	i2_stall_long_MEM_out ,
	i2_result_MEM_out 
	
	
 );
---------------------------------------------------------------------------------- MEMORY WRITE BACK BUFFER
mem_writeback :entity work.Memory_write_back_Buffer port map ( 
	-------------------------------------------- inputs
	clk,rst,
	i1_Rdst_MEM_out,
	i1_WB_MEM_out ,
	i1_MR_MEM_out,
	i1_stall_long_MEM_out,
	i1_result_MEM_out ,
	--------------------------------------
	i2_Rdst_MEM_out ,
	i2_WB_MEM_out ,
	i2_MR_MEM_out,
	i2_stall_long_MEM_out ,
	i2_result_MEM_out ,
	--------------------------------------------- outputs
 	i1_Rdst_WB_out ,
 	i1_WB_WB_out ,
 	i1_MR_WB_out ,
 	i1_stall_long_WB_out ,
 	i1_result_WB_out ,
 	--------------------------------------
 	i2_Rdst_WB_out ,
 	i2_WB_WB_out ,
 	i2_MR_WB_out ,
 	i2_stall_long_WB_out ,
 	i2_result_WB_out ,
	En
 );
END my_system;