local physics = require("physics")
physics.start()

local A = [[
------o------ 
-----o-o-----
----o---o---- 
---o-o-o-o--- 
--o-------o-- 
-o---------o- 
o-----------o 
]]

local B = [[
o-o-oo
o-----o
o------o
o-o-o-o
o------o
o------o
o-o-o-o
]]

local C = [[
--oooo
-o----o
o
o
o
-o----o
--oooo
]]

local D = [[
ooooo
o-----o
o------o
o------o
o------o
o-----o
ooooo
]]

local E = [[
o-o-o-o
o
o
o-o-o
o
o
o-o-o-o
]]

local F = [[
o-o-o-o
o
o
o-o-o
o
o
o
]]

local G = [[
--o-o-o
-o-----o
o
o
o---o-o-o
-o-----o
--o-o-o
]]

local H = [[
o-------o
o-------o
o-------o
o-o-o-o-o
o-------o
o-------o
o-------o
]]

local I = [[
ooo
-o
-o
-o
-o 
-o 
ooo 
]]

local J = [[
-ooooo
---o
---o
---o
---o
o--o
-oo
]]

local K = [[
o----o
o---o
o--o
o-o
o--o
o---o
o----o
]]

local L = [[
o
o
o
o
o
o
o-o-o-o
]]

local M = [[
oo------------oo
o-o----------o-o
o--o--------o--o
o---o------o---o
o----o----o----o
o-----o--o-----o
o------oo------o
]]

local N = [[
oo------o 
o-o-----o
o--o----o 
o---o---o 
o----o--o 
o-----o-o 
o------oo 
]]

local O = [[
--o-o-o
-o-----o
o-------o
o-------o
o-------o
-o-----o
--o-o-o
]]

local P = [[
o-o-o
o-----o
o-----o 
o-o-o
o 
o 
o 
]]


local R = [[
o-o-o
o-----o
o-----o 
o-o-o
o--o
o---o
o----o
]]

local S = [[
--o-o-o
-o
--o
----o
-----o
-----o
o-o-o-
]]

local T = [[
o-o-o-o-o
----o
----o
----o
----o
----o
----o
]]

local U = [[
o-------o
o-------o
o-------o
o-------o
o-------o
o-------o
-o-o-o-o
]]


local Y = [[
o-----o
-o---o
--o-o
---o
---o
---o
---o
]]


local W = [[
o---------------o
-o-------------o
--o-----------o
---o---------o
----o---o---o
-----o-o-o-o
------o---o
]]


local space = [[
---------
---------
---------
---------
---------
---------
---------
]]

local alphabet = {
	a = A,
	b = B,
	c = C,
	d = D,
	e = E,
	f = F,
	g = G, 
	h = H,
	i = I,
	j = J,
	k = K,
	l = L,
	m = M,
	n = N,
	o = O,
	p = P,
	q = Q,
	r = R,
	s = S,
	t = T, 
	u = U,
	v = v,
	w = W,
	x = X,
	y = Y,
	_ = space 
}

function makeDottedLetter()
	local dot = {}
	local coinX = 0
	local coinY = 0
	local coin_var = 0
	dot.coin = {}
	local textGroup = display.newGroup()

	function dot.makeFromString(str,startXConst,startYConst) 
		local letters = {}
		local largestWidth = 0

		str:gsub('.', function(c)
			table.insert(letters,alphabet[c])
		end)

		for i = 1, #letters do
			local letter = letters[i]
			local width = 0
			startXConst = startXConst + largestWidth*2.5
			imageX = startXConst
			imageY = startYConst
			largestWidth = 0

			letter:gsub('[.\n.o.-]', function (c)
				imageX = imageX + 10
	            width = width + 5
				if c == '\n' then
					imageY = imageY + 20
					imageX = startXConst
					if width > largestWidth then
						largestWidth = width
					end
					width = 0
				elseif c == "-" then
					--Do Nothing
				elseif c == 'o' then
					coin_var = coin_var + 1
			        dot.coin[coin_var] = display.newImage("images/coin.png",imageX,imageY)
			        dot.coin[coin_var]:scale(0.4,0.4)
			        physics.addBody(dot.coin[coin_var],"kinematic",{density=-100,bounce=0,friction=0,isSensor=true})
					end
			end)
	end
end

	function dot.moveCoins(goX,speed)
		for i=1,coin_var do
			dot.coin[i].kind = "coin"
			dot.coin[i].transStart = system.getTimer()
			dot.coin[i].gx = goX
			dot.coin[i].transTime = ((goX + dot.coin[i].x)/(speed*60)) * 1000
			dot.coin[i].trans = transition.to(dot.coin[i],{time=dot.coin[i].transTime,x=-goX})
		end
	end

	return dot 
end
makeDottedLetter()






