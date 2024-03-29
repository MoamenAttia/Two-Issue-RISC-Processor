LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
-------------------------------------
ENTITY system IS
     PORT(
		  clk,rst : IN std_logic;
		  En : in std_logic;
		  IN_bus : in std_logic_vector (15 downto 0);
		  OUT_bus_data : out std_logic_vector (15 downto 0);
		  interupt : in std_logic   -- to decode file 
		  );
END system;
----------------------------------------
ARCHITECTURE my_system OF system IS
------------------------------------------signals connecting each componant
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
signal	i1_OUT_DEC_out : std_logic;
signal	i1_Rsrc_data_DEC_out: std_logic_vector(15 DOWNTO 0);
signal	i1_Rdst_data_DEC_out: std_logic_vector(15 DOWNTO 0);
signal	i1_stall_long_DEC_out : std_logic := '0';
signal	i1_WB_DEC_out : std_logic;
signal	i1_MR_DEC_out:std_logic;
signal	i1_MW_DEC_out : std_logic;
signal	i1_alu_op_DEC_out : std_logic_vector (4 downto 0);
	------------------------------------------------
signal	i2_Rdst_DEC_out: std_logic_vector(3 DOWNTO 0);
signal	i2_Rsrc_DEC_out: std_logic_vector(3 DOWNTO 0);
signal	i2_branch_taken_DEC_out : std_logic;
signal	i2_OUT_DEC_out :  std_logic;
signal	i2_Rsrc_data_DEC_out:  std_logic_vector(15 DOWNTO 0);
signal	i2_Rdst_data_DEC_out:std_logic_vector(15 DOWNTO 0);
signal	i2_stall_long_DEC_out : std_logic;
signal	i2_WB_DEC_out : std_logic;
signal	i2_MR_DEC_out:std_logic;
signal	i2_MW_DEC_out : std_logic;
signal	i2_alu_op_DEC_out :  std_logic_vector(4 downto 0);
------------------------------------------------------------------Execute Input
signal	i1_Rdst_Exec_in: std_logic_vector(3 DOWNTO 0);
signal	i1_Rsrc_Exec_in:  std_logic_vector(3 DOWNTO 0);
signal	i1_branch_taken_Exec_in :  std_logic;
signal	i1_OUT_Exec_in :  std_logic;
signal	i1_Rsrc_data_Exec_in:  std_logic_vector(15 DOWNTO 0);
signal	i1_Rdst_data_Exec_in:  std_logic_vector(15 DOWNTO 0);
signal	i1_stall_long_Exec_in : std_logic;
signal	i1_WB_Exec_in : std_logic;
signal	i1_MR_Exec_in : std_logic;
signal	i1_MW_Exec_in : std_logic;
signal	i1_alu_op_Exec_in: std_logic_vector (4 downto 0);
---------- flags
signal flags : std_logic_vector(2 downto 0);
	------------------------------------------------
