
local tex2 = ... or "arrow"

return Def.ActorFrame{
	
	Def.Sprite{
		Texture=NOTESKIN:GetPath( tex2, '30x16' ),
		Frames = Sprite.LinearFrames( 60, 2 ),
		InitCommand=function(self)
			local w = self:GetZoomedWidth()
			local h = self:GetZoomedHeight()
			self:setsize( w * 2, h * 2 )
			self:effectclock("beat")
			self:set_tween_uses_effect_delta(true)
			self:SetTextureFiltering(false)
		end
	}

}
