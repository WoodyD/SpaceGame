local physics = require("physics");
local shipsModule = require("modules.shipsModule");
physics.start();
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
local planetHealth = 3000;
physics.addBody(planet, "static", {radius=display.contentWidth/8});

--creating ship and physics of ship
local ship = shipsModule.createShip();
print(ship.health);
