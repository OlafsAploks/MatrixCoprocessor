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

ENTITY OutterCE_vhd_tst IS
END OutterCE_vhd_tst;
ARCHITECTURE OutterCE_arch OF OutterCE_vhd_tst IS
-- constants
-- signals
SIGNAL x : STD_LOGIC_VECTOR(8 DOWNTO 0);
SIGNAL m : STD_LOGIC_VECTOR(8 DOWNTO 0);
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
x <= "000000001";
wait for 10 ns;
x <= "000000100";
wait for 10 ns;
x <= "000001000";
wait for 10 ns;
x <= "000010000";
        -- code executes for every event on sensitivity list
WAIT;
END PROCESS always;
END OutterCE_arch;
