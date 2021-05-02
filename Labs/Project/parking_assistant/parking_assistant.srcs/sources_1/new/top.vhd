----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.04.2021 21:44:59
-- Design Name: 
-- Module Name: top - Behavioral
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

entity top is
    port ( 
        CLK100MHZ   : in std_logic;
        btn         : in std_logic_vector (1 - 1 downto 0);
        ja          : out std_logic_vector(8 - 1 downto 0);
        jb          : out std_logic_vector (4 - 1 downto 0);
        jc          : in std_logic_vector(1 - 1 downto 0));
end top;

architecture Behavioral of top is
--no internal signals
begin
    
    trigger_top : entity work.trigger
        port map (
            clk         => CLK100MHZ,
            rst         => btn(0),
            trig_o      => ja(0));
            
    dist_top    : entity work.dist
        port map (
            clk                     => CLK100MHZ,
            rst                     => btn(0),  
            buzz_o                  => ja(1), 
            leds_o(6 - 1 downto 0)  => ja(8 - 1 downto 2),
            leds_o(10 - 1 downto 6) => jb(4 - 1 downto 0),
            echo_i                  => jc(0)); 
end Behavioral;
