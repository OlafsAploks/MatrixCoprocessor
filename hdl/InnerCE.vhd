LIBRARY ieee ;
USE ieee.std_logic_1164.all ;
use IEEE.STD_LOGIC_signed.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
-- use ieee.fixed_pkg.all;
library ieee_proposed;
use ieee_proposed.fixed_pkg.all;
-- use ieee.fixed_generic_pkg.all;

use work.computing_elements_ports_pkg.all;

entity InnerCE is
	PORT(
		CLK: in STD_LOGIC;
		input: in innerCE_IN;
		output: out innerCE_OUT
	);
end InnerCE;

architecture structure of InnerCE is
--local signals
signal localX : x_type := xType_zero_constant;
signal multiplierA, multiplierB, member: x_type;

	component InnerCECalc PORT(
		phase : in STD_LOGIC;
		multiplierA: in x_type;
		multiplierB: in x_type;
		member: in x_type;
		result: out x_type
	);
end component;
begin

	calc : InnerCECalc PORT MAP(
		phase => input.phase,
		multiplierA => multiplierA,
		multiplierB => multiplierB,
		member => member,
		result => output.x
	);

--first computing phase
calculate : process(CLK)
begin
	if CLK='1' AND CLK'event then
		if input.phase = '0' then
			--First computing phase - working with matrixes A and B
			if input.s = '1' then
				-- output.x <= resize(input.m*input.x + localX, output.x'high, output.x'low);
				multiplierA <= input.m;
				multiplierB <= input.x;
				member <= localX;
				localX <= input.x;
			else
				-- output.x <= resize(input.m*localX + input.x, output.x'high, output.x'low);
				multiplierA <= input.m;
				multiplierB <= localX;
				member <= input.x;
			end if;
			output.m <= input.m;
			output.s <= input.s;
		else --Second computing phase - working with matrixes (-C) and D
			-- output.x <=  resize(input.x - input.m*localX, localX'high, localX'low);
			multiplierA <= input.m;
			multiplierB <= localX;
			member <= input.x;
			output.m <= input.m;
			output.s <= '0';
		end if;
		output.phase <= input.phase;
	end if;
end process;

end structure;
