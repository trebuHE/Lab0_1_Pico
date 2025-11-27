library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity clk_divider is
    Port ( clk_i : in STD_LOGIC;
           clk_o : out STD_LOGIC);
end clk_divider;

architecture Behavioral of clk_divider is
    signal clk_counter : unsigned(15 downto 0) := (others => '0');
    signal clk : std_logic := '0';
begin
    process(clk_i)
    begin
        if rising_edge(clk_i) then
            if clk_counter < 50000 then
                clk_counter  <= clk_counter + 1;
            else
                clk <= not clk;
                clk_counter <= (others => '0');       
            end if;
        end if;
    end process;

    clk_o <= clk;
    
end Behavioral;
