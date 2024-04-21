
local combat = {}

-- Create the combat stages using the AREA_SEQUENCE_STORM
for i = 1, #AREA_SEQUENCE_STORM do
    combat[i] = Combat()
    combat[i]:setParameter(COMBAT_PARAM_TYPE, COMBAT_ICEDAMAGE)
    combat[i]:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_ICETORNADO)
    combat[i]:setArea(createCombatArea(AREA_SEQUENCE_STORM[i]))
end

function executeCombat(combatInfo, i)
    if not combatInfo.player then
        return false
    end
    if not combatInfo.player:isPlayer() then
        return false
    end
    combatInfo.combat[i]:execute(combatInfo.player, combatInfo.var)
end

function onCastSpell(player, var)
    local combatInfo = { player = player, var = var, combat = combat }
    local level = player:getLevel()
    -- Use Eternal Winter formula
    local magicLevel = player:getMagicLevel()
    local min = (level / 5) + (magicLevel * 5.5) + 25
    local max = (level / 5) + (magicLevel * 11) + 50
    -- Set 300ms of delay for each animiation (similar to the video)
    local animationDelay = 300
    -- Execute the combat stages
    for i = 1, #AREA_SEQUENCE_STORM do
        combat[i]:setFormula(COMBAT_FORMULA_LEVELMAGIC, 0, -min, 0, -max)
        if i == 1 then
            combat[i]:execute(player, var)
        else
            addEvent(executeCombat, (animationDelay * i) - animationDelay, combatInfo, i)
        end
    end
    return true
end