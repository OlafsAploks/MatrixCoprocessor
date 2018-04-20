LIBRARY ieee ;
USE ieee.std_logic_1164.all ;

entity Coprocessor is
	PORT(
	--CLOCK??
		input: in std_logic;
		output: out std_logic
	);
end Coprocessor;

architecture structure of Coprocessor is
--local signals
-- signal localX : x_type := "000000000";

begin
	output <= '1';

end structure;
