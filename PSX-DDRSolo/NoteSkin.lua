
local ret = ... or {}

ret.RedirTable =
{
	Up = "Down",
	Down = "Down",
	Left = "Down",
	Right = "Down",
	UpLeft = "UpRight",
	UpRight = "UpRight"
}

local OldRedir = ret.Redir

ret.Redir = function(sButton, sElement)

	local sButton = Var "Button"
	local sElement = Var "Element"

	-- Point the fakes to the tap note
	if sElement == "Tap Fake" then
		sElement = "Tap Note"
	end

	if not sElement:match("Tap Mine") then

		if sElement:match("HitMine Explosion") then
			sButton = "Down"
		end

		if not sElement:match("Body")
		and not sElement:match("Bottomcap") then
			sButton = ret.RedirTable[sButton]
		end

		if sElement:match("Roll Head Active") then 
			sElement = "Hold Head Active"
		elseif sElement:match("Roll Head Inactive") then
			sElement = "Hold Head Inactive"
		end

	end

	return sButton, sElement
	
end

local OldFunc = ret.Load
function ret.Load()
	local t = OldFunc()
	return t
end

ret.PartsToRotate =
{
	["Receptor"] = true,
	["Tap Explosion Dim"] = true,
	["Tap Note"] = true,
	["Tap Fake"] = true,
	["Tap Lift"] = true,
	["Tap Addition"] = true,
	["Hold Head Active"] = true,
	["Hold Head Inactive"] = true,
	["Roll Head Active"] = true,
	["Roll Head Inactive"] = true
}

ret.Rotate =
{
	Up = 180,
	Down = 0,
	Left = 90,
	Right = -90,
	UpLeft = -90,
	UpRight = 0
}

return ret
