-- Tiedoston kuvaus: Ruudulla olevien tähtien logiikka ja piirtäminen



local points = {}
local max_stars1 = 200
local max_stars2 = 200
local max_stars3 = 120

-- Logiikka joka päättää tähtien sijainnin
function pointsgame_load()

   stars1 = {}

   for i=1, max_stars1 do
    local x = love.math.random(-50, love.graphics.getWidth() + 50)
    local y = love.math.random(-50, love.graphics.getWidth() + 50)
    stars1[i] = {x, y}
   end

   stars2 = {}

   for i=1, max_stars2 do
   	local x = love.math.random(-50, love.graphics.getWidth() + 50)
   	local y = love.math.random(-50, love.graphics.getWidth() + 50)
   	stars2[i] = {x, y}
   end

   stars3 = {}

   for i=1, max_stars3 do
   	local x = love.math.random(-50, love.graphics.getWidth() + 50)
   	local y = love.math.random(-50, love.graphics.getWidth() + 50)
   	stars3[i] = {x, y}
   end
end

-- Piirtää tähdet ruudulle
function pointsgame_draw()

	love.graphics.setColor(255, 255, 255, 40)
	love.graphics.points(stars1)

	love.graphics.setColor(255, 255, 255, 120)
	love.graphics.points(stars2)

	love.graphics.setColor(255, 255, 255, 255)
	love.graphics.points(stars3)
end

-- Liikuttaa tähtiä tietyllä nopeudella ja tiettyyn suuntaan kun pelaaja liikkuu
function pointsgame_update(dt)

	if love.keyboard.isDown("right") then
		if player.x + 64 < love.graphics.getWidth() then

		for i=1, max_stars1 do
		  stars1[i][1] = stars1[i][1] - 13 * dt
		end

		for i=1, max_stars2 do
		  stars2[i][1] = stars2[i][1] - 18 * dt
		end

		for i=1, max_stars3 do
		  stars3[i][1] = stars3[i][1] - 38 * dt
		end

		end
	end

	if love.keyboard.isDown("left") then
		if player.x > 0 then

		for i=1, max_stars1 do
		stars1[i][1] = stars1[i][1] + 13 * dt
		end

		for i=1, max_stars2 do
			stars2[i][1] = stars2[i][1] + 18 * dt
		end

		for i=1, max_stars3 do
			stars3[i][1] = stars3[i][1] + 38 * dt
		end

		end
	end

	if love.keyboard.isDown("up") then
		if player.y > 0 then

		for i=1, max_stars1 do
	  	stars1[i][2] = stars1[i][2] + 13 * dt
		end

		for i=1, max_stars2 do
			stars2[i][2] = stars2[i][2] + 18 * dt
		end

		for i=1, max_stars3 do
			stars3[i][2] = stars3[i][2] + 38 * dt
		end

		end
	end

	if love.keyboard.isDown("down") then
		if player.y + 64 < love.graphics.getHeight() then

		for i=1, max_stars1 do
			stars1[i][2] = stars1[i][2] - 13 * dt
		end

		for i=1, max_stars2 do
			stars2[i][2] = stars2[i][2] - 18 * dt
		end

		for i=1, max_stars3 do
			stars3[i][2] = stars3[i][2] - 38 * dt
  		end

	 	end
  	end
end