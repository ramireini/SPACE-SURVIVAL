-- Tiedoston kuvaus: Pelitilaan "intro" liittyvät asiat



local max_stars1 = 200
local max_stars2 = 200
local max_stars3 = 120
local introSpeed = 200
introOpacity = 255
introX = love.graphics.getWidth() / 2 - 32
introY = love.graphics.getHeight() + 32

-- Asettaa tietyt muuttujat haluttuihin arvoihin
function introplayer_reset()

 opacity = 255
 introX = love.graphics.getWidth() / 2 - 32
 introY = love.graphics.getHeight() + 32
end

-- Tekee taulukoita ja laskee tähtien koordinaatit
function intropointsgame_load()

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

-- Piirtää tähdet ruudulle tietyillä läpinäkyvyys arvoilla
function intropointsgame_draw()

	love.graphics.setColor(255, 255, 255, 40)
	love.graphics.points(stars1)

	love.graphics.setColor(255, 255, 255, 120)
	love.graphics.points(stars2)

	love.graphics.setColor(255, 255, 255, 255)
	love.graphics.points(stars3)
end

-- Piirtää pelaajan ruudulle
function introplayer_draw()

  love.graphics.setColor(255, 255, 255, 255)
  love.graphics.draw(GoingUp, introX, introY)
end

-- Liikuttaa pelaajan kuvaketta
function introplayer_update(dt)

  introY = introY - introSpeed * dt

  if introY <= love.graphics.getHeight() / 2 - 32 then
    gamestate = "playing"
  end
end

-- Piirtää mustan suorakulmion ruudulle
function phase_in_draw()

  love.graphics.setColor(0, 0, 0, introOpacity)
  love.graphics.rectangle('fill', 0, 0, 1200, 800)
end

-- Laskee mustan suorakulmion läpinäkyvyys arvoa
function phase_in_update(dt)

  if introOpacity > 0 then
    introOpacity = introOpacity - 150 * dt
  end
end