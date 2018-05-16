LIBRARY ieee ;
USE ieee.std_logic_1164.all ;
use IEEE.STD_LOGIC_signed.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use ieee.numeric_std;
library ieee_proposed;
use ieee_proposed.fixed_pkg.all;

use work.computing_elements_ports_pkg.all;
entity Coprocessor is
	PORT(
	--CLOCK??
		CLOCK_50_B5B: in STD_LOGIC;
		-- SRAM interface
		SRAM_A : out STD_LOGIC_VECTOR(17 downto 0);
		SRAM_D : inout STD_LOGIC_VECTOR(15 downto 0);
		SRAM_CE_n : out STD_LOGIC; --When CE is HIGH (deselected), the device assumes a standby mode
		SRAM_OE_n : out STD_LOGIC;
		SRAM_WE_n : out STD_LOGIC; --write enabled
		SRAM_LB_n : out STD_LOGIC; --Easy memory expansion is provided by using Chip Enable and Output Enable inputs
		SRAM_UB_n : out STD_LOGIC;
		--
		LEDG : out STD_LOGIC_VECTOR(7 downto 0);
		LEDR : out STD_LOGIC_VECTOR(9 downto 0);
		SW : in STD_LOGIC_VECTOR(9 downto 0)
	);
end Coprocessor;
architecture structure of Coprocessor is
	--I/O buffer
	COMPONENT MemoryBuffer PORT
	(
			datain  : IN  STD_LOGIC_VECTOR (15 DOWNTO 0);
			dataio  : INOUT  STD_LOGIC_VECTOR (15 DOWNTO 0);
			dataout : OUT  STD_LOGIC_VECTOR (15 DOWNTO 0);
			oe      : IN  STD_LOGIC_VECTOR (15 DOWNTO 0)
	);
	END COMPONENT;

	COMPONENT InputControllerPerf is
		PORT(
	  --ROM?
			CLK    : in STD_LOGIC;
			enable: in STD_LOGIC;
			operation: STD_LOGIC_VECTOR(3 downto 0);
			A: in columnSignals;
			B: in columnSignals;
			reset  : in STD_LOGIC;
			-- input  : in InputController_IN;
			output : out SystolicArray_IN
		);
	end COMPONENT;

	--types
	--constants
	constant oeENABLE : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
	constant oeDISABLE : STD_LOGIC_VECTOR(15 downto 0) := (others => '1');
	--local signals
	signal enable : STD_LOGIC := '0';
	signal read_enabled, write_enabled : STD_LOGIC := '0';
	signal address : STD_LOGIC_VECTOR(17 downto 0) := (others => '0');
	signal ce, we, oe, ub, lb : STD_LOGIC;
	signal data_out, write_pointer : STD_LOGIC_VECTOR(15 downto 0) := (others => '0'); --data that comes out of memory
	signal data_in : STD_LOGIC_VECTOR(15 downto 0) := "0000000001000001"; --data that needs to be written in memory
	signal oeVector : STD_LOGIC_VECTOR(15 downto 0);
	-- 0 => add, 1 => subtract, 2 => multiplication, 3 => Inversion
	signal operation : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
	--local memory
	-- signal column1, column2, column3, column4,
	-- 			 column5, column6, column7, column8 : columnsignals;
	signal A, B : columnSignals;
	signal memoryIndex: INTEGER := 0;
	--TEEEEEEEEEMP
	signal xtype_one: x_type := (0 => '1', others => '0');
	signal dividedClock: STD_LOGIC := '0';
	signal divideCounter: STD_LOGIC_VECTOR(26 downto 0):= (others => '0');
	signal SWvalues : STD_LOGIC_VECTOR(8 downto 0) := (others => '0');
	signal array_data : data_from_memory;
	signal array_counter : INTEGER := 0;
	signal clocky : STD_LOGIC := '0';
	signal convertToSignal : data_from_memory := (others => '0');
	signal cycleCounter : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
	signal enableCycleCounter: STD_LOGIC := '1';
	--MEM_READ local
	signal readingInA : STD_LOGIC := '1';
	-- DATA from RAM to InputController
	type RAMoutCounter is array(4 downto 1) of INTEGER;
	signal RAMindexCounter : RAMoutCounter := (1 => 0,
																								2 => 4,
																								3 => 8,
																								4	=> 12);
	signal RAMtoInputController: InputController_IN;
	signal enableInputController : STD_LOGIC := '0';
	--DATA from InputController
	signal DataFromInputController : SystolicArray_IN;
	--COMPONENT declaration
begin

	MemoryBuffer_inst : MemoryBuffer PORT MAP (
			datain  => data_in,
			oe      => oeVector,
			dataio  => SRAM_D,
			dataout => data_out
	);

	InputController_inst : InputControllerPerf PORT MAP (
			CLK       => dividedClock,
			enable    => enable,
			operation => operation,
			A         => A,
			B         => B,
			reset     => enableInputController,
			-- input     => RAMtoInputController,
			output    => DataFromInputController
	);

	convertToSignal <= to_slv(DataFromInputController.column8.value);
	-- -- LEDR(8) <= DataFromInputController.column3.phase;
	LEDR(8) <= enable;
	-- LEDG <= convertToSignal(7 downto 0);
	LEDG <= convertToSignal(15 downto 8);
	-- LEDR(7 downto 0) <= convertToSignal(15 downto 8);
	LEDR(7 downto 0) <= cycleCounter;
	-- enableCycleCounter <= SW(6);
	----
