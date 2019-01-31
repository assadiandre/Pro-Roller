--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:2671a8a062ffb86cca84e79311715b2a:3dd330742b96ab6c8d58d59d8b950283:3ae26195ff7da3c656d878185b11bf4f$
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
            -- smoke1
            x=1,
            y=1,
            width=76,
            height=66,

            sourceX = 28,
            sourceY = 56,
            sourceWidth = 130,
            sourceHeight = 128
        },
        {
            -- smoke2
            x=79,
            y=1,
            width=81,
            height=82,

            sourceX = 22,
            sourceY = 39,
            sourceWidth = 119,
            sourceHeight = 128
        },
        {
            -- smoke3
            x=162,
            y=1,
            width=88,
            height=108,

            sourceX = 14,
            sourceY = 15,
            sourceWidth = 118,
            sourceHeight = 128
        },
        {
            -- smoke4
            x=252,
            y=1,
            width=98,
            height=118,

            sourceX = 12,
            sourceY = 4,
            sourceWidth = 124,
            sourceHeight = 128
        },
        {
            -- smoke5
            x=352,
            y=1,
            width=102,
            height=118,

            sourceX = 10,
            sourceY = 1,
            sourceWidth = 126,
            sourceHeight = 128
        },
        {
            -- smoke6
            x=1,
            y=121,
            width=100,
            height=114,

            sourceX = 8,
            sourceY = 1,
            sourceWidth = 120,
            sourceHeight = 128
        },
        {
            -- smoke7
            x=103,
            y=121,
            width=97,
            height=106,

            sourceX = 8,
            sourceY = 2,
            sourceWidth = 117,
            sourceHeight = 128
        },
        {
            -- smoke8
            x=202,
            y=121,
            width=91,
            height=102,

            sourceX = 14,
            sourceY = 2,
            sourceWidth = 111,
            sourceHeight = 128
        },
        {
            -- smoke9
            x=295,
            y=121,
            width=87,
            height=98,

            sourceX = 15,
            sourceY = 3,
            sourceWidth = 123,
            sourceHeight = 128
        },
        {
            -- smoke10
            x=384,
            y=121,
            width=80,
            height=94,

            sourceX = 13,
            sourceY = 5,
            sourceWidth = 116,
            sourceHeight = 128
        },
    },
    
    sheetContentWidth = 465,
    sheetContentHeight = 236
}

SheetInfo.frameIndex =
{

    ["smoke1"] = 1,
    ["smoke2"] = 2,
    ["smoke3"] = 3,
    ["smoke4"] = 4,
    ["smoke5"] = 5,
    ["smoke6"] = 6,
    ["smoke7"] = 7,
    ["smoke8"] = 8,
    ["smoke9"] = 9,
    ["smoke10"] = 10,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
