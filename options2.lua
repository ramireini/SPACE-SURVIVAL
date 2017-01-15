-- Tiedoston kuvaus: Asetusvalikkoon liittyviä asioita



options2 = {}
local sliderGrabMouseover = nil
local sliderMouseover = nil
local bar = {x = 500, y = 167, w = 200, h = 10}
local slider = {(percentVolume * 2) + 494, 164, (percentVolume * 2) + 500, 159, (percentVolume * 2) + 506, 164, (percentVolume * 2) + 506, 182, (percentVolume * 2) + 494, 182}

-- Generoi napin
function options2_button_spawn(x, y, text, id)

	table.insert(options2, {x = x, y = y, text = text, id = id, mouseover = mouseover})
end

-- Lataa napit tahdottuihin koordinaatteihin
function options2_load()

	options2_button_spawn(110, 120, "Graphics", "options1")
	options2_button_spawn(110, 185, "  Sound", "options2")
	options2_button_spawn(361, 732, "      OK", "mainmenu")
end

-- Piirtää ruudulle
function options2_title_draw()

	love.graphics.setFont(optionsfont)
	love.graphics.setColor(7, 96, 170, 255)
	love.graphics.print("OPTIONS", 534.7, 35)
	love.graphics.setColor(255, 255, 255, 255)
	love.graphics.print("OPTIONS", 538, 35)
end

-- Liittyy hiiren ja äänipalkin yhteyteen
function slider_mouse_check()

	if love.mouse.isDown(1) and
		 mousex <= slider[5] and mousex >= slider[1] and
			mousey <= slider[8] and mousey >= slider[4] then

			sliderGrabMouseover = true

		else

			if mousex <= slider[5] and mousex >= slider[1] and
				mousey <= slider[8] and mousey >= slider[4] then

			sliderMouseover = true
			sliderGrabMouseover = false

		else

			sliderMouseover = false
			sliderGrabMouseover = false
		end
	end
end


-- Päivittää äänen voimakkuuden
function loudness_sound_update()

	src1:setVolume(percentVolume / 100)
	src3:setVolume(percentVolume / 100)
	src4:setVolume(percentVolume / 100)
	src6:setVolume(percentVolume / 100)
	src7:setVolume(percentVolume / 100)
end


-- Pyöristää ääniluvun arvon
function percent_sound_update()

percentVolume = math.floor((slider[3] - bar.x) / 2)
end

-- Tarkistaa onko hiiri äänipalkin sisällä
function slider_mouse_update()

	if love.mouse.isDown(1) then

		if mousex >= 500 then
			if mousex <= 700 then
				if mousex <= slider[5] + 200 and mousex >= slider[1] - 200 and
			 		mousey <= slider[8] and mousey >= slider[4] then
				 		slider[1] = mousex - 6
				 		slider[3] = mousex
				 		slider[5] = mousex + 6
				 		slider[7] = mousex + 6
				 		slider[9] = mousex - 6
			 	end
			 end
		end
	end
end

-- Piirtää äänipalkin
function options2_volume_draw()

	love.graphics.setColor(255, 255, 255)
	love.graphics.setFont(optionsfont2)
	love.graphics.print("Volume", 320, 110)

	love.graphics.setColor(117, 206, 224)
	love.graphics.setFont(optionsfont3)
	love.graphics.print("Master Volume:", 320, 160)

	love.graphics.setColor(60, 150, 176)
	love.graphics.rectangle("fill", bar.x, bar.y, bar.w, bar.h)

	love.graphics.setColor(117, 206, 224)
	love.graphics.print(percentVolume.."%", 720, 160)

if sliderMouseover == false then

	love.graphics.setColor(8, 122, 208)
	love.graphics.polygon("fill", slider)
	end 

if sliderMouseover == true then

	love.graphics.setColor(0, 150, 247)
	love.graphics.polygon("fill", slider)
	end

if sliderGrabMouseover == true then
	love.graphics.setColor(181, 249, 255)
	love.graphics.polygon("fill", slider)
	end
end

-- Piirtää taustalla olevat elementit
function options2_draw()

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

	for i,v in ipairs(options2) do

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

-- Päättää mitä tapahtuu kun painetaan näppäintä
function options2_button_click()

	for i,v in ipairs(options2) do
		if mousex > v.x - 63 and
			mousex < v.x + 184 and
			mousey > v.y - 20 and
			mousey < v.y + 42 then

				if v.id == "options1" then
					gamestate = "options1"
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
function options2_button_check()

	for i,v in ipairs(options2) do
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