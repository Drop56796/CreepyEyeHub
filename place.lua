local doorsPlaceId = 6516141723  

local function isDoorsGame()
    return game.PlaceId == doorsPlaceId
end

if isDoorsGame() then
    loadstring(game:HttpGet("https://github.com/Drop56796/CreepyEyeHub/blob/main/Fliesob.lua?raw=true"))()
else
    loadstring(game:HttpGet("https://github.com/Drop56796/new/blob/main/Script.lua?raw=true"))()
end
