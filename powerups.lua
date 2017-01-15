-- Tiedoston kuvaus: Pitää sisällään kilpisuojuksiin liittyvät asiat



powerup = {}
spawnPowerup = false
local timerOptions = {15, 20, 25, 30}
local startCountdown = true
local x = nil
local y = nil
local u = 0
local powerupOpacity = 0
local collisionValue1 = 28
local collisionValue2 = 28

-- Moduuli, joka pitää sisällään ominaisuuksia
function powerup_load()

  src7 = love.audio.newSource("Assets/Sounds/PowerupObtain.mp3", "static")
  ShieldPowerup = love.graphics.newImage("Assets/Images/ShieldPowerup.png")
end

-- Generoi kilven
function powerup_spawn(x, y)

  table.insert(powerup, {x = x, y = y})
end

-- Piirtää kilven ruudulle
function powerup_draw()

    if spawnPowerup == true then
        for i,v in ipairs(powerup) do
            love.graphics.setColor(255, 255, 255, powerupOpacity)
            love.graphics.draw(ShieldPowerup, v.x, v.y)
        end
    end
end

-- Kun kilvelle on annettu lupa, se generoidaan
function powerup_call()

  if spawnPowerup == true then
    powerup_spawn(x, y)
  end
end

-- Voimme tarvittaessa tuoda esiin kilven "hitboxin"
function collision_draw2()

  if spawnPowerup == true then
      for i,v in ipairs(powerup) do
        love.graphics.setColor(0, 0, 0, 0)
        love.graphics.rectangle('fill', v.x + 5, v.y + 5, collisionValue2, collisionValue1)
      end
  end
end

-- Päättää mitä tapahtuu kun pelaaja ja kilpi törmäävät
function player_powerup_collision(dt)

  for i,v in ipairs(powerup) do

    if v.x + 5 + collisionValue2 > player.x and
       v.x + 5 < player.x + enemy.pic:getWidth() and
       v.y + 5 + collisionValue1 > player.y and
       v.y + 5 < player.y + enemy.pic:getHeight() then

       spawnPowerup = false
       powerupOpacity = 0
       startCountdown = true
       src7:play()
       for i=1, 40 do
        table.remove(powerup, i)
       end
       moveSet = 2
    end
  end

  if moveSet == 2 then
  u = u + dt
  end

  if u > 4 then
  moveSet = 1
  u = 0
  end
end

-- Päättää mihin koordinaatteihin kilpi generoidaan
function x_y_update2(dt)

  if spawnPowerup == false then
    x = love.math.random(58, 1142)
    y = love.math.random(58, 742)
  end


  for i,v in ipairs(powerup) do
  	if spawnPowerup == true then
  		if powerupOpacity < 255 then
  			powerupOpacity = powerupOpacity + 1 * dt
  		end
  	end
  end
end

-- Määrittää kuinka usein kilpi voidaan generoida
function timer_countdown(dt)

  if startCountdown == true then
      countdown = timerOptions[love.math.random(1, 4)]
      startCountdown = false
  end

  countdown = countdown - dt

  if countdown < 0 then
  	  countdown = 0
      spawnPowerup = true
  end
end