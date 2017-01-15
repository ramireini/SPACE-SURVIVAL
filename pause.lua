-- Tiedoston kuvaus: Pelin tauko tilaan liittyviä asioita



-- Moduuli, joka pitää sisällään ominaisuuksia
function pause_load()

	pausefont2 = love.graphics.newFont("Assets/Fonts/gasalt.black.ttf", 24)
	pausefont = love.graphics.newFont("Assets/Fonts/gasalt.black.ttf", 45)
end

-- Piirtää tekstin ruudulle
function pause_draw()

	love.graphics.setColor(255, 255, 255, 50)
	love.graphics.rectangle("fill", 0, 0, 1200, 800)

	love.graphics.setColor(59, 162, 247, 200)
	love.graphics.setFont(pausefont)
	love.graphics.print("PAUSED", 540, 340)
	love.graphics.setFont(pausefont2)
	love.graphics.print("Click the game window to resume", 450, 380)

	love.graphics.setColor(255, 255, 255, 255)
	love.graphics.setFont(pausefont)
	love.graphics.print("PAUSED", 542, 340)
	love.graphics.setFont(pausefont2)
	love.graphics.print("Click the game window to resume", 452, 380)
end