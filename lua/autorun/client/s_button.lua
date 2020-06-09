local PANEL = {}

function PANEL:Init()
    self.Text = ''

    self.Hovered  = false
    self.LerpSize = 0
    self:SetText( '' )

    self.Spd = FrameTime() * 0.75
end

function PANEL:SetTitle( arg )
    if ( !arg || !isstring( arg ) ) then return end

    self.Text = arg 
end

function PANEL:Paint( w , h )
    local hovered = self.Hovered

    self.LerpSize = Lerp( self.Spd, self.LerpSize, hovered && w || 0 )
    draw.RoundedBoxEx( 8, 0, 0, w, h, Color(83, 83, 83), true, true, !hovered, ( !hovered && self.LerpSize <= 1 ) )
                
    draw.SimpleText( self.Text, 'sT:comfortaa33', w / 2, h / 2, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
                
    surface.SetDrawColor( Color(255, 255, 255) )
    surface.DrawRect( hovered && 0 || w - self.LerpSize, h-1, self.LerpSize, 1)

end

function PANEL:OnCursorExited()
    self.LerpSize = self:GetWide()
    self.Hovered = false
end

function PANEL:OnCursorEntered()
    self.LerpSize = 0
    self.Hovered = true
end

vgui.Register( 'sT:Button', PANEL, 'DButton' )