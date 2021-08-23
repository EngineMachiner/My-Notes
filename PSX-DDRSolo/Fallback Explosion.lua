return Def.ActorFrame {

	NOTESKIN:LoadActor( Var "Button", "Tap Explosion Dim" ) .. {},
	NOTESKIN:LoadActor( Var "Button", "Tap Explosion Bright" ) .. {
		BrightCommand=function(self)
			self:visible(true)
		end;
		DimCommand=function(self)
			self:visible(false)
		end
	},

	NOTESKIN:LoadActor( Var "Button", "Hold Explosion" ) .. {},
	NOTESKIN:LoadActor( Var "Button", "Roll Explosion" ) .. {},

	-- I will use a sprite
	NOTESKIN:LoadActor( Var "Button", "HitMine Explosion" ) .. {
		InitCommand=function(self)
			self:blend("BlendMode_Add")
			self:diffusealpha(0)
			self:y(161)
		end,
		HitMineCommand=function(self)
			self:stoptweening()
			self:diffusealpha(0)
			self:linear(0.125)
			self:diffusealpha(1)
			self:linear(0.25):diffusealpha(0)
		end
	}

}