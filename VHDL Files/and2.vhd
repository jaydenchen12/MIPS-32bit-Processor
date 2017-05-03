library IEEE;
use IEEE.std_logic_1164.all;

entity and2 is
    Port ( input0 : in  STD_LOGIC;
	   input1 : in STD_LOGIC;
           output : out  STD_LOGIC);
end and2;

architecture behave of and2 is

begin 

output <= input0 and input1;

end behave;