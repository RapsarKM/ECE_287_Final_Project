--------------------------------------------------------------------------------
--
--   FileName:         hw_image_generator.vhd
--   Dependencies:     none
--   Design Software:  Quartus II 64-bit Version 12.1 Build 177 SJ Full Version
--
--   HDL CODE IS PROVIDED "AS IS."  DIGI-KEY EXPRESSLY DISCLAIMS ANY
--   WARRANTY OF ANY KIND, WHETHER EXPRESS OR IMPLIED, INCLUDING BUT NOT
--   LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A
--   PARTICULAR PURPOSE, OR NON-INFRINGEMENT. IN NO EVENT SHALL DIGI-KEY
--   BE LIABLE FOR ANY INCIDENTAL, SPECIAL, INDIRECT OR CONSEQUENTIAL
--   DAMAGES, LOST PROFITS OR LOST DATA, HARM TO YOUR EQUIPMENT, COST OF
--   PROCUREMENT OF SUBSTITUTE GOODS, TECHNOLOGY OR SERVICES, ANY CLAIMS
--   BY THIRD PARTIES (INCLUDING BUT NOT LIMITED TO ANY DEFENSE THEREOF),
--   ANY CLAIMS FOR INDEMNITY OR CONTRIBUTION, OR OTHER SIMILAR COSTS.
--
--   Version History
--   Version 1.0 05/10/2013 Scott Larson
--     Initial Public Release
--    
--------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_ARITH.all;
use ieee.std_logic_unsigned.all;

ENTITY hw_image_generator IS
	GENERIC(
		pixels_y :	INTEGER := 478;    --row that first color will persist until
		pixels_x	:	INTEGER := 600);   --column that first color will persist until
	PORT(
		disp_ena		:	IN		STD_LOGIC;	--display enable ('1' = display time, '0' = blanking time)
		row			:	IN		INTEGER;		--row pixel coordinate
		column		:	IN		INTEGER;		--column pixel coordinate
		clk			: 	IN 	STD_LOGIC;
		ps2_clk      : IN  STD_LOGIC;                     --clock signal from PS/2 keyboard
		ps2_data     : IN  STD_LOGIC;                     --data signal from PS/2 keyboard
		led			: 	OUT 	STD_LOGIC;
		red			:	OUT	STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');  --red magnitude output to DAC
		green			:	OUT	STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');  --green magnitude output to DAC
		blue			:	OUT	STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0'); --blue magnitude output to DAC
		b1,b2,b3,b4 : in std_logic;
		led1,led2,led3,led4, led5 : out std_logic);
END hw_image_generator;

ARCHITECTURE behavior OF hw_image_generator IS

	signal counter: std_logic_vector(32 downto 0);
	
	signal switch: std_LOGIC;
	signal m1: std_LOGIC;
	signal m2: std_LOGIC;
	signal words: std_logic;
	signal boom1: std_logic;
	signal explode: std_logic;
	
	signal ps2_code_new: std_logic;
	signal ps2_code: std_LOGIC_VECTOR(8 downto 1);
	signal option: std_LOGIC;
	
	-- signals from justDance
	signal up : std_LOGIC;
	signal down : std_LOGIC;
	signal leftt : std_LOGIC;
	signal rightt : std_LOGIC;
	signal jtitle : std_LOGIC;
	signal fail : std_LOGIC;
	signal pass : std_LOGIC;
	signal clr	: std_LOGIC;
	signal ps : std_LOGIC;
	signal U : std_LOGIC;
	signal D : std_LOGIC;
	signal L : std_LOGIC;
	signal R : std_LOGIC;
	signal T : std_LOGIC;
	signal enable: std_LOGIC := '0';
	
	-- signals from morse code
	signal morseEn : std_LOGIC := '0';
	signal morseSuccess : std_LOGIC := '0';
	signal morseBoom : std_logic := '0';
	signal mtitle	: std_LOGIC;
	signal MT		: std_logic;
	signal ml1		: std_logic;
	signal ml2		: std_logic;
	signal ml3		: std_logic;
	signal ml4		: std_logic;
	
	-- signals from sequence game
	signal seqEn	: std_logic:= '0';
	signal seqfl	: std_logic;
	signal seqT		: std_logic;
	signal seqtitle: std_logic;
	signal seqSuccess	: std_logic;
	signal stitle	: std_LOGIC;
	
	type state_type is (title, Win, Boom, jusDance, morsecode, seq);
	signal state : state_type := title;
	

