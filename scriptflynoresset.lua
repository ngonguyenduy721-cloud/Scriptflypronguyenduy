-- Nguyenduydz OLD FLY FIX (BAY ĐƯỢC + KHÔNG MẤT KHI CHẾT)

local player = game.Players.LocalPlayer
local RunService = game:GetService("RunService")

-- ===== CHARACTER FIX =====
local char

local function setupCharacter(c)
    char = c
end

if player.Character then
    setupCharacter(player.Character)
end

player.CharacterAdded:Connect(function(c)
    setupCharacter(c)
end)

-- ===== GUI =====
local gui = Instance.new("ScreenGui")
gui.Parent = player.PlayerGui
gui.ResetOnSpawn = false

-- ===== FPS =====
local fps = Instance.new("TextLabel")
fps.Parent = gui
fps.Size = UDim2.new(0,100,0,30)
fps.Position = UDim2.new(0.8,0,0.02,0)

fps.BackgroundColor3 = Color3.fromRGB(20,20,20)
fps.TextColor3 = Color3.new(1,1,1)

fps.Text = "FPS: 0"

Instance.new("UICorner", fps)

local frames = 0
local last = tick()

-- ===== OPEN =====
local open = Instance.new("TextButton")
open.Parent = gui

open.Size = UDim2.new(0,100,0,35)
open.Position = UDim2.new(0.02,0,0.3,0)

open.Text = "Nguyenduydz"

open.BackgroundColor3 = Color3.fromRGB(0,170,255)
open.TextColor3 = Color3.new(1,1,1)

open.Active = true
open.Draggable = true

Instance.new("UICorner", open)

-- ===== FRAME =====
local frame = Instance.new("Frame")
frame.Parent = gui

frame.Size = UDim2.new(0,180,0,220)
frame.Position = UDim2.new(0.15,0,0.3,0)

frame.BackgroundColor3 = Color3.fromRGB(25,25,25)

frame.Visible = false
frame.Active = true
frame.Draggable = true

Instance.new("UICorner", frame)

-- ===== TITLE =====
local title = Instance.new("TextLabel")
title.Parent = frame

title.Size = UDim2.new(1,0,0,25)

title.Text = "Nguyenduydz Fly"

title.BackgroundTransparency = 1
title.TextColor3 = Color3.new(1,1,1)

title.TextScaled = true

-- ===== FLY =====
local flyBtn = Instance.new("TextButton")
flyBtn.Parent = frame

flyBtn.Size = UDim2.new(1,-10,0,35)
flyBtn.Position = UDim2.new(0,5,0,35)

flyBtn.Text = "Fly: OFF"

-- ===== PLUS =====
local plus = Instance.new("TextButton")
plus.Parent = frame

plus.Size = UDim2.new(0.45,0,0,35)
plus.Position = UDim2.new(0.05,0,0,80)

plus.Text = "+ Tốc độ"

-- ===== MINUS =====
local minus = Instance.new("TextButton")
minus.Parent = frame

minus.Size = UDim2.new(0.45,0,0,35)
minus.Position = UDim2.new(0.5,0,0,80)

minus.Text = "- Tốc độ"

-- ===== SPEED =====
local speedLabel = Instance.new("TextLabel")
speedLabel.Parent = frame

speedLabel.Size = UDim2.new(1,0,0,25)
speedLabel.Position = UDim2.new(0,0,0,120)

speedLabel.BackgroundTransparency = 1
speedLabel.TextColor3 = Color3.new(1,1,1)

speedLabel.Text = "Speed: 1"

-- ===== UP =====
local up = Instance.new("TextButton")
up.Parent = frame

up.Size = UDim2.new(1,-10,0,35)
up.Position = UDim2.new(0,5,0,145)

up.Text = "UP"

-- ===== DOWN =====
local down = Instance.new("TextButton")
down.Parent = frame

down.Size = UDim2.new(1,-10,0,35)
down.Position = UDim2.new(0,5,0,185)

down.Text = "DOWN"

-- ===== STATES =====
local flyOn = false
local speed = 1

local upHold = false
local downHold = false

-- ===== OPEN =====
open.MouseButton1Click:Connect(function()
    frame.Visible = not frame.Visible
end)

-- ===== FLY =====
flyBtn.MouseButton1Click:Connect(function()

    flyOn = not flyOn

    flyBtn.Text = flyOn and "Fly: ON" or "Fly: OFF"

end)

-- ===== SPEED =====
plus.MouseButton1Click:Connect(function()

    speed = speed + 1

    speedLabel.Text = "Speed: "..speed

end)

minus.MouseButton1Click:Connect(function()

    speed = math.max(1,speed - 1)

    speedLabel.Text = "Speed: "..speed

end)

-- ===== HOLD =====
up.MouseButton1Down:Connect(function()
    upHold = true
end)

up.MouseButton1Up:Connect(function()
    upHold = false
end)

down.MouseButton1Down:Connect(function()
    downHold = true
end)

down.MouseButton1Up:Connect(function()
    downHold = false
end)

-- ===== LOOP =====
RunService.RenderStepped:Connect(function()

    -- FPS
    frames += 1

    if tick() - last >= 1 then

        fps.Text = "FPS: "..frames

        frames = 0
        last = tick()

    end

    -- FLY
    if not flyOn then return end
    if not char then return end

    local root = char:FindFirstChild("HumanoidRootPart")

    if not root then return end

    local move = Vector3.new()

    if upHold then
        move += Vector3.new(0,speed,0)
    end

    if downHold then
        move -= Vector3.new(0,speed,0)
    end

    root.Velocity = move

end)