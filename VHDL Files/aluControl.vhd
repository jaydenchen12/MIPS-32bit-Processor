library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity aluControl is
port(clk: in std_logic;
aluOp: in std_logic_vector(1 downto 0); 
Instr: in std_logic_vector(5 downto 0); 
aluControlInstr: out std_logic_vector(3 downto 0)
);--end port
end aluControl;

architecture Behavioral of aluControl is
begin--begin architecture
process(clk,aluOp)
begin--begin process

if clk='1' and clk'event then
	if aluOp="00" then aluControlInstr<="0010";--add (lw,sw)
	elsif aluOp="01" then aluControlInstr<="1000";--subtract and or, see alu_Reg (beq, ori)
	elsif aluOp="10" then
		case Instr is
		   when "100000"=>--add
			aluControlInstr<="0010";
		   when "100001"=>--addu
			aluControlInstr<="0010";
		   when "100100"=>--and
			aluControlInstr<="0010";
		   when "001000"=>--jr
			aluControlInstr<="0010";
		   when "100111"=>--nor
			aluControlInstr<="0101";
		   when "100101"=>--or
			aluControlInstr<="0001";
		   when "101010"=>--slt
			aluControlInstr<="0111";
		   when "101011"=>--sltu
			aluControlInstr<="0111";
		   when "000000"=>--sll
			aluControlInstr<="0011";
		   when "000010"=>--srl
			aluControlInstr<="0100";
		   when "100010"=>--sub
			aluControlInstr<="0110";
		   when "100011"=>--subu
			aluControlInstr<="0110";
		   when others=>--undefined R-type, wrong function code inputted
			aluControlInstr<="1110";--this number in ALU should be undefined
		end case;
	else aluControlInstr<="1111";--(andi,bne)
	--ALU Behavior: if aluControlInstr=1111 ALU_Zero_Result<=input1 XOR Input2
	--Then ALU Result<=Input1 AND Input 2
	end if;
end if;

end process;
end Behavioral;