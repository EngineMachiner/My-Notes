
local Button, Player = Var "Button", Var "Player"

local isReversed = GAMESTATE:GetPlayerState(Player):GetPlayerOptions("ModsLevel_Preferred"):Reverse() == 1

local stepsType = GAMESTATE:GetCurrentSteps(Player):GetStepsType()          local lastKey = stepsType:sub( #stepsType )

local isLastKey = Button == "Key" .. lastKey


local isScratch = Button == "scratch"           local isFirst = Button == "Key1"

local function frame()

    if isScratch then return 0 end          if isFirst then return 2 end           if isLastKey then return 1 end

    local n = Button:match("%d")        n = tonumber(n)         local isEven = n % 2 == 0

    return isEven and 3 or 0

end

local Texture = isScratch and "Scratch.png" or "Receptor 2x2.png"

local function goYellow(self)

    self:stoptweening():linear(0.125):diffuse( Color.Yellow )

end

local function goWhite(self)

    self:linear(0.125):diffuse( Color.White )

end

local function ColorKeyCommand(self)

    if isScratch then return end

    goYellow(self)      self:sleep(0.06)        goWhite(self)

end

local Receptor = Def.Sprite {
    
    Texture = Texture,           Frames = {{ Frame = frame() }},

    InitCommand=function(self)

        if not isScratch then self:zoom(1.25) end
        
        self:y( self:GetZoomedHeight() * 0.5 )          if isScratch then return end

        if frame() == 0 then self:zoomx(1.5) end      self:zoomx( self:GetZoomX() * 1.25 )

        if isFirst then self:x( self:GetZoomedWidth() * 0.175 ) end
        if isLastKey then self:x( - self:GetZoomedWidth() * 0.175 ) end

        self:addy(-1)
    
    end
    
}

for i = 1, 5 do Receptor[ 'W' .. i .. "Command" ] = ColorKeyCommand end


local w = isScratch and 37 or 20

local StaticLight = Def.Quad {
            
    InitCommand=function(self)
        
        local color = color("1,0,0")        self:setsize( w, 4 ):diffuse(color):y(-2)
    
    end

}

local PlayLight = Def.Quad {

	InitCommand=function(self)

        local Color = isScratch and color("0,0,1") or color("1,0,0")

        self:setsize( w, SCREEN_CENTER_Y * 0.5 ):y( - self:GetHeight() * 0.5 - 4 )
        
        self:diffuse(Color):fadetop(0.25):diffusealpha(0)
    
    end,

	PressCommand=function(self) self:stoptweening():linear(0.06):diffusealpha(1) end,

	LiftCommand=function(self) self:linear(0.06):diffusealpha(0) end

}


local function moveColumns( notefield )

	if not notefield then return end            local columns = notefield:get_column_actors()

    local x = -7        for i = 1, #columns do columns[i]:x(x)      x = x + 6 end

end

local function onChildren(self) self:SetTextureFiltering(false) end

return Def.ActorFrame {
    
    InitCommand=function(self) self:zoomy( isReversed and -1 or 1 ) end,

    Def.ActorFrame {

        InitCommand=function(self) self:RunCommandsOnChildren(onChildren):zoom(2) end,

        OnCommand=function(self)

            -- Yes, this is hacky... Move the columns once.

            if not isFirst then return end             local Screen = SCREENMAN:GetTopScreen()

            local gameplay = Screen:GetChild("PlayerP1")        gameplay = gameplay and gameplay:GetChild("NoteField")
            
            local edit = Screen:GetChild("EditNoteField")       moveColumns(gameplay)      moveColumns(edit)

        end,

        Def.ActorFrame {

            InitCommand=function(self)
                
                local color = color("#3B3B3B")

                local function onChildren(self) self:zoomto( 2, SCREEN_CENTER_Y ):diffuse(color) end

                self:y( - SCREEN_CENTER_Y * 0.5 ):RunCommandsOnChildren(onChildren)
            
            end,

            Def.Quad { InitCommand=function(self) self:x( - w / 2 ) end },
            Def.Quad { InitCommand=function(self) self:x( w / 2 ) end },

        },

        Def.ActorFrame { 

            InitCommand=function(self) self:diffusealpha(0.5) end,

            StaticLight,      PlayLight

        },

        Receptor

    }

}