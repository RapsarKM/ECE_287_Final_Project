library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_unsigned.all;
use IEEE.std_logic_arith.all;

entity justDance is
	port(
		ps2_clk		: IN  STD_LOGIC;                     --clock signal from PS/2 keyboard
		ps2_data		: IN  STD_LOGIC;                     --data signal from PS/2 keyboard
		clk			:	in STD_LOGIC;
		enable		:	in STD_LOGIC;
		T				:	out STD_LOGIC;
		U				:	out STD_LOGIC;
		D				:	out STD_LOGIC;
		L				:	out STD_LOGIC;
		R				:	out STD_LOGIC;
		fl				:	out STD_LOGIC;
		sc				:	out STD_LOGIC
	);
end justDance;

architecture behavior of justDance is
	type state_type is(start, one, two, three, four,five,six,seven,eight,nine,ten,eleven,twelve,thirteen,fourteen,fifteen,fail, pass, waitt);
	signal state: state_type; 
	signal keyin : std_LOGIC_VECTOR(8 downto 1);
	signal ps2_code_new: std_logic;
	signal counter 	: std_logic_vector(29 downto 0);
	signal rst : std_LOGIC;
	signal en2 : std_Logic:= '0';
BEGIN
	
	counter1: process(clk)
	BEGIN
		if en2 = '1' then
			if clk'event and clk = '1'then
				if rst = '0' and counter < X"66FF300" then
					counter <= counter + 1;
				else 
					counter <= (others => '0');
				end if;
			end if;
		end if;
	end process counter1;
	
	
	
	
	keyboard: entity work.ps2_keyboard
		GENERIC map(
			clk_freq              => 108_000_000, 			--system clock frequency in Hz
			debounce_counter_size => 9)         			--set such that (2^size)/clk_freq = 5us (size = 8 for 50MHz)
		PORT map(
			clk          => clk,                     		--system clock
			ps2_clk      => ps2_clk,                  	--clock signal from PS/2 keyboard
			ps2_data     => ps2_data,                    --data signal from PS/2 keyboard
			ps2_code_new => ps2_code_new,                --flag that new PS/2 code is available on ps2_code bus
			ps2_code     => keyin 								--code received from PS/2
			);
			
	sDance: process(clk)  --state machine for just dance module
	begin
		if(enable = '0') then
			state <= waitt;
		
		elsif (clk'event and clk = '1') then
		case state is
			when start =>
				T <= '1';
				sc <= '0';
				fl <= '0';
				if ps2_code_new = '1' then
					if keyin = X"3B" then
						T <= '0';
						en2 <= '1';
						rst <= '1';
						U <='0';
						D <='0';
						L <='0';
						R <='1';
						state <= one;					
					end if;
				end if;
			when one =>
				rst <= '0';
				if counter < X"4D3F640" then
				if ps2_code_new = '1' then 
					if keyin = X"23" then
						rst <= '1';
						U <='0';
						D <='0';
						L <='1';
						R <='0';
						state <= two;
					end if;
				end if;
				else 
					state <= fail;
				end if;
				
			when two =>
			if counter < X"4D3F640" then
				rst <= '0';
				if ps2_code_new = '1' then
					if keyin = X"1C" then
						rst <= '1';
						U <='0';
						D <='1';
						L <='0';
						R <='0';
						state <= three;
					end if;
				end if;
			else
				state <= fail;
			end if;
			when three =>
				rst <= '0';
				if counter < X"4D3F640" then
				if ps2_code_new = '1'  then
					if keyin = X"1B" then
						rst <= '1';
						U <='0';
						D <='0';
						L <='1';
						R <='0';
						state <= four;
					end if;
			
				end if;
			else
				state <= fail;
				end if;
			when four =>
				rst <= '0';
				if counter < X"4D3F640" then
				if ps2_code_new = '1'  then
					if keyin = X"1C" then
						rst <= '1';
						U <='1';
						D <='0';
						L <='0';
						R <='0';
						state <= five;
					end if;
				
				end if;
			else
				state <= fail;
				end if;
			when five =>
				rst <= '0';
				if counter < X"4D3F640" then
				if ps2_code_new = '1'  then
					if keyin = X"1D" then
						rst <= '1';
						U <='0';
						D <='0';
						L <='0';
						R <='1';
						state <= six;
					end if;
				
				end if;
				else
					state <= fail;
				end if;
			when six =>
				rst <= '0';
				if counter < X"4D3F640" then
				if ps2_code_new = '1'  then
					if keyin = X"23" then
						rst <= '1';
						U <='0';
						D <='1';
						L <='0';
						R <='0';
						state <= seven;
					end if;
			
				end if;
			else
				state <= fail;
				end if;
			when seven =>
				rst <= '0';
				if counter < X"4D3F640" then
				if ps2_code_new = '1'  then
					if keyin = X"1B" then
						rst <= '1';
						U <='0';
						D <='0';
						L <='1';
						R <='0';
						state <= eight;
					end if;
			
				end if;
			else
				state <= fail;	
				end if;
			when eight =>
				rst <= '0';
				if counter < X"4D3F640" then
				if ps2_code_new = '1'  then
					if keyin = X"1C" then
						rst <= '1';
						U <='1';
						D <='0';
						L <='0';
						R <='0';
						state <= nine;
					end if;
			
				end if;
			else
				state <= fail;
			end if;
			when nine =>
				rst <= '0';
				if counter < X"4D3F640" then
				if ps2_code_new = '1'  then
					if keyin = X"1D" then
						rst <= '1';
						U <='0';
						D <='0';
						L <='0';
						R <='1';
						state <= ten;
					end if;
				
				end if;
				else
					state <= fail;
				end if;
			when ten =>
				rst <= '0';
				if counter < X"4D3F640" then
				if ps2_code_new = '1'  then
					if keyin = X"23" then
						rst <= '1';
						U <='0';
						D <='1';
						L <='0';
						R <='0';
						state <= eleven;
					end if;
			
				end if;
			else
				state <= fail;	
				end if;
			when eleven =>
				rst <= '0';
				if counter < X"4D3F640" then
				if ps2_code_new = '1'  then
					if keyin = X"1B" then
						rst <= '1';
						U <='0';
						D <='0';
						L <='1';
						R <='0';
						state <= twelve;
					end if;
		
				end if;
				else
					state <= fail;
				end if;
			when twelve =>
				rst <= '0';
				if counter < X"4D3F640" then
				if ps2_code_new = '1'  then
					if keyin = X"1C" then
						rst <= '1';
						U <='0';
						D <='1';
						L <='0';
						R <='0';
						state <= thirteen;
					end if;
		
				end if;
				else
					state <= fail;
				end if;
			when thirteen =>
				rst <= '0';
				if counter < X"4D3F640" then
				if ps2_code_new = '1'  then
					if keyin = X"1B" then
						rst <= '1';
						U <='0';
						D <='0';
						L <='0';
						R <='1';
						state <= fourteen;
					end if;
		
				end if;
				else
					state <= fail;
				end if;
			when fourteen =>
				rst <= '0';
				if counter < X"4D3F640" then
				if ps2_code_new = '1'  then
					if keyin = X"23" then
						rst <= '1';
						U <='1';
						D <='0';
						L <='0';
						R <='0';
						state <= fifteen;
					end if;
		
				end if;
				else
					state <= fail;
				end if;
			when fifteen =>
				rst <= '0';
			if counter < X"4D3F640" then
				if ps2_code_new = '1'  then
					if keyin = X"23" then
						rst <= '1';
						state <= pass;
					end if;
				end if;
			else
				state <= fail;
			end if;
			when fail =>
				U <='0';
				D <='0';
				L <='0';
				R <='0';
				fl <= '1';
			when pass =>
				U <='0';
				D <='0';
				L <='0';
				R <='0';
				sc <= '1';
			
			when waitt =>
				T <= '0';
				state <= start;
		end case;
		end if;
	end process sDance;
end behavior;