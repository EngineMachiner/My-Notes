
local tex2 = ... or "arrow"

return Def.Sprite{
	Texture=NOTESKIN:GetPath( tex2, '30x4' ),
	Frames = Sprite.LinearFrames( 30*4, 2 ),
	InitCommand=function(self)
		local w = self:GetZoomedWidth()
		local h = self:GetZoomedHeight()
		self:setsize( w * 2, h * 2 )
		self:effectclock("beat")
		self:set_tween_uses_effect_delta(true)
		self:SetTextureFiltering(false)
	end
}
