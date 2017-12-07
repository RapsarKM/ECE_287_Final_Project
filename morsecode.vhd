library ieee;
USE ieee.std_logic_unsigned.all;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

entity morsecode is
	port(
		en		: in std_logic;
		clk		: in std_logic;
		led		: out std_logic;
		ps2_clk		: in std_logic;
		ps2_data	: in std_logic;
		ps2_code	: in std_logic_vector(7 downto 0);
		ps2_code_new : in std_logic;
		success		: out std_logic;
		boom		: out std_logic;
		MT			: out std_logic);
end morsecode;

architecture beh of morsecode is

	signal counter 	: std_logic_vector(32 downto 0);
	signal counter2 	: std_logic_vector(32 downto 0);
	signal letter1	: std_logic_vector(7 downto 0);
	signal letter2	: std_logic_vector(7 downto 0);
	signal letter3	: std_logic_vector(7 downto 0);
	signal letter4	: std_logic_vector(7 downto 0);
	signal letter5	: std_logic_vector(7 downto 0);
	
	signal short : std_logic;
	signal long : std_logic;
	

	type state_type is (off, start, code1, code2);
	signal state : state_type;
	
	begin	
	
	blink: process(clk)
	begin
	if clk'event and clk = '1' then	
			case state is
				when off =>
				when start =>
				when code1 =>
					--shell ... .... . ._.. ._..					
					if counter < x"19BFCC0" then
						led <= '1';
						counter <= counter + 1;
					elsif	counter < x"337F980" then
						counter <= counter + 1;
						led <= '0';
					elsif	counter < x"4D3F640" then
						counter <= counter + 1;
						led <= '1';
					elsif	counter < x"66FF300" then
						counter <= counter + 1;
						led <= '0';
					elsif counter < x"80BEFC0" then
						counter <= counter + 1;
						led <= '1';
					elsif counter < x"9A7EC80" then
						counter <= counter + 1;
						led <= '0';
					elsif counter < x"CDFE600" then
						counter <= counter + 1;
						led <= '0';
					elsif counter < x"E7BE2C0" then
						counter <= counter + 1;
						led <= '1';
					elsif counter < x"1017DF80" then
						counter <= counter + 1;
						led <= '0';
					elsif counter < x"11B3DC40" then
						counter <= counter + 1;
						led <= '1';
					elsif counter < x"134FD900" then
						counter <= counter + 1;
						led <= '0';
					elsif counter < x"14EBD5C0" then
						counter <= counter + 1;
						led <= '1';
					elsif counter < x"1687D280" then
						counter <= counter + 1;
						led <= '0';
					elsif counter < x"1823CF40" then
						counter <= counter + 1;
						led <= '1';
					elsif counter < x"19BFCC00" then
						counter <= counter + 1;
						led <= '0';
					elsif counter < x"1CF7C580" then
						counter <= counter + 1;
						led <= '0';
					elsif counter < x"1E93C240" then
						counter <= counter + 1;
						led <= '1';
					elsif counter < x"202FBF00" then
						counter <= counter + 1;
						led <= '0';
					elsif counter < x"2367B880" then
						counter <= counter + 1;
						led <= '0';
					elsif counter < x"2503B540" then
						counter <= counter + 1;
						led <= '1';
					elsif counter < x"269FB200" then
						counter <= counter + 1;
						led <= '0';
					elsif counter < x"29D7AB80" then
						counter <= counter + 1;
						led <= '1';
					elsif counter < x"2B73A840" then
						counter <= counter + 1;
						led <= '0';
					elsif counter < x"2D0FA500" then
						counter <= counter + 1;
						led <= '1';
					elsif counter < x"2EABA1C0" then
						counter <= counter + 1;
						led <= '0';
					elsif counter < x"30479E80" then
						counter <= counter + 1;
						led <= '1';
					elsif counter < x"31E39B40" then
						counter <= counter + 1;
						led <= '0';
					elsif counter < x"351B94C0" then
						counter <= counter + 1;
						led <= '0';
					elsif counter < x"36B79180" then
						counter <= counter + 1;
						led <= '1';
					elsif counter < x"38538E40" then
						counter <= counter + 1;
						led <= '0';
					elsif counter < x"3B8B87C0" then
						counter <= counter + 1;
						led <= '1';
					elsif counter < x"3D278480" then
						counter <= counter + 1;
						led <= '0';
					elsif counter < x"3EC38140" then
						counter <= counter + 1;
						led <= '1';
					elsif counter < x"405F7E00" then
						counter <= counter + 1;
						led <= '0';
					elsif counter < x"41FB7AC0" then
						counter <= counter + 1;
						led <= '1';
					elsif counter < x"43977780" then
						counter <= counter + 1;
						led <= '0';
					elsif counter < x"46CF7100" then
						counter <= counter + 1;
						led <= '0';
					else
						counter <= (others => '0');
					end if;
					
				when code2 =>
				-- slick
				if counter < x"19BFCC0" then
						led <= '1';
						counter <= counter + 1;
					elsif	counter < x"337F980" then
						counter <= counter + 1;
						led <= '0';
					elsif	counter < x"4D3F640" then
						counter <= counter + 1;
						led <= '1';
					elsif	counter < x"66FF300" then
						counter <= counter + 1;
						led <= '0';
					elsif counter < x"80BEFC0" then
						counter <= counter + 1;
						led <= '1';
					elsif counter < x"9A7EC80" then
						counter <= counter + 1;
						led <= '0';
					elsif counter < x"CDFE600" then
						counter <= counter + 1;
						led <= '0';
					elsif counter < x"E7BE2C0" then
						counter <= counter + 1;
						led <= '1';
					elsif counter < x"1017DF80" then
						counter <= counter + 1;
						led <= '0';
					elsif counter < x"134FD900" then
						counter <= counter + 1;
						led <= '1';
					elsif counter < x"14EBD5C0" then
						counter <= counter + 1;
						led <= '0';
					elsif counter < x"1687D280" then
						counter <= counter + 1;
						led <= '1';
					elsif counter < x"1823CF40" then
						counter <= counter + 1;
						led <= '0';
					elsif counter < x"19BFCC00" then
						counter <= counter + 1;
						led <= '1';
					elsif counter < x"1B5BC8C0" then
						counter <= counter + 1;
						led <= '0';
					elsif counter < x"1E93C240" then
						counter <= counter + 1;
						led <= '0';
					elsif counter < x"202FBF00" then
						counter <= counter + 1;
						led <= '1';
					elsif counter < x"21CBBBC0" then
						counter <= counter + 1;
						led <= '0';
					elsif counter < x"2367B880" then
						counter <= counter + 1;
						led <= '1';
					elsif counter < x"2503B540" then
						counter <= counter + 1;
						led <= '0';
					elsif counter < x"283BAEC0" then
						counter <= counter + 1;
						led <= '0';
					elsif counter < x"2B73A840" then
						counter <= counter + 1;
						led <= '1';
					elsif counter < x"2D0FA500" then
						counter <= counter + 1;
						led <= '0';
					elsif counter < x"2EABA1C0" then
						counter <= counter + 1;
						led <= '1';
					elsif counter < x"30479E80" then
						counter <= counter + 1;
						led <= '0';
					elsif counter < x"337F9800" then
						counter <= counter + 1;
						led <= '1';
					elsif counter < x"351B94C0" then
						counter <= counter + 1;
						led <= '0';
					elsif counter < x"36B79180" then
						counter <= counter + 1;
						led <= '1';
					elsif counter < x"38538E40" then
						counter <= counter + 1;
						led <= '0';
					elsif counter < x"3B8B87C0" then
						counter <= counter + 1;
						led <= '0';
					elsif counter < x"3EC38140" then
						counter <= counter + 1;
						led <= '1';
					elsif counter < x"405F7E00" then
						counter <= counter + 1;
						led <= '0';
					elsif counter < x"41FB7AC0" then
						counter <= counter + 1;
						led <= '1';
					elsif counter < x"43977780" then
						counter <= counter + 1;
						led <= '0';
					elsif counter < x"46CF7100" then
						counter <= counter + 1;
						led <= '1';
					elsif counter < x"486B6DC0" then
						counter <= counter + 1;
						led <= '0';
					elsif counter < x"4BA36740" then
						counter <= counter + 1;
						led <= '0';
					else
						counter <= (others => '0');
					end if;
				end case;
		end if;
	end process blink;

	process(clk)
	begin

		if en = '0' then
			state <= off;
			success <= '0';
		elsif clk'event and clk ='1' then
			case state is
				when off =>
					boom <= '0';
					state <= start;
					MT <= '0';
				when start =>
					MT <= '1';
					boom <= '0';
					if ps2_code_new = '1' and ps2_code = X"3A" then
						MT <= '0';
						state <= code1;
					end if;
				when code1 =>
				--shell ... .... . ._.. ._..
				if counter2 < "1100110111111110011000000" then
						counter2 <= counter2 + 1;
				else
					counter2 <= (others => '0');
					if  ps2_code_new = '1' then
						if ps2_code = X"16" then
							state <= code2;
							counter2 <= (others => '0');
						elsif ps2_code = X"1E" or ps2_code = X"26" or ps2_code = X"25" then	
							boom <= '1';
						end if;
					end if;
				end if;
				when code2 =>
				-- slick
				if counter2 < "1100110111111110011000000" then
						counter2 <= counter2 + 1;
				else
					counter2 <= (others => '0');
					if  ps2_code_new = '1' then
						if ps2_code = X"26" then
							success <= '1';
						elsif ps2_code = X"1E" or ps2_code = X"25" then	
							boom <= '1';
						end if;
					end if;
				end if;
				end case;
		end if;
	end process;
	
	end beh;
	