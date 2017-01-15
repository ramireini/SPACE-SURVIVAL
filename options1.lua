-- Tiedoston kuvaus: Asetusvalikkoon liittyviä asioita



options = {}

-- Generoi napin
function options1_button_spawn(x, y, text, id)

	table.insert(options, {x = x, y = y, text = text, id = id, mouseover = mouseover})
end

-- Moduuli, joka sisältää ominaisuuksia
function options1_load()

	src6 = love.audio.newSource("Assets/Sounds/OptionsClick.mp3", "static")
	optionsfont = love.graphics.newFont("Assets/Fonts/gasalt.black.ttf", 48)
	optionsfont2 = love.graphics.newFont("Assets/Fonts/gasalt.black.ttf", 38)
	optionsfont3 = love.graphics.newFont("Assets/Fonts/gasalt.black.ttf", 20)

	options1_button_spawn(110, 120, "Graphics", "options1")
	options1_button_spawn(110, 185, "  Sound", "options2")
	options1_button_spawn(361, 732, "      OK", "mainmenu")
end

-- Piirtää ruudulle
function options1_title_draw()

	love.graphics.setFont(optionsfont)
	love.graphics.setColor(7, 96, 170, 255)
	love.graphics.print("OPTIONS", 534.7, 35)
	love.graphics.setColor(255, 255, 255, 255)
	love.graphics.print("OPTIONS", 538, 35)
end

-- Piirtää ruudun taustalla olevat valikko elementit
function options1_draw()

	love.graphics.setColor(14, 56, 81, 255)
	love.graphics.polygon("fill", 27, 33, 33, 27, 1172, 27, 1178, 34, 1178, 772, 1172, 778, 33, 778, 27, 772)

	love.graphics.setColor(12, 21, 36, 255)
	love.graphics.polygon("fill", 30, 35, 35, 30, 1170, 30, 1175, 35, 1175, 770, 1170, 775, 35, 775, 35, 775, 30, 770)

	love.graphics.setColor(6, 11, 17, 255)
	love.graphics.polygon("fill", 40, 100, 45, 95, 1160, 95, 1165, 100, 1165, 705, 1160, 710, 45, 710, 40, 705)

	love.graphics.setColor(22, 37, 56, 255)
	love.graphics.polygon("line", 40, 100, 45, 95, 1160, 95, 1165, 100, 1165, 705, 1160, 710, 45, 710, 40, 705)

	love.graphics.setColor(30, 49, 63, 255)
	love.graphics.polygon("fill", 300, 101, 1159, 101, 1159, 704, 300, 704)

	for i,v in ipairs(options) do

		if v.mouseover == false then

		love.graphics.setColor(12, 21, 36, 255)
		love.graphics.polygon("fill", v.x - 60, v.y - 19, v.x + 180, v.y - 19, v.x + 180, v.y + 40, v.x - 60, v.y + 40)
		love.graphics.setColor(14, 56, 81, 255)
		love.graphics.polygon("line", v.x - 61, v.y - 18, v.x + 181, v.y - 18, v.x + 181, v.y + 41, v.x - 61, v.y + 41)

		love.graphics.setColor(255, 255, 255, 255)
		love.graphics.setFont(smallerfont)
		love.graphics.print(v.text, v.x, v.y)
		end



		if v.mouseover == true then

		love.graphics.setColor(25, 43, 73)
		love.graphics.polygon("fill", v.x - 60, v.y - 19, v.x + 180, v.y - 19, v.x + 180, v.y + 40, v.x - 60, v.y + 40)
		love.graphics.setColor(22, 87, 123)
		love.graphics.polygon("line", v.x - 61, v.y - 18, v.x + 181, v.y - 18, v.x + 181, v.y + 41, v.x - 61, v.y + 41)

		love.graphics.setColor(255, 255, 255, 255)
		love.graphics.setFont(smallerfont)
		love.graphics.print(v.text, v.x, v.y)
		end
	end 
end

-- Päättää mitä tapahtuu kun pelaaja painaa nappia
function options1_button_click(x, y)

	for i,v in ipairs(options) do
		if mousex > v.x - 63 and
			mousex < v.x + 184 and
			mousey > v.y - 20 and
			mousey < v.y + 42 then

			if v.id == "options2" then
					gamestate = "options2"
					src6:play()
			end

			if v.id == "mainmenu" then
					gamestate = "menu"
					src6:play()
			end
		end
	end
end

-- Tarkistaa onko pelaajan hiiri napin päällä
function options1_button_check()

	for i,v in ipairs(options) do
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