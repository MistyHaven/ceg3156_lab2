library ieee;
use ieee.std_logic_1164.all;

-- ==== 2 INPUT N-BIT MUX
entity mux2_nBit is
generic (bit_width : integer := 8);
port (
  i_1, i_2 : in std_logic_vector(bit_width-1 downto 0);
  sel : in std_logic;
  o : out std_logic_vector(bit_width-1 downto 0)
);
end mux2_nBit;

architecture rtl of mux2_nBit is
begin
  b_i: for i in bit_width-1 downto 0 generate
  begin
    o(i) <= 
      (i_1(i) and not sel) or
      (i_2(i) and sel);
  end generate;
end rtl;

-- ==== 4 INPUT N-BIT MUX
library ieee;
use ieee.std_logic_1164.all;
entity mux4_nBit is
generic (bit_width : integer := 8);
port (
  i_1, i_2, i_3, i_4 : in std_logic_vector(bit_width-1 downto 0);
  sel : in std_logic_vector(1 downto 0);
  o : out std_logic_vector(bit_width-1 downto 0)
);
end mux4_nBit;

architecture rtl of mux4_nBit is
begin
  b_i: for i in bit_width-1 downto 0 generate
  begin
    o(i) <= 
      (i_1(i) and not sel(1) and not sel(0)) or
      (i_2(i) and not sel(1) and sel(0)) or
      (i_3(i) and sel(1) and not sel(0)) or
      (i_4(i) and sel(1) and sel(0));
  end generate;
end rtl;

-- ==== 8 INPUT N-BIT MUX
library ieee;
use ieee.std_logic_1164.all;
entity mux8_nBit is
generic (bit_width : integer := 8);
port (
  i_1, i_2, i_3, i_4,
  i_5, i_6, i_7, i_8 : in std_logic_vector(bit_width-1 downto 0);
  sel : in std_logic_vector(2 downto 0);
  o : out std_logic_vector(bit_width-1 downto 0)
);
end mux8_nBit;

architecture rtl of mux8_nBit is
begin
  b_i: for i in bit_width-1 downto 0 generate
  begin
    o(i) <= 
      (i_1(i) and not sel(2) and not sel(1) and not sel(0)) or
      (i_2(i) and not sel(2) and not sel(1) and sel(0)) or
      (i_3(i) and not sel(2) and sel(1) and not sel(0)) or
      (i_4(i) and not sel(2) and sel(1) and sel(0)) or
      (i_5(i) and sel(2) and not sel(1) and not sel(0)) or
      (i_6(i) and sel(2) and not sel(1) and sel(0)) or
      (i_7(i) and sel(2) and sel(1) and not sel(0)) or
      (i_8(i) and sel(2) and sel(1) and sel(0));
  end generate;
end rtl;
