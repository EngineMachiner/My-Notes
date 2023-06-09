
local Button, Player = Var "Button", Var "Player"

-- Based on NoteSkin.lua
local Buttons = { scratch = "Red" }

for i=1,7 do
	if i % 2 == 0 then Buttons['Key' .. i] = 'Blue' end
	if ( i + 1 ) % 2 == 0 then Buttons['Key' .. i] = 'White' end
end

Buttons['Key1'] = 'First'

local sType = GAMESTATE:GetCurrentSteps(Player):GetStepsType()
local lastKey = sType:sub(#sType)

-- Mark last key
if Button:sub(#Button) == lastKey then Buttons[Button] = "Last" end

local Reverse = GAMESTATE:GetPlayerState(Player)
Reverse = Reverse:GetPlayerOptions("ModsLevel_Preferred")
Reverse = Reverse:Reverse() == 1

local moreFuncs = {
	First = function(self)
		self:zoomx( self:GetZoomX() * 1.15 )
		self:x( self:GetZoomedWidth() * 0.15 )
	end,
	Blue = function(self) 
		self:x( self:GetZoomedWidth() * 0.108 )
	end,
	White = function(self)
		self:zoomx( self:GetZoomX() * 1.25 ):x( - 1 )
	end,
	Last = function(self) 
		self:zoomx( self:GetZoomX() * 1.15 )
		self:x( - self:GetZoomedWidth() * 0.15 )
	end
}

local keyFunc = {
	InitCommand=function(self)

		self:SetTextureFiltering(false)

		if Button == 'scratch' then
			self:zoom(1.69)
			self:y( self:GetZoomedHeight() * 0.5 )
			return 
		end

		self:vertalign(top)
		self:zoomx( 1.6 * 1.725 ):zoomy( 2.3 * 1.69 )
		local func = moreFuncs[ Buttons[Button] ]
		if func then func(self) end
		
	end
}

local function moveColumns(notefield)

	if notefield then

		local screen = SCREENMAN:GetTopScreen()
		local columnT = notefield:get_column_actors()
		
		local a = 5.75
		if screen:GetName():match('Gameplay') then a = 17 end

		if sType:match('Single5') then
			columnT[6]:x( columnT[6]:GetX() + a ) 
		end

		if sType:match('Single7') then
			columnT[1]:x( columnT[1]:GetX() - a )
			notefield:x( notefield:GetX() + a )
		end

		a = 2.8
		if screen:GetName():match('Gameplay') then a = 8.5 end

		if sType:match('Double5') then

			columnT[6]:x( columnT[6]:GetX() + a )
			columnT[12]:x( columnT[12]:GetX() + a )

			if screen:GetName():match('Gameplay') then 
				notefield:x( notefield:GetX() - 15 )
			end

			for i = 7, 12 do
				columnT[i]:x( columnT[i]:GetX() + 26 )
			end

		end

		if sType:match('Double7') then
			
			columnT[1]:x( columnT[1]:GetX() - a )
			notefield:x( notefield:GetX() + a )
			columnT[16]:x( columnT[16]:GetX() + a )

			if screen:GetName():match('Gameplay') then 
				notefield:x( notefield:GetX() - 18 )
			end

			for i = 9, 16 do
				columnT[i]:x( columnT[i]:GetX() + 16 )
			end

		end

	end

end

-- Main
local t = Def.ActorFrame {
	OnCommand=function(self)

		self:zoomy(Reverse and -1 or 1)
		
		-- Move columns once
		if Button == 'Key1' then
			local screen = SCREENMAN:GetTopScreen()

			-- Move in ScreenEditor
			local editNotefield = screen:GetChild("EditNoteField")
			moveColumns(editNotefield)

			local notefield = screen:GetChild("PlayerP1")

			-- Move in Gameplay and ScreenEditor gameplay state
			if notefield then 

				notefield = notefield:GetChild("NoteField") 

				if sType:match('Double7') or sType:match('Double5') then 
					
					if editNotefield then
						notefield:x( self:GetX() - 50 )
					end

					if notefield and sType:match('Double7')
					and screen:GetName():match('Gameplay') then
						notefield:y( self:GetY() - 29 )
					end

				end

			end
			moveColumns(notefield)

		end

	end
}

-- Distance offset between grid and light
local distance = 4.5

-- This quad needs to be on the overlay layer
local bgQuad = Def.Quad{
	InitCommand=function(self)

		self:diffuse(Color.Black)
		self:diffusealpha(0.75):fadetop(0.25)

		local spacing = 75
		if lastKey == '7' then 
			spacing = 94	self:x( 25 )
		end
		self:setsize(spacing, 128)
		
		self:x( self:GetX() + 120 ):zoom(3.75)
		self:y( - self:GetZoomedHeight() * 0.5 + distance )

	end
}

-- Column var starts at 0
local columnN, setNum = Var 'Column', '1'
columnN = tonumber(columnN)
if ( columnN > 5 and sType:match('Double5') )
or ( columnN > 7 and sType:match('Double7') ) then
	setNum = '2'
end
local path = '_P' .. setNum .. 'Set.png'
path = NOTESKIN:GetPath('', path)

-- NoteField FrameSets ActorFrame
local a = Def.ActorFrame{
	InitCommand=function(self)
		if columnN <= 7 then 
			self:x( 0 )
			if lastKey == '7' then self:x( - 26 ) end
		end
	end
}

local zoom = { 1.25, 1.875 }

local leftSide = Def.Sprite{
	Texture=path,
	InitCommand=function(self)
		local float = 0.28
		local p, crop = self:GetParent(), 0.84
		if columnN > 5 then float = 0.275 end
		self:SetTextureFiltering(false):cropright( crop )
		self:zoomx( zoom[1] ):x( self:GetZoomedWidth() * float * crop )
		self:zoomy( zoom[2] ):y( - self:GetZoomedHeight() * 0.3 )
	end
}

local rightSide = Def.Sprite{
	Texture=path,
	InitCommand=function(self)
		local float = 0.105
		local p, crop = self:GetParent(), 0.825
		if columnN > 5 then float = 0.125 end
		self:SetTextureFiltering(false):cropleft( crop )
		self:zoomx( zoom[1] ):x( - self:GetZoomedWidth() * float * crop )
		self:zoomy( zoom[2] ):y( - self:GetZoomedHeight() * 0.3 )
		if lastKey == '7' then self:x( self:GetX() + 4 ) end
		if columnN > 7 and sType:match('Double7') then self:x( self:GetX() - 4 ) end
	end
}

-- Shadow BG
if lastKey == '5' and ( columnN == 6 or columnN == 0 ) then 
	a[#a+1] = bgQuad 
end

if lastKey == '7' and ( columnN == 8 or columnN == 0 ) then 
	a[#a+1] = bgQuad 
end

-- Left side FrameSet on 5-key set and on 7-key double (2nd)
if ( lastKey == '5' or columnN == 8 ) and Button == 'Key1' then 
	a[#a+1] = leftSide
end

-- Add the missed notes animation
local missDir = NOTESKIN:GetPath('_MissNote','(res 44x9).png')

if Button == 'scratch' then

	missDir = NOTESKIN:GetPath('_ScratchNote 1x3','(res 98x63).png')

	-- Right side FrameSet on 5-key set and the doubles 7-key (2nd)
	-- Left side FrameSet on 7-key set
	if lastKey == '5' or columnN == 15 then a[#a+1] = rightSide
	elseif lastKey == '7' then a[#a+1] = leftSide end

end

-- Right side FrameSet on 7-key set
if columnN == 7 and Buttons[Button] == 'Last' then
	a[#a+1] = rightSide 
end

-- Animation of the missed notes
local missedFuncs = {
	InitCommand=function(self) 
		self:diffusealpha(0):effectclock('beat')
		self:set_tween_uses_effect_delta(true):animate(false)
		if self:GetNumStates() > 1 then self:setstate(2) end
	end,
	W3Command=function(self)
		self:stoptweening()
		self:diffusealpha(1):y(0):sleep(1)
		self:smooth(1):y( self:GetZoomedHeight() )
		self:diffusealpha(0)
	end
}
missedFuncs.W4Command = missedFuncs.W3Command
missedFuncs.W5Command = missedFuncs.W3Command
missedFuncs.MissCommand = missedFuncs.W3Command

-- Add the FrameSets and missed notes
t[#t+1] = a
t[#t+1] = Def.Sprite{ Texture=missDir } .. missedFuncs

-- Notefield actor keys
local key = loadfile( NOTESKIN:GetPath(Buttons[Button], "ReceptorGlyph") )() .. keyFunc
local triggeredKey = Def.ActorFrame{
	LoadActor( NOTESKIN:GetPath(Buttons[Button], "ReceptorGlow") ) .. keyFunc,
	InitCommand=function(self) self:diffuse(Color.Yellow):diffusealpha(0) end,
	PressCommand=function(self) self:stoptweening():linear(0.0625):diffusealpha(1) end,
	LiftCommand=function(self) self:linear(0.0625):diffusealpha(0) end
}

local quadsSize = function(self)

	local w = 42
	if Button == 'scratch' then w = 94 end

	self:setsize( w, 9 )
	self:diffuse(Color.Red):diffusealpha(0.5)

end

-- Notefield
t[#t+1] = Def.ActorFrame{

	'ToReplace',

	-- redLight
	Def.Quad{
		InitCommand=function(self)

			self.alpha = 0.5

			quadsSize(self)
			self:setsize( self:GetZoomedWidth(), SCREEN_HEIGHT * 0.5 )

			self:y( - self:GetZoomedHeight() * 0.5 - distance )
			self:diffusealpha(0)
			self:fadetop(0.5)

		end,
		PressCommand=function(self)
			self:finishtweening()
			self:linear(0.125):diffusealpha(self.alpha)
		end,
		LiftCommand=function(self)
			self:sleep(0.125):linear(0.125):diffusealpha(0)
		end
	},

	-- redGrid
	Def.Quad{
		InitCommand=function(self) quadsSize(self) end
	},

	Def.ActorFrame{
		InitCommand=function(self) self:y( distance ) end,
		key,	triggeredKey
	}

}

local newT = t[#t]
-- Vertical Grid
newT[1] = Def.Quad{
	InitCommand=function(self)

		quadsSize(self)
		self:setsize( self:GetZoomedWidth(), SCREEN_HEIGHT * 0.75 )

		local crop = 0.9
		if Button == 'scratch' then crop = 0.95 end
		self:y( - self:GetZoomedHeight() * 0.5 - distance )
		self:fadetop(0):cropleft(crop):x( self:GetX() - 2 )
		self:diffuse(color('#606060')):diffusealpha(0.5)

		if lastKey == '7' and columnN == 0 then self:x( self:GetX() + 9 ) end

		if lastKey == '7' and columnN == 7 or columnN == 15 
		or lastKey == '5' and Button == 'scratch' then self:visible(false) end

	end
}

return Def.ActorFrame{ t }