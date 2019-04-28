LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

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
	MEM_data : out std_logic_vector(15 downto 0) 

    );
END DECODE;

ARCHITECTURE a_DECODE OF DECODE IS
signal i1_Rsrc_in_regFile : std_logic_vector (3 downto 0);
signal i1_Rdst_in_regFile : std_logic_vector (3 downto 0);

signal i2_Rsrc_in_regFile : std_logic_vector (3 downto 0);
signal i2_Rdst_in_regFile : std_logic_vector (3 downto 0);
------------------------------------------------------------------ hazar sel data out
signal	hazard_sel : std_logic_vector(3 downto 0) ;
signal	hazard_data : std_logic_vector(15 downto 0) ;
-----------------------------------------------------------
--  1.entity for hazard detection
--  2.entity for branch detection and calculation address 
--- 3.entity for reg file (done)
--  4.entity for control unit (done)
BEGIN
---------------------- control unit instr 1
controli1_unit:entity work.Control_Unit  generic map (32) port map (i1_opcode, i1_function,i1_Rsrc_in,i1_Rdst_in,
i1_alu_op,i1_Rsrc_out, i1_Rdst_out , i1_WB,i1_MR ,i1_MW , i1_Rsrc_in_regFile,i1_Rdst_in_regFile );

---------------------- control unit instr 2		
controli2_unit:entity work.Control_Unit  generic map (32) port map (i2_opcode, i2_function,i2_Rsrc_in,i2_Rdst_in,
i2_alu_op, i2_Rsrc_out,i2_Rdst_out , i2_WB,i2_MR ,i2_MW , i2_Rsrc_in_regFile,i2_Rdst_in_regFile);		
-------------------------- Register file  -------- '0' to be replaced by write back signal fro last buffer 
Register_file:entity work.Register_file  generic map (16) port map (clk , rst , i1_Rsrc_in_regFile , i1_Rdst_in_regFile , i1_Rsrc_data , i1_Rdst_data , i1_WB_data ,i1_WB_Rdst,
i1_WB_signal,i2_Rsrc_in_regFile , i2_Rdst_in_regFile , i2_Rsrc_data , i2_Rdst_data, i2_WB_data ,i2_WB_Rdst,i2_WB_signal,
hazard_sel, hazard_data , MEM_sel ,MEM_data);

END architecture;