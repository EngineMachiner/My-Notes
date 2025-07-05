
local function init(self) self:SetTextureFiltering(false):SetAllStateDelays( 1 / 20 ):playcommand("Stop") end

local function StopCommand(self) self:setstate(4):animate(false) end

local function AnimateCommand(self)
    
    self:stoptweening():setstate(0):animate(true)           self:sleep(0.25):queuecommand("Stop")

end

local function Sprite( tbl )

    local Texture = tbl.Texture         tbl.Texture = nil

    return Def.Sprite { Texture = Texture,      StopCommand = StopCommand } .. tbl

end

return Def.ActorFrame {

    InitCommand=function(self) self:RunCommandsOnChildren(init) end,

    Sprite { 
        
        Texture = "Explosion 1x5.png",      W1Command = AnimateCommand,         W2Command = AnimateCommand,

        HeldCommand = AnimateCommand

    },

    Sprite { Texture = "Explosion HitMine 1x5.png",     HitMineCommand = AnimateCommand }

}
