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
--Not DELAYCOUNT-1, because 0-1 = -1 downto 0 INVALID
type delayArray is array (DELAYCOUNT downto 0) of x_type;
--local signals
--counter counts delayed cycles
--reader outputs saved values once DELAYCOUNT is reached
signal counter, delayCounter : INTEGER := 0;
signal delArray : delayArray := (others => (others => '0'));


begin

	phaseCalc : process(CLK, resetIN)
	begin
		if resetIN = '1' then
			if CLK='1' and CLK'event then
				if counter < 4 then
					output.phase <= '0';
				elsif counter < 8 then
					output.phase <= '1';
				end if;
				if delayCounter > DELAYCOUNT-1 then
					counter <= counter + 1;
				end if;
				delayCounter <= delayCounter + 1;
			end if;
		elsif resetIN = '0' then
			delayCounter <= 0;
			counter <= 0;
		end if;
	end process;


	delayprocess : process(CLK, resetIN)
	begin
    if resetIN = '1' then
			if CLK = '1' and CLK'event then
				--GENERICS CASES
				if DELAYCOUNT = 0 then
						output.value <= input;
				elsif DELAYCOUNT = 1 then
						delArray(0) <= input;
						output.value <= delArray(0);
				elsif DELAYCOUNT > 0 then
						delay : for i in 0 to DELAYCOUNT-1 loop
							if i = 0 then
								delArray(i) <= input;
							elsif i = DELAYCOUNT then
								delArray(i) <= delArray(i-1);
							else
								output.value <= delArray(DELAYCOUNT-1);
								delArray(i) <= delArray(i-1);
							end if;
						end loop;
					end if;
				end if;
				--GENERIC CASES ENDS
			elsif resetIN = '0' then
					delArray <= (others => (others => '0'));
    end if;
	end process;
end structure;
