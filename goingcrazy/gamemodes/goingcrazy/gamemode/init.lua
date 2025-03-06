AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_hud.lua")
AddCSLuaFile("cl_view.lua")

include("shared.lua")

function GM:GetFallDamage(ply, speed)
    return (speed / 8)
end

-- hook.Add("PlayerNoClip", "NoClip", function(ply, state) return false end)

function GM:PlayerSpawn(ply)
    ply:SetupHands()
    ply:CrosshairDisable() 
    ply:SetModel("models/player/Group03/male_09.mdl")
    ply:SetPlayerColor(Vector(0.224, 0.322, 0.098))
    ply:SetRunSpeed(200)
    ply:SetWalkSpeed(100)
end