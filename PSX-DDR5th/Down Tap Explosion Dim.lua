
local t = Def.ActorFrame{}

local tex, tex2 = ...

tex = tex or "arrow"
tex2 = tex2 or "click"

local c = {
	color("1,1,1,1"),
	color("1,1,0.55,1"),
	color("0.55,1,0.55,1")
}

for i=1,3 do
	
	t[i] = Def.Sprite{
		Texture=tex2 .. ".png",
		BrightCommand=function(self) self.Lock = true end,
		DimCommand=function(self) self.Lock = false end,
		InitCommand=function(self)
			
			local s = i == 3 and 2.25 or 2
			local w = self:GetZoomedWidth()
			local h = self:GetZoomedHeight()

			self:setsize( w * s, h * s )
			self:SetTextureFiltering(false)

			if i == 3 then
				self:GetParent():diffusealpha(0)
				self:blend('add')
			end

		end,
		HoldingOnCommand=function(self)
			local p = self:GetParent()
			p:stoptweening()
			p:diffusealpha(0.5)
			self:stoptweening():diffuse(Color.White)
			self:queuecommand("Zoomin")
		end,
		ZoominCommand=function(self)
			self:linear(0.125):zoom( 1.25 )
			self:linear(0.125):zoom( 1 )
			self:queuecommand("Zoomin")
		end,
		HoldingOffCommand=function(self)
			local p = self:GetParent()
			self:stoptweening()
			p:stoptweening()
			p:smooth( 0.25 * 1.25 ):diffusealpha(0)
		end,
		HeldCommand=function(self)
			local p = self:GetParent()
			self:stoptweening():zoom(0.75)
			p:stoptweening()
			p:smooth( 0.25 * 1.25 ):diffusealpha(0)
		end
	}

	t[i].RollOnCommand=t[i].HoldingOnCommand
	t[i].RollOffCommand=t[i].HoldingOffCommand

	if i == 3 then
		t[i].Texture = tex .. ' 30x4.png'
		t[i].Frames = Sprite.LinearFrames( 30, 1 )
	end

	for j=1,3 do
		local s = tostring(j)
		t[i]["W"..s.."Command"] = function(self)
			
			if not self.Lock then
				self:stoptweening()
				self:zoom(1):diffuse(c[j])

				if i == 3 then
					self:diffusealpha(0.5)
				end

				self:linear(0.125):zoom( 1.25 )

				local p = self:GetParent()
				p:stoptweening()
				p:diffusealpha(1)
				p:smooth( 0.25 * 1.25 ):diffusealpha(0)
			end

		end
	end

end

return Def.ActorFrame{ t }