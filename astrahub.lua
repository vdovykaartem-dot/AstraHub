--	Functions.Notify({Title = "Used For Notifications."})

local LoadStart = tick()

if shared.Hastelepasta then
    return 
end

shared.Hastelepasta = true

getgenv().Astra = {
    Legit = true
}

-- Змінено URL на AstraHub, якщо файли розміщені на іншому репозиторії
local BaseUrl = "https://raw.githubusercontent.com/therealcookiemonsterof1966/AstraHub/main/"

getgenv().Astra = {
    Environment = loadstring(game:HttpGet(BaseUrl .. "Components/Environment.luau"))(),
    ESPLibrary = loadstring(game:HttpGet(BaseUrl .. "Components/ESP.luau"))(),
    ["16Notice"] = loadstring(game:HttpGet(BaseUrl .. "Components/16Notice.luau"))(),
    Legit = true
}

local Astra = getgenv().Astra

local function CloneReference(Object)
    if Astra and Astra.Environment.cloneref then
        return Astra.Environment.cloneref(Object)
    end
    return Object
end

local Services = setmetatable({}, {
    __index = function(Self, Name)
        return CloneReference(game:GetService(Name))
    end
})

if Astra.Environment.writefile and Astra.Environment.readfile then
    -- База даних перероблена на Astra
    if not Astra.Environment.isfile("Astra/UserData.json") then[cite: 1]
        local Data = {
            TotalExecutions = 0,
            UILibrary = "Obsidian"
        }

        Astra.Environment.writefile(
            "Astra/UserData.json",[cite: 1]
            Services.HttpService:JSONEncode(Data)
        )
    end

    local UserData = Astra.Environment.readfile("Astra/UserData.json")[cite: 1]
    local Decoded = Services.HttpService:JSONDecode(UserData)

    if not Decoded.TotalExecutions then
        Decoded.TotalExecutions = 0
    end

    Decoded.TotalExecutions = Decoded.TotalExecutions + 1

    if not Decoded.UILibrary then
        Decoded.UILibrary = "Obsidian"
    end

    Astra.TotalExecutions = Decoded.TotalExecutions
    Astra.UILibrary = Decoded.UILibrary

    Astra.Environment.writefile(
        "Astra/UserData.json",[cite: 1]
        Services.HttpService:JSONEncode(Decoded)
    )
end

Astra.Interface = loadstring(game:HttpGet(
    BaseUrl .. "Components/Interface.luau"
))()

Astra.Analytics = loadstring(game:HttpGet(
    BaseUrl .. "Components/Analytics.luau"
))()


Astra.SavePath = "Astra/Doors/Game"[cite: 1]

local Library = Astra.Interface.Library
local SaveManager = Astra.Interface.SaveManager
local ThemeManager = Astra.Interface.ThemeManager

local Toggles = Library.Toggles
local Options = Library.Options

local function CloneReference(Object)
	if Astra and Astra.Environment.cloneref then
		return Astra.Environment.cloneref(Object)
	end
	return Object
end

local Services = setmetatable({}, {
	__index = function(Self, Name)
		return CloneReference(game:GetService(Name))
	end
})

-- archives locals
local DroneWalkedIntoParents = {}
local DroneConnection = nil
local DronesStampedeParents = {}
local DronesStampedeConnection = nil
local AlmaConnection = nil
local ScribblesHook = nil
local WaterParts = {}
local WaterConnection = nil
local ForgetMeNotConnection
local ForgetMeNotSavedRoom
local ForgetMeNotProcessing = {}
local ForgetMeNotSolvedRooms = {}
local ForgetMeNotStorage
local ForgetMeNotRoomCount = 0
local ForgetMeNotHasSolved = false
local AntiScribbles_OldNamecall
local AntiScribbles_IsHooked = false
local TimeShowerConnection = nil
local TimeShowerClone = nil
local TimeShowerSourceLabel = nil
local TimeShowerLabel = nil
local TimeShowerToken = 0
local BypassDronesStampedeConnection
local HonchoCorrectBoxConnection = nil
local HonchoProcessedRooms = {}
local HonchoESPObjects = {}

-- Stairwell locals

local Globals = {}
local Connections = {}
local ESPConnections = {}
local Groupboxes = {}
local FakePrompts = {}
local Functions = {}
local PartProperties = {}

local Objects = {
	Prompts = {},
	Objectives = {},
	Doors = {},
	HidingSpots = {},
	Entities = {},
	SeekObstructions = {},
	Items = {},
	Chests = {},
	Currency = {},
	Ladders = {},
	Obstructions = {},
	EventTriggers = {},
	JumpscareModules = {},
	SeekHighlights = {},
	EyestalkHighlights = {},
	SeekNodes = {},
	SeekDuckBoards = {},
	SeekBridges = {},
	PathLights = {}
}

Globals.IncompatibleMessage = "Your executor doesn't support this feature."

Functions.CheckCompatability = function(Array)
	for _, Name in Array do
		if not Astra.Environment[Name] then
			return false
		end
	end
	return true
end

local Entities = {
	["StemsEntity"] = {
	    Alias = 'Balls',
		NotifyMessage = { Title = "Balls", Body = "Balls."}
	},
	["NoiseModel"] = {
		Alias = 'Noise',
		NotifyMessage = { Title = "Entity 'Noise' has spawned.", Body = "Dont let it touch you." }
	},
	["Creak"] = {
		Alias = "Creak",
		NotifyMessage = { Title = "Entity 'Creak' has spawned.", Body = "Dont touch him." }
	},
	["DronesStampede"] = {
		Alias = "DronesStampede",
		NotifyMessage = { Title = "Entity 'Drones Stampede' has spawned.", Body = "Find a hiding spot." }
	},
	["TellerRig"] = {
		Alias = "Teller",
		NotifyMessage = { Title = "Entity 'Teller' has spawned.", Body = "Dont worry, hes only annoying." }
	},
	["Scribbles"] = {
		Alias = "Scribbles",
		NotifyMessage = { Title = "Entity 'Scribbles' has spawned.", Body = "Find a hiding spot." }
	},
	["BashMoving"] = {
		Alias = "Bash",
		NotifyMessage = { Title = "Entity 'Bash' has spawned.", Body = "Find a hiding spot."}
	},
	["RushMoving"] = {
		Alias = "Rush",
		NotifyMessage = { Title = "Entity 'Rush' has spawned.", Body = "Find a hiding spot." }
	},
	["AmbushMoving"] = {
		Alias = "Ambush",
		NotifyMessage = { Title = "Entity 'Ambush' has spawned.", Body = "Find a hiding spot." }
	},
	["Eyes"] = {
		Alias = "Eyes",
		NotifyMessage = { Title = "Entity 'Eyes' has spawned.", Body = "Avoid looking at it." }
	},
	["Lookman"] = {
		Alias = "Eyes",
		NotifyMessage = { Title = "Entity 'Eyes' has spawned.", Body = "Avoid looking at it." }
	},
	["BackdoorRush"] = {
		Alias = "Blitz",
		NotifyMessage = { Title = "Entity 'Blitz' has spawned.", Body = "Find a hiding spot." }
	},
	["BackdoorLookman"] = {
		Alias = "Lookman",
		NotifyMessage = { Title = "Entity 'Lookman' has spawned.", Body = "Avoid looking at its eyes." }
	},
	["Groundskeeper"] = {
		Alias = "Groundskeeper",
		NotifyMessage = { Title = "Entity 'Groundskeeper' has spawned.", Body = "Avoid stepping on the grass." }
	},
	["A60"] = {
		Alias = "A-60",
		NotifyMessage = { Title = "Entity 'A-60' has spawned.", Body = "Find a hiding spot." }
	},
	["A120"] = {
		Alias = "A-120",
		NotifyMessage = { Title = "Entity 'A-120' has spawned.", Body = "Find a hiding spot." }
	},
	["GloombatSwarm"] = {
		Alias = "Gloombat Swarm",
		NotifyMessage = { Title = "Entity 'Gloombat Swarm' has spawned.", Body = "Keep all light sources turned off." }
	},
	["GlitchRush"] = {
		Alias = "RNIUSHCG==",
		NotifyMessage = { Title = "Entity 'RNIUSHCG==' has spawned.", Body = "Find a hiding spot." }
	},
	["GlitchAmbush"] = {
		Alias = "AR0xMBUSH",
		NotifyMessage = { Title = "Entity 'AR0xMBUSH' has spawned.", Body = "Find a hiding spot." }
	},
	["MonumentEntity"] = {
		Alias = "Monument",
		NotifyMessage = { Title = "Entity 'Monument' has spawned.", Body = "It can't move while you are looking at it." }
	},
	["JeffTheKiller"] = {
		Alias = "Jeff the Killer",
		NotifyMessage = { Title = "Entity 'Jeff the Killer' has spawned.", Body = "Avoid touching him." }
	},
	["CustomEntity"] = {
		Alias = "Custom Entity",
		NotifyMessage = { Title = "Entity 'Custom Entity' has spawned.", Body = "Find a hiding spot." }
	},
	["FrozenAmbush"] = {
		Alias = "Frozen Ambush",
		NotifyMessage = { Title = "Entity 'Frozen Ambush' has spawned.", Body = "Find a hiding spot." }
	},
	["SallyMoving"] = {
		Alias = "Sally",
		NotifyMessage = { Title = "Entity 'Sally' has spawned.", Body = "Find her horse and rop it." }
	}
}

local EntityIcons = {
	["RushMoving"]      = "rbxassetid://10716032262",
	["AmbushMoving"]    = "rbxassetid://10110576663",
	["A60"]             = "rbxassetid://12571092295",
	["A120"]            = "rbxassetid://12711591665",
	["BackdoorRush"]    = "rbxassetid://16602023490",
	["Eyes"]            = "rbxassetid://10183704772",
	["Lookman"]         = "rbxassetid://10183704772",
	["BackdoorLookman"] = "rbxassetid://16764872677",
	["GloombatSwarm"]   = "rbxassetid://79221203116470",
	["Halt"]            = "rbxassetid://11331795398",
	["JeffTheKiller"]   = "rbxassetid://94479432156278",
	["GlitchRush"]      = "rbxassetid://73859273102919",
	["GlitchAmbush"]    = "rbxassetid://88369678433359",
	["SallyMoving"]     = "rbxassetid://10840888070",
	["MonumentEntity"]  = "rbxassetid://88933556873017",
	["Groundskeeper"]   = "rbxassetid://114991380115557"
}

local ItemNames = {
	["DinkyLamp"]         = "Lamp",
	["BottleCrate"]       = "18+ Bottles",
	["GweenSodaPack"]     = "Gween Soda Pack",
	["BrokenMonitor"]     = "Broken Monitor",
	["JerryCan"]          = "Jerry Can",
 	["SallyToyObtain"]    = "Sally Toy",
	["Leftovers"]         = "Lunch Box",
	["HoneyPot"]          = "Honey Pot",
	["FihFlakes"]         = "Fih Food",
	["SecretCD"]          = "CD Disc",
	["Pizza"]             = "Pizza",
	["PaperPlanePickup"]  = "Paper Plane",
	["Lighter"]           = "Lighter",
	["Flashlight"]        = "Flashlight",
	["Lockpick"]          = "Lockpicks",
	["Vitamins"]          = "Vitamins",
	["Bandage"]           = "Bandage",
	["StarVial"]          = "Starlight Vial",
	["StarBottle"]        = "Starlight Bottle",
	["StarJug"]           = "Starlight Barrel",
	["Shakelight"]        = "Gummy Flashlight",
	["Straplight"]        = "Straplight",
	["Bulklight"]         = "Spotlight",
	["Battery"]           = "Battery",
	["Candle"]            = "Candle",
	["Crucifix"]          = "Crucifix",
	["CrucifixWall"]      = "Crucifix",
	["Glowsticks"]        = "Glowstick",
	["SkeletonKey"]       = "Skeleton Key",
	["Candy"]             = "Candy",
	["ShieldMini"]        = "Mini Shield Potion",
	["ShieldBig"]         = "Big Shield Potion",
	["BandagePack"]       = "Bandage Pack",
	["BatteryPack"]       = "Battery Pack",
	["RiftCandle"]        = "Moonlight Candle",
	["LaserPointer"]      = "Laser Pointer",
	["HolyGrenade"]       = "Holy Hand Grenade",
	["Shears"]            = "Shears",
	["Smoothie"]          = "Smoothie",
	["Cheese"]            = "Cheese",
	["Bread"]             = "Bread",
	["AlarmClock"]        = "Alarm Clock",
	["RiftSmoothie"]      = "Moonlight Smoothie",
	["GweenSoda"]         = "Gween Soda",
	["GlitchCube"]        = "Glitch Fragment",
	["Scanner"]           = "Tablet",
	["Bomb"]              = "Bomb",
	["Knockbomb"]         = "Knockbomb",
	["Nanner"]            = "Nanner",
	["BigBomb"]           = "Big Bomb",
	["SnakeBox"]          = "Hiding Box",
	["GoldGun"]           = "Golden Gun",
	["StopSign"]          = "Stop Sign",
	["TipJar"]            = "Tip Jar",
	["Lantern"]           = "Lantern",
	["IronKey"]           = "Iron Key",
	["LotusPetal"]        = "Lotus Petal",
	["Compass"]           = "Compass",
	["LotusPetalPickup"]  = "Lotus Petal",
	["LanternLitItem"]    = "Lantern",
	["KeyIron"]           = "Iron Key",
	["IronKeyForCrypt"]   = "Iron Key",
	["LotusHolder"]       = "Lotus Petal",
	["Multitool"]         = "Multitool",
	["RiftJar"]           = "Rift Jar",
	["AloeVera"]          = "Aloe Vera",
	["Donut"]             = "Donut",
	["Lotus"]             = "Lotus",
	["BoxingGloves"]      = "Boxing Gloves"
}

