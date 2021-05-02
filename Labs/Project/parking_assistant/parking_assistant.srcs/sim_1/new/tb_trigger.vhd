library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_trigger is
end entity tb_trigger;

architecture testbench of tb_trigger is

   constant clk_freq : integer := 100e6; -- 100 MHz
   constant clk_per    : time    := 1000 ms / clk_freq;
 
   signal s_clk    : std_logic := '1';
   signal s_rst    : std_logic := '0';
   signal s_trig_o   : std_logic := '0';
   
begin
    
    uut_trigger: entity work.trigger(Behavioral)
    port map(
        clk  => s_clk,
        rst  => s_rst,
        trig_o => s_trig_o);
        
    s_clk <= not s_clk after clk_per / 2;
    
    p_reset_gen : process is
    begin    
        s_rst <= '1';
        
        wait for 100 ms; --first period of trigger (100ms), reset on
        s_rst <= '0'; --the rest of the time reset off
        wait;
    end process p_reset_gen;

end architecture testbench;