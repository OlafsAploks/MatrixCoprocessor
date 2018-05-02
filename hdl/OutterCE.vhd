LIBRARY ieee ;
USE ieee.std_logic_1164.all ;
use IEEE.STD_LOGIC_signed.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

library ieee_proposed;
use ieee_proposed.fixed_pkg.all;

use work.computing_elements_ports_pkg.all;

entity OutterCE is
	PORT(
		CLK: in STD_LOGIC;
		input: in outterCE_IN;
		output: out outterCE_OUT
	);
end OutterCE;

architecture structure of OutterCE is
--local signals
signal localX : x_type := xType_zero_constant;--(others	=> '0'); -- initialized as zero vector
-- signal a, b, c : x_type;


begin


calculate : process(CLK)
begin
if CLK='1' AND CLK'event then
	if input.phase = '0' then
		--First computing phase - works with matrixes A and B
		if abs(input.x) >= abs(localX) then
			output.s <= '1';
			if input.x /= xType_zero_constant then
				output.m <= resize((-localX) / input.x, output.m'high, output.m'low);
				localX <= input.x;
			else
				output.m <= xType_zero_constant;
				localX <= input.x;
			end if;
		else --abs else
			output.s <= '0';
			--Simulator missleads
					if localX /= xType_zero_constant then
						output.m <=  resize((-input.x) / localX, localX'high, localX'low);
					end if;
			-- output.m <=  resize((-input.x) / localX, localX'high, localX'low);
			localX <= localX;
		end if;
	else --second computing phase - works with matrixes (-C) and D
		if localX /= xType_zero_constant then
			output.m <= resize(input.x/localX, input.x'high, input.x'low);
			output.s <= '0';
		else
			output.m <= input.x;
			output.s <= '0';
		end if;
	end if;

	-- output.phase <= input.phase;
end if;
end process;


end structure;
