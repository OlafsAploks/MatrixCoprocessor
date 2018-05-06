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
signal divident, divider : x_type;

component DivisionUnit PORT(
	divident: in x_type;
	divider:  in x_type;
	result: out x_type
);
end component;
begin

divunit : DivisionUnit PORT MAP(
	divident => divident,
	divider => divider,
	result => output.m
);

calculate : process(CLK)
begin
if CLK='1' AND CLK'event then
	if input.phase = '0' then
		--First computing phase - works with matrixes A and B
		if abs(input.x) >= abs(localX) then
			output.s <= '1';
			if input.x /= xType_zero_constant then
				divident <= resize(xType_zero_constant-localX, divident'high, divident'low);
        divider <= input.x;
				localX <= input.x;
			else
				divident <= xType_zero_constant;
        divider <= xType_one;
				localX <= input.x;
			end if;
		else --abs else
			output.s <= '0';
			--Simulator missleads
					if localX /= xType_zero_constant then
						divident <= resize(xType_zero_constant-input.x, divident'high, divident'low);
            divider <= localX;
					end if;
			-- output.m <=  resize((-input.x) / localX, localX'high, localX'low);
			localX <= localX;
		end if;
	else --second computing phase - works with matrixes (-C) and D
		if localX /= xType_zero_constant then
			divident <= input.x;
      divider <= localX;
		else
			divident <= input.x;
      divider <= xType_one;
			output.s <= '0';
		end if;
	end if;


end if;
end process;


end structure;
