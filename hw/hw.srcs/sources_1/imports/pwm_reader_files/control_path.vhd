library ieee;
use ieee.std_logic_1164.all;
entity fsm is
   port(
      clk, rst: in std_logic;
      pwm_in: in std_logic;
      clear, count, load: out std_logic
   );
end fsm;

architecture arch of fsm is
   type state_type is (s0, s1);
   signal st_reg, st_next: state_type;
begin
   -- state register
   process(clk,rst)
   begin
      if (rst='1') then
         st_reg <= s0;
      elsif rising_edge(clk) then
         st_reg <= st_next;
      end if;
   end process;
   -- next-state/output logic
   process(st_reg,pwm_in)
   begin
      st_next <= st_reg;  -- default back to same state
      clear <= '0';  -- all outputs default to '0'  
      count <= '0';   
	  load <= '0';
	  
      case st_reg is
         when s0 =>
            clear <= '1';
            if pwm_in='1' then
			    st_next <= s1;
			end if;
			
         when s1 =>
            count <= '1';
            if pwm_in='0' then
                load <= '1';
                st_next <= s0;
            end if;
      end case;
      
   end process;
   
end arch;
