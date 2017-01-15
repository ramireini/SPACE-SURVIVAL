-- Tiedoston kuvaus: Pelaajan luodin liikkuminen, piirtäminen ja generoiminen



bullet = {}
bullet.width = 5
bullet.height = 5
bullet.speed = 450

-- Moduuli, joka sisältää ominaisuuksia
function bullet_load()

	src2 = {}
	src2[1] = love.audio.newSource ("Assets/Sounds/Laser.mp3", "static")
	player.bullet = love.graphics.newImage("Assets/Images/Bullet.png")
end

-- Generoi laseri luodit ruudulle ja soittaa äänen
function bullet_spawn(x, y, dir)

if gamestate == "playing" then

	table.insert(bullet, {x = x, y = y, dir = dir, width = bullet.width, height = bullet.height})

	local full = true
	for i=1, #src2 do
		if not src2[i]:isPlaying() then
			full = false
			src2[#src2]:setVolume(percentVolume / 100)
			src2[i]:setPitch(1.05-love.math.random()*.2)
			src2[i]:play()
				break
			end
		end
		if full then
			src2[#src2+1] = src2[1]:clone()
			src2[#src2]:setVolume(percentVolume / 100)
			src2[#src2]:setPitch(1.05-love.math.random()*.2)
			src2[#src2]:play()
		end
	end
end

-- Piirtää luodin ruudulle ja oikeihin koordinaatteihin
function bullet_draw()

	for i,v in ipairs(bullet) do
		love.graphics.setColor(255, 255, 255, 255)
		love.graphics.draw(player.bullet, v.x, v.y)
	end
end

-- On vastuussa luodin liikkumisesta oikeaan suuntaan ja sen poistamisesta kun se pääsee ohjelman ikkunan ulkopuolelle
function bullet_move(dt)

	for i,v in ipairs (bullet) do
		if v.dir == "up" then
			v.y = v.y - bullet.speed * dt
		end

		if v.dir == "down" then
			v.y = v.y + bullet.speed * dt
		end

		if v.dir == "right" then
			v.x = v.x + bullet.speed * dt
		end

		if v.dir == "left" then
			v.x = v.x - bullet.speed * dt
		end

		if v.x > love.graphics.getWidth() + 5 or
			v.x < - 5 or v.y > love.graphics.getHeight() + 5 or
			v.y < - 5 then

			table.remove(bullet, i)
		end
	end 
end