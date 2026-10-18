-- ═══════════════════════════════════════════════════════════
-- [[ OMEGA FINAL FIX | RIGHTS: @kL_ow ]]
-- قائمة قابلة للسحب + زرين فقط + بدون أي أخطاء
-- ═══════════════════════════════════════════════════════════

local OWNER = "@kL_ow"
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local LP = Players.LocalPlayer

game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "👑 OMEGA FINAL",
    Text = "تم التحميل | الحقوق لـ " .. OWNER,
    Duration = 5
})

-- حقوقك في النص
local Watermark = Instance.new("TextLabel")
Watermark.Size = UDim2.new(0, 500, 0, 30)
Watermark.Position = UDim2.new(0.5, -250, 0, 5) 
Watermark.BackgroundTransparency = 1
Watermark.Text = "👑 " .. OWNER .. " | TG: " .. OWNER
Watermark.TextColor3 = Color3.fromRGB(255, 215, 0) 
Watermark.TextStrokeTransparency = 0.5
Watermark.Font = Enum.Font.GothamBold
Watermark.TextSize = 16
Watermark.Parent = game.CoreGui

-- القائمة
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game.CoreGui
ScreenGui.Name = "OmegaFinal"

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 200, 0, 150)
MainFrame.Position = UDim2.new(0, 20, 0.5, -75)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Parent = ScreenGui
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)
Instance.new("UIStroke", MainFrame).Color = Color3.fromRGB(255, 215, 0)

-- شريط السحب
local TopBar = Instance.new("Frame", MainFrame)
TopBar.Size = UDim2.new(1, 0, 0, 30)
TopBar.BackgroundColor3 = Color3.fromRGB(30, 25, 10)
TopBar.BorderSizePixel = 0
Instance.new("UICorner", TopBar).CornerRadius = UDim.new(0, 10)

local Title = Instance.new("TextLabel", TopBar)
Title.Size = UDim2.new(1, -40, 1, 0)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.Text = "👑 OMEGA | " .. OWNER
Title.TextColor3 = Color3.fromRGB(255, 215, 0)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.TextSize = 12
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TopBar

-- زر الإغلاق
local CloseBtn = Instance.new("TextButton", TopBar)
CloseBtn.Size = UDim2.new(0, 20, 0, 20)
CloseBtn.Position = UDim2.new(1, -25, 0, 5)
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 40, 40)
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.new(1,1,1)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 10
CloseBtn.Parent = TopBar
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(1, 0)

-- السحب
local dragging, dragInput, dragStart, startPos
TopBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then dragging = false end
        end)
    end
end)
TopBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)
UIS.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

CloseBtn.MouseButton1Click:Connect(function() MainFrame.Visible = false end)

-- القتل التلقائي
local AutoFarm = false

local function GetMyLevel()
    local stats = LP:FindFirstChild("leaderstats")
    if stats then
        local level = stats:FindFirstChild("Level")
        if level then return level.Value end
    end
    return 1
end

local function StartAutoFarm()
    task.spawn(function()
        while AutoFarm do
            task.wait(0.1)
            local hrp = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                local myLevel = GetMyLevel()
                local bestEnemy, shortestDist = nil, math.huge
                for _, v in pairs(workspace:GetDescendants()) do
                    if v:IsA("Humanoid") and v.Parent ~= LP.Character and v.Health > 0 then
                        local t = v.Parent:FindFirstChild("HumanoidRootPart")
                        if t then
                            local enemyLevel = 1
                            local levelObj = v.Parent:FindFirstChild("Level") or (v.Parent:FindFirstChild("leaderstats") and v.Parent.leaderstats:FindFirstChild("Level"))
                            if levelObj then enemyLevel = levelObj.Value end
                            if enemyLevel >= (myLevel - 50) and enemyLevel <= (myLevel + 100) then
                                local dist = (t.Position - hrp.Position).Magnitude
                                if dist < shortestDist and dist < 1000 then
                                    shortestDist = dist
                                    bestEnemy = t
                                end
                            end
                        end
                    end
                end
                if bestEnemy then
                    hrp.CFrame = CFrame.new(bestEnemy.Position + Vector3.new(0, 5, 0))
                    local tool = LP.Character:FindFirstChildWhichIsA("Tool")
                    if tool then tool:Activate() end
                else
                    hrp.CFrame = hrp.CFrame + Vector3.new(math.random(-300, 300), 50, math.random(-300, 300))
                end
            end
        end
    end)
end

-- الأزرار
local function makeBtn(text, y, cb, color)
    local b = Instance.new("TextButton", MainFrame)
    b.Size = UDim2.new(1, -20, 0, 40)
    b.Position = UDim2.new(0, 10, 0, y)
    b.BackgroundColor3 = color
    b.TextColor3 = Color3.new(1,1,1)
    b.Text = text
    b.Font = Enum.Font.GothamBold
    b.TextSize = 12
    b.Parent = MainFrame
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 8)
    b.MouseButton1Click:Connect(function() pcall(cb) end)
end

makeBtn("▶️ تشغيل", 40, function()
    if not AutoFarm then
        AutoFarm = true
        StartAutoFarm()
    end
end, Color3.fromRGB(40, 150, 40))

makeBtn("⏹️ إيقاف", 90, function()
    AutoFarm = false
end, Color3.fromRGB(150, 40, 40))
