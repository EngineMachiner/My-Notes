
return Def.Sprite {

	Texture = "Scratch Mine 1x3.png",

	Frames = {

		{ Frame = 0, Delay = 0.125 },		{ Frame = 1, Delay = 0.125 },
		{ Frame = 2, Delay = 3.75 }

	},

	InitCommand=function(self) self:effectclock('beat') end

}