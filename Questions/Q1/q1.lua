-- Fix or improve the implementation of the below methods

local function releaseStorage(player)
    player:setStorageValue(1000, -1)
end

function onLogout(player)
    if player:getStorageValue(1000) == 1 then
        addEvent(releaseStorage, 1000, player)
    end
    return true
end

-- Solution code:

-- Create a descriptive a constant for the value 1000
local RELEASE_STORAGE = 1000

local function releaseStorage(player)
    player:setStorageValue(RELEASE_STORAGE, -1)
end

function onLogout(player)
    if player:getStorageValue(RELEASE_STORAGE) == 1 then
        -- If the player is logged out, the 'RELEASE_STORAGE' value should not change, and it seems that the delay for 'AddEvent' is unnecessary.
        releaseStorage(player)
    end
    return true
end