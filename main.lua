--[[
	Tekijä: Rami Reini
	Opinnäytetyö 2016

	Kuvaus: Space Survival on 2D "Shoot 'em up" avaruuspeli.
]]

-- Tiedoston kuvaus: Osa tiedostojärjestelmän hallintaa, moduulit ja tärkeimmät takaisinkutsufunktiot



-- Tiedostojärjestelmä tarkistuksia
if not love.filesystem.exists("percentvolume.txt", percentVolume) then
	percentVolume = 50
	love.filesystem.write("percentvolume.txt", percentVolume)
end

if not love.filesystem.exists("highscore.txt", playerHighscore) then
	playerHighscore = 0
	love.filesystem.write("highscore.txt", playerHighscore)
end

-- Edellytetään tarvittavat tiedostot
require 'conf'
require 'menu'
require 'intro'
require 'player'
require 'bullet'
require 'enemy'
require 'pause'
require 'gameover'
require 'health'
require 'pointsgame'
require 'pointsmenu'
require 'options1'
require 'options2'
require 'explosion'
require 'score'
require 'powerups'
require 'credits'

-- Kutsutaan kerran pelin alussa. Lataamme pelin ominaisuuksia ja määritämme tiettyjä asioita
function love.load()

	love.math.setRandomSeed(os.time())
	love.math.random(1, 100)
	love.math.random(1, 100)
	menu_load()
	options1_load()
	options2_load()
	intropointsgame_load()
	pointsgame_load()
	pointsmenu_load()
	explosion_load()
	gameover_load()
	enemy_load()
	bullet_load()
	health_load()
	player_load()
	pause_load()
	powerup_load()
	credits_load()

	love.graphics.setBackgroundColor(10, 10, 10, 200)

	local cursor
	cursor = love.mouse.newCursor("Assets/Images/GameCursor.png", 0, 0)
	love.mouse.setCursor(cursor)

	shakeTimer = 0.6
	gamestate = "menu"
end

-- Kutsutaan jatkuvasti ja sen sisällä lasketaan yleensä suurin määrä matematiikkaa
function love.update(dt)

	mousex = love.mouse.getX()
	mousey = love.mouse.getY()
	shakeTimer = shakeTimer + dt

	if gamestate == "menu" then
		src3:play()
		menu_button_update(dt)
		menu_button_check()
		points_edge_test()
		pointsmenu_update(dt)
		loudness_sound_update()
	end

	if gamestate == "intro" then
		src3:stop()
		introplayer_update(dt)
		phase_in_update(dt)
	end

	if gamestate == "playing" then
		if not inFocus then
		src1:pause()
			return
		end
		src1:play()
		src3:stop()
		new_highscore_update(dt)
		player_damaged_phase_in(dt)
		explosion_sound_update()
		hud_phase_in_update1(dt)
		hud_phase_in_update2(dt)
		shake_update()
		explosion_update(dt)
		enemy_physics(dt)
		enemy_AI(dt)
		enemy_generate(dt)
		enemy_bullet_collide()
		updateopacity_enemy(dt)
		pointsgame_update(dt)
		player_enemy_collision()
		player_powerup_collision(dt)
		player_move(dt)
		player_window_check()
		bullet_move(dt)
		highscore_update()
		x_y_update1()
		x_y_update2(dt)
		timer_countdown(dt)
		end

	if gamestate == "options1" then
		src3:play()
		options1_button_check()
		points_edge_test()
		pointsmenu_update(dt)
	end

	if gamestate == "options2" then
		src3:play()
		slider_mouse_check()
		options2_button_check()
		slider_mouse_update()
		points_edge_test()
		pointsmenu_update(dt)
		percent_sound_update()
		loudness_sound_update()
	end

	if gamestate == "gameover" then
		src1:stop()
		src3:play()
		points_edge_test()
		pointsmenu_update(dt)
		gameover_button_check()
	end

	if gamestate == "credits" then
		credits_escape(dt)
		credits_phase_in_update(dt)
		back_to_main_menu_update(dt)
		points_edge_test()
		pointsmenu_update(dt)
		credits_update(dt)
		rgb_update()
		text_stop_update()
	end
end

-- Kutsutaan jatkuvasti ja se on vastuussa ruudulle piirtämisestä
function love.draw()

	if gamestate == "menu" then
		highscore_draw()
		menu_title_draw()
		menu_button_draw()
		pointsmenu_draw()
	end

	if gamestate == "intro" then
		intropointsgame_draw()
		introplayer_draw()
		phase_in_draw()
	end

	if gamestate == "playing" then
		if not inFocus then
		intropointsgame_draw()
		if gamestate == "intro" then
		introplayer_draw()
		end
		phase_in_draw()
		enemy_draw()
		pointsgame_draw()
		health_draw()
		player_draw()
		bullet_draw()
		score_draw()
		explosion_draw()
		powerup_draw()
		powerup_call()
		new_highscore_draw()
		pause_draw()
				return
		end
	pointsgame_draw()
	health_draw()
	score_draw()
	explosion_draw()
	collision_draw()
	collision_draw2()
	new_highscore_draw()
	powerup_draw()
	powerup_call()
	enemy_draw()
	player_draw()
	bullet_draw()
	end

	if gamestate == "options1" then
		options1_draw()
		options1_title_draw()
		pointsmenu_draw()
	end

	if gamestate == "options2" then
		options2_draw()
		options2_title_draw()
		options2_volume_draw()
		pointsmenu_draw()
	end

	if gamestate == "gameover" then
		pointsmenu_draw()
		gameover_title_draw()
		gameover_draw()
	end

	if gamestate == "credits" then
		pointsmenu_draw()
		credits_draw()
		credits_phase_in_draw()
	end
end

-- Kutsutaan kun näppäimistön näppäintä painetaan
function love.keypressed(key)

	player_shoot(key)
end

-- Kutsutaan jos ikkunaan kohdistetaan tai siitä kohdistetaan pois
function love.focus(f)

  inFocus = f
end

-- Kutsutaan kun näppäintä painetaan
function love.mousepressed()

	if gamestate == "menu" then
		menu_button_click()
	end

	if gamestate == "options1" then
		options1_button_click()
	end

	if gamestate == "options2" then
		options2_button_click()
	end

	if gamestate == "gameover" then
		gameover_button_click()
	end
end

-- Kutsutaan kun peli suljetaan
function love.quit()

	love.filesystem.write("percentvolume.txt", percentVolume)
	love.filesystem.write("highscore.txt", playerHighscore)
end