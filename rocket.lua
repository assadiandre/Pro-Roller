--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:e8df601cd48e1423eee73d4385cbef3e:fe20c0cb21984fd6e416ec63f0437c20:d1245b2e8cbcfd8a7dc2506f1439f842$
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
            -- 1
            x=1,
            y=1,
            width=133,
            height=449,

        },
        {
            -- 2
            x=136,
            y=1,
            width=133,
            height=449,

        },
        {
            -- 3
            x=271,
            y=1,
            width=133,
            height=455,

        },
    },
    
    sheetContentWidth = 405,
    sheetContentHeight = 457
}

SheetInfo.frameIndex =
{

    ["1"] = 1,
    ["2"] = 2,
    ["3"] = 3,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
