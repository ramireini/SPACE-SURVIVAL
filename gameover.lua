-- Tiedosto kuvaus: Pelitilaan "gameover" liittyvät asiat



gameover = {}

-- Liittyy painikkeiden luomiseen 
function gameover_button_spawn(x, y, text, id)

	table.insert(gameover, {x = x, y = y, text = text, id = id, mouseover = mouseover})
end

-- Pitää sisällään ominaisuuksia
function gameover_load()

	smallerfont = love.graphics.newFont("Assets/Fonts/Orbitron Light.ttf", 24)
	gameoverfont = love.graphics.newFont("Assets/Fonts/neef-for-font.regular.ttf", 45)

	gameover_button_spawn(410, 400, "Play Again", "playagain")
	gameover_button_spawn(670, 400, "Main Menu", "mainmenu")
end

-- Piirtää tekstiä ruudulle
function gameover_title_draw()

	love.graphics.setColor(7, 96, 170, 255)
	love.graphics.setFont(gametitle)
	love.graphics.print("GAME OVER", 395, 240)

	love.graphics.setColor(255, 255, 255, 255)
	love.graphics.print("GAME OVER", 400, 240)

	love.graphics.setColor(7, 96, 170, 255)
	love.graphics.setFont(optionsfont2)
	love.graphics.print("Your final score: "..playerScore, 480, 320)
end

-- Piirtää tekstiä ja muotoja. Muodot piirretään määrittäen pisteet monikulmioille.
function gameover_draw()

	for i,v in ipairs(gameover) do

		if v.mouseover == false then

		love.graphics.setColor(12, 21, 36, 255)
		love.graphics.polygon("fill", v.x - 55, v.y - 19, v.x + 190, v.y - 19, v.x + 190, v.y + 40, v.x - 55, v.y + 40)
		love.graphics.setColor(200, 200, 200, 255)
		love.graphics.polygon("line", v.x - 56, v.y - 18, v.x + 191, v.y - 18, v.x + 191, v.y + 41, v.x - 56, v.y + 41)

		love.graphics.setColor(255, 255, 255, 255)
		love.graphics.setFont(smallerfont)
		love.graphics.print(v.text, v.x, v.y)
		end



		if v.mouseover == true then

		love.graphics.setColor(25, 43, 73, 255)
		love.graphics.polygon("fill", v.x - 55, v.y - 19, v.x + 190, v.y - 19, v.x + 190, v.y + 40, v.x - 55, v.y + 40)
		love.graphics.setColor(255, 255, 255, 255)
		love.graphics.polygon("line", v.x - 56, v.y - 18, v.x + 191, v.y - 18, v.x + 191, v.y + 41, v.x - 56, v.y + 41)

		love.graphics.setColor(255, 255, 255, 255)
		love.graphics.setFont(smallerfont)
		love.graphics.print(v.text, v.x, v.y)
		end
	end
end

-- Päätetään mitä tapahtuu kun pelaaja painaa painiketta
function gameover_button_click()

	for i,v in ipairs(gameover) do

		if mousex > v.x - 63 and
			mousex < v.x + 184 and
			mousey > v.y - 20 and
			mousey < v.y + 42 then

			if v.id == "playagain" then
				introplayer_reset()
				player_reset()
				hud_reset()
				gamestate = "intro"
			end

			if v.id == "mainmenu" then
				gamestate = "menu"
			end
		end
	end
end

-- Tarkistaa onko hiiri napin päällä vai ei
function gameover_button_check()

	for i,v in ipairs(gameover) do
		if mousex > v.x - 63 and
			mousex < v.x + 184 and
			mousey > v.y - 20 and
			mousey < v.y + 42 then
				v.mouseover = true
			else
				v.mouseover = false
		end
	end
end