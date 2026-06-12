
local Protect = loadstring(game:HttpGet("https://raw.githubusercontent.com/setrawmetatable/Scripts/refs/heads/main/Protect.lua"))()
local AntiEnv = loadstring(game:HttpGet("https://raw.githubusercontent.com/setrawmetatable/Scripts/refs/heads/main/AntiEnv.lua"))()
local Notification = loadstring(game:HttpGet("https://raw.githubusercontent.com/setrawmetatable/Scripts/refs/heads/main/Notification"))()

local Api = {
    players = game:GetService("Players"),
    run = game:GetService("RunService"),
    uis = game:GetService("UserInputService"),
    vim = game:GetService("VirtualInputManager"),
    tween = game:GetService("TweenService"),
    core = game:GetService("CoreGui"),
    light = game:GetService("Lighting"),
    http = game:GetService("HttpService"),
    sound = game:GetService("SoundService"),
    market = game:GetService("MarketplaceService"),
    rep = game:GetService("ReplicatedStorage"),
    text = game:GetService("TextService"),
    
    player = game:GetService("Players").LocalPlayer,
    name = game:GetService("Players").LocalPlayer.Name,
    camera = workspace.CurrentCamera,
    placeid = game.PlaceId,
    
    mouse = game:GetService("Players").LocalPlayer:GetMouse(),
    screen = Instance.new("ScreenGui")

}   

local Function = {
    {name = "Drawing", present = type(Drawing) == "table" or type(Drawing) == "userdata"},
    {name = "hookmetamethod", present = type(hookmetamethod) == "function"},
    {name = "getnamecallmethod", present = type(getnamecallmethod) == "function"},
    {name = "checkcaller", present = type(checkcaller) == "function"},
    {name = "getgc", present = type(getgc) == "function" and pcall(getgc) and type(getgc()) == "table"},
}

function Api:CreateProtect()
    getgenv().token, exp = Protect.generate()
end

function Api:CheckProtect()
    local success, result = pcall(function()
        return Protect.check(token, exp)
    end)
end

function Api:Kick(text)
    Api.player:Kick(text)
    return
end

function Api:CheckSupport()
    for i, sup in ipairs(Function) do
        if not sup.present then
            Api:Kick("[Executor unsupported]")
            break
        end
    end
end

function Api:GetPlayers()
    for i, all in pairs(Api.players:GetPlayers()) do
        return all
    end
end

function Api:GetScript(name)
    local obj = game:FindFirstChild(name, true)
    if obj then
        return obj
    end
    return nil
end

function Api:Notification(text, time)
    Notification:Notification(text, time)
end

print([[
                _   ___             __              
                        / | / (_)___ _____ _/ /___  ________ 
                       /  |/ / / __ `/ __ `/ / __ \/ ___/ _ \
                      / /|  / / /_/ / /_/ / / /_/ (__  )  __/
                     /_/ |_/_/\__, /\__,_/_/\____/____/\___/ 
                             /____/   
]])

return Api
