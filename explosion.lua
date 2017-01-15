-- Tiedosto kuvaus: Vihollisen räjähdykseen liittyviä asioita



local anim8 = require "anim8"
local image, animation

-- Moduuli, joka pitää sisällään ominaisuuksia
function explosion_load()

  src5 = {}
  src5[1] = love.audio.newSource("Assets/Sounds/Explosion.mp3", "static")
  image = love.graphics.newImage("Assets/Images/explosion.png")
  local grid = anim8.newGrid(32, 32, image:getWidth(), image:getHeight())
  animation = anim8.newAnimation(grid('1-7', 1), 0.1)
end

-- Päivittää räjäytystä
function explosion_update(dt)

  animation:update(dt)
end

-- Piirtää räjäytyksen ruudulle
function explosion_draw()

  love.graphics.setColor(255, 255, 255)

  for i, v in ipairs(enemy) do
    if v.dying == true then
        animation:draw(image, v.x, v.y)
    end
  end
end

-- Soittaa räjähdysäänen
function explosion_sound_update()

for i, v in ipairs(enemy) do
  if v.dying == true then

    local full = true
      for i=1, #src5 do
        if not src5[i]:isPlaying() then
          full = false
          src5[#src5]:setVolume(percentVolume / 100)
          src5[i]:setPitch(1.05-love.math.random()*.2)
          src5[i]:play()
        break
      end
    end
      if full then
        src5[#src5+1] = src5[1]:clone()
        src5[#src5]:setVolume(percentVolume / 100)
        src5[#src5]:setPitch(1.05-love.math.random()*.2)
        src5[#src5]:play()
      end
    end
  end
end