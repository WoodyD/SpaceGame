module(...,package.seeall);
local physics = require("physics");
physics.start();
physics.setDrawMode("hybrid");

--creating ship
function createShip()
	ship = newShip();
	local shipX, shipY = ship.body:localToContent( 0, 0 );
	print(shipX, shipY);
	shipOrientation(ship.body, shipX, shipY);
	return ship;
end

--creating ships with physics
function createFlyingShips()
	timer.performWithDelay(2000, function()
		local ship = newShip();
		local shipX, shipY = ship.body:localToContent( 0, 0 );
		--print(shipX, shipY);
		shipOrientation(ship.body, shipX, shipY);
		physics.addBody(ship.body, "dynamic");
		transition.to(ship, {x=display.contentWidth/2, y=display.contentHeight/2, time=1500});
		return ship{};
		end, -1);
end

--creating random ship with health
function newShip()
	local ship = {};
	local shipNumber = math.random(4);
	local shipX = shipX();
	local shipY = shipY();

	if (shipNumber==1) then
		ship.body = display.newImage("shipsImages/spaceship-1.png", shipX, shipY);
		ship.health = 10;
		return ship;
	end
	if (shipNumber==2) then
		return display.newImage("shipsImages/spaceship-2.png", shipX, shipY);
	end
	if (shipNumber==3) then
		return display.newImage("shipsImages/spaceship-3.png", shipX, shipY);
	end
	if (shipNumber==4) then
		return display.newImage("shipsImages/spaceship-4.png", shipX, shipY);
	end
end

--creating coordinates for ship
function shipX()
	local rand = math.random(2);
	local shipX = 0;
	if (rand==2) then
		shipX = display.contentWidth;
	end
	return shipX;
end

function shipY()
	local rand = math.random(2);
	local shipY = 0;
	if (rand==2) then
		shipY = display.contentHeight;
	end
	return shipY;
end

--set the orientation of ship
function shipOrientation(ship, shipX, shipY)
	if (shipX==0 and shipY==0) then
		transition.to( ship, { rotation=125, time=0, transition=easing.inOutCubic } );
	end
	if (shipX==display.contentWidth and shipY==0) then
		transition.to( ship, { rotation=-125, time=0, transition=easing.inOutCubic } );
	end
	if (shipX==display.contentWidth and shipY==display.contentHeight) then
		transition.to( ship, { rotation=-55, time=0, transition=easing.inOutCubic } );
	end
	if (shipX==0 and shipY==display.contentHeight) then
		transition.to( ship, { rotation=55, time=0, transition=easing.inOutCubic } );
	end
end

--function shipMove()


