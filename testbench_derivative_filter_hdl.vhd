LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY tb_derivative_filter_algorithm_fixpt IS
END tb_derivative_filter_algorithm_fixpt;

ARCHITECTURE behavior OF tb_derivative_filter_algorithm_fixpt IS

  -- Component under test (UUT)
  COMPONENT derivative_filter_algorithm_fixpt
    PORT (
      clk             : IN  std_logic;
      reset           : IN  std_logic;
      clk_enable      : IN  std_logic;
      input_signal    : IN  std_logic_vector(13 DOWNTO 0);
      ce_out          : OUT std_logic;
      filtered_output : OUT std_logic_vector(13 DOWNTO 0)
    );
  END COMPONENT;

  -- Signals
  SIGNAL clk             : std_logic := '0';
  SIGNAL reset           : std_logic := '1';
  SIGNAL clk_enable      : std_logic := '0';
  SIGNAL input_signal    : std_logic_vector(13 DOWNTO 0) := (OTHERS => '0');
  SIGNAL ce_out          : std_logic;
  SIGNAL filtered_output : std_logic_vector(13 DOWNTO 0);

  CONSTANT clk_period : TIME := 10 ns;

BEGIN

  -- Instantiate the UUT
  uut: derivative_filter_algorithm_fixpt
    PORT MAP (
      clk             => clk,
      reset           => reset,
      clk_enable      => clk_enable,
      input_signal    => input_signal,
      ce_out          => ce_out,
      filtered_output => filtered_output
    );

  -- Clock generation
  clk_process : PROCESS
  BEGIN
    WHILE TRUE LOOP
      clk <= '0';
      WAIT FOR clk_period / 2;
      clk <= '1';
      WAIT FOR clk_period / 2;
    END LOOP;
  END PROCESS;

  -- Stimulus process
  stim_proc: PROCESS
  BEGIN
    -- Wait for 2 clock cycles then release reset
    WAIT FOR 2 * clk_period;
    reset <= '0';
    clk_enable <= '1';

    -- Apply a few test inputs
    WAIT FOR clk_period;
    input_signal <= std_logic_vector(to_signed(100, 14));  -- nh? d??ng
    WAIT FOR clk_period;
    input_signal <= std_logic_vector(to_signed(200, 14));  -- l?n h?n
    WAIT FOR clk_period;
    input_signal <= std_logic_vector(to_signed(150, 14));  -- gi?m nh?
    WAIT FOR clk_period;
    input_signal <= std_logic_vector(to_signed(0, 14));    -- v? 0
    WAIT FOR clk_period;
    input_signal <= std_logic_vector(to_signed(-100, 14)); -- âm

    -- K?t thúc mô ph?ng
    WAIT FOR 5 * clk_period;
    REPORT "Simulation finished. Sample output: " & INTEGER'image(to_integer(signed(filtered_output)));
    WAIT;
  END PROCESS;

END behavior;

