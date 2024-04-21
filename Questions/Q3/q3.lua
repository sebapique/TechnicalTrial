-- Fix or improve the name and the implementation of the below method

function do_sth_with_PlayerParty(playerId, membername)
    player = Player(playerId)
    local party = player:getParty()

    for k,v in pairs(party:getMembers()) do
        if v == Player(membername) then
            party:removeMember(Player(membername))
        end
    end
end

-- Solution code: 

-- Use camel case and more descriptive name for the function.
function removeMemberFromPlayerParty(playerId, membername)
    local player = Player(playerId)
    local party = player:getParty()
    -- Avoid using a nil player or party, and return false instead.
    if player == nil or party == nil then
		return false
	end
    local members = party:getMembers()

    -- Improve for declaration (more readable and follow the LUA code style ).
    for _, member in ipairs(members) do
        -- Check directly with the player object (use Player(membername) is wrong).
        if member == player then
            party:removeMember(member)
            -- Add a return true once the member is removed - avoid iterating in all members.
            return true  
        end
    end
    -- Return false if player is membername is not in the party.
    return false
end