local CutsceneNames = {
    "Figure",
    "FigureEnd",
    "FigureHotelEnd",
    "FigureHotelFire",
    "SeekIntroFools",
    "SeekIntroHotel",
    "SeekIntroMines",
    "SeekIntroMines2",
    "SerewSeekDrain",
    "SewerSeekLower",
    "GrumbleNestEnd",
    "EyestalkIntro",
}

local Character
local Humanoid
local RootPart

local Collision
local CollisionClone
local CollisionPart
local CollisionPartClone

local Camera
local LocalPlayer = Services.Players.LocalPlayer

local RemotesFolder   = Services.ReplicatedStorage:FindFirstChild("RemotesFolder")
local LiveModifiers   = Services.ReplicatedStorage:FindFirstChild("LiveModifiers")
local FloorReplicated = Services.ReplicatedStorage:FindFirstChild("FloorReplicated")
local CurrentRooms    = Services.Workspace:FindFirstChild("CurrentRooms")
local Drops           = Services.Workspace:FindFirstChild("Drops")
local GameData        = Services.ReplicatedStorage:WaitForChild("GameData")
local Floor           = GameData:WaitForChild("Floor").Value
local LatestRoom      = GameData:WaitForChild("LatestRoom")
local FinishedLoadingRoom = GameData:FindFirstChild("FinishedLoadingRoom")
local RunService = game:GetService("RunService")

if FinishedLoadingRoom then
	FinishedLoadingRoom:Destroy()
end

local function GetHiddenContainer()
	if Functions.CheckCompatability({"gethui"}) then
		return Astra.Environment.gethui()
	end
	return Services.CoreGui
end

local NotificationLibrary = {
	LiveNotifications = 0,
	Notifications = 1
}

local Container = Instance.new("ScreenGui")
Container.Name = Astra.ESPLibrary:GenerateRandomString()
Container.Parent = GetHiddenContainer()
Container.DisplayOrder = 32767
Container.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

if not Library.Scheme then
	Library.Scheme = setmetatable({}, {
		__index = function(Self, Name)
			return Library[Name]
		end
	})
end

function NotificationLibrary:Notify(TitleText, Desc, Delay)
	task.spawn(function()
		local Notification = Instance.new("Frame")
		local Line = Instance.new("Frame")
		local Warning = Instance.new("ImageLabel")
		local UICorner = Instance.new("UICorner")
		local UICorner2 = Instance.new("UICorner")
		local Title = Instance.new("TextLabel")
		local Description = Instance.new("TextLabel")

		Notification.Name = "Notification"
		Notification.Parent = Container
		Notification.BackgroundColor3 = Library.Scheme.BackgroundColor
		Notification.BackgroundTransparency = 0.4
		Notification.BorderSizePixel = 0
		Notification.Position = UDim2.new(1, 5, 0, 60 + (60 * NotificationLibrary.LiveNotifications))
		Notification.Size = UDim2.new(0, 420, 0, 50)
		Notification:SetAttribute("ID", NotificationLibrary.Notifications)
		Notification:SetAttribute("CurrentPosition", Notification.Position)

		Line.Name = "Line"
		Line.Parent = Notification
		Line.BackgroundColor3 = Library.Scheme.AccentColor
		Line.BorderSizePixel = 0
		Line.Position = UDim2.new(0, 0, 1, -3)
		Line.Size = UDim2.new(0, 0, 0, 3)

		Warning.Name = "Warning"
		Warning.Parent = Notification
		Warning.BackgroundTransparency = 1
		Warning.Position = UDim2.new(0, 10, 0, 5)
		Warning.Size = UDim2.new(0, 40, 0, 40)
		Warning.Image = "rbxassetid://3944668821"
		Warning.ImageColor3 = Library.Scheme.AccentColor
		Warning.ScaleType = Enum.ScaleType.Fit

		UICorner.CornerRadius = UDim.new(0, 20)
		UICorner.Parent = Warning

		UICorner2.CornerRadius = UDim.new(0, 4)
		UICorner2.Parent = Notification

		Title.Name = "Title"
		Title.Parent = Notification
		Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Title.BackgroundTransparency = 1
		Title.Position = UDim2.new(0, 60, 0.155, 0)
		Title.Size = UDim2.new(0, 205, 0, 15)
		Title.Text = TitleText or "..."
		Title.TextColor3 = Library.Scheme.FontColor
		Title.TextSize = 10
		Title.TextStrokeTransparency = 0.75
		Title.TextXAlignment = Enum.TextXAlignment.Left

		Description.Name = "Description"
		Description.Parent = Notification
		Description.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Description.BackgroundTransparency = 1
		Description.Position = UDim2.new(0, 60, 0.483, 0)
		Description.Size = UDim2.new(0, 205, 0, 18)
		Description.Text = Desc or "..."
		Description.TextColor3 = Library.Scheme.FontColor
		Description.TextTransparency = 0.1
		Description.TextSize = 10
		Description.TextStrokeTransparency = 0.75
		Description.TextXAlignment = Enum.TextXAlignment.Left

		NotificationLibrary.LiveNotifications += 1
		NotificationLibrary.Notifications += 1

		Services.TweenService:Create(
			Notification,
			TweenInfo.new(1, Enum.EasingStyle.Exponential),
			{ Position = UDim2.new(1, -370, 0, Notification.Position.Y.Offset) }
		):Play()

		task.wait(0.25)
		if typeof(Delay) == "Instance" then
			Delay.Destroying:Wait()
		else
			Services.TweenService:Create(
				Line,
				TweenInfo.new(Delay - 0.25, Enum.EasingStyle.Linear),
				{ Size = UDim2.new(0, 400, 0, 3) }
			):Play()
			task.wait(Delay - 0.25)
		end

		Notification:SetAttribute("Destroying", true)

		Services.TweenService:Create(
			Notification,
			TweenInfo.new(0.75, Enum.EasingStyle.Exponential, Enum.EasingDirection.In),
			{ Position = UDim2.new(1, 5, 0, Notification.Position.Y.Offset) }
		):Play()

		NotificationLibrary.LiveNotifications -= 1

		local NotifId = Notification:GetAttribute("ID")
		local NotifY = Notification:GetAttribute("CurrentPosition").Y.Offset

		for _, Object in Container:GetChildren() do
			if Object.Name == "Notification"
				and Object:GetAttribute("ID")
				and Object:GetAttribute("ID") > NotifId
				and Object:GetAttribute("Destroying") ~= true
				and Object.Position.Y.Offset ~= 60
			then
				local NewY = Object:GetAttribute("CurrentPosition").Y.Offset - 60
				Object:SetAttribute("CurrentPosition", UDim2.new(1, -450, 0, NewY))
				Services.TweenService:Create(
					Object,
					TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.InOut),
					{ Position = UDim2.new(1, -370, 0, NewY) }
				):Play()
			end
		end

		task.wait(0.75)
		Notification:Destroy()
	end)
end

Globals.DoorsNotify = function(NotifyOptions)
	local function PlaySound(Parent, SoundId, Volume)
		local Sound = Instance.new("Sound")
		Sound.SoundId = SoundId
		Sound.Volume = Volume or 1
		Sound.Parent = Parent
		task.spawn(function()
			task.wait(0.1)
			Sound:Play()
			Sound.Ended:Wait()
			Sound:Destroy()
		end)
	end

	local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
	local UIContainer = PlayerGui:FindFirstChild("GlobalUI") or PlayerGui:FindFirstChild("MainUI")
	if not UIContainer then return end

	local AchievementsHolder = UIContainer:FindFirstChild("AchievementsHolder")
	if not AchievementsHolder then return end

	local Achievement = AchievementsHolder.Achievement:Clone()
	Achievement.Size = UDim2.new(0, 0, 0, 0)
	Achievement.Frame.Position = UDim2.new(1.1, 0, 0, 0)
	Achievement.Name = "LiveAchievement"
	Achievement.Visible = true

	Achievement.Frame.TextLabel.Text = NotifyOptions.Style or "NOTIFICATION"
	Achievement.Frame.Details.Title.Text = NotifyOptions.Title or "Sem Título"
	Achievement.Frame.Details.Desc.Text = NotifyOptions.Description or "Sem Descrição"
	Achievement.Frame.Details.Reason.Text = NotifyOptions.Reason or ""
	Achievement.Frame.ImageLabel.Image = (NotifyOptions.Image ~= "" and NotifyOptions.Image) or "rbxassetid://6023426923"

	local Color = NotifyOptions.Color or Color3.new(1, 1, 1)
	Achievement.Frame.TextLabel.TextColor3 = Color
	Achievement.Frame.UIStroke.Color = Color
	Achievement.Frame.Glow.ImageColor3 = Color
	Achievement.Parent = AchievementsHolder

	PlaySound(AchievementsHolder, "rbxassetid://10469938989", 1)

	task.spawn(function()
		Achievement:TweenSize(UDim2.new(1, 0, 0.2, 0), "In", "Quad", 0.8, true)
		task.wait(0.8)
		Achievement.Frame:TweenPosition(UDim2.new(0, 0, 0, 0), "Out", "Quad", 0.5, true)
		Services.TweenService:Create(
			Achievement.Frame.Glow,
			TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
			{ ImageTransparency = 1 }
		):Play()

		if typeof(NotifyOptions.Time) == "Instance" then
			NotifyOptions.Time.Destroying:Wait()
		else
			task.wait(NotifyOptions.Time or 5)
		end

		Achievement.Frame:TweenPosition(UDim2.new(1.1, 0, 0, 0), "In", "Quad", 0.5, true)
		task.wait(0.5)
		Achievement:TweenSize(UDim2.new(1, 0, -0.1, 0), "InOut", "Quad", 0.5, true)
		task.wait(0.5)
		Achievement:Destroy()
	end)
end

Globals.STX = loadstring(game:HttpGet("https://raw.githubusercontent.com/bocaj111004/Astra/refs/heads/main/Components/STX.luau"))()
Functions.Notify = function(Settings)
	local HiddenContainer = GetHiddenContainer()

	if not Settings.Body then
		Settings.Body = "..."
	end

	if not Options.NotifyStyle or Options.NotifyStyle.Value == "Astra Hub" then
		local Sound = Instance.new("Sound", HiddenContainer)
		Sound.SoundId = "rbxassetid://8784885431"
		Sound.Volume = (Toggles.NotifyPlaySound and Toggles.NotifyPlaySound.Value and Options.NotifySoundVolume.Value) or (Toggles.NotifyPlaySound and 0 or 3)
		Sound.PlayOnRemove = true
		Sound:Destroy()
		NotificationLibrary:Notify(Settings.Title, Settings.Body, Settings.Time or 5)
	elseif Options.NotifyStyle.Value == "Doors" then
		local IsEntity = false
		local EntityName = ""
		for Index, Object in pairs(Entities) do
			if Object.NotifyMessage.Title == Settings.Title or Object.NotifyMessage.Body == Settings.Body then
				IsEntity = true
				EntityName = Index
			end
		end
		Globals.DoorsNotify({
			Title = "Astra Hub",
			Description = Settings.Title,
			Reason = Settings.Body,
			Style = IsEntity and "WARNING" or "NOTIFICATION",
			Color = IsEntity and Color3.fromRGB(255, 0, 0) or Color3.fromRGB(255, 222, 189),
			Image = Settings.Image,
			Time = Settings.Time
		})
	elseif Options.NotifyStyle.Value == "STX" then
		local Sound = Instance.new("Sound", HiddenContainer)
		Sound.SoundId = "rbxassetid://4590657391"
		Sound.Volume = (Toggles.NotifyPlaySound and Toggles.NotifyPlaySound.Value and Options.NotifySoundVolume.Value) or (Toggles.NotifyPlaySound and 0 or 3)
		Sound.PlayOnRemove = true
		Sound:Destroy()

		if Settings.Image then
			Globals.STX:Notify(
				{Title = "Astra Hub", Description = Settings.Title .. "\n" .. Settings.Body},
				{OutlineColor = Library.Scheme.AccentColor,Time = Settings.Time or 5, Type = "image"},
				{Image = Settings.Image, ImageColor = Color3.fromRGB(255, 255, 255)}
			)
		else
			Globals.STX:Notify(
				{Title = "Astra Hub", Description = Settings.Title .. "\n" .. Settings.Body},
				{OutlineColor = Library.Scheme.AccentColor,Time = Settings.Time or 5, Type = "default"}
			)
		end
	else
		local Sound = Instance.new("Sound", HiddenContainer)
		Sound.SoundId = "rbxassetid://4590662766"
		Sound.Volume = (Toggles.NotifyPlaySound and Toggles.NotifyPlaySound.Value and Options.NotifySoundVolume.Value) or (Toggles.NotifyPlaySound and 0 or 3)
		Sound.PlayOnRemove = true
		Sound:Destroy()
		Library:OldNotify({ Title = Settings.Title, Description = Settings.Body, Time = Settings.Time })
	end
