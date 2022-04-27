
local function RandomColors()
	local c = {}
	while #c < 4 do
		c[#c+1] = tostring( math.random(0,1000) * 0.003 ) .. ","
	end
	return c[1] .. c[2] .. c[3] .. "1"

end

local t = Def.Sprite{
	Texture=NOTESKIN:GetPath("100","dim"),
	InitCommand=function(self)
		local w = self:GetZoomedWidth()
		local h = self:GetZoomedHeight()
		self:setsize( w * 2.75, h * 2.75 )
		self:SetTextureFiltering(false)
		self:blend("BlendMode_Add")
		self:diffuse(Color.White)
		self:diffusealpha(0)
	end
}

for i = 1,3 do
	t["W"..tostring(i).."Command"] = function(self)
		self.Beat = self.Beat or GAMESTATE:GetSongBeat()
		self.Color = self.Color or RandomColors()
		if self.Beat ~= GAMESTATE:GetSongBeat() then
			self.Color = RandomColors()
		end
		self:stoptweening()
		self:diffuse(color(self.Color))
		self:smooth( 0.375 ):diffusealpha(0)
	end
end

return Def.ActorFrame{ t }
