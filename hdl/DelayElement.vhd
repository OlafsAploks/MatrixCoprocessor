LIBRARY ieee ;
USE ieee.std_logic_1164.all ;
use IEEE.STD_LOGIC_signed.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use ieee.fixed_pkg.all;

-- library ieee_proposed;
-- use ieee_proposed.fixed_pkg.all;

use work.computing_elements_ports_pkg.all;

entity DelayElement is
	GENERIC(DELAYCOUNT : INTEGER);
	PORT(
  --ROM?
    CLK: in STD_LOGIC;
		resetIN: in STD_LOGIC;
		input: in valueAndPhase;
    output: out valueAndPhase
	);
end DelayElement;

architecture structure of DelayElement is
type storedsignals is array (7 downto 0) of valueAndPhase;
--local signals
--counter counts delayed cycles
--reader outputs saved values once DELAYCOUNT is reached
signal counter, reader : INTEGER := 0;
signal store : storedsignals;

begin
	delayprocess : process(CLK)
	begin
		if CLK='1' and CLK'event then
			if counter < DELAYCOUNT then
				store(counter) <= input;
				output <= defaultValueAndPhase;
				counter <= counter + 1;
			else
				if counter < 8 then
					store(counter) <= input;
					counter <= counter + 1;
				end if;
				if reader < 8 then
					output <= store(reader);
					reader <= reader + 1;
				end if;
			end if;
		end if;
	end process;
end structure;
