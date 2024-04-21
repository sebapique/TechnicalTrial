jumpButton = nil
jumpWindow = nil
jumpActionButton = nil

function init()
  g_ui.importStyle('jumpwindow')
  jumpButton = modules.client_topmenu.addLeftGameButton('jumpButton', tr('Jump!'), '/images/topbuttons/jump', show)
end

function terminate()
  disconnect(g_game, {
    onGameStart = online,
    onGameEnd = offline
  })
  -- Remove moveButtionEventId event on terminate
  removeEvent(moveButtonEventId)
  jumpWindow:destroy()
  jumpButton:destroy()
  mouseGrabberWidget:destroy()
end

function show()
  jumpWindow = g_ui.createWidget('JumpWindow', rootWidget)
  -- get jumpAction button
  jumpActionButton = jumpWindow:getChildById('jumpAction')
  -- get the parent window position and size reference
  local parentPosition = jumpWindow:getPosition()
  local parentHeight = jumpWindow:getHeight()
  local parentWidth = jumpWindow:getWidth()
  -- set a initial position based on the parent reference
  jumpActionButton:setPosition({ x = parentPosition.x + parentWidth - 70, y = parentPosition.y + parentHeight - 50})
  if not g_game.isOnline() then
    return
  end
  -- start to move jumoAction button 
  moveButton()
end

function moveButton()
  -- get the parent window position and size reference
  parentPosition = jumpWindow:getPosition()
  parentWidth = jumpWindow:getWidth()
  -- get the current button position and size
  local buttonPosition = jumpActionButton:getPosition()
  local buttonWidth = jumpActionButton:getWidth()
  -- avoid move the button out of the parent dimensions
  if buttonPosition.x > parentPosition.x + 30 then
    jumpActionButton:setPosition({ x = buttonPosition.x - 15, y = buttonPosition.y})
  else
    jumpActionButton:setPosition({ x = parentPosition.x + parentWidth - 70, y = buttonPosition.y })
    -- jump if the button hits a parent edge
    jump(jumpActionButton)
  end
  -- add a timer event to move the button each 100ms
  moveButtonEventId = scheduleEvent(moveButton, 100)
end

-- create a jump function to move the button on clicking it
function jump(widget)
  -- get the parent window position and size reference
  parentPosition = jumpWindow:getPosition()
  parentHeight = jumpWindow:getHeight()
  parentWidth = jumpWindow:getWidth()
  local widgetPos = widget:getPosition()
  -- jump the button between the parent dimensions
  local randomY = math.random(parentPosition.y + 30, parentPosition.y + parentHeight - 30)
  widget:setPosition({ x = parentPosition.x + parentWidth - 70, y = randomY})
end
