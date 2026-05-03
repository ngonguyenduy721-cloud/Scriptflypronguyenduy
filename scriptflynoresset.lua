-- Nguyenduydz FLY + FPS FULL FINAL

local player = game.Players.LocalPlayer
local UIS = game:GetService("UserInputService")
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
gui.Name = "NguyenduydzFly"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

-- ===== FPS =====
local fpsLabel = Instance.new("TextLabel")
fpsLabel.Parent = gui
fpsLabel.Size = UDim2.new(0,100,0,30)
fpsLabel.Position = UDim2.new(0.8,0,0.02,0)

fpsLabel.BackgroundColor3 = Color3.fromRGB(25,25,25)
fpsLabel.TextColor3 = Color3.new(1,1,1)
fpsLabel.Text = "FPS: 0"

Instance.new("UICorner", fpsLabel)

local frames = 0
local last = tick()

-- ===== OPEN BUTTON =====
local openBtn = Instance.new("TextButton")
openBtn.Parent = gui

openBtn.Size = UDim2.new(0,100,0,35)
openBtn.Position = UDim2.new(0.02,0,0.3,0)

openBtn.Text = "Nguyenduydz"

openBtn.BackgroundColor3 = Color3.fromRGB(0,170,255)
openBtn.TextColor3 = Color3.new(1,1,1)

openBtn.Active = true
openBtn.Draggable = true

Instance.new("UICorner", openBtn)

-- ===== MENU =====
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

-- ===== FLY BUTTON =====
local flyBtn = Instance.new("TextButton")
flyBtn.Parent = frame

flyBtn.Size = UDim2.new(1,-10,0,35)
flyBtn.Position = UDim2.new(0,5,0,35)

flyBtn.Text = "Fly: OFF"

-- ===== SPEED + =====
local plus = Instance.new("TextButton")
plus.Parent = frame

plus.Size = UDim2.new(0.45,0,0,35)
plus.Position = UDim2.new(0.05,0,0,80)

plus.Text = "+ Speed"

-- ===== SPEED - =====
local minus = Instance.new("TextButton")
minus.Parent = frame

minus.Size = UDim2.new(0.45,0,0,35)
minus.Position = UDim2.new(0.5,0,0,80)

minus.Text = "- Speed"

-- ===== SPEED LABEL =====
local speedLabel = Instance.new("TextLabel")
speedLabel.Parent = frame

speedLabel.Size = UDim2.new(1,0,0,25)
speedLabel.Position = UDim2.new(0,0,0,120)

speedLabel.BackgroundTransparency = 1
speedLabel.TextColor3 = Color3.new(1,1,1)

speedLabel.Text = "Speed: 1"

-- ===== UP =====
local upBtn = Instance.new("TextButton")
upBtn.Parent = frame

upBtn.Size = UDim2.new(1,-10,0,35)
upBtn.Position = UDim2.new(0,5,0,145)

upBtn.Text = "UP"

-- ===== DOWN =====
local downBtn = Instance.new("TextButton")
downBtn.Parent = frame

downBtn.Size = UDim2.new(1,-10,0,35)
downBtn.Position = UDim2.new(0,5,0,185)

downBtn.Text = "DOWN"

-- ===== STATES =====
local flyOn = false
local speed = 1

local upHold = false
local downHold = false

-- ===== OPEN MENU =====
openBtn.MouseButton1Click:Connect(function()
    frame.Visible = not frame.Visible
end)

-- ===== FLY TOGGLE =====
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

    speed = math.max(1, speed - 1)

    speedLabel.Text = "Speed: "..speed

end)

-- ===== HOLD =====
upBtn.MouseButton1Down:Connect(function()
    upHold = true
end)

upBtn.MouseButton1Up:Connect(function()
    upHold = false
end)

downBtn.MouseButton1Down:Connect(function()
    downHold = true
end)

downBtn.MouseButton1Up:Connect(function()
    downHold = false
end)

-- ===== LOOP =====
RunService.RenderStepped:Connect(function()

    -- FPS
    frames += 1

    if tick() - last >= 1 then
        fpsLabel.Text = "FPS: "..frames
        frames = 0
        last = tick()
    end

    -- FLY
    if not flyOn then return end
    if not char then return end

    local root = char:FindFirstChild("HumanoidRootPart")

    if not root then return end

    local cam = workspace.CurrentCamera
    local moveDirection = Vector3.zero

    if UIS:IsKeyDown(Enum.KeyCode.W) then
        moveDirection += cam.CFrame.LookVector
    end

    if UIS:IsKeyDown(Enum.KeyCode.S) then
        moveDirection -= cam.CFrame.LookVector
    end

    if UIS:IsKeyDown(Enum.KeyCode.A) then
        moveDirection -= cam.CFrame.RightVector
    end

    if UIS:IsKeyDown(Enum.KeyCode.D) then
        moveDirection += cam.CFrame.RightVector
    end

    if upHold then
        moveDirection += Vector3.new(0,1,0)
    end

    if downHold then
        moveDirection -= Vector3.new(0,1,0)
    end

    if moveDirection.Magnitude > 0 then
        root.Velocity = moveDirection.Unit * (speed * 25)
    else
        root.Velocity = Vector3.zero
    end

end)