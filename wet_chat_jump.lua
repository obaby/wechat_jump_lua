require "TSLib"
require("math")
-----------------------------------------------
-- Auto jump scripy
-- Code by obaby
-- http://www.h4ck.org.cn
-- Findu App http://findu.co
-----------------------------------------------

-- define scan zone with (x1,y1) (x2,y2)
scanZone_x1 = 50;
scanZone_y1 = 600;
scanZone_x2 = 1000;
scanZone_y2 = 922;


-- get the target object position
function getDestXY()
	-- body
	mSleep(1000);
	isfound = 0;
	dest_x = 0;
	dest_y = 0;
	for y = scanZone_y1,scanZone_x2,30 do
		for x =scanZone_x1,scanZone_x2,30 do
			colorb = getColor(x, y)
			colorc = getColor(x-30, y)
			colord = getColor(x+50, y)
			delta = math.abs(colorb -colorc)
			delta2 = math.abs(colord - colorb)
			--toast(delta.." :x:"..x.." :y:"..y,1)
			--mSleep(100)
			if delta >1000 then
				--toast(delta.." :x:"..x.." :y:"..y,1)
				nLog("COLO TO::ColorB:"..colorb.." ColorC:"..colorc);
				isfound = 1;
				dest_x = x;
				dest_y = y;
				--mSleep(5000);
				break;
			end

			--dialog("ColorB:"..colorb.."ColorC:"..colorc, 3);
			--mSleep(3000)
			--x= x+10

		end
		--y= y+10
		if isfound ==1 then

			break;
		end

	end
	return dest_x, dest_y
end

-- get the 
function getDistance(dest_x, dest_y)
	-- body
	--mSleep(1000);
	x, y = findColorInRegionFuzzy( 0x39375f , 80, 0, 926, 1070, 1370); 
	if x == -1 then
		x, y = findColorInRegionFuzzy( 0x39375f , 70, 0, 926, 1070, 1370); 
	end
	if x == -1 then
		x, y = findColorInRegionFuzzy( 0x39375f , 80, 0, 926, 1070, 1370); 
	end
	if x ==-1 then
		return 0;
	end

	org_x = 796;
	org_y = 1100;
	org_x1 = 336
	org_y1 = 1110
	if dest_x >500 then
		org_x = org_x1;
		org_y = org_y1;
	end
	nLog("JUMP FR::src_x:"..x.." src_y:"..y);
	distance = math.sqrt(math.pow(dest_x - x,2) + math.pow(dest_y-y,2));
	
	if math.abs(dest_y - y) <(1116-940) then
		return (1116-940)*1.4;
	end
	
	
	return distance;
end


while (true) do
	-- body
	if (isColor( 581, 1626, 0xffffff, 85) and  isColor( 558, 1714, 0x262628, 85)) then
		break;
	end

	dest_x , dest_y = getDestXY();
	dist = getDistance(dest_x,dest_y);
	toast("dest_x:"..dest_x.." dest_y:"..dest_y.." distance:"..math.floor(dist),3);
	--toast(dist,1)
	--can not get dest position or can not get the source position
	nLog("JUMP TO::dst_x:"..dest_x.." dst_y:"..dest_y.." distance:"..math.floor(dist));
	if dest_x ==scanZone_x1 or dist == 0 or dest_y == scanZone_y1 or dest_x ==scanZone_x2 then
		toast("Get posison error",1);
		nLog("ERRO ER:: Get position error")
		break;
	end 
	
	touchDown(dest_x, dest_y);
	mSleep(dist*1.3);
	touchUp(dest_x, dest_y);
	
end




