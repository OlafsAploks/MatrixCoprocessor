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
	datain	:	IN  STD_LOGIC_VECTOR (15 DOWNTO 0);
	dataio	:	INOUT  STD_LOGIC_VECTOR (15 DOWNTO 0);
	dataout	:	OUT  STD_LOGIC_VECTOR (15 DOWNTO 0);
	oe	:	IN  STD_LOGIC_VECTOR (15 DOWNTO 0)
	);
	END COMPONENT;
	--constants
	constant oeENABLE : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
	constant oeDISABLE : STD_LOGIC_VECTOR(15 downto 0) := (others => '1');
	--local signals
	signal read_enabled, write_enabled : STD_LOGIC := '0';
	signal address : STD_LOGIC_VECTOR(17 downto 0) := (others => '0');
	signal ce, we, oe, ub, lb : STD_LOGIC;
	signal data_out : STD_LOGIC_VECTOR(15 downto 0) := (others => '0'); --data that comes out of memory
	signal data_in : STD_LOGIC_VECTOR(15 downto 0); --data that needs to be written in memory
	signal oeVector : STD_LOGIC_VECTOR(15 downto 0);
	-- 0 => add, 1 => subtract, 2 => multiplication, 3 => Inversion
	signal operation : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
	--local memory
	type columnsignals is array(15 downto 0) of x_type;
	-- signal column1, column2, column3, column4,
	-- 			 column5, column6, column7, column8 : columnsignals;
	signal A, B : columnSignals;
	signal memoryIndex: INTEGER := 0;
	--TEEEEEEEEEMP
	signal dividedClock: STD_LOGIC := '0';
	signal divideCounter: STD_LOGIC_VECTOR(26 downto 0):= (others => '0');
	signal SWvalues : STD_LOGIC_VECTOR(8 downto 0) := (others => '0');
	signal array_data : x_type;
	signal array_counter : INTEGER := 0;
	signal clocky : STD_LOGIC := '0';
	signal convertToSignal : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
	signal enable : STD_LOGIC := '0';
begin
--TESTING ZONE
testigais : process(SW(1), dividedClock)
begin
	if dividedClock = '1' and dividedClock'event then
		if enable = '1' then
			if SW(1) = '1' then
				array_data <= A(array_counter);
				array_counter <= array_counter + 1;
			elsif SW(1) = '0' then
				array_data <= B(array_counter);
				array_counter <= array_counter + 1;
			end if;
			convertToSignal <= to_slv(array_data);
		elsif enable = '0' then
			array_counter <= 0;
		end if;
	end if;
end process;
LEDG <= convertToSignal(7 downto 0);
LEDR(7 downto 0) <= convertToSignal(15 downto 8);

read_enabled <= SW(0);
LEDR(8) <= read_enabled;
--
SRAM_A <= address;
SRAM_CE_n <= ce;
SRAM_UB_n <= ub;
SRAM_LB_n <= lb;
SRAM_OE_n <= oe;
SRAM_WE_n <= we;

MemoryBuffer_inst : MemoryBuffer PORT MAP (
		datain	 => data_in,
		oe	 => oeVector,
		dataio	 => SRAM_D,
		dataout	 => data_out
	);

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

MEM_READ : process(dividedClock)
begin
	if dividedClock = '1' and dividedClock'event then
		if enable = '0' then
			if memoryIndex < 16 then
				A(memoryIndex) <= to_sfixed(data_out, A(0)'high, A(0)'low);
				memoryIndex <= memoryIndex + 1;
				enable <= '0';
			elsif memoryIndex = 16 then
				operation <= data_out(3 downto 0);
				memoryIndex <= memoryIndex + 1;
				enable <= '0';
			elsif memoryIndex < 33 then--< 33 then
				B(memoryIndex) <= to_sfixed(data_out, A(0)'high, A(0)'low);
				memoryIndex <= memoryIndex + 1;
				enable <= '0';
			else
				enable <= '1';
			-- 	memoryIndex <= 0;
			end if;
		else
			memoryIndex <= 0;
		end if;
	end if;
end process;


--CLOCK STUFF

divider : process(CLOCK_50_B5B)
begin
	if CLOCK_50_B5B='1' and CLOCK_50_B5B'event then
		divideCounter <= divideCounter + '1';
		dividedClock <= divideCounter(23);
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
