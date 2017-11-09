library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity test_fsm IS
end test_fsm;

architecture workbench_fsm of test_fsm is
  component fsm_mp3 is
    port(
      CLOCK : in STD_LOGIC;
      RESET : in STD_LOGIC;
      B_UP : in STD_LOGIC;
      B_DOWN : in STD_LOGIC;
      B_CENTER : in STD_LOGIC;
      B_LEFT : in STD_LOGIC;
      B_RIGHT : in STD_LOGIC;
      FORWARD : out STD_LOGIC;
      PLAY_PAUSE : out STD_LOGIC;
      RESTART : out STD_LOGIC;
      VOLUME_DW : out STD_LOGIC;
      VOLUME_UP : out STD_LOGIC
      );
  end component;

  signal clock : STD_LOGIC := '0';
  signal reset : STD_LOGIC := '0';
  signal b_up : STD_LOGIC := '0';
  signal b_down : STD_LOGIC := '0';
  signal b_center : STD_LOGIC := '0';
  signal b_left : STD_LOGIC := '0';
  signal b_right : STD_LOGIC := '0';
  signal forward : STD_LOGIC := '0';
  signal play_pause : STD_LOGIC := '0';
  signal restart : STD_LOGIC := '0';
  signal volume_dw : STD_LOGIC := '0';
  signal volume_up : STD_LOGIC := '0';

  constant period : time := 10ns;

  begin
    instance_fsm :  fsm_mp3
      port map (
        clock => CLOCK,
        reset => RESET,
        b_up => B_UP,
        b_down => B_DOWN,
        b_center => B_CENTER,
        b_left => B_LEFT,
        b_right => B_RIGHT,
        forward => FORWARD,
        play_pause => PLAY_PAUSE,
        restart => RESTART,
        volume_dw => VOLUME_DW,
        volume_up => VOLUME_UP
        );

    clock_Process : process
      begin
        clock <= '1';
        wait for period/2;
        clock <= '0';
        wait for period/2;
      end process clock_Process;

    stimuli : process
      begin
        --etat => init
        reset <= '1';
        b_up <= '0';
        b_down <= '0';
        b_center <= '0';
        b_left <= '0';
        b_right <= '0';
        wait for 15ns;

        --etat => play_fwd
        reset <= '0';
        b_up <= '1';
        b_down <= '1';
        b_center <= '1';
        b_left <= '0';
        b_right <= '0';
        wait for 10ns;

        --etat => pause
        reset <= '0';
        b_up <= '0';
        b_down <= '0';
        b_center <= '1';
        b_left <= '0';
        b_right <= '0';
        wait for 10ns;

        --etat => play_bwd
        reset <= '0';
        b_up <= '1';
        b_down <= '0';
        b_center <= '0';
        b_left <= '1';
        b_right <= '0';
        wait for 10ns;

        --etat => pause
        reset <= '0';
        b_up <= '0';
        b_down <= '0';
        b_center <= '1';
        b_left <= '0';
        b_right <= '0';
        wait for 10ns;

        --etat => stop
        reset <= '0';
        b_up <= '0';
        b_down <= '0';
        b_center <= '1';
        b_left <= '0';
        b_right <= '0';
        wait for 10ns;

        --etat => play_fwd
        reset <= '0';
        b_up <= '0';
        b_down <= '1';
        b_center <= '1';
        b_left <= '0';
        b_right <= '0';
        wait for 10ns;

        --etat => init
        reset <= '1';
        b_up <= '0';
        b_down <= '0';
        b_center <= '0';
        b_left <= '0';
        b_right <= '0';
        wait for 10ns;
      end process stimuli;
  end workbench_fsm;
