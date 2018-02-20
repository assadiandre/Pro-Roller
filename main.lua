local screenW, screenH = display.contentWidth, display.contentHeight
local physics = require("physics")
local coinLetter = require("coinLetter")
physics.start()
--physics.setDrawMode("hybrid")
display.setStatusBar(display.HiddenStatusBar)

local midJumpTimer 
local youLost = false
local stopMountPos = false 
local asHealth
--Man Variables-----------------------------
local manInfo = require("newMan")
local manSheet = graphics.newImageSheet( "images/newMan.png", manInfo:getSheet() )
local manOrderData = {
	{name="fallHard",start=1,count=12,time=200,loopCount=1},
	{name="fall",start=1,count=6,time=500,loopCount=1},
	{name="hit",start=18,count=1,time=500,loopCount=1},
	{name="midJump",start=26,count=11,time=500,loopCount=0},
	{name="jump",start=7,count=19,time=600,loopCount=1},
	{name="run",start=37,count=19,time=500,loopCount=0}
}
local checkManSlam = true
--Platform Variables-----------------------------
local platform = {}
local platform_chose = 0
local platform_num = 0
local platform_prevX = 600
local platform_prevW = 0 
local spawnNextPlat
--Cloud Variables-----------------------------
local cloud = {}
local cloudTable = {
	{"images/cloudBack1.png",math.random(0,70),math.random(50,80)},
	{"images/cloudBack1.png",math.random(400,500),math.random(50,80)},
	{"images/cloudFront2.png",math.random(0,70),math.random(20,40)},
	{"images/cloudFront1.png",math.random(250,300),math.random(20,40)},
	{"images/cloudFront2.png",math.random(400,500),math.random(20,40)},
}
local cloud_chose = 0 
---Mount Variables----------------------------
local mount1 = {}
local mount2 = {}
local mount1_var = 0
local mount2_var = 0
local mount1_count = 0
local mount2_count = 0
local mountPos
--Mountain Variables------------------------------
local mountain = {}
local mountain_var = 0
local mountain_count = 0
--Cannon Variables------------------------------
local cannon = {}
local cannon_var = 0
local cannon_go = 0
--Ball Variables------------------------------
local ball = {}
local ball_var = 0
--Falling Effect Variables------------------------------
local timeEffect
local time2Effect 
--Detecting Sprite Variables------------------------------
local sprite_var = 0
--Starts and Stops Bounce Variables------------------------------
local bounce_var = 0
--Coin Variables------------------------------
local coin_var = 0
local coin_pos = 1
local coin = {}
local coinGroup = display.newGroup()
--Game Variables------------------------------
local gameSpeed = 4
local cannonChance = 3
--Gunner Variables------------------------------
local gunnerInfo = require("gunner")
local gunnerSheet = graphics.newImageSheet( "images/gunner.png", gunnerInfo:getSheet() )
local gunnerOrderData = {
	{name="shoot",start=1,count=2,time=500,loopCount=0},
}
local gunner = {}
local gunner_num = 0 
--Special Cannon Variables------------------------------
local tcannon = {}
local tbullet 
local t = 0 
--Smoke Variables------------------------------
local smoke = {}
local smoke_var = 0
local smokeInfo = require("smoke")
local smokeSheet = graphics.newImageSheet( "images/smoke.png", smokeInfo:getSheet() )
local smokeOrderData = {
	{name="shoot",start=1,count=10,time=1200/gameSpeed,loopCount=1},
}
--Rocket Variables------------------------------
local rocket = {}
local rocket_var = 0 
local newRocket
--Tree Variables------------------------------
local tree = {}
local tree_num = 0
--Shard Variables------------------------------
local shards = {}
local shardAm = 0
--Screen Variables------------------------------
local swipeSY = 0
local swipeEY = 0
local swipeDif = 0
local screenTapped = false
--Controll Variables------------------------------
local controllTable = {
	{0,0,math.random(0,1),1,0,math.random(0,1),math.random(0,1),0,math.random(0,1),1,math.random(0,1),0,1,0,math.random(1,2),
	1,2,math.random(0,1),0,1,0,2,2,math.random(0,1),1},
	{0,0,0,0,1,0,0,1,0,0,1,0,1,0,1,1,0,0,1,0,1,0,0,0,1,1,1,0,0,1,1,1,0,1,0,1,1,0,1,1,2,0,2,1,1,0,1,0,0,0,2,0,0,3,3,0,0,1,3,3,3,3,3,3,3},
	{0,0,0,1,2,1,0,1,1,2,3,2,0,0,0,2,1,0,1,0,1,2,3,2,1,0,1,0,0,1,2,3,3,3,3,2,1,0,2,1,3,1,0,0,1,2,3,3,2,2,2,2,2,2,2,2},
	{0,0,0,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,33,3,3,3,3,3,3,3,3,3,3,3,3,3}

}

local numCount = 0
--Coin Variables------------------------------
local DL = makeDottedLetter()
--Explosion Variables------------------------------
local explosionInfo = require("explosion")
local explosionSheet = graphics.newImageSheet( "images/explosion.png", explosionInfo:getSheet() )
local explosionOrderData = {
	{name="explosion",start=1,count=7,time=300,loopCount=1}
}
--Setting Game Scene Variables + Tables ------------------------------
local gameScene = {
	normal = {backmount = { type="image", filename="images/mountBack1.png" },platform = "plat",mount = "mount",
	hill="images/frontHill",backhill="images/backHill",tree="images/frontTree1.png",
	cannon="images/barrel.png",cannonbase = "images/base.png"},

	norm_ice = {backmount = {type="image", filename="images/norm-ice.png" }},

	ice = {backmount = { type="image", filename="images/mountBack_ice.png" },platform = "platice",mount = "ice_mount",
	hill="images/ice_frontHill",backhill="images/ice_backHill",tree="images/ice_frontTree.png",
	cannon= "images/ice_barrel.png",cannonbase = "images/ice_base.png"},

	water = {backmount = { type="image", filename="images/nothing.png" },platform = "nothing",mount = "nothing",
	hill="images/nothing",backhill="images/nothing",tree="images/nothing.png",
	cannon= "images/nothing.png",cannonbase = "images/nothing.png"},
}

