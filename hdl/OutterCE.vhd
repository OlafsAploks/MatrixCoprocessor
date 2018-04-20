LIBRARY ieee ;
USE ieee.std_logic_1164.all ;
use IEEE.STD_LOGIC_signed.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

-- library ieee_proposed;
-- use ieee_proposed.fixed_pkg.all;

use work.computing_elements_ports_pkg.all;

entity OutterCE is
	PORT(
	--CLOCK??
		input: in outterCE_IN;
		output: out outterCE_OUT
	);
end OutterCE;

architecture structure of OutterCE is
--local signals
signal localX : x_type := (others	=> '0');
-- signal localX, inputX: signed()

begin

firstPhase : process(input.x)
begin
	if input.x > localX then
		output.s <= '1';
		if input.x /= "000000000" then
			-- output.m <= (localX) / input.x;
		else
			output.m <= 0;
		end if;
	else
		output.s <= '0';
	end if;
end process;

end structure;
