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
--use ieee.fixed_pkg.all;

use work.computing_elements_ports_pkg.all;
library ieee_proposed;
use ieee_proposed.fixed_pkg.all;

ENTITY OutterCE_vhd_tst IS
END OutterCE_vhd_tst;
ARCHITECTURE OutterCE_arch OF OutterCE_vhd_tst IS
-- constants
constant Clk_period : time := 10 ns;
-- signals
signal clk : std_logic := '0';
SIGNAL x : x_type := xType_zero_constant;
SIGNAL m : x_type;
SIGNAL s : STD_LOGIC;
SIGNAL phaseIN : STD_LOGIC;
SIGNAL PhaseOUT : STD_LOGIC;


COMPONENT OutterCE
	PORT (
	CLK : in STD_LOGIC;
	input : in outterCE_IN;
	output :  out outterCE_OUT
	);
END COMPONENT;
BEGIN
	i1 : OutterCE
	PORT MAP (
-- list connections between master ports and signals
	CLK => clk,
	input.x => x,
	input.phase => phaseIN,
	output.m => m,
	output.s => s
--	output.phase => phaseOUT
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

--		--all branches
--		wait until rising_edge(clk);
--		wait until rising_edge(clk);
--		wait until rising_edge(clk); -- unknown values flowing in (not defined)
--		phaseIN <= '0';
--		wait until rising_edge(clk); --1.
--		x <= "1111111111111111111111111111111100000000000000000000000000000000";
--		wait until rising_edge(clk); --2.
--		x <= "1111111111111111111111111111111000000000000000000000000000000000";
--		wait until rising_edge(clk); --3.
--		x <= "0000000000000000000000000000000000000000000000000000000000000000";
--		wait until rising_edge(clk); --4.
--		x <= "0000000000000000000000000000000000000000000000000000000000000000";
--		wait until rising_edge(clk); --5.
--		phaseIN <= '1';
--		x <= "0000000000000000000000000000000000000000000000000000000000000000";
--		wait until rising_edge(clk); --6.
--		wait for 30 ns;


		--oe_2_1 start test case
		phaseIN <= '0';
		wait until rising_edge(clk); --1.
		x <= "0000000000000000000000000000000000000000000000000000000000000000"; --0
		wait until rising_edge(clk); --2.
		x <= "0000000000000000000000000000000100000000000000000000000000000000";
		wait until rising_edge(clk); --3.
		x <= "0000000000000000000000000000000000000000000000000000000000000000";
		wait until rising_edge(clk); --4.
		x <= "0000000000000000000000000000000000000000000000000000000000000000";
		wait until rising_edge(clk); --5.
		phaseIN <= '1';
		x <= "0000000000000000000000000000000000000000000000000000000000000000";
		wait until rising_edge(clk); --6.
		wait for 30 ns;


		phaseIN <= '0';
		x <= "0000000000000000000000000000000100000000000000000000000000000000";
		wait until rising_edge(clk);
		x <= "0000000000000000000000000000000000000000000000000000000000000000";
		wait until rising_edge(clk);
		x <= "0000000000000000000000000000000000000000000000000000000000000000";
		wait until rising_edge(clk);
		x <= "0000000000000000000000000000000000000000000000000000000000000000";
		wait until rising_edge(clk);
		phaseIN <= '1';
		x <= "0000000000000000000000000000000100000000000000000000000000000000";
		wait until rising_edge(clk);
		x <= "0000000000000000000000000000000100000000000000000000000000000000";
		wait until rising_edge(clk);
		phaseIN <= '0'; --First phase
		--TEST CASE ### 1
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

		wait for 20 ns;
		phaseIN <= '1'; --Second phase
		x <= xType_zero_constant;
		wait for 10 ns;
		x <= "1111111111111111111111111111010000000000000000000000000000000000";
		wait for 10 ns;
		x <= "0000000000000000000000000001111000000000000000000000000000000000";
		wait for 10 ns;
		x <= xType_one;
		wait for 10 ns;
		x <= "1111111111111111111111111111110000000000000000000000000000000000";
		wait for 10 ns;
		x <= "0000000000000000000010111011100000000000000000000000000000000000";
		wait for 10 ns;


WAIT;
END PROCESS always;
END OutterCE_arch;
