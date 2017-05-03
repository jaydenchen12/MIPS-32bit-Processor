library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity leftShifter26_28 is
    Port ( input : in  STD_LOGIC_VECTOR (25 downto 0);           
	   output : out STD_LOGIC_VECTOR(27 downto 0));			  
end leftShifter26_28;

architecture Behavioral of leftShifter26_28 is
signal input_temp:STD_LOGIC_VECTOR(27 downto 0);
begin
	input_temp <= std_logic_vector(resize(signed(Input), Output'length));
	output <=  std_logic_vector(unsigned(input_temp) sll 2);
end Behavioral;

