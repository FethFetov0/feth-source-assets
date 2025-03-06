surface.CreateFont("crazy_hud_font", {
    font = "Indie Flower",
    size = 125,
    weight = 600,
    outline = true
})

function DrawHealth(ply)
    local DEFAULT_HP_COLOR = Color(197, 197, 197)
    local LOW_HP_COLOR = Color(106, 0, 0)
    local CHANGE_HP_COLOR

    local hp = ply:Health()

    if hp <= 20 then
        CHANGE_HP_COLOR = LOW_HP_COLOR
    else
        CHANGE_HP_COLOR = DEFAULT_HP_COLOR
    end
    draw.SimpleText(hp, "crazy_hud_font", 100, ScrH() - 50, CHANGE_HP_COLOR, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    if hp <= 20 then
        
    end
end

function DrawAmmo(ply, weapon)
    if IsValid(weapon) and weapon:GetPrintName() != nil and weapon:Clip1() != -1 then
        local DEFAULT_AMMO_COLOR = Color(197, 197, 197)
        local LOW_AMMO_COLOR = Color(92, 92, 92, 140)
        local CHANGE_AMMO_COLOR

        if weapon:Clip1() <= 10 then
            CHANGE_AMMO_COLOR = LOW_AMMO_COLOR
        else
            CHANGE_AMMO_COLOR = DEFAULT_AMMO_COLOR
        end

        draw.SimpleText(weapon:Clip1() .. "/" .. ply:GetAmmoCount(weapon:GetPrimaryAmmoType()), "crazy_hud_font", ScrW() - 100, ScrH() - 50, CHANGE_AMMO_COLOR, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end
end

function HUD()
    local ply = LocalPlayer()

    if IsValid(ply) and ply:Alive() then
        local weapon = ply:GetActiveWeapon()
        local vignette = Material("hud/vignette.png")

        render.SetMaterial(vignette)
        render.DrawScreenQuad()

        DrawHealth(ply)
        DrawAmmo(ply, weapon)

        if ply:Health() <= 10 then
            DrawMotionBlur(0.35, 2, 0.01)
        end
    end
end

hook.Add("HUDPaint", "GMHud", HUD)

function HideHud(name)
    for _, v in pairs({"CHudHealth", "CHudBattery", "CHudAmmo", "CHudSecondaryAmmo"}) do
        if name == v then
            return false
        end
    end
end

hook.Add("HUDShouldDraw", "HideDefaultHUD", HideHud)

function GM:DrawDeathNotice(x, y)
end