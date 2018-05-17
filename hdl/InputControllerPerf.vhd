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
		enable: in STD_LOGIC;
    -- dimensions (n * n): in STD_LOGIC;
		operation: STD_LOGIC_VECTOR(3 downto 0);
		A: in columnSignals; --Memory
		B: in columnSignals; --Memory
		reset: in STD_LOGIC;
		-- input: in InputController_IN;
    output: out SystolicArray_IN
	);
end InputControllerPerf;

architecture structure of InputControllerPerf is
	type columnS is array (7 downto 0) of valueAndPhase;
	type convertedSignals is array (8 downto 1)  of x_type;
--local signals
signal cs : columnS;
signal counter : INTEGER := 0;
signal convSignals : convertedSignals;
--------------------------
type toBeConverted is array (15 downto 0) of data_from_memory;
signal tbc : toBeConverted;
signal matrixA, matrixB, matrixC, matrixD, Neg_matrix : columnsignals;
signal toConvert : InputController_IN;
--------------------------
signal RAMtoInputController : data_from_memory;
signal enableInputController : STD_LOGIC := '0';
type RAMoutCounter is array(4 downto 1) of INTEGER;
signal RAMindexCounter, RAMindexCounterSec : RAMoutCounter := (1 => 0,
																							2 => 4,
																							3 => 8,
																							4	=> 12);

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

setup_input : process(A,B,operation)
begin
	if CLK='1' and CLK'event then
		if operation = "0010" then --multiplication
			TO_NEGATIVE_M_MULTIPLICATION : for i in 0 to 15 loop
				Neg_matrix(i) <= -A(i);
			end loop;
			matrixA <= identityMatrix;
			matrixB <= B;
			matrixC <= Neg_matrix;
			matrixD <= zeroMatrix;
		elsif operation = "0000" then --addition
			TO_NEGATIVE_M_ADDITION : for i in 0 to 15 loop
				Neg_matrix(i) <= -B(i);
			end loop;
			matrixA <= identityMatrix;
			matrixB <= identityMatrix;
			matrixC <= Neg_matrix; --minus B
			matrixD <= A;
		elsif operation = "0001" then --subtraction
			matrixA <= identityMatrix;
			matrixB <= identityMatrix;
			matrixC <= B;
			matrixD <= A;
		elsif operation = "0011" then --Inversion
			matrixA <= A;
			matrixB <= identityMatrix;
			matrixC <= N_identityMatrix; --NEGATIVE vienibas matrica
			matrixD <= zeroMatrix;
		-- elsif expression then --division?
		end if;
	end if;
end process;

deliver_input : process(CLK, enable)
begin
	if enable = '1' then
		if CLK='1' and CLK'event then
			if counter < 4 then -- A and B
				toConvert(1) <= matrixA(RAMindexCounter(1));
				toConvert(2) <= matrixA(RAMindexCounter(2));
				toConvert(3) <= matrixA(RAMindexCounter(3));
				toConvert(4) <= matrixA(RAMindexCounter(4));
				toConvert(5) <= matrixB(RAMindexCounter(1));
				toConvert(6) <= matrixB(RAMindexCounter(2));
				toConvert(7) <= matrixB(RAMindexCounter(3));
				toConvert(8) <= matrixB(RAMindexCounter(4));
				increment_counter : for i in 1 to 4 loop
					RAMindexCounter(i) <= RAMindexCounter(i) + 1;
				end loop;
				enableInputController <= '1';
			elsif counter < 8 then --C and D
				toConvert(1) <= matrixC(RAMindexCounterSec(1));
				toConvert(2) <= matrixC(RAMindexCounterSec(2));
				toConvert(3) <= matrixC(RAMindexCounterSec(3));
				toConvert(4) <= matrixC(RAMindexCounterSec(4));
				toConvert(5) <= matrixD(RAMindexCounterSec(1));
				toConvert(6) <= matrixD(RAMindexCounterSec(2));
				toConvert(7) <= matrixD(RAMindexCounterSec(3));
				toConvert(8) <= matrixD(RAMindexCounterSec(4));
				increment_counter2 : for i in 1 to 4 loop
					RAMindexCounterSec(i) <= RAMindexCounterSec(i) + 1;
				end loop;
				enableInputController <= '1';
			-- else
			-- 	RAMindexCounter <= (1 => 0, 2 => 4,	3 => 8,	4	=> 12);
			-- 	RAMindexCounterSec <= (1 => 0, 2 => 4,	3 => 8,	4	=> 12);
			-- 	enableInputController <= '0';
			end if;
			counter <= counter + 1;
		end if;
	elsif enable = '0' then
		counter <= 0;
		RAMindexCounter <= (1 => 0, 2 => 4,	3 => 8,	4	=> 12);
		RAMindexCounterSec <= (1 => 0, 2 => 4,	3 => 8,	4	=> 12);
	end if;
end process;

	convSignals(1) <= to_sfixed(toConvert(1), convSignals(1));
	convSignals(2) <= to_sfixed(toConvert(2), convSignals(2));
	convSignals(3) <= to_sfixed(toConvert(3), convSignals(3));
	convSignals(4) <= to_sfixed(toConvert(4), convSignals(4));
	convSignals(5) <= to_sfixed(toConvert(5), convSignals(5));
	convSignals(6) <= to_sfixed(toConvert(6), convSignals(6));
	convSignals(7) <= to_sfixed(toConvert(7), convSignals(7));
	convSignals(8) <= to_sfixed(toConvert(8), convSignals(8));

	output.column1 <= cs(0);
	output.column2 <= cs(1);
	output.column3 <= cs(2);
	output.column4 <= cs(3);
	output.column5 <= cs(4);
	output.column6 <= cs(5);
	output.column7 <= cs(6);
	output.column8 <= cs(7);


	DELAY_0 : DelayElementPerf GENERIC MAP (DELAYCOUNT => 0)
	PORT MAP (
		CLK => CLK, resetIN => enableInputController, input => convSignals(1),
		output => cs(0)
	);

	DELAY_1 : DelayElementPerf GENERIC MAP (DELAYCOUNT => 1)
	PORT MAP (
		CLK => CLK, resetIN => enableInputController, input => convSignals(2),
		output => cs(1)
	);

	DELAY_2 : DelayElementPerf GENERIC MAP (DELAYCOUNT => 2)
	PORT MAP (
		CLK => CLK, resetIN => enableInputController, input => convSignals(3),
		output => cs(2)
	);

	DELAY_3 : DelayElementPerf GENERIC MAP (DELAYCOUNT => 3)
	PORT MAP (
		CLK => CLK, resetIN => enableInputController, input => convSignals(4),
		output => cs(3)
	);

	DELAY_4 : DelayElementPerf GENERIC MAP (DELAYCOUNT => 4)
	PORT MAP (
		CLK => CLK, resetIN => enableInputController, input => convSignals(5),
		output => cs(4)
	);

	DELAY_5 : DelayElementPerf GENERIC MAP (DELAYCOUNT => 5)
	PORT MAP (
		CLK => CLK, resetIN => enableInputController, input => convSignals(6),
		output => cs(5)
	);

	DELAY_6 : DelayElementPerf GENERIC MAP (DELAYCOUNT => 6)
	PORT MAP (
		CLK => CLK, resetIN => enableInputController, input => convSignals(7),
		output => cs(6)
	);

	DELAY_7 : DelayElementPerf GENERIC MAP (DELAYCOUNT => 7)
	PORT MAP (
		CLK => CLK, resetIN => enableInputController, input => convSignals(8),
		output => cs(7)
	);

end structure;
