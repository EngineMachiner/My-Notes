return Def.Sprite{
	Texture="_ScratchMine 1x3 (res 98x63).png",
	Frames = {
		{ Frame = 0, Delay = 0.25 },		{ Frame = 1, Delay = 0.25 },
		{ Frame = 2, Delay = 4 }
	},
	InitCommand=function(self)
		self:effectclock('beat')
		self:SetTextureFiltering(false)
	end
}