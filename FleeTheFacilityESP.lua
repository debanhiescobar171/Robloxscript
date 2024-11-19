local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Flee the Facility ESP", "Ocean")

-- Main
local Main = Window:NewTab("Main")
local MainSection = Main:NewSection("ESP Options")

local ESP = {
    PlayerESP = false,
    ComputerESP = false
}

MainSection:NewToggle("Player ESP", "Toggle Player ESP", function(state)
    ESP.PlayerESP = state
end)

MainSection:NewToggle("Computer ESP", "Toggle Computer ESP", function(state)
    ESP.ComputerESP = state
end)

-- ESP Functions
local function CreateESP(part, color)
    local billboard = Instance.new("BillboardGui")
    billboard.Size = UDim2.new(0, 200, 0, 50)
    billboard.AlwaysOnTop = true
    billboard.Parent = part

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 1, 0)
    frame.BackgroundTransparency = 0.5
    frame.BackgroundColor3 = color
    frame.Parent = billboard
end

-- Update Loop
game:GetService("RunService").RenderStepped:Connect(function()
    for _, player in pairs(game.Players:GetPlayers()) do
        if player ~= game.Players.LocalPlayer then
            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                if ESP.PlayerESP then
                    if not player.Character.HumanoidRootPart:FindFirstChild("BillboardGui") then
                        CreateESP(player.Character.HumanoidRootPart, Color3.new(1, 0, 0))
                    end
                    player.Character.HumanoidRootPart.BillboardGui.Enabled = true
                else
                    if player.Character.HumanoidRootPart:FindFirstChild("BillboardGui") then
                        player.Character.HumanoidRootPart.BillboardGui.Enabled = false
                    end
                end
            end
        end
    end

    for _, computer in pairs(workspace:GetDescendants()) do
        if computer.Name == "ComputerPart" then
            if ESP.ComputerESP then
                if not computer:FindFirstChild("BillboardGui") then
                    CreateESP(computer, Color3.new(0, 1, 0))
                end
                computer.BillboardGui.Enabled = true
            else
                if computer:FindFirstChild("BillboardGui") then
                    computer.BillboardGui.Enabled = false
                end
            end
        end
    end
end)
