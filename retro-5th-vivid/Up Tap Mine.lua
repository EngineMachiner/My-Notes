return Def.Sprite{
	Texture=NOTESKIN:GetPath( "", "mines 8x1" ),
	Frames={ { Frame=2 } },
	InitCommand=function(self)
		local w = self:GetZoomedWidth()
		local h = self:GetZoomedHeight()
		self:setsize( w * 2, h * 2 )
		self:SetTextureFiltering(false)
		self:diffuseshift()
		self:effectcolor1(color("1,1,1,1"))
		self:effectcolor2(color("#00FFFF"))
	end
}
