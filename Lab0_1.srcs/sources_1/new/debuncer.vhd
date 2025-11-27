library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity debouncer is
    Port ( clk_i : in STD_LOGIC;
           btn_i : in STD_LOGIC;
           btn_debounced_o : out STD_LOGIC);
end debouncer;

architecture Behavioral of debouncer is

	signal flip_flops : std_logic_vector(1 downto 0);
	signal counter_reset : std_logic;

begin

	counter_reset <= flip_flops(0) xor flip_flops(1);

process (clk_i)

	constant MAX_COUNT : integer := 1000000;
	variable count : integer range 0 to MAX_COUNT;

begin

	if (rising_edge(clk_i)) then
		flip_flops(0) <= btn_i;
		flip_flops(1) <= flip_flops(0);
		
		if (counter_reset = '1') then
			count := 0;
		elsif ( count < MAX_COUNT) then
			count := count + 1;
		else
			btn_debounced_o <= flip_flops(1);
		end if;
	end if;
	
end process;
end Behavioral;