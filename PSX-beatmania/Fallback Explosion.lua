
local sButton = Var "Button"
local sPlayer = Var "Player"
local sType = GAMESTATE:GetCurrentSteps(sPlayer):GetStepsType()
local lim = sType:sub(#sType)

local add = {
	InitCommand=function(self)
		self.alpha = self.alpha or 1
		self.t = 0.25 * 1.125
		local states = self:GetNumStates()
		if states > 1 then self.t = self.t / states end
		self:diffusealpha(0):animate(false)
		self:SetAllStateDelays(self.t)
	end,
	W1Command=function(self)
		local tween = 0.125
		local t = self:GetAnimationLengthSeconds() - tween * 2
		self:finishtweening()
		self:playcommand("Animate")
		self:linear(tween):diffusealpha(self.alpha)
		self:sleep(t):linear(tween):diffusealpha(0)
		self:queuecommand("Stop")
	end,
	AnimateCommand=function(self) self:animate(true):setstate(0) end,
	StopCommand=function(self) self:animate(false) end
}
add.W2Command = add.W1Command

local HitMine = NOTESKIN:GetPath( "Global", "HitMine Explosion.lua" )
HitMine = LoadActor( HitMine )
HitMine = HitMine .. add
HitMine.HitMineCommand = add.W1Command
HitMine.W1Command = nil		HitMine.W2Command = nil

local dim = NOTESKIN:GetPath( "Global", "Tap Explosion Dim.lua" )
dim = LoadActor( dim ) .. add

return Def.ActorFrame{ dim,	HitMine }
