library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity control is

port(
Instr: in std_logic_vector(5 downto 0);
RegDst,Jump,Branch,MemRead,MemtoReg,MemWrite,ALUSrc,RegWrite: out std_logic;
ALUOp: out std_logic_vector(1 downto 0)
);--end port
end control;

architecture Behavioral of control is
--variables here
begin--begin architecture
process(Instr)
begin--begin process
case Instr is
	when "000000"=>--R-type
	  RegDst<='1';Jump<='0';Branch<='0';MemRead<='0';MemtoReg<='0';MemWrite<='0';ALUSrc<='0';
	  RegWrite<='1';ALUOp<="10";
	when "001000"=>--addi
	  RegDst<='0';Jump<='0';Branch<='0';MemRead<='0';MemtoReg<='0';MemWrite<='0';ALUSrc<='1';
	  RegWrite<='1';ALUOp<="01";
	when "001001"=>--addiu
	  RegDst<='0';Jump<='0';Branch<='0';MemRead<='0';MemtoReg<='0';MemWrite<='0';ALUSrc<='1';
	  RegWrite<='1';ALUOp<="01";
	when "001100"=>--andi
	  RegDst<='0';Jump<='0';Branch<='0';MemRead<='0';MemtoReg<='0';MemWrite<='0';ALUSrc<='1';
	  RegWrite<='1';ALUOp<="11";
	when "000100"=>--beq
	  RegDst<='0';Jump<='0';Branch<='1';MemRead<='0';MemtoReg<='0';MemWrite<='0';ALUSrc<='0';
	  RegWrite<='0';ALUOp<="01";
	when "000101"=>--bne
	  RegDst<='0';Jump<='0';Branch<='1';MemRead<='0';MemtoReg<='0';MemWrite<='0';ALUSrc<='0';
	  RegWrite<='0';ALUOp<="11";
	when "000010"=>--jump
	  RegDst<='0';Jump<='1';Branch<='0';MemRead<='0';MemtoReg<='0';MemWrite<='0';ALUSrc<='0';
	  RegWrite<='0';ALUOp<="00";
	when "000011"=>--jal
	  RegDst<='0';Jump<='1';Branch<='0';MemRead<='0';MemtoReg<='0';MemWrite<='0';ALUSrc<='0';
	  RegWrite<='1';ALUOp<="00";
	when "100100"=>--lbu
	  RegDst<='0';Jump<='0';Branch<='0';MemRead<='1';MemtoReg<='1';MemWrite<='0';ALUSrc<='1';
	  RegWrite<='1';ALUOp<="00";
	when "100101"=>--lhu
	  RegDst<='0';Jump<='0';Branch<='0';MemRead<='1';MemtoReg<='1';MemWrite<='0';ALUSrc<='1';
	  RegWrite<='1';ALUOp<="00";
	when "110000"=>--ll
	  RegDst<='0';Jump<='0';Branch<='0';MemRead<='1';MemtoReg<='1';MemWrite<='0';ALUSrc<='1';
	  RegWrite<='1';ALUOp<="00";
	when "001111"=>--lui
	  RegDst<='0';Jump<='0';Branch<='0';MemRead<='0';MemtoReg<='1';MemWrite<='0';ALUSrc<='1';
	  RegWrite<='1';ALUOp<="00";
	when "100011"=>--lw
	  RegDst<='0';Jump<='0';Branch<='0';MemRead<='1';MemtoReg<='1';MemWrite<='0';ALUSrc<='1';
	  RegWrite<='1';ALUOp<="00";
	when "001101"=>--ori
	  RegDst<='0';Jump<='0';Branch<='0';MemRead<='0';MemtoReg<='1';MemWrite<='0';ALUSrc<='1';
	  RegWrite<='1';ALUOp<="01";
	when "001010"=>--slti
	  RegDst<='0';Jump<='0';Branch<='0';MemRead<='0';MemtoReg<='0';MemWrite<='0';ALUSrc<='1';
	  RegWrite<='1';ALUOp<="00";
	when "001011"=>--sltiu
	  RegDst<='0';Jump<='0';Branch<='0';MemRead<='0';MemtoReg<='0';MemWrite<='0';ALUSrc<='1';
	  RegWrite<='1';ALUOp<="00";
	when "101000"=>--sb
	  RegDst<='0';Jump<='0';Branch<='0';MemRead<='0';MemtoReg<='0';MemWrite<='1';ALUSrc<='1';
	  RegWrite<='0';ALUOp<="00";
	when "111000"=>--sc
	  RegDst<='0';Jump<='0';Branch<='0';MemRead<='0';MemtoReg<='0';MemWrite<='1';ALUSrc<='1';
	  RegWrite<='0';ALUOp<="00";
	when "101001"=>--sh
	  RegDst<='0';Jump<='0';Branch<='0';MemRead<='0';MemtoReg<='0';MemWrite<='1';ALUSrc<='1';
	  RegWrite<='0';ALUOp<="00";
	when "101011"=>--sw
	  RegDst<='0';Jump<='0';Branch<='0';MemRead<='0';MemtoReg<='0';MemWrite<='1';ALUSrc<='1';
	  RegWrite<='0';ALUOp<="00";
	when others=>--all other func codes
	  RegDst<='0';Jump<='0';Branch<='0';MemRead<='0';MemtoReg<='0';MemWrite<='0';ALUSrc<='0';
	  RegWrite<='0';ALUOp<="00";
end case;
end process;
end Behavioral;
