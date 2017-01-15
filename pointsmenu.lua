-- Tiedoston kuvaus: Ruudulla olevien tähtien logiikka ja piirtäminen



local points = {}
local max_stars4 = 180
local max_stars5 = 180
local max_stars6 = 100

-- Logiikka joka päättää tähtien sijainnin
function pointsmenu_load()

     stars4 = {}

    for i=1, max_stars4 do
      local x = love.math.random(0, love.graphics.getWidth())
      local y = love.math.random(0, love.graphics.getWidth())
      stars4[i] = {x, y}
    end

     stars5 = {}

    for i=1, max_stars5 do
     	local x = love.math.random(0, love.graphics.getWidth())
     	local y = love.math.random(0, love.graphics.getWidth())
     	stars5[i] = {x, y}
    end

     stars6 = {}

    for i=1, max_stars6 do
     	local x = love.math.random(0, love.graphics.getWidth())
     	local y = love.math.random(0, love.graphics.getWidth())
     	stars6[i] = {x, y}
    end
end

-- Piirtää tähdet ruudulle
function pointsmenu_draw()

  love.graphics.setColor(255, 255, 255, 40)
  love.graphics.points(stars4)

  love.graphics.setColor(255, 255, 255, 120)
  love.graphics.points(stars5)

  love.graphics.setColor(255, 255, 255, 255)
  love.graphics.points(stars6)
end

-- Liikuttaa tiettyjä tähtiä tietyllä nopeudella
function pointsmenu_update(dt)

    for i=1, max_stars4 do
      stars4[i][1] = stars4[i][1] + 10 * dt
    end

    for i=1, max_stars5 do
      stars5[i][1] = stars5[i][1] + 13 * dt
    end

    for i=1, max_stars6 do
      stars6[i][1] = stars6[i][1] + 23 * dt
    end
end

-- Siirtää tähtiä kun ne lähtevät ruudulta pois
function points_edge_test()

  for i=1, max_stars4 do
    if stars4[i][1] > 1200 then
      stars4[i][1] = 0
    end
  end

  for i=1, max_stars5 do
    if stars5[i][1] > 1200 then
      stars5[i][1] = 0
    end
  end

  for i=1, max_stars6 do
    if stars6[i][1] > 1200 then
      stars6[i][1] = 0
    end
  end
end