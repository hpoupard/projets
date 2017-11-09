library ieee;
use ieee.std_logic_1164.all;

entity tb_pwm is
end tb_pwm;

architecture tb of tb_pwm is

    component pwm
        port (CLOCK : in std_logic;
              CE    : in std_logic;
              RESET : in std_logic;
              IDATA : in std_logic_vector (10 downto 0);
              ODATA : out std_logic);
    end component;

    signal CLOCK : std_logic;
    signal CE    : std_logic;
    signal RESET : std_logic;
    signal IDATA : std_logic_vector (10 downto 0);
    signal ODATA : std_logic;

    constant TbPeriod : time := 10 ns; -- EDIT Put right period here
    constant TbPeriodCE : time := 22660 ns; -- EDIT Put right period here
    signal TbSimEnded : std_logic := '0';

begin

    dut : pwm
    port map (CLOCK => CLOCK,
              CE    => CE,
              RESET => RESET,
              IDATA => IDATA,
              ODATA => ODATA);

    -- Clock generation
process
begin
    CLOCK <= '0';
    wait for TbPeriod/2;
    CLOCK <= '1';
    wait for TbPeriod/2;
end process;

process
begin
    CE <= '0';
    wait for TbPeriodCE-TbPeriod;
    CE <= '1';
    wait for TbPeriod;
end process;
    -- EDIT: Check that CLOCK is really your main clock signal

    stimuli : process
    begin

        -- Reset generation
        -- EDIT: Check that RESET is really your reset signal
        RESET <= '1';
        wait for 100 ns;
        RESET <= '0';
        wait for 100 ns;

        IDATA <= "00000000000";
        wait for 1 * TbPeriodCE;
        IDATA <= "11111111111";
        wait for 1 * TbPeriodCE;
        IDATA <= "00000100000";
        wait for 1 * TbPeriodCE;
        IDATA <= "00001000000";
        wait for 1 * TbPeriodCE;
        IDATA <= "00010000000";
        wait for 1 * TbPeriodCE;
        IDATA <= "00100000000";
        wait for 1 * TbPeriodCE;
        IDATA <= "01000000000";
        wait for 1 * TbPeriodCE;
        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;