local setStage = gameScene.normal
--------------------------------
local stTimer 
local spawnMounts
local spawnBackMounts
local spawnMountains

local white = display.newRect(screenW/2,screenH/2,screenW + 200,screenH)

local healthGroup = display.newGroup()
local health_num = 20
local healthBar = display.newRect(75,0,31,5)
local health = {}
healthGroup:insert(healthBar)
for i=1,20 do
	health[i] = display.newRect(healthBar.x + healthBar.width/2 + 0.5 - (i*1.5) ,healthBar.y,1.5,4)
	health[i]:setFillColor(1,0,0)
	healthGroup:insert(health[i])
end
healthGroup.alpha = 0

local background = display.newImage("images/background.png",screenW/2,screenH/2)
background.xScale = 0.5
background.yScale = 0.5

local sun = display.newImage("images/sun.png")
sun.x = screenW/2 
sun.y = 70
sun:scale(0.65,0.65)

local stageIndex = display.newText("Round 1 ",screenW/2,screenH/2 - 20,"buba",60)
transition.to(stageIndex,{time=500,xScale=0.9,yScale=0.9,transition=easing.continuousLoop,iterations=1,onComplete=function()
	transition.to(stageIndex,{delay=400,time=200,alpha=0,xScale=1.3,yScale=1.3})end})

local man = display.newSprite( manSheet, manOrderData )
man.x = 75
man.y = 250
man.kind = "man"
man.xScale = 0.05
man.yScale = 0.05
physics.addBody(man,"dynamic",{radius=20,bounce=0,density=100000})
man.gravityScale = 2

local explosion = display.newSprite( explosionSheet, explosionOrderData )
explosion.x = 100
explosion.y = 200
explosion.yScale = 0.4
explosion.xScale = 0.4
explosion.alpha = 0
explosion:play()

local mountainBack1 = display.newRect( -50, screenH/2 + 30, 850, 231 )
mountainBack1.anchorX = 0
mountainBack1.alpha = 1
mountainBack1.kind = "mountainBack"
mountainBack1.fill = setStage.backmount

local mountainBack2 = display.newRect(760, screenH/2 + 30, 850, 231 )
mountainBack2.anchorX = 0
mountainBack2.alpha = 1
mountainBack2.kind = "mountainBack"
mountainBack2.fill = setStage.backmount

local splashInfo = require("waterSplash")
local splashSheet = graphics.newImageSheet( "images/waterSplash.png", splashInfo:getSheet() )
local splashOrderData = {
	{name="go",start=1,count=6,time=300,loopCount=1},
}

local splash = display.newSprite( splashSheet, splashOrderData )
splash.x = man.x
splash.y = 275
splash.alpha = 0
splash:scale(0.1,0.1)

local startPlat = display.newImage("images/startPlat.png")
startPlat.x = 210
startPlat.y = 300
startPlat.kind = "plat"
physics.addBody(startPlat,"kinematic",{density=100,bounce=0})

local checkWater = display.newRect(screenW/2,300,screenW,1)
physics.addBody(checkWater,"kinematic",{isSensor=true})
checkWater.kind = "checkWater"
checkWater.alpha = 0
checkWater.isHitTestable = true

local clouds = display.newImage("images/clouds.png",screenW/2,40)
clouds.xScale = 1.15
clouds.yScale = 1.15
local clouds2 = display.newImage("images/clouds.png",screenW*2 - 100,40)
clouds2.xScale = 1.15
clouds2.yScale = 1.15

local water1 = display.newImage("images/water.png",screenW/2,310)
water1.xScale,water1.yScale = 0.7,0.7

local water2 = display.newImage("images/water.png",screenW/2 + 20,330)
water2.xScale,water2.yScale = 0.7,0.7

local cloudMove
local cloudMove2

local function playSplash()
	man.body = false
	splash.x = man.x
	youLost = true
	splash.alpha = 1
	splash:setSequence("go")
	splash:play()
	man.alpha = 0
end


cloudMove = function(selectedCloud)
	transition.to(selectedCloud,{time=25000,x=-340,onComplete= function() cloudMove2(selectedCloud) end})
end
cloudMove2 = function(selectedCloud)
	selectedCloud.x = screenW*2 - 100
	transition.to(selectedCloud,{time=50000,x=-340,onComplete= function() cloudMove2(selectedCloud) end})
end
cloudMove(clouds) cloudMove2(clouds2)

transition.to(water1,{time=1300,y=315,transition=easing.continuousLoop,iterations=-1})
transition.to(water2,{delay=700,time=1700,y=310,transition=easing.continuousLoop,iterations=-1})

DL.makeFromString("",600,110)
DL.moveCoins(800,gameSpeed)

local stopHills = false
local stopMounts = false 
local stopPlats = false 
--GAME FUNCTIONALITY-----------------
-------------------------------------
-------------------------------------
-------------------------------------
-------------------------------------
local function moveCoinsUTS()
	for i = 1, #DL.coin do
		local remaining = system.getTimer() - DL.coin[i].transStart - DL.coin[i].transTime 
		transition.cancel(DL.coin[i].trans)
  			if remaining < 800 then
       		transition.to(DL.coin[i],{time = ((DL.coin[i].gx + DL.coin[i].x)/(gameSpeed*60)) * 1000,x=-DL.coin[i].gx})
   		end
	end
end 

local function makeSmoke(smokeX,smokeY,smokeRotate)
	smoke_var = smoke_var + 1
	smoke[smoke_var] = display.newSprite( smokeSheet, smokeOrderData )
	smoke[smoke_var].x = smokeX - (gameSpeed * 6)
	smoke[smoke_var].y = smokeY - 10
	smoke[smoke_var].rotation = smokeRotate
	smoke[smoke_var].xScale = 0.7
	smoke[smoke_var].yScale = 0.7
	smoke[smoke_var]:play()
	smoke[smoke_var].kind = "smoke"
	transition.to(smoke[smoke_var],{time=2800/gameSpeed,x=smokeX - 175})
	local function smokeTrans(self)
		transition.to(self,{delay=1200/gameSpeed,time=50,alpha=0,onComplete=
		function() self.kind = "nil" self:removeSelf() self=nil end})
	end
	smokeTrans(smoke[smoke_var])
end

local function removeIt(self)
	self:removeSelf()
	self = nil
end

