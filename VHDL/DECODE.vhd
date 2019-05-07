LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
--------------------------------
ENTITY DECODE IS
	PORT (
	clk ,rst :in std_logic;
    --this data is directly from ir buffer 
 	 i1_opcode : in std_logic_vector(1 DOWNTO 0);
	i1_function: in std_logic_vector(2 DOWNTO 0);
	i1_Rsrc_in : in std_logic_vector(3 DOWNTO 0);
	i1_Rdst_in : in std_logic_vector(3 DOWNTO 0);
	i1_WB_data : in std_logic_vector(15 downto 0);
	i1_WB_Rdst : in std_logic_vector(3 downto 0);
	i1_WB_signal : in std_logic;
	--------------------------------------------
	i2_opcode : in std_logic_vector(1 DOWNTO 0);
	i2_function: in std_logic_vector(2 DOWNTO 0);
	i2_Rsrc_in : in std_logic_vector(3 DOWNTO 0);
  	i2_Rdst_in : in std_logic_vector(3 DOWNTO 0);
	i2_WB_data : in std_logic_vector(15 downto 0);
	i2_WB_Rdst : in std_logic_vector(3 downto 0);
	i2_WB_signal : in std_logic;	
    --this data is output of entitys below 
    -- connected to the decode execute buffer 
  i1_Rdst_out: out std_logic_vector(3 DOWNTO 0);
	i1_Rsrc_out: out std_logic_vector(3 DOWNTO 0);
	i1_branch_taken : out std_logic;
	i1_load_use : out std_logic;
	i1_Rsrc_data: out std_logic_vector(15 DOWNTO 0);
	i1_Rdst_data: out std_logic_vector(15 DOWNTO 0);
	i1_stall_long :out std_logic;
	i1_WB :out std_logic;
	i1_MR:out std_logic;
	i1_MW :out std_logic;
	i1_alu_op :out std_logic_vector (4 downto 0);
	------------------------------------------------
	i2_Rdst_out: out std_logic_vector(3 DOWNTO 0);
	i2_Rsrc_out: out std_logic_vector(3 DOWNTO 0);
	i2_branch_taken : out std_logic;
	i2_load_use : out std_logic;
	i2_Rsrc_data: out std_logic_vector(15 DOWNTO 0);
	i2_Rdst_data:out std_logic_vector(15 DOWNTO 0);
	i2_stall_long :out std_logic;
	i2_WB :out std_logic;
	i2_MR:out std_logic;
	i2_MW :out std_logic;
	i2_alu_op : out std_logic_vector(4 downto 0);
	-----------------------------------------------memory sel data out
	MEM_sel : in std_logic_vector(3 downto 0) ;
	MEM_data : out std_logic_vector(15 downto 0);
	-------------------------------------------------in w out 
	IN_bus : in std_logic_vector (15 downto 0);
	OUT_bus : out std_logic_vector (15 downto 0) ;
	------------------------------------    
	i1_immediate : out std_logic;
	i2_immediate : out std_logic;
	------------------------------------------------hazard data 
	DEC_EXE_branch_taken_1	 :in std_logic;
	DEC_EXE_branch_taken_2 	:in std_logic;
	DEC_EXE_Memory_read_1 	:in std_logic;
	DEC_EXE_Memory_read_2 	:in std_logic;
	DEC_EXE_Rdst_1 			:in std_logic_vector(3 downto 0);
	DEC_EXE_Rdst_2 		    :in std_logic_vector(3 downto 0);
	flags 					: in std_logic_vector(2 downto 0);
	 ------------------------------------------out from hazard 
	hazard_data_out : out std_logic_vector(15 downto 0) ;
	PC_select_out : out std_logic_vector(2 downto 0) ;
	RST_IR_out : out std_logic;
	branch_taken_1_out : out std_logic;
	branch_taken_2_out : out std_logic;
	DEC_EXE_stall_lone_out  : out std_logic;
	DEC_EXE_stall_long_in   : in std_logic;

	-- MOAMEN
	i1_WB_Exec_in  : in std_logic;
  i2_WB_Exec_in  : in std_logic;
  i1_Rdst_Mem_in : in std_logic_vector(3 downto 0);
  i2_Rdst_Mem_in : in std_logic_vector(3 downto 0);
  i1_WB_Mem_in   : in std_logic;
  i2_WB_Mem_in   : in std_logic;


	-- RET
	ID_EXE_ret_flush_in   : out std_logic;
	ID_EXE_ret_flush_out  : in std_logic;
	EXE_MEM_ret_flush_out : in std_logic;
	MEM_WB_ret_flush_out  : in std_logic;
	ret_flush             : in std_logic;

	--pc 

	pc_out : in std_logic_vector(31 downto 0)
);
END DECODE;

