local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local widget = require "widget"
local background = require "util.background"

-- Called when the scene's view does not exist:
function scene:createScene( event )
  local group = self.view 

  local bg          = Background:createBackground()
  local floor       = Background:createFloor()
  local title       = scene:createGameTitle()
  local playButton  = scene:createPlayButton()
  local flappy      = scene:createFlappy()
  group:insert(bg)
  group:insert(floor)
  group:insert(title)
  group:insert(playButton)
  group:insert(flappy)
end

function scene:createGameTitle()
  local gameTitle = display.newImageRect("images/logo.png", 400, 133)
    gameTitle.x = halfW
    gameTitle.y = thirdH
  return gameTitle
end

function scene:createPlayButton()
  local function onPlayBtnEvent(event)
    local phase = event.phase 
    if "began" == phase then
      event.target.y = event.target.y + 2
    elseif "ended" == phase then
      event.target.y = event.target.y - 2
      storyboard.gotoScene( "scenes.game", "fade", 200 )
    end
  end

  local playBtn = widget.newButton {
    width = 200,
    height = 100,
    x = halfW,
    y = 2 * thirdH,
    defaultFile = "images/play_button.png",
    onEvent = onPlayBtnEvent
  }

  local function onPlayBtnRelease()
    storyboard.gotoScene( "game", "fade", 500 )
    return true
  end
  return playBtn
end

function scene:createFlappy()
  local sheetData = { width=17, height=12, numFrames=2, sheetContentWidth=17, sheetContentHeight=24 }
  local mySheet = graphics.newImageSheet( "images/flappy.png", sheetData )
  local sequenceData = { name = "normalRun", start=1, count=2, time=400 }
  local animation = display.newSprite( mySheet, sequenceData )
  animation.x = display.contentWidth/2  --center the sprite horizontally
  animation.y = display.contentHeight/2  --center the sprite vertically
  animation.xScale = 4 * animation.xScale
  animation.yScale = 4 * animation.yScale
  animation:play()

  local function bounceFlappy(flappy, speed)
    local function bounceFlappyDown(flappy)
      transition.to( flappy, { y = flappy.y + 10 , time=300, transition=easing.inOutSine, onComplete=bounceFlappy } )
    end
    transition.to( flappy, { y = flappy.y - 10 , time=300, transition=easing.inOutSine, onComplete=bounceFlappyDown } )
  end
  bounceFlappy(animation)
  return animation
end

function scene:enterScene(event)
  if(storyboard.getPrevious() ~= nil) then
    storyboard.purgeScene(storyboard.getPrevious())
    storyboard.removeScene(storyboard.getPrevious())
  end
end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "destroyScene", scene )

return scene