local function manSlam()
	if checkManSlam == true then
		man.mode = "slam"
		swipeSY = 0
		swipeEY = 0
		swipeDif = 0
		checkManSlam = false
		man:setLinearVelocity(0,600)
		timer.performWithDelay(400,function() checkManSlam = true end,1)
	end
end

--[[local function swipeDown(event)
	if event.phase == "began" then 
		swipeSY = event.y
	end
	if event.phase == "ended" then
		swipeEY = event.y
		swipeDif = swipeEY - swipeSY
	end
	if swipeDif > 60 then
		manSlam()
		man:setSequence("fallHard")
		man:play()
		if midJumpTimer then
			timer.cancel(midJumpTimer) 
		end 
	end
end
Runtime:addEventListener("touch",swipeDown)--]]

local function swipeDown(event)
	if event.keyName == "down" and event.phase == "down" then
		manSlam()
		man:setSequence("fallHard")
		man:play()
		if midJumpTimer then
			timer.cancel(midJumpTimer) 
		end
	end 
end
Runtime:addEventListener("key",swipeDown)

local function effect(var)
	if var == 1 then 
		time2Effect = timer.performWithDelay(500,function()
			timeEffect = timer.performWithDelay(100,
				function()
				if man.y < 150 then 
					local effectIt = display.newRect(man.x + math.random(-10,10),man.y - 15,1,10)
					transition.to(effectIt,{time=200,y=effectIt.y - 10,alpha=0,onComplete=function() removeIt(effectIt) end})
					man:toFront()
				end
			end,10)
		end,1)
	end
end

--[[local helmTable = {
	run = {
		{man.x + 11,man.y - 38,20},
		{man.x + 7,man.y - 38,20},
		{man.x + 9,man.y - 40,20},
		{man.x + 7,man.y - 39,20},
		{man.x + 7,man.y - 39,22},
		{man.x + 8,man.y - 37,23},
		{man.x + 8,man.y - 39,20},
		{man.x + 7,man.y - 38,20},
		{man.x + 10,man.y - 38,20},
		{man.x + 10,man.y - 38,20},
		{man.x + 11,man.y - 40,20},
		{man.x,man.y - 40,20},
		{man.x,man.y - 40,20},
		{man.x,man.y - 40,20},
		{man.x,man.y - 40,20},
		{man.x,man.y - 40,20},
		{man.x,man.y,20},
		{man.x,man.y,20},
		{man.x,man.y,20},
		{man.x,man.y,20},
	}
}--]]

local function getRidofEffect()
	if timeEffect ~= nil then 
		timer.cancel(timeEffect)
	end
	if time2Effect ~= nil then 
		timer.cancel(time2Effect)
	end
end

local function spriteListener( event )
	if screenTapped == false then
		screenTapped = true 
		man:setSequence("fall")
		man:play()
	end
end
man:addEventListener( "sprite", spriteListener )

local function barListener()
	healthGroup.y = man.y - 30
end

--[[
local function tapScreen()
	if man.body == nil then 
		if stTimer ~= nil then 
			timer.cancel(stTimer)
		end
		if man.sequence == "run" then
			if midJumpTimer then
				timer.cancel(midJumpTimer) 
			end 
			man:setSequence("jump")
			man:play()
			midJumpTimer = timer.performWithDelay(600,function() man:setSequence("midJump") man:play() end,1)
		end
		if man.sequence == "fall" then
			man:setSequence("midJump")
			man:play() 
		end
		man.mode = nil
		bounce_var = 0
		getRidofEffect()
		sprite_var = 0
		screenTapped = true
		stTimer = timer.performWithDelay(800,function()
		if screenTapped ~= 1 then screenTapped = false end end,1)
		man:setLinearVelocity(0,-300)
	end
end
Runtime:addEventListener("tap",tapScreen)--]]

local function tapScreen(event)
	if event.keyName == "space" and event.phase == "down" then
		if man.body == nil then 
			if stTimer ~= nil then 
				timer.cancel(stTimer)
			end
			if man.sequence == "run" then
				if midJumpTimer then
					timer.cancel(midJumpTimer) 
				end 
				man:setSequence("jump")
				man:play()
				midJumpTimer = timer.performWithDelay(600,function() man:setSequence("midJump") man:play() end,1)
			end
			if man.sequence == "fall" then
				man:setSequence("midJump")
				man:play() 
			end
			man.mode = nil
			bounce_var = 0
			getRidofEffect()
			sprite_var = 0
			screenTapped = true
			stTimer = timer.performWithDelay(800,function()
			if screenTapped ~= 1 then screenTapped = false end end,1)
			man:setLinearVelocity(0,-300)
		end
	end
end
Runtime:addEventListener("key",tapScreen)

local function makeShards(startX,startY)
	local function getRidofShard(shard)
		timer.performWithDelay(500,function() shard.kind = "nil" shard:removeSelf() shard = nil end,1)
	end
	timer.performWithDelay(50,function()
	for i=1,5 do 
		shardAm = shardAm + 1
		shards[shardAm] = display.newImageRect("images/shard1.png",math.random(10,20),math.random(10,20))
		shards[shardAm].x = startX
		shards[shardAm].y = startY
		shards[shardAm].kind = "shard"
		shards[shardAm].rotation = math.random(90,180)
		physics.addBody(shards[shardAm],"dynamic",{isSensor=true})
		shards[shardAm]:setLinearVelocity(math.random(-1000,1000),math.random(-1000,1000))
		getRidofShard(shards[shardAm])

		shardAm = shardAm + 1  
		shards[shardAm] = display.newImageRect("images/shard2.png",math.random(10,15),math.random(15,15))
		shards[shardAm].x = startX 
		shards[shardAm].y = startY
		shards[shardAm].kind = "shard"
		shards[shardAm].rotation = math.random(90,180)
		physics.addBody(shards[shardAm],"dynamic",{isSensor=true})
		shards[shardAm]:setLinearVelocity(math.random(-1000,1000),math.random(-1000,1000))
		getRidofShard(shards[shardAm])
		mountPos()
		end
	end,1)
end

local function getRidofRocketChildren(rocket)
	rocket.kind = "nil"
	for i=1,5 do 
		Runtime:removeEventListener("enterFrame",rocket[i])
	end
end

