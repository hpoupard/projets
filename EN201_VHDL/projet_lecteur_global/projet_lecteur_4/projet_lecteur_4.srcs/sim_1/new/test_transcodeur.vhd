----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04.10.2017 09:53:23
-- Design Name: 
-- Module Name: test_transcodeur - Behavioral
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

entity test_transcodeur is
--  Port ( );
end test_transcodeur;

architecture workbench_transcodeur of test_transcodeur is

    component transcodeur is
    Port ( FORWARD : in STD_LOGIC;
           PLAY_PAUSE : in STD_LOGIC;
           RESTART : in STD_LOGIC;
           nb_binaire : in STD_LOGIC_VECTOR (9 downto 0);
           nb_binaire_vol : in STD_LOGIC_VECTOR (3 downto 0);
           centaines : out STD_LOGIC_VECTOR (6 downto 0);
           dizaines : out STD_LOGIC_VECTOR (6 downto 0);
           unites : out STD_LOGIC_VECTOR (6 downto 0);
           unites_vol : out STD_LOGIC_VECTOR (6 downto 0);
           carac1 : out STD_LOGIC_VECTOR (6 downto 0);
           carac2 : out STD_LOGIC_VECTOR (6 downto 0);
           carac3 : out STD_LOGIC_VECTOR (6 downto 0);
           carac4 : out STD_LOGIC_VECTOR (6 downto 0));
end component;

    signal forward : STD_LOGIC;
    signal play_pause : STD_LOGIC;
    signal restart : STD_LOGIC;
    signal NB_BINAIRE : STD_LOGIC_VECTOR (9 downto 0);
    signal NB_BINAIRE_VOL : STD_LOGIC_VECTOR (3 downto 0);
    signal CENTAINES : STD_LOGIC_VECTOR (6 downto 0);
    signal DIZAINES : STD_LOGIC_VECTOR (6 downto 0);
    signal UNITES : STD_LOGIC_VECTOR (6 downto 0);
    signal UNITES_VOL : STD_LOGIC_VECTOR (6 downto 0);
    signal CARAC1 : STD_LOGIC_VECTOR (6 downto 0);
    signal CARAC2 : STD_LOGIC_VECTOR (6 downto 0);
    signal CARAC3 : STD_LOGIC_VECTOR (6 downto 0);
    signal CARAC4 : STD_LOGIC_VECTOR (6 downto 0);

begin

    instance_transcodeur : transcodeur
    port map (
        forward => FORWARD,
        play_pause => PLAY_PAUSE,
        restart => RESTART,
        NB_BINAIRE => nb_binaire,
        NB_BINAIRE_VOL => nb_binaire_vol,
        CENTAINES => centaines,
        DIZAINES => dizaines,
        UNITES => unites,
        UNITES_VOL => unites_vol,
        CARAC1 => carac1,
        CARAC2 => carac2,
        CARAC3 => carac3,
        CARAC4 => carac4);
    

    affichage : process
    begin
        nb_binaire <= "0000000000";
        wait for 10ns;
        nb_binaire <= "1001010111";
        wait for 1ms;
    end process;    
end workbench_transcodeur;
