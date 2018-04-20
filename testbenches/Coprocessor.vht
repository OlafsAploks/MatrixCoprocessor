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
-- Generated on "02/21/2018 14:46:49"
                                                            
-- Vhdl Test Bench template for design  :  Coprocessor
-- 
-- Simulation tool : ModelSim-Altera (VHDL)
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                

ENTITY Coprocessor_vhd_tst IS
END Coprocessor_vhd_tst;
ARCHITECTURE Coprocessor_arch OF Coprocessor_vhd_tst IS
-- constants                                                 
-- signals                                                   
SIGNAL input : STD_LOGIC;
SIGNAL output : STD_LOGIC;
COMPONENT Coprocessor
	PORT (
	input : IN STD_LOGIC;
	output : OUT STD_LOGIC
	);
END COMPONENT;
BEGIN
	i1 : Coprocessor
	PORT MAP (
-- list connections between master ports and signals
	input => input,
	output => output
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
        -- code executes for every event on sensitivity list
		  input <= '1';
		  wait for 100ns;
		  input <= '0';
		  wait for 100ns;
		  input <= '1';
WAIT;                                                        
END PROCESS always;                                          
END Coprocessor_arch;
