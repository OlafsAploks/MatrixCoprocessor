LIBRARY ieee ;
USE ieee.std_logic_1164.all ;
use IEEE.STD_LOGIC_signed.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

library ieee_proposed;
use ieee_proposed.fixed_pkg.all;

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
signal localX : x_type := xType_zero_constant;--(others	=> '0'); -- initialized as zero vector

-- signal a, b, c : sfixed (8 downto -5); --"00000000.000000";


signal a : x_type;
-- signal localX, inputX: signed()

begin

firstPhase : process(input.x)
begin

	-- variable'high - index of most significant bit (MSB)
	-- variable'low - index of least significant bit (LSB)
	-- a <= "00100000010000";
	-- b <= "00001100010000";
	-- report("HELLO");
	-- report(to_string(to_real(a)));
	a <= xType_one;

	if abs(input.x) >= abs(localX) then
		output.s <= '1';
		if input.x /= xType_zero_constant then
			output.m <= resize(localX / input.x, localX'high, localX'low);
			localX <= input.x;
		else
			output.m <= xType_zero_constant;
			localX <= input.x;
		end if;
	else
		output.s <= '0';
		output.m <=  resize((-input.x) / localX, localX'high, localX'low);
		localX <= localX;
	end if;
end process;

end structure;