signal	i2_Rdst_Exec_in:  std_logic_vector(3 DOWNTO 0);
signal	i2_Rsrc_Exec_in:  std_logic_vector(3 DOWNTO 0);
signal	i2_branch_taken_Exec_in :  std_logic;
signal	i2_OUT_Exec_in :  std_logic;
signal	i2_Rsrc_data_Exec_in:  std_logic_vector(15 DOWNTO 0);
signal	i2_Rdst_data_Exec_in:  std_logic_vector(15 DOWNTO 0);
signal	i2_stall_long_Exec_in : std_logic;
signal	i2_WB_Exec_in : std_logic;
signal	i2_MR_Exec_in : std_logic;
signal	i2_MW_Exec_in : std_logic;
signal	i2_alu_op_Exec_in: std_logic_vector (4 downto 0);
-------------------------------------------------------------------Execute Outputs 
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
-------------------------------------------------------------------Execute Memory Buffer outputs
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
-------------------------------------------------------------------MEMORY OUTPUTS
signal	i1_Rdst_MEM_out : std_logic_vector (3 downto 0);
signal	i1_WB_MEM_out 	: std_logic;
signal	i1_MR_MEM_out 	: std_logic;
signal	i1_stall_long_MEM_out 	: std_logic;
signal	i1_result_MEM_out	: std_logic_vector (15 downto 0 );
signal	i2_Rdst_MEM_out 		: std_logic_vector (3 downto 0);
signal	i2_WB_MEM_out 	: std_logic;
signal	i2_MR_MEM_out 	: std_logic;
signal	i2_stall_long_MEM_out 	: std_logic;
signal	i2_result_MEM_out 	: std_logic_vector (15 downto 0);
----------------------------------------------------------------- mem write back buffer outputs
signal 	i1_Rdst_WB_out : std_logic_vector (3 downto 0);
signal 	i1_WB_WB_out : std_logic;
signal 	i1_MR_WB_out :  std_logic;
signal 	i1_stall_long_WB_out : std_logic;
signal 	i1_result_WB_out : std_logic_vector (15 downto 0);
--------------------------------------------------------------
signal 	i2_Rdst_WB_out : std_logic_vector (3 downto 0);
signal 	i2_WB_WB_out : std_logic;
signal 	i2_MR_WB_out : std_logic;
signal 	i2_stall_long_WB_out : std_logic;
signal 	i2_result_WB_out : std_logic_vector (15 downto 0);
-----------------------------------------------------immediate from control unit
signal i1_immediate :std_logic;
signal i2_immediate :std_logic;
----------------------------------------------------signal for immediate
signal immediate_op : std_logic_vector(15 downto 0);
signal i1_source_dec_out: std_logic_vector(15 downto 0);
-------- out
signal OUT_bus :  std_logic_vector (15 downto 0);
-- MOAMEN MAGIC BIT
signal late_stall_long_in  :  std_logic;
signal late_stall_long_out :  std_logic;
-----------------------hazard out 
signal hazard_data_out : std_logic_vector(15 downto 0) ;
signal PC_select_out : std_logic_vector(2 downto 0) ;
signal RST_IR_out : std_logic;
signal branch_taken_1 : std_logic;
signal branch_taken_2 :std_logic;       
-----
signal hard_address :std_logic_vector(31 downto 0) ;
--------------------------------------------------

-- MOAMEN to be added to hazard unit

signal ID_EXE_ret_flush_in  : std_logic;
signal ID_EXE_ret_flush_out : std_logic;
signal EXE_MEM_ret_flush_out : std_logic;
signal MEM_WB_ret_flush_out : std_logic;
signal ret_flush : std_logic;


-- PC
signal pc_wb : std_logic;
signal pc_rdst_wb : std_logic_vector(3 downto 0);
signal pc_rdst_data : std_logic_vector(15 downto 0);

BEGIN

----------------------------------------------------fetch ---------  fetch & pc & ir
fetch:entity work.FETCH  port map (clk, rst , pc_out ,i1 ,i2);
ir_input <= i1&i2;
-------------------------------------------------------------------IR 
IR_BUFFER:entity work.IR_Buffer  generic map (32) port map (
	clk_inv,  rst , 
	ir_input,
	i1_opcode ,
	i1_function ,
	i1_Rsrc ,
	i1_Rdst,
	i2_opcode,
	i2_function,
	i2_Rsrc,
	i2_Rdst,
	En,
	immediate_op
	); 
-----------------------------------------------------------------PC

