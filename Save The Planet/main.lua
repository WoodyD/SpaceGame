local physics = require("physics");
local shipsModule = require("modules.shipsModule");
physics.start();
physics.setGravity(0, 0);
physics.setDrawMode("hybrid");

--> hide upper mobile bar 
display.setStatusBar(display.HiddenStatusBar);

centerX = display.contentWidth/2;
centerY = display.contentHeight/2;

--set background and size of bg
local background = display.newImage("images/space-1.jpg", centerX, centerY);
background:scale(display.contentWidth/background.contentWidth, display.contentHeight/background.contentHeight);

--set planet, size, health and physics of planet
local planet = display.newImage("images/planet-1.png", centerX, centerY);
planet:scale(display.contentWidth/(planet.contentWidth*3), display.contentWidth/(planet.contentWidth*3));
physics.addBody(planet, "static", {radius=display.contentWidth/8});
local planetHealth = 3000;
local displayHealth = display.newText("Health: "..planetHealth, (display.contentWidth-300), 20, "Arial", 30);
local playerScore = 0;
local displayScore = display.newText("Score: "..playerScore, 300, 20, "Arial", 30);

local function shipAttack()
	timer.performWithDelay(2000, function()
		local ship = shipsModule.createShip();
		physics.addBody(ship.body, "dynamic");
		transition.to(ship.body, {x=display.contentWidth/2, y=display.contentHeight/2, time=1500});

		--collision handler
		local function onLocalCollision( self, event )
		    if ( event.phase == "began" ) then
		    	planetHealth = planetHealth - ship.health;
		    	displayHealth:removeSelf();
		    	displayHealth = display.newText("Health: "..planetHealth, (display.contentWidth-300), 20, "Arial", 30);
		    	timer.performWithDelay(1, function()
		    		ship.body:removeSelf();
        			ship = nil;
        		end, 1);
    		end
		end
		ship.body.collision = onLocalCollision;
		ship.body:addEventListener("collision", ship.body);

		--tap handler
		local function myTapListener( event )
			playerScore = playerScore + ship.health;
		    displayScore:removeSelf();
			displayScore = display.newText("Score: "..playerScore, 300, 20, "Arial", 30);
		    timer.performWithDelay(1, function()
		    	ship.body:removeSelf();
        		ship = nil;
        	end, 1);
		end
		ship.body:addEventListener( "tap", myTapListener )

	end, -1);
end

shipAttack();