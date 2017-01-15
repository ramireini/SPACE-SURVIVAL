-- Tiedoston kuvaus: Pelitilaan "menu "ja tiedostojärjestelmään liittyviä asioita



button = {}

percentVolume = love.filesystem.read("percentvolume.txt")

-- Generoi painikkeen
function menu_button_spawn(x, y, text, id)

	table.insert(button, {x = x, y = y, text = text, id = id, mouseover = false, opacityHolder = opacityHolder})
end

-- Pitää sisällään ominaisuuksia
function menu_load()

	src3 = love.audio.newSource ("Assets/Sounds/Menu.mp3", "stream")
	src1 = love.audio.newSource ("Assets/Sounds/Game.mp3", "stream")
	controlsfont = love.graphics.newFont("Assets/Fonts/Baumans-Regular.ttf", 32)
	gametitle = love.graphics.newFont("Assets/Fonts/gasalt.black.ttf", 92)
	font = love.graphics.newFont("Assets/Fonts/Orbitron Light.ttf", 28)
	mainmenuheader = love.graphics.newFont("Assets/Fonts/DentonBETA2.ttf", 42)
	highlighter = love.graphics.newImage("Assets/Images/highlighter.png")

	menu_button_spawn(100, 460, "PLAY", "start")
	menu_button_spawn(100, 530, "OPTIONS", "options1")
	menu_button_spawn(100, 600, "CREDITS", "credits")
	menu_button_spawn(100, 670, "EXIT GAME", "quit")
end

-- Piirtää suurimman osan päävalikon teksteistä ruudulle
function menu_title_draw()

	love.graphics.setFont(gametitle)
	love.graphics.setColor(7, 96, 170, 255)
	love.graphics.print("S P A C E   S U R V I V A L", 135, 50)

	love.graphics.setColor(255, 255, 255, 255)
	love.graphics.print("S P A C E   S U R V I V A L", 140, 50)

	love.graphics.draw(highlighter, -370, -420)

	love.graphics.setFont(mainmenuheader)
	love.graphics.setColor(7, 96, 170, 255)
	love.graphics.print("Main Menu", 52, 355, 0, 1.2, 1.2)

	love.graphics.setColor(255, 255, 255, 255)
	love.graphics.print("Main Menu", 55, 355, 0, 1.2, 1.2)

	love.graphics.setColor(7, 96, 170, 255)
	love.graphics.setFont(mainmenuheader)
	love.graphics.print("Controls:", 610, 460)
	love.graphics.print("W, A, S, D to shoot,", 610, 500)
	love.graphics.print("Arrow keys to move.", 610, 540)

	love.graphics.setColor(255, 255, 255, 255)
	love.graphics.print("Controls:", 613, 460)
	love.graphics.print("W, A, S, D to shoot,", 613, 500)
	love.graphics.print("Arrow keys to move.", 613, 540)
end

-- Piirtää painikkeet ruudulle
function menu_button_draw()

	for i,v in ipairs(button) do

		if v.mouseover == false then

		love.graphics.setColor(32, 32, 32, 200)
		love.graphics.polygon("fill", 55, v.y - 10, 469, v.y - 10, 495, v.y + font:getHeight(v.text) / 2 + 3, 495, v.y + font:getHeight(v.text) / 2 + 20, 80, v.y + font:getHeight(v.text) / 2 + 20, 55, v.y + font:getHeight(v.text) / 2 - 6)
		love.graphics.setColor(255, 255, 255, 255)
		love.graphics.setFont(font)
		love.graphics.print(v.text, v.x, v.y)
		end



		if v.mouseover == true then

		love.graphics.setColor(7, 96, 143, v.opacityHolder)
		love.graphics.polygon("fill", 66, v.y - 19, 492, v.y - 19, 524, v.y + font:getHeight(v.text) / 2, 524, v.y + font:getHeight(v.text) / 2 + 29, 97, v.y + font:getHeight(v.text) / 2 + 29, 66, v.y + font:getHeight(v.text) / 2 - 3)

		love.graphics.setColor(32, 32, 32, v.opacityHolder)
		love.graphics.polygon("fill", 72, v.y - 13, 489, v.y - 13, 518, v.y + font:getHeight(v.text) / 2 + 3, 518, v.y + font:getHeight(v.text) / 2 + 23, 100, v.y + font:getHeight(v.text) / 2 + 23, 72, v.y + font:getHeight(v.text) / 2 - 6)

		love.graphics.setColor(7, 96, 143, v.opacityHolder)
		love.graphics.polygon("fill", 75, v.y - 10, 489, v.y - 10, 515, v.y + font:getHeight(v.text) / 2 + 3, 515, v.y + font:getHeight(v.text) / 2 + 20, 100, v.y + font:getHeight(v.text) / 2 + 20, 75, v.y + font:getHeight(v.text) / 2 - 6)

		love.graphics.setColor(255, 255, 255, 255)
		love.graphics.setFont(font)
		love.graphics.print(v.text, v.x + 20, v.y)
		end
	end
end

-- Vaikuttaa painikkeiden muutosvaiheisiin
function menu_button_update(dt)

	for i,v in ipairs(button) do

		if v.mouseover == false then
			v.opacityHolder = 0
		end

		if v.mouseover == true then
			if v.opacityHolder < 254 then
				v.opacityHolder = v.opacityHolder + 1050 * dt
			end
		end
	end
end

-- Vaikuttaa siihen mitä tapahtuu kun pelaaja painaa painiketta
function menu_button_click()

	for i,v in ipairs(button) do
		if mousex > v.x - 44 and
		mousex < v.x + 396 and
		mousey > v.y - 11 and
		mousey < v.y + 35 then

			if v.id == "quit" then
				love.event.push("quit")
			end

			if v.id == "options1" then
				src6:play()
				gamestate = "options1"
			end

			if v.id == "start" then
				src6:play()
				introplayer_reset()
				player_reset()
				hud_reset()
				gamestate = "intro"
			end

			if v.id == "credits" then
				src6:play()
				credits_reset()
				gamestate = "credits"
			end
 		end
	end
end

-- Tarkastaa onko pelaajan hiiri painikkeen päällä vai ei
function menu_button_check()

	for i,v in ipairs(button) do
		if mousex > v.x - 44 and
			mousex < v.x + 396 and
			mousey > v.y - 11 and
			mousey < v.y + 35 then
				v.mouseover = true
			else
				v.mouseover = false
		end
	end
end