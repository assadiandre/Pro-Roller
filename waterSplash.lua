--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:84f9e2bb4c73e0508607d6a52b8b742c:77da668ffde4f0b6fd727f0e4fb1e608:1245cdd74e7c70359c322f7974346598$
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
            -- w1
            x=864,
            y=385,
            width=570,
            height=294,

            sourceX = 463,
            sourceY = 459,
            sourceWidth = 1464,
            sourceHeight = 958
        },
        {
            -- w2
            x=1,
            y=544,
            width=738,
            height=416,

            sourceX = 385,
            sourceY = 351,
            sourceWidth = 1466,
            sourceHeight = 956
        },
        {
            -- w3
            x=1,
            y=1,
            width=861,
            height=541,

            sourceX = 284,
            sourceY = 252,
            sourceWidth = 1459,
            sourceHeight = 953
        },
        {
            -- w4
            x=864,
            y=1,
            width=780,
            height=382,

            sourceX = 325,
            sourceY = 419,
            sourceWidth = 1460,
            sourceHeight = 952
        },
        {
            -- w5
            x=741,
            y=681,
            width=896,
            height=277,

            sourceX = 274,
            sourceY = 526,
            sourceWidth = 1462,
            sourceHeight = 949
        },
        {
            -- w6
            x=1,
            y=962,
            width=1107,
            height=127,

            sourceX = 189,
            sourceY = 710,
            sourceWidth = 1457,
            sourceHeight = 959
        },
        {
            -- w7
            x=1436,
            y=385,
            width=3,
            height=3,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 1457,
            sourceHeight = 959
        },
    },
    
    sheetContentWidth = 1645,
    sheetContentHeight = 1090
}

SheetInfo.frameIndex =
{

    ["w1"] = 1,
    ["w2"] = 2,
    ["w3"] = 3,
    ["w4"] = 4,
    ["w5"] = 5,
    ["w6"] = 6,
    ["w7"] = 7,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
