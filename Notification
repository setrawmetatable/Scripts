
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local ContextActionService = game:GetService("ContextActionService")
local CoreGui = game:GetService("CoreGui")
local GuiService = game:GetService("GuiService")

gethui = gethui or function() return CoreGui end

local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera
local Mouse = LocalPlayer:GetMouse()
local GuiInset = GuiService:GetGuiInset().Y

local Library = {
    Directory = "niggahack",
    Folders = {
        Assets = "/Assets",
        Configs = "/Configs"
    },
    FontSize = 9,
    Animation = {
        Time = 0.3,
        Style = "Quint",
        Direction = "Out"
    },
    Theme = nil,
    Threads = {},
    Connections = {},
    Notifications = {},
    Holder = nil,
    NotifHolder = nil,
    Font = nil
}

do
    Library.__index = Library

    if not isfolder(Library.Directory) then
        makefolder(Library.Directory)
    end

    for _, Folder in Library.Folders do
        if not isfolder(Library.Directory .. Folder) then
            makefolder(Library.Directory .. Folder)
        end
    end

    local Themes = {
        ["Preset"] = {
            ["Background"] = Color3.fromRGB(16, 17, 20),
            ["Outline"] = Color3.fromRGB(36, 38, 45),
            ["Border"] = Color3.fromRGB(7, 8, 10),
            ["Accent"] = Color3.fromRGB(152, 188, 255),
            ["Risky"] = Color3.fromRGB(255, 50, 50),
            ["Light Border"] = Color3.fromRGB(12, 8, 12),
            ["Border 2"] = Color3.fromRGB(5, 10, 14),
            ["Text"] = Color3.fromRGB(180, 180, 180),
            ["Section"] = Color3.fromRGB(20, 21, 25),
            ["Element"] = Color3.fromRGB(28, 29, 35),
            ["Hovered Element"] = Color3.fromRGB(36, 38, 45),
            ["Inactive Text"] = Color3.fromRGB(100, 100, 100)
        }
    }

    Library.Theme = Themes.Preset

    -- Custom Font
    local CustomFont = {}
    do
        function CustomFont:New(Name, Weight, Style, Data)
            if not isfile(Data.Id) then
                writefile(Data.Id, game:HttpGet(Data.Url))
            end

            local Data = {
                name = Name,
                faces = {
                    {
                        name = Name,
                        weight = Weight,
                        style = Style,
                        assetId = getcustomasset(Data.Id)
                    }
                }
            }

            writefile(string.format("%s%s/%s.font", Library.Directory, Library.Folders.Assets, Name), HttpService:JSONEncode(Data))
            return Font.new(getcustomasset(string.format("%s%s/%s.font", Library.Directory, Library.Folders.Assets, Name)))
        end

        Library.Font = CustomFont:New("SmallestPixel7", 400, "Regular", {
            Id = "SmallestPixel7",
            Url = "https://github.com/sametexe001/luas/raw/refs/heads/main/smallest_pixel-7.ttf"
        })
    end

    Library.Create = function(Self, Class, Properties)
        local Data = {
            Class = Class,
            Properties = Properties,
            Instance = Instance.new(Class)
        }

        for Index, Property in Properties do
            if Property == "FontFace" then
                Data.Instance[Property] = Library.Font
                continue
            end

            if Property == "TextSize" then
                Data.Instance[Property] = Library.FontSize
                continue
            end

            Data.Instance[Index] = Property
        end

        return setmetatable(Data, Library)
    end

    Library.Connect = function(Self, Signal, Callback)
        local Connection

        if Self.Instance then
            if Self.Instance[Signal] then
                Connection = Self.Instance[Signal]:Connect(Callback)
            else
                Connection = Signal:Connect(Callback)
            end
        else
            Connection = Signal:Connect(Callback)
        end

        table.insert(Library.Connections, Connection)
        return Connection
    end

    Library.Tween = function(Self, Properties, Info, IsRawItem)
        local Object = Self.Instance or IsRawItem
        Info = Info or TweenInfo.new(Library.Animation.Time, Enum.EasingStyle[Library.Animation.Style],
            Enum.EasingDirection[Library.Animation.Direction])

        if not Object then
            return
        end

        local NewTween = TweenService:Create(Object, Info, Properties)
        NewTween:Play()

        return NewTween
    end

    Library.SafeCall = function(Self, Function, ...)
        local Arguments = { ... }
        local Success, Result = pcall(Function, table.unpack(Arguments))

        if not Success then
            warn(Result)
            return false
        end

        return Success, Result
    end

    Library.Holder = Library:Create("ScreenGui", {
        Parent = gethui(),
        Name = "\0",
        ZIndexBehavior = Enum.ZIndexBehavior.Global,
        IgnoreGuiInset = true,
        ResetOnSpawn = false
    })

    Library.NotifHolder = Library:Create("Frame", {
        Name = "\0",
        Parent = Library.Holder.Instance,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 0, 0, 10 + GuiInset),
        Size = UDim2.new(0, 0, 1, 0),
        BorderSizePixel = 0,
        AutomaticSize = Enum.AutomaticSize.X
    })

    Library:Create("UIListLayout", {
        Name = "\0",
        Parent = Library.NotifHolder.Instance,
        SortOrder = Enum.SortOrder.LayoutOrder,
        HorizontalAlignment = Enum.HorizontalAlignment.Left,
        Padding = UDim.new(0, 6)
    })

    Library:Create("UIPadding", {
        Name = "\0",
        Parent = Library.NotifHolder.Instance,
        PaddingTop = UDim.new(0, 10),
        PaddingBottom = UDim.new(0, 8),
        PaddingRight = UDim.new(0, 8),
        PaddingLeft = UDim.new(0, 8)
    })

    Library.Notification = function(Self, Name, Duration, Color)
        local Items = {}
        do
            Items["Notification"] = Library:Create("Frame", {
                Name = "\0",
                Parent = Library.NotifHolder.Instance,
                Size = UDim2.new(0, 0, 0, 20),
                Position = UDim2.new(0, 471, 0, 678),
                BorderSizePixel = 0,
                AutomaticSize = Enum.AutomaticSize.X,
                BackgroundColor3 = Library.Theme["Section"]
            }):AddToTheme({ BackgroundColor3 = 'Section' })

            Library:Create("UIPadding", {
                Name = "\0",
                Parent = Items["Notification"].Instance,
                PaddingRight = UDim.new(0, 8),
                PaddingLeft = UDim.new(0, 8)
            })

            Items["Stroke"] = Library:Create("UIStroke", {
                Name = "\0",
                Parent = Items["Notification"].Instance,
                ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                LineJoinMode = Enum.LineJoinMode.Miter,
                Color = Library.Theme["Border"],
                BorderOffset = UDim.new(0, 1)
            }):AddToTheme({ Color = 'Border' })

            Items["Stroke1"] = Library:Create("UIStroke", {
                Name = "\0",
                Parent = Items["Notification"].Instance,
                ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                LineJoinMode = Enum.LineJoinMode.Miter,
                Color = Library.Theme["Outline"]
            }):AddToTheme({ Color = 'Outline' })

            Items["AccentLiner"] = Library:Create("Frame", {
                Name = "\0",
                Parent = Items["Notification"].Instance,
                Position = UDim2.new(0, -8, 0, 0),
                Size = UDim2.new(0, 1, 1, 0),
                BorderSizePixel = 0,
                BackgroundColor3 = Color
            })

            Items["Text"] = Library:Create("TextLabel", {
                Name = "\0",
                FontFace = Library.Font,
                TextSize = Library.FontSize,
                Parent = Items["Notification"].Instance,
                TextColor3 = Library.Theme["Text"],
                Text = Name,
                AnchorPoint = Vector2.new(0, 0.5),
                Size = UDim2.new(0, 0, 0, 15),
                BackgroundTransparency = 1,
                Position = UDim2.new(0, 2, 0.5, -1),
                BorderSizePixel = 0,
                AutomaticSize = Enum.AutomaticSize.X
            }):AddToTheme({ TextColor3 = 'Text' })
        end

        for Index, Value in Items do
            if Value.Instance:IsA("Frame") then
                Value.Instance.BackgroundTransparency = 1
            elseif Value.Instance:IsA("TextLabel") then
                Value.Instance.TextTransparency = 1
            elseif Value.Instance:IsA("UIStroke") then
                Value.Instance.Transparency = 1
            end
        end

        local GetSize = function()
            local AbsSize = Items["Notification"].Instance.AbsoluteSize
            Items["Notification"].Instance.AutomaticSize = Enum.AutomaticSize.None
            task.wait()
            Items["Notification"].Instance.Size = UDim2.new(0, AbsSize.X, 0, AbsSize.Y)
            return AbsSize
        end

        local Size = GetSize()
        task.wait()
        Items["Notification"].Instance.Size = UDim2.new(0, 0, 0, Size.Y)

        local Info = TweenInfo.new(0.85, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out, 0, false, 0)

        Library:Thread(function()
            for Index, Value in Items do
                if Value.Instance:IsA("Frame") then
                    Value:Tween({ BackgroundTransparency = 0 }, Info)
                elseif Value.Instance:IsA("TextLabel") then
                    Value:Tween({ TextTransparency = 0 }, Info)
                elseif Value.Instance:IsA("UIStroke") then
                    Value:Tween({ Transparency = 0 }, Info)
                end
            end

            Items["Notification"]:Tween({ Size = UDim2.new(0, Size.X, 0, Size.Y) }, Info)

            task.delay(Duration + 0.1, function()
                for Index, Value in Items do
                    if Value.Instance:IsA("Frame") then
                        Value:Tween({ BackgroundTransparency = 1 })
                    elseif Value.Instance:IsA("TextLabel") then
                        Value:Tween({ TextTransparency = 1 })
                    elseif Value.Instance:IsA("UIStroke") then
                        Value:Tween({ Transparency = 1 })
                    end
                end

                Items["Notification"]:Tween({ Size = UDim2.new(0, 0, 0, Size.Y) }, Info)
                task.wait(0.5)
                Items["Notification"].Instance:Destroy()
            end)
        end)
    end

    Library.Thread = function(Self, Function)
        local NewThread = coroutine.create(Function)

        coroutine.wrap(function()
            coroutine.resume(NewThread)
        end)()

        table.insert(Library.Threads, NewThread)
        return NewThread
    end

    Library.AddToTheme = function(Self, Properties)
        local Object = Self.Instance

        for Property, Value in Properties do
            if type(Value) == "string" then
                Object[Property] = Library.Theme[Value]
            else
                Object[Property] = Value()
            end
        end

        return Self
    end
end

return Library
