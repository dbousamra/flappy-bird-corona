display.setStatusBar( display.HiddenStatusBar )
display.setDefault("magTextureFilter", "nearest")
display.setDefault("minTextureFilter", "nearest")

screenW = display.contentWidth
screenH = display.contentHeight 
halfW = display.contentWidth * 0.5
halfH = display.contentHeight * 0.5
thirdH = display.contentHeight * 0.33

-- include the Corona "storyboard" module
local storyboard = require "storyboard"

-- load menu screen
storyboard.gotoScene( "scenes.menu" )
