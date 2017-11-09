library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.ALL;

entity mp3player is
  port (
    CLOCK : in STD_LOGIC;
    RESET : in STD_LOGIC;
    RX : in STD_LOGIC;
    bouton_right : in STD_LOGIC;
    bouton_left : in STD_LOGIC;
    bouton_up : in STD_LOGIC;
    bouton_down : in STD_LOGIC;
    bouton_center : in STD_LOGIC;
    sept_segment : out STD_LOGIC_VECTOR(6 downto 0);
    anode : out STD_LOGIC_VECTOR(7 downto 0);
    DP : out STD_LOGIC;
    SORTIE : out STD_LOGIC;
    SORTIE_EN : out STD_LOGIC
    );
end mp3player;

architecture Behavorial of mp3player is

  signal B_right, B_left, B_up, B_down, B_center : STD_LOGIC;
  signal forward, play_pause, restart, volume_dw, volume_up : STD_LOGIC;
  signal CE_affichage, CE_perception : STD_LOGIC;
  signal V_volume : STD_LOGIC_VECTOR(3 downto 0);
  signal V_temps : STD_LOGIC_VECTOR(9 downto 0);
  signal S_cent, S_diz, S_unit, S_vol, S_carac1, S_carac2, S_carac3, S_carac4 : STD_LOGIC_VECTOR(6 downto 0);
  signal signal_anode : STD_LOGIC_VECTOR(2 downto 0);
  
  component synthese_totale is
      Port ( CLOCK : in STD_LOGIC;
             RESET : in STD_LOGIC;
             UART : in STD_LOGIC;
             PLAY_PAUSE : in STD_LOGIC;
             FORWARD : in STD_LOGIC;
             RESTART : in STD_LOGIC;
             --VOLUME : in STD_LOGIC_VECTOR (3 downto 0);
             SORTIE : out STD_LOGIC;
             SORTIE_EN : out STD_LOGIC);
  end component;

  
  component cpt_1_599 is
      Port ( INIT : in STD_LOGIC;
             RESET : in STD_LOGIC;
             CLOCK : in STD_LOGIC;
             CE_AFFICHAGE : in STD_LOGIC;
             DECR : in STD_LOGIC;
             PLAY_PAUSE : in STD_LOGIC;
             SORTIE : out STD_LOGIC_VECTOR (9 downto 0));
  end component;
  
  component cpt_1_9 is
      Port ( INCR : in STD_LOGIC;
             CLOCK : in STD_LOGIC;
             DECR : in STD_LOGIC;
             RESET : in STD_LOGIC;
             SORTIE : out STD_LOGIC_VECTOR (3 downto 0));
  end component;
  
  component detect_impulsion is
    port (
      CLOCK : in STD_LOGIC;
      INPUT : in STD_LOGIC;
      OUTPUT : out STD_LOGIC
      );
    end component;
    
    component fsm_mp3 is
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
    end component;
    
    component gestion_freq is
        Port ( CLOCK : in STD_LOGIC;
               RESET : in STD_LOGIC;
               CE_AFFICHAGE : out STD_LOGIC;
               CE_PERCEPTION : out STD_LOGIC);
    end component;
    
    component mod8 is
      port (
        CLOCK : in STD_LOGIC;
        RESET : in STD_LOGIC;
        C_PERC : in STD_LOGIC;
        AN : out STD_LOGIC_VECTOR(7 downto 0);
        sortie : out STD_LOGIC_VECTOR(2 downto 0)
      );
    end component;
    
    component mux8 is
      port (
        COMMANDE : in STD_LOGIC_VECTOR(2 downto 0);
        E0 : in STD_LOGIC_VECTOR(6 downto 0);
        E1 : in STD_LOGIC_VECTOR(6 downto 0);
        E2 : in STD_LOGIC_VECTOR(6 downto 0);
        E3 : in STD_LOGIC_VECTOR(6 downto 0);
        E4 : in STD_LOGIC_VECTOR(6 downto 0);
        E5 : in STD_LOGIC_VECTOR(6 downto 0);
        E6 : in STD_LOGIC_VECTOR(6 downto 0);
        E7 : in STD_LOGIC_VECTOR(6 downto 0);
        S0 : out STD_LOGIC_VECTOR(6 downto 0);
        DP : out STD_LOGIC
      );
    end component;

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
           carac4 : out STD_LOGIC_VECTOR (6 downto 0)
         );
