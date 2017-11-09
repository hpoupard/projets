----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.10.2017 11:44:02
-- Design Name: 
-- Module Name: synthese_totale - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE IEEE.math_real.ALL;

PACKAGE audio_rom IS
	CONSTANT ROM_FREQ      : integer := 44100;
	CONSTANT ROM_MAX_ADDR  : integer := 262144;
	CONSTANT ROM_MAX_DATA  : integer :=  2048;
	CONSTANT ROM_ADDR_BITS : integer :=    18;
	CONSTANT ROM_DATA_BITS : integer :=    11;
END;

--------------------------------------------------------------------------------

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE IEEE.math_real.ALL;
USE work.audio_rom.ALL;

entity synthese_totale is
    Port ( CLOCK : in STD_LOGIC;
           RESET : in STD_LOGIC;
           UART : in STD_LOGIC;
           PLAY_PAUSE : in STD_LOGIC;
           FORWARD : in STD_LOGIC;
           RESTART : in STD_LOGIC;
           --VOLUME : in STD_LOGIC_VECTOR (3 downto 0);
           SORTIE : out STD_LOGIC;
           SORTIE_EN : out STD_LOGIC);
end synthese_totale;

architecture Behavioral of synthese_totale is

component wav_rom IS
PORT (
      CLOCK     : IN  STD_LOGIC;
      WRITE_EN  : IN  STD_LOGIC;
      DATA_IN   : IN  STD_LOGIC_VECTOR(15 DOWNTO 0);
      ADDR      : IN  STD_LOGIC_VECTOR(17 DOWNTO 0);
      ADDR_IN   : IN  STD_LOGIC_VECTOR(17 DOWNTO 0);
      DATA_OUT  : OUT STD_LOGIC_VECTOR(10 DOWNTO 0)
      );
END component;

component cmp_addr is
  Port ( CLOCK : in STD_LOGIC;
         CE : in STD_LOGIC;
         ADDR_IN : in STD_LOGIC_VECTOR (17 downto 0);
         RESET : in STD_LOGIC;
         PLAY_PAUSE : in STD_LOGIC;
         FORWARD : in STD_LOGIC;
         RESTART : in STD_LOGIC;
         --VOLUME : in STD_LOGIC_VECTOR (3 downto 0);
         ADDR : out STD_LOGIC_VECTOR (17 downto 0)
       );
end component;

component horloge_44100Hz is
    Port ( CLOCK : in STD_LOGIC;
           RESET : in STD_LOGIC;
           CLK_44100 : out STD_LOGIC);
end component;

component pwm is
    Port ( CLOCK : in STD_LOGIC;
           CE : in STD_LOGIC;
           RESET : in STD_LOGIC;
           --VOLUME : in STD_LOGIC_VECTOR(3 downto 0);
           IDATA : in STD_LOGIC_VECTOR (10 downto 0);
           ODATA : out STD_LOGIC);
end component;

component full_UART_recv is
    PORT (
        clk_100MHz  : in  STD_LOGIC;
        reset       : in  STD_LOGIC;
        rx          : in  STD_LOGIC;

        memory_addr : out STD_LOGIC_VECTOR (17 downto 0);
        data_value  : out STD_LOGIC_VECTOR (15 downto 0);
        memory_wen  : out STD_LOGIC
    );

end component;

signal ce, write_en : STD_LOGIC;
signal idata : STD_LOGIC_VECTOR (10 downto 0);
signal addr, addr_in : STD_LOGIC_VECTOR (17 downto 0);
signal data_in : STD_LOGIC_VECTOR (15 downto 0);

begin

    SORTIE_EN <= '1';

    Iwav_rom : wav_rom
    port map (
        CLOCK => CLOCK,
        ADDR => addr,
        ADDR_IN => addr_in,
        DATA_IN => data_in,
        DATA_OUT => idata,
        WRITE_EN => write_en);
        
    Icmp_addr : cmp_addr
    port map (
        CLOCK => CLOCK,
        CE => ce,
        ADDR_IN => addr_in,
        RESET => RESET,
        PLAY_PAUSE => PLAY_PAUSE,
        FORWARD => FORWARD,
        RESTART => RESTART,
        ADDR => addr);
        
    Ihorloge_44100 : horloge_44100Hz
    port map (
        CLOCK => CLOCK,
        RESET => RESET,
        CLK_44100 => ce);
        
    Ipwm : pwm
    port map (
        CLOCK => CLOCK,
        CE => ce,
        RESET => RESET,
        --VOLUME => VOLUME,
        IDATA => idata,
        ODATA => SORTIE);
        
    Ifull_UART_recv : full_UART_recv
    port map(
        clk_100MHz => CLOCK,
        reset => RESET,
        rx => UART,
        memory_addr => addr_in,
        data_value => data_in,
        memory_wen => write_en);

end Behavioral;
