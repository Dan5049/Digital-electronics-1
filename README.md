# Digital-electronics-1
VUT FEKT DE1

## nadpis 2
__bolt__

1. Item A
1. Item B
1. Item C

### nadpis 3
*italic*

* Item 1
* Item 2
  * Item 2a
  * Item 2b
  
  [Odkaz](https://www.youtube.com/user/msadaghd)
  
Prvni | Druhy
----- | -----
A | B
C | D

First Header | Second Header
------------ | -------------
Content from cell 1 | Content from cell 2
Content in the first column | Content in the second column

```vhdl
-- (tohle je komentář)

-- import std_logic z knihovny IEEE
library IEEE;
use IEEE.std_logic_1164.all;

-- definice entity...
entity my_and is
  port (IN1, IN2 : in std_logic; OUT1: out std_logic);
end entity;

-- ...a architektury
architecture example of my_and is
begin
  OUT1 <= IN1 and IN2;
end example;
