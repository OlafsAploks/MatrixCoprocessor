library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;

library ieee_proposed;
use ieee_proposed.fixed_pkg.all;


package computing_elements_ports_pkg is

  subtype x_type is sfixed(31 downto -32); --2^(10-1) = +/- 512
  -- subtype x_type is signed(8 downto 0);

  -- Outputs outter computing element.
  type outterCE_OUT is record
    s : STD_LOGIC;
    m : x_type;
    phase: STD_LOGIC;
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

  constant xType_zero_constant : x_type := (others=>'0');--"000000000000000000000";
  constant xType_one : x_type := (0 => '1', others => '0');
  constant xType_lowest_value : x_type := (
    -1     => '1',
    -2     => '1',
    others => '1' );
  constant xType_max_value : x_type := (
    1      => '1',
    others => '0' );
  constant xType_random_value : x_type := (
    9      => '1',
    others => '0' );
--  constant c_FROM_FIFO_INIT : t_FROM_FIFO := (wr_full => '0',
--                                              rd_empty => '1',
--                                              rd_dv => '0',
--                                              rd_data => (others => '0'));
--


end package computing_elements_ports_pkg;
