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

ENTITY InnerCE_vhd_tst IS
END InnerCE_vhd_tst;
ARCHITECTURE InnerCE_arch OF InnerCE_vhd_tst IS
-- constants
-- signals
SIGNAL xIN, xOUT : x_type;
SIGNAL mIN, mOUT : x_type;
SIGNAL sIN, sOUT : STD_LOGIC;

SIGNAL temp1, temp2 : x_type;


COMPONENT InnerCE
	PORT (
	input : in innerCE_IN;
	output :  out innerCE_OUT
	);
END COMPONENT;
BEGIN
	UUT : InnerCE
	PORT MAP (
-- list connections between master ports and signals
	input.x => xIN,
	input.m => mIN,
	input.s => sIN,
	output.m => mOUT,
	output.x => xOUT,
	output.s => sOUT
	);
	
		
init : PROCESS
-- variable declarations
BEGIN
        -- code that executes only once
WAIT;
END PROCESS init;
always : PROCESS
-- optional sensitivity list
-- (        )
-- variable declarations
BEGIN
		--00000000000000000000000000011110.00000000000000000000000000000000
		--TEST CASE ### 1
--		temp1 <= "0000000000000000000000000000010000000000000000000000000000000000"; -- 4
--		temp2 <= "0000000000000000000000000000101000000000000000000000000000000000"; -- 10
--		xIN <= resize(temp1/temp2, temp1'high, temp1'low); -- 0.4
--		mIN <= resize(temp2/temp1, temp1'high, temp1'low); -- 2.5

		sIN <= '1';
		xIN <= "0000000000000000000000100000001000001000100000000000000000000000";
		mIN <= "0000000000000000000000000001100010000000000000000000000000000000";
		wait for 10 ns;
		sIN <= '0';
		xIN <= "0000000000000000000000000000010000000000000000000000000000000000"; --4
		mIN <= "0000000000000000000000000000101000000000000000000000000000000000"; --10
		wait for 10 ns;
		sIN <= '1';
		xIN <= "0000000000000000000000000001111011000000000000000000000000000000"; --30.75
		mIN <= "0000000000000000000000000000101000000000000000000000000000000000"; --10 
		wait for 10 ns;
		sIN <= '1';
		xIN <= xType_zero_constant;
		mIN <= xType_one;
		wait for 10 ns;
		sIN <= '0';
		xIN <= "0000000000000000000000000001111000110000000000000000000000000000"; --30.1875
		mIN <= "0000000000000000000000000001111000001100000000000000000000000000"; --30.0469
		wait for 10 ns;
		sIN <= '0';
		xIN <= xType_one;
		mIN <= xType_zero_constant;
WAIT;
END PROCESS always;
END InnerCE_arch;
