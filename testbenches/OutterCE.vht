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

-- ***************************************************************************
-- This file contains a Vhdl test bench template that is freely editable to
-- suit user's needs .Comments are provided in each section to help the user
-- fill out necessary details.
-- ***************************************************************************
-- Generated on "02/16/2018 15:32:28"

-- Vhdl Test Bench template for design  :  OutterCE
--
-- Simulation tool : ModelSim-Altera (VHDL)
--

LIBRARY ieee;
USE ieee.std_logic_1164.all;

use work.computing_elements_ports_pkg.all;

library ieee_proposed;
use ieee_proposed.fixed_pkg.all;

ENTITY OutterCE_vhd_tst IS
END OutterCE_vhd_tst;
ARCHITECTURE OutterCE_arch OF OutterCE_vhd_tst IS
-- constants
-- signals
SIGNAL x : x_type := xType_zero_constant;
SIGNAL m : x_type;
SIGNAL s : STD_LOGIC;


COMPONENT OutterCE
	PORT (
	input : in outterCE_IN;
	output :  out outterCE_OUT
	);
END COMPONENT;
BEGIN
	i1 : OutterCE
	PORT MAP (
-- list connections between master ports and signals
	input.x => x,
	output.m => m,
	output.s => s
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
		--TEST CASE ### 1
--		x <= "00000000000001001011000000000000"; -- 300 Xin > LocalX(init value)
--		wait for 10 ns;
--		x <= "00000000001011101110000000000000"; -- 3000 Xin > LocalX(300)
--		wait for 10 ns;
--		x <= xType_zero_constant;					  -- 0 Xin < LocalX(3000)
--		wait for 10 ns;
--		x <= "11111111111111111101000000000000"; -- -12 Xin < LocalX(0)
--		wait for 10 ns;
--		x <= "00000000000000100000000000000000"; -- 300 Xin < LocalX(1500)
		
		--TEST CASE ### 2
		x <= xType_zero_constant;																 -- |0| Xin = |LocalX(init = 0)|		 | IF -> if(false);
		wait for 10 ns;
		x <= "1111111111111111111111111111010000000000000000000000000000000000"; -- |-12| Xin > |LocalX(0)| 			 | IF -> if(true);
		wait for 10 ns;
		x <= "0000000000000000000000000001111000000000000000000000000000000000"; -- |30| Xin > |LocalX(-12)|  		 | IF -> if(true);
		wait for 10 ns;
		x <= xType_one;																 			 -- |1| Xin < LocalX(30)				 | ELSE
		wait for 10 ns;
		x <= "1111111111111111111111111111110000000000000000000000000000000000"; -- -4 Xin < LocalX(30)					 | ELSE
		wait for 10 ns;
		x <= "0000000000000000000010111011100000000000000000000000000000000000"; -- 3000 Xin > LocalX(30)				 | IF -> if(true);
		wait for 10 ns;
WAIT;
END PROCESS always;
END OutterCE_arch;
