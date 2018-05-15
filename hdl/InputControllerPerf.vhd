LIBRARY ieee ;
USE ieee.std_logic_1164.all ;
use IEEE.STD_LOGIC_signed.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

library ieee_proposed;
use ieee_proposed.fixed_pkg.all;

use work.computing_elements_ports_pkg.all;
--This entity applies DelayElement to input
entity InputControllerPerf is
	PORT(
  --ROM?
    CLK: in STD_LOGIC;
    -- enable: in STD_LOGIC;
		reset: in STD_LOGIC;
		input: in InputController_IN;
    output: out SystolicArray_IN
	);
end InputControllerPerf;

architecture structure of InputControllerPerf is
	type columnS is array (7 downto 0) of valueAndPhase;
	type convertedSignals is array (8 downto 1)  of x_type;
	-- type allSignals is array(7 downto 1) of columnSignals;
--local signals
signal columnSignals : columnS;
-- signal column1, column2, column3, column4 : columnSignals; -- A, C
-- signal column5, column6, column7, column8 : columnSignals; -- B, D
signal counter : INTEGER := 0;
signal convSignals : convertedSignals;

component DelayElementPerf
	GENERIC(DELAYCOUNT : INTEGER);
	PORT(
		CLK: in STD_LOGIC;
		resetIN: in STD_LOGIC;
		input: in x_type;
		output: out valueAndPhase
	);
end component;
begin

	convSignals(1) <= to_sfixed(input(1), convSignals(1));
	convSignals(2) <= to_sfixed(input(2), convSignals(2));
	convSignals(3) <= to_sfixed(input(3), convSignals(3));
	convSignals(4) <= to_sfixed(input(4), convSignals(4));
	convSignals(5) <= to_sfixed(input(5), convSignals(5));
	convSignals(6) <= to_sfixed(input(6), convSignals(6));
	convSignals(7) <= to_sfixed(input(7), convSignals(7));
	convSignals(8) <= to_sfixed(input(8), convSignals(8));

	output.column1 <= columnSignals(0);
	output.column2 <= columnSignals(1);
	output.column3 <= columnSignals(2);
	output.column4 <= columnSignals(3);
	output.column5 <= columnSignals(4);
	output.column6 <= columnSignals(5);
	output.column7 <= columnSignals(6);
	output.column8 <= columnSignals(7);


	DELAY_0 : DelayElementPerf GENERIC MAP (DELAYCOUNT => 0)
	PORT MAP (
		CLK => CLK, resetIN => reset, input => convSignals(1),
		output => columnSignals(0)
	);

	DELAY_1 : DelayElementPerf GENERIC MAP (DELAYCOUNT => 1)
	PORT MAP (
		CLK => CLK, resetIN => reset, input => convSignals(2),
		output => columnSignals(1)
	);

	DELAY_2 : DelayElementPerf GENERIC MAP (DELAYCOUNT => 2)
	PORT MAP (
		CLK => CLK, resetIN => reset, input => convSignals(3),
		output => columnSignals(2)
	);

	DELAY_3 : DelayElementPerf GENERIC MAP (DELAYCOUNT => 3)
	PORT MAP (
		CLK => CLK, resetIN => reset, input => convSignals(4),
		output => columnSignals(3)
	);

	DELAY_4 : DelayElementPerf GENERIC MAP (DELAYCOUNT => 4)
	PORT MAP (
		CLK => CLK, resetIN => reset, input => convSignals(5),
		output => columnSignals(4)
	);

	DELAY_5 : DelayElementPerf GENERIC MAP (DELAYCOUNT => 5)
	PORT MAP (
		CLK => CLK, resetIN => reset, input => convSignals(6),
		output => columnSignals(5)
	);

	DELAY_6 : DelayElementPerf GENERIC MAP (DELAYCOUNT => 6)
	PORT MAP (
		CLK => CLK, resetIN => reset, input => convSignals(7),
		output => columnSignals(6)
	);

	DELAY_7 : DelayElementPerf GENERIC MAP (DELAYCOUNT => 7)
	PORT MAP (
		CLK => CLK, resetIN => reset, input => convSignals(8),
		output => columnSignals(7)
	);

end structure;
