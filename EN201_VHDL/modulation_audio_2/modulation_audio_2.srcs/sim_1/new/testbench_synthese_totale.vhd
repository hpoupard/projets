library ieee;
use ieee.std_logic_1164.all;

entity tb_synthese_totale is
end tb_synthese_totale;

architecture tb of tb_synthese_totale is

    component synthese_totale
        port (CLOCK  : in std_logic;
              RESET  : in std_logic;
              SORTIE : out std_logic);
    end component;

    signal CLOCK  : std_logic;
    signal RESET  : std_logic;
    signal SORTIE : std_logic;

    constant TbPeriod : time := 1000 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : synthese_totale
    port map (CLOCK  => CLOCK,
              RESET  => RESET,
              SORTIE => SORTIE);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that CLOCK is really your main clock signal
    CLOCK <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed

        -- Reset generation
        -- EDIT: Check that RESET is really your reset signal
        RESET <= '1';
        wait for 10 ns;
        RESET <= '0';
        wait for 100 ns;

        -- EDIT Add stimuli here
        wait for 1000000 * TbPeriod;

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_synthese_totale of tb_synthese_totale is
    for tb
    end for;
end cfg_tb_synthese_totale;