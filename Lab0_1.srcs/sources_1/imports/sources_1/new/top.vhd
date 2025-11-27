library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top is
    Port (  clk_i : in std_logic;
            rst_i : in std_logic;
            button_i : in std_logic_vector(3 downto 0);
            led7_an_o : out std_logic_vector(3 downto 0);
            led7_seg_o : out std_logic_vector(7 downto 0)
     );
end top;

architecture Behavioral of top is
--
-- Declaration of the KCPSM6 component including default values for generics.
--

--
-- Declaration of the default Program Memory recommended for development.
--
-- The name of this component should match the name of your PSM file.
--

  component counter                             
    generic(             C_FAMILY : string := "V6"; 
                C_RAM_SIZE_KWORDS : integer := 1;
             C_JTAG_LOADER_ENABLE : integer := 1);
    Port (      address : in std_logic_vector(11 downto 0);
            instruction : out std_logic_vector(17 downto 0);
                 enable : in std_logic;
                    rdl : out std_logic;                    
                    clk : in std_logic);
  end component;
  
  signal counter_reg   : std_logic_vector(3 downto 0) := "0000";
  
  component kcpsm6 
    generic(                 hwbuild : std_logic_vector(7 downto 0) := X"00";
                    interrupt_vector : std_logic_vector(11 downto 0) := X"3FF";
             scratch_pad_memory_size : integer := 64);
    port (                   address : out std_logic_vector(11 downto 0);
                         instruction : in std_logic_vector(17 downto 0);
                         bram_enable : out std_logic;
                             in_port : in std_logic_vector(7 downto 0);
                            out_port : out std_logic_vector(7 downto 0);
                             port_id : out std_logic_vector(7 downto 0);
                        write_strobe : out std_logic;
                      k_write_strobe : out std_logic;
                         read_strobe : out std_logic;
                           interrupt : in std_logic;
                       interrupt_ack : out std_logic;
                               sleep : in std_logic;
                               reset : in std_logic;
                                 clk : in std_logic);
  end component;
  
  
--
-- Signals for connection of KCPSM6 and Program Memory.
--

    signal         address : std_logic_vector(11 downto 0);
    signal     instruction : std_logic_vector(17 downto 0);
    signal     bram_enable : std_logic;
    signal         in_port : std_logic_vector(7 downto 0);
    signal        out_port : std_logic_vector(7 downto 0);
    signal         port_id : std_logic_vector(7 downto 0);
    signal    write_strobe : std_logic;
    signal  k_write_strobe : std_logic;
    signal     read_strobe : std_logic;
    signal       interrupt : std_logic;
    signal   interrupt_ack : std_logic;
    signal    kcpsm6_sleep : std_logic;
    signal    kcpsm6_reset : std_logic;

--
-- Some additional signals are required if your system also needs to reset KCPSM6. 
--

    signal       cpu_reset : std_logic;
    signal             rdl : std_logic;
    
--
-- When interrupt is to be used then the recommended circuit included below requires 
-- the following signal to represent the request made from your system.
--

    signal     int_request : std_logic;
    
    signal clk : std_logic;
     
    component clk_divider
        Port (  clk_i : in std_logic;
                clk_o : out std_logic);         
    end component;
    
    component display
        Port ( clk_i : in std_logic;
            rst_i : in std_logic;
            digit_i : in std_logic_vector (31 downto 0);
            led7_an_o : out std_logic_vector (3 downto 0);
            led7_seg_o : out std_logic_vector (7 downto 0));
   end component;
   
   signal segment : std_logic_vector(7 downto 0);
   signal segment_out : std_logic_vector(31 downto 0);
   
   component debouncer
    Port ( clk_i : in STD_LOGIC;
           btn_i : in STD_LOGIC;
           btn_debounced_o : out STD_LOGIC);
    end component;
    
    signal btn_increment : std_logic;
    signal btn_decrement : std_logic;
begin

 processor: kcpsm6
    generic map (                 hwbuild => X"00", 
                         interrupt_vector => X"3FF",
                  scratch_pad_memory_size => 64)
    port map(      address => address,
               instruction => instruction,
               bram_enable => bram_enable,
                   port_id => port_id,
              write_strobe => write_strobe,
            k_write_strobe => k_write_strobe,
                  out_port => out_port,
               read_strobe => read_strobe,
                   in_port => in_port,
                 interrupt => interrupt,
             interrupt_ack => interrupt_ack,
                     sleep => kcpsm6_sleep,
                     reset => kcpsm6_reset,
                       clk => clk);
                       
                   
    kcpsm6_sleep <= '0';
    interrupt <= interrupt_ack;
    
    program_rom: counter                           --Name to match your PSM file
    generic map(             C_FAMILY => "V6",   --Family 'S6', 'V6' or '7S'
                    C_RAM_SIZE_KWORDS => 1,      --Program size '1', '2' or '4'
                 C_JTAG_LOADER_ENABLE => 0)      --Include JTAG Loader when set to '1' 
    port map(      address => address,      
               instruction => instruction,
                    enable => bram_enable,
                       rdl => rdl,
                       clk => clk);

   kcpsm6_reset <= rst_i or rdl;      
   
   clock_divider : clk_divider
   port map(    clk_i => clk_i,
                clk_o => clk);
            
  increment_debounce : debouncer
  port map(     clk_i => clk_i,
                btn_i => button_i(0),
                btn_debounced_o => btn_increment);
                
  decrement_debounce : debouncer
  port map(     clk_i => clk_i,
                btn_i => button_i(1),
                btn_debounced_o => btn_decrement);
  disp : display
  port map(     clk_i => clk_i,
                rst_i => rst_i,
                digit_i => segment_out,
                led7_an_o => led7_an_o,
                led7_seg_o => led7_seg_o);
                             
  input : process(clk_i)
  begin
        if rising_edge(clk_i) then
            if port_id = X"01" then 
                in_port <= "000000" & btn_decrement & btn_increment;
            else
                in_port <= (others => '0');
            end if;
        end if;
    end process;
    
  output : process(clk_i)
    begin
        if rising_edge(clk_i) then
            if write_strobe = '1' and port_id = X"02" then
                counter_reg <= out_port(3 downto 0);
            end if;
        end if;
    end process;
    
    with counter_reg select
        segment <= "1000000" when "0000", -- 0
                   "1111001" when "0001", -- 1
                   "0100100" when "0010", -- 2
                   "0110000" when "0011", -- 3
                   "0011001" when "0100", -- 4
                   "0010010" when "0101", -- 5
                   "0000010" when "0110", -- 6
                   "1111000" when "0111", -- 7
                   "0000000" when "1000", -- 8
                   "0010000" when "1001", -- 9
                   "0001000" when "1010", -- A
                   "0000011" when "1011", -- b
                   "1000110" when "1100", -- C
                   "0100001" when "1101", -- d
                   "0000110" when "1110", -- E
                   "0001110" when "1111", -- F
                   "1111111" when others;
  segment_out <= X"FFF" & segment;
  
end Behavioral;