-- HAZARD 
hard_address <= x"0000" & hazard_data_out;
pc:entity work.PC port map (clk_inv,  rst ,hard_address ,pc_out ,PC_select_out , i1, i1_WB_WB_out, i1_Rdst_WB_out, i1_result_WB_out, i2_WB_WB_out, i2_Rdst_WB_out, i2_result_WB_out);
---------------------------------------------------decode --------decode 
out_bus_data <= out_bus ;
deocode : entity work.DECODE PORT map  (
	clk ,rst,
    i1_opcode ,
	i1_function,
	i1_Rsrc ,
	i1_Rdst ,
	i1_result_WB_out ,  -- from last buffer
	i1_Rdst_WB_out,
	i1_WB_WB_out,
	---------------
	i2_opcode,
	i2_function,
	i2_Rsrc,
        i2_Rdst,
	i2_result_WB_out ,  -- from last buffer
	i2_Rdst_WB_out ,
	i2_WB_WB_out,
	---------------
    i1_Rdst_DEC_out,
	i1_Rsrc_DEC_out,
	i1_branch_taken_DEC_out,
	i1_OUT_DEC_out ,
	i1_Rsrc_data_DEC_out,
	i1_Rdst_data_DEC_out,
	i1_stall_long_DEC_out ,
	i1_WB_DEC_out ,
	i1_MR_DEC_out,
	i1_MW_DEC_out,
	i1_alu_op_DEC_out,
	---------------------
	i2_Rdst_DEC_out,
	i2_Rsrc_DEC_out,
	i2_branch_taken_DEC_out,
	i2_OUT_DEC_out ,
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
	OUT_bus ,      ----- to in and out circuit
	i1_immediate,
	i2_immediate,
	-----------------------to hazard 
	i1_branch_taken_Exec_in	, 
	i2_branch_taken_Exec_in ,	
	i1_MR_Exec_in ,	
	i2_MR_Exec_in ,	
	i1_Rdst_Exec_in, 			
	i2_Rdst_Exec_in ,		   
	flags ,	

	--------------from hazard 
	hazard_data_out, 
	PC_select_out ,
	RST_IR_out ,
	branch_taken_1, 
	branch_taken_2 ,
	late_stall_long_in,
	late_stall_long_out,

	-- MOAMEN
	i1_WB_Exec_in,
    i2_WB_Exec_in,
    i1_Rdst_Mem_in,
    i2_Rdst_Mem_in,
    i1_WB_Mem_in,
    i2_WB_Mem_in,

	-- RETI
	ID_EXE_ret_flush_in, 
	ID_EXE_ret_flush_out,
	EXE_MEM_ret_flush_out,
	MEM_WB_ret_flush_out,
	ret_flush,
	pc_out

    );
 ----------------------------------------buffer decode/execute     
	--immediate logic
	i1_source_dec_out <= i1_Rsrc_data_DEC_out when i1_immediate = '0'
	else immediate_op when i1_immediate = '1';
dec_exec_BUFFER:entity work.Decode_Execute_Buffer port map (
	clk_inv,  rst , 
	late_stall_long_in,
	late_stall_long_out,
    i1_Rdst_DEC_out,
	i1_Rsrc_DEC_out,
	branch_taken_1,
	i1_OUT_DEC_out ,
	i1_source_dec_out,
	i1_Rdst_data_DEC_out,
	i1_stall_long_DEC_out ,  -- stall_long_output
	i1_WB_DEC_out ,
	i1_MR_DEC_out,
	i1_MW_DEC_out,
	i1_alu_op_DEC_out,
	---------------------
	i2_Rdst_DEC_out,
	i2_Rsrc_DEC_out,
	branch_taken_2,
	i2_OUT_DEC_out ,
	i2_Rsrc_data_DEC_out,
	i2_Rdst_data_DEC_out,
	i2_stall_long_DEC_out ,
	i2_WB_DEC_out,
	i2_MR_DEC_out,
	i2_MW_DEC_out ,
	i2_alu_op_DEC_out,
	--------------------- output
	i1_Rdst_Exec_in,
	i1_Rsrc_Exec_in,
	i1_branch_taken_Exec_in ,
	i1_OUT_Exec_in ,
	i1_Rsrc_data_Exec_in,
	i1_Rdst_data_Exec_in,
	i1_stall_long_Exec_in , -- stall_long_output
	i1_WB_Exec_in,
	i1_MR_Exec_in ,
	i1_MW_Exec_in ,
	i1_alu_op_Exec_in,
	----------------------
	i2_Rdst_Exec_in,
	i2_Rsrc_Exec_in,
	i2_branch_taken_Exec_in ,
	i2_OUT_Exec_in ,
	i2_Rsrc_data_Exec_in,
	i2_Rdst_data_Exec_in,
	i2_stall_long_Exec_in,
	i2_WB_Exec_in ,
	i2_MR_Exec_in ,
	i2_MW_Exec_in ,
	i2_alu_op_Exec_in,
	En,

	-- MOAMEN
	ID_EXE_ret_flush_in,
	ID_EXE_ret_flush_out
 );

 ------------------------------------------Execute
 -----------------------------------------
 Execute :entity work.EXECUTE port map (
 	i1_Rdst_Exec_in,
	i1_Rsrc_Exec_in,
	i1_branch_taken_Exec_in,
	i1_OUT_Exec_in ,
	i1_Rsrc_data_Exec_in,
	i1_Rdst_data_Exec_in,
	i1_stall_long_Exec_in ,
	i1_WB_Exec_in,
	i1_MR_Exec_in ,
	i1_MW_Exec_in ,
	i1_alu_op_Exec_in,
	-------------------
	i2_Rdst_Exec_in,
	i2_Rsrc_Exec_in,
	i2_branch_taken_Exec_in ,
	i2_OUT_Exec_in ,
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

 --------------------------
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
	flags
);


