LIBRARY ieee ;
USE ieee.std_logic_1164.all ;
use IEEE.STD_LOGIC_signed.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

library ieee_proposed;
use ieee_proposed.fixed_pkg.all;

use work.computing_elements_ports_pkg.all;

entity InnerCECalc is
	PORT(
    phase : in STD_LOGIC;
		multiplierA: in x_type;
    multiplierB: in x_type;
    member: in x_type;
		result: out x_type
	);
end InnerCECalc;

architecture structure of InnerCECalc is

begin

calculate : process(multiplierA, multiplierB, member)
begin
  if phase = '0' then
    result <= resize(multiplierA*multiplierB + member, result'high, result'low);
  else
    result <= resize(member - multiplierA*multiplierB, result'high, result'low);
  end if;
end process;

end structure;
