------------------------------------------------------
----------------Add component-------------------------
------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity add is
	port (
		A,B: in std_logic_vector(31 downto 0);
		C: out std_logic_vector(31 downto 0)
	);
end entity;

architecture beh of add is
	begin
	C <= A+B;
end beh;