ARCHITECTURE a_DECODE OF DECODE IS
------------------------------------from control unit
signal i1_Rsrc_in_regFile : std_logic_vector (3 downto 0);
signal i1_Rdst_in_regFile : std_logic_vector (3 downto 0);
signal i2_Rsrc_in_regFile : std_logic_vector (3 downto 0);
signal i2_Rdst_in_regFile : std_logic_vector (3 downto 0);
-----------------------------------------------------------hazar sel data out
signal	hazard_sel : std_logic_vector(3 downto 0) ;
signal	hazard_data : std_logic_vector(15 downto 0) ;
------------------------------------------
signal i1_flush :std_logic; --from hazard
signal i2_flush:std_logic;
---------------------------------------
signal i1_IN_signal   :std_logic;
signal i1_OUT_signal  :std_logic;
signal i2_IN_signal   :std_logic;
signal i2_OUT_signal  :std_logic;
---------------------------------------
signal clear_first  : std_logic;			
signal clear_second 	: std_logic;		
signal RST_IR   		: std_logic;		
signal PC_select 		: std_logic_vector(2 downto 0);
signal reg_file_select    : std_logic_vector (3 downto 0);
signal structural_hazard  : std_logic;  
signal branch_taken_1      : std_logic;   
signal branch_taken_2      : std_logic; 
-----------------------------
signal SIG_ID_EXE_late_flush : std_logic;
signal SIG_late_flush_ID_EXE : std_logic;
---------------
signal  PP_signal :std_logic_vector(1 downto 0);
signal  PP_signal_useless :std_logic_vector(1 downto 0);
------

BEGIN

i1_stall_long <= clear_first;
i2_stall_long <= clear_second;

DEC_EXE_stall_lone_out  <= SIG_late_flush_ID_EXE;
SIG_ID_EXE_late_flush   <=DEC_EXE_stall_long_in;

---------------------- control unit instr 1
controli1_unit:entity work.Control_Unit port map (
opcode => i1_opcode,
func => i1_function,
Rsrc => i1_Rsrc_in,
Rdst => i1_Rdst_in,
AluFunc => i1_alu_op,
src => i1_Rsrc_out,
dest => i1_Rdst_out,
WB => i1_WB,
MR => i1_MR,
Mw => i1_MW,
regOut1 => i1_Rsrc_in_regFile,
regOut2 => i1_Rdst_in_regFile,
flush => clear_first, 
IN_signal => i1_IN_signal,
OUT_signal => i1_OUT_signal,
immediate => i1_immediate,
PP_signal => PP_signal,
branch_taken => branch_taken_1
);
---------------------- control unit instr 2		
controli2_unit:entity work.Control_Unit  port map (
opcode => i2_opcode,
func => i2_function,
Rsrc => i2_Rsrc_in,
Rdst => i2_Rdst_in,
AluFunc => i2_alu_op,
src => i2_Rsrc_out,
dest => i2_Rdst_out,
WB => i2_WB,
MR => i2_MR,
Mw => i2_MW,
regOut1 => i2_Rsrc_in_regFile,
regOut2 => i2_Rdst_in_regFile,
flush => clear_second,
IN_signal => i2_IN_signal,
OUT_signal => i2_OUT_signal,
immediate => i2_immediate,
PP_signal => PP_signal_useless,
branch_taken => branch_taken_2

);		
-------------------------- Register file  

