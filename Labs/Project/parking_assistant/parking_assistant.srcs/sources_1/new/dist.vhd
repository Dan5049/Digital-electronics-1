library ieee;               -- Standard library
use ieee.std_logic_1164.all;-- Package for data types and logic operations
use ieee.numeric_std.all;   -- Package for arithmetic operations

entity dist is
port(
    clk       : in std_logic;
    rst       : in std_logic;
    echo_i    : in std_logic;  --input from sonar
    buzz_o    : out std_logic; --output to buzzer
    leds_o    : out std_logic_vector (10 - 1 downto 0));
end entity dist;

architecture Behavioral of dist is 
    signal s_tick     : integer; --auxiliary variable for time counting
    signal s_dist     : integer; --auxiliary variable for distance counting
    signal s_tock     : integer; --auxiliary variable for time counting
    signal s_tock_on  : integer; --duty cycle for PWM signal to buzzer
    signal s_tock_off : integer; --period of the PWM signal
    signal s_xyz      : std_logic := '1'; --echo rising edge detection signal
begin

    p_distance : process(clk, echo_i)is --measure distance 
    begin
        if rising_edge(clk) then
            if rst = '1' then
                s_dist <= 1000; -- if dist = 1000 - error value (10m - more than it's able to measure)
                s_tick <= 0;
            else
                if echo_i = '1' then -- if echo is on 1, start counting time
                    s_tick <= s_tick +1; 
                    s_dist <= s_tick /(100*58); --conversion of ticks to distnace
                else
                    s_tick <= 0;
                end if;
            end if;
        end if;
    end process p_distance;
    
    p_bargraf : process (echo_i, s_dist, s_xyz)  --set the number of leds and duty cycle of buzzer
    begin
        if s_dist > 400 then
            leds_o <= "0000000000";
            s_tock_on <= 0;
            s_tock_off <= 100000000;
        end if; 
        if s_xyz = '1' and echo_i = '0' then
            if (s_dist <= 400 and s_dist >= 150) then --distance 4m to 1.5m
                leds_o <= "0000000001";
                s_tock_on <= 3000000;
                s_tock_off <= 10000000;
            elsif (s_dist < 150 and s_dist >= 100) then --distance 1.5m to 1m
                leds_o <= "0000000011";
                s_tock_on <= 3500000;
                s_tock_off <= 10000000;
            elsif (s_dist < 100 and s_dist >= 80) then --distance 1m to 0.8m
                leds_o <= "0000000111";
                s_tock_on <= 4000000;
                s_tock_off <= 10000000;
            elsif (s_dist < 80 and s_dist >= 70) then --distance 0.8m to 0.7m
                leds_o <= "0000001111";
                s_tock_on <= 4500000;
                s_tock_off <= 10000000; 
            elsif (s_dist < 70 and s_dist >= 60) then --distance 0.7m to 0.6m
                leds_o <= "0000011111";
                s_tock_on <= 5000000;
                s_tock_off <= 10000000;
            elsif (s_dist < 60 and s_dist >= 50) then --distance 0.6m to 0.5m
                leds_o <= "0000111111";
                s_tock_on <= 6000000;
                s_tock_off <= 10000000;
            elsif (s_dist < 50 and s_dist >= 40) then --distance 0.5m to 0.4m
                leds_o <= "0001111111";
                s_tock_on <= 7000000;
                s_tock_off <= 10000000;
            elsif (s_dist < 40 and s_dist >= 35) then --distance 0.4m to 0.35m
                leds_o <= "0011111111";
                s_tock_on <= 8000000;
                s_tock_off <= 10000000;
            elsif (s_dist < 35 and s_dist >= 30) then --distance 0.35m to 0.3m
                leds_o <= "0111111111";
                s_tock_on <= 9000000;
                s_tock_off <= 10000000;
            elsif s_dist < 30 then                      --distance less than 0.3m
                leds_o <= "1111111111";
                s_tock_on <= 3000000;
                s_tock_off <= 0;
            else
                leds_o <= "0000000000";
                s_tock_on <= 0;
                s_tock_off <= 100000000;
            end if;
       end if;
       s_xyz <= echo_i;    
    end process p_bargraf;
    
    p_buzz : process(clk, s_tock, s_tock_on, s_tock_off, echo_i)is
    begin                           -- controll buzzer based on the duty cycle values from p_bargraf
        if rising_edge(clk) then
            if rst = '1' then
                buzz_o <= '0';
                s_tock <= 0;
            else                
                if (s_tock <= s_tock_on) then
                    buzz_o <= '1';
                    s_tock <= s_tock + 1;
                elsif (s_tock <= s_tock_off and s_tock >= s_tock_on) then
                    buzz_o <= '0';
                    s_tock <= s_tock + 1;
                else 
                    s_tock <= 0;
                end if;
            end if;
        end if;    
    end process p_buzz;
    
end architecture Behavioral;