BEGIN
	sequence: entity work.MySimon
		port map(
			b1=>b1,
			b2=>b2,
			b3=>b3,
			b4=>b4,
			led1=>led1,
			led2=>led2,
			led3=>led3,
			led4=>led4, 
			led5=>led5,
			enable => seqEn,
			clk  => clk,
			strt => seqT,
			fl => seqfl,
			success => seqSuccess);
			
	morse: entity work.morsecode
		port map (
			en		=> morseEn,
			clk	=> clk,
			led	=> led,
			ps2_clk	=> ps2_clk,
			ps2_data	=> ps2_data,
			ps2_code	=> ps2_code,
			ps2_code_new => ps2_code_new,
			success		=> morseSuccess,
			boom		=> morseBoom,
			MT			=> MT);
		
	
	justDance: entity work.justDance
		port map(
			enable	=> enable,
			clk		=> clk,
			T			=> T,
			U			=> U,
			D			=> D,
			L			=> L,
			R			=> R,
			fl			=> fail,
			sc			=> ps,
			ps2_clk	=> ps2_clk,
			ps2_data	=> ps2_data);
		

	keyboard: entity work.ps2_keyboard
		GENERIC map(
			clk_freq              => 108_000_000, --system clock frequency in Hz
			debounce_counter_size => 9)         --set such that (2^size)/clk_freq = 5us (size = 8 for 50MHz)
		PORT map(
			clk          => clk,                     --system clock
			ps2_clk      => ps2_clk,                   --clock signal from PS/2 keyboard
			ps2_data     => ps2_data,                     --data signal from PS/2 keyboard
			ps2_code_new => ps2_code_new,                    --flag that new PS/2 code is available on ps2_code bus
			ps2_code     => ps2_code --code received from PS/2
			);
	
	winner: entity work.Pixel_On_Text
        generic map (
        	textLength => 25
        )
        port map(
        	clk => clk,
        	displayText => "You Have Defused the Bomb",
        	position => (50, 50), -- text position (top left)
        	horzCoord => row,
        	vertCoord => column,
        	pixel => pass -- result
        );
		  
	ww: entity work.Pixel_On_Text
        generic map (
        	textLength => 2
        )
        port map(
        	clk => clk,
        	displayText => "UP",
        	position => (50, 50), -- text position (top left)
        	horzCoord => row,
        	vertCoord => column,
        	pixel => up -- result
        );
	ss: entity work.Pixel_On_Text
        generic map (
        	textLength => 4
        )
        port map(
        	clk => clk,
        	displayText => "DOWN",
        	position => (50, 50), -- text position (top left)
        	horzCoord => row,
        	vertCoord => column,
        	pixel => down -- result
        );
	aa: entity work.Pixel_On_Text
        generic map (
        	textLength => 4
        )
        port map(
        	clk => clk,
        	displayText => "LEFT",
        	position => (50, 50), -- text position (top left)
        	horzCoord => row,
        	vertCoord => column,
        	pixel => leftt -- result
        );
		  
	dd: entity work.Pixel_On_Text
        generic map (
        	textLength => 5
        )
        port map(
        	clk => clk,
        	displayText => "RIGHT",
        	position => (50, 50), -- text position (top left)
        	horzCoord => row,
        	vertCoord => column,
        	pixel => rightt -- result
        );
		  
	t1: entity work.Pixel_On_Text
        generic map (
        	textLength => 25
        )
        port map(
        	clk => clk,
        	displayText => "Click N to start Sequence",
        	position => (50, 50), -- text position (top left)
        	horzCoord => row,
        	vertCoord => column,
        	pixel => stitle -- result
        );
		  
	t2: entity work.Pixel_On_Text
        generic map (
        	textLength => 27
        )
        port map(
        	clk => clk,
        	displayText => "Click J to start Just Dance",
        	position => (50, 50), -- text position (top left)
        	horzCoord => row,
        	vertCoord => column,
        	pixel => jtitle -- result
        );
		  
	t3: entity work.Pixel_On_Text
        generic map (
        	textLength => 27
        )
        port map(
        	clk => clk,
        	displayText => "Click M to start Morse Code",
        	position => (50, 50), -- text position (top left)
        	horzCoord => row,
        	vertCoord => column,
        	pixel => mtitle -- result
        );
	
	morse1: entity work.Pixel_On_Text
        generic map (
        	textLength => 8
        )
        port map(
        	clk => clk,
        	displayText => "1: shell",
        	position => (50, 50), -- text position (top left)
        	horzCoord => row,
        	vertCoord => column,
        	pixel => ml1 -- result
        );
	morse2: entity work.Pixel_On_Text
        generic map (
        	textLength => 8
        )
        port map(
        	clk => clk,
        	displayText => "2: halls",
        	position => (50, 100), -- text position (top left)
        	horzCoord => row,
        	vertCoord => column,
        	pixel => ml2 -- result
        );
	morse3: entity work.Pixel_On_Text
        generic map (
        	textLength => 8
        )
        port map(
        	clk => clk,
        	displayText => "3: slick",
        	position => (50, 150), -- text position (top left)
        	horzCoord => row,
        	vertCoord => column,
        	pixel => ml3 -- result
        );
	morse4: entity work.Pixel_On_Text
        generic map (
        	textLength => 8
        )
        port map(
        	clk => clk,
        	displayText => "4: trick",
        	position => (50, 200), -- text position (top left)
        	horzCoord => row,
        	vertCoord => column,
        	pixel => ml4 -- result
        );
		  
	menu1: entity work.Pixel_On_Text
        generic map (
        	textLength => 34
        )
        port map(
        	clk => clk,
        	displayText => "Welcome to Our Bomb Diffusing Game",
        	position => (50, 50), -- text position (top left)
        	horzCoord => row,
        	vertCoord => column,
        	pixel => m1 -- result
        );
		  
	menu2: entity work.Pixel_On_Text
        generic map (
        	textLength => 20
        )
        port map(
        	clk => clk,
        	displayText => "Press Enter to start",
        	position => (50, 100), -- text position (top left)
        	horzCoord => row,
        	vertCoord => column,
        	pixel => m2 -- result
        );

		  
	kaboom: entity work.Pixel_On_Text
        generic map (
        	textLength => 5
        )
        port map(
        	clk => clk,
        	displayText => "BOOM!",
        	position => (50, 50), -- text position (top left)
        	horzCoord => row,
        	vertCoord => column,
        	pixel => boom1 -- result
        );

	ProCESS (clk)
		begin
		if clk'event and clk = '1' then
		if counter < "110011011111111001100000000" then
				counter <= counter +1;
		--else
			--	counter <= (others => '0');
				--switch <= not switch;
		end if;
		end if;
		end proCESS;
	
	menustates: process (clk)
		begin
		if clk'event and clk = '1' then
			if ps2_code_new = '1' and ps2_code = X"76" then
				state <= title;
			end if;
			case state is 
				when title =>
					words <= m1 or m2;
					explode <= '1';
					if ps2_code_new = '1' then
						if ps2_code = X"5A" then
							words <= '0';
							state <= seq;
						end if;
					end if;
				when Boom =>
					words <= '0';
					explode <= boom1;
				when seq =>
					if ps2_code_new = '1' and ps2_code = X"31" theN
						words <= '0';
						seqEn <= '1';
					else
						words <= stitle;
					end if;
					if seqSuccess = '1' then
						state <= jusDance;
					elsif seqfl = '1' then
						state <= Boom;
					end if;
				when morsecode =>
						morseEn <= '1';
						if MT = '1' then
							words <= mtitle;
						else
							words <= ml1 or ml2 or ml3 or ml4;
						end if;
						if morseSuccess = '1' then	
							state <= win;
						elsif morseBoom = '1' theN
							state <= Boom;
						end if;
				when jusDance =>
						
						enable <= '1';
						if T = '1' theN
							words <= jtitle;
						elsif U = '1' then	
							words <= up;
						elsif D = '1' theN
							words <= down;
						elsif L = '1' theN
							words <= leftt;
						elsif R = '1' theN
							words <= rightt;
						end if;
						if fail = '1' theN
							enable <= '0';
							state <= Boom;
						end if;
						if ps = '1' theN
							enable <= '0';
							words <= '0';
							state <= morsecode;							
						end if;
				when win =>
						words <= pass;
			end case;
		end if;
	
	end proCESS menustates;
			
	 PROCESS(disp_ena, row, column)		
	BEGIN

		IF(disp_ena = '1') THEN		--display time
				IF(words = '1') THEN
					red <= (OTHERS => '0');
					green	<= (OTHERS => '1');
					blue <= (OTHERS => '0');
				ELSIF(explode ='0') THEN
					red <= (OTHERS => '1');
					green	<= (OTHERS => '0');
					blue <= (OTHERS => '0');
				ELSE
					red <= (OTHERS => '0');
					green	<= (OTHERS => '0');
					blue <= (OTHERS => '0');
				END IF;
		ELSE								--blanking time
			red <= (OTHERS => '0');
			green <= (OTHERS => '0');
			blue <= (OTHERS => '0');
		END IF;
	
	END PROCESS;
	
	
END behavior;