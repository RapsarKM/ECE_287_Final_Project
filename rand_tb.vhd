LIBRARY ieee  ; 
LIBRARY std  ; 
USE ieee.std_logic_1164.all  ; 
USE ieee.std_logic_textio.all  ; 
USE ieee.std_logic_unsigned.all  ; 
USE std.textio.all  ; 
ENTITY rand_tb  IS 
END ; 
 
ARCHITECTURE rand_tb_arch OF rand_tb IS
  SIGNAL Q   :  std_logic_vector (7 downto 0)  ; 
  SIGNAL check   :  STD_LOGIC  ; 
  SIGNAL clk   :  STD_LOGIC  ; 
  SIGNAL en   :  STD_LOGIC  ; 
  SIGNAL reset   :  STD_LOGIC  ; 
  COMPONENT rand  
    PORT ( 
      Q  : out std_logic_vector (7 downto 0) ; 
      check  : out STD_LOGIC ; 
      clk  : in STD_LOGIC ; 
      en  : in STD_LOGIC ; 
      reset  : in STD_LOGIC ); 
  END COMPONENT ; 
BEGIN
  DUT  : rand  
    PORT MAP ( 
      Q   => Q  ,
      check   => check  ,
      clk   => clk  ,
      en   => en  ,
      reset   => reset   ) ; 



-- "Clock Pattern" : dutyCycle = 50
-- Start Time = 0 ns, End Time = 1 us, Period = 100 ns
  Process
	Begin
	 clk  <= '0'  ;
	wait for 50 ns ;
-- 50 ns, single loop till start period.
	for Z in 1 to 9
	loop
	    clk  <= '1'  ;
	   wait for 50 ns ;
	    clk  <= '0'  ;
	   wait for 50 ns ;
-- 950 ns, repeat pattern in loop.
	end  loop;
	 clk  <= '1'  ;
	wait for 50 ns ;
-- dumped values till 1 us
	wait;
 End Process;


-- "Constant Pattern"
-- Start Time = 0 ns, End Time = 1 us, Period = 0 ns
  Process
	Begin
	 reset  <= '0'  ;
	wait for 1 us ;
-- dumped values till 1 us
	wait;
 End Process;


-- "Constant Pattern"
-- Start Time = 0 ns, End Time = 1 us, Period = 0 ns
  Process
	Begin
	 en  <= '1'  ;
	wait for 1 us ;
-- dumped values till 1 us
	wait;
 End Process;
END;