end

Functions.Caption = function(Text, PlaySound)
	if typeof(PlaySound) ~= "boolean" then
		PlaySound = true
	end
	local CaptionValue = Instance.new("NumberValue")
	local Caption = Globals.MainUI:WaitForChild("MainFrame"):WaitForChild("Caption"):Clone()
	local CaptionSound = Globals.MainUI:WaitForChild("Initiator"):WaitForChild("Main_Game"):WaitForChild("Reminder"):WaitForChild("Caption")
	local CaptionSoundClone = CaptionSound:Clone()
	CaptionSoundClone.Parent = CaptionSound.Parent
	CaptionSoundClone.Volume = 0.1

	Caption.Destroying:Connect(function()
		CaptionValue:Destroy()
	end)

	for _, Child in Globals.MainUI:GetChildren() do
		if Child.Name == "LiveCaption" then
			Child:Destroy()
		end
	end

	Caption.Parent = Globals.MainUI
	Caption.Visible = true
	Caption.Name = "LiveCaption"
	Caption.Text = Text

	if PlaySound then
		CaptionSoundClone:Play()
	end

	Services.Debris:AddItem(CaptionSoundClone, 5)

	local HolderTween = Services.TweenService:Create(CaptionValue, TweenInfo.new(3), { Value = 100 })
	HolderTween:Play()
	HolderTween.Completed:Connect(function()
		CaptionValue:Destroy()
		Services.TweenService:Create(Caption, TweenInfo.new(4, Enum.EasingStyle.Linear), { TextTransparency = 1 }):Play()
		Services.TweenService:Create(Caption, TweenInfo.new(4, Enum.EasingStyle.Linear), { TextStrokeTransparency = 1 }):Play()
	end)
end

Functions.GetHasteTime = function()
	local TimeRemaining = FloorReplicated.DigitalTimer.Value
	local Minutes = math.floor(TimeRemaining / 60)
	local Seconds = TimeRemaining - (Minutes * 60)
	local MinutesText = Minutes < 10 and ("0" .. tostring(Minutes)) or tostring(Minutes)
	local SecondsText = Seconds < 10 and ("0" .. tostring(Seconds)) or tostring(Seconds)
	return MinutesText .. ":" .. SecondsText
end

Library.OldNotify = Library.Notify
Library.Notify = function(Data, Body, Time)
	Functions.Notify({ Title = Body, Time = Time or 5 })
end

if not LocalPlayer.Character or not CurrentRooms:FindFirstChildOfClass("Model") then
	Functions.Notify({ Title = "Waiting for the game to load..." })
	queue_on_teleport([[loadstring(game:HttpGet("https://raw.githubusercontent.com/therealcookiemonsterof1966/AstraHub/main/Games/Doors/Main.luau"))()]])
	while not LocalPlayer.Character or not CurrentRooms:FindFirstChildOfClass("Model") do
		task.wait()
	end
	task.wait(4)
end

if not RemotesFolder then
	if Services.ReplicatedStorage:FindFirstChild("EntityInfo") then
		RemotesFolder = Services.ReplicatedStorage:FindFirstChild("EntityInfo")
	elseif Services.ReplicatedStorage:FindFirstChild("Bricks") then
		RemotesFolder = Services.ReplicatedStorage:FindFirstChild("Bricks")
	end
end

if Floor == "Hotel" and RemotesFolder.Name == "Bricks" then
	Floor = "OldHotel"
end

if not LiveModifiers then
	LiveModifiers = Instance.new("Folder")
end

if not FloorReplicated then
	FloorReplicated = Instance.new("Folder")
end

local FakeEvents = {
	Screech = Instance.new("RemoteEvent"),
	Shade   = Instance.new("RemoteEvent"),
	A90     = Instance.new("RemoteEvent"),
	Surge   = Instance.new("RemoteEvent"),
}

FakeEvents.Screech.Name  = "Screech"
FakeEvents.Shade.Name    = "ShadeResult"
FakeEvents.A90.Name      = "A90"
FakeEvents.Surge.Name    = "SurgeRemote"

FakeEvents.Screech_Real = RemotesFolder:WaitForChild("Screech")
FakeEvents.Shade_Real   = RemotesFolder:WaitForChild("ShadeResult")
FakeEvents.A90_Real     = RemotesFolder:FindFirstChild("A90")
FakeEvents.Surge_Real   = RemotesFolder:FindFirstChild("SurgeRemote")

if RemotesFolder:FindFirstChild("FootstepRemoteThatWeNeed") then
    local RealRemote = RemotesFolder:FindFirstChild("FootstepRemoteThatWeNeed")
    RealRemote:Destroy()

    local FakeRemote = Instance.new("RemoteEvent", RemotesFolder)
    FakeRemote.Name = "FootstepRemoteThatWeNeed"
end

Globals.FogInstances = {}
Globals.OldFog = Services.Lighting.FogEnd

for _, Object in Services.Lighting:GetChildren() do
	if Object:IsA("Atmosphere") then
		Object:SetAttribute("Density_Old", Object.Density)

		local AtmoConnection = Object:GetPropertyChangedSignal("Density"):Connect(function()
			if Object.Density ~= 0 then
				Object:SetAttribute("Density_Old", Object.Density)
			end
			if Toggles.RemoveCameraFog.Value then
				Object.Density = 0
			end
		end)

		Object.Destroying:Once(function()
			AtmoConnection:Disconnect()
		end)

		table.insert(Connections, AtmoConnection)
		table.insert(Globals.FogInstances, Object)
	end
end

Globals.SeekNodesFolder = Instance.new("Folder", Services.Workspace)
Globals.SeekNodesFolder.Name = Astra.ESPLibrary:GenerateRandomString()

Globals.RoomsNodesFolder = Instance.new("Folder", Services.Workspace)
Globals.RoomsNodesFolder.Name = Astra.ESPLibrary:GenerateRandomString()

Functions.SendChat = function(Message)
	local Folder = Services.ReplicatedStorage:FindFirstChild("DefaultChatSystemEvents") or Instance.new("Folder")
	local Event = Folder:FindFirstChild("SayMessageRequest") or Instance.new("RemoteEvent")
	Event:FireServer(Message, "All")
	local Channel = (Services.TextChatService:FindFirstChild("TextChannels") and Services.TextChatService.TextChannels:FindFirstChild("RBXGeneral")) or Instance.new("TextChannel")
	Channel:SendAsync(Message)
end

Functions.IsCrouching = function()
	if Floor == "Fools" or Floor == "OldHotel" then
		return Character:GetAttribute("Crouching")
	end
	return CollisionPart.CollisionGroup == "PlayerCrouching"
end

Functions.GetInjuriesSpeed = function()
	return 0.075 * (Humanoid.MaxHealth - Humanoid.Health)
end

Functions.GetCurrentSpeed = function()
	local Speed = 15
	Speed += Character:GetAttribute("SpeedBoost") or 0
	Speed += Character:GetAttribute("SpeedBoostBehind") or 0
	Speed += Character:GetAttribute("SpeedBoostExtra") or 0
	Speed += (Floor == "Party" and 10 or 0)
	Speed += (LiveModifiers:FindFirstChild("PlayerFast") and 3 or 0)
	Speed += (LiveModifiers:FindFirstChild("PlayerFaster") and 6 or 0)
	Speed += (LiveModifiers:FindFirstChild("PlayerFastest") and 20 or 0)
	Speed -= (LiveModifiers:FindFirstChild("PlayerSlow") and 3 or 0)
	Speed -= (LiveModifiers:FindFirstChild("PlayerSlowHealth") and Functions.GetInjuriesSpeed() or 0)
	if Functions.IsCrouching() then
		if LiveModifiers:FindFirstChild("PlayerCrouchSlow") then
			Speed -= 8
		elseif LiveModifiers:FindFirstChild("PlayerSlow") then
			Speed -= 8
		else
			Speed -= 5
		end
	end
	return Speed
end

Functions.GetMousePosition = function()
	if Library.IsMobile then
		return Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
	end
	local MouseLocation = Services.UserInputService:GetMouseLocation()
	return Vector2.new(MouseLocation.X, MouseLocation.Y)
end

Functions.FormatOxygen = function(Oxygen)
	return "Oxygen: " .. (math.floor(Oxygen * 10) / 10) .. "%"
end

Functions.IsHidePersistent = function()
	return Floor == "Mines"
		or Floor == "Ripple"
		or Floor == "Party"
		or LiveModifiers:FindFirstChild("HideLevel2") ~= nil
end

Functions.GetPlayerFromMouse = function(TargetPart, MaxDistance)
	local Closest
	local ClosestDistance = math.huge

	for _, Player in Services.Players:GetPlayers() do
		local Char = Player.Character
		if Char then
			local Target = Char:FindFirstChild(TargetPart)
			if Target then
				local Result = Camera:WorldToViewportPoint(Target.Position)
				local ScreenPos = Vector2.new(Result.X, Result.Y)
				local Distance = (Functions.GetMousePosition() - ScreenPos).Magnitude
				if Player.Name ~= LocalPlayer.Name and Distance < ClosestDistance and Distance < MaxDistance then
					Closest = Target
					ClosestDistance = Distance
				end
			end
		end
	end
	return Closest
end

local EntityDistances = {
	["RushMoving"]    = 85,
	["Scribbles"]	  = 100,
	["BashMoving"]    = 150,
	["DronesStampede"] = 100,
	["AmbushMoving"]  = 150,
	["A60"]           = 125,
	["A120"]          = 85,
	["GlitchRush"]    = 90,
	["GlitchAmbush"]  = 175,
	["BackdoorRush"]  = 85,
	["CustomEntity"]  = 85,
}

Functions.GetNearestEntity = function(CheckDisabled, List, UseRaycasting)
	local Nearest = { Distance = math.huge, Object = nil }

	for _, Entity in Objects.Entities do
		if not Entity or not Entity:IsA("Model") or not Entity:IsDescendantOf(Services.Workspace) then continue end
		if not EntityDistances[Entity.Name] or not Entity.PrimaryPart then continue end

		local EntityData = Entities[Entity.Name]
		if not EntityData then continue end
		if List and List[EntityData.Alias] then continue end

		local Distance = LocalPlayer:DistanceFromCharacter(Entity.PrimaryPart.Position)
		if Distance < EntityDistances[Entity.Name] and Distance < Nearest.Distance then
			if not CheckDisabled or Entity:GetAttribute("Inactive") ~= true then
				Nearest.Distance = Distance
				Nearest.Object = Entity
			end
		end
	end
	return Nearest.Object
end

Functions.GetNearestFigure = function()
	local Nearest = { Distance = math.huge, Object = nil }
	local FigureNames = { FigureRig = true, FigureRagdoll = true, Figure = true }

	for _, Object in Objects.Entities do
		if Object:IsA("Model") and Object.PrimaryPart and FigureNames[Object.Name] then
			local Distance = LocalPlayer:DistanceFromCharacter(Object.PrimaryPart.Position)
			if Distance < Nearest.Distance and Distance < 25 then
				Nearest.Distance = Distance
				Nearest.Object = Object
			end
		end
	end
	return Nearest.Object
end

