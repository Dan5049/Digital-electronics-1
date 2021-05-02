library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_dist is
end entity tb_dist;

architecture testbench of tb_dist is

   constant clk_freq   : integer := 100e6; -- 100 MHz
   constant clk_per    : time    := 1000 ms / clk_freq;
 
   signal s_clk      : std_logic := '1';
   signal s_rst      : std_logic := '0';
   signal s_echo_i   : std_logic := '0';
   signal s_buzz_o   : std_logic := '0';
  
begin
    
    uut_dist: entity work.dist(Behavioral)
    port map(
        clk    => s_clk,
        echo_i => s_echo_i,
        buzz_o => s_buzz_o,
        rst    => s_rst);
        
    s_clk <= not s_clk after clk_per / 2;
    
    p_reset_gen : process is
    begin    
        s_rst <= '1'; --first period of trigger (100ms), reset on
        wait for 50 ms; 
        s_rst <= '0'; --the rest of the time reset off
        wait;
    end process p_reset_gen;
    
    p_echo_gen : process is
    begin    
        s_echo_i <= '1'; 
        wait for 20 ms;         
        s_echo_i <= '0'; 
        wait for 30 ms;
        s_echo_i <= '1';
        wait for 5 ms;
        s_echo_i <= '0'; 
        wait for 95 ms;
        s_echo_i <= '1';
        wait for 3 ms;
        s_echo_i <= '0'; 
        wait for 97 ms;
        s_echo_i <= '1';
        wait for 1.8 ms;
        s_echo_i <= '0'; 
--       wait for 98.2 ms;
        
        wait;
    end process p_echo_gen;
    

end architecture testbench;