local function makeExplosion(e)
	explosion.alpha = 1 
	explosion.x = e.other.x 
	explosion.y = e.other.y 
	explosion:play()
	timer.performWithDelay(300,function() explosion.alpha = 0 end,1)
	transition.to(explosion,{time=2800/gameSpeed,x=explosion.x - 175})
	makeShards(e.other.x ,e.other.y)

	if e.other.string == "rocket" then
		getRidofRocketChildren(e.other.group)
	end

	Runtime:removeEventListener("enterFrame",e.other.group)
	e.other.group.kind = "nil"
	display.remove(e.other.group)
	e.other.group = nil 
	Runtime:removeEventListener("enterFrame",e.other)
	e.other:removeSelf()
	e.other = nil
end

local manLost

local function manCollision(event)
	if event.phase == "began" then
		bounce_var = bounce_var + 1
		getRidofEffect() 
		if event.other.kind == "ball" then
			-- Lose points
			asHealth(-5)
		elseif man.mode == "slam" and event.other.kind == "shooter" then
			makeExplosion(event)
			man:setSequence("midJump")
			man:play()
			man:setLinearVelocity(0,-400)
			screenTapped = true
			timer.cancel(stTimer)
			man.mode = "notSlam"
		elseif event.other.coll == "cd" then 
			manLost()
		elseif event.other.kind == "checkWater" then
			playSplash()
		elseif event.other.kind == "plat" then
			screenTapped = 1
			man:setSequence("run") 
			man:play()
		elseif event.other.kind == "coin" then 
			event.other.kind = "nil"
			event.other:removeSelf()
			event.other = nil 
		end
	end
	if event.phase == "ended" and event.other.kind == "plat" and screenTapped == 1 then
		man:setSequence("fall")
		man:play()
	end
end
man:addEventListener("collision",manCollision)

manLost = function()
	man:setLinearVelocity(-500,100)
	man:setSequence("hit")
	man:play()
	man.body = false
	man.isSensor = true
	healthGroup.alpha = 0
	Runtime:removeEventListener("enterFrame",healthGroup)
end

local function moveMountains(self)
	if self.kind == "mountainBack" then
		self.x = self.x - gameSpeed/3.7 
		if self.x < -920 then
			 self.x = 730
		end
	elseif self.kind == "mountain" then
		self.x = self.x - gameSpeed/2.5
		if self.x < -300 then
			self.kind = "nil"
			Runtime:removeEventListener("enterFrame",self)
			mountain_count = mountain_count + 1 
			self:removeSelf()
			self = nil 
		elseif self.x < 500 and self.go == true then 
			self.go = false 
			spawnMountains(700,true)
		end
	elseif self.kind == "hill" then 
		self.x = self.x - gameSpeed/1.87
		if self.x < -300 then
			self.kind = "nil"
			Runtime:removeEventListener("enterFrame",self)
			self:removeSelf()
			self = nil 
		elseif self.x < 500 and self.go == true then 
			self.go = false 
			spawnMounts(900,true)
		end
	elseif self.kind == "backHill" then
		self.x = self.x - gameSpeed/2.2
		if self.x < -300 then
			self.kind = "nil"
			Runtime:removeEventListener("enterFrame",self)
			self:removeSelf()
			self = nil 
		elseif self.x < 500 and self.go == true then 
			self.go = false 
			spawnBackMounts(900,true)
		end 
	end
end

local function removeMount1()
	mount1_count = mount1_count + 1
	mount1[mount1_count]:removeSelf()
	mount1[mount1_count] = nil
end

local function removeMount2()
	mount2_count = mount2_count + 1
	mount2[mount2_count]:removeSelf()
	mount2[mount2_count] = nil
end

local function movePlat(self)
	self.x = self.x - gameSpeed
	if self.x < 500 and self.go == true then
		self.go = false 
		spawnNextPlat()
	end
	if self.x < -500 and self.kind == "plat" then 
		self.kind = "nil"
		Runtime:removeEventListener("enterFrame",self)
		display.remove(self)
		self = nil
	elseif self.x < -1300 and self.kind == "shooter" then 
		self.kind = "nil"
		Runtime:removeEventListener("enterFrame",self)
		display.remove(self)
		self = nil
	end
end

local function getRidOfBall(self)
	timer.performWithDelay(2000,function() self.kind = "nil" self:removeSelf() self = nil end,1)
end

local function shootIt(theCannon,thePlatform)
	timer.performWithDelay(5000/gameSpeed,function()
		if thePlatform.kind == "plat" and theCannon.kind == "shooter" then 
			ball_var = ball_var + 1
			transition.to(theCannon[1],{time=300,xScale=0.18,yScale=0.18,transition=easing.continuousLoop})
			ball[ball_var] = display.newCircle(thePlatform.x + thePlatform.width/3,200,10)
			ball[ball_var].kind = "ball"
			ball[ball_var].num = ball_var
			physics.addBody(ball[ball_var],"dynamic")
			ball[ball_var]:setLinearVelocity(-240*(gameSpeed-1),-120*(gameSpeed-1))
			ball[ball_var]:setFillColor(0,0,0)
			getRidOfBall(ball[ball_var])
			makeSmoke(thePlatform.x + thePlatform.width/3,180,-40)
			mountPos()
		end
	end,4)
end

local function choseCannon()
	numCount = numCount + 1
	return controllTable[3][numCount]
end

local function makeItSnow()
	timer.performWithDelay(100,function()
		local snowflake = display.newRect(math.random(-80,500),math.random(-100,-50),2,2)
		physics.addBody(snowflake,"dynamic",{isSensor=true})
		snowflake.gravityScale = 0.1
		local function removeSnowflake(self)
			transition.to(snowflake,{time=9000,alpha=0,onComplete=function() self:removeSelf() self = nil end})
		end
		removeSnowflake(snowflake)
	end,0)
end
--SPAWNING---------------------------
-------------------------------------
-------------------------------------
-------------------------------------
-------------------------------------
--MOUNTAIN CODE-----------------------------------
spawnMountains = function(mountX,varGo)
	if stopMounts == false then 
		mountain_var = mountain_var + 1
		mountain[mountain_var] = display.newImage("images/"..setStage.mount..math.random(1,5)..".png",mountX,200)
		mountain[mountain_var].xScale, mountain[mountain_var].yScale = 1,1
		mountain[mountain_var].kind = "mountain"
		mountain[mountain_var].go = varGo
		mountain[mountain_var].enterFrame = moveMountains
		Runtime:addEventListener("enterFrame",mountain[mountain_var])
		mountPos()
	end
