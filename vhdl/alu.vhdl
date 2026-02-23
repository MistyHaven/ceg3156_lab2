library ieee;
use ieee.std_logic_1164.all;
entity alu is
generic (bit_width : integer := 32);
port (
  a, b : in std_logic_vector(bit_width-1 downto 0);
  aluOP : in std_logic_vector(2 downto 0);
  o_aluZero, o_aluCarryOut : out std_logic;
  o : out std_logic_vector(bit_width-1 downto 0)
);
end alu;

architecture rtl of alu is

-- 000 and
-- 001 or
-- 010 add
-- 110 sub

  component addSub_nBit is
    generic ( n : integer := bit_width );
    port (
      x , y: in std_logic_vector(n-1 downto 0);
      ci: in std_logic;
      s: out std_logic_vector(n-1 downto 0);
      co: out std_logic
   );
  end component;

  component mux8_nBit is
  generic (bit_width : integer := bit_width);
  port (
    i_1, i_2, i_3, i_4,
    i_5, i_6, i_7, i_8 : in std_logic_vector(bit_width-1 downto 0);
    sel : in std_logic_vector(2 downto 0);
    o : out std_logic_vector(bit_width-1 downto 0)
  );

  end component;

  signal int_and, int_or, int_addSub: std_logic_vector(bit_width-1 downto 0); 
  signal int_isSub : std_logic;
begin
  
  -- could be more elegant
  -- sub if aluOp == 110
  int_isSub <=  aluOp(2) and 
                aluOp(1) and 
                not aluOp(0);

  int_and <= a and b; 
  int_or <= a or b; 

  addSub: addSub_nBit 
    generic map ( n => bit_width )
    port map (
      x => a,
      y => b,
      ci => int_isSub, 
      s => int_addSub,
      co => o_aluCarryOut
   );

end rtl;
