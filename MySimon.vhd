library IEEE;
Use IEEE.STD_LOGIC_1164.ALL;
Use IEEE.STD_LOGIC_ARITH.ALL;
Use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity MySimon is
	port ( b1,b2,b3,b4 : in std_logic;
			led1,led2,led3,led4, led5 : out std_logic;
			lose : out std_logic;
			clk: in std_logic;
			enable: in std_logic;
			fl : out std_logic;
			success : out std_logic;
			strt : out std_logic
			);
	end MySimon;
architecture behavior of MySimon is
	type state_type is(lit0,lit1,lit2,lit3,s0,s1,s2,s3,waitt,pass,fail,start);
	signal state: state_type;
	signal rst : std_logic := '1';
	signal debrst :std_logic := '1';
	signal counter : std_logic_vector(32 downto 0);
	signal debcounter : std_logic_vector(32 downto 0);
	signal sc1 : std_logic := '0';
	signal sc2 : std_logic_vector(1 downto 0);
	signal sc3 : std_logic_vector(2 downto 0);


	begin
		
		counter1: process(clk)
	begin
	
		
		
			if clk'event and clk = '1'then
			
				if rst = '0' and counter < "1100000100011110011110100000000" then
				
					counter <= counter + 1;
					
				else 
					counter <= (others => '0');
				end if;
			end if;
		
	end process counter1;
	
	debcounter1: process(clk)
	begin
	
		
		
			if clk'event and clk = '1'then
			
				if debrst = '0' and debcounter < "1100110111111110011000000" then
				
					debcounter <= debcounter + 1;
					
				
				end if;
			end if;
		
	end process debcounter1;
	
	
	
	
	simon: process(clk)
		begin
		if(enable = '0') then
			state <= waitt;
		
		elsif (clk'event and clk = '1') then
			case state is
				when start =>
					rst <= '1';
					strt <= '1';
					fl <= '0';
					success <= '0';
					state <= lit0;
				when lit0 =>
					rst <= '0';
					led5 <= '0';
					if counter < "110011011111111001100000000" then
					led1 <= '1';
					led2 <= '0';
					led3 <= '0';
					led4 <= '0';
					else
					
					rst <= '1';
					state <= s0;
					end if;
				when s0 =>
					rst <= '0';
					
					led1 <= '0';
					led2 <= '0';
					led3 <= '0';
					led4 <= '0';
					led5 <= '1';
					
					if  counter < "1100110111111110011000000000" then -- 2 sec
						if debcounter < "1100110111111110011000000"  then -- .25 sec
							if b1 = '0' then
								rst <= '1';
								state <= lit1;
								debcounter <= (others => '0');
							end if;
						else 
							debcounter <= (others => '0');
						end if;
					else
						state <= fail;
					end if;
				when lit1 =>
					rst <= '0';
					led5 <= '0';
					if counter < "110011011111111001100000000" then
						led1 <= '1';
						led2 <= '0';
						led3 <= '0';
						led4 <= '0';
					
					elsif counter < "1001101001111110110010000000" then
						led1 <= '0';
						led2 <= '0';
						led3 <= '1';
						led4 <= '0';
					else
					
						rst <= '1';
						state <= s1;
					end if;
				when s1 =>
					rst <= '0';
					
					led1 <= '0';
					led2 <= '0';
					led3 <= '0';
					led4 <= '0';
					led5 <= '1';
					
					if  counter < "11001101111111100110000000000" then -- 4 sec
						if debcounter < "1100110111111110011000000"  then -- .25 sec
							if b1 = '0' then
								sc1 <= '1';
								debcounter <= (others => '0');
							end if;
							if b3 = '0' and sc1 <= '1' then
								rst <= '1';
								state <= lit2;
								debcounter <= (others => '0');
						else 
							debcounter <= (others => '0');
						end if;
					
					end if;
					else
						state <= fail;
					end if;
				when lit2 =>
					rst <= '0';
					led5 <= '0';
					if counter < "110011011111111001100000000" then --1 sec
					led1 <= '0';
					led2 <= '0';
					led3 <= '1';
					led4 <= '0';
					
					elsif counter < "1001101001111110110010000000" then -- 1.5 sec
					led1 <= '0';
					led2 <= '1';
					led3 <= '0';
					led4 <= '0';
					
					elsif counter < "1100110111111110011000000000" then --2 sec
					led1 <= '0';
					led2 <= '0';
					led3 <= '0';
					led4 <= '1';
					else
					rst <= '1';
					state <= s2;
					end if;
				when s2 =>
					rst <= '0';
					
					led1 <= '0';
					led2 <= '0';
					led3 <= '0';
					led4 <= '0';
					led5 <= '1';
					
					if  counter < "100000001011111011111100000000" then -- 5 sec
						if debcounter < "1100110111111110011000000"  then -- .25 sec
							if b3 = '0' then
								sc2 <= "01";
								debcounter <= (others => '0');
							end if;
							if b2 = '0' and sc2 = "01" then
								sc2 <= "10";
								debcounter <= (others => '0');
							end if;
							if b4 = '0' and sc2 = "10" then
								rst <= '1';
								state <= lit3;
								debcounter <= (others => '0');
							end if;
						else 
							debcounter <= (others => '0');
						end if;
					
					
					else
						state <= fail;
					end if;
				when lit3 =>
					rst <= '0';
					led5 <= '0';
					if counter < "110011011111111001100000000" then --1 sec
					led1 <= '0';
					led2 <= '1';
					led3 <= '0';
					led4 <= '0';
					
					elsif counter < "1001101001111110110010000000" then -- 1.5 sec
					led1 <= '0';
					led2 <= '0';
					led3 <= '0';
					led4 <= '1';
					
					elsif counter < "1100110111111110011000000000" then --2 sec
					led1 <= '0';
					led2 <= '0';
					led3 <= '1';
					led4 <= '0';
					elsif counter < "10000000101111101111110000000" then --2.5 sec
					led1 <= '1';
					led2 <= '0';
					led3 <= '0';
					led4 <= '0';
					else
					rst <= '1';
					state <= s3;
					end if;
				when s3 =>
					rst <= '0';
					
					led1 <= '0';
					led2 <= '0';
					led3 <= '0';
					led4 <= '0';
					led5 <= '1';
					
					if  counter < "100000001011111011111100000000" then -- 5 sec
						if debcounter < "1100110111111110011000000"  then -- .25 sec
							if b2 = '0' then
								sc3 <= "001";
								debcounter <= (others => '0');
							end if;
							if b3 = '0' and sc3 = "010"then
								sc3 <= "100";
								debcounter <= (others => '0');
							end if;
							if b4 = '0' and sc3 = "001" then
								sc3 <= "010";
								debcounter <= (others => '0');
							end if;
							if b1 = '0' and sc3 = "100"then
								rst <= '1';
								state <= pass;
								debcounter <= (others => '0');
							end if;
						else 
							debcounter <= (others => '0');
						end if;
					else
						state <= fail;
					end if;
					
					
				when waitt =>
					if enable <= '1' then
						state <= start;
						end if;
				when pass =>
					success <= '1';
				when fail =>
					fl <= '1';
			end case;
		end if;
	end process;
end behavior;