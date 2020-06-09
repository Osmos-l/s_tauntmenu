resource.AddFile("resource/fonts/comfortaa-regular.ttf")

util.AddNetworkString('sTaunt:EmitSound')

local register = sound.Add
for _, categ in ipairs( sTaunt['categ'] ) do
    for __, sound in ipairs( categ['sounds'] ) do
        register( {
            name    = sound['title'],
            channel = CHAN_VOICE_BASE,        -- https://wiki.facepunch.com/gmod/Enums/CHAN
            level   = 60,               -- https://wiki.facepunch.com/gmod/Enums/SNDLVL
            sound   = sound['path']
        } )
    end
end

net.Receive('sTaunt:EmitSound', function( len, ply ) 
    local idCateg = net.ReadUInt( 3 )
    local idSound = net.ReadUInt( 7 )

    -- anti spam protection
    sTaunt.SpamProtec( ply, function()

        local arg = DarkRP && RPExtraTeams[ ply:Team() ] || ply:GetUserGroup()
        if ( !sTaunt['categ'][ idCateg ]['filter']( arg ) ) then return end

        local trSound = sTaunt['categ'][ idCateg ]['sounds'][ idSound ]

        if ( trSound ) then
            ply:EmitSound( trSound['title'] )
        end

    end )

end )