---------------------------------------- Exexcute/Memory Buffer
-------------------------------------------------------
exec_mem_BUFFER:entity work.Execute_Memory_Buffer port map ( 
	Clk_inv,Rst,
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
	----------------------
	i1_Rdst_Mem_in, 
	i1_WB_Mem_in,
	i1_stall_long_Mem_in,
	i1_MR_Mem_in,
	i1_MW_Mem_in,
	i1_alu_result_Mem_in ,
	--------------------
	i2_Rdst_Mem_in ,
	i2_WB_Mem_in,
	i2_stall_long_Mem_in,
	i2_MR_Mem_in,
	i2_MW_Mem_in,
	i2_alu_result_Mem_in ,
	En,
	-- MOAMEN
	ID_EXE_ret_flush_out,
	EXE_MEM_ret_flush_out
 );
 --------------------------- MEMORY
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
	------------------------outputs
	i1_Rdst_MEM_out,
	i1_WB_MEM_out ,
	i1_MR_MEM_out,
	i1_stall_long_MEM_out,
	i1_result_MEM_out,
	-------------------------
	i2_Rdst_MEM_out ,
	i2_WB_MEM_out ,
	i2_MR_MEM_out,
	i2_stall_long_MEM_out ,
	i2_result_MEM_out

 );
--------------------------------- MEMORY WRITE BACK BUFFER
mem_writeback :entity work.Memory_write_back_Buffer port map ( 
	-------------------------------------------- inputs
	clk_inv,rst,
	i1_Rdst_MEM_out,
	i1_WB_MEM_out ,
	i1_MR_MEM_out,
	i1_stall_long_MEM_out,
	i1_result_MEM_out ,
	---------------------
	i2_Rdst_MEM_out ,
	i2_WB_MEM_out ,
	i2_MR_MEM_out,
	i2_stall_long_MEM_out ,
	i2_result_MEM_out ,
	-------------------------- outputs
 	i1_Rdst_WB_out ,
 	i1_WB_WB_out ,
 	i1_MR_WB_out ,
 	i1_stall_long_WB_out ,
 	i1_result_WB_out ,
 	-------------------------
 	i2_Rdst_WB_out ,
 	i2_WB_WB_out ,
 	i2_MR_WB_out ,
 	i2_stall_long_WB_out ,
 	i2_result_WB_out ,
	En,
	EXE_MEM_ret_flush_out,
	MEM_WB_ret_flush_out
 );

 -- MOAMEN
ret_bit_flush : entity work.D_ff port map (
	 d   => MEM_WB_ret_flush_out,
	 clk => clk_inv,
	 rst => rst,
	 en  => '1',
	 q   => ret_flush
 );

END my_system;