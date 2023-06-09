
-- Based on the default be-mu NS.

local Nskin = {}

Nskin.ButtonRedir = {
	Key1 = "First",		Key2 = "Blue",		Key3 = "White",
	Key4 = "Blue",		Key5 = "White",		Key6 = "Blue",
	Key7 = "White",		scratch = "Red"
}

--Define elements that need to be redirected
Nskin.ElementRedir = {
	["Tap Fake"] = "Tap Note",
	["Hold Head Active"] = "Tap Note",
	["Hold Head Inactive"] = "Tap Note",
	["Hold Tail Active"] = "Tap Note",
	["Hold Tail Inactive"] = "Tap Note",
	["Tap Explosion Dim"] = "Tap Explosion",
	["Tap Explosion Bright"] = "Tap Explosion"
}

Nskin.Blank = {
	["Hold Bottomcap Active"] = true,
	["Hold Bottomcap Inactive"] = true,
	["Hold Topcap Active"] = true,
	["Hold Topcap Inactive"] = true,
	["Roll Bottomcap Active"] = true,
	["Roll Bottomcap Inactive"] = true,
	["Roll Topcap Active"] = true,
	["Roll Topcap Inactive"] = true,
	["Hold Explosion"] = true,
	["Roll Explosion"] = true
}

function Nskin.Load()

	local sButton = Var "Button"
	local sElement = Var "Element"
	local sPlayer = Var "Player"

	-- Default redir
	local Button = Nskin.ButtonRedir[sButton] or "White"
	local Element = Nskin.ElementRedir[sElement] or sElement

	-- Blank scratch glow
	local Blank = sButton == "Red" and sElement == "ReceptorGlow"

	-- Use one script 'Global' for all keys
	if string.find(Element, "Tap Explosion")
	or string.find(Element, "Receptor") then
		Button = "Global"
	end
	
	-- Load the Actor
	local t = LoadActor(NOTESKIN:GetPath(Button,Element))
	
	--Set blank redirects	
	if Nskin.Blank[sElement] or Blank then
		t = Def.Actor {}
		-- Check if element is sprite only
		if Var "SpriteOnly" then
			t = LoadActor(NOTESKIN:GetPath("","_blank"))
		end
	end
			
	return t

end


return Nskin