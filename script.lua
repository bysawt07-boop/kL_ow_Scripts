-- ═══════════════════════════════════════════════════════════
-- [[ BLOX FRUITS AUTO FARM | RIGHTS: @kL_ow ]]
-- المميزات: ضرب تلقائي + طيران + حماية
-- ═══════════════════════════════════════════════════════════

local OWNER = "@kL_ow"
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LP = Players.LocalPlayer

local State = { KillAura = false, Fly = false, GodMode = true }

-- إشعار الحقوق
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "⚡ BLOX FRUITS FARM",
    Text = "تم التحميل | الحقوق لـ " .. OWNER,
    Duration = 5
})

-- واجهة
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game.CoreGui
ScreenGui.Name = "BloxFruitsFarm"

local Btn = Instance.new("TextButton", ScreenGui)
Btn.Size = UDim2.new(0, 60, 0, 60)
Btn.Position = UDim2.new(0, 20, 0.5, -30)
Btn.BackgroundColor3 = Color3.fromRGB(15, 10, 20)
Btn.Text = "🍎"
Btn.TextColor3 = Color3.fromRGB(255, 50, 50)
Btn.TextSize = 30
Btn.Font = Enum.Font.GothamBlack
Btn.Parent = ScreenGui
Instance.new("UICorner", Btn).CornerRadius = UDim.new(1, 0)

local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 250, 0, 200)
Frame.Position = UDim2.new(0, 50, 0.5, -100)
Frame.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
Frame.Visible = false
Frame.Parent = ScreenGui
Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 12)
Instance.new("UIStroke", Frame).Color = Color3.fromRGB(255, 50, 50)

local Title = Instance.new("TextLabel", Frame)
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Text = "🍎 BLOX FRUITS | " .. OWNER
Title.TextColor3 = Color3.fromRGB(255, 50, 50)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.Parent = Frame

local function getHRP() return LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") end
local function getHum() return LP.Character and LP.Character:FindFirstChildOfClass("Humanoid") end

-- 1. الحماية (ما تموت)
task.spawn(function()
    while true do
        task.wait(1)
        local h = getHum()
        if h then h.MaxHealth = math.huge; h.Health = math.huge end
    end
end)

-- 2. الضرب التلقائي (Kill Aura)
task.spawn(function()
    while true do
        task.wait(0.1)
        if State.KillAura then
            local hrp = getHRP()
            if hrp then
                for _, v in pairs(workspace:GetDescendants()) do
                    if v:IsA("Humanoid") and v.Parent ~= LP.Character and v.Health > 0 then
                        local t = v.Parent:FindFirstChild("HumanoidRootPart")
                        if t and (t.Position - hrp.Position).Magnitude < 50 then
                            local tool = LP.Character:FindFirstChildWhichIsA("Tool")
                            if tool then tool:Activate() end
                        end
                    end
                end
            end
        end
    end
end)

-- 3. الطيران (Fly)
task.spawn(function()
    while true do
        task.wait()
        if State.Fly then
            local hrp = getHRP()
            if hrp then
                if not hrp:FindFirstChild("FlyBV") then
                    local bv = Instance.new("BodyVelocity", hrp)
                    bv.Name = "FlyBV"; bv.MaxForce = Vector3.new(1e5, 1e5, 1e5)
                    local cam = workspace.CurrentCamera
                    local UIS = game:GetService("UserInputService")
                    task.spawn(function()
                        while hrp:FindFirstChild("FlyBV") and State.Fly do
                            task.wait()
                            local mv = Vector3.zero
                            if UIS:IsKeyDown(Enum.KeyCode.W) then mv = mv + cam.CFrame.LookVector end
                            if UIS:IsKeyDown(Enum.KeyCode.S) then mv = mv - cam.CFrame.LookVector end
                            if UIS:IsKeyDown(Enum.KeyCode.A) then mv = mv - cam.CFrame.RightVector end
                            if UIS:IsKeyDown(Enum.KeyCode.D) then mv = mv + cam.CFrame.RightVector end
                            if UIS:IsKeyDown(Enum.KeyCode.Space) then mv = mv + Vector3.new(0,1,0) end
                            bv.Velocity = mv * 150
                        end
                    end)
                end
            end
        else
            local hrp = getHRP()
            if hrp and hrp:FindFirstChild("FlyBV") then hrp.FlyBV:Destroy() end
        end
    end
end)

-- الأزرار
local function makeBtn(text, y, cb)
    local b = Instance.new("TextButton", Frame)
    b.Size = UDim2.new(1, -20, 0, 40)
    b.Position = UDim2.new(0, 10, 0, y)
    b.BackgroundColor3 = Color3.fromRGB(40, 20, 20)
    b.TextColor3 = Color3.new(1,1,1)
    b.Text = text
    b.Font = Enum.Font.GothamBold
    b.Parent = Frame
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 8)
    b.MouseButton1Click:Connect(function() pcall(cb) end)
end

makeBtn("⚔️ تشغيل/إيقاف الضرب التلقائي", 50, function()
    State.KillAura = not State.KillAura
end)

makeBtn("🦅 تشغيل/إيقاف الطيران", 100, function()
    State.Fly = not State.Fly
end)

Btn.MouseButton1Click:Connect(function() Frame.Visible = not Frame.Visible end)
