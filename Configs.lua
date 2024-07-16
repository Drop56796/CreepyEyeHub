local HttpService = game:GetService("HttpService")

-- 定义文件路径
local folderPath = "/storage/emulated/0/Android/data/com.roblox.client/files/Delta/workspace/MrWhiteConfig"

-- 检查目录是否存在，如果不存在则创建
local function ensureDirectoryExists(path)
    local success, errorMessage = pcall(function()
        if not isfolder(path) then
            makefolder(path)
        end
    end)
    if not success then
        warn("创建目录时出错: " .. errorMessage)
    end
end

-- 检查游戏是否支持
local function isGameSupported(gameName)
    local supportedGames = {
        "Doors",
        "Prison life",
        "Thirsy Vampire"
    }
    for _, name in ipairs(supportedGames) do
        if name == gameName then
            return true
        end
    end
    return false
end

-- 创建配置文件
local function createConfigFile()
    local configData = {
        Speed = 1,
        SupportedGames = {
            "Doors",
            "Prison life",
            "Thirsy Vampire"
        }
    }

    local jsonData = HttpService:JSONEncode(configData)
    
    -- 使用时间戳创建唯一文件名
    local timestamp = os.time()
    local filePath = folderPath .. "/config_" .. timestamp .. ".json"

    local success, errorMessage = pcall(function()
        writefile(filePath, jsonData)
    end)
    if success then
        print("配置文件已成功保存: " .. filePath)
    else
        warn("保存配置文件时出错: " .. errorMessage)
    end
end

-- 执行特定操作
local function performOperation()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Drop56796/CreepyEyeHub/main/Script.lua"))()
end

-- 主函数
local function main(gameName)
    ensureDirectoryExists(folderPath)
    if isGameSupported(gameName) then
        createConfigFile()
        performOperation()
    else
        warn("游戏不支持: " .. gameName)
    end
end

-- 调用主函数
main("DOORS")
main("Thirsy Vampire")
main("Prison life")
