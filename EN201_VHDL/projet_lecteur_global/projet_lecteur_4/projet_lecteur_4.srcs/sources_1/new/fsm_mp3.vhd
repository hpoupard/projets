----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.09.2017 09:43:24
-- Design Name: 
-- Module Name: fsm_mp3 - Behavioral
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


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity fsm_mp3 is
    Port ( CLOCK : in STD_LOGIC;
           RESET : in STD_LOGIC;
           B_CENTER : in STD_LOGIC;
           B_DOWN : in STD_LOGIC;
           B_LEFT : in STD_LOGIC;
           B_RIGHT : in STD_LOGIC;
           B_UP : in STD_LOGIC;
           FORWARD : out STD_LOGIC;
           PLAY_PAUSE : out STD_LOGIC;
           RESTART : out STD_LOGIC;
           VOLUME_DW : out STD_LOGIC;
           VOLUME_UP : out STD_LOGIC);
end fsm_mp3;

architecture Behavioral of fsm_mp3 is

type state is (init, play_fwd, play_bwd, pause, stop);
signal curr_state : state;
signal next_state : state;

begin

etat_futur : process (curr_state, B_CENTER, B_LEFT, B_RIGHT) 
begin
    case curr_state is
        when init =>
            if B_CENTER = '1' then
                next_state <= play_fwd;
            else
                next_state <= init;
            end if;
        when play_fwd =>
            if B_CENTER = '1' then
                next_state <= pause;
            else
                next_state <= play_fwd;
            end if;
        when pause =>
            if B_CENTER = '1' then
                next_state <= stop;
            elsif B_RIGHT = '1' then
                next_state <= play_fwd;
            elsif B_LEFT = '1' then
                next_state <= play_bwd;
            else
                next_state <= pause;
            end if;
        when play_bwd =>
            if B_CENTER = '1' then
                next_state <= pause;
            else
                next_state <= play_bwd;
            end if;
        when stop =>
            if B_CENTER = '1' then
                next_state <= play_fwd;
            else
                next_state <= stop;
            end if;
        when others =>
            next_state <= init;
    end case;
end process etat_futur;

syn_etat_present : process (CLOCK)
begin 
    if rising_edge(CLOCK) then
        if reset = '1' then
            curr_state <= init;
        else
            curr_state <= next_state;
        end if;
    end if;
end process syn_etat_present;

sorties : process (curr_state)
begin
    case curr_state is
        when play_fwd =>
            PLAY_PAUSE <= '1';
            RESTART <= '0';
            FORWARD <= '0';
            VOLUME_UP <= B_UP;
            VOLUME_DW <= B_DOWN;
        when play_bwd =>
            PLAY_PAUSE <= '1';
            RESTART <= '0';
            FORWARD <= '1';
            VOLUME_UP <= B_UP;
            VOLUME_DW <= B_DOWN;
        when pause =>
            PLAY_PAUSE <= '0';
            RESTART <= '0';
            FORWARD <= '0';
            VOLUME_UP <= '0';
            VOLUME_DW <= '0';
        when others =>
            PLAY_PAUSE <= '0';
            RESTART <= '1';
            FORWARD <= '0';
            VOLUME_UP <= '0';
            VOLUME_DW <= '0';
    end case;
end process sorties;
     
end Behavioral;
