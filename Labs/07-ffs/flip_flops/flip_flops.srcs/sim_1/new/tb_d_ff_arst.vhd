----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.03.2021 13:54:40
-- Design Name: 
-- Module Name: tb_d_ff_arst - Behavioral
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

entity tb_d_ff_arst is
--  Port ( );
end tb_d_ff_arst;

architecture Behavioral of tb_d_ff_arst is

        constant c_clk : time    := 10 ns;
        
        signal s_clk     : std_logic;
        signal s_arst    : std_logic;
        signal s_d       : std_logic;
        signal s_q       : std_logic;
        signal s_q_bar   : std_logic;
begin

    uut_d_ff_arst : entity work.d_ff_arst
        port map(
            clk   => s_clk,   
            arst  => s_arst, 
            d     => s_d,    
            q     => s_q,    
            q_bar => s_q_bar
        );
    
    p_arst : process
        begin
            s_arst <= '0';
            wait for 52 ns;
            
            s_arst <= '1';
            wait for 8 ns;
    
            s_arst <= '0';
            wait for 150 ns;
            
            s_arst <= '1';
            wait for 58 ns;
            
            s_arst <= '0';
            wait for 20ns;
            
            s_arst <= '1';
            wait;
            
    end process p_arst;
    
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
        wait for 18ns;
        assert(s_arst = '0' and s_clk = '1' and s_q = '1')
        report "Out" severity error;
        
        wait for 39ns;
        assert(s_arst = '1' and s_clk = '1' and s_q = '0')
        report "Rst" severity error;
        
        wait for 45ns;
        assert(s_arst = '0' and s_clk = '0' and s_q = '0')
        report "Out" severity error;
        
        wait for 121ns;
        assert(s_arst = '1' and s_clk = '0' and s_q = '0')
        report "Rst" severity error;
        wait;
        report "End of assert process" severity note;
    end process p_asserts_gen;

end Behavioral;