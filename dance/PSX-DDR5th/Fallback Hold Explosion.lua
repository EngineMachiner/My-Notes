return Def.Sprite{
	Texture=NOTESKIN:GetPath("100","dim"),
	InitCommand=function(self)
		local w = self:GetZoomedWidth()
		local h = self:GetZoomedHeight()
		self:setsize( w * 2.75, h * 2.75 )
		self:SetTextureFiltering(false)
		self:blend("BlendMode_Add")
		self:diffuse(Color.White)
		self:diffusealpha(0)
	end,
	HeldCommand=function(self)
		self:stoptweening()
		self:smooth( 0.125 ):diffusealpha(0.375)
		self:smooth( 0.25 ):diffusealpha(0)
	end
}