end
timer.performWithDelay(1,function() spawnMountains(1100,true) end,1)
--HILL CODE-----------------------------------
spawnMounts = function(mountX,varGo)
	if stopHills == false then
		mount1_var = mount1_var + 1
		mount1[mount1_var] = display.newImage(setStage.hill..math.random(1,3)..".png",mountX,260)
		mount1[mount1_var].kind = "hill"
		mount1[mount1_var].go = varGo
		mount1[mount1_var].enterFrame = moveMountains
		Runtime:addEventListener("enterFrame",mount1[mount1_var])
		mountPos()
	end
end
timer.performWithDelay(1,function() spawnMounts(1600,true) end,1)


spawnBackMounts = function(mountX,varGo)
	if stopHills == false then 
		mount2_var = mount2_var + 1
		mount2[mount2_var] = display.newImage(setStage.backhill..math.random(1,4)..".png",mountX,260)
		mount2[mount2_var].kind = "backHill"
		mount2[mount2_var].go = varGo
		mount2[mount2_var].enterFrame = moveMountains
		Runtime:addEventListener("enterFrame",mount2[mount2_var])
		mountPos()
	end
end
timer.performWithDelay(1,function() spawnBackMounts(1600,true) end,1)
--GUNNER CODE-----------------------------------
local function newLandGunner(x,y)
	gunner_num = gunner_num + 1 
	gunner[gunner_num] = display.newSprite( gunnerSheet, gunnerOrderData )
	gunner[gunner_num].x = x
	gunner[gunner_num].y = y
	gunner[gunner_num].kind = "shooter"
	gunner[gunner_num].xScale = 0.27
	gunner[gunner_num].yScale = 0.27
	gunner[gunner_num]:setSequence("shoot")
	gunner[gunner_num]:play()
	physics.addBody(gunner[gunner_num],"static",{shape={40,-80,-30,-80,-30,70,40,70}})
	gunner[gunner_num].enterFrame = movePlat
	Runtime:addEventListener("enterFrame",gunner[gunner_num])

	local function fireGunner(self)
		timer.performWithDelay(800,function()
			if self.kind == "shooter" then 
				local bullet = display.newRect(self.x - 60,self.y - 55,10,4)
				bullet:setFillColor(1,0,1)
				physics.addBody(bullet,"kinematic")
				bullet:setLinearVelocity(-700,0)
				timer.performWithDelay(1000,function() bullet:removeSelf() bullet=nil end,1)
			end
		end,8)
	end
	fireGunner(gunner[gunner_num])
end
--SPECIAL CANNON CODE-----------------------------------
local function newTCannon(posX,posY)
	t = t + 1
	tcannon[t] = display.newGroup()

	local tcannon_barrel = display.newImage("images/1barrel.png",posX,posY)
	tcannon_barrel.xScale, tcannon_barrel.yScale = 0.15,0.15
	tcannon_barrel.rotation = -90
	tcannon_barrel.anchorX, tcannon_barrel.anchorY = 0.5,1
	local tcannon_back = display.newImage("images/1back.png",tcannon_barrel.x - 10,tcannon_barrel.y - 1)
	tcannon_back.xScale, tcannon_back.yScale = 0.15,0.15
	local tcannon_front = display.newImage("images/1front.png",tcannon_barrel.x - 5,tcannon_barrel.y + 2)
	tcannon_front.xScale, tcannon_front.yScale = 0.15,0.15
	tcannon[t]:insert(tcannon_barrel)
	tcannon[t]:insert(tcannon_back)
	tcannon_barrel:toFront()
	tcannon[t]:insert(tcannon_front)
	tcannon[t].kind = "shooter"
	tcannon[t].enterFrame = movePlat
	Runtime:addEventListener("enterFrame",tcannon[t])

	local tcannon_body = display.newRect(tcannon_barrel.x - 20,tcannon_barrel.y - 20,20,20)
	tcannon_body.kind = "shooter"
	tcannon_body.alpha = 0
	physics.addBody(tcannon_body,"static",{isSensor=true,shape={40,20,-40,20,-30,70,40,70}})
	tcannon_body.group = tcannon[t]
	tcannon_body.enterFrame = movePlat
	Runtime:addEventListener("enterFrame",tcannon_body)

	local function checkRotation()
		local function shootTcannon(self,deltaX,deltaY,normDeltaX,normDeltaY)
			if man.y < 200 then 
				deltaX = self.x + posX - man.x 
				deltaY = self.y + posY - man.y
				normDeltaX = deltaX / math.sqrt(math.pow(deltaX,2) + math.pow(deltaY,2))
				normDeltaY = deltaY / math.sqrt(math.pow(deltaX,2) + math.pow(deltaY,2))
				transition.to(tcannon_barrel,{time=100,rotation=(math.atan2(deltaY,deltaX) * 180 / math.pi) -80,onComplete=function() 
					tbullet = display.newCircle(self.x + (posX -15),posY,10)
					tbullet.alpha = 0
					tbullet.kind = "ball"
					physics.addBody(tbullet,"dynamic",{density=2000})
					tbullet:setFillColor(0,0,0)
					tbullet:setLinearVelocity(normDeltaX*-1000,normDeltaY*-1200)
					self:toFront()
					transition.to(tbullet,{time=150,alpha=1})
					transition.to(tcannon_barrel,{delay=200,time=400,rotation=-90})
				end})
			end
		end
		local function callIt(self)
			timer.performWithDelay(1500,function() shootTcannon(self,0,0,0,0) end,1)
		end
		callIt(tcannon[t])
	end
	checkRotation()
end
--TREE CODE-----------------------------------
local function spawnTree(treeX,treeY)
	local treeVar = treeX
	for i=1,math.random(0,2) do 
		tree_num = tree_num + 1
		tree[tree_num] = display.newImage(setStage.tree)
		tree[tree_num].x = treeVar
		tree[tree_num].y = treeY
		local treeScale = math.random(3,4)/10
		tree[tree_num]:scale(treeScale,treeScale)
		tree[tree_num].kind = "shooter"
		tree[tree_num].enterFrame = movePlat
		Runtime:addEventListener("enterFrame",tree[tree_num])
		treeVar = treeVar + math.random(20,30)
		if tree[tree_num].xScale < 0.4 then 
			tree[tree_num].y = tree[tree_num].y + 10
		end
	end
