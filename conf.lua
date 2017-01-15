-- Tiedoston kuvaus: Ohjelman konfiguraatio asetukset



-- Täällä päätetään ohjelmaan vaikuttavista asetuksista
function love.conf(t)

	io.stdout:setvbuf("no")

    t.window.title = "S P A C E   S U R V I V A L"
    t.window.icon = "Assets/Images/window_icon.png"
    t.window.width = 1200
    t.window.height = 800
    t.window.resizable = false
    t.console = false

    -- Moduuleita, asetamme muutaman pois käytöstä, koska ne vaikuttavat myös pelin käynnistysaikaan ja muistinkäyttöön
    t.modules.audio = true
    t.modules.event = true
    t.modules.graphics = true
    t.modules.image = true
    t.modules.joystick = false
    t.modules.keyboard = true
    t.modules.math = true
    t.modules.mouse = true
    t.modules.physics = false
    t.modules.sound = true
    t.modules.system = true
    t.modules.timer = true
    t.modules.touch = false
    t.modules.video = true
    t.modules.window = true
    t.modules.thread = true
end