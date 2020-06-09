function sTaunt.SpamProtec( ply, callback )
    if ( !ply || !ply:IsPlayer() || !ply:Alive() ) then return end
    
    local cTime = CurTime()
    ply.sTauntNextEmit = ply.sTauntNextEmit || 0

    if ( cTime < ply.sTauntNextEmit ) then
        if CLIENT then
            notification.AddLegacy( sTaunt['wait'], NOTIFY_ERROR, 2 )
        end
        return 
    end 

    ply.sTauntNextEmit = cTime + sTaunt['interval']

    if ( callback ) then
        callback()
    end
end