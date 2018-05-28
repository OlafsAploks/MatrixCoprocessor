LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.fixed_pkg.all;

use work.computing_elements_ports_pkg.all;

ENTITY IC_SysArray_vhd_tst IS
END IC_SysArray_vhd_tst;
ARCHITECTURE InputContr_SYSARRAY_arch OF IC_SysArray_vhd_tst IS
-- constants
constant Clk_period : time := 10 ns;
-- signals
signal clk : std_logic := '0';
signal dataIN : SystolicArray_IN;
signal dataOUT : SystolicArray_OUT;
signal reset, en : STD_LOGIC;
signal op : STD_LOGIC_VECTOR(3 downto 0);
signal A, B : columnsignals;
signal sysarrIN : SystolicArray_IN;

component InputControllerPerf is
	PORT(
  --ROM?
    CLK: in STD_LOGIC;
		enable: in STD_LOGIC;
    -- dimensions (n * n): in STD_LOGIC;
		operation: STD_LOGIC_VECTOR(3 downto 0);
		A: in columnSignals; --Memory
		B: in columnSignals; --Memory
		reset: in STD_LOGIC;
		-- input: in InputController_IN;
    output: out SystolicArray_IN
	);
end component;

begin

UUT : InputControllerPerf PORT MAP (
  CLK       => clk,
  enable    => en,
  operation => op,
  A         => A,
  B         => B,
  reset     => reset,
  output    => sysarrIN
);

Clk_process : process
   begin
		clk <= '0';
		wait for Clk_period/2;
		clk <= '1';
		wait for Clk_period/2;
   end process Clk_process;

   init : PROCESS
   -- variable declarations
   BEGIN
    B(0) <= "0000100100000000"; B(8) <= "0000100000000000";
    B(1) <= "0000010100000000"; B(9) <= "0000010000000000";
    B(2) <= "0000100100000000"; B(10) <= "0000100000000000";
    B(3) <= "0000010100000000"; B(11) <= "0000010000000000";

    B(4) <= "0000011100000000"; B(12) <= "0000011000000000";
    B(5) <= "0000001100000000"; B(13) <= "0000001000000000";
    B(6) <= "0000011100000000"; B(14) <= "0000011000000000";
    B(7) <= "0000001100000000"; B(15) <= "0000001000000000";

    populateAram : for i in 0 to 15 loop
      A(i) <= "0000101000000000";
    end loop;
   WAIT;
   END PROCESS init;


always : PROCESS
-- optional sensitivity list
-- (        )
-- variable declarations
BEGIN
wait until rising_edge(clk);
wait until rising_edge(clk);
op <= "0001";
en <= '1';
reset <= '1';

WAIT;
END PROCESS always;
END InputContr_SYSARRAY_arch;
