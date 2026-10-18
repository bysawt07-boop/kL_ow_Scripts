-- ═══════════════════════════════════════════════════════════
-- [[ BLOX FRUITS BANANA CAT | RIGHTS: @kL_ow ]]
-- سكربت أسطوري: لف تلقائي + جمع مستوى + تنقل بين الجزر
-- ═══════════════════════════════════════════════════════════

local OWNER = "@kL_ow"
local Players = game:GetService("Players")
local LP = Players.LocalPlayer

-- إشعار الحقوق
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "🍌 BANANA CAT | " .. OWNER,
    Text = "تم التحميل | الحقوق لـ " .. OWNER,
    Duration = 5
})

-- تحميل سكربت Banana Cat الأصلي
local success, err = pcall(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/VoidDeveloper67/VoidHub/refs/heads/main/Void"))()
end)

if not success then
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "❌ خطأ",
        Text = "فشل تحميل السكربت الأساسي. تأكد من اتصالك.",
        Duration = 5
    })
end
