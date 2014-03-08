Background = {}
Background.__index = Background
setmetatable(Background, {__index = Background })

function Background:createBackground()
  local backgrounds = { "images/background-day.png", "images/background-night.png"}
  local randomBackground = backgrounds[math.random(1, #backgrounds)]
  local background = display.newImageRect(randomBackground, screenW, screenH)
    background.x = halfW
    background.y = halfH
  return background
end

function Background:createFloor()
  local floor = display.newImageRect("images/floor.png", screenW + 60, 256 + 100)
    floor.x = halfW  
    floor.y = screenH - (256/2) + 100

  local function reset_landscape( landscape )
    landscape.x = halfW
    transition.to( landscape, { x = halfW - 30 , time=100, onComplete=reset_landscape } )
  end

  reset_landscape(floor)
  return floor
end