surface.CreateFont( "sT:comfortaa33", { font = "Comfortaa", size = 33, } )
surface.CreateFont( "sT:comfortaa40", { font = "Comfortaa", size = 33, } )

local function openTaunt()

    local body = vgui.Create('DFrame')
    body:SetSize( 500, 600 )
    body:Center()
    body:SetTitle( '' )
    body:MakePopup()
    body:ShowCloseButton( false )

    function body:Paint( w , h )
        -- Header
		draw.RoundedBoxEx( 16, 0, 0, w, h * 0.1, Color( 32, 32, 32), true, true, false, false )

		draw.SimpleText( 'Taunt', 'sT:comfortaa33', w * 0.05, h * 0.05, Color( 255, 255, 255 ), nil, TEXT_ALIGN_CENTER )

		-- Body
		draw.RoundedBoxEx( 16, 0, h * 0.1, w, h * 0.9, Color(43, 43, 43), false, false, true, true )
    end

    local close = vgui.Create('DButton', body )
	close:SetSize( 40, 40 )
	close:SetPos(  body:GetWide() * 0.95 - 40, body:GetTall() * 0.05 - 20 )
	close:SetText( 'X' )
	close:SetFont( 'sT:comfortaa40' )
	close:SetTextColor( Color(255, 255, 255) )

	function close:Paint( w, h )
	end

	function close:DoClick()
		body:Remove()
	end

    local core = vgui.Create('DScrollPanel', body )
	core:SetPos( body:GetWide() * 0.05, body:GetTall() * 0.1 )
	core:SetSize( body:GetWide() * 0.9, body:GetTall() * 0.9 )

    core:GetVBar():SetWide( 0 )

    local height = body:GetTall() * 0.9 / 13

    local LPlayer = LocalPlayer()
    local arg = DarkRP && RPExtraTeams[ LPlayer:Team() ] || LPlayer:GetUserGroup()

    for _, categ in ipairs( sTaunt['categ'] ) do
        if ( !categ['filter']( arg ) ) then continue end
        if ( _ > 7 ) then break end         -- max for 3  bits

        for __, sound in ipairs( categ['sounds'] ) do
            if ( __ > 127 ) then break end  -- max for 7 bits

            local btn = core:Add('sT:Button')
            btn:Dock( TOP )
            btn:DockMargin( 0, 10, 0, 0 )
            btn:SetHeight( height )
            btn:SetTitle( sound['title'] )
            
            function btn:DoClick()
                sTaunt.SpamProtec( LPlayer, function()
                    body:Remove()

                    net.Start('sTaunt:EmitSound')
                        net.WriteUInt( _, 3 )
                        net.WriteUInt( __, 7 )
                    net.SendToServer()
                end )
            end
        end
    end

end


hook.Add( 'PlayerButtonDown', 'TauntMenu', function( ply , btn )
    if ( !ply:Alive() ) then return end
    if ( !IsFirstTimePredicted() ) then return end
    
    if ( btn == sTaunt['key'] && input.IsButtonDown( btn ) ) then
        openTaunt()
    end

end )

hook.Add( 'OnPlayerChat', 'TaunMenu', function( ply, text )
    if ( ply != LocalPlayer() ) then return end
    if ( !ply:Alive() ) then return end

    if ( string.lower( text ) == sTaunt['command'] ) then
        openTaunt()
        return true
    end

end )