library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;

entity display is
    Port ( clk_i : in std_logic;
            rst_i : in std_logic;
            digit_i : in std_logic_vector (31 downto 0);
            led7_an_o : out std_logic_vector (7 downto 0);
            led7_seg_o : out std_logic_vector (7 downto 0));
end display;

architecture Behavioral of display is
    
begin
    process (clk_i)
    variable current_anode : std_logic_vector (1 downto 0) := "00";
    variable i : integer := 0;
    begin
       if rising_edge(clk_i) then
       
            i := i + 1;
            if i = 200000 then
                if current_anode = "11" then
                    current_anode := "00";
                else 
                    current_anode := current_anode + 1;
                end if;
                i := 0;
            end if;
            
            case current_anode is
            when "00" =>
                led7_an_o <= "11101111";
                led7_seg_o <= digit_i(7 downto 0);
            when "01" =>
                led7_an_o <= "11011111";
                led7_seg_o <= digit_i(15 downto 8);
            when "10" =>
                led7_an_o <= "10111111";
                led7_seg_o <= digit_i(23 downto 16);
            when "11" =>
                led7_an_o <= "01111111";
                led7_seg_o <= digit_i(31 downto 24);
            when others =>
                led7_an_o <= "0000";
            end case;
       end if;
    end process;
end Behavioral;