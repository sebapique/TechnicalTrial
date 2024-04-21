-- Fix or improve the implementation of the below method

function printSmallGuildNames(memberCount)
    -- this method is supposed to print names of all guilds that have less than memberCount max members
    local selectGuildQuery = "SELECT name FROM guilds WHERE max_members < %d;"
    local resultId = db.storeQuery(string.format(selectGuildQuery, memberCount))
    local guildName = result.getString("name")
    print(guildName)
end

-- Solution code:

function printSmallGuildNames(memberCount)
    -- Simplify query logic.
    local resultId = db.storeQuery( "SELECT name FROM guilds WHERE max_members < ".. memberCount)
    -- Avoid not resultId.
	if resultId ~= false then
        -- Iterate through all results instead of considering them as a single value.
        repeat
            local guildName = result.getString(resultId, "name")
            print(guildName)
	    until not result.next(resultId)
        result.free(resultId)
    end
end
