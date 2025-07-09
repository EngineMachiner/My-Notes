return Def.Sprite{
	Texture=NOTESKIN:GetPath( "hold", "inactive" ),
	InitCommand=function(self)
		local w = self:GetZoomedWidth()
		local h = self:GetZoomedHeight()
		self:setsize( w * 2, h * 2 )
		self:SetTextureFiltering(false)
	end
}
