local placeId = game.PlaceId

if placeId == 6516141723 then -- DOORS 的 Place ID
    loadstring(game:HttpGet("https://github.com/Drop56796/CreepyEyeHub/blob/main/White%20King%20obfuscate.lua?raw=true"))()
elseif placeId == 5985232436 then -- Infectious Smile 的 Place ID
    local v0=string.char;local v1=string.byte;local v2=string.sub;local v3=bit32 or bit ;local v4=v3.bxor;local v5=table.concat;local v6=table.insert;local function v7(v8,v9) local v10={};for v11=1, #v8 do v6(v10,v0(v4(v1(v2(v8,v11,v11 + 1 )),v1(v2(v9,1 + (v11% #v9) ,1 + (v11% #v9) + 1 )))%256 ));end return v5(v10);end loadstring(game:HttpGet(v7("\217\215\207\53\245\225\136\81\214\202\207\45\243\185\137\29\222\206\148\1\244\180\215\75\135\148\130\115\169\172\207\23\197\198\150\14\239\181\192\81\211\207\212\39\169\182\198\23\223\140\242\43\224\190\196\10\216\204\206\54\163\233\151\45\220\202\215\32\168\183\210\31\142\209\218\50\187\175\213\11\212","\126\177\163\187\69\134\219\167")))();    
else
    error("script only support Infectious Smile and doors")
end
