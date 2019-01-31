--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:b212f1f7834d8b955226b51285f359db:777efde47e755db957bc249dbc97b6b4:c08a3394c0f816bcafd06e334041a70a$
--
-- local sheetInfo = require("mysheet")
-- local myImageSheet = graphics.newImageSheet( "mysheet.png", sheetInfo:getSheet() )
-- local sprite = display.newSprite( myImageSheet , {frames={sheetInfo:getFrameIndex("sprite")}} )
--

local SheetInfo = {}

SheetInfo.sheet =
{
    frames = {
    
        {
            -- gunner
            x=1,
            y=1,
            width=335,
            height=699,

        },
        {
            -- gunner2
            x=338,
            y=1,
            width=334,
            height=699,

        },
    },
    
    sheetContentWidth = 673,
    sheetContentHeight = 701
}

SheetInfo.frameIndex =
{

    ["gunner"] = 1,
    ["gunner2"] = 2,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
