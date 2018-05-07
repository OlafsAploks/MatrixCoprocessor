library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;

-- use ieee.fixed_pkg.all;
library ieee_proposed;
use ieee_proposed.fixed_pkg.all;


package computing_elements_ports_pkg is

  -- subtype x_type is sfixed(31 downto -32); --2^(10-1) = +/- 512
  -- subtype x_type is sfixed(15 downto -14);
  subtype x_type is sfixed(8 downto -12); --2^(10-1) = +/- 512
  subtype address is std_logic_vector(5 downto 0); --2^6 = 64; N=4;P=4;
  -- subtype x_type is signed(8 downto 0);

  -- Outputs outter computing element.
  type outterCE_OUT is record
    s : STD_LOGIC;
    m : x_type;
    -- phase: STD_LOGIC;
  end record outterCE_OUT;

  type outterCE_IN is record
	  x : x_type;
    phase: STD_LOGIC;
  end record outterCE_IN;

  type innerCE_OUT is record
    s : STD_LOGIC;
    phase: STD_LOGIC;
    m : x_type;
	  x : x_type;
  end record innerCE_OUT;

  type innerCE_IN is record
    s : STD_LOGIC;
    phase: STD_LOGIC;
    m : x_type;
	  x : x_type;
  end record innerCE_IN;

  type valueAndPhase is record
    value: x_type;
    phase: STD_LOGIC;
  end record valueAndPhase;

  type SystolicArrayScale_IN is array (8 downto 1) of valueAndPhase;
  type SystolicArrayScale_OUT is array (4 downto 1) of x_type;

  type SystolicArray_IN is record
    column1: valueAndPhase;
    column2: valueAndPhase;
    column3: valueAndPhase;
    column4: valueAndPhase;
    column5: valueAndPhase;
    column6: valueAndPhase;
    column7: valueAndPhase;
    column8: valueAndPhase;
  end record SystolicArray_IN;

  type SystolicArray_OUT is record
    column1: x_type;
    column2: x_type;
    column3: x_type;
    column4: x_type;
  end record SystolicArray_OUT;


  constant xType_zero_constant : x_type := (others=>'0');--"000000000000000000000";
  constant xType_one : x_type := (0 => '1', others => '0');
  constant xType_lowest_value : x_type := (
    -1     => '1',
    -2     => '1',
    others => '1' );
  constant xType_max_value : x_type := (
    1      => '1',
    others => '0' );
  constant defaultValueAndPhase : valueAndPhase := (
    value => xType_zero_constant,
    phase => '0'
  );
--  constant c_FROM_FIFO_INIT : t_FROM_FIFO := (wr_full => '0',
--                                              rd_empty => '1',
--                                              rd_dv => '0',
--                                              rd_data => (others => '0'));
--


end package computing_elements_ports_pkg;