Functions.GetNearestHidingSpot = function()
	local Nearest = { Distance = math.huge, Object = nil }
	local LastHideSpot = Character:FindFirstChild("LastHideSpot")

	local function IsHidingSpotName(Name)
		if typeof(Name) ~= "string" then return false end
		return string.find(string.lower(Name), "hidingspot") or string.find(string.lower(Name), "hiding_spot")
	end

	local function GetHidePrompt(Object)
	if not Object then return nil end

	local Prompt = Object:FindFirstChild("HidePrompt") or Object:FindFirstChild("HidingPrompt")
	if Prompt then return Prompt end

	for _, Child in Object:GetDescendants() do
		if (Child:IsA("ProximityPrompt") or Child:IsA("InteractPrompt"))
			and (Child.Name == "HidePrompt" or Child.Name == "HidingPrompt" or IsHidingSpotName(Child.Name))
		then
			return Child
		end
	end

	if IsHidingSpotName(Object.Name) or IsHidingSpotName(Object.Parent and Object.Parent.Name) then
		return Object:FindFirstChild("HidePrompt") or Object:FindFirstChild("HidingPrompt")
	end

	return nil
	end

	local function TryObject(Object)
		if not Object or not Object:IsDescendantOf(Services.Workspace) then return end
		if not Object.PrimaryPart and not Object:FindFirstChildOfClass("BasePart") then return end
		local Prompt = GetHidePrompt(Object)
		if not Prompt then return end
		local PrimaryPart = Object.PrimaryPart or Object:FindFirstChildOfClass("BasePart")
		if not PrimaryPart then return end
		local Distance = LocalPlayer:DistanceFromCharacter(PrimaryPart.Position)
		if Distance < Prompt.MaxActivationDistance and Distance < Nearest.Distance then
			local Persistent = Functions.IsHidePersistent()
			if not Persistent or (LastHideSpot and LastHideSpot.Value ~= Object) or not LastHideSpot then
				Nearest.Distance = Distance
				Nearest.Object = Object
			end
		end
	end

	for _, Object in Objects.HidingSpots do
		TryObject(Object)
	end

	return Nearest.Object
end

Functions.GetNearestTurnNode = function()
	local Nearest = { Distance = math.huge, Object = nil }

	for _, Node in Objects.SeekNodes do
		local Distance = LocalPlayer:DistanceFromCharacter(Node.Position)
		if Distance < Options.AutoSteerMinecartTurnDistance.Value and Distance < Nearest.Distance then
			Nearest.Distance = Distance
			Nearest.Object = Node
		end
	end
	return Nearest.Object
end

Functions.GetNearestDuckBoard = function()
	local Nearest = { Distance = math.huge, Object = nil }

	for _, Board in Objects.SeekDuckBoards do
		if Board.PrimaryPart then
			local Distance = LocalPlayer:DistanceFromCharacter(Board.PrimaryPart.Position)
			if Distance < Options.AutoSteerMinecartDuckDistance.Value and Distance < Nearest.Distance then
				Nearest.Distance = Distance
				Nearest.Object = Board
			end
		end
	end
	return Nearest.Object
end

Functions.GetCurrentAnchor = function()
	local AnchorCode = Globals.MainUI.AnchorHintFrame.AnchorCode.Text
	for _, Anchor in Objects.Objectives do
		if Anchor.Name == "MinesAnchor" and Anchor:FindFirstChild("Sign") then
			if Anchor.Sign.TextLabel.Text == AnchorCode then
				return Anchor
			end
		end
	end
end

Functions.GetMinecart = function()
	return Camera:FindFirstChild("MinecartRig") ~= nil
end

Functions.HasItem = function(Name, OnlyCharacter)
	if not OnlyCharacter and LocalPlayer.Backpack:FindFirstChild(Name) then
		return LocalPlayer.Backpack:FindFirstChild(Name)
	elseif Character:FindFirstChild(Name) then
		return Character:FindFirstChild(Name)
	end
end

Functions.GetFlyVelocity = function()
	if Humanoid.MoveDirection == Vector3.zero then
		return Humanoid.MoveDirection
	end
	local LookFlat = Vector3.new(Camera.CFrame.LookVector.X, 0, Camera.CFrame.LookVector.Z)
	local FlatFrame = CFrame.new(Camera.CFrame.Position, Camera.CFrame.Position + LookFlat)
	local Velocity = (Camera.CFrame * CFrame.new(FlatFrame:VectorToObjectSpace(Humanoid.MoveDirection))).Position - Camera.CFrame.Position
	if Velocity == Vector3.zero then
		return Velocity
	end
	return Velocity.Unit
end

Globals.PromptContainer = Instance.new("Folder")
Globals.PromptContainer.Name = "PromptContainer"
Globals.PromptContainer.Parent = GetHiddenContainer()

local ESPBlacklist = {}

Functions.AddESP = function(ESPOptions, RoomBased)
	local Object = ESPOptions.Object

	if table.find(ESPBlacklist, Object) then
		return
	end

	if RoomBased then
		local CurrentRoom = tonumber(LocalPlayer:GetAttribute("CurrentRoom"))
		local ObjectRoom = tonumber(Object:GetAttribute("ParentRoom"))

		if ObjectRoom == CurrentRoom or (table.find(Objects.Doors, Object) and ObjectRoom == CurrentRoom + 1) then
			Astra.ESPLibrary:AddESP(ESPOptions)
		end

		local RoomConnection = LocalPlayer:GetAttributeChangedSignal("CurrentRoom"):Connect(function()
			if Astra.ESPLibrary.ColorTable[Object] then
				ESPOptions.Color = Astra.ESPLibrary.ColorTable[Object]
			end

			local NewCurrentRoom = tonumber(LocalPlayer:GetAttribute("CurrentRoom"))
			local ObjRoom = tonumber(Object:GetAttribute("ParentRoom"))

			if ObjRoom == NewCurrentRoom or (table.find(Objects.Doors, Object) and ObjRoom == NewCurrentRoom + 1) then
				Astra.ESPLibrary:AddESP(ESPOptions)
			else
				Astra.ESPLibrary:RemoveESP(Object)
			end
		end)

		table.insert(Connections, RoomConnection)
		ESPConnections[Object] = RoomConnection

		Object.Destroying:Once(function()
			RoomConnection:Disconnect()
			if Astra then
				Astra.ESPLibrary:RemoveESP(Object)
			end
			local Pos = table.find(Connections, RoomConnection)
			if Pos then table.remove(Connections, Pos) end
		end)
	else
		Astra.ESPLibrary:AddESP(ESPOptions)
	end
end

Functions.RemoveESP = function(Object)
	local Conn = ESPConnections[Object]
	if Conn then
		Conn:Disconnect()
		ESPConnections[Object] = nil
		local Pos = table.find(Connections, Conn)
		if Pos then table.remove(Connections, Pos) end
	end
	Astra.ESPLibrary:RemoveESP(Object)
end

Functions.BlacklistESP = function(Object)
	table.insert(ESPBlacklist, Object)
end

Functions.GetDoorNumber = function(Object)
	local DoorNumber = tonumber(Object.Parent.Name) or tonumber(Object.Parent.Parent.Name)
	if DoorNumber then
		DoorNumber = DoorNumber + 1
	end
	if Floor == "Mines" then
		DoorNumber = DoorNumber + 100
	end
	if Floor == "Backdoor" then
		DoorNumber = DoorNumber - 50
	end

	return tostring(DoorNumber)
end

Functions.GetLibraryCode = function()
	local Paper = Character:FindFirstChild("LibraryHintPaper")
		or Character:FindFirstChild("LibraryHintPaperHard")
		or LocalPlayer.Backpack:FindFirstChild("LibraryHintPaper")
		or LocalPlayer.Backpack:FindFirstChild("LibraryHintPaperHard")

	if Paper and Paper:FindFirstChild("UI") then
		local Code = {}
		local CodeLength = Floor == "Fools" and 10 or 5
		for I = 1, CodeLength do Code[I] = "_" end

		local HintChildren = LocalPlayer.PlayerGui.PermUI.Hints:GetChildren()
		local UIChildren = Paper.UI:GetChildren()

		for _, Hint in HintChildren do
			for _, UIChild in UIChildren do
				if Hint:IsA("ImageLabel") and UIChild:IsA("ImageLabel")
					and Hint.ImageRectOffset == UIChild.ImageRectOffset
					and Code[tonumber(UIChild.Name)]
				then
					Code[tonumber(UIChild.Name)] = Hint.TextLabel.Text
				end
			end
		end
		return table.concat(Code)
	end
	return Floor == "Fools" and "__________" or "_____"
end

Globals.UsedRandomCodes = {}
Functions.GetRandomCode = function()
    local CodeTemplate = Functions.GetLibraryCode()
    if not CodeTemplate then
        return nil
    end

    local NewCode
    local Tries = 0
    repeat
        NewCode = CodeTemplate:gsub("_", function()
            return tostring(math.random(0, 9))
        end)
        Tries = Tries + 1
    until not Globals.UsedRandomCodes[NewCode] or Tries >= 10

    Globals.UsedRandomCodes[NewCode] = true
    return NewCode
end

-- Перероблено вікно на Astra Hub Edition та налаштовано космічну блакитну тему
local Window = Library:CreateWindow({
	Title = "Astra Hub",
	Footer = "Astra Hub Edition",[cite: 1]
	NotifySide = "Right",
	ShowCustomCursor = false,
	AutoShow = true,
	Center = true,
	TabPadding = 3,
	MenuFadeTime = 0,
	CornerRadius = 6,
})

-- Космічна та блакитна тема для UI та кнопок Toggle / Lock
if Library.Scheme then
    Library.Scheme.BackgroundColor = Color3.fromRGB(10, 15, 30)
    Library.Scheme.MainColor = Color3.fromRGB(15, 20, 40)
    Library.Scheme.AccentColor = Color3.fromRGB(0, 190, 255)
    Library.Scheme.OutlineColor = Color3.fromRGB(30, 40, 70)
    Library.Scheme.FontColor = Color3.fromRGB(240, 248, 255)
end
if ThemeManager then
    ThemeManager:SetCustomTheme({
        BackgroundColor = Color3.fromRGB(10, 15, 30),
        MainColor = Color3.fromRGB(15, 20, 40),
        AccentColor = Color3.fromRGB(0, 190, 255),
        OutlineColor = Color3.fromRGB(30, 40, 70),
        FontColor = Color3.fromRGB(240, 248, 255)
    })
end

-- Видалено виклик Astra.Interface.ApplyInfoTab(Window), який генерував Info, Changelog, Credits, Community[cite: 1]

local Tabs = {
	General  = Window:AddTab("General", "house"),
	Exploits = Window:AddTab("Exploits", "shield"),
	Visuals  = Window:AddTab("Visuals", "eye"),
	Floors   = Window:AddTab("Floors", "earth"),
	Archives  = Window:AddTab("New - Archives", "rbxassetid://104508835882225"),
	Stairwell = Window:AddTab("New - Stairwell", "rbxassetid://80017304328364"),
}

Groupboxes.General_Character = Tabs.General:AddLeftGroupbox("Character")
Groupboxes.General_Character:AddSlider("SpeedBoostSlider", {
	Text = "Speed Boost", Min = 0, Max = 100, Default = 0, Rounding = 0, Compact = true
})
Groupboxes.General_Character:AddToggle("SpeedBoostToggle", {
	Text = "Enable Speed Boost", Default = false, Tooltip = "Increases your walkspeed by the specified amount."
})
Groupboxes.General_Character:AddToggle("FlyToggle", {
	Text = "Fly", Default = false, Tooltip = "Allows you to freely fly around the map."
})
Toggles.FlyToggle:AddKeyPicker("FlyKeybind", {
	Text = "Fly", Default = "F", Mode = "Toggle", SyncToggleState = true
})
Groupboxes.General_Character:AddSlider("FlySpeed", {
	Text = "Fly Speed", Min = 0, Max = 115, Default = 20, Rounding = 0, Compact = true
})
Groupboxes.General_Character:AddDivider()
Groupboxes.General_Character:AddToggle("NoclipToggle", {
	Text = "Noclip", Default = false, Tooltip = "Allows your character to pass through solid objects."
})
Groupboxes.General_Character:AddToggle("RemoveClosetDelay", {
	Text = "Remove Closet Delay", Default = false,
	Tooltip = "Removes the short window where you can't exit out of a closet after the animation finishes."
})
Groupboxes.General_Character:AddToggle("RemoveAcceleration", {
	Text = "Remove Acceleration", Default = false, Tooltip = "Prevents your character from sliding while moving."
})

local CustomPhysics

Options.SpeedBoostSlider:OnChanged(function(Value)
	if RemotesFolder:FindFirstChild("Crouch") then
		RemotesFolder.Crouch:FireServer(Value and true or Functions.IsCrouching(), true)
	end
end)

