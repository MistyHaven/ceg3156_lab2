library ieee;
use ieee.std_logic_1164.all;

entity registerFile is
generic (
  bit_width : integer := 32;
  address_width : integer := 3;
  n : integer := 8
);
port (
  clock, reset : in std_logic;

  regWrite : in std_logic;

  writeAddr : in std_logic_vector(address_width-1 downto 0);
  writeData : in std_logic_vector(bit_width-1 downto 0);
  readAddr1 : in std_logic_vector(address_width-1 downto 0);
  readAddr2 : in std_logic_vector(address_width-1 downto 0);
  readReg1 : out std_logic_vector(bit_width-1 downto 0);
  readReg2 : out std_logic_vector(bit_width-1 downto 0)
);
end registerFile;

architecture rtl of registerFile is
  -- deps:
  -- nBit_register, dFF_2
  component regPIPO_nBit 
    generic ( bit_width : integer := 32 );
    port (
      clock, reset : in std_logic;
      load : in std_logic;
      d : in std_logic_vector(bit_width-1 downto 0);
      o : out std_logic_vector(bit_width-1 downto 0)
    );
  end component;


  component mux8_nBit is
    generic (bit_width : integer := 8);
    port (
      i_1, i_2, i_3, i_4,
      i_5, i_6, i_7, i_8 : in std_logic_vector(bit_width-1 downto 0);
      sel : in std_logic_vector(2 downto 0);
      o : out std_logic_vector(bit_width-1 downto 0)
    );
  end component;
  
  -- doing the scuffed huge vector thing again
  signal int_bus : std_logic_vector(bit_width * n - 1 downto 0);

  alias r1 : std_logic_vector(bit_width-1 downto 0) is int_bus(31 downto 0);
  alias r2 : std_logic_vector(bit_width-1 downto 0) is int_bus(63 downto 32);
  alias r3 : std_logic_vector(bit_width-1 downto 0) is int_bus(95 downto 64);
  alias r4 : std_logic_vector(bit_width-1 downto 0) is int_bus(127 downto 96);
  alias r5 : std_logic_vector(bit_width-1 downto 0) is int_bus(159 downto 128);
  alias r6 : std_logic_vector(bit_width-1 downto 0) is int_bus(191 downto 160);
  alias r7 : std_logic_vector(bit_width-1 downto 0) is int_bus(223 downto 192);
  alias r8 : std_logic_vector(bit_width-1 downto 0) is int_bus(255 downto 224);
begin
  test1: assert 
    n >= 2 ** address_width 
    report "error: bit_width too small for address_width, not all bits can be addressed";

  registers: for i in n-1 downto 0 generate
  begin
  reg_i : regPIPO_nBit
  generic map ( bit_width => bit_width )
  port map (
    clock => clock,
    reset => reset,
    load => regWrite,
    d => writeData,
    o => int_bus(bit_width * (i+1) - 1 downto bit_width * i)
  );
  end generate;

  read1: mux8_nBit
   generic map(bit_width => bit_width)
   port map(
      i_1 => r1, i_2 => r2, i_3 => r3, i_4 => r4,
      i_5 => r5, i_6 => r6, i_7 => r7, i_8 => r8,
      sel => readAddr1,
      o => readReg1
  );

  read2: mux8_nBit
   generic map(bit_width => bit_width)
   port map(
      i_1 => r1, i_2 => r2, i_3 => r3, i_4 => r4,
      i_5 => r5, i_6 => r6, i_7 => r7, i_8 => r8,
      sel => readAddr2,
      o => readReg2
  );
end rtl;
