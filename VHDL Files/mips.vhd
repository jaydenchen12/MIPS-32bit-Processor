library IEEE;
use IEEE.std_logic_1164.all;

entity mips is
    Port (
	   clk : in STD_LOGIC);
end mips;

architecture struct of mips is

component addshift4
    port (A: in std_logic_vector(31 downto 0);
	  C: out std_logic_vector(31 downto 0));
end component;

component add
    port (A,B: in std_logic_vector(31 downto 0);
	  C: out std_logic_vector(31 downto 0));
end component;

component alu_Reg
    port(clk: in std_logic;
         Input1:in std_logic_vector(31 downto 0);
         Input2:in std_logic_vector(31 downto 0);
         shAmt: in std_logic_vector(4 downto 0);
         aluControlSignal: in std_logic_vector(3 downto 0);
         ZeroOut: out std_logic;
         aluResult:out std_logic_vector(31 downto 0));
end component;

component ProgramCounter
    Port ( input : in  STD_LOGIC_VECTOR (31 downto 0);
           reset : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           output : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component SignExtend
    Port ( input : in  STD_LOGIC_VECTOR (15 downto 0);
           output : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component Mux32bit
    Port ( input0 : in  STD_LOGIC_VECTOR(31 downto 0);
           input1 : in 	STD_LOGIC_VECTOR(31 downto 0);
	   select0 : in STD_LOGIC;
           output : out  STD_LOGIC_VECTOR(31 downto 0));
end component;

component Mux5bit
    Port ( input0 : in  STD_LOGIC_VECTOR(4 downto 0);
           input1 : in 	STD_LOGIC_VECTOR(4 downto 0);
	   select0 : in STD_LOGIC;
           output : out  STD_LOGIC_VECTOR(4 downto 0));
end component;

component leftShifter
    Port ( input : in  STD_LOGIC_VECTOR (31 downto 0);           
	   output : out STD_LOGIC_VECTOR(31 downto 0));		
end component;

component instructionmem
   port ( read_addr: in STD_LOGIC_VECTOR (31 downto 0);
	  instruct : out STD_LOGIC_VECTOR (31 downto 0));
end component;

component aluControl
   port(clk: in std_logic;
        aluOp: in std_logic_vector(1 downto 0); 
        Instr: in std_logic_vector(5 downto 0); 
        aluControlInstr: out std_logic_vector(3 downto 0));
end component;

component and2
    Port ( input0 : in  STD_LOGIC;
	   input1 : in STD_LOGIC;
           output : out  STD_LOGIC);
end component;

component finalReg
    port (  ReadAddress1, ReadAddress2, writeAddress: in std_logic_vector(4 downto 0);
            write_data: in STD_LOGIC_VECTOR (31 downto 0);
	    clk,RegWrite: in STD_LOGIC;
	    read_data1: out STD_LOGIC_VECTOR (31 downto 0);
	    read_data2: out STD_LOGIC_VECTOR (31 downto 0));
end component;

component memory
    port (address, write_data: in STD_LOGIC_VECTOR (31 downto 0);
	  MemWrite, MemRead,ck: in STD_LOGIC;
	  read_data: out STD_LOGIC_VECTOR (31 downto 0));
end component;

component leftShifter26_28
    Port ( input : in  STD_LOGIC_VECTOR (25 downto 0);           
	   output : out STD_LOGIC_VECTOR(27 downto 0));		
end component;

component control
   port(Instr: in std_logic_vector(5 downto 0);
        RegDst,Jump,Branch,MemRead,MemtoReg,MemWrite,ALUSrc,RegWrite: out std_logic;
        ALUOp: out std_logic_vector(1 downto 0));
end component;

--STARTING COMPONENT SIGNAL DECLARING

-- MUX 32 out
signal mux1out:STD_LOGIC_VECTOR (31 downto 0);
signal mux2out:STD_LOGIC_VECTOR (31 downto 0);
signal mux3out:STD_LOGIC_VECTOR (31 downto 0);
signal mux4out:STD_LOGIC_VECTOR (31 downto 0);
-- Mux 5 out
signal mux5bitout:STD_LOGIC_VECTOR(4 downto 0);
-- Control Out
signal RegDst,Jump,Branch,MemRead,MemtoReg,MemWrite,ALUSrc,RegWrite:std_logic;
signal ALUOp : std_logic_vector(1 downto 0);
--addshift4 out
signal add4out:STD_LOGIC_VECTOR (31 downto 0);
-- PC out
signal pc_out:STD_LOGIC_VECTOR (31 downto 0);
-- instruction memory out
signal instr31_0:STD_LOGIC_VECTOR(31 downto 0);
-- register read out
signal registerRead1:STD_LOGIC_VECTOR (31 downto 0);
signal registerRead2:STD_LOGIC_VECTOR (31 downto 0);
--sign extend out
signal signExtendout:STD_LOGIC_VECTOR (31 downto 0);
--add(with alu result then goes into mux 1) out
signal add_out:STD_LOGIC_VECTOR (31 downto 0);
--and out
signal and2out:STD_LOGIC;
--ALU out
signal aluResultOut:std_logic_vector(31 downto 0);
signal aluZeroOut:STD_LOGIC;
--leftShifter out
signal shift1Output: std_logic_vector(31 downto 0);
--leftShifter26_28 out
signal shift26_28Output: std_logic_vector(27 downto 0);
--Memory out
signal memoryOut: std_logic_vector(31 downto 0);
--PC+shiftLeft
signal PCshift: std_logic_vector(31 downto 0);
--ALU Control Out
signal aluControlOut: std_logic_vector(3 downto 0);

--START WIRING
begin
PCshift <= add4out(31 downto 28)&shift26_28Output;
pc:      ProgramCounter port map(mux2out,'0', clk, pc_out);
add4:    addshift4      port map(pc_out, add4out);
instmem: instructionmem port map(pc_out,instr31_0);
ctrl:    control	port map(instr31_0(31 downto 26),RegDst,Jump,Branch,MemRead,MemtoReg,MemWrite,ALUSrc,RegWrite,ALUOp);
mx5:	 Mux5bit	port map(instr31_0(20 downto 16),instr31_0(15 downto 11), RegDst, mux5bitout);
mainReg: finalReg	port map(instr31_0(25 downto 21), instr31_0(20 downto 16), mux5bitout, mux4out,clk,RegWrite,registerRead1,registerRead2);
signEx:	 SignExtend	port map(instr31_0(15 downto 0), signExtendout);
leftSh1: leftShifter    port map(signExtendout,shift1Output);
leftSh2: leftShifter26_28    port map(instr31_0(25 downto 0),shift26_28Output);
ad:	 add 		port map(shift1Output,add4out,add_out);
a2:	 and2		port map(Branch, AluZeroOut, and2out);
mx1:	 Mux32bit	port map(add4out, add_out, and2out, mux1out);
mx2:	 Mux32bit	port map(mux1out,PCshift,Jump,mux2out);
mx3:	 Mux32bit	port map(registerRead2,signExtendout,ALUSrc,mux3out);
mx4:	 Mux32bit	port map(aluResultOut,memoryOut,MemtoReg,mux4out);
aluC:    aluControl     port map(clk, ALUOp,instr31_0(5 downto 0),aluControlOut);
alu:	 alu_Reg	port map(clk, registerRead1, mux3out, instr31_0(10 downto 6), aluControlOut,aluZeroOut,aluResultOut);
mem:	 memory 	port map(aluResultOut,registerRead2,MemWrite,MemRead,clk, memoryOut);
end struct;
   