-- LEDG <= RAMtoInputController(2)(7 downto 0);
-- LEDR(7 downto 0) <= RAMtoInputController(2)(15 downto 8);
-- dataToInContr : process(SW(1), dividedClock)
-- begin
-- 	if dividedClock = '1' and dividedClock'event then
-- 		if enable = '1' then --done reading memory and writing to ram
-- 			enableInputController <= '1';
-- 			if RAMindexCounter(1) < 4 then
-- 				--each row has its own counter
-- 				RAMtoInputController(1) <= A(RAMindexCounter(1));
-- 				RAMtoInputController(2) <= A(RAMindexCounter(2));
-- 				RAMtoInputController(3) <= A(RAMindexCounter(3));
-- 				RAMtoInputController(4) <= A(RAMindexCounter(4));
-- 				RAMtoInputController(5) <= B(RAMindexCounter(1));
-- 				RAMtoInputController(6) <= B(RAMindexCounter(2));
-- 				RAMtoInputController(7) <= B(RAMindexCounter(3));
-- 				RAMtoInputController(8) <= B(RAMindexCounter(4));
-- 				addToCounter : for i in 1 to 4 loop
-- 					RAMindexCounter(i) <= RAMindexCounter(i) + 1;
-- 				end loop;
-- 			elsif RAMindexCounter(1) >= 4 then
-- 				RAMtoInputController <= (others => (others => '-'));
-- 				RAMindexCounter <= (1 => 0, 2 => 4, 3 => 8, 4 => 12);
-- 				--DONE GIVING DATA TO INPUT CONTROLLER
-- 			end if;
-- 		elsif enable = '0' then
-- 			RAMtoInputController <= (others => (others => '-'));
-- 			RAMindexCounter <= (1 => 0, 2 => 4, 3 => 8, 4 => 12);
-- 		end if;
-- 	end if;
-- end process;

read_enabled <= SW(0);
write_enabled <= SW(9);
-- LEDR(8) <= '1' when (read_enabled = '1' and write_enabled = '0') else
-- 					 '1' when (read_enabled = '0' and write_enabled = '1') else '0';
--
SRAM_A <= address;
SRAM_CE_n <= ce;
SRAM_UB_n <= ub;
SRAM_LB_n <= lb;
SRAM_OE_n <= oe;
SRAM_WE_n <= we;

MEM_SETUP : process(read_enabled)
begin
	if read_enabled = '1' then
		--READING
		oeVector <= (others => '0');
		ce <= '0';
		we <= '1';
		ub <= '0';
		lb <= '0';
		oe <= '0';
	elsif write_enabled = '1' then
		--WRITING
		oeVector <= (others => '1');
		ce <= '0';
		we <= '0';
		ub <= '0';
		lb <= '0';
		oe <= '1';
	else --STANDBY
		ce <= '1';
		we <= '1';
		oe <= '0';
		oeVector <= oeENABLE;
		ub <= '1';
		lb <= '1';
	end if;
end process;

--Reads data from SRAM and inserts them in local RAM
MEM_READ : process(dividedClock)
begin
	if dividedClock = '1' and dividedClock'event then
		if enable = '0' then
			if memoryIndex < 16 and readingInA='1' then
				A(memoryIndex) <= data_out;--to_sfixed(data_out, A(0)'high, A(0)'low);
				memoryIndex <= memoryIndex + 1;
				enable <= '0';
			elsif memoryIndex = 16 and readingInA='1' then
				operation <= data_out(3 downto 0);
				-- memoryIndex <= memoryIndex + 1;
				memoryIndex <= 0; -- resets index for B array (RAM)
				readingInA <= '0';
				enable <= '0';
			elsif memoryIndex < 16 and readingInA = '0' then--< 33 then
				B(memoryIndex) <= data_out;--to_sfixed(data_out, A(0)'high, A(0)'low);
				memoryIndex <= memoryIndex + 1;
				enable <= '0';
			else
				enable <= '1'; --done reading and writing in RAM
			-- 	memoryIndex <= 0;
			end if;
		else
			memoryIndex <= 0;
		end if;
	end if;
end process;

MEM_WRITE : process(dividedClock)
begin
	if dividedClock = '1' and dividedClock'event then
		if read_enabled = '0' and write_enabled = '1' then

		end if;
	end if;
end process;

--CLOCK STUFF

divider : process(CLOCK_50_B5B)
begin
	if CLOCK_50_B5B='1' and CLOCK_50_B5B'event then
		divideCounter <= divideCounter + '1';
		dividedClock <= divideCounter(22);
	end if;
end process;

address_counter : process(dividedClock, read_enabled, write_enabled)
begin
	if dividedClock='1' and dividedClock'event then
		if read_enabled = '1' then
			address <= address + '1';
		elsif write_enabled = '1' then
			address <= address + '1';
		else
			address <= (others => '0');
		end if;
	end if;
end process;

LEDR(9) <= clocky;
indicator : process(dividedClock)
begin
	if dividedClock = '1' and dividedClock'event then
		if enableCycleCounter='1' then
			if  to_slv(DataFromInputController.column8.value) = "0001000000000000" then
			-- if DataFromInputController.column3.phase = '1' then
			-- if DataFromInputController.column1.value = xType_one then
			-- if RAMtoInputController(1) = "0000000000000001" then
				enableCycleCounter <= '0';
				cycleCounter <= cycleCounter + '1';
			else
				cycleCounter <= cycleCounter + '1';
			end if;
		elsif enableCycleCounter = '0' then
			cycleCounter <= cycleCounter;
		end if;
		if clocky = '1' then
			clocky <= '0';
		else
			clocky <= '1';
		end if;
	end if;
end process;
-- TESTING Output

-- identifier : process(sensitivity_list)
-- begin
--
-- end process;

end structure;
