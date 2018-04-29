-- Copyright (C) 2017  Intel Corporation. All rights reserved.
-- Your use of Intel Corporation's design tools, logic functions
-- and other software and tools, and its AMPP partner logic
-- functions, and any output files from any of the foregoing
-- (including device programming or simulation files), and any
-- associated documentation or information are expressly subject
-- to the terms and conditions of the Intel Program License
-- Subscription Agreement, the Intel Quartus Prime License Agreement,
-- the Intel FPGA IP License Agreement, or other applicable license
-- agreement, including, without limitation, that your use is for
-- the sole purpose of programming logic devices manufactured by
-- Intel and sold by Intel or its authorized distributors.  Please
-- refer to the applicable agreement for further details.

-- Vhdl Test Bench for design  :  InnerCE
--
-- Simulation tool : ModelSim-Altera (VHDL)
--

LIBRARY ieee;
USE ieee.std_logic_1164.all;

use work.computing_elements_ports_pkg.all;

library ieee_proposed;
use ieee_proposed.fixed_pkg.all;

ENTITY SystolicArray_vhd_tst IS
END SystolicArray_vhd_tst;
ARCHITECTURE SystolicArray_arch OF SystolicArray_vhd_tst IS
-- constants
constant Clk_period : time := 10 ns;
-- signals
signal clk : std_logic := '0';

signal column1Value: x_type := "0000000000000000000000000000010000000000000000000000000000000000";
signal column1Phase: STD_LOGIC := '0';
signal column2Value: x_type := "0000000000000000000000000000010000000000000000000000000000000000";
signal column2Phase: STD_LOGIC := '0';
signal column3Value: x_type := "0000000000000000000000000000010000000000000000000000000000000000";
signal column3Phase: STD_LOGIC := '0';
signal column4Value: x_type := "0000000000000000000000000000010000000000000000000000000000000000";
signal column4Phase: STD_LOGIC := '0';
signal column5Value: x_type := "0000000000000000000000000000010000000000000000000000000000000000";
signal column5Phase: STD_LOGIC := '0';
signal column6Value: x_type := "0000000000000000000000000000010000000000000000000000000000000000";
signal column6Phase: STD_LOGIC := '0';
signal column7Value: x_type := "0000000000000000000000000000010000000000000000000000000000000000";
signal column7Phase: STD_LOGIC := '0';
signal column8Value: x_type := "0000000000000000000000000000010000000000000000000000000000000000";
signal column8Phase: STD_LOGIC := '0';


COMPONENT SystolicArray
	PORT (
	clk : in STD_LOGIC;
	input : in SystolicArray_IN;
	output :  out SystolicArray_OUT
	);
END COMPONENT;
BEGIN
	UUT : SystolicArray
	PORT MAP (
-- list connections between master ports and signals
	clk => clk,
		input.column1.value => column1Value,
		input.column1.phase => column1Phase,
		input.column2.value => column2Value,
		input.column2.phase => column2Phase,
		input.column3.value => column3Value,
		input.column3.phase => column3Phase,
		input.column4.value => column4Value,
		input.column4.phase => column4Phase,
		input.column5.value => column5Value,
		input.column5.phase => column5Phase,
		input.column6.value => column6Value,
		input.column6.phase => column6Phase,
		input.column7.value => column7Value,
		input.column7.phase => column7Phase,
		input.column8.value => column8Value,
		input.column8.phase => column8Phase
	);
	
		
init : PROCESS
-- variable declarations
BEGIN
        -- code that executes only once
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
		wait for 10 ns;
		column1Value <= "0000000000000000000000000000100000000000000000000000000000000000";
		column1Phase <= '0';
		column2Value <= "0000000000000000000000000000100000000000000000000000000000000000";
		column2Phase <= '0';
		column3Value <= "0000000000000000000000000000100000000000000000000000000000000000";
		column3Phase <= '0';
		column4Value <= "0000000000000000000000000000100000000000000000000000000000000000";
		column4Phase <= '0';
		column5Value <= "0000000000000000000000000000100000000000000000000000000000000000";
		column5Phase <= '0';
		column6Value <= "0000000000000000000000000000100000000000000000000000000000000000";
		column6Phase <= '0';
		column7Value <= "0000000000000000000000000000100000000000000000000000000000000000";
		column7Phase <= '0';
		column8Value <= "0000000000000000000000000000100000000000000000000000000000000000";
		column8Phase <= '0';
		wait for 10 ns;
WAIT;
END PROCESS always;
END SystolicArray_arch;
