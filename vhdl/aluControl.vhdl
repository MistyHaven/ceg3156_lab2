library ieee;
use ieee.std_logic_1164.all;
entity aluControl is
port(
  i_func : in std_logic_vector(5 downto 0);
  i_aluOP : in std_logic_vector(1 downto 0);
  
  o_operation : out std_logic_vector(2 downto 0)
);
end aluControl;

architecture rtl of aluControl is
  alias f0 : std_logic is i_func(0);
  alias f1 : std_logic is i_func(1);
  alias f2 : std_logic is i_func(2);
  alias f3 : std_logic is i_func(3);
  alias f4 : std_logic is i_func(4);
  alias f5 : std_logic is i_func(5);

  alias op1 : std_logic is i_aluOP(1);
  alias op2 : std_logic is i_aluOP(2);

begin
  o_operation(2) <= (f1 and op1) or op2;
  o_operation(1) <= (not op1) or (not f2);
  o_operation(0) <= (f3 or f0) and op1;

end rtl;