end

local function newCannon(cx,cy)
	cannon_var = cannon_var + 1 
	local newCannon = display.newGroup()
	local barrel = display.newImage(setStage.cannon,cx,cy)
	barrel.xScale,barrel.yScale = 0.15,0.15
	local base = display.newImage(setStage.cannonbase,barrel.x + 15,231)
	base.xScale,base.yScale = 0.15,0.15
	newCannon:insert(barrel)
	newCannon:insert(base)
	newCannon.y = 10
	newCannon.kind = "shooter"
	newCannon.enterFrame = movePlat
	Runtime:addEventListener("enterFrame",newCannon)
	cannon[cannon_var] = newCannon
	local cannonColl = display.newCircle(barrel.x,barrel.y,20)
	cannonColl.alpha = 0 
	cannonColl.kind = "shooter"
	cannonColl.group = newCannon
	cannonColl.isHitTestable = true
	physics.addBody(cannonColl,"static",{isSensor=true,shape={40,20,-40,20,-30,70,40,70}})
	cannonColl.enterFrame = movePlat
	Runtime:addEventListener("enterFrame",cannonColl)
	shootIt(newCannon,platform[platform_num])
end


--PLATFORM CODE-----------------------------------
spawnNextPlat = function()
	if stopPlats == false then 
		platform_chose = math.random(1,3)
		cannon_go = choseCannon()
		platform_num = platform_num + 1

		platform[platform_num] = display.newImage("images/"..setStage.platform..platform_chose..".png",600 + platform_prevW,300)
		platform[platform_num].anchorX = 0
		platform[platform_num].kind = "plat"
		platform[platform_num].go = true

		platform[platform_num].enterFrame = movePlat
		Runtime:addEventListener("enterFrame",platform[platform_num])
		physics.addBody(platform[platform_num],"kinematic",{density=500,bounce=0})
		platform_prevW = platform[platform_num].width

		cd = display.newRect(platform[platform_num].x+3,platform[platform_num].y - 27,13,40 )
		cd.kind = "plat"
		cd.coll = "cd"
		cd.enterFrame = movePlat
		Runtime:addEventListener("enterFrame",cd)
		physics.addBody(cd,"kinematic")

		cd2 = display.newRect(platform[platform_num].x + platform[platform_num].width - 3,platform[platform_num].y - 25,13,40)
		cd2.kind = "plat"
		cd2.coll = "cd"
		cd2.enterFrame = movePlat
		Runtime:addEventListener("enterFrame",cd2)
		physics.addBody(cd2,"kinematic")

		if cannon_go == 1 then 
			newCannon(platform[platform_num].x + platform[platform_num].width/2,215)
		elseif cannon_go == -1 then 
			newLandGunner(platform[platform_num].x + platform[platform_num].width/2 ,160)
		elseif cannon_go == 2 then 
			newTCannon(platform[platform_num].x + platform[platform_num].width/2,240)
		elseif cannon_go == 3 then 
			newRocket(platform[platform_num].x + platform[platform_num].width/2,200)
		end
		mountPos()
		spawnTree(platform[platform_num].x + platform[platform_num].width/2 + math.random(-40,40),208)
	end
end

local newRocketVar = 0

