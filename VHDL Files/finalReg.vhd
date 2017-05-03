library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
entity finalReg is
	port (
		ReadAddress1, ReadAddress2, writeAddress: in std_logic_vector(4 downto 0);
		write_data: in STD_LOGIC_VECTOR (31 downto 0);
		clk, RegWrite: in STD_LOGIC;
		read_data1: out STD_LOGIC_VECTOR (31 downto 0);
		read_data2: out STD_LOGIC_VECTOR (31 downto 0)
	);
end finalReg;


architecture behavioral of finalReg is	
type mem_array is array(0 to 31) of STD_LOGIC_VECTOR (31 downto 0);

signal data_mem: mem_array := (
    X"00000000", -- initialize data memory
    X"00000000", -- mem 1
    X"00000000",
    X"00000000",
    X"00000000",
    X"00000000",
    X"00000000",
    X"00000000",
    X"00000000",
    X"00000000", 
    X"00000000", -- mem 10 
    X"00000000", 
    X"00000000",
    X"00000000",
    X"00000000",
    X"00000000",
    X"00000000",
    X"00000000",
    X"00000000",
    X"00000000",  
    X"00000000", -- mem 20
    X"00000000",
    X"00000000",
    X"00000000",
    X"00000000", 
    X"00000000",
    X"00000000",
    X"00000000",
    X"00000000",
    X"00000000", 
    X"00000000", -- mem 30
    X"00000000");

begin


mem_process: process(writeAddress, write_data,clk)
begin
	if clk = '1' and clk'event then
		read_data1 <= data_mem(conv_integer(ReadAddress1));
		read_data2 <= data_mem(conv_integer(ReadAddress2));
	end if;
	if clk = '0' and clk'event then
	  if RegWrite='1' then
		data_mem(conv_integer(writeAddress)) <= write_data;
	  end if;
	end if;
end process mem_process;

end behavioral;