Toggles.NoclipToggle:AddKeyPicker("NoclipKeybind", {
	Text = "Noclip", Default = "N", Mode = "Toggle", SyncToggleState = true
})
Toggles.RemoveAcceleration:OnChanged(function(Value)
	for Index, Old in PartProperties do
		Index.CustomPhysicalProperties = Value and CustomPhysics or Old
	end
end)

Groupboxes.General_Character:AddDivider()
Groupboxes.General_Character:AddToggle("EnableCharacterJump", {
	Text = "Enable Jumping", Default = false, Tooltip = "Allows your character to jump."
})
Groupboxes.General_Character:AddToggle("EnableCharacterSlide", {
	Text = "Enable Sliding", Default = false, Tooltip = "Allows your character to slide."
})
Groupboxes.General_Character:AddToggle("InfiniteJumps", {
	Text = "Infinite Jumps", Default = false, Tooltip = "Allows you to jump while in the air."
})

local OldJump = false
local OldSlide = false

Toggles.SpeedBoostToggle:OnChanged(function(Value)
	if Humanoid then
		Humanoid.WalkSpeed = Functions.GetCurrentSpeed() + (Value and Options.SpeedBoostSlider.Value or 0)
	end
end)
Toggles.EnableCharacterJump:OnChanged(function(Value)
	if Character then
		Character:SetAttribute("CanJump", Value and true or OldJump)
	end
end)
Toggles.EnableCharacterSlide:OnChanged(function(Value)
	if Character then
		Character:SetAttribute("CanSlide", Value and true or OldSlide)
	end
end)

Groupboxes.General_Self = Tabs.General:AddLeftGroupbox("Self")
Groupboxes.General_Self:AddToggle("DoorReachToggle", {
	Text = "Door Reach", Default = false, Tooltip = "Allows you to open doors from further away."
})
Groupboxes.General_Self:AddToggle("DisableIdleKick", {
	Text = "Disable Idle Kick", Default = false, Tooltip = "Prevents the kick from being idle for 20 minutes."
})
Toggles.DisableIdleKick:OnChanged(function(Value)
	if Functions.CheckCompatability({"getconnections"}) then
		for _, Conn in Astra.Environment.getconnections(LocalPlayer.Idled) do
			if Value then Conn:Disable() else Conn:Enable() end
		end
	end
end)
LocalPlayer.Idled:Connect(function()
	if Toggles.DisableIdleKick.Value then
		Services.VirtualUser:CaptureController()
		Services.VirtualUser:ClickButton2(Vector2.new())
	end
end)

Groupboxes.General_Self:AddDivider()
Groupboxes.General_Self:AddSlider("PromptReachSlider", {
	Text = "Prompt Reach Multiplier", Min = 1, Max = 2, Default = 1, Rounding = 1, Compact = true
})
Groupboxes.General_Self:AddToggle("InstantPrompts", {
	Text = "Instant Prompts", Default = false, Tooltip = "Allows you to trigger all prompts instantly."
})
Groupboxes.General_Self:AddToggle("PromptClip", {
	Text = "Prompt Clip", Default = false, Tooltip = "Allows you to interact with prompts through walls."
})

Options.PromptReachSlider:OnChanged(function(Value)
	for _, Prompt in Objects.Prompts do
		Prompt.MaxActivationDistance = Prompt:GetAttribute("MaxActivationDistance_Old") * Value
	end
end)
Toggles.InstantPrompts:OnChanged(function(Value)
	for _, Prompt in Objects.Prompts do
		Prompt.HoldDuration = Value and 0 or Prompt:GetAttribute("HoldDuration_Old")
	end
end)
Toggles.PromptClip:OnChanged(function(Value)
	for _, Prompt in Objects.Prompts do
		Prompt.RequiresLineOfSight = Value and false or Prompt:GetAttribute("RequiresLineOfSight_Old")
	end
end)

Groupboxes.Self_Automation = Tabs.General:AddRightGroupbox("Automation")
Groupboxes.Self_Automation:AddToggle("AutoBreakerBox", {
	Text = "Auto Breaker Box", Default = false, Tooltip = "Automatically solves the breaker box."
})
Groupboxes.Self_Automation:AddToggle("AutoSolveAnchors", {
	Text = "Auto Solve Anchors", Default = false,
	Tooltip = "Automatically enters the correct code into anchors when you are near them."
})
Toggles.AutoBreakerBox:OnChanged(function(Value)
	if Value and CurrentRooms:FindFirstChild("ElevatorBreaker", true) then
		if not Globals.BreakerBoxInteracted then
			if not Globals.BreakerBoxNotified then
				Functions.Notify({ Title = "Interact with the breaker box.", Body = "It will be automatically solved." })
				Globals.BreakerBoxInteracted = true
			end
		else
			RemotesFolder.EBF:FireServer()
		end
	end
end)

Groupboxes.Self_Automation:AddToggle("AutoHeartbeatMinigame", { Text = "Auto Heartbeat Minigame", Default = false, Tooltip = "Prevents the 'Figure' minigame from ever failing.", Disabled = not Functions.CheckCompatability({"hookmetamethod", "newcclosure", "getnamecallmethod"}), DisabledTooltip = Globals.IncompatibleMessage })
Groupboxes.Self_Automation:AddDivider()
Groupboxes.Self_Automation:AddToggle("AutoUnlockPadlockToggle", {
	Text = "Auto Unlock Padlock", Default = false, Tooltip = "Automatically enters the code into the library padlock."
})
Groupboxes.Self_Automation:AddSlider("AutoUnlockPadlockSlider", {
	Text = "Unlock Distance", Min = 1, Max = 50, Default = 10, Rounding = 0, Compact = true
})
Groupboxes.Self_Automation:AddToggle("AutoLibraryGuessCode", {
	Text = "Guess Library Code", Default = false,
	Tooltip = "Attempts to guess the library code, but collecting some books is also necessary."
})
Groupboxes.Self_Automation:AddDivider()
Groupboxes.Self_Automation:AddToggle("AutoInteractToggle", {
	Text = "Auto Interact", Default = false, Tooltip = "Automatically triggers nearby prompts."
})
Toggles.AutoInteractToggle:AddKeyPicker("AutoInteractKeybind", {
    Text = "Auto Interact",
    Default = "R",
    Mode = "Toggle",
    SyncToggleState = true
})
Groupboxes.Self_Automation:AddDropdown("AutoInteractIgnoreList", {
	Text = "Ignore List",
	Values = { "Glitch Fragments", "Jeff Items", "Dropped Items", "Currency", "Minecarts", "Locks" },
	Default = { "Glitch Fragments", "Jeff Items", "Dropped Items" },
	Multi = true, AllowNull = true
})
Groupboxes.Self_Automation:AddDivider()
Groupboxes.Self_Automation:AddToggle("AutoClosetToggle", {
	Text = "Auto Closet", Default = false,
	Tooltip = "Automatically hides in a nearby closet when an entity is near."
})
Toggles.AutoClosetToggle:AddKeyPicker("AutoClosetKeybind", {
	Text = "Auto Closet", Default = "Q", Mode = "Toggle", SyncToggleState = true
})
Groupboxes.Self_Automation:AddDropdown("AutoClosetEntityList", {
	Text = "Ignore List",
	Values = { "Rush", "Ambush", "Blitz", "DronesStampede", "Scribbles", "A-60", "A-120", "AR0xMBUSH", "RNIUSHCG==" },
	Multi = true, AllowNull = true
})
Groupboxes.Self_Automation:AddToggle("SpectateEntityToggle", {
	Text = "Spectate Entity",
	Default = false,
	Tooltip = "Spectates the entity while auto hiding."
})
Groupboxes.Self_Automation:AddDropdown("SpecateEntityMode", {
	Values = {"Player to Entity", "Entity to Player"},
	Default = 1,
	AllowNull = true
})

Groupboxes.Self_Misc = Tabs.General:AddRightGroupbox("Miscellaneous")
Groupboxes.Self_Misc:AddButton({
	Text = "Play Again", Tooltip = "Makes you join a new run, click again to cancel.", DoubleClick = true,
	Func = function() RemotesFolder.PlayAgain:FireServer() end
})
Groupboxes.Self_Misc:AddButton({
	Text = "Return to Lobby", Tooltip = "Makes you teleport back to the lobby.", DoubleClick = true,
	Func = function() RemotesFolder.Lobby:FireServer() end
})
Groupboxes.Self_Misc:AddButton({
	Text = "Revive",
	Tooltip = "Makes you revive, if you have a revive and haven't already revived in this run.",
	DoubleClick = true,
	Func = function() RemotesFolder.Revive:FireServer() end
})
Groupboxes.Self_Misc:AddButton({
	Text = "Reset Character",
	Tooltip = "Kills your character on the server. (takes around 20 seconds if replicatesignal isn't supported)",
	DoubleClick = true,
	Func = function()
		Globals.SelfKilled = true
		if Functions.CheckCompatability({"replicatesignal"}) then
			Astra.Environment.replicatesignal(LocalPlayer.Kill)
		else
			if RemotesFolder:FindFirstChild("Underwater") then
				RemotesFolder.Underwater:FireServer(true)
			else
				Humanoid.Health = 0
			end
		end
	end
})
Groupboxes.Debug = Tabs.General:AddRightGroupbox("Debug")
Groupboxes.Debug:AddButton({
	Text = "Void",
	Tooltip = "Teleports your character to Y -120.",
	Func = function()
		if not Character then return end
		local Pivot = Character:GetPivot()
		Character:PivotTo(Pivot + Vector3.new(0, -120 - Pivot.Position.Y, 0))
	end
})
Groupboxes.Debug:AddButton({
	Text = "Exit Closet",
	Tooltip = "Exits the current closet.",
	Func = function()
		if RemotesFolder and RemotesFolder:FindFirstChild("CamLock") then
			RemotesFolder.CamLock:FireServer()
		end
	end
})

local TpNextDoorConnection

local function getNextClosedDoor()
	if not Character then return nil end

	local GameData = game:GetService("ReplicatedStorage"):FindFirstChild("GameData")
	if not GameData then return nil end

	local LatestRoom = GameData:FindFirstChild("LatestRoom")
	if not LatestRoom then return nil end

	local startRoom = LatestRoom.Value
	local bestDoor = nil
	local bestNumber = math.huge

	for _, obj in ipairs(workspace:GetDescendants()) do
		if obj.Name == "Door" and obj:IsA("Model") then
			local openAttr = obj:GetAttribute("Open")
			if openAttr == false or openAttr == nil then
				local roomModel = obj.Parent
				local roomNum = tonumber(roomModel and roomModel.Name)

				if roomNum and roomNum >= startRoom and roomNum < bestNumber then
					bestNumber = roomNum
					bestDoor = obj
				end
			end
		end
	end

	return bestDoor
end

Groupboxes.Debug:AddButton({
	Text = "Tp Next Door",
	Tooltip = "Teleports you to the next sequential unopened door.",
	Func = function()
		local door = getNextClosedDoor()
		if door then
			Character:PivotTo(door:GetPivot())
		end
	end
})

Toggles.TpNextDoor = Groupboxes.Debug:AddToggle("TpNextDoor", {
	Text = "Auto Tp Next Door",
	Tooltip = "Continuously teleports you to the next sequential unopened door.",
	Default = false
})

Toggles.TpNextDoor:OnChanged(function(TpNextDoorEnabled)
	if TpNextDoorConnection then
		task.cancel(TpNextDoorConnection)
		TpNextDoorConnection = nil
	end

	if not TpNextDoorEnabled then
		return
	end

	TpNextDoorConnection = task.spawn(function()
		while Toggles.TpNextDoor.Value do
			local door = getNextClosedDoor()
			if door and Character then
				Character:PivotTo(door:GetPivot())
			end
			task.wait(0.15)
		end
		TpNextDoorConnection = nil
	end)
end)

Groupboxes.Exploits_Bypass = Tabs.Exploits:AddLeftGroupbox("Bypass / Solve")

