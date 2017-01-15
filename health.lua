-- Tiedoston kuvaus: Pelaajan elämäpisteisiin liittyvät asiat



healthOpacity = 0
playerHealth = 3

-- Moduuli, joka pitää sisällään ominaisuuksia
function health_load()

	scorefont = love.graphics.newFont("Assets/Fonts/gasalt.black.ttf", 38)
	src4 = love.audio.newSource ("Assets/Sounds/HealthDown.mp3", "static")
	Health1 = love.graphics.newImage("Assets/Images/Health1.png")
	Health2 = love.graphics.newImage("Assets/Images/Health2.png")
	Health3 = love.graphics.newImage("Assets/Images/Health3.png")
end

-- Piirtää elämäpisteiden kuvakkeet ruudulle
function health_draw()

	love.graphics.setColor(255, 255, 255, healthOpacity)

	if playerHealth == 1 then
	love.graphics.draw(Health1, 1020, 35)
	end

	if playerHealth == 2 then
	love.graphics.draw(Health2, 1020, 35)
	love.graphics.draw(Health2, 1060, 35)
	end

	if playerHealth == 3 then
	love.graphics.draw(Health3, 1020, 35)
	love.graphics.draw(Health3, 1060, 35)
	love.graphics.draw(Health3, 1100, 35)
	end

	love.graphics.setColor(7, 96, 170, healthOpacity)
	love.graphics.setFont(scorefont)
	love.graphics.print("LIVES:", 900, 30)
end

-- Tuo elämäpisteet ruudulle pelin alussa
function hud_phase_in_update2(dt)

	if healthOpacity < 255 then
		healthOpacity = healthOpacity + 250 * dt
	end
end