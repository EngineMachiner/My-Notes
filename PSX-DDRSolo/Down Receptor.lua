
local tex = ... or "notefield 2x1"

local t = Def.ActorFrame{}

t[#t+1] = Def.Sprite {
	Texture=tex .. ".png",
	InitCommand=function(self)
		self.p = self:GetParent()
		self.p:stoptweening():zoom(1.875)
		self.p:diffuse(color("0.75,0.75,0.75,1"))
		self:effectclock("beat")
		self:set_tween_uses_effect_delta(true)
		self:SetTextureFiltering(false)
		self:animate(false):setstate(1)
		self:sleep(2):queuecommand("Animate")
	end,
	AnimateCommand=function(self)
		self.p:diffuse(color("1,1,1,1"))
		self.p:zoom(2)
		self:animate(true)
		self:SetStateProperties( {
			{ Frame=0, Delay=0.25 },
			{ Frame=1, Delay=0.75 }
		} )
	end,
	ZoominCommand=function(self)
		self.p:stoptweening()
		self.p:zoom( 2 * 0.75 ):linear(0.12)
		self.p:zoom( 2 )
	end
}

for i=1,5 do
	t[#t]["W"..tostring(i).."Command"]=function(self)
		if i < 4 then
			self.p:stoptweening()
			self.p:linear(0.12):zoom(2)
		else
			self.p:stoptweening()
			self.p:sleep(0.05):queuecommand("Zoomin")
		end
	end
end

return Def.ActorFrame{ t }