Groupboxes.Exploits_Bypass:AddToggle("BypassGiggle",         { Text = "Bypass Giggle",           Default = false, Tooltip = "Prevents 'Giggle' from attacking you." })
Groupboxes.Exploits_Bypass:AddToggle("BypassDupe",           { Text = "Bypass Dupe",             Default = false, Tooltip = "Prevents you from open 'Dupe' fake doors." })
Groupboxes.Exploits_Bypass:AddToggle("BypassEyes",           { Text = "Bypass Eyes",             Default = false, Tooltip = "Prevents 'Eyes' from hurting you." })
Groupboxes.Exploits_Bypass:AddToggle("BypassLookman",        { Text = "Bypass Lookman",          Default = false, Tooltip = "Prevents 'Lookman' from hurting you." })
Groupboxes.Exploits_Bypass:AddToggle("BypassGloombatEggs",   { Text = "Bypass Gloombat Eggs",    Default = false, Tooltip = "Prevents taking damage from stepping on 'Gloombat' eggs." })
Groupboxes.Exploits_Bypass:AddToggle("BypassSeekObstructions", { Text = "Bypass Seek Obstructions", Default = false, Tooltip = "Prevents obstacles in the 'Seek' chase from harming you." })
Groupboxes.Exploits_Bypass:AddToggle("BypassVacuum",         { Text = "Bypass Vacuum",           Default = false, Tooltip = "Prevents you from falling into 'Vacuum' fake doors." })
Groupboxes.Exploits_Bypass:AddToggle("BypassKillbricks",     { Text = "Bypass Killbricks",       Default = false, Tooltip = "Prevents 'Lava' from hurting you." })
Groupboxes.Exploits_Bypass:AddToggle("BypassSeekingWall",    { Text = "Bypass Seeking Wall",     Default = false, Tooltip = "Prevents 'ScaryWall' from hurting you." })
Groupboxes.Exploits_Bypass:AddToggle("BypassSnare",          { Text = "Bypass Snare",            Default = false, Tooltip = "Prevents 'Snare' from trapping you." })
Groupboxes.Exploits_Bypass:AddToggle("BypassBanana",         { Text = "Bypass Banana",           Default = false, Tooltip = "Prevents 'Banana Peel' from slipping you up (sometimes doesn't work)." })
Groupboxes.Exploits_Bypass:AddToggle("BypassJeff",           { Text = "Bypass Jeff",             Default = false, Tooltip = "Prevents 'Jeff the Killer' from stabbing you (sometimes doesn't work)." })


Toggles.BypassGiggle:OnChanged(function(Value)
	for _, Object in Objects.Entities do
		if Object.Name == "GiggleCeiling" then
			Object:WaitForChild("Hitbox").CanTouch = not Value
		end
	end
end)
Toggles.BypassDupe:OnChanged(function(Value)
	for _, Object in Objects.Entities do
		if Object.Name == "DoorFake" or Object.Name == "FakeDoor" then
			Object:WaitForChild("Hidden").CanTouch = not Value
			if Object:FindFirstChild("Lock") then
				Object.Lock.UnlockPrompt.Enabled = not Value
			end
		end
	end
end)
Toggles.BypassEyes:OnChanged(function(Value)
	if Value and Globals.IsEyes then
		if Floor == "Fools" or Floor == "OldHotel" then
			RemotesFolder.MotorReplication:FireServer(0, (Globals.SpoofOffset == 200 and 65 or -65), 0, false)
		else
			RemotesFolder.MotorReplication:FireServer(-650)
		end
	end
end)
Toggles.BypassLookman:OnChanged(function(Value)
	if Value and Globals.IsLookman then
		if Floor == "Fools" or Floor == "OldHotel" then
			RemotesFolder.MotorReplication:FireServer(0, (Globals.SpoofOffset == 200 and 65 or -65), 0, false)
		else
			RemotesFolder.MotorReplication:FireServer(-650)
		end
	end
end)
Toggles.BypassGloombatEggs:OnChanged(function(Value)
	for _, Object in Objects.Entities do
		for _, Part in Object:GetDescendants() do
			if Part:IsA("BasePart") then
				Part.CanTouch = not Value
			end
		end
	end
end)
Toggles.BypassSeekObstructions:OnChanged(function(Value)
	for _, Object in Objects.SeekObstructions do
		Object.CanTouch = not Value
		if Object.Name == "SeekFloodline" then
			Object.CanCollide = Value
		end
	end
	for _, Object in Objects.SeekBridges do
		Object.CanCollide = Value
		Object.Transparency = Value and 0 or 1
	end
end)
Toggles.BypassVacuum:OnChanged(function(Value)
	for _, Object in Objects.Entities do
		if Object.Name == "SideroomSpace" then
			Object:WaitForChild("Collision").CanCollide = Value
			Object:WaitForChild("Collision").CanTouch = not Value
		end
	end
end)
Toggles.BypassKillbricks:OnChanged(function(Value)
	for _, Object in Objects.Obstructions do
		if Object.Name == "Lava" then Object.CanTouch = not Value end
	end
end)
Toggles.BypassSeekingWall:OnChanged(function(Value)
	for _, Object in Objects.Obstructions do
		if Object.Name == "ScaryWall" then
			for _, Part in Object:GetDescendants() do
				if Part:IsA("BasePart") then
					Part.CanTouch = not Value
					Part.CanCollide = not Value
				end
			end
		end
	end
end)
Toggles.BypassSnare:OnChanged(function(Value)
	for _, Object in Objects.Entities do
		if Object.Name == "Snare" then
			for _, Part in Object:GetDescendants() do
				if Part:IsA("BasePart") then Part.CanTouch = not Value end
			end
		end
	end
end)
Toggles.BypassBanana:OnChanged(function(Value)
	for _, Object in Objects.Entities do
		if Object.Name == "BananaPeel" then Object.CanTouch = not Value end
	end
end)
Toggles.BypassJeff:OnChanged(function(Value)
	for _, Object in Objects.Entities do
		if Object.Name == "JeffTheKiller" then
			for _, Part in Object:GetDescendants() do
				if Part:IsA("BasePart") then
					Part.CanCollide = not Value
					Part.CanTouch = not Value
				end
			end
			Object:WaitForChild("Humanoid").Health = 0
		end
	end
end)

-- Archives

Groupboxes.Archives_Misc = Tabs.Archives:AddRightGroupbox("Exploits / Anti")
Groupboxes.Archives_Misc:AddToggle("AntiRansom", { Text = "Anti Ransom", Default = false, Tooltip = "Prevents 'Ransom' from attacking you." })
Groupboxes.Archives_Misc:AddToggle("AntiClosetTrash", { Text = "Anti Closet Trash", Default = false, Tooltip = "Prevents 'Closet Trash' from spawning." })
Groupboxes.Archives_Misc:AddToggle("ForgetMeNotSolver", { Text = "Forget Me Not Skipper", Default = false, Tooltip = "Automatically Skippes Forget Me Not doors." })
Groupboxes.Archives_Misc:AddToggle("TimeShower", { Text = "Time Shower", Default = false, Tooltip = "Shows the Archives clock time." })
Groupboxes.Archives_Misc:AddToggle("BypassDronesStampede",         { Text = "Stop Time/Anti Stampede",           Default = false, Tooltip = "Prevents 'The Drones Stampede' from attacking you." })
Groupboxes.Archives_Misc:AddToggle("HonchoCorrectBoxESP", {Text = "Honcho Correct Box ESP", Default = false, Tooltip = "ESPs the Archives Correct Boxes." })

TimeShowerLabel = Instance.new("TextLabel")
TimeShowerLabel.Name = "TimeShower"
TimeShowerLabel.AnchorPoint = Vector2.new(0, 1)
TimeShowerLabel.Position = UDim2.new(0, 12, 1, -12)
TimeShowerLabel.Size = UDim2.new(0, 180, 0, 32)
TimeShowerLabel.BackgroundTransparency = 1
TimeShowerLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TimeShowerLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
TimeShowerLabel.TextStrokeTransparency = 0.35
TimeShowerLabel.Font = Enum.Font.GothamBold
TimeShowerLabel.TextSize = 18
TimeShowerLabel.TextXAlignment = Enum.TextXAlignment.Left
TimeShowerLabel.Text = "Time: --:--"
TimeShowerLabel.Visible = false
TimeShowerLabel.Parent = Container

Toggles.HonchoCorrectBoxESP:OnChanged(function(Value)
	if HonchoCorrectBoxConnection then
		HonchoCorrectBoxConnection:Disconnect()
		HonchoCorrectBoxConnection = nil
	end

	for _, Object in pairs(HonchoESPObjects) do
		if Object and Object.Parent then
			Functions.RemoveESP(Object)
		end
	end
	table.clear(HonchoESPObjects)
	table.clear(HonchoProcessedRooms)

	if not Value then
		return
	end

	local function ProcessHonchoRoom(Room)
		if not tonumber(Room.Name) then
			return
		end

		if HonchoProcessedRooms[Room] then
			return
		end

		HonchoProcessedRooms[Room] = true

		task.wait(3)

		if not Toggles.HonchoCorrectBoxESP.Value or not Room.Parent then
			HonchoProcessedRooms[Room] = nil
			return
		end

		local HonchoRoom = Room:FindFirstChild("ArchivesHonchoRoom", true)
		if not HonchoRoom then

			HonchoProcessedRooms[Room] = nil
			return
		end

		local BoxIDs = {}
		local depositCount = 0
		for _, Desc in ipairs(Room:GetDescendants()) do
			if Desc.Name == "ArchivesPackageDeposit" then
				depositCount += 1
				local BoxID = Desc:GetAttribute("BoxID")
				if BoxID ~= nil then
					BoxIDs[BoxID] = true
				else
				end
			end
		end

		if next(BoxIDs) == nil then
			HonchoProcessedRooms[Room] = nil
			return
		end

		local RoomNumber = tonumber(Room.Name)
		local foundCorrectBox = false
		local matchedCount = 0

		for _, Child in HonchoRoom:GetDescendants() do
			if Child.Name == "ArchivesStorageBox" then
				local ToolBoxID = Child:GetAttribute("Tool_BoxID")

				if ToolBoxID ~= nil and BoxIDs[ToolBoxID] then
					matchedCount += 1

					if Toggles.HonchoCorrectBoxESP.Value then
						if not Child:GetAttribute("ParentRoom") then
							Child:SetAttribute("ParentRoom", RoomNumber)
						end

						local Color = (Options.ObjectiveESPColor and Options.ObjectiveESPColor.Value) or Color3.fromRGB(0, 255, 0)

						Functions.AddESP({
							Object = Child,
							Text = "Correct Box",
							Color = Color
						}, true)

						table.insert(HonchoESPObjects, Child)
						foundCorrectBox = true

						Child.Destroying:Once(function()
							Functions.RemoveESP(Child)
							local pos = table.find(HonchoESPObjects, Child)
							if pos then
								table.remove(HonchoESPObjects, pos)
							end
						end)
					end
				end
			end
		end
	end

	local currentRooms = workspace:FindFirstChild("CurrentRooms")
	if not currentRooms then
		return
	end


	for _, Room in ipairs(currentRooms:GetChildren()) do
		task.spawn(ProcessHonchoRoom, Room)
	end

	HonchoCorrectBoxConnection = currentRooms.ChildAdded:Connect(function(Room)
		task.spawn(ProcessHonchoRoom, Room)
	end)

end)

local function GetArchivesClockLabel(Room)
	local Assets = Room and Room:FindFirstChild("Assets", true)
	local Clock = Assets and Assets:FindFirstChild("ArchivesClock", true)
	local Time = Clock and Clock:FindFirstChild("Time", true)
	local TextLabel = Time and Time:FindFirstChild("TextLabel")
	if TextLabel and TextLabel:IsA("TextLabel") then
		return TextLabel
	end
	return nil
end

