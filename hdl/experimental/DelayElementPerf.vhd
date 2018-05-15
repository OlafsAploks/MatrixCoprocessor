LIBRARY ieee ;
USE ieee.std_logic_1164.all ;
use IEEE.STD_LOGIC_signed.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
-- use ieee.fixed_pkg.all;

library ieee_proposed;
use ieee_proposed.fixed_pkg.all;

use work.computing_elements_ports_pkg.all;

entity DelayElementPerf is
	GENERIC(DELAYCOUNT : INTEGER := 0);
	PORT(
  --ROM?
    CLK: in STD_LOGIC;
		resetIN: in STD_LOGIC;
		input: in x_type;
    output: out valueAndPhase
	);
end DelayElementPerf;

architecture structure of DelayElementPerf is
type storedsignals is array (7 downto 0) of x_type;
--local signals
--counter counts delayed cycles
--reader outputs saved values once DELAYCOUNT is reached
signal counter, reader : INTEGER := 0;
signal store : storedsignals;

begin
	delayprocess : process(CLK)
	begin
    if resetIN = '1' then
  		if DELAYCOUNT = 0 then
  			if CLK='1' and CLK'event then
  				output.value <= input;
          if counter < 4 then
            output.phase <= '0';
          elsif counter < 8 then
            output.phase <= '1';
          end if;
					counter <= counter + 1;
        end if;
  		else -- 1 to N delay
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
  						output.value <= store(reader);
              if reader < 4 then
                output.phase <= '0';
              else
                output.phase <= '1';
              end if;
  						reader <= reader + 1;
  					end if;
  				end if;
  			end if;
  		end if;
    elsif resetIN = '0' then
      reader  <= 0;
      counter <= 0;
    end if;
	end process;
end structure;