--ROCKET CODE-----------------------------------
newRocket = function(rocketx,rockety)
	local playshootVar = true 
	rocket_var = rocket_var + 1
	rocket[rocket_var] = display.newGroup()
	local r_barrelInfo = require("rocket")
	local r_barrelSheet = graphics.newImageSheet( "images/rocket.png", r_barrelInfo:getSheet() )
	local r_barrelOrderData = {
		{name="1",start=2,count=1,time=0,loopCount=1},
		{name="0",start=3,count=1,time=0,loopCount=1},
		{name="2",start=1,count=1,time=0,loopCount=1}}

	local r_barrel = display.newSprite( r_barrelSheet,r_barrelOrderData )
	r_barrel.x, r_barrel.y = rocketx,rockety
	r_barrel:scale(0.2,0.2)
	r_barrel:setSequence("2")
	r_barrel.isLocked = false
	r_barrel.rotation = -70
	local r_base = display.newImage("images/r_base.png",r_barrel.x - 10,r_barrel.y+30)
	r_base:scale(0.5,0.5)
	local r_bullet2 = display.newImage("images/r_bullet.png",r_barrel.x + 25,r_barrel.y - 5)
	r_bullet2:scale(0.15,0.15)
	r_bullet2.alpha = 0
	r_bullet2.anchorX = 1
	r_bullet2.kind = "ball"
	r_bullet2.anchorY = 1
	r_bullet2.rotation = -70
	--physics.addBody(r_bullet2,"kinematic",{radius=20,isSensor=true}) 

	local r_bullet1 = display.newImage("images/r_bullet.png",r_barrel.x + 20,r_barrel.y - 10)
	r_bullet1:scale(0.15,0.15)
	r_bullet1.alpha = 0
	r_bullet1.kind = "ball"
	r_bullet1.anchorX = 1
	r_bullet1.anchorY = 1
	r_bullet1.rotation = -70
	--physics.addBody(r_bullet1,"kinematic",{radius=20,isSensor=true}) 

	local r_checkCollision = display.newRect(r_barrel.x,r_barrel.y,300,5)
	r_checkCollision.anchorX,r_checkCollision.anchorY = 1,1
	r_checkCollision.rotation = 20
	r_checkCollision.alpha = 0
	r_checkCollision.group = rocket[rocket_var]
	r_checkCollision.isHitTestable = true
	physics.addBody(r_checkCollision,"static",{isSensor=true})

	local r_checkCollision2 = display.newRect(r_barrel.x,r_barrel.y + 15,5,5)
	r_checkCollision2.alpha = 0
	r_checkCollision2.kind = "shooter"
	r_checkCollision2.string = "rocket"
	r_checkCollision2.group = rocket[rocket_var]
	r_checkCollision2.isHitTestable = true
	r_checkCollision2.enterFrame = movePlat
	Runtime:addEventListener("enterFrame",r_checkCollision2)
	physics.addBody(r_checkCollision2,"static",{shape={40,20,-40,20,-30,70,40,70},isSensor=true})

	rocket[rocket_var]:insert(r_checkCollision)
	rocket[rocket_var]:insert(r_bullet2)
	rocket[rocket_var]:insert(r_bullet1)
	rocket[rocket_var]:insert(r_barrel)
	rocket[rocket_var]:insert(r_base)
	rocket[rocket_var].kind = "rocket"

	for i=1,5 do
		rocket[rocket_var][i].enterFrame = movePlat
		Runtime:addEventListener("enterFrame",rocket[rocket_var][i])
	end

	local goTime = math.random(1000,2000)
	local barrelTrans = transition.to(r_barrel,{delay=goTime,time=3000,rotation=-100,transition=easing.continuousLoop,iterations=-1})
	local bulletTrans1 = transition.to(r_bullet1,{delay=goTime,time=3000,rotation=-100,transition=easing.continuousLoop,iterations=-1})
	local bulletTrans2 = transition.to(r_bullet2,{delay=goTime,time=3000,rotation=-100,transition=easing.continuousLoop,iterations=-1})
	local checkTrans = transition.to(r_checkCollision,{delay=goTime,time=3000,rotation=-10,transition=easing.continuousLoop,iterations=-1})

	local function shootRocket(mx,my,bullet,seq,rocket)
		if rocket.kind ~= "nil" and bullet.x > 120 then
			timer.performWithDelay(1,function()
				physics.addBody(bullet,"dynamic",{radius=20,isSensor=true}) 
				Runtime:removeEventListener("enterFrame",bullet)
				bullet.alpha = 1
				rocket[4]:setSequence(seq)
				rocket[4]:play()

				deltaX = rocket[4].x - mx
				deltaY = rocket[4].y - my    

				normDeltaX = deltaX / math.sqrt(math.pow(deltaX,2) + math.pow(deltaY,2))
				normDeltaY = deltaY / math.sqrt(math.pow(deltaX,2) + math.pow(deltaY,2))

				bullet:setLinearVelocity(normDeltaX*-1000,normDeltaY*-1000)

				transition.cancel(barrelTrans)
				transition.cancel(bulletTrans1)
				transition.cancel(bulletTrans2)
				transition.cancel(checkTrans)
			 end,1)
		end
	end

	local function rocketSensor(event,mx,my,rr)
		if r_barrel.isLocked == false and event.other.kind == "man" and playshootVar == true then
			newRocketVar = newRocketVar + 1
			mx = man.x
			my = man.y
			rr = r_barrel.rotation - 40 
			playshootVar = false
			if r_bullet1 then 
				shootRocket(mx,my,rocket[newRocketVar][3],"1",rocket[newRocketVar])
				timer.performWithDelay(200,function() 
					if r_bullet2 then 
						shootRocket(mx,my,rocket[newRocketVar][2],"0",rocket[newRocketVar])
					end
				end,1)
			end
		end
	end
	r_checkCollision:addEventListener("collision",rocketSensor)
end

local function moveWaterObjects(self)
	if self.kind == "ship" then 
		self.x = self.x - gameSpeed/3
	elseif self.kind == "boat" then
		self.x = self.x - gameSpeed
	end
	if self.x < -1000 then 
		self.kind = "nil"
		Runtime:removeEventListener("enterFrame",self)
		self:removeSelf()
		self = nil
	end
end 

local ship
local boat = {}
local boat_num = 0 
local boatGunner = {}
local boatGunner_num = 0
local wgBullet = {}
local wgBullet_num = 0

local function shootBoatGunner(self)
	timer.performWithDelay(1900,function() 
		for i=1,3 do 
			timer.performWithDelay(i*400,function()
				wgBullet_num = wgBullet_num + 1
				transition.to(self,{time=200,rotation=self.rotation + 7.5})
				transition.to(self,{time=200,xScale=0.16,yScale=0.16,transition=easing.continuousLoop})
				wgBullet[wgBullet_num] = display.newCircle(self.x,self.y,5)
				wgBullet[wgBullet_num].alpha = 0
				wgBullet[wgBullet_num]:setFillColor(0,0,0)
				physics.addBody(wgBullet[wgBullet_num],"dynamic",{density=100000})
				wgBullet[wgBullet_num]:setLinearVelocity(-800,-100+ (-40*1.5 * i))
				timer.performWithDelay(100,function() wgBullet[wgBullet_num].alpha = 1  end,1)
			end,1)
		end
	end,1)
end


local function spawnShip()
	ship = display.newImage("images/bigship.png")
	ship:scale(1,1)
	ship.x = 1200
	ship.y = 230
	ship.kind = "ship"
	ship.enterFrame = moveWaterObjects
	Runtime:addEventListener("enterFrame",ship)
	mountPos()
end

local function spawnBoatGunner(gx,gy)
	boatGunner_num = boatGunner_num + 1
	boatGunner[boatGunner_num] = display.newImage("images/gunner.png")
	boatGunner[boatGunner_num].x = gx + 40
	boatGunner[boatGunner_num].y = gy 
	boatGunner[boatGunner_num].anchorX = 1
	boatGunner[boatGunner_num].anchorY = 0.5
	boatGunner[boatGunner_num].kind = "boat" 
	boatGunner[boatGunner_num]:scale(0.15,0.15)
	boatGunner[boatGunner_num].enterFrame = moveWaterObjects
	Runtime:addEventListener("enterFrame",boatGunner[boatGunner_num])
	mountPos()
	shootBoatGunner(boatGunner[boatGunner_num])
end 


local function spawnBoat()
	boat_num = boat_num + 1 
	boat[boat_num] = display.newImage("images/boat.png")
	boat[boat_num].x = 1000
	boat[boat_num].y = 270
	boat[boat_num].kind = "boat"
	boat[boat_num]:scale(0.2,0.2)
	spawnBoatGunner(boat[boat_num].x,boat[boat_num].y - 50)
	boat[boat_num].enterFrame = moveWaterObjects
	Runtime:addEventListener("enterFrame",boat[boat_num])
	mountPos()
end

