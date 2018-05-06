LIBRARY ieee ;
USE ieee.std_logic_1164.all ;
use IEEE.STD_LOGIC_signed.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

library ieee_proposed;
use ieee_proposed.fixed_pkg.all;

use work.computing_elements_ports_pkg.all;
--This entity applies DelayElement to input
entity InputController is
	PORT(
  --ROM?
    CLK: in STD_LOGIC;
		reset: in STD_LOGIC;
		input: in SystolicArray_IN;
    output: out SystolicArray_OUT
	);
end InputController;

architecture structure of InputController is
	type columnS is array (7 downto 0) of valueAndPhase;
	-- type allSignals is array(7 downto 1) of columnSignals;
--local signals
signal columnSignals : columnS;
-- signal column1, column2, column3, column4 : columnSignals; -- A, C
-- signal column5, column6, column7, column8 : columnSignals; -- B, D

component DelayElement
	GENERIC(DELAYCOUNT : INTEGER);
	PORT(
    CLK: in STD_LOGIC;
		resetIN: in STD_LOGIC;
		input: in valueAndPhase;
    output: out valueAndPhase
	);
end component;

component SystolicArray
	PORT(
    CLK: in STD_LOGIC;
		input: in SystolicArray_IN;
    output: out SystolicArray_OUT
	);
end component;

begin

	systolicArr : SystolicArray PORT MAP(
		CLK => CLK,
		input.column1 => columnSignals(0), -- could be just column signals;
		input.column2 => columnSignals(1),
		input.column3 => columnSignals(2),
		input.column4 => columnSignals(3),
		input.column5 => columnSignals(4),
		input.column6 => columnSignals(5),
		input.column7 => columnSignals(6),
		input.column8 => columnSignals(7),
		output => output
	);

	-- delay functionality
	-- column1 <= input.column1; -- first column has no delay

	DELAY_0 : DelayElement GENERIC MAP (DELAYCOUNT => 0)
	PORT MAP (
		CLK => CLK, resetIN => reset, input => input.column1,
		output => columnSignals(0)
	);

	DELAY_1 : DelayElement GENERIC MAP (DELAYCOUNT => 1)
	PORT MAP (
		CLK => CLK, resetIN => reset, input => input.column2,
		output => columnSignals(1)
	);

	DELAY_2 : DelayElement GENERIC MAP (DELAYCOUNT => 2)
	PORT MAP (
		CLK => CLK, resetIN => reset, input => input.column3,
		output => columnSignals(2)
	);

	DELAY_3 : DelayElement GENERIC MAP (DELAYCOUNT => 3)
	PORT MAP (
		CLK => CLK, resetIN => reset, input => input.column4,
		output => columnSignals(3)
	);

	DELAY_4 : DelayElement GENERIC MAP (DELAYCOUNT => 4)
	PORT MAP (
		CLK => CLK, resetIN => reset, input => input.column5,
		output => columnSignals(4)
	);

	DELAY_5 : DelayElement GENERIC MAP (DELAYCOUNT => 5)
	PORT MAP (
		CLK => CLK, resetIN => reset, input => input.column6,
		output => columnSignals(5)
	);

	DELAY_6 : DelayElement GENERIC MAP (DELAYCOUNT => 6)
	PORT MAP (
		CLK => CLK, resetIN => reset, input => input.column7,
		output => columnSignals(6)
	);

	DELAY_7 : DelayElement GENERIC MAP (DELAYCOUNT => 7)
	PORT MAP (
		CLK => CLK, resetIN => reset, input => input.column8,
		output => columnSignals(7)
	);

end structure;
