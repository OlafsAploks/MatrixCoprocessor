LIBRARY ieee;
USE ieee.std_logic_1164.all;
--use ieee.fixed_pkg.all;
use work.computing_elements_ports_pkg.all;

library ieee_proposed;
use ieee_proposed.fixed_pkg.all;

ENTITY DelayElementPERF_vhd_tst IS
END DelayElementPERF_vhd_tst;
ARCHITECTURE DelayElementPERF_arch OF DelayElementPERF_vhd_tst IS
-- constants
constant Clk_period : time := 10 ns;
-- signals
signal clk : std_logic := '0';
SIGNAL xIN, xOUT, xOUT2, xOUT3, xOUT4, xOUT5 : x_type;
SIGNAL phaseOUT, phaseOUT2, phaseOUT3, phaseOUT4, phaseOUT5 : STD_LOGIC;
SIGNAL reset : STD_LOGIC := '1';

component DelayElementPerf
GENERIC(DELAYCOUNT : INTEGER);
PORT(
	CLK: in STD_LOGIC;
	resetIN: in STD_LOGIC;
	input: in x_type;
	output: out valueAndPhase
);


end component;
BEGIN

UUT_DELAY_7 : DelayElementPerf
GENERIC MAP ( DELAYCOUNT => 7)
PORT MAP (
	CLK => clk,
	resetIN => reset,
	input => xIN,
	output.value => xOUT,
	output.phase => phaseOUT
);

	UUT_DELAY_1 : DelayElementPerf
	GENERIC MAP ( DELAYCOUNT => 1)
	PORT MAP (
		CLK => clk,
		resetIN => reset,
		input => xIN,
		output.value => xOUT2,
		output.phase => phaseOUT2
	);

	UUT_DELAY_4 : DelayElementPerf
	GENERIC MAP ( DELAYCOUNT => 4)
	PORT MAP (
		CLK => clk,
		resetIN => reset,
		input => xIN,
		output.value => xOUT3,
		output.phase => phaseOUT3
	);

	UUT_DELAY_0 : DelayElementPerf
	GENERIC MAP ( DELAYCOUNT => 0)
	PORT MAP (
		CLK => clk,
		resetIN => reset,
		input => xIN,
		output.value => xOUT4,
		output.phase => phaseOUT4
	);

	UUT_DELAY_3 : DelayElementPerf
	GENERIC MAP ( DELAYCOUNT => 3)
	PORT MAP (
		CLK => clk,
		resetIN => reset,
		input => xIN,
		output.value => xOUT5,
		output.phase => phaseOUT5
	);

init : PROCESS
BEGIN
WAIT;
END PROCESS init;

Clk_process : process
   begin
		clk <= '0';
		wait for Clk_period/2;
		clk <= '1';
		wait for Clk_period/2;
   end process Clk_process;


always : PROCESS
-- optional sensitivity list
-- (        )
-- variable declarations
BEGIN
  reset <= '0';
	wait until rising_edge(clk);
  reset <= '1';
	xIN <= "0000000100000000";
	wait until rising_edge(clk);
	xIN <= "0000001110000000";
	wait until rising_edge(clk);
	xIN <= "0000001101000000";
	wait until rising_edge(clk);
	xIN <= "0000100100000000";
	wait until rising_edge(clk);
	xIN <= "0000110100010000";
	wait until rising_edge(clk);
	xIN <= "0000000100000001";
	wait until rising_edge(clk);
	xIN <= "0000001100000010";
	wait until rising_edge(clk);
	xIN <= "0000001100000011";
	wait until rising_edge(clk);
	wait until rising_edge(clk);
	wait until rising_edge(clk);
	wait until rising_edge(clk);
	wait until rising_edge(clk);
	reset <= '0';
	wait until rising_edge(clk);


WAIT;
END PROCESS always;
END DelayElementPERF_arch;
