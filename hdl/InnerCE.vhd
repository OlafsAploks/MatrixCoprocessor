LIBRARY ieee ;
USE ieee.std_logic_1164.all ;
use IEEE.STD_LOGIC_signed.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

library ieee_proposed;
use ieee_proposed.fixed_pkg.all;

use work.computing_elements_ports_pkg.all;

entity InnerCE is
	PORT(
	--CLOCK??
		input: in innerCE_IN;
		output: out innerCE_OUT
	);
end InnerCE;

architecture structure of InnerCE is
--local signals
signal localX : x_type := xType_zero_constant;
signal temp: x_type;
-- signal a : x_type;
begin
--first computing phase
firstPhase : process(input.x)
begin

  if input.s = '1' then
    output.x <= resize(input.m*input.x + localX, output.x'high, output.x'low);
    localX <= input.x;
  else
    output.x <= resize(input.m*localX + input.x, output.x'high, output.x'low);
    -- localX <= localX;
  end if;
  output.m <= input.m;
  output.s <= input.s;
end process;

end structure;
