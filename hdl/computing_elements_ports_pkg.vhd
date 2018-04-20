library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;
package computing_elements_ports_pkg is

  subtype x_type is std_logic_vector(8 downto 0);
  -- subtype x_type is signed(8 downto 0);

  -- Outputs outter computing element.
  type outterCE_OUT is record
    s : STD_LOGIC;
    m : x_type;
  end record outterCE_OUT;

  type outterCE_IN is record
	x : x_type;
  end record outterCE_IN;

  type innerCE_OUT is record
    s : STD_LOGIC;
    m : STD_LOGIC_VECTOR(8 DOWNTO 0);
	  x : STD_LOGIC_VECTOR(8 DOWNTO 0);
  end record innerCE_OUT;

  type innerCE_IN is record
    s : STD_LOGIC;
    m : STD_LOGIC_VECTOR(8 DOWNTO 0);
	  x : STD_LOGIC_VECTOR(8 DOWNTO 0);
  end record innerCE_IN;

--  constant c_FROM_FIFO_INIT : t_FROM_FIFO := (wr_full => '0',
--                                              rd_empty => '1',
--                                              rd_dv => '0',
--                                              rd_data => (others => '0'));
--


end package computing_elements_ports_pkg;
