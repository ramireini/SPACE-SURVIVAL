-- Tiedoston kuvaus: Pelaajaan liittyvät asiat



player = {}
player.x = love.graphics.getWidth() / 2 - 32
player.y = love.graphics.getHeight() / 2 - 32
player.yvel = 0
player.xvel = 0
player.speed = 200
player.width = 64
player.height = 64
moveSet = 1
local playerDamaged = false
local collisionValue1 = 32
local collisionValue2 = 32
local playerOpacity = 255
local state = 0
local k = 0

-- Moduuli, joka pitää sisällään ominaisuuksia
function player_load()

	player.pic = love.graphics.newImage("Assets/Images/Player.png")
	GoingRight = love.graphics.newImage("Assets/Images/GoingRight.png")
	GoingLeft = love.graphics.newImage("Assets/Images/GoingLeft.png")
	GoingUp = love.graphics.newImage("Assets/Images/GoingUp.png")
	GoingDown = love.graphics.newImage("Assets/Images/GoingDown.png")
	GoingRightDown = love.graphics.newImage("Assets/Images/GoingRightDown.png")
	GoingRightUp = love.graphics.newImage("Assets/Images/GoingRightUp.png")
	GoingLeftDown = love.graphics.newImage("Assets/Images/GoingLeftDown.png")
	GoingLeftUp = love.graphics.newImage("Assets/Images/GoingLeftUp.png")

	player.pic2 = love.graphics.newImage("Assets/Images/PlayerShield.png")
	GoingRight2 = love.graphics.newImage("Assets/Images/GoingRightShield.png")
	GoingLeft2 = love.graphics.newImage("Assets/Images/GoingLeftShield.png")
	GoingUp2 = love.graphics.newImage("Assets/Images/GoingUpShield.png")
	GoingDown2 = love.graphics.newImage("Assets/Images/GoingDownShield.png")
	GoingRightDown2 = love.graphics.newImage("Assets/Images/GoingRightDownShield.png")
	GoingRightUp2 = love.graphics.newImage("Assets/Images/GoingRightUpShield.png")
	GoingLeftDown2 = love.graphics.newImage("Assets/Images/GoingLeftDownShield.png")
	GoingLeftUp2 = love.graphics.newImage("Assets/Images/GoingLeftUpShield.png")
end

-- Asettaa tietyt muuttujat tiettyihin arvoihin
function player_reset()

moveSet = 1
enemyDelete = 0
bulletDelete = 0
playerDamaged = false

for i,v in ipairs(enemy) do
	for enemyDelete = 0, 40 do
	table.remove(enemy, i)
end
end

for i,v in ipairs(bullet) do
	for bulletDelete = 0, 20 do
	table.remove(bullet, i)
end
end
	playerScore = 0
	playerHealth = 3
	player.x = love.graphics.getWidth() / 2 - 32
	player.y = love.graphics.getHeight() / 2 - 32
end

-- Päättää mikä kuva pelaajasta piirretään logiikan perusteella
function player_draw()

	love.graphics.setColor(255, 255, 255, playerOpacity)
	if moveSet == 1 then
		if playerDirection == 0 then
			love.graphics.draw(player.pic, player.x, player.y)
		end

		if playerDirection == 1 then
			love.graphics.draw(GoingRight, player.x, player.y)
		end

		if playerDirection == 2 then
			love.graphics.draw(GoingLeft, player.x, player.y)
		end

		if playerDirection == 3 then
			love.graphics.draw(GoingUp, player.x, player.y)
		end

		if playerDirection == 4 then
			love.graphics.draw(GoingDown, player.x, player.y)
		end

		if playerDirection == 5 then
			love.graphics.draw(GoingRightUp, player.x, player.y)
		end

		if playerDirection == 6 then
			love.graphics.draw(GoingLeftUp, player.x, player.y)
		end

		if playerDirection == 7 then
			love.graphics.draw(GoingLeftDown, player.x, player.y)
		end

		if playerDirection == 8 then
			love.graphics.draw(GoingRightDown, player.x, player.y)
		end
	end

	if moveSet == 2 then
		if playerDirection == 0 then
			love.graphics.draw(player.pic2, player.x, player.y)
		end

		if playerDirection == 1 then
			love.graphics.draw(GoingRight2, player.x, player.y)
		end

		if playerDirection == 2 then
			love.graphics.draw(GoingLeft2, player.x, player.y)
		end

		if playerDirection == 3 then
			love.graphics.draw(GoingUp2, player.x, player.y)
		end

		if playerDirection == 4 then
			love.graphics.draw(GoingDown2, player.x, player.y)
		end

		if playerDirection == 5 then
			love.graphics.draw(GoingRightUp2, player.x, player.y)
		end

		if playerDirection == 6 then
			love.graphics.draw(GoingLeftUp2, player.x, player.y)
		end

		if playerDirection == 7 then
			love.graphics.draw(GoingLeftDown2, player.x, player.y)
		end

		if playerDirection == 8 then
			love.graphics.draw(GoingRightDown2, player.x, player.y)
		end
	end
end

-- Päättää mihin pelaajan luoti generoituu ja mihin suuntaan se lähtee
function player_shoot(key)

	if key == "w" then
		bullet_spawn(player.x + player.width / 2 - bullet.width / 2, player.y - bullet.height, "up")
	end

	if key == "s" then
		bullet_spawn(player.x + player.width / 2 - bullet.width / 2, player.y + player.height, "down")
	end

	if key == "a" then
		bullet_spawn(player.x - bullet.width, player.y + player.height / 2 - bullet.height / 2, "left")
	end

	if key == "d" then
		bullet_spawn(player.x + player.width, player.y + player.height / 2 - bullet.height / 2, "right")
	end
