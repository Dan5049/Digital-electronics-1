----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.03.2021 19:13:07
-- Design Name: 
-- Module Name: tb_d_ff_rst - Behavioral
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

entity tb_d_ff_rst is
--  Port ( );
end tb_d_ff_rst;

architecture Behavioral of tb_d_ff_rst is

        constant c_clk : time    := 10 ns;
        
        signal s_clk     : std_logic;
        signal s_rst     : std_logic;
        signal s_d       : std_logic;
        signal s_q       : std_logic;
        signal s_q_bar   : std_logic;

begin

    uut_d_ff_rst : entity work.d_ff_rst
        port map(
            clk   => s_clk,   
            rst   => s_rst, 
            d     => s_d,    
            q     => s_q,    
            q_bar => s_q_bar
        );
        
     p_clk_gen : process
        begin
            while now < 750 ns loop
                s_clk <= '0';
                wait for c_clk / 2;
                s_clk <= '1';
                wait for c_clk / 2;
            end loop;
        wait;
    end process p_clk_gen;
    
    p_rst_gen : process
    begin
        s_rst <= '0';
        wait for 19ns;
        s_rst <= '1';
        wait for 20ns;
        s_rst <= '0';
        wait for 158ns;
        s_rst <= '1';
        wait for 97ns;
        s_rst <= '1';
        wait;
        
     end process p_rst_gen;   

     p_stimulus : process
        begin
            report "Stimulus process started" severity note;
            
            wait for 13 ns;
            s_d  <= '1';
            wait for 10 ns;
            s_d  <= '0';
            wait for 10 ns;
            s_d  <= '1';
            wait for 10 ns;
            s_d  <= '0';
            wait for 10 ns;
            s_d  <= '1';
            wait for 10 ns;
            s_d  <= '0';
            
            report "Stimulus process started" severity note;
    end process p_stimulus;
    
    p_asserts_gen : process
    begin
        report "Start of assert process" severity note;
        wait for 27ns;
        assert(s_rst = '1' and s_clk = '1' and s_q = '0')
        report "Rst" severity error;
        
        wait for 6ns;
        assert(s_rst = '1' and s_clk = '0' and s_q = '0')
        report "Rst" severity error;
        
        wait for 25ns;
        assert(s_rst = '0' and s_clk = '1' and s_q = '1')
        report "Out" severity error;
        
        wait for 14ns;
        assert(s_rst = '0' and s_clk = '0' and s_q = '0')
        report "Out" severity error;
        wait;
        report "End of assert process" severity note;
    end process p_asserts_gen;
end Behavioral;
