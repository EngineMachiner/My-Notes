
local NoteSkin = {}


local Buttons = {

	Key1 = "First",		Key2 = "Blue",		Key3 = "White",
	Key4 = "Blue",		Key5 = "White",		Key6 = "Blue",
	Key7 = "White",		scratch = "Red"
    
}

NoteSkin.ButtonRedir = Buttons


local Elements = {

	["Tap Fake"] = "Tap Note",
	["Hold Head Active"] = "Tap Note",
	["Hold Head Inactive"] = "Tap Note",
	["Hold Tail Active"] = "Tap Note",
	["Hold Tail Inactive"] = "Tap Note",
	["Tap Explosion Dim"] = "Tap Explosion",
	["Tap Explosion Bright"] = "Tap Explosion"

}

NoteSkin.ElementRedir = Elements


local Blanks = {

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

NoteSkin.Blank = Blanks


function NoteSkin.Load()

	local Button = Var "Button"         local Element = Var "Element"
	local Player = Var "Player"

	Button = Buttons[Button] or "White"             Element = Elements[Element] or Element

    local isScratch = Button == "Red"

    
	-- Tap Explosion and Receptor as Global.

	if Element:match("Tap Explosion") or Element:match("Receptor") then Button = "Global" end


    local isBorder = Button == "First" or Button == "Last"

    local isWhite = Element:match("Tap Note") or Element:match("Hold Body")

    if isBorder and isWhite then Button = "White" end


    if not isScratch and Element:match("Tap Mine") then Button = "White" end


    local isScratchGlow = isScratch and Element == "ReceptorGlow"

	if Blanks[Element] or isScratchGlow then

        local Blank = LoadActor( NOTESKIN:GetPath("","_blank") )

        return Var "SpriteOnly" and Blank or Def.Actor {}
    
    end
			

    local Path = NOTESKIN:GetPath( Button, Element )

    return LoadActor(Path) .. { InitCommand=function(self) self:SetTextureFiltering(false) end }

end


return NoteSkin