end

-- Yhdistää pelaajan liikkumislogiikan oikea kuvan kanssa ja sisältää myös pelaajan vauhti logiikan
function player_move(dt)

  if not love.keyboard.isDown("right") and
  	 not love.keyboard.isDown("left") and
  	 not love.keyboard.isDown("up") and
  	 not love.keyboard.isDown("down") then

  	playerDirection = 0
  end

  if love.keyboard.isDown("right") then

  		playerDirection = 1
    	player.xvel = player.xvel + player.speed
  end

  if love.keyboard.isDown("left") then

  		playerDirection = 2
    	player.xvel = player.xvel - player.speed
  end

  if love.keyboard.isDown("up") then

  		playerDirection = 3
    	player.yvel = player.yvel - player.speed
  end

  if love.keyboard.isDown("down") then

  		playerDirection = 4
   		player.yvel = player.yvel + player.speed
  end

  if love.keyboard.isDown("up") and
  	 love.keyboard.isDown("right") then

  	 playerDirection = 5
  end

  if love.keyboard.isDown("up") and
  	 love.keyboard.isDown("left") then

  	 playerDirection = 6
  end

  if love.keyboard.isDown("down") and
  	 love.keyboard.isDown("left") then

  	 playerDirection = 7
  end

  if love.keyboard.isDown("down") and
  	 love.keyboard.isDown("right") then

  	 playerDirection = 8
  end

	if love.keyboard.isDown("up") and
		 love.keyboard.isDown("down") then

			playerDirection = 0
	end

	if love.keyboard.isDown("left") and
		 love.keyboard.isDown("right") then

			playerDirection = 0
	end

	if love.keyboard.isDown("left") and
		 love.keyboard.isDown("right") and
		 love.keyboard.isDown("up") then

			playerDirection = 3
	end

	if love.keyboard.isDown("left") and
		 love.keyboard.isDown("right") and
		 love.keyboard.isDown("down") then

			playerDirection = 4
	end

	if love.keyboard.isDown("up") and
		 love.keyboard.isDown("down") and
		 love.keyboard.isDown("left") then

			playerDirection = 2
	end

	if love.keyboard.isDown("up") and
		 love.keyboard.isDown("down") and
		 love.keyboard.isDown("right") then

			playerDirection = 1
	end


  player.x = player.x + player.xvel * dt
  player.y = player.y + player.yvel * dt

  if player.xvel > 0 then
    	player.xvel = player.xvel - 250 * dt

  elseif player.xvel < 0 then
    	player.xvel = player.xvel + 250 * dt
  end

  if player.yvel > 0 then
    	player.yvel = player.yvel - 250 * dt

  elseif player.yvel < 0 then
    	player.yvel = player.yvel + 250 * dt
  end

  if player.xvel > 100 then
    	player.xvel = 100

  elseif player.xvel < -100 then
    	player.xvel = -100
  end

  if player.yvel > 100 then
    	player.yvel = 100

  elseif player.yvel < -100 then
   		player.yvel = -100
  end
end

-- Voimme halutessamme tuoda esille pelaajan 'hitboxin'
function collision_draw()

	love.graphics.setColor(0, 0, 0, 0)
	love.graphics.rectangle('fill', player.x + 16, player.y + 16, collisionValue2, collisionValue1)
end

-- Joka määrittää mitä tapahtuu kun pelaaja ja vihollinen törmäävät
function player_enemy_collision()

for i,v in ipairs(enemy) do

	if playerDamaged == false then

	if player.x + 16 + collisionValue2 > v.x and
		 player.x + 16 < v.x + enemy.pic:getWidth() and
		 player.y + 16 + collisionValue1 > v.y and
		 player.y < v.y + enemy.pic:getHeight() then

		 if moveSet == 1 then
		    src4:play()
		    v.dying = true
		    playerHealth = playerHealth - 1
		    playerDamaged = true
		 end

		 if playerHealth == 0 then
			gamestate = "gameover"
	 			end
	 		end
 		end
	end
end

-- Pelaajan reaktio vahingon ottamiseen
function player_damaged_phase_in(dt)

if playerDamaged == true then

		if state == 0 then

			if playerOpacity > 0 then
			   playerOpacity = playerOpacity - 1000 * dt
			end

			if playerOpacity < 1 then
			   state = 1
			end
		end


		if state == 1 then

			if playerOpacity < 255 then
			   playerOpacity = playerOpacity + 1000 * dt
			end
			
			if playerOpacity > 254 then
			   state = 0
			end
		end
		k = k + 50 * dt

		if k > 50 then
			playerDamaged = false
			playerOpacity = 255
			k = 0
		end
	end
end

-- Estää pelaajaa lähtemästä ruudulta
function player_window_check()

	if player.x < 0 then
		player.x = 0
	end

	if player.x + 64 > love.graphics.getWidth() then
		player.x = love.graphics.getWidth() - 64
	end 

	if player.y < 0 then
		player.y = 0
	end 

	if player.y + 64 > love.graphics.getHeight() then
		player.y = love.graphics.getHeight() - 64
	end
end