local function ResolveClockLabel()
	if TimeShowerSourceLabel and TimeShowerSourceLabel.Parent and TimeShowerSourceLabel:IsDescendantOf(game) then
		return TimeShowerSourceLabel
	end

	local currentRooms = workspace:FindFirstChild("CurrentRooms")
	if not currentRooms then return nil end

	local rooms = {}
	for _, room in ipairs(currentRooms:GetChildren()) do
		local num = tonumber(room.Name)
		if num then
			table.insert(rooms, {room = room, num = num})
		end
	end

	table.sort(rooms, function(a, b)
		return a.num > b.num
	end)

	local endIndex = math.min(6, #rooms)
	for i = 1, endIndex do
		local label = GetArchivesClockLabel(rooms[i].room)
		if label then
			TimeShowerSourceLabel = label
			return label
		end
	end

	return nil
end

local function ResolveClockRemote()
	local label = ResolveClockLabel()
	if not label then return nil end
	local clock = label:FindFirstAncestor("ArchivesClock")
	if not clock then return nil end
	local remote = clock:FindFirstChild("LookedAtRemote", true)
	return (remote and remote:IsA("RemoteEvent")) and remote or nil
end

task.spawn(function()
	local lastCheckedRoomCount = 0

	while game:IsLoaded() do
		local currentRooms = workspace:FindFirstChild("CurrentRooms")
		if currentRooms then
			local roomCount = 0
			for _, child in ipairs(currentRooms:GetChildren()) do
				if tonumber(child.Name) then
					roomCount += 1
				end
			end

			if roomCount > 0 and (lastCheckedRoomCount == 0 or (roomCount - lastCheckedRoomCount) >= 10) then
				ResolveClockLabel()
				lastCheckedRoomCount = roomCount
			end
		end

		task.wait(0.5)
	end
end)

local function StopTimeShower()
	TimeShowerToken += 1
	if TimeShowerConnection then
		TimeShowerConnection:Disconnect()
		TimeShowerConnection = nil
	end
	if TimeShowerLabel then
		TimeShowerLabel.Visible = false
		TimeShowerLabel.Text = "Time: --:--"
	end
end

Toggles.TimeShower:OnChanged(function(Value)
	StopTimeShower()
	if not Value then return end

	local Token = TimeShowerToken
	TimeShowerLabel.Visible = true

	TimeShowerConnection = Services.RunService.Heartbeat:Connect(function()
		if Token ~= TimeShowerToken then return end

		local TextLabel = ResolveClockLabel()
		if TextLabel then
			TimeShowerLabel.Text = "Time: " .. TextLabel.Text
		else
			TimeShowerLabel.Text = "Time: --:--"
		end
	end)
end)
Toggles.BypassDronesStampede:OnChanged(function(enabled)
	if BypassDronesStampedeConnection then
		task.cancel(BypassDronesStampedeConnection)
		BypassDronesStampedeConnection = nil
	end
	if not enabled then return end

	BypassDronesStampedeConnection = task.spawn(function()
		while Toggles.BypassDronesStampede.Value do
			local remote = ResolveClockRemote()
			if remote then
				remote:FireServer()
			end
			task.wait(1)
		end
	end)
end)

Groupboxes.Archives_Bypasses = Tabs.Archives:AddLeftGroupbox("Bypasses")
Groupboxes.Archives_Bypasses:AddToggle("BypassWater", { Text = "Bypass Electric Water", Default = false, Tooltip = "Prevents electric water from hurting you." })
Groupboxes.Archives_Bypasses:AddToggle("BypassAlma", { Text = "Bypass Alma", Default = false, Tooltip = "Prevents 'Alma' from spawning." })
Groupboxes.Archives_Bypasses:AddToggle("BypassDrones",         { Text = "Bypass Drones",           Default = false, Tooltip = "Prevents 'Drones' from attacking you." })
Groupboxes.Archives_Bypasses:AddToggle("AntiScribbles", { Text = "Bypass Scribbles", Default = false, Tooltip = "Prevents 'Scribbles' from attacking you." })

Groupboxes.Archives_Experimental = Tabs.Archives:AddLeftGroupbox("Experimental")


Toggles.AntiClosetTrash:OnChanged(function(Value)
	if AntiClosetTrash_Connection then
		AntiClosetTrash_Connection:Disconnect()
		AntiClosetTrash_Connection = nil
	end

	if not Value then
		return
	end

	AntiClosetTrash_Connection = workspace.ChildAdded:Connect(function(Child)
		if not Toggles.AntiClosetTrash.Value then
			return
		end

		local Name = Child.Name

		if (Name:sub(1, 6) == "Binder"
			or Name:sub(1, 4) == "Shoe"
			or Name:sub(1, 5) == "Shelf")
			then

			Child:Destroy()
		end
	end)
end)
Toggles.AntiRansom:OnChanged(function(Value)
	if AntiRansom_Connection then
		AntiRansom_Connection:Disconnect()
		AntiRansom_Connection = nil
	end

	if not Value then
		return
	end

	AntiRansom_Connection = workspace.ChildAdded:Connect(function(Child)
		if Child.Name == "Ransom" and Toggles.AntiRansom.Value then
			Child:Destroy()
			print ("Ransom gone hehehehehehehehe")
		end
	end)
end)
Toggles.ForgetMeNotSolver:OnChanged(function(Value)
	if ForgetMeNotConnection then
		ForgetMeNotConnection:Disconnect()
		ForgetMeNotConnection = nil
	end

	ForgetMeNotRunning = false
	ForgetMeNotProcessing = {}
	ForgetMeNotNotified = {}

	if not Value then
		return
	end

	ForgetMeNotRunning = true

	local function GetCharacter()
		return game.Players.LocalPlayer.Character
			or game.Players.LocalPlayer.CharacterAdded:Wait()
	end

	local function GetNextRoom(Number)
		while ForgetMeNotRunning do
			for RoomNumber = Number + 1, Number + 5 do
				local NextRoom = workspace.CurrentRooms:FindFirstChild(tostring(RoomNumber))
				if NextRoom then
					return NextRoom
				end
			end
			task.wait(0.1)
		end
		return nil
	end

	local function FireLookAts(Room)
		for i = 1, 6 do
			local Obj = Room:FindFirstChild(tostring(i))
			if Obj then
				local LookAt = Obj:FindFirstChild("LookAt")
				if LookAt then
					pcall(function()
						LookAt:FireServer()
					end)
				end
			end
		end
	end

	local function Run(Room)
		if not ForgetMeNotRunning or ForgetMeNotProcessing[Room] then
			return
		end

		ForgetMeNotProcessing[Room] = true

		task.wait(2)

		if not ForgetMeNotRunning or not Room.Parent then
			ForgetMeNotProcessing[Room] = nil
			return
		end

		if not Room:FindFirstChild("ForgetMeNotVineDoors", true) then
			ForgetMeNotProcessing[Room] = nil
			return
		end

		FireLookAts(Room)


		local NextRoom = GetNextRoom(tonumber(Room.Name))

		if not NextRoom then
			ForgetMeNotProcessing[Room] = nil
			return
		end

		local Door = NextRoom:FindFirstChild("Door")

		if not Door then
			ForgetMeNotProcessing[Room] = nil
			return
		end

		if Door:GetAttribute("Opened") == true then
			ForgetMeNotProcessing[Room] = nil
			return
		end

		if not Room:FindFirstChild(game.Players.LocalPlayer.Name, true) then
			if not ForgetMeNotNotified[Room] then
				ForgetMeNotNotified[Room] = true
				Functions.Notify({Title = "Please Enter The First ForgetMeNot Door"})
			end

			repeat
				task.wait()
			until Room:FindFirstChild(game.Players.LocalPlayer.Name, true)
				or not ForgetMeNotRunning
				or not Room.Parent

			if not ForgetMeNotRunning or not Room.Parent then
				ForgetMeNotProcessing[Room] = nil
				return
			end
		end

		if not ForgetMeNotRunning or Door:GetAttribute("Opened") == true then
			ForgetMeNotProcessing[Room] = nil
			return
		end

		local Hidden = Door:WaitForChild("Hidden", 10)

		if not Hidden or not ForgetMeNotRunning or Door:GetAttribute("Opened") == true then
			ForgetMeNotProcessing[Room] = nil
			return
		end

		task.wait(3)

		if not ForgetMeNotRunning or not NextRoom.Parent or Door:GetAttribute("Opened") == true then
			ForgetMeNotProcessing[Room] = nil
			return
		end

		while ForgetMeNotRunning and NextRoom.Parent and Door:GetAttribute("Opened") ~= true do
			local Character = GetCharacter()

			if Character then
				if Hidden:IsA("BasePart") then
					Character:PivotTo(Hidden.CFrame)
				elseif Hidden:IsA("Model") then
					Character:PivotTo(Hidden:GetPivot())
				end
			end

			pcall(function()
				Door.ClientOpen:Fire()
			end)

			pcall(function()
				Door.ClientOpen:FireServer()
			end)

			task.wait()
		end

		if ForgetMeNotRunning and Door:GetAttribute("Opened") == true then
			local Character = GetCharacter()
			if Character then
				Character:PivotTo(CFrame.new(0, -120, 0))
				Character:PivotTo(CFrame.new(0, -120, 0))
				Character:PivotTo(CFrame.new(0, -120, 0))
				Character:PivotTo(CFrame.new(0, -120, 0))
				Functions.Notify({Title = "Spam Void In Debug If Stuck In ForgetMeNot"})
			end
			ForgetMeNotNotified[Room] = nil
		end

		ForgetMeNotProcessing[Room] = nil
	end

	local function CheckRooms()
		local LatestRoomNumber = tonumber(LatestRoom.Value) or 0
		local FirstRoomNumber = math.max(0, LatestRoomNumber - 4)
		for RoomNumber = FirstRoomNumber, LatestRoomNumber do
			if not ForgetMeNotRunning then
				return
			end

			local Room = workspace.CurrentRooms:FindFirstChild(tostring(RoomNumber))
			if Room and not ForgetMeNotProcessing[Room] then
				task.spawn(Run, Room)
			end
		end
	end

	ForgetMeNotConnection = workspace.CurrentRooms.ChildAdded:Connect(function(Room)
		if not tonumber(Room.Name) then
			return
		end

		task.spawn(function()
			task.wait(2)

			if ForgetMeNotRunning and Room.Parent then
				task.spawn(Run, Room)
			end
		end)
	end)

	task.spawn(function()
		while ForgetMeNotRunning do
			CheckRooms()
			task.wait(2)
		end
	end)

	CheckRooms()
end)
Toggles.BypassWater:OnChanged(function(Value)

	Functions.Notify({Title = "PositionSpoof Will Break This!."})

	if WaterBypassConnection then
		WaterBypassConnection:Disconnect()
		WaterBypassConnection = nil
	end

	if Value then
		local function ProcessWaterBypassRoom(WaterBypassRoom)
			if not tonumber(WaterBypassRoom.Name) then
				return
			end

			task.wait(3)

			local WaterBypassWater = WaterBypassRoom:FindFirstChild("Water")

			if not WaterBypassWater or WaterParts[WaterBypassWater] then
				return
			end

			local WaterBypassPart = Instance.new("Part")
			WaterBypassPart.Name = "WaterBypass"
			WaterBypassPart.Anchored = true
			WaterBypassPart.CanCollide = true
			WaterBypassPart.CanTouch = false
			WaterBypassPart.CanQuery = false
			WaterBypassPart.Transparency = 0.25
			WaterBypassPart.Color = Color3.fromRGB(0, 150, 255)
			WaterBypassPart.Material = Enum.Material.ForceField

			if WaterBypassWater:IsA("BasePart") then
				WaterBypassPart.Size = WaterBypassWater.Size + Vector3.new(0, 0.5, 0)
				WaterBypassPart.CFrame = WaterBypassWater.CFrame * CFrame.new(0, 0.25, 0)

			elseif WaterBypassWater:IsA("Model") then
				local WaterBypassCFrame, WaterBypassSize = WaterBypassWater:GetBoundingBox()

				WaterBypassPart.Size = WaterBypassSize + Vector3.new(0, 0.5, 0)
				WaterBypassPart.CFrame = WaterBypassCFrame * CFrame.new(0, 0.25, 0)

			else
				WaterBypassPart.Size = Vector3.new(10, 1.5, 10)
				WaterBypassPart.CFrame = WaterBypassWater:GetPivot() * CFrame.new(0, 0.25, 0)
			end


			if WaterBypassPart.Size.Y > 3 then
				WaterBypassPart:Destroy()

				Functions.Notify({
					Title = "Water Bypass removed: Softlock.",
				})

				return
			end

			WaterBypassPart.Parent = WaterBypassRoom
			WaterParts[WaterBypassWater] = WaterBypassPart
		end

		local WaterBypassLatestRoomNumber = tonumber(LatestRoom.Value) or 0

		for WaterBypassRoomNumber = math.max(0, WaterBypassLatestRoomNumber - 4), WaterBypassLatestRoomNumber do
			local WaterBypassRoom = workspace.CurrentRooms:FindFirstChild(tostring(WaterBypassRoomNumber))

			if WaterBypassRoom then
				task.spawn(ProcessWaterBypassRoom, WaterBypassRoom)
			end
		end

		WaterBypassConnection = workspace.CurrentRooms.ChildAdded:Connect(function(WaterBypassRoom)
			task.spawn(ProcessWaterBypassRoom, WaterBypassRoom)
		end)
	else
		for _, WaterBypassPart in pairs(WaterParts) do
			if WaterBypassPart then
				WaterBypassPart:Destroy()
			end
		end

		table.clear(WaterParts)
	end
end)
Toggles.BypassAlma:OnChanged(function(Value)
	if AlmaConnection then
		AlmaConnection:Disconnect()
		AlmaConnection = nil
	end

	if Value then
		for _, child in ipairs(workspace:GetChildren()) do
			if child.Name == "Alma" then
				child:Destroy()
			end
		end

		AlmaConnection = workspace.ChildAdded:Connect(function(child)
			if child.Name == "Alma" then
				child:Destroy()
			end
		end)
	end
end)
Toggles.AntiScribbles:OnChanged(function(Value)
	if AntiScribbles_Connection then
		AntiScribbles_Connection:Disconnect()
		AntiScribbles_Connection = nil
	end

	if not Value then
		return
	end

	AntiScribbles_Connection = workspace.ChildAdded:Connect(function(Child)
		if Child.Name == "Scribbles" and Toggles.AntiScribbles.Value then
			local ExploitSribbleWarning = Child:FindFirstChild("IfYoureExploitingDeleteThis")
			if ExploitSribbleWarning then
				ExploitSribbleWarning:Destroy()
			end
		end
	end)
end)
Toggles.BypassDronesStampede:OnChanged(function(BypassDronesStampedeEnabled)
	if BypassDronesStampedeConnection then
		task.cancel(BypassDronesStampedeConnection)
		BypassDronesStampedeConnection = nil
	end

	if not BypassDronesStampedeEnabled then
		return
	end

	BypassDronesStampedeConnection = task.spawn(function()
		while Toggles.BypassDronesStampede.Value do
			if not TimeShowerSourceLabel then
				task.wait(0.25)
				continue
			end

			local clockLabel = TimeShowerSourceLabel
			local clock = clockLabel:FindFirstAncestor("ArchivesClock")

			if not clock or not clock.Parent then
				task.wait(0.25)
				continue
			end

			local lookedAtRemote = clock:FindFirstChild("LookedAtRemote", true)
			if not lookedAtRemote or not lookedAtRemote:IsA("RemoteEvent") then
				task.wait(0.25)
				continue
			end

			while Toggles.BypassDronesStampede.Value
				and TimeShowerSourceLabel == clockLabel
				and clock.Parent
			do
				lookedAtRemote:FireServer()
				task.wait(0.5)
			end
		end
	end)
end)
Toggles.BypassDrones:OnChanged(function(Value)
	local RS = game:GetService("ReplicatedStorage")

	local function ProcessDrones(drones)
		local WalkedInto = drones:FindFirstChild("WalkedInto") or drones:WaitForChild("WalkedInto", 3)
		if WalkedInto and not DroneWalkedIntoParents[WalkedInto] then
			DroneWalkedIntoParents[WalkedInto] = drones
			WalkedInto.Parent = RS
		end
	end

	if Value then
		for _, child in ipairs(workspace:GetChildren()) do
			if child.Name == "Drones" then
				ProcessDrones(child)
			end
		end

		if DroneConnection then
			DroneConnection:Disconnect()
		end
		DroneConnection = workspace.ChildAdded:Connect(function(child)
			if child.Name == "Drones" then
				ProcessDrones(child)
			end
		end)
	else
		for WalkedInto, originalParent in pairs(DroneWalkedIntoParents) do
			if WalkedInto and WalkedInto.Parent and originalParent and originalParent.Parent then
				WalkedInto.Parent = originalParent
			end
		end
		table.clear(DroneWalkedIntoParents)

		if DroneConnection then
			DroneConnection:Disconnect()
			DroneConnection = nil
		end
	end
end)


-- Stairwell

Groupboxes.Stairwell_Misc = Tabs.Stairwell:AddLeftGroupbox("Exploits / Anti")
Groupboxes.Stairwell_Experimental = Tabs.Stairwell:AddLeftGroupbox("Experimental")
Groupboxes.Stairwell_Experimental:AddButton({
    Text = "Bring Dropped Items",
    Func = function()
        local workspaceDropsFolder = workspace:FindFirstChild("Drops")

        if LocalPlayer and LocalPlayer.Character then
            local playerHumanoidRootPart = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            
            if playerHumanoidRootPart then
                if workspaceDropsFolder then
                    for _, itemToBring in ipairs(workspaceDropsFolder:GetChildren()) do
                        if itemToBring:IsA("Model") then
                            itemToBring:PivotTo(playerHumanoidRootPart.CFrame)
                        elseif itemToBring:IsA("BasePart") then
                            itemToBring.CFrame = playerHumanoidRootPart.CFrame
                        end
                    end
                end
            end
        end
    end,
    DoubleClick = false,
    Tooltip = "Brings all dropped items."
})

Groupboxes.Stairwell_Experimental:AddToggle("AntiNoise", { Text = "Anti Noise", Default = false, Tooltip = "Prevents the game from making noise when moving (Visual studio auto ai lmfao ✌)." })

Toggles.AntiNoise:OnChanged(function(value)
	for i, conn in ipairs(Connections) do
		if conn.Disconnect then
			conn:Disconnect()
			table.remove(Connections, i)
		end
	end

	local antiNoiseConn = RunService.PreSimulation:Connect(function(dt)
		if not value then return end
		if not LocalPlayer:GetAttribute("Alive") then return end

		local character = LocalPlayer.Character
		if not character then return end

		local rootPart = character:FindFirstChild("HumanoidRootPart")
		local humanoid = character:FindFirstChildOfClass("Humanoid")
		local camera = workspace.CurrentCamera

		if not rootPart or not humanoid or not camera then return end
		if humanoid.Health <= 0 then return end
		if rootPart.Anchored then return end

		local state = humanoid:GetState()
		if state == Enum.HumanoidStateType.Dead
			or state == Enum.HumanoidStateType.Ragdoll
			or state == Enum.HumanoidStateType.Climbing
			or state == Enum.HumanoidStateType.Swimming
		then
			return
		end

		humanoid.AutoRotate = false
		humanoid:Move(Vector3.zero, false)

		local inputVector = Controls:GetMoveVector()
		local inputMagnitude = inputVector.Magnitude

		if inputMagnitude <= 0 then
			rootPart.AssemblyLinearVelocity = Vector3.zero
			return
		end

		local cameraCFrame = camera.CFrame
		local cameraForward = Vector3.new(cameraCFrame.LookVector.X, 0, cameraCFrame.LookVector.Z)
		local cameraRight = Vector3.new(cameraCFrame.RightVector.X, 0, cameraCFrame.RightVector.Z)

		if cameraForward.Magnitude < 0.001 or cameraRight.Magnitude < 0.001 then return end

		cameraForward = cameraForward.Unit
		cameraRight = cameraRight.Unit

		local worldDirection = (cameraRight * inputVector.X) + (cameraForward * -inputVector.Z)
		if worldDirection.Magnitude <= 0 then return end
		worldDirection = worldDirection.Unit

		local finalSpeed = humanoid.WalkSpeed * math.clamp(inputMagnitude, 0, 1)
		local clampedDt = math.clamp(dt, 0, 1/30)

		rootPart.AssemblyLinearVelocity = Vector3.zero
		rootPart.CFrame = rootPart.CFrame + (worldDirection * finalSpeed * clampedDt)
		rootPart.CFrame = CFrame.new(rootPart.Position, rootPart.Position + worldDirection)
	end)

	table.insert(Connections, antiNoiseConn)
end)

Groupboxes.Exploits_BypassRight = Tabs.Exploits:AddRightGroupbox("Bypass")
Groupboxes.Exploits_BypassRight:AddToggle("DisableAnticheat", {
	Text = "Anticheat Bypass", Default = false,
	Tooltip = "Completely disables the anticheat, after interacting with a ladder."
})
Groupboxes.Exploits_BypassRight:AddToggle("VelocityManipulationToggle", {
	Text = "Velocity Manipulation", Default = false,
	Tooltip = "Moves your character forward slowly, mitigating the game's anti-noclip."
})
Toggles.DisableAnticheat:OnChanged(function(Value)
	if Globals.AnticheatDisabled == true and not Value then
		RemotesFolder.ClimbLadder:FireServer()
		Globals.AnticheatDisabled = false
	end
end)
Toggles.VelocityManipulationToggle:AddKeyPicker("VelocityManipulationKeybind", {
	Text = "Velocity Manipulation", Default = "V",
	Mode = Library.IsMobile and "Toggle" or "Hold", SyncToggleState = true
})
Groupboxes.Exploits_BypassRight:AddDropdown("VelocityManipulationMode", {
	Values = {"Velocity", "Pivot"}, Text = "Manipulation Method",
	Default = 1,
})

Groupboxes.Exploits_BypassRight:AddDivider()
Groupboxes.Exploits_BypassRight:AddToggle("InfiniteItemsToggle", {
	Text = "Infinite Items", Default = false,
	Tooltip = "Allows certain items to be used without draining their uses.",
	Disabled = not Functions.CheckCompatability({"fireproximityprompt"}),
	DisabledTooltip = Globals.IncompatibleMessage
})
Groupboxes.Exploits_BypassRight:AddDropdown("InfiniteItemsList", {
	Text = "Item List",
	Values = { "Lockpicks", "Skeleton Key", "Shears", "Multitool" },
	Multi = true, AllowNull = true,
	Disabled = not Functions.CheckCompatability({"fireproximityprompt"}),
	DisabledTooltip = Globals.IncompatibleMessage
})

Groupboxes.Exploits_BypassRight:AddToggle("InfCrucifix", {
	Text = "Infinite Crucifix",
	Default = false,
	Tooltip = "Risky! You can die or lose the Crucifix. Recommended to have low ping and stable fps.",
	Risky = Floor ~= "Ballz",
})


local InfCrucifixDropTable = {
	RushMoving   = 54,
	AmbushMoving = 67,
	A60          = 70,
	GlitchRush   = 120,
	GlitchAmbush = 155,
	A120         = 75,

}



Toggles.InfCrucifix:OnChanged(function(Value)
	print("i allive")
	local InfCrucifixRaycastParams = RaycastParams.new()
	InfCrucifixRaycastParams.FilterType = Enum.RaycastFilterType.Blacklist

	local InfCrucifixConnection
	InfCrucifixConnection = RunService.RenderStepped:Connect(function()
		if not Toggles.InfCrucifix.Value then
			if InfCrucifixConnection then
				InfCrucifixConnection:Disconnect()
			end
			return
		end

		local InfCrucifixCharacter = game.Players.LocalPlayer
		if not InfCrucifixCharacter then
			return
		end

		local InfCrucifixCollision = InfCrucifixCharacter:FindFirstChild("CollisionPart")
		if not InfCrucifixCollision then
			return
		end

		InfCrucifixRaycastParams.FilterDescendantsInstances = {InfCrucifixCharacter}

		for _, InfCrucifixEntity in ipairs(Workspace:GetChildren()) do
			local InfCrucifixMaxDistance = InfCrucifixDropTable[InfCrucifixEntity.Name]
			if not InfCrucifixMaxDistance or not InfCrucifixEntity.PrimaryPart then
				continue
			end

			InfCrucifixEntity.PrimaryPart.CanCollide = true
			InfCrucifixEntity.PrimaryPart.CanQuery = true

			local InfCrucifixOrigin = InfCrucifixCollision.Position
			local InfCrucifixDirection = InfCrucifixEntity.PrimaryPart.Position - InfCrucifixOrigin
			local InfCrucifixRayResult = Workspace:Raycast(InfCrucifixOrigin, InfCrucifixDirection, InfCrucifixRaycastParams)

			if not InfCrucifixRayResult or not InfCrucifixRayResult.Instance:IsDescendantOf(InfCrucifixEntity) then
				continue
			end

			local InfCrucifixDistance = (InfCrucifixCollision.Position - InfCrucifixEntity.PrimaryPart.Position).Magnitude
			if InfCrucifixDistance >= InfCrucifixMaxDistance then
				continue
			end

			local InfCrucifixTool = InfCrucifixCharacter:FindFirstChildOfClass("Tool")
			if not InfCrucifixTool or InfCrucifixTool.Name ~= "Crucifix" then
				continue
			end

			task.spawn(function()
				ReplicatedStorage.RemotesFolder.DropItem:FireServer(InfCrucifixTool)
				task.wait(0.54)
				print("hi")
				local InfCrucifixDrops = Workspace:FindFirstChild("Drops")
				if not InfCrucifixDrops then
					return
				end

				local InfCrucifixDropped = InfCrucifixDrops:FindFirstChild("Crucifix")
				if not InfCrucifixDropped then
					return
				end

				local InfCrucifixPrompt = InfCrucifixDropped:FindFirstChildOfClass("ProximityPrompt")
				if InfCrucifixPrompt then
					fireproximityprompt(InfCrucifixPrompt)
				end
			end)
			print ("hi")
			task.wait(0.6)
		end
	end)
end)


Groupboxes.Exploits_BypassRight:AddDivider()
Groupboxes.Exploits_BypassRight:AddToggle("PositionSpoof", {
	Text = "Position Spoof", Default = false,
	Tooltip = "Makes your character appear underground on the server, protecting you from rush-like entities."
})
