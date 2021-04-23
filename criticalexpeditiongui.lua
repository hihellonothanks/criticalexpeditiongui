local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()

local Window = Library.CreateLib("Critical Expedition", "DarkTheme")

local Tab = Window:NewTab("Main")

local Section = Tab:NewSection("Autofarm")

local VUser = game:GetService('VirtualUser') 

local Plr = game:GetService("Players").LocalPlayer

local child = game.Players.LocalPlayer.Backpack:GetChildren()

local ts = game:GetService("TweenService")
local char = game:GetService("Players").LocalPlayer.Character
local part = char.HumanoidRootPart
local tp = {CFrame = New_CFrame}

local player = game.Players.LocalPlayer
local rs = game:GetService("RunService")

Section:NewToggle("Auto Skill", "ToggleInfo", function(state3)
    if state3 then
_G.autoskill = true
    else
_G.autoskill = false
    end
    
        while _G.autoskill do wait(4)
wait(0.35)
game:GetService("Players").LocalPlayer.Character.ItemActivate:FireServer(game:GetService("Players").LocalPlayer.Character.ActiveItems:FindFirstChild("Ignite Scroll"))
wait(0.35)
game:GetService("Players").LocalPlayer.Character.ItemActivate:FireServer(game:GetService("Players").LocalPlayer.Character.ActiveItems:FindFirstChild("Water Bolt"))
wait(0.35)
game:GetService("Players").LocalPlayer.Character.ItemActivate:FireServer(game:GetService("Players").LocalPlayer.Character.ActiveItems:FindFirstChild("Blizzard Scroll"))
end
end)

local destination = {
    desX = nil,
    desY = nil,
    desZ = nil
}
Section:NewDropdown("Select Target", "DropdownInf", {
    "Ice Slime",
    "Hardmode Wolf",
    "Slime Prince"
}, function(currentOption2)

    print(currentOption)
    
    if currentOption2 == "Ice Slime" then
    destination["desX"] = -957.060425
    destination["desY"] = 163.100006
    destination["desZ"] = -1081.69995
    elseif currentOption2 == "Hardmode Wolf" then
    destination["desX"] = -399
    destination["desY"] = 269
    destination["desZ"] = -496
    elseif currentOption2 == "Slime Prince" then
    end
        end)

_G.tping = nil
Section:NewToggle("Auto TP", "ToggleInfo", function(state2)
if state2 then
    _G.tping = true
    else
    _G.tping = false
end
    while _G.tping do wait(9)
      Plr.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(destination["desX"], destination["desY"], destination["desZ"])
    end
end)

function tp(CFrametp)
   ts:Create(part, TweenInfo.new((CFrametp.Position - char.HumanoidRootPart.Position).magnitude/44, Enum.EasingStyle.Quad), {CFrame = CFrametp.CFrame}):Play()
end
Section:NewToggle("Auto Grab Tokens", "ToggleInfo", function(state4)
if state4 then
    _G.testing = true
    else
    _G.testing = false
end

while _G.testing do
   wait(.1)
if game.Workspace:FindFirstChild("CombatFolder") then
   if game.Workspace:FindFirstChild("CombatFolder"):FindFirstChild(game.Players.LocalPlayer.Name) and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
       for i,v in pairs(game.Workspace.CombatFolder[game.Players.LocalPlayer.Name]:GetChildren()) do
           tp(v.Part)
       end
   end
end
end
end)

local target = nil
Section:NewDropdown("Select Stat", "DropdownInf", {
    "Damage",
    "Shield",
    "Health",
    "Mana",
    "Magic"
}, function(currentOption)
    print(currentOption)
    target = currentOption
end)

_G.autostat = nil
Section:NewToggle("Auto Stats", "ToggleInfo", function(state5)
    if state5 then
    _G.autostat = true
    else
    _G.autostat = false
end

while _G.autostat do wait(1)
game:GetService("ReplicatedStorage").Remotes.StatsChange:FireServer(target)
end
end)

local Tab2 = Window:NewTab("Other")

local Section2 = Tab2:NewSection("Utility")

Section2:NewButton("God Mode", "ToggleInfo", function()
local old;
old = hookfunction(getrawmetatable(game).__namecall,function(...)
    local args = {...}
    if getnamecallmethod() == "FireServer" and args[1].Name == "Damage" and tostring(args[2]) == game.Players.LocalPlayer.Name then
        return
    end
    return old(...)
end)
end)

Section2:NewButton("Grab Items", "ToggleInfo", function()
for i,v in pairs(game.Workspace.MaterialGivers:GetDescendants()) do
   if v:IsA("TouchTransmitter") then
   firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v.Parent, 0)
   wait(.3)
   firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v.Parent, 1)
end
end
end)

Section2:NewButton("Equip Items", "ToggleInfo", function()
    Plr.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(249.402786, 37.0032997, 233.86998)
wait(0.5)
game:GetService("ReplicatedStorage").Remotes.ItemSetup:FireServer("Magic Gauge")
wait(0.1)
game:GetService("ReplicatedStorage").Remotes.ItemSetup:FireServer("Champions Emblem")
wait(0.1)
game:GetService("ReplicatedStorage").Remotes.ItemSetup:FireServer("Winged Boots")
wait(0.1)
game:GetService("ReplicatedStorage").Remotes.ItemSetup:FireServer("Ignite Scroll")
wait(0.1)
game:GetService("ReplicatedStorage").Remotes.ItemSetup:FireServer("Water Bolt")
wait(0.1)
game:GetService("ReplicatedStorage").Remotes.ItemSetup:FireServer("Blizzard Scroll")
end)

Section2:NewButton("Inf Combo?", "ToggleInfo", function()
function InfCombo(c)
    local head = c:WaitForChild("Head")
    head.DescendantAdded:Connect(function(v)
        if v:IsA("Script") then
            rs.RenderStepped:wait()
            v:Destroy()
        end
    end)
end

player.CharacterAdded:Connect(InfCombo)
InfCombo(player.Character)
end)
