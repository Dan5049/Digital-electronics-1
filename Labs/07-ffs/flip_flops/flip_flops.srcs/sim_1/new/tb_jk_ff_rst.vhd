----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.03.2021 19:56:48
-- Design Name: 
-- Module Name: tb_jk_ff_rst - Behavioral
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

entity tb_jk_ff_rst is
--  Port ( );
end tb_jk_ff_rst;

architecture Behavioral of tb_jk_ff_rst is
        constant c_clk : time    := 10 ns;
 
        signal s_clk     : std_logic;
        signal s_rst     : std_logic;
        signal s_j       : std_logic;
        signal s_k       : std_logic;
        signal s_q       : std_logic;
        signal s_q_bar   : std_logic;
begin

    uut_jk_ff_rst : entity work.jk_ff_rst
        port map(
            clk   => s_clk,   
            rst   => s_rst, 
            j     => s_j,    
            k     => s_k,    
            q     => s_q,    
            q_bar => s_q_bar
        );
 
    p_rst : process
        begin
            s_rst <= '0';
            wait for 322 ns;
 
            s_rst <= '1';
            wait for 1 ns;
 
            s_rst <= '0';
            wait for 4 ns;
            
            s_rst <= '1';
            wait for 1 ns;
 
            s_rst <= '0';
            wait for 20 ns;
 
            s_rst <= '1';
            wait;
    end process p_rst;
 
    p_clk_gen : process
        begin
            while now < 750 ns loop         -- 75 periods of 100MHz clock
                s_clk <= '0';
                wait for c_clk / 2;
                s_clk <= '1';
                wait for c_clk / 2;
            end loop;
        wait;
    end process p_clk_gen;
 
    p_stimulus : process
        begin
            report "Stimulus process started" severity note;
            for I in 0 to 4 loop
                wait for 13 ns; --reset
                s_j  <= '0';
                s_k  <= '1';
                wait for 10 ns; --set
                s_j  <= '1';
                s_k  <= '0';
                wait for 10 ns; --no change
                s_j  <= '0';
                s_k  <= '0';
                wait for 10 ns; --togle
                s_j  <= '1';
                s_k  <= '1';
                
                wait for 10 ns; --reset
                s_j  <= '0';
                s_k  <= '1';
                 wait for 10 ns; --no change
                s_j  <= '0';
                s_k  <= '0';
                wait for 10 ns; --togle
                s_j  <= '1';
                s_k  <= '1';
                wait for 10 ns; --set
                s_j  <= '1';
                s_k  <= '0';
                wait for 10 ns; --reset
                s_j  <= '0';
              
           end loop;
           report "Stimulus process ended" severity note;
           wait;
    end process p_stimulus;
    
    p_asserts_gen : process
    begin
        report "Start of assert process" severity note;        
        wait for 48ns;
        assert(s_rst = '0' and s_clk = '1' and s_q = '0')
        report "Out" severity error;
        
        wait for 30ns;
        assert(s_rst = '0' and s_clk = '1' and s_q = '1')
        report "Out" severity error;
        
        wait for 64ns;
        assert(s_rst = '0' and s_clk = '0' and s_q = '1')
        report "Out" severity error;
        
        wait for 51ns;
        assert(s_rst = '0' and s_clk = '0' and s_q = '1')
        report "Out" severity error;
        
         wait for 164ns;
        assert(s_rst = '1' and s_clk = '1' and s_q = '0') --357
        report "Rst" severity error;
        
        wait for 6ns;
        assert(s_rst = '1' and s_clk = '0' and s_q = '0') --363
        report "Rst" severity error;
        
        wait;
        report "End of assert process" severity note;
    end process p_asserts_gen;
end Behavioral;
