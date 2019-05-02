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
	----------------------------------------------------------- memory sel data out
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


	 stall_long_in   : in std_logic
	
	----------------
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
signal i1_in_out_dest : std_logic_vector (3 downto 0);
signal i2_in_out_dest : std_logic_vector (3 downto 0);
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
signal stall_long_out : std_logic;

BEGIN

i1_stall_long <= stall_long_out;

---------------------- control unit instr 1
controli1_unit:entity work.Control_Unit port map (i1_opcode, i1_function,i1_Rsrc_in,i1_Rdst_in,
i1_alu_op,i1_Rsrc_out, i1_Rdst_out , i1_WB,i1_MR ,i1_MW , i1_Rsrc_in_regFile,i1_Rdst_in_regFile,clear_first -- 0 is the flush
 ,i1_IN_signal ,  i1_OUT_signal ,i1_in_out_dest,i1_immediate , structural_hazard);
---------------------- control unit instr 2		
controli2_unit:entity work.Control_Unit  port map (i2_opcode, i2_function,i2_Rsrc_in,i2_Rdst_in,
i2_alu_op, i2_Rsrc_out,i2_Rdst_out , i2_WB,i2_MR ,i2_MW , i2_Rsrc_in_regFile,i2_Rdst_in_regFile,clear_second
,i2_IN_signal ,  i2_OUT_signal ,i2_in_out_dest,i2_immediate,structural_hazard);	--0 is the flush	
-------------------------- Register file  -------- '0' to be replaced by write back signal fro last buffer 

Register_file:entity work.Register_file  generic map (16) port map (clk , rst ,
 i1_Rsrc_in_regFile , i1_Rdst_in_regFile , i1_Rsrc_data , i1_Rdst_data , i1_WB_data ,i1_WB_Rdst, i1_WB_signal,
 i2_Rsrc_in_regFile , i2_Rdst_in_regFile , i2_Rsrc_data , i2_Rdst_data, i2_WB_data ,i2_WB_Rdst,i2_WB_signal,
reg_file_select, hazard_data , 
MEM_sel ,MEM_data,
IN_bus,OUT_bus ,
i1_IN_signal ,i1_OUT_signal ,i2_IN_signal,i2_OUT_signal ,i1_in_out_dest,i2_in_out_dest);
-----------------------------hazard detection and its connection 
hazard : entity work.hazard_unit port map (
i1_opcode,
i1_function,
i1_Rsrc_in, 
i1_Rdst_in, 
i2_opcode,
i2_function,
i2_Rsrc_in, 
i2_Rdst_in,
------------branch taken 1 ,2 
DEC_EXE_branch_taken_1,
DEC_EXE_branch_taken_2,
DEC_EXE_Memory_read_1 ,
DEC_EXE_Memory_read_2 ,
DEC_EXE_Rdst_1 ,			
DEC_EXE_Rdst_2 ,
-------------	
i1_WB_Rdst,
i2_WB_Rdst,
i1_WB_signal,
i2_WB_signal,
flags,
stall_long_in,
----out 
clear_first ,
clear_second,
RST_IR  ,   ---out from here 
PC_select ,   -- out from here --
reg_file_select,  
structural_hazard,
branch_taken_1 ,   -- out  
branch_taken_2 , -- out 
i1_stall_long
);
  -- make output signals here 
  hazard_data_out <=  hazard_data;
  PC_select_out <= PC_select;
  RST_IR_out <= RST_IR;
  branch_taken_1_out <= branch_taken_1;
  branch_taken_2_out <= branch_taken_1;

END architecture;