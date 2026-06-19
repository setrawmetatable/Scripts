
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
    screen = Instance.new("ScreenGui"),

    mobile = game:GetService("UserInputService").TouchEnabled and not game:GetService("UserInputService").MouseEnabled,
    executor = identifyexecutor() or getexecutorname() or "Unknown",

    cache = {
        players = {},
        player = {},
    },
}  

function Api:UpdateCache()
    table.clear(Api.cache.players)
    for i, v in pairs(Api.players:GetPlayers()) do
        if v ~= Api.player then
            local character = v.Character
            if character then
                local humanoid = character:FindFirstChild("Humanoid")
                local root = character:FindFirstChild("HumanoidRootPart")
                local head = character:FindFirstChild("Head")
                local torso = character:FindFirstChild("Torso")
                local leftarm = character:FindFirstChild("Left Arm")
                local rightarm = character:FindFirstChild("Right Arm")
                local leftleg = character:FindFirstChild("Left Leg")
                local rightleg = character:FindFirstChild("Right Leg")
                if humanoid and humanoid.Health ~= 0 and root then 
                    Api.cache.players[v] = {
                        character = character,
                        humanoid = humanoid,
                        root = root,
                        head = head,
                        torso = torso,
                        leftarm = leftarm,
                        rightarm = rightarm,
                        leftleg = leftleg,
                        rightleg = rightleg,
                    }
                end
            end
        end
    end
    local character = Api.player.Character
    if not character then
        Api.cache.player.character = nil
        Api.cache.player.humanoid = nil
        Api.cache.player.root = nil
        Api.cache.player.head = nil
    else
        Api.cache.player.character = character
        Api.cache.player.humanoid = character:FindFirstChild("Humanoid")
        Api.cache.player.root = character:FindFirstChild("HumanoidRootPart")
        Api.cache.player.head = character:FindFirstChild("Head")
    end
end

local Function = {
    {name = "Drawing", present = type(Drawing) == "table" or type(Drawing) == "userdata"},
    {name = "hookmetamethod", present = type(hookmetamethod) == "function"},
    {name = "getnamecallmethod", present = type(getnamecallmethod) == "function"},
    {name = "checkcaller", present = type(checkcaller) == "function"},
    {name = "getgc", present = type(getgc) == "function" and pcall(getgc) and type(getgc()) == "table"},
}

function Api:Loadstring(load)
    local succes, result = pcall(function()
        return loadstring(game:HttpGet(load))()
    end)
    if not succes then
        warn("[Api] Failed load")
        return nil
    end
    return result
end

local Protect = Api:Loadstring("https://raw.githubusercontent.com/setrawmetatable/Scripts/refs/heads/main/Protect.lua")
local AntiEnv = Api:Loadstring("https://raw.githubusercontent.com/setrawmetatable/Scripts/refs/heads/main/AntiEnv.lua")
local Notification = Api:Loadstring("https://raw.githubusercontent.com/setrawmetatable/Scripts/refs/heads/main/Notification")

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
            Api:Kick("[Executor unsupported] " .. Api.executor .. " is not supported")
            return false
        end
    end
    return true
end

function Api:GetScript(name)
    local obj = game:FindFirstChild(name, true)
    if obj then
        return obj
    end
    return nil
end

function Api:Random()
	local chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
	local name = ""
	local lenght = math.random(5, 10)
	for i = 1, lenght do 
		local rand = math.random(1, #chars)
		name = name .. string.sub(chars, rand, rand)
	end
	return name
end

function Api:Notification(text, time)
    if Notification and Notification:Notification then
        Notification:Notification(text, time)
    end
end

function Api:JoinDiscord(dscode)
    local http = (syn and syn.request) or (psm and psm.request) or request
    if http then
        pcall(function()
            local HttpService = game:GetService("HttpService")
            http({
                Url = "http://127.0.0.1:6463/rpc?v=1",
                Method = "POST",
                Headers = {
                    ["Content-Type"] = "application/json",
                    ["Origin"] = "https://discord.com"
                },
                Body = HttpService:JSONEncode({
                    cmd = "INVITE_BROWSER",
                    args = {code = dscode},
                    nonce = HttpService:GenerateGUID(true)
                })
            })
        end)
    end
end

function Api:CheckDevice()
    if Api.mobile then
        Api:Kick("[Device unsupported] Mobile is not supported")
        return true
    end
    return false
end

function Api:PrintNiga()
    print([[
                         _   ___             __              
                        / | / (_)___ _____ _/ /___  ________ 
                       /  |/ / / __ `/ __ `/ / __ \/ ___/ _ \
                      / /|  / / /_/ / /_/ / / /_/ (__  )  __/
                     /_/ |_/_/\__, /\__,_/_/\____/____/\___/ 
                             /____/   
    ]])
end

return Api
