LIBRARY ieee ;
USE ieee.std_logic_1164.all ;
use IEEE.STD_LOGIC_signed.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

library ieee_proposed;
use ieee_proposed.fixed_pkg.all;
-- use ieee.fixed_pkg.all;

use work.computing_elements_ports_pkg.all;

entity DivisionUnit is
	PORT(
		-- CLK: in STD_LOGIC;
		divident: in x_type;
    divider:  in x_type;
		result: out x_type
	);
end DivisionUnit;

architecture structure of DivisionUnit is
--local signals
signal test : integer;


begin
calculate : process(divident, divider)
begin
    result <= resize(divident/divider, result'high, result'low);
end process;

end structure;
