----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.04.2021 22:22:44
-- Design Name: 
-- Module Name: tb_top - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_top is
--  Port ( );
end tb_top;

architecture Behavioral of tb_top is
    constant clk_per   : time := 10 ns;
    
    signal s_clk    : std_logic := '0'; 
    signal s_rst    : std_logic;
    signal s_trig_o : std_logic;
       
    signal s_echo_i : std_logic;                 
    signal s_buzz_o : std_logic;                 
    signal s_leds_o_o : std_logic_vector (10 - 1 downto 0);

begin
    uut_top : entity work.top
        port map(
         CLK100MHZ           => s_clk, 
         btn(0)              => s_rst,
         ja(0)               => s_trig_o,
         
         ja(1)               => s_buzz_o,
         ja(8 - 1 downto 2)  => s_leds_o_o(6 - 1 downto 0),
         jb(4 - 1 downto 0)  => s_leds_o_o(10 - 1 downto 6),
         jc(0)               => s_echo_i);
         
   s_clk <= not s_clk after clk_per / 2;
    
   p_reset_gen : process
   begin   
        s_rst <= '1';
        wait for 100 ms;
        s_rst <= '0';
        wait;       
   end process p_reset_gen; 
         
   p_echo_gen : process
   begin
        s_echo_i <= '1'; 
        wait for 50 ms;
        s_echo_i <= '0';
        wait for 50 ms;         
        s_echo_i <= '1'; 
        wait for 10 ms;
        s_echo_i <= '0';
        wait for 90 ms;
        s_echo_i <= '1'; 
        wait for 4.8 ms;
        s_echo_i <= '0';
        wait for 95.2 ms;
        s_echo_i <= '1'; 
        wait for 1.9 ms;
        s_echo_i <= '0';
        wait for 98.1 ms;
        s_echo_i <= '0';
        wait;
        wait;
  end process p_echo_gen;
         
end Behavioral;
