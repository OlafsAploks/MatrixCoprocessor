LIBRARY ieee ;
USE ieee.std_logic_1164.all ;
use IEEE.STD_LOGIC_signed.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

library ieee_proposed;
use ieee_proposed.fixed_pkg.all;

use work.computing_elements_ports_pkg.all;

entity SystolicArray is
	PORT(
  --ROM?
    CLK: in STD_LOGIC;
		input: in SystolicArray_IN;
    output: out SystolicArray_OUT
	);
end SystolicArray;

architecture structure of SystolicArray is
--local signals
signal oe_1_1_signals : outterCE_OUT;
signal ie_1_2_signals : innerCE_OUT;
signal ie_1_3_signals : innerCE_OUT;
signal ie_1_4_signals : innerCE_OUT;
signal ie_1_5_signals : innerCE_OUT;
signal ie_1_6_signals : innerCE_OUT;
signal ie_1_7_signals : innerCE_OUT;
signal ie_1_8_signals : innerCE_OUT;
--------------------
component outterCE
  PORT(
    CLK: in STD_LOGIC;
    input: in outterCE_IN;
    output: out outterCE_OUT
  );
end component;

component innerCE
  PORT(
    CLK: in STD_LOGIC;
    input: in innerCE_IN;
    output: out innerCE_OUT
  );
end component;

begin
  --outterCE declaration and portmap template
  -- oe_1_1 : outterCE PORT MAP(
  --   CLK => CLK,
  --   input.x => ie_row-1_column_signals,
  --   input.phase => ie_row-1_column_signals.phase,
  --   output.m => oe_row_column_signals.m,
  --   output.s => oe_row_column_signals.s,
  --   output.phase => oe_row_column_signals.phase
  -- );

  -- innerCE declaration and portmap template
  -- ie_row_column : innerCE PORT MAP(
  --   CLK => CLK,
  --   input.phase => ie_row-1_column_signals.phase,
  --   input.x => ie_row-1_column_signals.x,
  --   input.m => ie/oe_row_column-1_signals.m,
  --   input.s => ie/oe_row_column-1_signals.s,
  --   output.s => ie_row_column_signals.s,
  --   output.phase => ie_row_column_signals.phase,
  --   output.m => ie_row_column_signals.m,
  --   output.x => ie_row_column_signals.x
  -- );

  -- FIRST ROW ---
  oe_1_1 : outterCE PORT MAP(
    CLK => CLK,
    input.x => input.column1.value,
    input.phase => input.column1.phase,
    output.m => oe_1_1_signals.m,
    output.s => oe_1_1_signals.s,
    output.phase => oe_1_1_signals.phase
  );

  ie_1_2 : innerCE PORT MAP(
    CLK => CLK,
    input.phase => input.column1.phase,
    input.x => input.column1.value,
    input.m => oe_1_1_signals.m,
    input.s => oe_1_1_signals.s,
    output.s => ie_1_2_signals.s,
    output.phase => ie_1_2_signals.phase,
    output.m => ie_1_2_signals.m,
    output.x => ie_1_2_signals.x
  );

  ie_1_3 : innerCE PORT MAP(
    CLK => CLK,
    input.phase => input.column3.phase,
    input.x => input.column3.value,
    input.m => ie_1_2_signals.m,
    input.s => ie_1_2_signals.s,
    output.s => ie_1_3_signals.s,
    output.phase => ie_1_3_signals.phase,
    output.m => ie_1_3_signals.m,
    output.x => ie_1_3_signals.x
  );

  ie_1_4 : innerCE PORT MAP(
    CLK => CLK,
    input.phase => input.column4.phase,
    input.x => input.column4.value,
    input.m => ie_1_3_signals.m,
    input.s => ie_1_3_signals.s,
    output.s => ie_1_4_signals.s,
    output.phase => ie_1_4_signals.phase,
    output.m => ie_1_4_signals.m,
    output.x => ie_1_4_signals.x
  );

  ie_1_5 : innerCE PORT MAP(
    CLK => CLK,
    input.phase => input.column5.phase,
    input.x => input.column5.value,
    input.m => ie_1_4_signals.m,
    input.s => ie_1_4_signals.s,
    output.s => ie_1_5_signals.s,
    output.phase => ie_1_5_signals.phase,
    output.m => ie_1_5_signals.m,
    output.x => ie_1_5_signals.x
  );

  ie_1_6 : innerCE PORT MAP(
    CLK => CLK,
    input.phase => input.column6.phase,
    input.x => input.column6.value,
    input.m => ie_1_5_signals.m,
    input.s => ie_1_5_signals.s,
    output.s => ie_1_6_signals.s,
    output.phase => ie_1_6_signals.phase,
    output.m => ie_1_6_signals.m,
    output.x => ie_1_6_signals.x
  );

  ie_1_7 : innerCE PORT MAP(
    CLK => CLK,
    input.phase => input.column7.phase,
    input.x => input.column7.value,
    input.m => ie_1_6_signals.m,
    input.s => ie_1_6_signals.s,
    output.s => ie_1_7_signals.s,
    output.phase => ie_1_7_signals.phase,
    output.m => ie_1_7_signals.m,
    output.x => ie_1_7_signals.x
  );

  ie_1_8 : innerCE PORT MAP(
    CLK => CLK,
    input.phase => input.column8.phase,
    input.x => input.column8.value,
    input.m => ie_1_7_signals.m,
    input.s => ie_1_7_signals.s,
    output.s => ie_1_8_signals.s,
    output.phase => ie_1_8_signals.phase,
    output.m => ie_1_8_signals.m,
    output.x => ie_1_8_signals.x
  );
  -- SECOND ROW ---

end structure;