asHealth = function(healthVar)
	healthGroup.alpha = 1
	Runtime:addEventListener( "enterFrame", barListener )
	health_num = health_num + healthVar
	if healthVar < 0 then 
		for i=1,(20 - health_num) do
			if health[i] then
				health[i].alpha = 0
			end 
		end
	elseif healthVar > 0 then 
		for i=1,20 do
			if health[i] and i > 20 - health_num then
				health[i].alpha = 1
			end
		end
	end
end




--PLACEMENT + TRANSITION-------------
-------------------------------------
-------------------------------------
-------------------------------------
-------------------------------------

local function checkBackMount1()
	if mountainBack1.x > 600 then
		mountainBack1.fill = setStage.backmount
		Runtime:removeEventListener("enterFrame",checkBackMount1)
		timer.performWithDelay(50000/gameSpeed,function() mountainBack2.fill = setStage.backmount end,1)
	end
end

local function checkBackMount2()
	if mountainBack2.x > 600 then
		mountainBack2.fill = setStage.backmount
		Runtime:removeEventListener("enterFrame",checkBackMount2)
		timer.performWithDelay(50000/gameSpeed,function() mountainBack1.fill = setStage.backmount end,1)
	end
end 

local function transition_Snow()
	timer.performWithDelay(10000,function() makeItSnow() setStage = gameScene.ice 
	Runtime:addEventListener("enterFrame",checkBackMount1) Runtime:addEventListener("enterFrame",checkBackMount2) end,1)
	timer.performWithDelay(15000,function() 
		transition.to(stageIndex,{time=300,xScale=1,yScale=1,alpha=1})
		stageIndex.text = "Round 2"
		transition.to(stageIndex,{delay=300,time=500,xScale=0.9,yScale=0.9,transition=easing.continuousLoop,iterations=1,onComplete=function()
		transition.to(stageIndex,{delay=700,time=200,alpha=0,xScale=1.3,yScale=1.3})end})
  end,1)
end
timer.performWithDelay(30000,function() transition_Snow() end,1)

local function transition_Water()
	Runtime:addEventListener("enterFrame",checkBackMount1)
	Runtime:addEventListener("enterFrame",checkBackMount2)
	timer.performWithDelay(45000/gameSpeed,function() spawnShip()  spawnBoat() end,1) 
	timer.performWithDelay(40000/gameSpeed,function() stopPlats = true setStage = gameScene.water end,1) 
	timer.performWithDelay(40000/gameSpeed,function() stopMounts = true end,1) 
	stopHills = true 
end

timer.performWithDelay(65000,function() transition_Water() end,1)


mountPos = function()
	if stopMountPos == false then 
		clouds:toFront()
		clouds2:toFront()
		mountainBack1:toFront()
		mountainBack2:toFront()
		for i=1,mountain_var do
		if mountain[i] ~= nil and mountain[i].kind == "mountain" then
			mountain[i]:toFront()
			end
		end
		for i=1,mount2_var do 
		if mount2[i] ~= nil and  mount2[i].kind == "backHill"  then
			mount2[i]:toFront()
			end
		end
		for i=1,mount1_var do
		if mount1[i] ~= nil and mount1[i].kind == "hill"  then
			mount1[i]:toFront()
			end
		end
		coinGroup:toFront()
		for i=1,smoke_var do
			if smoke[i] ~= nil and smoke[i].kind == "smoke" then 
				smoke[i]:toFront()
			end
		end
		for i=1,tree_num do
			if tree[i] and tree[i].kind == "shooter" then
				tree[i]:toFront() 
			end
		end
		for i=1,cannon_var do 
			if cannon[i] and cannon[i].kind == "shooter" then
				cannon[i]:toFront()
			end
		end
		if ship ~= nil and ship.kind == "ship" then 
			ship:toFront()
		end
		for i=1,wgBullet_num do
			if wgBullet[i] ~= nil then 
				wgBullet[i]:toFront()
			end
		end
		for i=1,boatGunner_num do
			if boatGunner[i] ~= nil and boatGunner[i].kind == "boat" then
				boatGunner[i]:toFront() 
			end 
		end
		for i=1,boat_num do
			if boat[i].kind ~= nil and boat[i].kind == "boat" then
				boat[i]:toFront()
			end
		end
		splash:toFront()
		water1:toFront()
		water2:toFront()
		for i=1,platform_num  do 
			if platform[i] and platform[i].kind == "plat" then
				platform[i]:toFront() 
			end
		end
		for i=1,ball_var do
			if ball[i] and ball[i].kind == "ball" then
				ball[i]:toFront()
			end
		end
		if startPlat and startPlat.kind == "plat" then 
			startPlat:toFront()
		end
		for i=1,#DL.coin do 
			if DL.coin[i] ~= nil and DL.coin[i].kind == "coin" then 
				DL.coin[i]:toFront()
			end
		end
		for i=1,rocket_var do 
			if rocket[i] ~= nil and rocket[i].kind == "rocket" then 
				rocket[i]:toFront()
			end
		end
		for i=1,gunner_num do
			if gunner[i].kind == "shooter" then
				gunner[i]:toFront()
			end
		end
		if tbullet ~= nil then 
			tbullet:toFront()
		end
		for i=1,t do
			if tcannon[i] and tcannon[i].kind == "shooter" then
				tcannon[i]:toFront()
			end
		end
			if tcannon[i] and tcannon[i].kind == "shooter" then
				tcannon[i]:toFront()
		end
		for i=1,shardAm do
			if shards[i] ~= nil and shards[i].kind == "shard" then 
				shards[i]:toFront()
			end
		end
		stageIndex:toFront()
		explosion:toFront()
		man:toFront()
		healthGroup:toFront()
	end
end


--Making Startup Images--------------------------
for i=0,3 do
	spawnMounts(i*400,false)
end
for i=0,3 do
	spawnBackMounts(i*400,false)
end
for i=0,5 do
	 spawnMountains(i*200)
end
mountPos()
spawnNextPlat()
----------------------------

mountainBack1.enterFrame = moveMountains
mountainBack2.enterFrame = moveMountains
startPlat.enterFrame = movePlat 
Runtime:addEventListener("enterFrame",mountainBack1)
Runtime:addEventListener("enterFrame",mountainBack2)
Runtime:addEventListener("enterFrame",startPlat)


