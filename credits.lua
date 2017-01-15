-- Tiedoston kuvaus: Lopputekstit ja niihin vaikuttavat asiat



local r = nil
local g = nil
local b = nil
local escapeTimer = 0
x = 430
y = 900
timer = 0
canCalculate = true
creditsOpacity = 255

-- Moduuli, joka pitää sisällään ominaisuuksia
function credits_load()

	creditstitle1 = love.graphics.newFont("Assets/Fonts/gasalt.black.ttf", 78)
	creditstitle2 = love.graphics.newFont("Assets/Fonts/gasalt.black.ttf", 48)
	creditstitle3 = love.graphics.newFont("Assets/Fonts/gasalt.black.ttf", 24)
end

-- On vastuussa lopputekstien piirtämisestä ruudulle
function credits_draw()

	love.graphics.setFont(creditstitle1)
	love.graphics.setColor(7, 96, 170, 255)
	love.graphics.print("C R E D I T S", x, y)

	love.graphics.setColor(255, 255, 255, 255)
	love.graphics.print("C R E D I T S", x + 3, y)


	love.graphics.setFont(creditstitle2)
	love.graphics.setColor(7, 96, 170, 255)
	love.graphics.print("Game Design:", x + 75, y + 400)

	love.graphics.setColor(255, 255, 255, 255)
	love.graphics.print("Game Design:", x + 77, y + 400)


	love.graphics.setFont(creditstitle3)
	love.graphics.print("Rami Reini", x + 20, y + 460)


	love.graphics.setFont(creditstitle2)
	love.graphics.setColor(7, 96, 170, 255)
	love.graphics.print("Music:", x + 75, y + 540)

	love.graphics.setColor(255, 255, 255, 255)
	love.graphics.print("Music:", x + 77, y + 540)


	love.graphics.setFont(creditstitle3)
	love.graphics.print("www.freesound.org", x + 20, y + 600)
	love.graphics.print("www.soundimage.org", x + 20, y + 620)


	love.graphics.setFont(creditstitle2)
	love.graphics.setColor(7, 96, 170, 255)
	love.graphics.print("Art:", x + 75, y + 700)

	love.graphics.setColor(255, 255, 255, 255)
	love.graphics.print("Art:", x + 77, y + 700)


	love.graphics.setFont(creditstitle3)
	love.graphics.print("Rami Reini", x + 20, y + 760)
	love.graphics.print("www.txvirus.deviantart.com", x + 20, y + 780)


	love.graphics.setFont(creditstitle2)
	love.graphics.setColor(7, 96, 170, 255)
	love.graphics.print("SPECIAL THANKS TO:", x + 75, y + 860)

	love.graphics.setColor(255, 255, 255, 255)
	love.graphics.print("SPECIAL THANKS TO:", x + 77, y + 860)


	love.graphics.setFont(creditstitle3)
	love.graphics.setColor(r, g, b, 255)
	love.graphics.print("Steven 'exezin' Young", x + 20, y + 920)
	love.graphics.print("Donald 'nisco' Smith", x + 20, y + 940)

	love.graphics.setColor(255, 255, 255, 255)
	love.graphics.print("Thank you for playing Space Survival! As my first game ever this was an exciting experience", x - 240, y + 1050)
	love.graphics.print("and I'm happy for everything I've learned while making this game!", x - 130, y + 1070)
end

-- Laskee jatkuvavasti eri arvot muuttujille
function rgb_update()

	r = love.math.random(150, 255)
	g = love.math.random(150, 255)
	b = love.math.random(150, 255)
end

-- Siirtää lopputekstejä ylöspäin
function credits_update(dt)
	
	if canCalculate == true then
		y = y - 80 * dt
	end
end

-- Piirtää alussa mustan ruudun
function credits_phase_in_draw()

	love.graphics.setColor(0, 0, 0, creditsOpacity)
	love.graphics.rectangle('fill', 0, 0, 1200, 800)
end

-- Vähentää alussa piirretyn mustan ruudun läpinäkyvyys arvoa
function credits_phase_in_update(dt)

	if creditsOpacity > 0 then
		creditsOpacity = creditsOpacity - 150 * dt
	end
end

-- Määrittää milloin tekstin liikkuminen loppuu
function text_stop_update()

	if y < -380 then
		canCalculate = false
		y = y
	end
end

-- Ajoittaa siirtymisen takaisin päävalikkoon
function back_to_main_menu_update(dt)

	if canCalculate == false then
		timer = timer + dt
	end

	if timer > 8 then
		gamestate = "menu"
	end
end

-- Asettaa tietyt arvot uudelleen haluttuihin arvoihin
function credits_reset()

	creditsOpacity = 255
	canCalculate = true
	x = 430
	y = 900
	timer = 0
end

-- Voimme paeta lopputeksteistä painamalla hiirtä
function credits_escape(dt)

	if escapeTimer < 1 then
		escapeTimer = escapeTimer + dt
	end

	if escapeTimer > 1 then
		if love.mouse.isDown(1) then
				escapeTimer = 0
			gamestate = "menu"
		end
	end
end