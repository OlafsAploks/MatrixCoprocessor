LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.fixed_pkg.all;
use work.computing_elements_ports_pkg.all;

--library ieee_proposed;
--use ieee_proposed.fixed_pkg.all;

ENTITY DelayElement_vhd_tst IS
END DelayElement_vhd_tst;
ARCHITECTURE DelayElement_arch OF DelayElement_vhd_tst IS
-- constants
constant Clk_period : time := 10 ns;
-- signals
signal clk : std_logic := '0';
SIGNAL xIN, xOUT, xOUT2, xOUT3, xOUT4 : x_type;
SIGNAL phaseIN, phaseOUT, phaseOUT2, phaseOUT3, phaseOUT4 : STD_LOGIC;
SIGNAL reset : STD_LOGIC := '1';
SIGNAL resetOUT, resetOUT2, resetOUT3, resetOUT4 : STD_LOGIC;

component DelayElement
GENERIC(DELAYCOUNT : INTEGER);
PORT(
	CLK: in STD_LOGIC;
	resetIN: in STD_LOGIC;
	input: in valueAndPhase;
	output: out valueAndPhase
);


end component;
BEGIN

UUT_DELAY_7 : DelayElement
GENERIC MAP ( DELAYCOUNT => 7)
PORT MAP (
	CLK => clk,
	resetIN => reset,
	input.value => xIN,
	input.phase => phaseIN,
	output.value => xOUT,
	output.phase => phaseOUT
);

	UUT_DELAY_1 : DelayElement
	GENERIC MAP ( DELAYCOUNT => 1)
	PORT MAP (
		CLK => clk,
		resetIN => reset,
		input.value => xIN,
		input.phase => phaseIN,
		output.value => xOUT2,
		output.phase => phaseOUT2
	);

	UUT_DELAY_4 : DelayElement
	GENERIC MAP ( DELAYCOUNT => 4)
	PORT MAP (
		CLK => clk,
		resetIN => reset,
		input.value => xIN,
		input.phase => phaseIN,
		output.value => xOUT3,
		output.phase => phaseOUT3
	);

	UUT_DELAY_0 : DelayElement
	GENERIC MAP ( DELAYCOUNT => 0)
	PORT MAP (
		CLK => clk,
		resetIN => reset,
		input.value => xIN,
		input.phase => phaseIN,
		output.value => xOUT4,
		output.phase => phaseOUT4
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
	phaseIN <= '0';
	xIN <= "1111111111111111111111111111111100000000000000000000000000000000";
	wait until rising_edge(clk);
	xIN <= "0000000000000000000000000000001000000000000000000000000000000000";
	wait until rising_edge(clk);
	xIN <= "1111111111111111111111111111110000000000000000000000000000000000";
	wait until rising_edge(clk);
	xIN <= "0000000000000000000000000000100000000000000000000000000000000000";
	wait until rising_edge(clk);
	phaseIN <= '1';
	xIN <= "1111111111111111111111111111000000000000000000000000000000000000";
	wait until rising_edge(clk);
	xIN <= "0000000000000000000000000000001100000000000000000000000000000000";
	wait until rising_edge(clk);
	xIN <= "1111111111111111111111111110000000000000000000000000000000000000";
	wait until rising_edge(clk);
	xIN <= "0000000000000000000000000100000000000000000000000000000000000000";
	wait until rising_edge(clk);


WAIT;
END PROCESS always;
END DelayElement_arch;
