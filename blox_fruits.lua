-- ═══════════════════════════════════════════════════════════
-- [[ BLOX FRUITS PRIME | RIGHTS: @kL_ow ]]
-- لفل تلقائي + تنقل بين الجزر + بدون ديسكورد
-- ═══════════════════════════════════════════════════════════

local OWNER = "@kL_ow"

-- إشعار الحقوق
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "⚡ PRIME BLOX | " .. OWNER,
    Text = "تم التحميل | الحقوق محفوظة لـ " .. OWNER,
    Duration = 5
})

-- تحميل سكربت Prime Hub (بدون ديسكورد وبدون مفاتيح)
loadstring(game:HttpGet("https://raw.githubusercontent.com/PrimoScripts/PrimoHub/main/PrimoHub.lua"))()
