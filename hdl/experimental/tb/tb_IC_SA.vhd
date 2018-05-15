LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.fixed_pkg.all;

use work.computing_elements_ports_pkg.all;

ENTITY InputControllerToSystolicArray_vhd_tst IS
END InputControllerToSystolicArray_vhd_tst;
ARCHITECTURE InputControllerToSystolicArray_arch OF InputControllerToSystolicArray_vhd_tst IS
-- constants
constant Clk_period : time := 10 ns;
-- signals
signal clk : std_logic := '0';
signal dataIN : InputController_IN;
signal dataToSysArray : SystolicArray_IN;
signal SysArrayOUT : SystolicArray_OUT;
signal reset, en : STD_LOGIC;


COMPONENT InputControllerPerf
	PORT (
    CLK    : in STD_LOGIC;
    -- enable : in STD_LOGIC;
    reset  : in STD_LOGIC;
    input  : in InputController_IN;
    output : out SystolicArray_IN
	);
END COMPONENT;

COMPONENT SystolicArray
  PORT(
    CLK    : in STD_LOGIC;
    input  : in SystolicArray_IN;
    output : out SystolicArray_OUT
  );
END COMPONENT;
BEGIN

UUT_InController : InputControllerPerf PORT MAP (
  CLK    => clk,
  -- enable => en,
  reset  => reset,
  input  => dataIN,
  output => dataToSysArray
);

UUT_Delay : SystolicArray PORT MAP (
  CLK    => clk,
  input  => dataToSysArray,
  output => SysArrayOUT
);

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
wait until rising_edge(clk);
wait until rising_edge(clk);
reset <= '1';
--1
dataIN(1) <= "0000000100000000";
dataIN(2) <= "0000000000000000";
dataIN(3) <= "0000000000000000";
dataIN(4) <= "0000000000000000";
dataIN(5) <= "0000000110000000";
dataIN(6) <= "0000001000000000";
dataIN(7) <= "0000010000000000";
dataIN(8) <= "0000001100000000";
wait until rising_edge(clk);
--2
dataIN(1) <= "0000000000000000";
dataIN(2) <= "0000000100000000";
dataIN(3) <= "0000000000000000";
dataIN(4) <= "0000000000000000";
dataIN(5) <= "0000010000000000";
dataIN(6) <= "0000000111000000";
dataIN(7) <= "0000001000000000";
dataIN(8) <= "0000100000000000";
wait until rising_edge(clk);
--3
dataIN(1) <= "0000000000000000";
dataIN(2) <= "0000000000000000";
dataIN(3) <= "0000000100000000";
dataIN(4) <= "0000000000000000";
dataIN(5) <= "0000000100000000";
dataIN(6) <= "0000000000000000";
dataIN(7) <= "0000001010000000";
dataIN(8) <= "0000000000000000";
wait until rising_edge(clk);
--4
dataIN(1) <= "0000000000000000";
dataIN(2) <= "0000000000000000";
dataIN(3) <= "0000000000000000";
dataIN(4) <= "0000000100000000";
dataIN(5) <= "0000000000000000";
dataIN(6) <= "0000001000000000";
dataIN(7) <= "0000000101100000";
dataIN(8) <= "0000001000000000";
wait until rising_edge(clk);
--5
dataIN(1) <= "1111111100000000";
dataIN(2) <= "1111111000000000";
dataIN(3) <= "1111110100000000";
dataIN(4) <= "1111110000000000";
dataIN(5) <= "0000000000000000";
dataIN(6) <= "0000000000000000";
dataIN(7) <= "0000000000000000";
dataIN(8) <= "0000000000000000";
wait until rising_edge(clk);
--6
dataIN(1) <= "1111101100000000";
dataIN(2) <= "1111101000000000";
dataIN(3) <= "1111110100000000";
dataIN(4) <= "1111110001000000";
dataIN(5) <= "0000000000000000";
dataIN(6) <= "0000000000000000";
dataIN(7) <= "0000000000000000";
dataIN(8) <= "0000000000000000";
wait until rising_edge(clk);
--7
dataIN(1) <= "1111111100000000";
dataIN(2) <= "1111111111000000";
dataIN(3) <= "1111011100000000";
dataIN(4) <= "1111010110000000";
dataIN(5) <= "0000000000000000";
dataIN(6) <= "0000000000000000";
dataIN(7) <= "0000000000000000";
dataIN(8) <= "0000000000000000";
wait until rising_edge(clk);
--8
dataIN(1) <= "1111011100000000";
dataIN(2) <= "1111101000000000";
dataIN(3) <= "1111110100000000";
dataIN(4) <= "1111111100000000";
dataIN(5) <= "0000000000000000";
dataIN(6) <= "0000000000000000";
dataIN(7) <= "0000000000000000";
dataIN(8) <= "0000000000000000";
wait until rising_edge(clk);

WAIT;
END PROCESS always;
END InputControllerToSystolicArray_arch;
