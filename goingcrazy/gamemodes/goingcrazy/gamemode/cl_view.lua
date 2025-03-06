hook.Add("CalcView", "ViewBob", function(ply, origin, ang, fov)
    if not IsValid(ply) or not ply:Alive() then return end
    
    local timeFactor = CurTime() * 0.4
    local baseSway = 4 * timeFactor
    local onGround = ply:IsOnGround()
    local velocityLength = ply:GetVelocity():Length2D()

    local function ApplyMovementSway(key, multiplier, angaction)
        if ply:KeyDown(key) then
            local sway = math.sin(baseSway * multiplier)
            ang:RotateAroundAxis(angaction, sway)
        end
    end

    if onGround then
        local groundSway = math.cos(baseSway)
        ang:RotateAroundAxis(ang:Right(), groundSway)

        ApplyMovementSway(IN_FORWARD, 2, ang:Right())
        ApplyMovementSway(IN_BACK, -2, ang:Right())
        ApplyMovementSway(IN_MOVERIGHT, 3, ang:Forward())
        ApplyMovementSway(IN_MOVELEFT, 3, ang:Forward())
    else
        local airSway = math.cos(math.Clamp(velocityLength, 0, 2) * CurTime() * 2)
        ang:RotateAroundAxis(ang:Right(), airSway)
    end

    fov = Lerp(math.Clamp(velocityLength / 240, 0, 1), 95, 105)

    return {angles = ang, fov = fov}
end)