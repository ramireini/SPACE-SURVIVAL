-- Tiedoston kuvaus: pelaajan pisteisiin liittyvät asiat



local shake = 0
local scoreOpacity = 0
local lowerOpacity = false
local x = nil
local y = nil
highScoreOpacity = 255
playerScore = 0
playerHighscore = love.filesystem.read("highscore.txt")

-- Saa pisteiden tekstin liikkumaan kun pelaaja saa pisteitä
function shake_update()

	if shakeTimer < 0.5 then
		shake = love.math.random(- 10, 10)
	end
end

-- Laskee satunnaisesti uuden ennätyspiste tekstin koordinaatit
function x_y_update1()

	if lowerOpacity == false then
		x = love.math.random(300, 900)
		y = love.math.random(300, 500)
	end
end

-- Piirtää pisteet ruudulle
function score_draw()

	love.graphics.setColor(7, 96, 170, scoreOpacity)
	love.graphics.setFont(scorefont)
	love.graphics.print("SCORE: "..playerScore, 60 + shake, 30 + shake)
end

-- Saa pisteet ilmestymään ruudulle
function hud_phase_in_update1(dt)

	if scoreOpacity < 255 then
		scoreOpacity = scoreOpacity + 250 * dt
  	end
end

-- Asettaa tietyt muuttajat tiettyihin arvoihin
function hud_reset()

	introOpacity = 255
	healthOpacity = 0
	scoreOpacity = 0
end

-- Piirtää uuden ennätyspiste tekstin ruudulle päävalikossa
function highscore_draw()

	love.graphics.setColor(255, 255, 255, 255)
	love.graphics.print("Current highscore: "..playerHighscore, 440, 170)
end

-- Päivittää ennätyspistemäärän
function highscore_update()

	if gamestate == "gameover" then

		if playerScore > tonumber(playerHighscore) then
			playerHighscore = playerScore
		end
		highScoreOpacity = 255
		lowerOpacity = false
	end

end

-- Piirtää ruudulle kun pelaaja saa uuden ennätyksen pisteissä
function new_highscore_draw()

	if playerScore > tonumber(playerHighscore) then
		lowerOpacity = true
		love.graphics.setColor(255, 255, 255, highScoreOpacity)
		love.graphics.print("New Highscore!", x, y)
	end
end

-- Poistaa uuden ennätyspistemäärä tekstin ruudulta
function new_highscore_update(dt)

	if lowerOpacity == true then
		if highScoreOpacity > 0 then
			highScoreOpacity = highScoreOpacity - 125 * dt
		end
	end
end