end component;

begin
    
    Reg_B_center : detect_impulsion
    port map (
      CLOCK => CLOCK,
      INPUT => bouton_center,
      OUTPUT => B_center
      );
    
    Reg_B_down : detect_impulsion
    port map (
      CLOCK => CLOCK,
      INPUT => bouton_down,
      OUTPUT => B_down
      );
    
    Reg_B_up : detect_impulsion
    port map (
      CLOCK => CLOCK,
      INPUT => bouton_up,
      OUTPUT => B_up
      );
    
    Reg_B_left : detect_impulsion
    port map (
      CLOCK => CLOCK,
      INPUT => bouton_left,
      OUTPUT => B_left
      );
    
    Reg_B_right : detect_impulsion
    port map (
      CLOCK => CLOCK,
      INPUT => bouton_right,
      OUTPUT => B_right
      );
    
    Ifsm_mp3 : fsm_mp3
    port map (
      B_center => B_CENTER,
      B_down => B_DOWN,
      B_left => B_LEFT,
      B_right => B_RIGHT,
      B_up => B_UP,
      CLOCK => CLOCK,
      RESET => RESET,
      RESTART => restart,
      forward => FORWARD,
      play_pause => PLAY_PAUSE,
      volume_dw => VOLUME_DW,
      volume_up => VOLUME_UP
      );
    
    Igestion_freq : gestion_freq
    port map (
      CLOCK => CLOCK,
      RESET => RESET,
      CE_affichage => CE_affichage,
      CE_perception => CE_perception
    );
    
    Icpt_1_9 : cpt_1_9
    port map (
      decr => volume_dw,
      CLOCK => CLOCK,
      incr => volume_up,
      RESET => RESET,
      sortie => V_volume
      );
      
   Icpt_1_599 : cpt_1_599
   port map (
    CE_AFFICHAGE => CE_affichage,
    DECR => forward,
    CLOCK => CLOCK,
    PLAY_PAUSE => play_pause,
    INIT => restart,
    RESET => RESET,
    sortie => V_temps
    );
    
  trans : transcodeur
  port map (
    FORWARD => forward,
    PLAY_PAUSE => play_pause,
    RESTART => restart,
    nb_binaire => V_temps,
    nb_binaire_vol => V_volume,
    centaines => S_cent,
    dizaines => S_diz,
    unites => S_unit,
    unites_vol => S_vol,
    carac1 => S_carac1,
    carac2 => S_carac2,
    carac3 => S_carac3,
    carac4 => S_carac4
    );
    
  Imod8 : mod8
  port map (
    C_PERC => CE_perception,
    CLOCK => CLOCK,
    RESET => RESET,
    AN => anode,
    sortie => signal_anode
    );
    
  Imux8 : mux8
  port map (
    COMMANDE => signal_anode,
    E0 => S_vol,
    E1 => S_cent,
    E2 => S_diz,
    E3 => S_unit ,
    E4 => S_carac1,
    E5 => S_carac2,
    E6 => S_carac3,
    E7 => S_carac4,
    DP => DP,
    S0 => sept_segment 
    );
    
    lecteur : synthese_totale
    port map (
        CLOCK => CLOCK,
        RESET => RESET,
        UART => RX,
        PLAY_PAUSE => play_pause,
        FORWARD => forward,
        RESTART => restart,
        --VOLUME => V_volume,
        SORTIE => SORTIE,
        SORTIE_EN => SORTIE_EN
        );
    
end Behavorial;
    
