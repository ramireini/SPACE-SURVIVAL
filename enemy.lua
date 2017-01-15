-- Tiedoston kuvaus: Vihollisen generointiin, poistoon ja törmäys tarkistuksiin liittyviä asioita



enemy = {}

enemy.width = 32
enemy.height = 32
enemy.speed = 130
enemy.friction = 10
enemy.side = love.math.random(1, 8)
enemy.timerLim = love.math.random(1, 3)
enemy.amount = love.math.random(1, 6)
enemy.timer = 0
local calculateChance = true
local collisionValue1 = 172
local collisionValue2 = 172

-- Moduuli, joka pitää sisällään ominaisuuksia
function enemy_load()

	enemy.pic = love.graphics.newImage("Assets/Images/Enemy.png")
end

-- On vastuussa vihollisten generoimisen ruudulle tietyissä määrissä ja tiettyihin aikoihin
function enemy_generate(dt)

	enemy.timer = enemy.timer + dt
	if enemy.timer > enemy.timerLim then

		for i = 1, enemy.amount do
			if enemy.side == 1 then -- Vasen yläkulma
				enemy_spawn(-32, love.graphics.getHeight() / 2 - 216)
			end

			if enemy.side == 2 then -- Vasen alakulma
				enemy_spawn(-32, love.graphics.getHeight() / 2 + 216)
			end

			if enemy.side == 3 then -- Oikea yläkulma
				enemy_spawn(love.graphics.getWidth() + 32, love.graphics.getHeight() / 2 - 216)
			end

			if enemy.side == 4 then -- Oikea alakulma
				enemy_spawn(love.graphics.getWidth() + 32, love.graphics.getHeight() / 2 + 216)
			end

			if enemy.side == 5 then -- Ylä-oikea
				enemy_spawn(love.graphics.getWidth() / 2 + 416, -32)
			end

			if enemy.side == 6 then -- Ylä-vasen
				enemy_spawn(love.graphics.getWidth() / 2 - 416, -32)
			end

			if enemy.side == 7 then -- Ala-oikea
				enemy_spawn(love.graphics.getWidth() / 2 + 416, love.graphics.getHeight() + 32)
			end

			if enemy.side == 8 then -- Ala-vasen
				enemy_spawn(love.graphics.getWidth() / 2 - 416, love.graphics.getHeight() + 32)
			end

			enemy.side = love.math.random(1, 8)
		end
		enemy.timerLim = love.math.random(1, 3)
		enemy.amount = love.math.random(1, 6)
		enemy.timer = 0
	end
end

-- Generoi vihollisen
function enemy_spawn(x, y)

	table.insert(enemy, {x = x, y = y, xvel = 0, yvel = 0, dying = false, opacity = 255})
end

-- Piirtää vihollisen ruudulle
function enemy_draw()

	for i,v in ipairs(enemy) do
		love.graphics.setColor(255, 255, 255, v.opacity)
		love.graphics.draw(enemy.pic, v.x, v.y)
	end
end

-- Laskee vihollisen liikkumisen fysiikkaa
function enemy_physics(dt)

	for i,v in ipairs(enemy) do
		v.x = v.x + (v.xvel * dt)
		v.y = v.y + (v.yvel * dt)
		v.xvel = v.xvel * (1 - math.min(enemy.friction, 1))
		v.yvel = v.yvel * (1 - math.min(enemy.friction, 1))
	end
end

-- On vastuussa siitä kuinka vihollinen seuraa pelaajaa
function enemy_AI()

	for i,v in ipairs(enemy) do
		if player.x + player.width / 2 < v.x + enemy.pic:getWidth() / 2 then
			if v.xvel > - enemy.speed then
				v.xvel = v.xvel - enemy.speed
			end
		end

		if player.x + player.width / 2 > v.x + enemy.pic:getWidth() / 2 then
			if v.xvel < enemy.speed then
				v.xvel = v.xvel + enemy.speed
			end
		end

		if player.y + player.height / 2 < v.y + enemy.pic:getHeight() / 2 then
			if v.yvel > - enemy.speed then
				v.yvel = v.yvel - enemy.speed
			end
		end

		if player.y + player.height / 2 > v.y + enemy.pic:getHeight() / 2 then
			if v.yvel < enemy.speed then
				v.yvel = v.yvel + enemy.speed
			end
		end
	end
end

-- Tarkistaa onko pelaajan laseri luoti osunut viholliseen
function enemy_bullet_collide()

	for i,v in ipairs(enemy) do
		for ia,va in ipairs(bullet) do
			if va.x + va.width > v.x and
				 va.x < v.x + enemy.pic:getWidth() and
				 va.y + va.height > v.y and
				 va.y < v.y + enemy.pic:getHeight() then

			v.dying = true
			table.remove(bullet, ia)
			playerScore = playerScore + 1
			shakeTimer = 0
			end
		end
	end
end

-- Pienentää vihollisen läpinäkyvyyttä kun siihen on osuttu laseri luodilla
function updateopacity_enemy(dt)

	for i, v in ipairs(enemy) do
		if v.dying == true then
			v.opacity = v.opacity - 1700 * dt
		end

		if v.opacity < 1 then
			table.remove(enemy, i)
		end
	end
end