------------------------------------------------------
----------------Add Shift By 4 component--------------
------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity addshift4 is
	port (
		A: in std_logic_vector(31 downto 0);
		C: out std_logic_vector(31 downto 0)
	);
end entity;

architecture beh of addshift4 is
	begin
	C <= A+4;
end beh;
