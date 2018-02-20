--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:85a67a00a254c5d25b991065ff443e11:021ba09dc7287d39832ccabfe4c898f2:ff6ed9a539a848dae2d91c7b3e7c2dd2$
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
            width=78,
            height=104,

            sourceX = 111,
            sourceY = 98,
            sourceWidth = 300,
            sourceHeight = 300
        },
        {
            -- 2
            x=81,
            y=1,
            width=156,
            height=182,

            sourceX = 71,
            sourceY = 59,
            sourceWidth = 300,
            sourceHeight = 300
        },
        {
            -- 3
            x=239,
            y=1,
            width=294,
            height=288,

            sourceX = 3,
            sourceY = 5,
            sourceWidth = 300,
            sourceHeight = 300
        },
        {
            -- 4
            x=535,
            y=1,
            width=300,
            height=300,

        },
        {
            -- 5
            x=837,
            y=1,
            width=250,
            height=254,

            sourceX = 50,
            sourceY = 25,
            sourceWidth = 300,
            sourceHeight = 300
        },
        {
            -- 6
            x=1089,
            y=1,
            width=220,
            height=188,

            sourceX = 40,
            sourceY = 55,
            sourceWidth = 300,
            sourceHeight = 300
        },
        {
            -- 7
            x=1311,
            y=1,
            width=220,
            height=178,

            sourceX = 39,
            sourceY = 61,
            sourceWidth = 300,
            sourceHeight = 300
        },
    },
    
    sheetContentWidth = 1532,
    sheetContentHeight = 302
}

SheetInfo.frameIndex =
{

    ["1"] = 1,
    ["2"] = 2,
    ["3"] = 3,
    ["4"] = 4,
    ["5"] = 5,
    ["6"] = 6,
    ["7"] = 7,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