Register_file:entity work.Register_file  generic map (16) port map (
clk , rst ,
i1_Rsrc_in_regFile ,
i1_Rdst_in_regFile ,
i1_Rsrc_data ,
i1_Rdst_data , 
i1_WB_data ,
i1_WB_Rdst, 
i1_WB_signal,
i2_Rsrc_in_regFile , 
i2_Rdst_in_regFile , 
i2_Rsrc_data , 
i2_Rdst_data, 
i2_WB_data ,
i2_WB_Rdst,
i2_WB_signal,
reg_file_select,
hazard_data , 
MEM_sel ,
MEM_data,
IN_bus,
OUT_bus,
pp_signal,
pc_out
 );
-----------------------------hazard detection and its connection 
hazard : entity work.hazard_unit port map 
(
	TEMP_IF_ID_opCode1 		 => i1_opcode,
	TEMP_IF_ID_func1 		 => i1_function,
	TEMP_IF_ID_Rsrc1 		 => i1_Rsrc_in, 
	TEMP_IF_ID_Rdst1 		 => i1_Rdst_in, 
	TEMP_IF_ID_opCode2 		 => i2_opcode,
	TEMP_IF_ID_func2 		 => i2_function,
	TEMP_IF_ID_Rsrc2 		 => i2_Rsrc_in, 
	TEMP_IF_ID_Rdst2 		 => i2_Rdst_in,
	ID_EXE_branch_taken1 => DEC_EXE_branch_taken_1,
	ID_EXE_branch_taken2 => DEC_EXE_branch_taken_2,
	ID_EXE_MemoryRead1 	 => DEC_EXE_Memory_read_1 ,
	ID_EXE_MemoryRead2 	 => DEC_EXE_Memory_read_2 ,
	ID_EXE_Rdst1 		 => DEC_EXE_Rdst_1 ,			
	ID_EXE_Rdst2 		 => DEC_EXE_Rdst_2 ,

	ID_EXE_WB1    => i1_WB_Exec_in  ,
	ID_EXE_WB2    => i2_WB_Exec_in  ,
	EXE_MEM_Rdst1 => i1_Rdst_Mem_in ,
	EXE_MEM_Rdst2 => i2_Rdst_Mem_in ,
	EXE_MEM_WB1   => i1_WB_Mem_in   ,
	EXE_MEM_WB2   => i2_WB_Mem_in   ,

	MEM_WB_Rdst1 		 => i1_WB_Rdst,
	MEM_WB_Rdst2 		 => i2_WB_Rdst,
	MEM_WB_WB1 		     => i1_WB_signal,
	MEM_WB_WB2 		     => i2_WB_signal,
	flags 				 => flags,
	ID_EXE_late_flush 	 => SIG_ID_EXE_late_flush, -- from output buffer
	clear_first 		 => clear_first ,
	clear_second 		 => clear_second,
	RST_IR 				 => RST_IR,
	PC_selector 		 => PC_select,
	new_address 		 => reg_file_select,  
	structural_hazard 	 => structural_hazard,
	branch_taken1 		 => branch_taken_1,
	branch_taken2 		 => branch_taken_2,
	late_flush_ID_EXE    => SIG_late_flush_ID_EXE,      -- to be put in the DEC_EXE buffer

	ID_EXE_ret_flush_in => ID_EXE_ret_flush_in,
	ID_EXE_ret_flush_out => ID_EXE_ret_flush_out,
	EXE_MEM_ret_flush_out => EXE_MEM_ret_flush_out,
	MEM_WB_ret_flush_out => MEM_WB_ret_flush_out,
	ret_flush => ret_flush
);

  -- output signals  
  hazard_data_out <=  hazard_data;
  PC_select_out <= PC_select;
  RST_IR_out <= RST_IR;
  branch_taken_1_out <= branch_taken_1;
  branch_taken_2_out <= branch_taken_1;

END architecture;