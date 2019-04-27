LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
ENTITY system IS
     PORT( clk,rst : IN std_logic;   q : OUT std_logic ; En : in std_logic);
END system;

ARCHITECTURE my_system OF system IS
signal instr_1,instr_2 : std_logic_vector(15 downto 0);
signal pc_out : std_logic_vector(31 downto 0);
signal ir_input : std_logic_vector(31 downto 0);
------------------------------------ IR outputs
signal  instr_1_opcode :  std_logic_vector(1 DOWNTO 0);
signal	instr_1_function: std_logic_vector(2 DOWNTO 0);
signal	instr_1_Rsrc : std_logic_vector(3 DOWNTO 0);
signal	instr_1_Rdst : std_logic_vector(3 DOWNTO 0);
--------------------------------------------
signal	instr_2_opcode :  std_logic_vector(1 DOWNTO 0);
signal	instr_2_function:  std_logic_vector(2 DOWNTO 0);
signal	instr_2_Rsrc : std_logic_vector(3 DOWNTO 0);
signal	instr_2_Rdst : std_logic_vector(3 DOWNTO 0);
------------------------------------ Decode outputs
signal	instr_1_Rdst_in:  std_logic_vector(3 DOWNTO 0);
signal	instr_1_Rsrc_in: std_logic_vector(3 DOWNTO 0);
signal	instr_1_branch_taken_in : std_logic;
signal	instr_1_load_use_in : std_logic;
signal	instr_1_Rsrc_data_in: std_logic_vector(15 DOWNTO 0);
signal	instr_1_Rdst_data_in: std_logic_vector(15 DOWNTO 0);
signal	instr_1_stall_long_in : std_logic;
signal	instr_1_write_back_in : std_logic;
signal	instr_1_mem_read_in:std_logic;
signal	instr_1_mem_write_in : std_logic;
signal	instr_1_alu_operation_in : std_logic_vector (4 downto 0);
	------------------------------------------------
signal	instr_2_Rdst_in: std_logic_vector(3 DOWNTO 0);
signal	instr_2_Rsrc_in: std_logic_vector(3 DOWNTO 0);
signal	instr_2_branch_taken_in : std_logic;
signal	instr_2_load_use_in :  std_logic;
signal	instr_2_Rsrc_data_in:  std_logic_vector(15 DOWNTO 0);
signal	instr_2_Rdst_data_in:std_logic_vector(15 DOWNTO 0);
signal	instr_2_stall_long_in : std_logic;
signal	instr_2_write_back_in : std_logic;
signal	instr_2_mem_read_in:std_logic;
signal	instr_2_mem_write_in : std_logic;
signal	instr_2_alu_operation_in :  std_logic_vector(4 downto 0);
-------------------------------------------------------------------
BEGIN
--------fetch ---------  fetch & pc & ir
fetch:entity work.FETCH  port map (clk, pc_out ,instr_1 ,instr_2);
ir_input <= instr_1&instr_2;
IR_BUFFER:entity work.IR_Buffer  generic map (32) port map (clk,  rst , ir_input,
instr_1_opcode ,instr_1_function , instr_1_Rsrc ,instr_1_Rdst,instr_2_opcode,instr_2_function,instr_2_Rsrc,instr_2_Rdst,'1'); --enable IR to be changed
pc:entity work.PC  generic map (32) port map (clk,  rst ,x"00000000" ,pc_out ,"000");-- sel to be changed , in_address to be changed 
-------decode --------decode 
d:entity work.DECODE   port map (clk,  rst , instr_1_opcode , instr_1_function  , instr_1_Rsrc , instr_1_Rdst  ,x"0000",x"0" ,
instr_2_opcode , instr_2_function , instr_2_Rsrc , instr_2_Rdst  ,x"0000",x"0", instr_1_Rdst_in,instr_1_Rsrc_in, instr_1_branch_taken_in ,instr_1_load_use_in,instr_1_Rsrc_data_in,instr_1_Rdst_data_in,  instr_1_stall_long_in,
 instr_1_write_back_in, instr_1_mem_read_in , instr_1_alu_operation_in , instr_2_Rdst_in, instr_2_Rsrc_in , instr_2_branch_taken_in, instr_2_load_use_in ,
instr_2_Rsrc_data_in, instr_2_Rdst_data_in , instr_2_stall_long_in , instr_2_write_back_in , instr_2_mem_read_in , instr_2_mem_write_in ,
instr_2_alu_operation_in);  -- these signals are from buffers 

END my_system;