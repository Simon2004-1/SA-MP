#include a_samp
#include dutils
//#include textdraws
#define MAX_ZONE_NAME 28
/*
native ---FARBEN---()
native Hellrot(0xFF0000FF)
native Hellgrün(0x00FF00FF)
native Hellblau(0x0091FFFF)
native Gelb(0xFFFF00AA)
native Weis(0xFFFFFFFF)
native TextdrawFarbe(0xFFFFFF24)

native
native ---BEFEHLE---()
native ChangePlayerMoney(playerid, amount, reason);
native Wika(playerid)
native GetSname(playerid)
native GetPlayerIDFromName(Playername)
native DebugMessage(playerid, text[])
native SendInfoText(playerid, text[])
native SendWarningText(playerid, text[])

native
native ---SONSTIGES---()
native GetDatum()
native GetWochentag()
native WochentagKurz()
native IsPlayerInRangeOfVehicle(playerid, vehicleid, Float:dist)
native IsAPlane(vehicleid)
native IsAAircraft(vehicleid)
native IsAHeli(vehicleid)
native IsABoat(vehicleid)
native IsAMountainBike(vehicleid)
native IsAMotorBike(vehicleid)
native IsATruck(vehicleid)
native RandomColor()
native GetVehicleMass(modelid)
native GetVehicleDriveType(modelid)
native SecondsToMinutes(seconds)
*/
#define Hellrot 0xFF0000FF

#define Hellgrün 0x00FF00FF

#define Hellblau 0x0091FFFF

#define Gelb 0xFFFF00AA

#define Weis 0xFFFFFFFF

#define TextdrawFarbe 0xFFFFFF24

forward OnPlayerCoonnect(playerid);// remove unused symbols
public OnPlayerCoonnect(playerid)// remove unused symbols
{
if (IsNumeric("Test")) return 1;
SecondsToMinutes(1);
return 1;
}

stock ChangePlayerMoney(playerid, amount, reason[])
{
   new Spielern[64];
   new Moneystring[255];
   //if(!playerid) return 0;
   //if(!reason[]) return -1;
   if(amount == 0) return 1;
   GivePlayerMoney(playerid, amount);
   format(Spielern,sizeof(Spielern),"/Spieler/%s.txt",GetSname(playerid));
   new AltGeld = dini_Int(Spielern, "Temp_Durchschnittsverbrauch");
   dini_IntSet(Spielern,"Temp_Durchschnittsverbrauch", AltGeld+amount);
   Moneystring = dini_Get(Spielern, "Geld9");
   dini_Set(Spielern,"Geld10", Moneystring);
   Moneystring = dini_Get(Spielern, "Geld8");
   dini_Set(Spielern,"Geld9", Moneystring);
   Moneystring = dini_Get(Spielern, "Geld7");
   dini_Set(Spielern,"Geld8", Moneystring);
   Moneystring = dini_Get(Spielern, "Geld6");
   dini_Set(Spielern,"Geld7", Moneystring);
   Moneystring = dini_Get(Spielern, "Geld5");
   dini_Set(Spielern,"Geld6", Moneystring);
   Moneystring = dini_Get(Spielern, "Geld4");
   dini_Set(Spielern,"Geld5", Moneystring);
   Moneystring = dini_Get(Spielern, "Geld3");
   dini_Set(Spielern,"Geld4", Moneystring);
   Moneystring = dini_Get(Spielern, "Geld2");
   dini_Set(Spielern,"Geld3", Moneystring);
   Moneystring = dini_Get(Spielern, "Geld1");
   dini_Set(Spielern,"Geld2", Moneystring);
   if(amount > 0)
   {
      format(Moneystring, sizeof Moneystring, "+%i$: %s", amount, reason);
   }
   else
   {
      format(Moneystring, sizeof Moneystring, "%i$: %s", amount, reason);
   }
   dini_Set(Spielern,"Geld1", Moneystring);
   return 1;
}

/*{
test
}*/

stock DebugMessage(playerid, string[])
{
if(!IsPlayerAdmin(playerid)) return 0;
return SendClientMessage(playerid, Weis, string);
}

stock GetSname(playerid)
{
new SSname[50];
GetPlayerName(playerid,SSname,sizeof(SSname));
return SSname;
}

SecondsToMinutes(seconds)
{
   new tmp[20];
   new minutes = floatround(seconds/60);
   seconds -= minutes*60;
   format(tmp, sizeof(tmp), "%d:%02d", minutes, seconds);
   return tmp;
}

stock RandomColor()
{
new randomcolor = random(255);
return randomcolor;
}

#define MAX_VEHICLE_NUMBERPLATE 14
enum vSync_Internal_Data
{
	vSync_NumberP[MAX_VEHICLE_NUMBERPLATE]
}
static vSync_gVehicleInternal[MAX_VEHICLES][vSync_Internal_Data];

stock IsPlayerInRangeOfVehicle(playerid, vehicleid, Float:dist)
{
	new Float:pos[3];
	GetVehiclePos(vehicleid, pos[0], pos[1], pos[2]);
	return IsPlayerInRangeOfPoint(playerid, dist, pos[0], pos[1], pos[2]);
}

stock Wika(playerid)
{
	SendClientMessage(playerid, -1, "Wika");
	return 0;
}

stock GetPlayerIDFromName(playername[])
{
  	for(new i = 0; i <= MAX_PLAYERS; i++)
  	{
    	if(IsPlayerConnected(i))
    	{
      		new playername2[MAX_PLAYER_NAME];
      		GetPlayerName(i, playername2, sizeof(playername2));
      		if(strcmp(playername2, playername, true, strlen(playername)) == 0)
      		{
        		return i;
      		}
    	}
  	}
  	return INVALID_PLAYER_ID;
}

stock GetPlayerSpeed(playerid, bool: kmh = true)
{
   new Float:x,
	   Float:y,
	   Float:z,
	   Float:pSpeed;
  if(IsPlayerDriver(playerid))
  {
   if(IsPlayerInAnyVehicle(playerid))
   {
	   GetVehicleVelocity(GetPlayerVehicleID(playerid),x,y,z);
   }
   else
   {
       GetPlayerVelocity(playerid,x,y,z);
   }
   pSpeed = floatsqroot((x * x) + (y * y) + (z * z));
   return kmh ? floatround((pSpeed * 187.0)) : floatround((pSpeed * 120.9));
  }
  return 1;
}

stock IsAMountainBike(vehicleid)
{
   switch(GetVehicleModel(vehicleid))
   {
		case 481,509,510:
		return 1;
   }
   return 0;
}

stock IsAMotorBike(vehicleid)
{
   switch(GetVehicleModel(vehicleid))
   {
		case 581, 462, 521, 463, 522, 461, 448, 468, 586, 471:
		return 1;
   }
   return 0;
}

stock IsAAircraft(vehicleid)
{
   switch(GetVehicleModel(vehicleid))
   {
		case 592, 577, 511, 512, 593, 520, 553, 476, 519, 460, 513, 548, 425, 417, 487, 488, 497, 563, 447, 469:
		return 1;
   }
   return 0;
}

stock IsAPlane(vehicleid)
{
   switch(GetVehicleModel(vehicleid))
   {
		case 592, 577, 511, 512, 593, 520, 553, 476, 519, 460, 513:
		return 1;
   }
   return 0;
}

stock IsAHeli(vehicleid)
{
   switch(GetVehicleModel(vehicleid))
   {
		case 548, 425, 417, 487, 488, 497, 563, 447, 469:
		return 1;
   }
   return 0;
}

stock IsABoat(vehicleid)
{
   switch(GetVehicleModel(vehicleid))
   {
		case 472, 473, 493, 595, 484, 430, 453, 452, 446, 454:
		return 1;
   }
   return 0;
}

stock IsATruck(vehicleid)
{
   switch(GetVehicleModel(vehicleid))
   {
		case 403, 443, 515, 514,  524:
		return 1;
   }
   return 0;
}

stock SendInfoText(playerid, text[])
{
new woiwoioi[150];
format(woiwoioi, sizeof woiwoioi, "~n~~n~~n~~n~~n~~n~~n~~n~~n~~w~%s", text);
GameTextForPlayer(playerid, woiwoioi, 4000, 3);
return 1;
}

stock SendWarningText(playerid, text[])
{
new woiwoioi[150];
format(woiwoioi, sizeof woiwoioi, "~r~%s", text);
GameTextForPlayer(playerid, woiwoioi, 4000, 3);
return 1;
}

stock WochentagKurz()
{
    new string[10];
    format(string, 15, "%s", GetWochentag());
	if(strcmp(string, "Monday")==0)
    {
       string = "Mo";
       return string;
    }
	else if(strcmp(string, "Tuesday")==0)
    {
       string = "Tu";
       return string;
    }
	else if(strcmp(string, "Wednesday")==0)
    {
       string = "We";
       return string;
    }
	else if(strcmp(string, "Thursday")==0)
    {
       string = "Th";
       return string;
    }
	else if(strcmp(string, "Friday")==0)
    {
       string = "Fr";
       return string;
    }
	else if(strcmp(string, "Saturday")==0)
    {
       string = "Sa";
       return string;
    }
	else if(strcmp(string, "Sunday")==0)
    {
       string = "Su";
       return string;
    }
    string = "WTF";
    return string;
}

stock GetWochentag()
{
	new var0 = gettime()- 86400;
	new var1 = 5;
	while(var0 >= 86400)
	{
		var0 = var0 - 86400;
		var1++;
		if(var1 == 8)
		{
			var1 = 1;
		}
	}
	new var2[11];
	switch(var1) {
		case 1: var2 = "Monday";
		case 2: var2 = "Tuesday";
		case 3: var2 = "Wednesday";
		case 4: var2 = "Thursday";
		case 5: var2 = "Friday";
		case 6: var2 = "Saturday";
		case 7: var2 = "Sunday";
	}
	return var2;
}

stock GetDatum()
{
new Year, Month, Day;
getdate(Year, Month, Day);
new Datumstr[15];
format(Datumstr, sizeof Datumstr, "%02i/%02i/%i", Day, Month, Year);
return Datumstr;
}

#define MAX_VEHICLE_NUMBERPLATE 14
#define MAX_VEHICLE_NAME 20

enum vSync_Vehicle_Info
{
	Name[MAX_VEHICLE_NAME],
	Seats,
	Windows,
	Float:Mass,
	DriveType,
	EngineType,
	MaxSpeed,
	bool:Nitro,
	Float:NeonOffsetX,
	Float:NeonOffsetY,
    Float:NeonOffsetZ
}
static const vSync_VehicleInfo[212][vSync_Vehicle_Info] = {
	{"Landstalker", 4, 4, 1700.0, '4', 'D', 159, true, -0.924996, 0.009998, -0.674996},
	{"Bravura", 2, 2, 1300.0, 'F', 'P', 148, true, -0.979999, 0.074997, -0.489998},
	{"Buffalo", 2, 2, 1500.0, 'R', 'P', 188, true, -1.034999, -0.029998, -0.579999},
	{"Linerunner", 2, 2, 3800.0, 'R', 'D', 111, true, -0.884998, 1.834998, -1.099997},
	{"Perennial", 4, 4, 1200.0, 'F', 'P', 134, true, -0.839999, -0.064998, -0.419999},
	{"Sentinel", 4, 4, 1600.0, 'R', 'P', 165, true, -0.914999, 0.000000, -0.534999},
	{"Dumper", 1, 1, 20000.0, 'R', 'D', 111, true, -1.129999, 0.354999, -1.219998},
	{"Firetruck", 2, 2, 6500.0, 'R', 'D', 150, true, -1.214998, 0.125000, -0.759998},
	{"Trashmaster", 2, 2, 5500.0, 'R', 'D', 101, true, -0.664999, 0.709999, -0.889998},
	{"Stretch", 4, 4, 2200.0, 'R', 'P', 159, true, -0.914999, -0.294999, -0.474999},
	{"Manana", 2, 2, 1000.0, 'F', 'P', 131, true, -0.879998, 0.000000, -0.389999},
	{"Infernus", 2, 2, 1400.0, '4', 'P', 225, true, -0.969999, 0.004999, -0.559997},
	{"Voodoo", 2, 2, 1800.0, 'R', 'P', 170, true, -0.994997, -0.154999, -0.569998},
	{"Pony", 4, 4, 2600.0, 'R', 'D', 111, true, -0.919999, -0.069999, -0.719999},
	{"Mule", 2, 2, 3500.0, 'R', 'D', 107, true, -0.759998, -0.469998, -0.524999},
	{"Cheetah", 2, 2, 1200.0, 'R', 'P', 194, true, -0.949998, -0.009998, -0.524999},
	{"Ambulance", 4, 4, 2600.0, '4', 'D', 155, true, -1.259999, -0.604999, -0.664999},
	{"Leviathan", 2, 2, 15000.0, '4', 'P', 143, false, -2.255002, 0.859999, -0.124999},
	{"Moonbeam", 4, 4, 2000.0, 'R', 'D', 116, true, -1.004999, 0.089997, -0.829999},
	{"Esperanto", 2, 2, 1800.0, 'R', 'P', 150, true, -0.934997, -0.009998, -0.584999},
	{"Taxi", 4, 4, 1450.0, 'F', 'P', 146, true, -0.954999, -0.009998, -0.444999},
	{"Washington", 2, 2, 1850.0, 'R', 'P', 155, true, -0.929997, -0.029998, -0.589999},
	{"Bobcat", 2, 2, 1700.0, '4', 'D', 141, true, -0.889998, 0.009998, -0.609999},
	{"Mr. Whoopee", 2, 2, 1700.0, 'R', 'D', 100, true, -0.999997, 0.164995, -0.714999},
	{"BF Injection", 2, 0, 1200.0, 'R', 'P', 137, true, -0.739997, 0.039999, -0.234999},
	{"Hunter", 1, 1, 10000.0, '4', 'P', 214, false, -0.639998, 2.475008, -0.789999},
	{"Premier", 4, 4, 1600.0, 'R', 'P', 175, true, -0.969999, 0.000000, -0.464998},
	{"Enforcer", 4, 4, 4000.0, 'R', 'D', 167, true, -1.124999, -0.714999, -0.734999},
	{"Securicar", 4, 2, 7000.0, 'R', 'D', 158, true, -1.124999, 0.054999, -0.759998},
	{"Banshee", 2, 2, 1400.0, 'R', 'P', 203, true, -0.844999, 0.004999, -0.474999},
	{"Predator", 1, 0, 2200.0, 'R', 'P', 184, false, 0.000000, 0.000000, 0.000000},
	{"Bus", 9, 2, 5500.0, 'R', 'D', 131, true, -1.304998, 2.300004, -0.714999},
	{"Rhino", 1, 0, 25000.0, '4', 'D', 95, true, 0.000000, 0.000000, 0.000000},
	{"Barracks", 2, 2, 10500.0, '4', 'D', 112, true, -0.579999, 0.994997, -0.874997},
	{"Hotknife", 2, 2, 1400.0, 'R', 'P', 169, true, 0.000000, 0.000000, 0.000000},
	{"Article Trailer", 1, 0, 3800.0, 'R', 'D', 0, true, 0.000000, 0.000000, 0.000000},
	{"Previon", 2, 2, 1400.0, 'F', 'P', 150, true, -0.859999, -0.024999, -0.489998},
	{"Coach", 9, 0, 9500.0, 'R', 'D', 159, true, -1.314998, 2.245002, -0.724999},
	{"Cabbie", 4, 4, 1750.0, 'R', 'P', 144, true, -0.969999, -0.034999, -0.674996},
	{"Stallion", 2, 2, 1600.0, 'R', 'P', 170, true, -0.884998, 0.034999, -0.644999},
	{"Rumpo", 4, 4, 2000.0, 'F', 'P', 137, true, -0.914999, -0.045000, -0.899999},
	{"RC Bandit", 1, 0, 100.0, '4', 'E', 76, true, 0.000000, 0.000000, 0.000000},
	{"Romero", 2, 2, 2500.0, 'R', 'P', 140, true, -1.004999, -0.074997, -0.604999},
	{"Packer", 2, 2, 8000.0, 'R', 'D', 127, true, -0.809997, 2.770015, -1.174998},
	{"Monster", 2, 2, 5000.0, '4', 'P', 111, true, -1.064998, 0.000000, 0.135000},
	{"Admiral", 4, 4, 1650.0, 'F', 'P', 165, true, -0.949998, 0.000000, -0.519999},
	{"Squallo", 1, 0, 2200.0, 'R', 'P', 240, false, 0.000000, 0.000000, 0.000000},
	{"Seasparrow", 2, 2, 3000.0, '4', 'P', 145, false, -1.004999, 0.259999, -0.769999},
	{"Pizzaboy", 1, 0, 350.0, 'R', 'P', 190, false, 0.000000, 0.000000, 0.000000},
	{"Tram", 2, 0, 1900.0, 'R', 'P', 185, false, 0.000000, 0.000000, 0.000000},
	{"Article Trailer 2", 1, 0, 3800.0, 'R', 'D', 0, true, 0.000000, 0.000000, 0.000000},
	{"Turismo", 2, 2, 1400.0, '4', 'P', 195, true, -0.984999, -0.194995, -0.519999},
	{"Speeder", 1, 0, 2200.0, 'R', 'P', 183, false, 0.000000, 0.000000, 0.000000},
	{"Reefer", 1, 0, 5000.0, 'R', 'P', 57, false, 0.000000, 0.000000, 0.000000},
	{"Tropic", 1, 0, 2200.0, 'R', 'P', 130, false, 0.000000, 0.000000, 0.000000},
	{"Flatbed", 2, 2, 8500.0, 'R', 'D', 159, true, -0.579999, 0.979999, -0.859999},
	{"Yankee", 2, 2, 4500.0, 'R', 'D', 107, true, -0.764998, -0.179995, -0.464998},
	{"Caddy", 2, 0, 1000.0, '4', 'E', 96, true, 0.000000, 0.000000, 0.000000},
	{"Solair", 4, 4, 2000.0, 'R', 'P', 159, true, -0.959999, -0.039999, -0.594999},
	{"Berkley's RC", 4, 4, 1900.0, 'R', 'D', 137, true, -0.919999, -0.069999, -0.719999},
	{"Skimmer", 2, 2, 5000.0, '4', 'P', 135, false, -1.399996, 0.554997, -1.819998},
	{"PCJ-600", 2, 0, 500.0, 'R', 'P', 207, false, 0.000000, 0.000000, 0.000000},
	{"Faggio", 2, 0, 350.0, 'R', 'P', 190, false, 0.000000, 0.000000, 0.000000},
	{"Freeway", 2, 0, 800.0, 'R', 'P', 210, false, 0.000000, 0.000000, 0.000000},
	{"RC Baron", 1, 0, 100.0, 'F', 'P', 45, true, 0.000000, 0.000000, 0.000000},
	{"RC Raider", 1, 0, 100.0, '4', 'P', 50, true, 0.000000, 0.000000, 0.000000},
	{"Glendale", 4, 4, 1600.0, 'R', 'P', 148, true, -0.989997, -0.064998, -0.489998},
	{"Oceanic", 4, 4, 1900.0, 'R', 'P', 142, true, -0.989997, -0.044998, -0.484999},
	{"Sanchez", 2, 0, 500.0, 'R', 'P', 186, false, 0.000000, 0.000000, 0.000000},
	{"Sparrow", 2, 2, 2500.0, '4', 'P', 145, false, 0.000000, 0.000000, 0.000000},
	{"Patriot", 4, 4, 2500.0, '4', 'P', 158, true, -1.119999, -0.149995, -0.359999},
	{"Quad", 2, 0, 400.0, '4', 'P', 111, true, 0.000000, 0.000000, 0.000000},
	{"Coastguard", 1, 0, 1200.0, 'R', 'P', 125, false, 0.000000, 0.000000, 0.000000},
	{"Dinghy", 1, 0, 800.0, 'R', 'P', 107, false, 0.000000, 0.000000, 0.000000},
	{"Hermes", 2, 2, 1950.0, 'F', 'P', 150, true, -0.994997, -0.064998, -0.544999},
	{"Sabre", 2, 2, 1700.0, 'R', 'P', 175, true, -0.904999, -0.054999, -0.549996},
	{"Rustler", 1, 1, 5000.0, '4', 'P', 220, false, 0.000000, 0.000000, 0.000000},
	{"ZR-350", 2, 2, 1400.0, 'R', 'P', 188, true, -0.979999, 0.019997, -0.514998},
	{"Walton", 2, 2, 1850.0, '4', 'D', 119, true, -0.804997, 0.064998, -0.519999},
	{"Regina", 4, 4, 1500.0, 'F', 'P', 141, true, -0.854999, 0.090000, -0.454997},
	{"Comet", 2, 2, 1400.0, '4', 'P', 186, true, -0.879998, 0.000000, -0.489998},
	{"BMX", 1, 0, 100.0, 'R', 'P', 97, false, 0.000000, 0.000000, 0.000000},
	{"Burrito", 2, 4, 1900.0, 'R', 'P', 158, true, -0.989997, 0.000000, -0.759998},
	{"Camper", 3, 3, 1900.0, 'R', 'P', 124, true, -0.834999, -0.149995, -0.744997},
	{"Marquis", 1, 0, 5000.0, 'R', 'P', 64, false, 0.000000, 0.000000, 0.000000},
	{"Baggage", 1, 0, 1000.0, 'R', 'E', 100, true, -0.629998, 0.164995, -0.374998},
	{"Dozer", 1, 0, 10000.0, '4', 'D', 65, true, 0.000000, 0.000000, 0.000000},
	{"Maverick", 4, 4, 5000.0, '4', 'P', 181, false, 0.000000, 0.000000, 0.000000},
	{"News Chopper", 2, 2, 3500.0, '4', 'P', 170, false, 0.000000, 0.000000, 0.000000},
	{"Rancher", 2, 2, 2500.0, '4', 'P', 141, true, -1.019999, 0.109999, -0.679997},
	{"FBI Rancher", 4, 4, 3500.0, '4', 'P', 158, true, -1.054998, 0.125000, -0.604999},
	{"Virgo", 2, 2, 1700.0, 'R', 'P', 150, true, -0.874997, -0.009998, -0.569998},
	{"Greenwood", 4, 4, 1600.0, 'R', 'P', 142, true, -0.909999, 0.000000, -0.459998},
	{"Jetmax", 1, 0, 3000.0, 'R', 'P', 183, false, 0.000000, 0.000000, 0.000000},
	{"Hotring Racer", 2, 2, 1600.0, 'R', 'P', 217, true, -0.909999, -0.199999, -0.639998},
	{"Sandking", 2, 2, 2000.0, '4', 'P', 178, true, -1.024999, 0.184999, -0.809997},
	{"Blista Compact", 2, 2, 1000.0, 'F', 'P', 164, true, -0.854999, 0.029998, -0.469998},
	{"Police Maverick", 4, 4, 4500.0, '4', 'P', 190, false, 0.000000, 0.000000, 0.000000},
	{"Boxville", 4, 2, 5500.0, 'R', 'D', 109, true, -1.149999, 0.269998, -0.654999},
	{"Benson", 2, 2, 3500.0, 'R', 'D', 124, true, -0.969999, -1.404996, -0.199999},
	{"Mesa", 2, 2, 1300.0, '4', 'D', 142, true, -0.969999, 0.189998, -0.574998},
	{"RC Goblin", 1, 0, 100.0, '4', 'P', 30, true, 0.000000, 0.000000, 0.000000},
	{"Hotring Racer A", 2, 2, 1600.0, 'R', 'P', 217, true, -0.909999, 0.029998, -0.639998},
	{"Hotring Racer B", 2, 2, 1600.0, 'R', 'P', 217, true, -0.909999, -0.184999, -0.639998},
	{"Bloodring Banger", 2, 2, 2100.0, 'R', 'P', 175, true, -0.989997, -0.059999, -0.494998},
	{"Rancher (Lure)", 2, 2, 2500.0, '4', 'P', 141, true, -1.019999, 0.109999, -0.679997},
	{"Super GT", 2, 2, 1400.0, 'R', 'P', 181, true, -0.904999, -0.249999, -0.509998},
	{"Elegant", 4, 4, 2200.0, 'R', 'P', 167, true, -1.084998, -0.024999, -0.589999},
	{"Journey", 2, 3, 3500.0, 'R', 'D', 109, true, -1.334998, -0.424997, -0.979999},
	{"Bike", 1, 0, 100.0, 'R', 'P', 105, false, 0.000000, 0.000000, 0.000000},
	{"Mountain Bike", 1, 0, 100.0, 'R', 'P', 130, false, 0.000000, 0.000000, 0.000000},
	{"Beagle", 2, 2, 10000.0, '4', 'P', 133, false, 0.000000, 0.000000, 0.000000},
	{"Cropduster", 1, 1, 5000.0, '4', 'P', 115, false, 0.000000, 0.000000, 0.000000},
	{"Stuntplane", 1, 1, 5000.0, '4', 'P', 151, false, 0.000000, 0.000000, 0.000000},
	{"Tanker", 2, 2, 3800.0, 'R', 'D', 122, true, -0.969999, 1.669998, -1.174998},
	{"Roadtrain", 2, 2, 5000.0, 'R', 'D', 144, true, -1.454998, 0.439999, -1.854997},
	{"Nebula", 4, 4, 1400.0, 'F', 'P', 159, true, -0.989997, 0.024999, -0.584999},
	{"Majestic", 2, 2, 1400.0, 'R', 'P', 159, true, -0.959999, 0.004999, -0.554997},
	{"Buccaneer", 2, 2, 1700.0, 'R', 'P', 166, true, -1.049998, 0.109999, -0.439999},
	{"Shamal", 1, 0, 15000.0, '4', 'P', 272, false, 0.000000, 0.000000, 0.000000},
	{"Hydra", 1, 1, 9000.0, '4', 'P', 272, false, 0.000000, 0.000000, 0.000000},
	{"FCR-900", 2, 0, 500.0, 'R', 'P', 209, false, 0.000000, 0.000000, 0.000000},
	{"NRG-500", 2, 0, 400.0, 'R', 'P', 209, false, 0.000000, 0.000000, 0.000000},
	{"HPV1000", 2, 0, 500.0, 'R', 'P', 197, false, 0.000000, 0.000000, 0.000000},
	{"Cement Truck", 2, 2, 5500.0, 'R', 'D', 131, true, -0.689997, 1.489997, -1.319998},
	{"Towtruck", 2, 2, 3500.0, 'R', 'D', 162, true, -1.054998, 0.499998, -0.329997},
	{"Fortune", 2, 2, 1700.0, 'R', 'P', 159, true, -0.899999, 0.000000, -0.564997},
	{"Cadrona", 2, 2, 1200.0, 'R', 'P', 150, true, -0.944998, 0.154999, -0.419999},
	{"FBI Truck", 2, 2, 4000.0, '4', 'D', 178, true, -0.924996, 0.059999, -0.529999},
	{"Willard", 4, 4, 1800.0, 'R', 'P', 150, true, -0.934997, -0.109999, -0.429998},
	{"Forklift", 1, 0, 1000.0, 'F', 'E', 61, true, 0.000000, 0.000000, 0.000000},
	{"Tractor", 1, 0, 2000.0, 'R', 'D', 71, true, -0.144997, 0.314999, -0.444999},
	{"Combine Harvester", 1, 1, 8500.0, '4', 'D', 111, true, 0.000000, 0.000000, 0.000000},
	{"Feltzer", 2, 2, 1600.0, 'R', 'P', 169, true, -0.924996, -0.034999, -0.479999},
	{"Remington", 2, 2, 1800.0, 'R', 'P', 170, true, -0.984999, 0.164995, -0.564997},
	{"Slamvan", 2, 2, 1950.0, 'R', 'P', 160, true, -1.069998, -0.034999, -0.569998},
	{"Blade", 2, 2, 1500.0, 'R', 'P', 175, true, -0.954999, -0.019997, -0.579999},
	{"Freight", 2, 0, 5500.0, 'R', 'D', 0, false, 0.000000, 0.000000, 0.000000},
	{"Brown Streak", 2, 0, 5500.0, 'R', 'D', 0, false, 0.000000, 0.000000, 0.000000},
	{"Vortex", 1, 0, 1900.0, 'R', 'P', 101, true, -1.004999, -0.049998, -0.019997},
	{"Vincent", 4, 4, 1800.0, 'F', 'P', 150, true, -1.024999, -0.090000, -0.639998},
	{"Bullet", 2, 2, 1200.0, 'R', 'P', 205, true, -0.904999, 0.000000, -0.414999},
	{"Clover", 2, 2, 1600.0, 'R', 'P', 166, true, -0.894999, 0.014999, -0.539999},
	{"Sadler", 2, 2, 1700.0, '4', 'D', 152, true, -0.904999, 0.009998, -0.409999},
	{"Firetruck", 2, 2, 6500.0, 'R', 'D', 150, true, -1.089998, 0.000000, -0.709999},
	{"Hustler", 2, 2, 1700.0, 'R', 'P', 148, true, -0.939997, -0.029998, -0.564997},
	{"Intruder", 4, 4, 1800.0, 'R', 'P', 150, true, -1.039999, -0.100000, -0.474999},
	{"Primo", 4, 4, 1600.0, 'R', 'P', 144, true, -0.884998, 0.059999, -0.479999},
	{"Cargobob", 2, 2, 20000.0, '4', 'P', 158, false, -1.769997, 1.484997, -1.774996},
	{"Tampa", 2, 2, 1700.0, 'R', 'P', 155, true, -0.949998, 0.104997, -0.439999},
	{"Sunrise", 4, 4, 1600.0, 'F', 'P', 146, true, -1.089998, -0.059999, -0.554997},
	{"Merit", 4, 4, 1800.0, 'R', 'P', 159, true, -0.964999, 0.004999, -0.564997},
	{"Utility Van", 2, 2, 2600.0, 'R', 'D', 122, true, -1.034999, 0.749997, -0.254999},
	{"Nevada", 1, 0, 25000.0, '4', 'P', 193, false, 0.000000, 0.000000, 0.000000},
	{"Yosemite", 2, 2, 3000.0, 'R', 'P', 145, true, -1.109997, 0.009998, -0.534999},
	{"Windsor", 2, 2, 1500.0, 'R', 'P', 160, true, -0.754998, 0.000000, -0.464998},
	{"Monster A", 2, 2, 5000.0, '4', 'P', 111, true, -1.119999, 0.000000, 0.184999},
	{"Monster B", 2, 2, 5000.0, '4', 'P', 111, true, -1.129999, 0.044998, 0.074997},
	{"Uranus", 2, 2, 1400.0, 'R', 'P', 157, true, -0.894999, -0.089997, -0.374998},
	{"Jester", 2, 2, 1500.0, 'F', 'P', 179, true, -0.964999, 0.000000, -0.444999},
	{"Sultan", 4, 4, 1400.0, '4', 'P', 171, true, -1.004999, 0.054999, -0.414999},
	{"Stratum", 4, 4, 1800.0, 'R', 'P', 155, true, -0.919999, 0.129997, -0.574998},
	{"Elegy", 2, 2, 1500.0, 'R', 'P', 179, true, -0.909999, 0.119998, -0.404998},
	{"Raindance", 2, 2, 10000.0, '4', 'P', 160, false, 0.000000, 0.000000, 0.000000},
	{"RC Tiger", 1, 0, 100.0, '4', 'E', 89, true, 0.000000, 0.000000, 0.000000},
	{"Flash", 2, 2, 1400.0, 'F', 'P', 166, true, -0.824998, 0.000000, -0.414999},
	{"Tahoma", 4, 4, 1800.0, 'R', 'P', 161, true, -0.989997, -0.049998, -0.479999},
	{"Savanna", 4, 2, 1500.0, 'R', 'P', 175, true, -1.089998, 0.309998, -0.609999},
	{"Bandito", 1, 0, 1000.0, 'R', 'P', 148, true, -0.334998, 0.100000, -0.374998},
	{"Freight Trailer", 1, 0, 5500.0, 'R', 'D', 0, false, 0.000000, 0.000000, 0.000000},
	{"Brown Trailer", 1, 0, 5500.0, 'R', 'D', 0, false, 0.000000, 0.000000, 0.000000},
	{"Kart", 1, 0, 300.0, 'R', 'P', 94, true, 0.000000, 0.000000, 0.000000},
	{"Mower", 1, 0, 800.0, 'R', 'P', 61, true, 0.000000, 0.000000, 0.000000},
	{"Dune", 2, 2, 10000.0, '4', 'P', 111, true, 0.000000, 0.000000, 0.000000},
	{"Sweeper", 1, 2, 800.0, 'R', 'P', 61, true, 0.000000, 0.000000, 0.000000},
	{"Broadway", 2, 2, 1700.0, 'R', 'P', 159, true, -0.924996, 0.004999, -0.334998},
	{"Tornado", 2, 2, 1700.0, 'R', 'P', 159, true, -1.019999, -0.140000, -0.419999},
	{"AT-400", 2, 0, 60000.0, '4', 'P', 250, false, 0.000000, 0.000000, 0.000000},
	{"DFT-30", 2, 2, 5500.0, 'R', 'D', 131, true, -1.429998, -0.649999, -0.879998},
	{"Huntley", 4, 4, 2500.0, '4', 'P', 159, true, -1.014999, 0.000000, -0.484999},
	{"Stafford", 4, 4, 2200.0, 'R', 'P', 154, true, -1.089998, 0.014999, -0.474999},
	{"BF-400", 2, 0, 500.0, 'R', 'P', 200, false, 0.000000, 0.000000, 0.000000},
	{"Newsvan", 4, 3, 1900.0, 'R', 'D', 137, true, -0.984999, -0.194995, -0.709999},
	{"Tug", 1, 2, 800.0, 'R', 'P', 86, true, -0.674996, 0.259999, 0.129997},
	{"Petrol Trailer", 1, 0, 3800.0, 'R', 'D', 0, true, 0.000000, 0.000000, 0.000000},
	{"Emperor", 4, 4, 1800.0, 'R', 'P', 154, true, -1.019999, -0.009998, -0.354999},
	{"Wayfarer", 2, 0, 800.0, 'R', 'P', 211, false, 0.000000, 0.000000, 0.000000},
	{"Euros", 2, 2, 1400.0, '4', 'P', 166, true, -1.009999, -0.064998, -0.534999},
	{"Hotdog", 2, 2, 5500.0, 'R', 'D', 109, true, -1.374997, 0.000000, -0.664999},
	{"Club", 2, 2, 1400.0, 'F', 'P', 164, true, -0.909999, 0.000000, -0.359999},
	{"Freight Box Trailer", 1, 0, 5500.0, 'R', 'D', 0, false, 0.000000, 0.000000, 0.000000},
	{"Article Trailer 3", 1, 0, 3800.0, 'R', 'D', 0, true, 0.000000, 0.000000, 0.000000},
	{"Andromada", 2, 0, 40000.0, '4', 'P', 266, false, 0.000000, 0.000000, 0.000000},
	{"Dodo", 2, 2, 5000.0, '4', 'P', 135, false, 0.000000, 0.000000, 0.000000},
	{"RC Cam", 1, 0, 100.0, '4', 'E', 62, true, 0.000000, 0.000000, 0.000000},
	{"Launch", 1, 0, 2200.0, 'R', 'P', 118, false, 0.000000, 0.000000, 0.000000},
	{"Police Car (LSPD)", 4, 4, 1600.0, 'R', 'P', 177, true, -0.974999, 0.000000, -0.469998},
	{"Police Car (SFPD)", 4, 4, 1600.0, 'R', 'P', 177, true, -0.969999, 0.000000, -0.464998},
	{"Police Car (LVPD)", 4, 4, 1600.0, 'R', 'P', 177, true, -1.004999, -0.014999, -0.414999},
	{"Ranger", 2, 2, 2500.0, '4', 'D', 159, true, -1.019999, 0.115000, -0.684997},
	{"Picador", 2, 2, 1600.0, 'R', 'D', 152, true, -0.959999, 0.204998, -0.499998},
	{"S.W.A.T.", 2, 0, 5000.0, '4', 'D', 111, true, 0.000000, 0.000000, 0.000000},
	{"Alpha", 2, 2, 1500.0, 'R', 'P', 171, true, -1.024999, 0.000000, -0.549996},
	{"Phoenix", 2, 2, 1500.0, 'R', 'P', 173, true, -0.954999, 0.034999, -0.629998},
	{"Glendale", 4, 4, 1600.0, 'R', 'P', 148, true, -0.989997, -0.064998, -0.489998},
	{"Sadler (destroyed)", 2, 2, 1700.0, '4', 'D', 152, true, -0.904999, 0.009998, -0.409999},
	{"Baggage Trailer A", 1, 0, 1000.0, 'R', 'E', 0, true, 0.000000, 0.000000, 0.000000},
	{"Baggage Trailer B", 1, 0, 1000.0, 'R', 'E', 0, true, 0.000000, 0.000000, 0.000000},
	{"Tug Stairs Trailer", 1, 0, 1000.0, 'R', 'E', 0, true, 0.000000, 0.000000, 0.000000},
	{"Boxville (burglary)", 4, 2, 5500.0, 'R', 'D', 109, true, -1.149999, 0.269998, -0.654999},
	{"Farm Trailer", 1, 0, 400.0, 'R', 'E', 0, true, 0.000000, 0.000000, 0.000000},
	{"Utility Trailer", 1, 0, 1000.0, 'R', 'E', 0, true, 0.000000, 0.000000, 0.000000}
};

/*static Float:PaynSprayPos[10][3] = {
    {1025.05, -1024.23, 32.1}, 	// LS Temple
    {487.68, -1740.87, 11.13}, 	// LS Santa Maria
    {-1420.73, 2583.37, 55.56}, // El Quebrados
    {-1904.39, 284.97, 40.75}, 	// Wang Cars
    {-2425.91, 1022.33, 50.10}, // Juniper Hill
    {1975.60, 2162.16, 10.77}, 	// LV Redsands
    {2065.38, -1831.51, 13.25}, // Idlewood
    {-99.55, 1118.36, 19.44}, 	// Fort Carson
    {721.07, -455.94, 16.04}, 	// Dillimore
    {2393.74, 1493.01, 10.52} 	// LV Unused (Pyramid)
};*/

stock Float:GetVehicleMass(modelid)
{
	if(400 <= modelid <= 611)
	{
		return vSync_VehicleInfo[modelid - 400][Mass];
	}
	return 0.0;
}

stock GetVehicleName(vehicleid, name[], len = sizeof(name))
{
	new modelid = GetVehicleModel(vehicleid);

	if(400 <= modelid <= 611)
	{
		strcpy(name, vSync_VehicleInfo[modelid - 400][Name], len);
	}
	return strlen(name);
}

stock GetVehicleNumberPlate(vehicleid, dest[], len = sizeof(dest))
{
	if(1 <= vehicleid <= MAX_VEHICLES)
	{
		strcpy(dest, vSync_gVehicleInternal[vehicleid - 1][vSync_NumberP], len);
	}
	return strlen(dest);
}

stock GetVehicleSeats(modelid)
{
	if(400 <= modelid <= 611)
	{
		return vSync_VehicleInfo[modelid - 400][Seats];
	}
	return -1;
}

stock GetVehicleWindows(modelid)
{
	if(400 <= modelid <= 611)
	{
		return vSync_VehicleInfo[modelid - 400][Windows];
	}
	return 0;
}

stock GetVehicleMaxSpeed(modelid)
{
	if(400 <= modelid <= 611)
	{
		return vSync_VehicleInfo[modelid - 400][MaxSpeed]*110/100;
	}
	return 0;
}

stock GetVehicleEngineType(modelid)
{
	if(400 <= modelid <= 611)
	{
		if(modelid == 481 || modelid == 509 || modelid == 510) // Bikes
		{
			return 'H'; // Human-powered vehicle
		}
		else
		{
			return vSync_VehicleInfo[modelid - 400][EngineType];
		}
	}
	return 0;
}

stock GetVehicleFuelType(modelid)
{
new string[15];
format(string, 15, "%c", GetVehicleEngineType(modelid));
  if(strcmp(string, "P")==0)
  {
    new fuel[15] = "Petrol";
    return fuel;
  }
  else if(strcmp(string, "D")==0)
  {
    new fuel[15] = "Diesel";
    return fuel;
  }
  new fuel[15] = "Nothing";
  return fuel;
}

stock GetVehicleDriveType(modelid)
{
	if(400 <= modelid <= 611)
	{
		if(modelid == 481 || modelid == 509 || modelid == 510) // Bikes
		{
			return 'H'; // Human-powered vehicle
		}
		else
		{
			return vSync_VehicleInfo[modelid - 400][DriveType];
		}
	}
	return 0;
}

stock GetVehicleDrivetrainType(modelid)
{
new string[20];
format(string, 15, "%c", GetVehicleDriveType(modelid));
  if(strcmp(string, "F")==0)
  {
    new fuel[20] = "Front wheel drive";
    return fuel;
  }
  else if(strcmp(string, "R")==0)
  {
    new fuel[20] = "Rear wheel drive";
    return fuel;
  }
  else
  {
    new fuel[20] = "4 wheel drive";
    return fuel;
  }
}

stock VehicleSupportsNeonLights(modelid)
{
    new idx = modelid - 400;

	if(0 <= idx <= 211)
	{
        if(vSync_VehicleInfo[idx][NeonOffsetX] == 0.0 && vSync_VehicleInfo[idx][NeonOffsetY] == 0.0 && vSync_VehicleInfo[idx][NeonOffsetZ] == 0.0)
		{
	    	return 0;
		}
		return 1;
	}
	return 0;
}

stock SetVehicleNeonLights(vehicleid, bool:enable = true, color)
{
	new idx = GetVehicleModel(vehicleid) - 400;

	if(0 <= idx <= 211)
	{
		for(new x = 0; x < 2; x++)
		{
			#if defined _streamer_included
				if(IsValidDynamicObject(vSync_gVehicleInternal[vehicleid - 1][vSync_Neon][x]))
				{
				    DestroyDynamicObject(vSync_gVehicleInternal[vehicleid - 1][vSync_Neon][x]);
				}
			#else
				if(IsValidObject(vSync_gVehicleInternal[vehicleid - 1][vSync_Neon][x]))
				{
					DestroyObject(vSync_gVehicleInternal[vehicleid - 1][vSync_Neon][x]);
				}
			#endif
		}

		if((NEON_LIGHT_RED <= color <= NEON_LIGHT_WHITE) && enable)
		{
			#if defined _streamer_included
				vSync_gVehicleInternal[vehicleid - 1][vSync_Neon][0] = CreateDynamicObject(color, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
				vSync_gVehicleInternal[vehicleid - 1][vSync_Neon][1] = CreateDynamicObject(color, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);

				AttachDynamicObjectToVehicle(vSync_gVehicleInternal[vehicleid - 1][vSync_Neon][0], vehicleid, vSync_VehicleInfo[idx][NeonOffsetX], vSync_VehicleInfo[idx][NeonOffsetY], vSync_VehicleInfo[idx][NeonOffsetZ], 0.0, 0.0, 0.0);
				AttachDynamicObjectToVehicle(vSync_gVehicleInternal[vehicleid - 1][vSync_Neon][1], vehicleid, -vSync_VehicleInfo[idx][NeonOffsetX], vSync_VehicleInfo[idx][NeonOffsetY], vSync_VehicleInfo[idx][NeonOffsetZ], 0.0, 0.0, 0.0);
			#else
				vSync_gVehicleInternal[vehicleid - 1][vSync_Neon][0] = CreateObject(color, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
				vSync_gVehicleInternal[vehicleid - 1][vSync_Neon][1] = CreateObject(color, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);

				AttachObjectToVehicle(vSync_gVehicleInternal[vehicleid - 1][vSync_Neon][0], vehicleid, vSync_VehicleInfo[idx][NeonOffsetX], vSync_VehicleInfo[idx][NeonOffsetY], vSync_VehicleInfo[idx][NeonOffsetZ], 0.0, 0.0, 0.0);
				AttachObjectToVehicle(vSync_gVehicleInternal[vehicleid - 1][vSync_Neon][1], vehicleid, -vSync_VehicleInfo[idx][NeonOffsetX], vSync_VehicleInfo[idx][NeonOffsetY], vSync_VehicleInfo[idx][NeonOffsetZ], 0.0, 0.0, 0.0);
			#endif
		}
		return 1;
	}
	return 0;
}

stock GetVehicleNeonLightsState(vehicleid)
{
	if(1 <= vehicleid <= MAX_VEHICLES)
 	{
		#if defined _streamer_included
			if(IsValidDynamicObject(vSync_gVehicleInternal[vehicleid - 1][vSync_Neon][0]) && IsValidDynamicObject(vSync_gVehicleInternal[vehicleid - 1][vSync_Neon][1]))
			{
				return 1;
			}
		#else
			if(IsValidObject(vSync_gVehicleInternal[vehicleid - 1][vSync_Neon][0]) && IsValidObject(vSync_gVehicleInternal[vehicleid - 1][vSync_Neon][1]))
			{
				return 1;
			}
		#endif
	}
	return 0;
}





enum string_edges {
	edge_left  = 1,
	edge_right = 2,
	edge_both = edge_left | edge_right
};

stock strcpy(dest[], const source[], len = sizeof(dest))
{
	dest[0] = '\0';
	return strcat(dest, source, len);
}

stock strtrim(string[], const chars[] = !"", string_edges:edge = edge_both) {
	new bool:packed = ispacked(string);
	if (!strgetfirstc(chars)) {
		if (edge & edge_left) {
			new i = 0;
			if (packed)
				while (0 < string{i} <= ' ') i++;
			else
				while (0 < string[i] <= ' ') i++;
			if (i) {
				strdel(string, 0, i);			}
		}
		if (edge & edge_right) {
			new i = strlen(string);
			if (i) {
				if (packed) {
					while (--i && 0 < string{i} <= ' ') {}

					string{i + 1} = '\0';
				} else {
					while (--i && 0 < string[i] <= ' ') {}

					string[i + 1] = '\0';
				}
			}
		}
	} else {
		if (edge & edge_left) {
			new i = 0, sub[2];

			if (packed) {
				while ((sub[0] = string{i})) {
					if (strfind(chars, sub) == -1)
						break;
					i++;
				}
				if (i) {
					strdel(string, 0, i);
				}
			} else {
				while ((sub[0] = string[i])) {
					if (strfind(chars, sub) == -1)
						break;
					i++;
				}
				if (i) strdel(string, 0, i);
			}
		}
		if (edge & edge_right) {
			new i = strlen(string), sub[2];
			if (i >= 0) {
				if (packed) {
					while (i--) {
						sub[0] = string{i};

						if (strfind(chars, sub) == -1)
							break;
					}
					string{i + 1} = '\0';
				} else {
					while (i--) {
						sub[0] = string[i];

						if (strfind(chars, sub) == -1)
							break;
					}
					string[i + 1] = '\0';
				}
			}
		}
	}
}

stock strgetfirstc(const string[]) {
	return ispacked(string) ? string{0} : string[0];
}









stock IsPlayerInLosSantos(playerid) {
    if(IsPlayerInZone(playerid, "Fallen Tree")) return 1;
	else if(IsPlayerInZone(playerid, "Beacon Hill")) return 1;
	else if(IsPlayerInZone(playerid, "Flint Intersection")) return 1;
	else if(IsPlayerInZone(playerid, "Flint Range")) return 1;
    else if(IsPlayerInZone(playerid, "Market")) return 1;
	else if(IsPlayerInZone(playerid, "Jefferson")) return 1;
	else if(IsPlayerInZone(playerid, "Santa Maria Beach")) return 1;
	else if(IsPlayerInZone(playerid, "Rodeo")) return 1;
	else if(IsPlayerInZone(playerid, "Richman")) return 1;
	else if(IsPlayerInZone(playerid, "Dillimore")) return 1;
	else if(IsPlayerInZone(playerid, "Verona Beach")) return 1;
	else if(IsPlayerInZone(playerid, "Marina")) return 1;
	else if(IsPlayerInZone(playerid, "Vinewood")) return 1;
	else if(IsPlayerInZone(playerid, "Verdant Bluffs")) return 1;
	else if(IsPlayerInZone(playerid, "Conference Center")) return 1;
	else if(IsPlayerInZone(playerid, "Temple")) return 1;
	else if(IsPlayerInZone(playerid, "Mulholland")) return 1;
	else if(IsPlayerInZone(playerid, "Los Santos International")) return 1;
	else if(IsPlayerInZone(playerid, "City Hall")) return 1;
	else if(IsPlayerInZone(playerid, "Pershing Square")) return 1;
	else if(IsPlayerInZone(playerid, "Commerce")) return 1;
	else if(IsPlayerInZone(playerid, "Downtown Los Santos")) return 1;
	else if(IsPlayerInZone(playerid, "Montgomery Intersection")) return 1;
	else if(IsPlayerInZone(playerid, "El Corona")) return 1;
	else if(IsPlayerInZone(playerid, "Little Mexico")) return 1;
	else if(IsPlayerInZone(playerid, "Idlewood")) return 1;
	else if(IsPlayerInZone(playerid, "Glen Park")) return 1;
	else if(IsPlayerInZone(playerid, "Ocean Docks")) return 1;
	else if(IsPlayerInZone(playerid, "Willowfield")) return 1;
	else if(IsPlayerInZone(playerid, "Ganton")) return 1;
	else if(IsPlayerInZone(playerid, "East Los Santos")) return 1;
	else if(IsPlayerInZone(playerid, "Las Colinas")) return 1;
	else if(IsPlayerInZone(playerid, "Playa del Seville")) return 1;
	else if(IsPlayerInZone(playerid, "East Beach")) return 1;
	else if(IsPlayerInZone(playerid, "Los Flores")) return 1;
	else if(IsPlayerInZone(playerid, "North Rock")) return 1;
	else if(IsPlayerInZone(playerid, "Los Santos")) return 1;
	return 0;
}
stock IsPlayerInLasVenturas(playerid) {
    if(IsPlayerInZone(playerid, "Greenglass College")) return 1;
	else if(IsPlayerInZone(playerid, "Blackfield")) return 1;
	else if(IsPlayerInZone(playerid, "Whitewood Estates")) return 1;
	else if(IsPlayerInZone(playerid, "Blackfield Intersection")) return 1;
	else if(IsPlayerInZone(playerid, "Pilson Intersection")) return 1;
	else if(IsPlayerInZone(playerid, "Yellow Bell Station")) return 1;
	else if(IsPlayerInZone(playerid, "Blackfield Chapel")) return 1;
	else if(IsPlayerInZone(playerid, "Randolph Industrial Estate")) return 1;
	else if(IsPlayerInZone(playerid, "LVA Freight Depot")) return 1;
	else if(IsPlayerInZone(playerid, "Las Venturas Airport")) return 1;
	else if(IsPlayerInZone(playerid, "Redsands West")) return 1;
	else if(IsPlayerInZone(playerid, "Prickle Pine")) return 1;
	else if(IsPlayerInZone(playerid, "Harry Gold Parkway")) return 1;
	else if(IsPlayerInZone(playerid, "Last Dime Motel")) return 1;
	else if(IsPlayerInZone(playerid, "Julius Thruway South")) return 1;
	else if(IsPlayerInZone(playerid, "The Four Dragons Casino")) return 1;
	else if(IsPlayerInZone(playerid, "The Pink Swan")) return 1;
	else if(IsPlayerInZone(playerid, "The Strip")) return 1;
	else if(IsPlayerInZone(playerid, "The High Roller")) return 1;
	else if(IsPlayerInZone(playerid, "Pirates in Men's Pants")) return 1;
	else if(IsPlayerInZone(playerid, "The Visage")) return 1;
	else if(IsPlayerInZone(playerid, "Redsands East")) return 1;
	else if(IsPlayerInZone(playerid, "The Emerald Isle")) return 1;
	else if(IsPlayerInZone(playerid, "Rockshore West")) return 1;
	else if(IsPlayerInZone(playerid, "Come-A-Lot")) return 1;
	else if(IsPlayerInZone(playerid, "The Camel's Toe")) return 1;
	else if(IsPlayerInZone(playerid, "Royal Casino")) return 1;
	else if(IsPlayerInZone(playerid, "Caligula's Palace")) return 1;
	else if(IsPlayerInZone(playerid, "Pilgrim")) return 1;
	else if(IsPlayerInZone(playerid, "Old Venturas Strip")) return 1;
	else if(IsPlayerInZone(playerid, "Roca Escalante")) return 1;
	else if(IsPlayerInZone(playerid, "Julius Thruway North")) return 1;
	else if(IsPlayerInZone(playerid, "Spinybed")) return 1;
	else if(IsPlayerInZone(playerid, "K.A.C.C. Military Fuels")) return 1;
	else if(IsPlayerInZone(playerid, "Rockshore East")) return 1;
	else if(IsPlayerInZone(playerid, "Linden Side")) return 1;
	else if(IsPlayerInZone(playerid, "Linden Station")) return 1;
	else if(IsPlayerInZone(playerid, "Julius Thruway East")) return 1;
	else if(IsPlayerInZone(playerid, "Sobell Rail Yards")) return 1;
	else if(IsPlayerInZone(playerid, "Creek")) return 1;
	else if(IsPlayerInZone(playerid, "Las Venturas")) return 1;
	return 0;
}
stock IsPlayerInSanFierro(playerid) {
    if(IsPlayerInZone(playerid, "Downtown")) return 1;
	else if(IsPlayerInZone(playerid, "Avispa Country Club")) return 1;
	else if(IsPlayerInZone(playerid, "Missionary Hill")) return 1;
	else if(IsPlayerInZone(playerid, "Easter Bay Airport")) return 1;
	else if(IsPlayerInZone(playerid, "Ocean Flats")) return 1;
	else if(IsPlayerInZone(playerid, "Hashbury")) return 1;
	else if(IsPlayerInZone(playerid, "Doherty")) return 1;
	else if(IsPlayerInZone(playerid, "Garcia")) return 1;
	else if(IsPlayerInZone(playerid, "City Hall")) return 1;
	else if(IsPlayerInZone(playerid, "Queens")) return 1;
	else if(IsPlayerInZone(playerid, "King's")) return 1;
	else if(IsPlayerInZone(playerid, "Easter Basin")) return 1;
	else if(IsPlayerInZone(playerid, "Santa Flora")) return 1;
	else if(IsPlayerInZone(playerid, "Chinatown")) return 1;
	else if(IsPlayerInZone(playerid, "Palisades")) return 1;
	else if(IsPlayerInZone(playerid, "Juniper Hill")) return 1;
	else if(IsPlayerInZone(playerid, "Kincaid Bridge")) return 1;
	else if(IsPlayerInZone(playerid, "Foster Valley")) return 1;
	else if(IsPlayerInZone(playerid, "Financial")) return 1;
	else if(IsPlayerInZone(playerid, "Paradiso")) return 1;
	else if(IsPlayerInZone(playerid, "Calton Heights")) return 1;
	else if(IsPlayerInZone(playerid, "Garver Bridge")) return 1;
	else if(IsPlayerInZone(playerid, "Juniper Hollow")) return 1;
	else if(IsPlayerInZone(playerid, "Battery Point")) return 1;
	else if(IsPlayerInZone(playerid, "Esplanade North")) return 1;
	else if(IsPlayerInZone(playerid, "Esplanade East")) return 1;
	else if(IsPlayerInZone(playerid, "Easter Bay Chemicals")) return 1;
	else if(IsPlayerInZone(playerid, "San Fierro")) return 1;
	return 0;
}
stock IsPlayerInWhetstone(playerid) {
    if(IsPlayerInZone(playerid, "Whetstone")) return 1;
	else if(IsPlayerInZone(playerid, "Angel Pine")) return 1;
	else if(IsPlayerInZone(playerid, "Shady Creeks")) return 1;
	else if(IsPlayerInZone(playerid, "Shady Cabin")) return 1;
	return 0;
}
stock IsPlayerInFlintCounty(playerid) {
    if(IsPlayerInZone(playerid, "The Farm")) return 1;
	else if(IsPlayerInZone(playerid, "Leafy Hollow")) return 1;
	else if(IsPlayerInZone(playerid, "Back o Beyond")) return 1;
	else if(IsPlayerInZone(playerid, "Flint County")) return 1;
	return 0;
}
stock IsPlayerInRedCounty(playerid) {
    if(IsPlayerInZone(playerid, "The Panopticon")) return 1;
	else if(IsPlayerInZone(playerid, "Blueberry Acres")) return 1;
	else if(IsPlayerInZone(playerid, "Blueberry")) return 1;
	else if(IsPlayerInZone(playerid, "Hilltop Farm")) return 1;
	else if(IsPlayerInZone(playerid, "Fern Ridge")) return 1;
	else if(IsPlayerInZone(playerid, "Hampton Barns")) return 1;
	else if(IsPlayerInZone(playerid, "Martin Bridge")) return 1;
	else if(IsPlayerInZone(playerid, "Fallow Bridge")) return 1;
	else if(IsPlayerInZone(playerid, "Montgomery")) return 1;
	else if(IsPlayerInZone(playerid, "Montgomery Intersection")) return 1;
	else if(IsPlayerInZone(playerid, "The Mako Span")) return 1;
	else if(IsPlayerInZone(playerid, "Palomino Creek")) return 1;
	else if(IsPlayerInZone(playerid, "Hankypanky Point")) return 1;
	else if(IsPlayerInZone(playerid, "Frederick Bridge")) return 1;
	else if(IsPlayerInZone(playerid, "Red County")) return 1;
	return 0;
}
stock IsPlayerInTierraRobada(playerid) {
    if(IsPlayerInZone(playerid, "Gant Bridge")) return 1;
	else if(IsPlayerInZone(playerid, "Bayside")) return 1;
	else if(IsPlayerInZone(playerid, "Bayside Marina")) return 1;
	else if(IsPlayerInZone(playerid, "El Quebrados")) return 1;
	else if(IsPlayerInZone(playerid, "Aldea Malvada")) return 1;
	else if(IsPlayerInZone(playerid, "The Sherman Dam")) return 1;
	else if(IsPlayerInZone(playerid, "Las Barrancas")) return 1;
	else if(IsPlayerInZone(playerid, "Arco del Oeste")) return 1;
	else if(IsPlayerInZone(playerid, "Valle Ocultado")) return 1;
	else if(IsPlayerInZone(playerid, "Tierra Robada")) return 1;
	return 0;
}
stock IsPlayerInBoneCounty(playerid) {
    if(IsPlayerInZone(playerid, "Fort Carson")) return 1;
	else if(IsPlayerInZone(playerid, "Lil' Probe Inn")) return 1;
	else if(IsPlayerInZone(playerid, "Regular Tom")) return 1;
	else if(IsPlayerInZone(playerid, "Las Brujas")) return 1;
	else if(IsPlayerInZone(playerid, "El Castillo del Diablo")) return 1;
	else if(IsPlayerInZone(playerid, "Las Payasadas")) return 1;
	else if(IsPlayerInZone(playerid, "Hunter Quarry")) return 1;
	else if(IsPlayerInZone(playerid, "Green Palms")) return 1;
	else if(IsPlayerInZone(playerid, "Octane Springs")) return 1;
	else if(IsPlayerInZone(playerid, "Verdant Meadows")) return 1;
	else if(IsPlayerInZone(playerid, "Bone County")) return 1;
	SetWeather(2);
	return 0;
}

enum mbinfo
{
        Float:XPOS,
        Float:YPOS,
        Float:ZPOS,
        Position[50]
};

stock nervnichtmbspawn()
{
new size = MBSPAWN*5;
return size;
}

new Float:MBSPAWN[][mbinfo] =
{
  // Positions, (X, Y, Z, Location)
    {713.073852, 912.842224, -19.096578, "The Quarry"},
    {688.145507, 844.974914, -28.631895, "The Quarry"},
    {586.370788, 913.020202, -34.194843, "The Quarry"},
    {503.419708, 970.914550, -24.997589, "The Quarry"},
    {499.296356, 971.732788, -25.047336, "The Quarry"},
    {458.502136, 891.120666, -27.374114, "The Quarry"},
    {628.248901, 735.500732, -0.903092, "The Quarry"},
    {627.924438, 1046.961303, 25.122577, "The Quarry"},
    {792.460510, 915.044189, 20.112213, "The Quarry"},
    {320.508636, 848.626281, 19.967500, "The Quarry"},
    {361.191741, 829.137329, 21.289638, "The Quarry"},
    {462.726348, 973.174621, 5.403401, "The Quarry"},
    {484.878112, 962.291137, 5.981633, "The Quarry"},
    {591.441650, 706.663513, 9.760972, "The Quarry"},
    {770.800415, 746.815368, 27.704566, "The Quarry"},
    {434.217102, 898.344543, 2.117520, "The Quarry"},
    {488.367218, 810.184814, 1.804343, "The Quarry"},
    {528.185913, 816.695800, -11.858360, "The Quarry"},
    {568.221130, 824.427429, -22.127143, "The Quarry"},
    {575.399353, 872.569091, -35.329307, "The Quarry"},
    {623.156188, 892.809875, -41.102825, "The Quarry"},
    {418.428070, 1409.390625, 8.565642, "The Petroleum"},
    {475.849548, 1325.585083, 11.321235, "The Petroleum"},
    {541.844848, 1556.681152, 0.482253, "The Petroleum"},
    {597.308898, 1535.999389, 3.586513, "The Petroleum"},
    {669.860534, 1422.952880, 10.887602, "The Petroleum"},
    {559.382812, 1371.361328, 16.322978, "The Petroleum"},
    {438.514587, 1268.192016, 9.017544, "The Petroleum"},
    {585.843322, 1485.281738, 12.073791, "The Petroleum"},
    {229.331573, 1478.390502, 10.151371, "Green Palms"},
    {152.056015, 1447.338256, 10.156622, "Green Palms"},
        {133.937881, 1377.117065, 10.158605, "Green Palms"},
        {205.768768, 1352.408081, 10.151306, "Green Palms"},
    {210.495468, 1395.340332, 10.151283, "Green Palms"},
        {215.108322, 1467.936157, 14.921875, "Green Palms"},
        {215.115737, 1467.059326, 23.734375, "Green Palms"},
    {187.969940, 1371.305786, 23.734375, "Green Palms"},
        {246.766662, 1360.596679, 10.707500, "Green Palms"},
        {246.478836, 1362.749633, 23.370285, "Green Palms"},
    {222.136520, 1424.068847, 10.585937, "Green Palms"},
        {-41.510822, 1178.722290, 18.961349, "Fort Carson"},
        {2.213922, 1119.721435, 19.450517, "Fort Carson"},
        {17.874195, 1076.159057, 19.804994, "Fort Carson"},
        {-95.816307, 1164.927001, 19.312730, "Fort Carson"},
        {-100.357772, 1127.539672, 19.323959, "Fort Carson"},
        {-117.773254, 1132.638061, 19.326152, "Fort Carson"},
        {-190.864791, 1218.766357, 19.306653, "Fort Carson"},
        {-218.729446, 1147.502807, 19.328531, "Fort Carson"},
        {-378.680541, 1103.303466, 19.314443, "Fort Carson"},
        {-312.767395, 1175.458740, 19.307266, "Fort Carson"},
        {-209.111099, 1216.520629, 23.436161, "Fort Carson"},
        {-170.258102, 1176.971801, 24.155366, "Fort Carson"},
        {-172.726379, 1182.572753, 26.504249, "Fort Carson"},
        {-824.523559, 1444.919677, 13.547593, "Las Barrancas"},
        {-811.227539, 1479.601074, 26.136028, "Las Barrancas"},
        {-778.594482, 1477.787719, 28.764667, "Las Barrancas"},
        {-801.825866, 1513.152099, 21.131435, "Las Barrancas"},
        {-730.415039, 1539.924682, 40.065593, "Las Barrancas"},
        {-733.456970, 1553.795654, 39.189163, "Las Barrancas"},
        {-737.410278, 1593.716186, 26.656929, "Las Barrancas"},
        {-774.510375, 1616.915771, 26.687776, "Las Barrancas"},
        {-835.524841, 1597.141967, 26.505504, "Las Barrancas"},
        {-888.960021, 1553.529907, 25.501276, "Las Barrancas"},
        {-862.112548, 1536.867919, 25.737701, "Las Barrancas"},
        {-856.268554, 1528.398559, 25.737701, "Las Barrancas"},
        {-303.303192, 2744.042236, 61.440700, "Las Payasadas"},
        {-210.072189, 2814.655273, 64.240028, "Las Payasadas"},
        {-164.061630, 2767.596435, 62.252616, "Las Payasadas"},
        {-166.319808, 2730.175537, 65.696540, "Las Payasadas"},
        {-213.414306, 2719.982177, 62.687500, "Las Payasadas"},
        {-287.109222, 2687.127441, 65.852340, "Las Payasadas"},
        {-268.482818, 2667.310546, 62.670055, "Las Payasadas"},
        {-282.033843, 2651.087402, 67.323928, "Las Payasadas"},
        {-307.318756, 2652.917236, 68.252456, "Las Payasadas"},
        {-237.491958, 2663.685546, 63.858531, "Las Payasadas"},
        {-153.610809, 2711.833984, 62.144855, "Las Payasadas"},
        {-235.506256, 2826.033935, 61.760990, "Las Payasadas"},
        {123.295402, 2427.276123, 16.638261, "Verdant Meadows"},
        {152.007369, 2417.473388, 19.140531, "Verdant Meadows"},
        {209.578689, 2415.689697, 16.322700, "Verdant Meadows"},
        {237.976455, 2432.690185, 16.626625, "Verdant Meadows"},
        {276.434844, 2430.887695, 16.041940, "Verdant Meadows"},
        {313.228027, 2415.748046, 19.511663, "Verdant Meadows"},
        {349.762481, 2451.393310, 20.452396, "Verdant Meadows"},
        {412.917022, 2432.326904, 16.054676, "Verdant Meadows"},
        {435.414642, 2561.705078, 16.089130, "Verdant Meadows"},
        {414.310363, 2533.625732, 19.148437, "Verdant Meadows"},
        {401.180969, 2544.245849, 19.631122, "Verdant Meadows"},
        {390.938781, 2607.264160, 16.049514, "Verdant Meadows"},
        {334.645782, 2677.588867, 15.882289, "Verdant Meadows"},
        {306.708404, 2629.444335, 16.256523, "Verdant Meadows"},
        {271.063079, 2611.989257, 16.041421, "Verdant Meadows"},
        {172.383773, 2606.412597, 16.116966, "Verdant Meadows"},
        {154.106018, 2630.396240, 16.041749, "Verdant Meadows"},
        {115.394462, 2631.614501, 15.986257, "Verdant Meadows"},
        {104.371681, 2582.203613, 16.044742, "Verdant Meadows"},
        {14.670138, 2560.055419, 15.932084, "Verdant Meadows"},
        {9.903661, 2435.500732, 16.019382, "Verdant Meadows"},
        {-2452.078125, 2438.356933, 14.555831, "Bayside"},
        {-2417.809570, 2456.555908, 25.779113, "Bayside"},
        {-2406.699462, 2469.222656, 12.183320, "Bayside"},
        {-2415.591552, 2386.210205, 7.998282, "Bayside"},
        {-2386.701904, 2398.892578, 8.845354, "Bayside"},
        {-2407.274902, 2477.111816, 11.345425, "Bayside"},
        {-2403.085449, 2553.951904, 23.601562, "Bayside"},
        {-2286.216552, 2572.171142, 23.416145, "Bayside"},
        {-2262.795410, 2573.447753, 8.214822, "Bayside"},
        {-2675.145996, 2322.950927, 25.147560, "Bayside"},
        {-2336.536376, 2480.192138, 1.275272, "Bayside"},
        {-2625.399658, 2245.826171, 6.694106, "Bayside"},
        {-2634.328125, 2240.306152, 14.622048, "Bayside"},
        {-2627.168457, 2234.247070, 12.825107, "Bayside"},
        {-2629.958984, 2243.830566, 12.611998, "Bayside"},
        {-2624.168212, 2245.396972, 6.268455, "Bayside"},
        {-2551.672851, 2432.413330, 18.866594, "Bayside"},
        {-2293.487060, 2225.002685, 4.982191, "Bayside"},
        {-2578.585693, 2520.823730, 21.721471, "Bayside"},
        {-2497.177978, 2455.601562, 17.332534, "Bayside"},
        {-2299.505859, 2277.234619, 4.978750, "Bayside"},
        {-2353.547119, 2430.278320, 7.510148, "Bayside"},
        {1316.041870, 275.046447, 31.049236, "Montgomery"},
        {1304.498779, 150.734161, 23.841037, "Montgomery"},
        {1424.074584, 234.264190, 19.554687, "Montgomery"},
        {1397.934692, 289.888427, 23.555511, "Montgomery"},
        {1377.866699, 317.458984, 19.554687, "Montgomery"},
        {1236.187255, 304.846252, 24.757812, "Montgomery"},
        {1239.561157, 288.248535, 25.755512, "Montgomery"},
        {1264.523315, 269.752105, 22.237289, "Montgomery"},
        {1283.437011, 264.630554, 23.762454, "Montgomery"},
        {1352.665161, 199.973419, 19.554687, "Montgomery"},
        {1363.234741, 195.539321, 23.227035, "Montgomery"},
        {1417.051757, 260.263885, 24.656915, "Montgomery"},
        {1414.501342, 363.570312, 19.164152, "Montgomery"},
        {1397.685424, 357.668762, 19.415740, "Montgomery"},
        {1374.767822, 366.475738, 21.055135, "Montgomery"},
        {1291.057983, 392.483947, 19.531446, "Montgomery"},
        {1282.783935, 385.586151, 27.555513, "Montgomery"},
        {1238.631103, 370.964813, 27.555509, "Montgomery"},
        {1183.289062, 230.991256, 19.561769, "Montgomery"},
        {1224.791137, 246.335128, 23.282218, "Montgomery"},
        {1270.518188, 240.601501, 31.107307, "Montgomery"},
        {1266.207519, 234.240051, 25.048685, "Montgomery"},
        {1290.146484, 300.298248, 28.560659, "Montgomery"},
        {198.153564, -189.123001, 7.578125, "Blueberry"},
        {244.182067, -312.091217, 1.578125, "Blueberry"},
        {377.058685, -126.040382, 1.282783, "Blueberry"},
        {331.945190, -21.335258, 8.999382, "Blueberry"},
        {270.666198, 25.962350, 7.423792, "Blueberry"},
        {269.469726, -39.207118, 2.076274, "Blueberry"},
        {249.126205, -55.748535, 2.778613, "Blueberry"},
        {200.529525, -2.403444, 1.585840, "Blueberry"},
        {151.374862, -112.419876, 8.206827, "Blueberry"},
        {186.791824, -97.364349, 4.896471, "Blueberry"},
        {294.001983, -195.634521, 7.138307, "Blueberry"},
        {79.888191, -172.170288, 3.240008, "Blueberry"},
        {90.263679, -196.305435, 1.484375, "Blueberry"},
        {307.548217, -256.133117, 1.583575, "Blueberry"},
        {130.356811, -65.668479, 1.578125, "Blueberry"},
        {201.947799, -107.787826, 1.552092, "Blueberry"},
        {251.443710, -59.984920, 5.882812, "Blueberry"},
        {338.868713, 39.111991, 6.514575, "Blueberry"},
        {233.187500, 88.724472, 3.707660, "Blueberry"},
        {271.035064, -325.480102, 4.109173, "Blueberry"},
        {258.287322, -91.798759, 6.548583, "Blueberry"},
        {660.309570, -515.073425, 22.836296, "Dillimore"},
        {681.892456, -471.186981, 24.570465, "Dillimore"},
        {720.187500, -460.116394, 23.195312, "Dillimore"},
        {766.745727, -565.935180, 18.013334, "Dillimore"},
        {766.601135, -565.742553, 18.013334, "Dillimore"},
        {795.740600, -498.457305, 18.013332, "Dillimore"},
        {830.493530, -483.307739, 17.335937, "Dillimore"},
        {822.035034, -539.921508, 23.336297, "Dillimore"},
        {806.729309, -644.110595, 16.335937, "Dillimore"},
        {837.977600, -618.451599, 16.427936, "Dillimore"},
        {872.614746, -589.113098, 17.975578, "Dillimore"},
        {618.945983, -495.678375, 17.036308, "Dillimore"},
        {613.239624, -511.376983, 20.336296, "Dillimore"},
        {668.560424, -565.262573, 20.646862, "Dillimore"},
        {655.586303, -565.002868, 22.147821, "Dillimore"},
        {663.681518, -552.116699, 16.335937, "Dillimore"},
        {666.731262, -624.085144, 16.335937, "Dillimore"},
        {659.283569, -649.963623, 16.335937, "Dillimore"},
        {714.395568, -638.833496, 15.661087, "Dillimore"},
        {706.086425, -513.023925, 19.836296, "Dillimore"},
        {697.977600, -502.530029, 20.336296, "Dillimore"},
        {2252.387695, -71.207305, 31.594974, "Palimino Creek"},
        {2256.675292, -51.222541, 33.039546, "Palimino Creek"},
        {2280.761474, -43.499469, 33.915302, "Palimino Creek"},
        {2331.433349, -16.148464, 29.984375, "Palimino Creek"},
        {2307.091796, 42.845218, 26.484375, "Palimino Creek"},
        {2312.534423, 81.270088, 34.412147, "Palimino Creek"},
        {2282.645019, 80.523757, 34.983432, "Palimino Creek"},
        {2270.598876, 52.587516, 29.983432, "Palimino Creek"},
        {2237.241210, -146.453750, 25.870410, "Palimino Creek"},
        {2294.017333, -133.607147, 28.153959, "Palimino Creek"},
        {2290.864501, -125.560646, 31.281974, "Palimino Creek"},
        {2494.198486, 84.268798, 26.484375, "Palimino Creek"},
        {2522.718505, -35.541027, 27.843750, "Palimino Creek"},
        {2371.754638, 166.031631, 28.441642, "Palimino Creek"},
        {2221.037597, 187.976211, 26.053337, "Palimino Creek"},
        {2175.741210, -96.308731, 25.773351, "Palimino Creek"},
        {2194.704589, -51.970607, 27.476959, "Palimino Creek"},
        {2521.830566, 147.489349, 26.660923, "Palimino Creek"},
        {2503.659667, 138.658645, 26.476562, "Palimino Creek"},
        {2385.197021, 132.599624, 26.477228, "Palimino Creek"},
        {2497.073974, 73.162178, 26.484375, "Palimino Creek"},
        {1113.000366, -298.941436, 79.273048, "Hilltop Farms"},
        {1145.276123, -319.449951, 68.736564, "Hilltop Farms"},
        {1139.270874, -279.303375, 68.293548, "Hilltop Farms"},
        {1109.191650, -254.074951, 73.178703, "Hilltop Farms"},
        {1074.967651, -290.027832, 76.994865, "Hilltop Farms"},
        {1045.733276, -292.704284, 77.359375, "Hilltop Farms"},
        {1038.980712, -314.385131, 73.993080, "Hilltop Farms"},
        {1019.215393, -280.257232, 73.992187, "Hilltop Farms"},
        {1017.502319, -291.644531, 77.359375, "Hilltop Farms"},
        {1025.220092, -286.122772, 73.993080, "Hilltop Farms"},
        {1008.152404, -361.344543, 73.992187, "Hilltop Farms"},
        {1031.137329, -286.081237, 73.992187, "Hilltop Farms"},
        {-91.739074, 47.309322, 3.117187, "Blueberry Acres"},
        {-59.916896, 110.778358, 3.117187, "Blueberry Acres"},
        {-21.062276, 101.820167, 3.117187, "Blueberry Acres"},
        {-39.467891, 54.310203, 3.117187, "Blueberry Acres"},
        {-57.822875, 58.630420, 12.634796, "Blueberry Acres"},
        {6.610152, -116.727790, 0.827577, "Blueberry Acres"},
        {-234.935729, -49.896484, 3.117187, "Blueberry Acres"},
        {-63.104183, -42.047443, 3.117187, "Blueberry Acres"},
        {-101.163230, -42.706863, 3.960474, "Blueberry Acres"},
        {-65.395072, -79.674530, 3.117187, "Blueberry Acres"},
        {-71.846885, 16.072692, 4.960474, "Blueberry Acres"},
        {-115.097801, -158.043121, 3.053518, "Blueberry Acres"},
        {-74.329200, 134.758972, 3.117187, "Blueberry Acres"},
        {-180.387710, 158.206222, 6.585262, "Blueberry Acres"},
        {43.705768, 31.582788, 2.406414, "Blueberry Acres"},
        {-120.041000, -101.572135, 3.118082, "Blueberry Acres"},
        {-97.865242, 3.703858, 6.140625, "Blueberry Acres"},
        {-141.913879, -45.108047, 3.117187, "Blueberry Acres"},
        {-96.231872, -43.475280, 6.484375, "Blueberry Acres"},
    {-614.443786, 151.758407, 25.818775, "The Panopticon"},
        {-526.496093, 58.226322, 50.909709, "The Panopticon"},
        {-472.907379, -169.445770, 78.210937, "The Panopticon"},
        {-735.953918, 57.285392, 26.305458, "The Panopticon"},
        {-546.440124, -61.437793, 63.233062, "The Panopticon"},
        {-710.849609, -206.753967, 69.553245, "The Panopticon"},
        {-436.740875, -59.873924, 58.875000, "The Panopticon"},
        {-751.409790, -114.402214, 67.739364, "The Panopticon"},
        {-925.530151, -124.350387, 57.936649, "The Panopticon"},
        {-400.126495, 236.726394, 9.927101, "The Panopticon"},
        {-520.779357, -125.374198, 69.994155, "The Panopticon"},
        {-561.900878, -178.898284, 78.413543, "The Panopticon"},
        {-539.732116, -161.536758, 78.206115, "The Panopticon"},
        {-532.769287, -177.417663, 84.258483, "The Panopticon"},
        {-389.482971, -211.937072, 59.564701, "The Panopticon"},
    {-406.703948, -1449.153686, 26.062500, "Flint Range"},
        {-396.805908, -1426.215209, 38.644241, "Flint Range"},
        {-365.578216, -1413.950805, 29.640625, "Flint Range"},
        {-364.751220, -1434.614501, 25.726562, "Flint Range"},
        {-584.598876, -1482.920043, 11.257370, "Flint Range"},
        {-558.555603, -1289.688232, 24.061843, "Flint Range"},
        {-210.887054, -1339.520751, 11.636716, "Flint Range"},
        {-203.383239, -1279.539794, 7.933257, "Flint Range"},
        {-370.022949, -1469.212768, 25.726562, "Flint Range"},
        {-257.378387, -1502.086059, 6.142509, "Flint Range"},
        {-329.254211, -1537.986083, 14.820620, "Flint Range"},
        {-370.188598, -1416.738281, 25.726562, "Flint Range"},
        {-468.467102, -1423.658813, 17.497291, "Flint Range"},
        {-366.230377, -1425.508422, 36.910018, "Flint Range"},
        {-438.425720, -1307.287841, 34.957294, "Flint Range"},
        {-326.334747, -1312.265869, 9.666571, "Flint Range"},
        {-2508.313232, -675.049499, 139.320312, "Missionary Hill"},
        {-2528.568359, -700.439453, 141.788848, "Missionary Hill"},
        {-2438.275146, -464.318084, 91.305053, "Missionary Hill"},
        {-2543.994384, -783.435424, 69.258705, "Missionary Hill"},
        {-2693.597412, -752.083862, 51.020137, "Missionary Hill"},
        {-2600.115478, -547.044921, 86.723999, "Missionary Hill"},
        {-2314.386230, -888.267517, 7.742542, "Missionary Hill"},
        {-2322.930664, -655.598815, 107.419876, "Missionary Hill"},
        {-2324.206054, -683.263916, 104.464118, "Missionary Hill"},
        {-2394.915283, -468.217041, 87.153312, "Missionary Hill"},
        {-2631.078613, -596.495971, 90.808830, "Missionary Hill"},
        {-2542.992431, -656.802001, 139.079116, "Missionary Hill"},
        {-2432.825439, -391.364898, 69.389305, "Missionary Hill"},
        {-2617.927001, -749.242065, 74.848922, "Missionary Hill"},
        {-2175.949951, -2417.699218, 34.296875, "Angel Pine"},
        {-2161.742919, -2453.351562, 37.592113, "Angel Pine"},
        {-2147.736572, -2461.206787, 30.851562, "Angel Pine"},
        {-2090.979492, -2469.472900, 33.924186, "Angel Pine"},
        {-2053.039306, -2544.468261, 31.066806, "Angel Pine"},
        {-2132.012939, -2433.635986, 39.040298, "Angel Pine"},
        {-2182.593994, -2428.734375, 35.523437, "Angel Pine"},
        {-2224.829833, -2396.499511, 35.533672, "Angel Pine"},
        {-2243.295654, -2359.313720, 30.750513, "Angel Pine"},
        {-2191.753173, -2345.898437, 35.007812, "Angel Pine"},
        {-2178.140625, -2314.520019, 37.743614, "Angel Pine"},
        {-2199.897949, -2243.446044, 33.320312, "Angel Pine"},
        {-2186.412353, -2245.995605, 30.721515, "Angel Pine"},
        {-2081.464843, -2254.676025, 37.810462, "Angel Pine"},
        {-2139.485839, -2263.617675, 37.106971, "Angel Pine"},
        {-2130.179931, -2362.220703, 37.803909, "Angel Pine"},
        {-2245.683837, -2489.593261, 30.939933, "Angel Pine"},
        {-2115.936523, -2417.141113, 31.226562, "Angel Pine"},
        {-2293.220947, -2449.365478, 25.740257, "Angel Pine"},
        {-1972.621704, -2409.536376, 36.779953, "Angel Pine"},
        {-2034.074829, -2350.098144, 40.890625, "Angel Pine"},
        {-2101.847412, -2341.794677, 34.820312, "Angel Pine"},
        {-1181.246826, -1169.744262, 129.218750, "The Farm"},
        {-1064.526367, -1202.956298, 136.825164, "The Farm"},
        {-1073.703247, -1236.239135, 129.218750, "The Farm"},
        {-960.019836, -969.289123, 136.249679, "The Farm"},
        {-1178.073120, -1139.615356, 129.218750, "The Farm"},
        {-1086.143554, -1304.293945, 129.218750, "The Farm"},
        {-1099.003295, -971.934814, 129.218750, "The Farm"},
        {-1062.486328, -913.190063, 129.211929, "The Farm"},
        {-1186.598144, -1138.081909, 132.746429, "The Farm"},
        {-1087.829833, -1084.395629, 129.218750, "The Farm"},
        {-1004.356140, -1013.866821, 129.218750, "The Farm"},
        {-1033.648925, -1068.210327, 129.218750, "The Farm"},
        {-1019.635437, -1153.692138, 129.218750, "The Farm"},
        {-1026.010375, -1183.257690, 129.218750, "The Farm"},
        {-1007.072387, -1296.862426, 132.661285, "The Farm"},
        {-1124.512817, -1222.314208, 129.218750, "The Farm"},
        {-1087.444824, -1677.984130, 76.373939, "Leafy Hallows"},
        {-1087.494018, -1678.885498, 76.373939, "Leafy Hallows"},
        {-1091.211059, -1663.834472, 76.367187, "Leafy Hallows"},
        {-1108.562622, -1634.623657, 80.057617, "Leafy Hallows"},
        {-1078.178222, -1607.183349, 76.367187, "Leafy Hallows"},
        {-1130.027343, -1606.987304, 76.367187, "Leafy Hallows"},
        {-1112.752685, -1621.049194, 86.261589, "Leafy Hallows"},
        {-1097.599121, -1627.398681, 76.367187, "Leafy Hallows"},
        {-946.533935, -1746.916137, 76.381385, "Leafy Hallows"},
        {-927.683105, -1701.916503, 77.025894, "Leafy Hallows"},
        {-923.776733, -1757.801513, 75.444259, "Leafy Hallows"},
        {-905.625366, -1730.898193, 78.139099, "Leafy Hallows"},
        {-1128.219360, -1696.092529, 76.558853, "Leafy Hallows"},
        {-1026.914428, -1733.098632, 76.425018, "Leafy Hallows"},
        {-1137.569824, -1630.458251, 76.367187, "Leafy Hallows"},
        {-1094.567626, -1663.774780, 76.367187, "Leafy Hallows"},
        {-1043.661254, -1621.000000, 76.367187, "Leafy Hallows"},
        {-907.789489, -1669.016723, 92.697944, "Leafy Hallows"},
        {2556.437744, -644.786804, 137.252746, "North Rock"},
        {2514.413818, -716.559753, 101.872634, "North Rock"},
        {2443.473388, -657.824401, 121.906684, "North Rock"},
        {2612.934814, -497.000335, 78.922164, "North Rock"},
        {2657.899414, -602.413452, 84.188896, "North Rock"},
        {2683.218017, -516.679077, 65.786819, "North Rock"},
        {2627.179199, -666.909179, 128.962661, "North Rock"},
        {2759.122314, -633.098876, 60.327945, "North Rock"},
        {2356.232910, -558.502868, 120.259140, "North Rock"},
        {2558.949218, -523.134826, 86.272521, "North Rock"},
        {-1012.700317, -754.431518, 32.007812, "Easter Bay Chemicals"},
        {-1095.468139, -629.071044, 34.089599, "Easter Bay Chemicals"},
        {-1109.042358, -601.289489, 34.089599, "Easter Bay Chemicals"},
        {-1074.046508, -600.883239, 34.089599, "Easter Bay Chemicals"},
        {-1112.463256, -748.833557, 32.007812, "Easter Bay Chemicals"},
        {-996.942810, -720.715209, 35.937500, "Easter Bay Chemicals"},
        {-987.252502, -716.223449, 35.901714, "Easter Bay Chemicals"},
        {-1037.941650, -697.023925, 32.007812, "Easter Bay Chemicals"},
        {-972.693725, -719.797607, 37.171875, "Easter Bay Chemicals"},
        {-1057.215332, -758.628417, 37.171875, "Easter Bay Chemicals"},
        {-1127.549194, -701.471435, 32.007812, "Easter Bay Chemicals"},
        {-973.345092, -635.038330, 32.007812, "Easter Bay Chemicals"},
        {-1099.870605, -696.740661, 32.351562, "Easter Bay Chemicals"},
        {-1057.206665, -634.323059, 35.493179, "Easter Bay Chemicals"},
        {-1017.676330, -704.239746, 32.007812, "Easter Bay Chemicals"},
        {-1525.973999, 2652.515136, 59.711399, "El Quebrados"},
        {-1507.893920, 2626.360107, 59.233432, "El Quebrados"},
        {-1530.962646, 2590.045654, 60.793697, "El Quebrados"},
        {-1481.348388, 2618.711181, 62.335689, "El Quebrados"},
        {-1416.942138, 2582.434082, 62.005947, "El Quebrados"},
        {-1437.265258, 2559.354248, 55.835937, "El Quebrados"},
        {-1459.728881, 2616.084960, 55.835937, "El Quebrados"},
        {-1452.608764, 2640.138183, 55.835937, "El Quebrados"},
        {-1463.314697, 2720.380126, 65.580146, "El Quebrados"},
        {-1550.759765, 2701.973876, 55.835937, "El Quebrados"},
        {-1567.961425, 2714.753662, 59.495937, "El Quebrados"},
        {-1591.316162, 2639.252685, 54.892074, "El Quebrados"},
        {-1564.054321, 2561.529541, 66.368583, "El Quebrados"},
        {-1593.676757, 2562.781250, 68.570213, "El Quebrados"},
        {-1461.241210, 2653.424804, 58.912673, "El Quebrados"},
        {-1470.498413, 2554.702636, 55.835937, "El Quebrados"},
        {-1579.125488, 2641.298095, 55.835937, "El Quebrados"},
        {-1521.946166, 2709.298339, 55.835937, "El Quebrados"},
        {-828.082336, 2661.674560, 104.945419, "Valle Ocultado"},
        {-835.934020, 2659.769775, 96.975189, "Valle Ocultado"},
        {-831.431640, 2695.995361, 53.576766, "Valle Ocultado"},
        {-803.072448, 2695.158203, 67.962074, "Valle Ocultado"},
        {-799.726013, 2704.947265, 47.416099, "Valle Ocultado"},
        {-788.210693, 2694.006103, 48.357761, "Valle Ocultado"},
        {-785.256774, 2719.440917, 45.300182, "Valle Ocultado"},
        {-779.532104, 2774.275146, 45.864643, "Valle Ocultado"},
        {-879.216064, 2747.853759, 46.000000, "Valle Ocultado"},
        {-724.237121, 2761.054199, 47.958900, "Valle Ocultado"},
        {-921.067687, 2675.897705, 45.312007, "Valle Ocultado"},
        {-912.755981, 2685.360595, 45.579273, "Valle Ocultado"},
        {-895.774658, 2672.384033, 42.191963, "Valle Ocultado"},
        {-769.700073, 2770.898437, 50.696720, "Valle Ocultado"},
        {-801.442077, 2776.446044, 45.975139, "Valle Ocultado"},
        {-737.213012, 2744.907470, 50.156967, "Valle Ocultado"},
        {-809.037780, 2809.187255, 49.179012, "Valle Ocultado"},
        {-821.493896, 2690.416259, 67.090553, "Valle Ocultado"},
        {-875.683532, 2693.958251, 52.923053, "Valle Ocultado"},
        {-918.803100, 2669.565429, 42.370262, "Valle Ocultado"},
        {-928.732421, 2707.239257, 42.883373, "Valle Ocultado"},
        {-384.209350, 2206.028564, 45.671134, "Ghost Town"},
        {-417.697753, 2246.862548, 42.429687, "Ghost Town"},
        {-384.358673, 2206.287841, 45.671134, "Ghost Town"},
        {-375.438262, 2241.879882, 47.126880, "Ghost Town"},
        {-371.937103, 2266.688964, 42.484375, "Ghost Town"},
        {-395.177276, 2246.250000, 50.119434, "Ghost Town"},
        {-324.652770, 2216.008789, 44.212184, "Ghost Town"},
        {-456.136169, 2223.866699, 42.894790, "Ghost Town"},
        {-435.397033, 2249.250732, 46.098773, "Ghost Town"},
        {-397.759216, 2198.488281, 42.425659, "Ghost Town"},
        {-327.913360, 2231.848876, 43.372142, "Ghost Town"},
        {-439.359222, 2219.759033, 47.228851, "Ghost Town"},
        {-765.302185, 2491.239013, 102.136093, "Acro del Oeste"},
        {-802.416625, 2444.712158, 157.024627, "Acro del Oeste"},
        {-769.736938, 2423.740478, 161.240509, "Acro del Oeste"},
        {-775.107543, 2454.568847, 155.394210, "Acro del Oeste"},
        {-825.450378, 2423.629394, 154.799423, "Acro del Oeste"},
        {-811.348144, 2392.648925, 154.081359, "Acro del Oeste"},
        {-869.765625, 2308.967285, 161.556732, "Acro del Oeste"},
        {-854.010314, 2395.529785, 90.695556, "Acro del Oeste"},
        {-865.451293, 2353.720458, 99.970436, "Acro del Oeste"},
        {-794.787414, 2267.457275, 58.976562, "Acro del Oeste"},
        {-806.945800, 2257.034667, 59.155395, "Acro del Oeste"},
        {-861.962158, 2275.708984, 69.768547, "Acro del Oeste"},
        {-806.547485, 2257.323242, 70.167610, "Acro del Oeste"},
        {-798.468383, 2249.032958, 52.464538, "Acro del Oeste"},
        {-819.647888, 2380.772460, 128.528991, "Acro del Oeste"},
        {-659.340942, 2310.784667, 137.731201, "Acro del Oeste"},
        {-629.103271, 2387.976806, 128.003738, "Acro del Oeste"},
        {-1967.813110, -923.389343, 32.226562, "Foster Valley"},
        {-1975.327148, -895.343750, 35.289417, "Foster Valley"},
        {-1945.200073, -1091.307373, 32.175434, "Foster Valley"},
        {-1904.608642, -1029.386840, 32.223834, "Foster Valley"},
        {-2059.095214, -989.335815, 32.171875, "Foster Valley"},
        {-2100.027343, -862.919860, 32.171875, "Foster Valley"},
        {-2153.603271, -793.245605, 31.976562, "Foster Valley"},
        {-2065.419677, -811.472534, 32.171875, "Foster Valley"},
        {-1964.095703, -726.187255, 37.390625, "Foster Valley"},
        {-1970.476440, -729.316772, 37.682456, "Foster Valley"},
        {-1971.316284, -729.375305, 38.024555, "Foster Valley"},
        {-1954.998413, -894.500610, 35.890884, "Foster Valley"},
        {-1952.155517, -991.665954, 35.890625, "Foster Valley"},
        {-1971.808837, -988.987060, 32.226562, "Foster Valley"},
        {-2040.327270, -734.473449, 32.171875, "Foster Valley"},
        {-1954.255981, -763.292663, 35.890884, "Foster Valley"},
        {-1934.306640, -817.633239, 35.277336, "Foster Valley"},
        {-2154.379394, -889.910583, 32.171875, "Foster Valley"},
        {-1933.880859, -957.182373, 35.292263, "Foster Valley"},
        {-2077.329833, -876.431518, 32.171875, "Foster Valley"},
        {-2021.934204, -889.969665, 30.179347, "Foster Valley"},
        {-1967.698486, -923.311828, 32.226562, "Foster Valley"},
        {-1975.518432, -881.348754, 35.289417, "Foster Valley"},
        {-1949.256469, -866.676269, 32.226562, "Foster Valley"},
        {-1893.254760, -884.175720, 31.968750, "Foster Valley"},
        {-1939.472412, -792.035339, 32.226562, "Foster Valley"},
        {-1944.139770, -744.467956, 32.226562, "Foster Valley"},
        {-1938.702148, -702.345642, 32.171875, "Foster Valley"},
        {-1912.550048, -715.325622, 32.158123, "Foster Valley"},
        {-1890.561767, -715.974426, 32.171875, "Foster Valley"},
        {-1314.880126, 2523.205566, 93.098388, "Aldea Malvada"},
        {-1340.013183, 2566.662841, 92.453392, "Aldea Malvada"},
        {-1342.981445, 2577.075195, 77.273002, "Aldea Malvada"},
        {-1316.729370, 2595.577880, 73.072959, "Aldea Malvada"},
        {-1300.144653, 2546.430664, 87.742187, "Aldea Malvada"},
        {-1365.330444, 2531.653320, 87.216758, "Aldea Malvada"},
        {-1289.671264, 2516.583984, 87.161216, "Aldea Malvada"},
        {-1314.141967, 2528.084716, 87.613708, "Aldea Malvada"},
        {-1369.994506, 2530.447753, 77.454376, "Aldea Malvada"},
        {-1325.340332, 2516.338378, 87.046875, "Aldea Malvada"},
        {-1324.558593, 2532.424560, 87.561912, "Aldea Malvada"},
        {-1346.553466, 2565.318115, 80.643333, "Aldea Malvada"},
        {-541.176086, -561.201354, 26.798007, "The Fallen Tree"},
        {-504.101501, -539.727050, 25.523437, "The Fallen Tree"},
        {-503.481170, -527.582458, 25.523437, "The Fallen Tree"},
        {-475.996154, -552.346740, 33.121536, "The Fallen Tree"},
        {-470.645874, -538.255004, 29.121538, "The Fallen Tree"},
        {-466.353302, -468.697967, 25.523437, "The Fallen Tree"},
        {-517.881530, -496.789825, 25.523437, "The Fallen Tree"},
        {-620.473388, -472.812927, 25.523437, "The Fallen Tree"},
        {-644.839599, -445.775238, 27.982749, "The Fallen Tree"},
        {-586.403198, -398.734558, 24.491775, "The Fallen Tree"},
        {-554.032104, -423.535186, 29.328639, "The Fallen Tree"},
        {-488.099975, -449.957580, 42.387664, "The Fallen Tree"},
        {-507.062316, -434.387115, 37.013797, "The Fallen Tree"},
        {-501.433959, -570.266723, 24.771287, "The Fallen Tree"},
        {-440.963348, -582.747680, 14.563718, "The Fallen Tree"},
        {-624.458557, -561.871093, 26.267879, "The Fallen Tree"},
        {-657.998779, -588.320190, 33.299449, "The Fallen Tree"},
        {-505.762481, -522.940368, 36.364982, "The Fallen Tree"},
        {-615.547546, -506.135650, 33.525276, "The Fallen Tree"},
        {-596.443237, -526.158813, 33.525276, "The Fallen Tree"},
        {-615.139038, -531.275512, 37.525276, "The Fallen Tree"},
        {-624.562072, -509.588043, 33.459438, "The Fallen Tree"},
        {-531.809875, -467.091979, 26.224544, "The Fallen Tree"}
};

enum SAZONE_MAIN { //Betamaster
		SAZONE_NAME[28],
		Float:SAZONE_AREA[6]
};

static const gSAZones[][SAZONE_MAIN] = {  // Majority of names and area coordinates adopted from Mabako's 'Zones Script' v0.2
	//	NAME                            AREA (Xmin,Ymin,Zmin,Xmax,Ymax,Zmax)
	{"The Big Ear",	                {-410.00,1403.30,-3.00,-137.90,1681.20,200.00}},
	{"Aldea Malvada",               {-1372.10,2498.50,0.00,-1277.50,2615.30,200.00}},
	{"Angel Pine",                  {-2324.90,-2584.20,-6.10,-1964.20,-2212.10,200.00}},
	{"Arco del Oeste",              {-901.10,2221.80,0.00,-592.00,2571.90,200.00}},
	{"Avispa Country Club",         {-2646.40,-355.40,0.00,-2270.00,-222.50,200.00}},
	{"Avispa Country Club",         {-2831.80,-430.20,-6.10,-2646.40,-222.50,200.00}},
	{"Avispa Country Club",         {-2361.50,-417.10,0.00,-2270.00,-355.40,200.00}},
	{"Avispa Country Club",         {-2667.80,-302.10,-28.80,-2646.40,-262.30,71.10}},
	{"Avispa Country Club",         {-2470.00,-355.40,0.00,-2270.00,-318.40,46.10}},
	{"Avispa Country Club",         {-2550.00,-355.40,0.00,-2470.00,-318.40,39.70}},
	{"Back o Beyond",               {-1166.90,-2641.10,0.00,-321.70,-1856.00,200.00}},
	{"Battery Point",               {-2741.00,1268.40,-4.50,-2533.00,1490.40,200.00}},
	{"Bayside",                     {-2741.00,2175.10,0.00,-2353.10,2722.70,200.00}},
	{"Bayside Marina",              {-2353.10,2275.70,0.00,-2153.10,2475.70,200.00}},
	{"Beacon Hill",                 {-399.60,-1075.50,-1.40,-319.00,-977.50,198.50}},
	{"Blackfield",                  {964.30,1203.20,-89.00,1197.30,1403.20,110.90}},
	{"Blackfield",                  {964.30,1403.20,-89.00,1197.30,1726.20,110.90}},
	{"Blackfield Chapel",           {1375.60,596.30,-89.00,1558.00,823.20,110.90}},
	{"Blackfield Chapel",           {1325.60,596.30,-89.00,1375.60,795.00,110.90}},
	{"Blackfield Intersection",     {1197.30,1044.60,-89.00,1277.00,1163.30,110.90}},
	{"Blackfield Intersection",     {1166.50,795.00,-89.00,1375.60,1044.60,110.90}},
	{"Blackfield Intersection",     {1277.00,1044.60,-89.00,1315.30,1087.60,110.90}},
	{"Blackfield Intersection",     {1375.60,823.20,-89.00,1457.30,919.40,110.90}},
	{"Blueberry",                   {104.50,-220.10,2.30,349.60,152.20,200.00}},
	{"Blueberry",                   {19.60,-404.10,3.80,349.60,-220.10,200.00}},
	{"Blueberry Acres",             {-319.60,-220.10,0.00,104.50,293.30,200.00}},
	{"Caligula's Palace",           {2087.30,1543.20,-89.00,2437.30,1703.20,110.90}},
	{"Caligula's Palace",           {2137.40,1703.20,-89.00,2437.30,1783.20,110.90}},
	{"Calton Heights",              {-2274.10,744.10,-6.10,-1982.30,1358.90,200.00}},
	{"Chinatown",                   {-2274.10,578.30,-7.60,-2078.60,744.10,200.00}},
	{"City Hall",                   {-2867.80,277.40,-9.10,-2593.40,458.40,200.00}},
	{"Come-A-Lot",                  {2087.30,943.20,-89.00,2623.10,1203.20,110.90}},
	{"Commerce",                    {1323.90,-1842.20,-89.00,1701.90,-1722.20,110.90}},
	{"Commerce",                    {1323.90,-1722.20,-89.00,1440.90,-1577.50,110.90}},
	{"Commerce",                    {1370.80,-1577.50,-89.00,1463.90,-1384.90,110.90}},
	{"Commerce",                    {1463.90,-1577.50,-89.00,1667.90,-1430.80,110.90}},
	{"Commerce",                    {1583.50,-1722.20,-89.00,1758.90,-1577.50,110.90}},
	{"Commerce",                    {1667.90,-1577.50,-89.00,1812.60,-1430.80,110.90}},
	{"Conference Center",           {1046.10,-1804.20,-89.00,1323.90,-1722.20,110.90}},
	{"Conference Center",           {1073.20,-1842.20,-89.00,1323.90,-1804.20,110.90}},
	{"Cranberry Station",           {-2007.80,56.30,0.00,-1922.00,224.70,100.00}},
	{"Creek",                       {2749.90,1937.20,-89.00,2921.60,2669.70,110.90}},
	{"Dillimore",                   {580.70,-674.80,-9.50,861.00,-404.70,200.00}},
	{"Doherty",                     {-2270.00,-324.10,-0.00,-1794.90,-222.50,200.00}},
	{"Doherty",                     {-2173.00,-222.50,-0.00,-1794.90,265.20,200.00}},
	{"Downtown",                    {-1982.30,744.10,-6.10,-1871.70,1274.20,200.00}},
	{"Downtown",                    {-1871.70,1176.40,-4.50,-1620.30,1274.20,200.00}},
	{"Downtown",                    {-1700.00,744.20,-6.10,-1580.00,1176.50,200.00}},
	{"Downtown",                    {-1580.00,744.20,-6.10,-1499.80,1025.90,200.00}},
	{"Downtown",                    {-2078.60,578.30,-7.60,-1499.80,744.20,200.00}},
	{"Downtown",                    {-1993.20,265.20,-9.10,-1794.90,578.30,200.00}},
	{"Downtown Los Santos",         {1463.90,-1430.80,-89.00,1724.70,-1290.80,110.90}},
	{"Downtown Los Santos",         {1724.70,-1430.80,-89.00,1812.60,-1250.90,110.90}},
	{"Downtown Los Santos",         {1463.90,-1290.80,-89.00,1724.70,-1150.80,110.90}},
	{"Downtown Los Santos",         {1370.80,-1384.90,-89.00,1463.90,-1170.80,110.90}},
	{"Downtown Los Santos",         {1724.70,-1250.90,-89.00,1812.60,-1150.80,110.90}},
	{"Downtown Los Santos",         {1370.80,-1170.80,-89.00,1463.90,-1130.80,110.90}},
	{"Downtown Los Santos",         {1378.30,-1130.80,-89.00,1463.90,-1026.30,110.90}},
	{"Downtown Los Santos",         {1391.00,-1026.30,-89.00,1463.90,-926.90,110.90}},
	{"Downtown Los Santos",         {1507.50,-1385.20,110.90,1582.50,-1325.30,335.90}},
	{"East Beach",                  {2632.80,-1852.80,-89.00,2959.30,-1668.10,110.90}},
	{"East Beach",                  {2632.80,-1668.10,-89.00,2747.70,-1393.40,110.90}},
	{"East Beach",                  {2747.70,-1668.10,-89.00,2959.30,-1498.60,110.90}},
	{"East Beach",                  {2747.70,-1498.60,-89.00,2959.30,-1120.00,110.90}},
	{"East Los Santos",             {2421.00,-1628.50,-89.00,2632.80,-1454.30,110.90}},
	{"East Los Santos",             {2222.50,-1628.50,-89.00,2421.00,-1494.00,110.90}},
	{"East Los Santos",             {2266.20,-1494.00,-89.00,2381.60,-1372.00,110.90}},
	{"East Los Santos",             {2381.60,-1494.00,-89.00,2421.00,-1454.30,110.90}},
	{"East Los Santos",             {2281.40,-1372.00,-89.00,2381.60,-1135.00,110.90}},
	{"East Los Santos",             {2381.60,-1454.30,-89.00,2462.10,-1135.00,110.90}},
	{"East Los Santos",             {2462.10,-1454.30,-89.00,2581.70,-1135.00,110.90}},
	{"Easter Basin",                {-1794.90,249.90,-9.10,-1242.90,578.30,200.00}},
	{"Easter Basin",                {-1794.90,-50.00,-0.00,-1499.80,249.90,200.00}},
	{"Easter Bay Airport",          {-1499.80,-50.00,-0.00,-1242.90,249.90,200.00}},
	{"Easter Bay Airport",          {-1794.90,-730.10,-3.00,-1213.90,-50.00,200.00}},
	{"Easter Bay Airport",          {-1213.90,-730.10,0.00,-1132.80,-50.00,200.00}},
	{"Easter Bay Airport",          {-1242.90,-50.00,0.00,-1213.90,578.30,200.00}},
	{"Easter Bay Airport",          {-1213.90,-50.00,-4.50,-947.90,578.30,200.00}},
	{"Easter Bay Airport",          {-1315.40,-405.30,15.40,-1264.40,-209.50,25.40}},
	{"Easter Bay Airport",          {-1354.30,-287.30,15.40,-1315.40,-209.50,25.40}},
	{"Easter Bay Airport",          {-1490.30,-209.50,15.40,-1264.40,-148.30,25.40}},
	{"Easter Bay Chemicals",        {-1132.80,-768.00,0.00,-956.40,-578.10,200.00}},
	{"Easter Bay Chemicals",        {-1132.80,-787.30,0.00,-956.40,-768.00,200.00}},
	{"El Castillo del Diablo",      {-464.50,2217.60,0.00,-208.50,2580.30,200.00}},
	{"El Castillo del Diablo",      {-208.50,2123.00,-7.60,114.00,2337.10,200.00}},
	{"El Castillo del Diablo",      {-208.50,2337.10,0.00,8.40,2487.10,200.00}},
	{"El Corona",                   {1812.60,-2179.20,-89.00,1970.60,-1852.80,110.90}},
	{"El Corona",                   {1692.60,-2179.20,-89.00,1812.60,-1842.20,110.90}},
	{"El Quebrados",                {-1645.20,2498.50,0.00,-1372.10,2777.80,200.00}},
	{"Esplanade East",              {-1620.30,1176.50,-4.50,-1580.00,1274.20,200.00}},
	{"Esplanade East",              {-1580.00,1025.90,-6.10,-1499.80,1274.20,200.00}},
	{"Esplanade East",              {-1499.80,578.30,-79.60,-1339.80,1274.20,20.30}},
	{"Esplanade North",             {-2533.00,1358.90,-4.50,-1996.60,1501.20,200.00}},
	{"Esplanade North",             {-1996.60,1358.90,-4.50,-1524.20,1592.50,200.00}},
	{"Esplanade North",             {-1982.30,1274.20,-4.50,-1524.20,1358.90,200.00}},
	{"Fallen Tree",                 {-792.20,-698.50,-5.30,-452.40,-380.00,200.00}},
	{"Fallow Bridge",               {434.30,366.50,0.00,603.00,555.60,200.00}},
	{"Fern Ridge",                  {508.10,-139.20,0.00,1306.60,119.50,200.00}},
	{"Financial",                   {-1871.70,744.10,-6.10,-1701.30,1176.40,300.00}},
	{"Fisher's Lagoon",             {1916.90,-233.30,-100.00,2131.70,13.80,200.00}},
	{"Flint Intersection",          {-187.70,-1596.70,-89.00,17.00,-1276.60,110.90}},
	{"Flint Range",                 {-594.10,-1648.50,0.00,-187.70,-1276.60,200.00}},
	{"Fort Carson",                 {-376.20,826.30,-3.00,123.70,1220.40,200.00}},
	{"Foster Valley",               {-2270.00,-430.20,-0.00,-2178.60,-324.10,200.00}},
	{"Foster Valley",               {-2178.60,-599.80,-0.00,-1794.90,-324.10,200.00}},
	{"Foster Valley",               {-2178.60,-1115.50,0.00,-1794.90,-599.80,200.00}},
	{"Foster Valley",               {-2178.60,-1250.90,0.00,-1794.90,-1115.50,200.00}},
	{"Frederick Bridge",            {2759.20,296.50,0.00,2774.20,594.70,200.00}},
	{"Gant Bridge",                 {-2741.40,1659.60,-6.10,-2616.40,2175.10,200.00}},
	{"Gant Bridge",                 {-2741.00,1490.40,-6.10,-2616.40,1659.60,200.00}},
	{"Ganton",                      {2222.50,-1852.80,-89.00,2632.80,-1722.30,110.90}},
	{"Ganton",                      {2222.50,-1722.30,-89.00,2632.80,-1628.50,110.90}},
	{"Garcia",                      {-2411.20,-222.50,-0.00,-2173.00,265.20,200.00}},
	{"Garcia",                      {-2395.10,-222.50,-5.30,-2354.00,-204.70,200.00}},
	{"Garver Bridge",               {-1339.80,828.10,-89.00,-1213.90,1057.00,110.90}},
	{"Garver Bridge",               {-1213.90,950.00,-89.00,-1087.90,1178.90,110.90}},
	{"Garver Bridge",               {-1499.80,696.40,-179.60,-1339.80,925.30,20.30}},
	{"Glen Park",                   {1812.60,-1449.60,-89.00,1996.90,-1350.70,110.90}},
	{"Glen Park",                   {1812.60,-1100.80,-89.00,1994.30,-973.30,110.90}},
	{"Glen Park",                   {1812.60,-1350.70,-89.00,2056.80,-1100.80,110.90}},
	{"Green Palms",                 {176.50,1305.40,-3.00,338.60,1520.70,200.00}},
	{"Greenglass College",          {964.30,1044.60,-89.00,1197.30,1203.20,110.90}},
	{"Greenglass College",          {964.30,930.80,-89.00,1166.50,1044.60,110.90}},
	{"Hampton Barns",               {603.00,264.30,0.00,761.90,366.50,200.00}},
	{"Hankypanky Point",            {2576.90,62.10,0.00,2759.20,385.50,200.00}},
	{"Harry Gold Parkway",          {1777.30,863.20,-89.00,1817.30,2342.80,110.90}},
	{"Hashbury",                    {-2593.40,-222.50,-0.00,-2411.20,54.70,200.00}},
	{"Hilltop Farm",                {967.30,-450.30,-3.00,1176.70,-217.90,200.00}},
	{"Hunter Quarry",               {337.20,710.80,-115.20,860.50,1031.70,203.70}},
	{"Idlewood",                    {1812.60,-1852.80,-89.00,1971.60,-1742.30,110.90}},
	{"Idlewood",                    {1812.60,-1742.30,-89.00,1951.60,-1602.30,110.90}},
	{"Idlewood",                    {1951.60,-1742.30,-89.00,2124.60,-1602.30,110.90}},
	{"Idlewood",                    {1812.60,-1602.30,-89.00,2124.60,-1449.60,110.90}},
	{"Idlewood",                    {2124.60,-1742.30,-89.00,2222.50,-1494.00,110.90}},
	{"Idlewood",                    {1971.60,-1852.80,-89.00,2222.50,-1742.30,110.90}},
	{"Jefferson",                   {1996.90,-1449.60,-89.00,2056.80,-1350.70,110.90}},
	{"Jefferson",                   {2124.60,-1494.00,-89.00,2266.20,-1449.60,110.90}},
	{"Jefferson",                   {2056.80,-1372.00,-89.00,2281.40,-1210.70,110.90}},
	{"Jefferson",                   {2056.80,-1210.70,-89.00,2185.30,-1126.30,110.90}},
	{"Jefferson",                   {2185.30,-1210.70,-89.00,2281.40,-1154.50,110.90}},
	{"Jefferson",                   {2056.80,-1449.60,-89.00,2266.20,-1372.00,110.90}},
	{"Julius Thruway East",         {2623.10,943.20,-89.00,2749.90,1055.90,110.90}},
	{"Julius Thruway East",         {2685.10,1055.90,-89.00,2749.90,2626.50,110.90}},
	{"Julius Thruway East",         {2536.40,2442.50,-89.00,2685.10,2542.50,110.90}},
	{"Julius Thruway East",         {2625.10,2202.70,-89.00,2685.10,2442.50,110.90}},
	{"Julius Thruway North",        {2498.20,2542.50,-89.00,2685.10,2626.50,110.90}},
	{"Julius Thruway North",        {2237.40,2542.50,-89.00,2498.20,2663.10,110.90}},
	{"Julius Thruway North",        {2121.40,2508.20,-89.00,2237.40,2663.10,110.90}},
	{"Julius Thruway North",        {1938.80,2508.20,-89.00,2121.40,2624.20,110.90}},
	{"Julius Thruway North",        {1534.50,2433.20,-89.00,1848.40,2583.20,110.90}},
	{"Julius Thruway North",        {1848.40,2478.40,-89.00,1938.80,2553.40,110.90}},
	{"Julius Thruway North",        {1704.50,2342.80,-89.00,1848.40,2433.20,110.90}},
	{"Julius Thruway North",        {1377.30,2433.20,-89.00,1534.50,2507.20,110.90}},
	{"Julius Thruway South",        {1457.30,823.20,-89.00,2377.30,863.20,110.90}},
	{"Julius Thruway South",        {2377.30,788.80,-89.00,2537.30,897.90,110.90}},
	{"Julius Thruway West",         {1197.30,1163.30,-89.00,1236.60,2243.20,110.90}},
	{"Julius Thruway West",         {1236.60,2142.80,-89.00,1297.40,2243.20,110.90}},
	{"Juniper Hill",                {-2533.00,578.30,-7.60,-2274.10,968.30,200.00}},
	{"Juniper Hollow",              {-2533.00,968.30,-6.10,-2274.10,1358.90,200.00}},
	{"K.A.C.C. Military Fuels",     {2498.20,2626.50,-89.00,2749.90,2861.50,110.90}},
	{"Kincaid Bridge",              {-1339.80,599.20,-89.00,-1213.90,828.10,110.90}},
	{"Kincaid Bridge",              {-1213.90,721.10,-89.00,-1087.90,950.00,110.90}},
	{"Kincaid Bridge",              {-1087.90,855.30,-89.00,-961.90,986.20,110.90}},
	{"King's",                      {-2329.30,458.40,-7.60,-1993.20,578.30,200.00}},
	{"King's",                      {-2411.20,265.20,-9.10,-1993.20,373.50,200.00}},
	{"King's",                      {-2253.50,373.50,-9.10,-1993.20,458.40,200.00}},
	{"LVA Freight Depot",           {1457.30,863.20,-89.00,1777.40,1143.20,110.90}},
	{"LVA Freight Depot",           {1375.60,919.40,-89.00,1457.30,1203.20,110.90}},
	{"LVA Freight Depot",           {1277.00,1087.60,-89.00,1375.60,1203.20,110.90}},
	{"LVA Freight Depot",           {1315.30,1044.60,-89.00,1375.60,1087.60,110.90}},
	{"LVA Freight Depot",           {1236.60,1163.40,-89.00,1277.00,1203.20,110.90}},
	{"Las Barrancas",               {-926.10,1398.70,-3.00,-719.20,1634.60,200.00}},
	{"Las Brujas",                  {-365.10,2123.00,-3.00,-208.50,2217.60,200.00}},
	{"Las Colinas",                 {1994.30,-1100.80,-89.00,2056.80,-920.80,110.90}},
	{"Las Colinas",                 {2056.80,-1126.30,-89.00,2126.80,-920.80,110.90}},
	{"Las Colinas",                 {2185.30,-1154.50,-89.00,2281.40,-934.40,110.90}},
	{"Las Colinas",                 {2126.80,-1126.30,-89.00,2185.30,-934.40,110.90}},
	{"Las Colinas",                 {2747.70,-1120.00,-89.00,2959.30,-945.00,110.90}},
	{"Las Colinas",                 {2632.70,-1135.00,-89.00,2747.70,-945.00,110.90}},
	{"Las Colinas",                 {2281.40,-1135.00,-89.00,2632.70,-945.00,110.90}},
	{"Las Payasadas",               {-354.30,2580.30,2.00,-133.60,2816.80,200.00}},
	{"Las Venturas Airport",        {1236.60,1203.20,-89.00,1457.30,1883.10,110.90}},
	{"Las Venturas Airport",        {1457.30,1203.20,-89.00,1777.30,1883.10,110.90}},
	{"Las Venturas Airport",        {1457.30,1143.20,-89.00,1777.40,1203.20,110.90}},
	{"Las Venturas Airport",        {1515.80,1586.40,-12.50,1729.90,1714.50,87.50}},
	{"Last Dime Motel",             {1823.00,596.30,-89.00,1997.20,823.20,110.90}},
	{"Leafy Hollow",                {-1166.90,-1856.00,0.00,-815.60,-1602.00,200.00}},
	{"Liberty City",                {-1000.00,400.00,1300.00,-700.00,600.00,1400.00}},
	{"Lil' Probe Inn",              {-90.20,1286.80,-3.00,153.80,1554.10,200.00}},
	{"Linden Side",                 {2749.90,943.20,-89.00,2923.30,1198.90,110.90}},
	{"Linden Station",              {2749.90,1198.90,-89.00,2923.30,1548.90,110.90}},
	{"Linden Station",              {2811.20,1229.50,-39.50,2861.20,1407.50,60.40}},
	{"Little Mexico",               {1701.90,-1842.20,-89.00,1812.60,-1722.20,110.90}},
	{"Little Mexico",               {1758.90,-1722.20,-89.00,1812.60,-1577.50,110.90}},
	{"Los Flores",                  {2581.70,-1454.30,-89.00,2632.80,-1393.40,110.90}},
	{"Los Flores",                  {2581.70,-1393.40,-89.00,2747.70,-1135.00,110.90}},
	{"Los Santos International",    {1249.60,-2394.30,-89.00,1852.00,-2179.20,110.90}},
	{"Los Santos International",    {1852.00,-2394.30,-89.00,2089.00,-2179.20,110.90}},
	{"Los Santos International",    {1382.70,-2730.80,-89.00,2201.80,-2394.30,110.90}},
	{"Los Santos International",    {1974.60,-2394.30,-39.00,2089.00,-2256.50,60.90}},
	{"Los Santos International",    {1400.90,-2669.20,-39.00,2189.80,-2597.20,60.90}},
	{"Los Santos International",    {2051.60,-2597.20,-39.00,2152.40,-2394.30,60.90}},
	{"Marina",                      {647.70,-1804.20,-89.00,851.40,-1577.50,110.90}},
	{"Marina",                      {647.70,-1577.50,-89.00,807.90,-1416.20,110.90}},
	{"Marina",                      {807.90,-1577.50,-89.00,926.90,-1416.20,110.90}},
	{"Market",                      {787.40,-1416.20,-89.00,1072.60,-1310.20,110.90}},
	{"Market",                      {952.60,-1310.20,-89.00,1072.60,-1130.80,110.90}},
	{"Market",                      {1072.60,-1416.20,-89.00,1370.80,-1130.80,110.90}},
	{"Market",                      {926.90,-1577.50,-89.00,1370.80,-1416.20,110.90}},
	{"Market Station",              {787.40,-1410.90,-34.10,866.00,-1310.20,65.80}},
	{"Martin Bridge",               {-222.10,293.30,0.00,-122.10,476.40,200.00}},
	{"Missionary Hill",             {-2994.40,-811.20,0.00,-2178.60,-430.20,200.00}},
	{"Montgomery",                  {1119.50,119.50,-3.00,1451.40,493.30,200.00}},
	{"Montgomery",                  {1451.40,347.40,-6.10,1582.40,420.80,200.00}},
	{"Montgomery Intersection",     {1546.60,208.10,0.00,1745.80,347.40,200.00}},
	{"Montgomery Intersection",     {1582.40,347.40,0.00,1664.60,401.70,200.00}},
	{"Mulholland",                  {1414.00,-768.00,-89.00,1667.60,-452.40,110.90}},
	{"Mulholland",                  {1281.10,-452.40,-89.00,1641.10,-290.90,110.90}},
	{"Mulholland",                  {1269.10,-768.00,-89.00,1414.00,-452.40,110.90}},
	{"Mulholland",                  {1357.00,-926.90,-89.00,1463.90,-768.00,110.90}},
	{"Mulholland",                  {1318.10,-910.10,-89.00,1357.00,-768.00,110.90}},
	{"Mulholland",                  {1169.10,-910.10,-89.00,1318.10,-768.00,110.90}},
	{"Mulholland",                  {768.60,-954.60,-89.00,952.60,-860.60,110.90}},
	{"Mulholland",                  {687.80,-860.60,-89.00,911.80,-768.00,110.90}},
	{"Mulholland",                  {737.50,-768.00,-89.00,1142.20,-674.80,110.90}},
	{"Mulholland",                  {1096.40,-910.10,-89.00,1169.10,-768.00,110.90}},
	{"Mulholland",                  {952.60,-937.10,-89.00,1096.40,-860.60,110.90}},
	{"Mulholland",                  {911.80,-860.60,-89.00,1096.40,-768.00,110.90}},
	{"Mulholland",                  {861.00,-674.80,-89.00,1156.50,-600.80,110.90}},
	{"Mulholland Intersection",     {1463.90,-1150.80,-89.00,1812.60,-768.00,110.90}},
	{"North Rock",                  {2285.30,-768.00,0.00,2770.50,-269.70,200.00}},
	{"Ocean Docks",                 {2373.70,-2697.00,-89.00,2809.20,-2330.40,110.90}},
	{"Ocean Docks",                 {2201.80,-2418.30,-89.00,2324.00,-2095.00,110.90}},
	{"Ocean Docks",                 {2324.00,-2302.30,-89.00,2703.50,-2145.10,110.90}},
	{"Ocean Docks",                 {2089.00,-2394.30,-89.00,2201.80,-2235.80,110.90}},
	{"Ocean Docks",                 {2201.80,-2730.80,-89.00,2324.00,-2418.30,110.90}},
	{"Ocean Docks",                 {2703.50,-2302.30,-89.00,2959.30,-2126.90,110.90}},
	{"Ocean Docks",                 {2324.00,-2145.10,-89.00,2703.50,-2059.20,110.90}},
	{"Ocean Flats",                 {-2994.40,277.40,-9.10,-2867.80,458.40,200.00}},
	{"Ocean Flats",                 {-2994.40,-222.50,-0.00,-2593.40,277.40,200.00}},
	{"Ocean Flats",                 {-2994.40,-430.20,-0.00,-2831.80,-222.50,200.00}},
	{"Octane Springs",              {338.60,1228.50,0.00,664.30,1655.00,200.00}},
	{"Old Venturas Strip",          {2162.30,2012.10,-89.00,2685.10,2202.70,110.90}},
	{"Palisades",                   {-2994.40,458.40,-6.10,-2741.00,1339.60,200.00}},
	{"Palomino Creek",              {2160.20,-149.00,0.00,2576.90,228.30,200.00}},
	{"Paradiso",                    {-2741.00,793.40,-6.10,-2533.00,1268.40,200.00}},
	{"Pershing Square",             {1440.90,-1722.20,-89.00,1583.50,-1577.50,110.90}},
	{"Pilgrim",                     {2437.30,1383.20,-89.00,2624.40,1783.20,110.90}},
	{"Pilgrim",                     {2624.40,1383.20,-89.00,2685.10,1783.20,110.90}},
	{"Pilson Intersection",         {1098.30,2243.20,-89.00,1377.30,2507.20,110.90}},
	{"Pirates in Men's Pants",      {1817.30,1469.20,-89.00,2027.40,1703.20,110.90}},
	{"Playa del Seville",           {2703.50,-2126.90,-89.00,2959.30,-1852.80,110.90}},
	{"Prickle Pine",                {1534.50,2583.20,-89.00,1848.40,2863.20,110.90}},
	{"Prickle Pine",                {1117.40,2507.20,-89.00,1534.50,2723.20,110.90}},
	{"Prickle Pine",                {1848.40,2553.40,-89.00,1938.80,2863.20,110.90}},
	{"Prickle Pine",                {1938.80,2624.20,-89.00,2121.40,2861.50,110.90}},
	{"Queens",                      {-2533.00,458.40,0.00,-2329.30,578.30,200.00}},
	{"Queens",                      {-2593.40,54.70,0.00,-2411.20,458.40,200.00}},
	{"Queens",                      {-2411.20,373.50,0.00,-2253.50,458.40,200.00}},
	{"Randolph Industrial",  {1558.00,596.30,-89.00,1823.00,823.20,110.90}},
	{"Redsands East",               {1817.30,2011.80,-89.00,2106.70,2202.70,110.90}},
	{"Redsands East",               {1817.30,2202.70,-89.00,2011.90,2342.80,110.90}},
	{"Redsands East",               {1848.40,2342.80,-89.00,2011.90,2478.40,110.90}},
	{"Redsands West",               {1236.60,1883.10,-89.00,1777.30,2142.80,110.90}},
	{"Redsands West",               {1297.40,2142.80,-89.00,1777.30,2243.20,110.90}},
	{"Redsands West",               {1377.30,2243.20,-89.00,1704.50,2433.20,110.90}},
	{"Redsands West",               {1704.50,2243.20,-89.00,1777.30,2342.80,110.90}},
	{"Regular Tom",                 {-405.70,1712.80,-3.00,-276.70,1892.70,200.00}},
	{"Richman",                     {647.50,-1118.20,-89.00,787.40,-954.60,110.90}},
	{"Richman",                     {647.50,-954.60,-89.00,768.60,-860.60,110.90}},
	{"Richman",                     {225.10,-1369.60,-89.00,334.50,-1292.00,110.90}},
	{"Richman",                     {225.10,-1292.00,-89.00,466.20,-1235.00,110.90}},
	{"Richman",                     {72.60,-1404.90,-89.00,225.10,-1235.00,110.90}},
	{"Richman",                     {72.60,-1235.00,-89.00,321.30,-1008.10,110.90}},
	{"Richman",                     {321.30,-1235.00,-89.00,647.50,-1044.00,110.90}},
	{"Richman",                     {321.30,-1044.00,-89.00,647.50,-860.60,110.90}},
	{"Richman",                     {321.30,-860.60,-89.00,687.80,-768.00,110.90}},
	{"Richman",                     {321.30,-768.00,-89.00,700.70,-674.80,110.90}},
	{"Robada Intersection",         {-1119.00,1178.90,-89.00,-862.00,1351.40,110.90}},
	{"Roca Escalante",              {2237.40,2202.70,-89.00,2536.40,2542.50,110.90}},
	{"Roca Escalante",              {2536.40,2202.70,-89.00,2625.10,2442.50,110.90}},
	{"Rockshore East",              {2537.30,676.50,-89.00,2902.30,943.20,110.90}},
	{"Rockshore West",              {1997.20,596.30,-89.00,2377.30,823.20,110.90}},
	{"Rockshore West",              {2377.30,596.30,-89.00,2537.30,788.80,110.90}},
	{"Rodeo",                       {72.60,-1684.60,-89.00,225.10,-1544.10,110.90}},
	{"Rodeo",                       {72.60,-1544.10,-89.00,225.10,-1404.90,110.90}},
	{"Rodeo",                       {225.10,-1684.60,-89.00,312.80,-1501.90,110.90}},
	{"Rodeo",                       {225.10,-1501.90,-89.00,334.50,-1369.60,110.90}},
	{"Rodeo",                       {334.50,-1501.90,-89.00,422.60,-1406.00,110.90}},
	{"Rodeo",                       {312.80,-1684.60,-89.00,422.60,-1501.90,110.90}},
	{"Rodeo",                       {422.60,-1684.60,-89.00,558.00,-1570.20,110.90}},
	{"Rodeo",                       {558.00,-1684.60,-89.00,647.50,-1384.90,110.90}},
	{"Rodeo",                       {466.20,-1570.20,-89.00,558.00,-1385.00,110.90}},
	{"Rodeo",                       {422.60,-1570.20,-89.00,466.20,-1406.00,110.90}},
	{"Rodeo",                       {466.20,-1385.00,-89.00,647.50,-1235.00,110.90}},
	{"Rodeo",                       {334.50,-1406.00,-89.00,466.20,-1292.00,110.90}},
	{"Royal Casino",                {2087.30,1383.20,-89.00,2437.30,1543.20,110.90}},
	{"San Andreas Sound",           {2450.30,385.50,-100.00,2759.20,562.30,200.00}},
	{"Santa Flora",                 {-2741.00,458.40,-7.60,-2533.00,793.40,200.00}},
	{"Santa Maria Beach",           {342.60,-2173.20,-89.00,647.70,-1684.60,110.90}},
	{"Santa Maria Beach",           {72.60,-2173.20,-89.00,342.60,-1684.60,110.90}},
	{"Shady Cabin",                 {-1632.80,-2263.40,-3.00,-1601.30,-2231.70,200.00}},
	{"Shady Creeks",                {-1820.60,-2643.60,-8.00,-1226.70,-1771.60,200.00}},
	{"Shady Creeks",                {-2030.10,-2174.80,-6.10,-1820.60,-1771.60,200.00}},
	{"Sobell Rail Yards",           {2749.90,1548.90,-89.00,2923.30,1937.20,110.90}},
	{"Spinybed",                    {2121.40,2663.10,-89.00,2498.20,2861.50,110.90}},
	{"Starfish Casino",             {2437.30,1783.20,-89.00,2685.10,2012.10,110.90}},
	{"Starfish Casino",             {2437.30,1858.10,-39.00,2495.00,1970.80,60.90}},
	{"Starfish Casino",             {2162.30,1883.20,-89.00,2437.30,2012.10,110.90}},
	{"Temple",                      {1252.30,-1130.80,-89.00,1378.30,-1026.30,110.90}},
	{"Temple",                      {1252.30,-1026.30,-89.00,1391.00,-926.90,110.90}},
	{"Temple",                      {1252.30,-926.90,-89.00,1357.00,-910.10,110.90}},
	{"Temple",                      {952.60,-1130.80,-89.00,1096.40,-937.10,110.90}},
	{"Temple",                      {1096.40,-1130.80,-89.00,1252.30,-1026.30,110.90}},
	{"Temple",                      {1096.40,-1026.30,-89.00,1252.30,-910.10,110.90}},
	{"The Camel's Toe",             {2087.30,1203.20,-89.00,2640.40,1383.20,110.90}},
	{"The Clown's Pocket",          {2162.30,1783.20,-89.00,2437.30,1883.20,110.90}},
	{"The Emerald Isle",            {2011.90,2202.70,-89.00,2237.40,2508.20,110.90}},
	{"The Farm",                    {-1209.60,-1317.10,114.90,-908.10,-787.30,251.90}},
	{"The Four Dragons Casino",     {1817.30,863.20,-89.00,2027.30,1083.20,110.90}},
	{"The High Roller",             {1817.30,1283.20,-89.00,2027.30,1469.20,110.90}},
	{"The Mako Span",               {1664.60,401.70,0.00,1785.10,567.20,200.00}},
	{"The Panopticon",              {-947.90,-304.30,-1.10,-319.60,327.00,200.00}},
	{"The Pink Swan",               {1817.30,1083.20,-89.00,2027.30,1283.20,110.90}},
	{"The Sherman Dam",             {-968.70,1929.40,-3.00,-481.10,2155.20,200.00}},
	{"The Strip",                   {2027.40,863.20,-89.00,2087.30,1703.20,110.90}},
	{"The Strip",                   {2106.70,1863.20,-89.00,2162.30,2202.70,110.90}},
	{"The Strip",                   {2027.40,1783.20,-89.00,2162.30,1863.20,110.90}},
	{"The Strip",                   {2027.40,1703.20,-89.00,2137.40,1783.20,110.90}},
	{"The Visage",                  {1817.30,1863.20,-89.00,2106.70,2011.80,110.90}},
	{"The Visage",                  {1817.30,1703.20,-89.00,2027.40,1863.20,110.90}},
	{"Unity Station",               {1692.60,-1971.80,-20.40,1812.60,-1932.80,79.50}},
	{"Valle Ocultado",              {-936.60,2611.40,2.00,-715.90,2847.90,200.00}},
	{"Verdant Bluffs",              {930.20,-2488.40,-89.00,1249.60,-2006.70,110.90}},
	{"Verdant Bluffs",              {1073.20,-2006.70,-89.00,1249.60,-1842.20,110.90}},
	{"Verdant Bluffs",              {1249.60,-2179.20,-89.00,1692.60,-1842.20,110.90}},
	{"Verdant Meadows",             {37.00,2337.10,-3.00,435.90,2677.90,200.00}},
	{"Verona Beach",                {647.70,-2173.20,-89.00,930.20,-1804.20,110.90}},
	{"Verona Beach",                {930.20,-2006.70,-89.00,1073.20,-1804.20,110.90}},
	{"Verona Beach",                {851.40,-1804.20,-89.00,1046.10,-1577.50,110.90}},
	{"Verona Beach",                {1161.50,-1722.20,-89.00,1323.90,-1577.50,110.90}},
	{"Verona Beach",                {1046.10,-1722.20,-89.00,1161.50,-1577.50,110.90}},
	{"Vinewood",                    {787.40,-1310.20,-89.00,952.60,-1130.80,110.90}},
	{"Vinewood",                    {787.40,-1130.80,-89.00,952.60,-954.60,110.90}},
	{"Vinewood",                    {647.50,-1227.20,-89.00,787.40,-1118.20,110.90}},
	{"Vinewood",                    {647.70,-1416.20,-89.00,787.40,-1227.20,110.90}},
	{"Whitewood Estates",           {883.30,1726.20,-89.00,1098.30,2507.20,110.90}},
	{"Whitewood Estates",           {1098.30,1726.20,-89.00,1197.30,2243.20,110.90}},
	{"Willowfield",                 {1970.60,-2179.20,-89.00,2089.00,-1852.80,110.90}},
	{"Willowfield",                 {2089.00,-2235.80,-89.00,2201.80,-1989.90,110.90}},
	{"Willowfield",                 {2089.00,-1989.90,-89.00,2324.00,-1852.80,110.90}},
	{"Willowfield",                 {2201.80,-2095.00,-89.00,2324.00,-1989.90,110.90}},
	{"Willowfield",                 {2541.70,-1941.40,-89.00,2703.50,-1852.80,110.90}},
	{"Willowfield",                 {2324.00,-2059.20,-89.00,2541.70,-1852.80,110.90}},
	{"Willowfield",                 {2541.70,-2059.20,-89.00,2703.50,-1941.40,110.90}},
	{"Yellow Bell Station",         {1377.40,2600.40,-21.90,1492.40,2687.30,78.00}},
	// Main Zones
	{"Los Santos",                  {44.60,-2892.90,-242.90,2997.00,-768.00,900.00}},
	{"Las Venturas",                {869.40,596.30,-242.90,2997.00,2993.80,900.00}},
	{"Bone County",                 {-480.50,596.30,-242.90,869.40,2993.80,900.00}},
	{"Tierra Robada",               {-2997.40,1659.60,-242.90,-480.50,2993.80,900.00}},
	{"Tierra Robada",               {-1213.90,596.30,-242.90,-480.50,1659.60,900.00}},
	{"San Fierro",                  {-2997.40,-1115.50,-242.90,-1213.90,1659.60,900.00}},
	{"Red County",                  {-1213.90,-768.00,-242.90,2997.00,596.30,900.00}},
	{"Flint County",                {-1213.90,-2892.90,-242.90,44.60,-768.00,900.00}},
	{"Whetstone",                   {-2997.40,-2892.90,-242.90,-1213.90,-1115.50,900.00}}
};

stock GetPlayerLocation(playerid) //Credits to Cueball, Betamaster, Mabako, and Simon (for finetuning).
{
   new OrtString[25];
   GetPlayer3DZone(playerid, OrtString, sizeof(OrtString));
   if(strlen(OrtString)==0) OrtString = "No GPS";
   return OrtString;
}

stock GetPlayer2DZone(playerid, zone[], len) //Credits to Cueball, Betamaster, Mabako, and Simon (for finetuning).
{
	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);
 	for(new i = 0; i != sizeof(gSAZones); i++ )
 	{
		if(x >= gSAZones[i][SAZONE_AREA][0] && x <= gSAZones[i][SAZONE_AREA][3] && y >= gSAZones[i][SAZONE_AREA][1] && y <= gSAZones[i][SAZONE_AREA][4])
		{
		    return format(zone, len, gSAZones[i][SAZONE_NAME], 0);
		}
	}
	return 0;
}

stock GetPlayer3DZone(playerid, zone[], len) //Credits to Cueball, Betamaster, Mabako, and Simon (for finetuning).
{
	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);
 	for(new i = 0; i != sizeof(gSAZones); i++ )
 	{
		if(x >= gSAZones[i][SAZONE_AREA][0] && x <= gSAZones[i][SAZONE_AREA][3] && y >= gSAZones[i][SAZONE_AREA][1] && y <= gSAZones[i][SAZONE_AREA][4] && z >= gSAZones[i][SAZONE_AREA][2] && z <= gSAZones[i][SAZONE_AREA][5])
		{
		    return format(zone, len, gSAZones[i][SAZONE_NAME], 0);
		}
	}
	return 0;
}

stock Get3DZone(Float:x, Float:y, Float:z, zone[], len) //Credits to Cueball, Betamaster, Mabako, and Simon (for finetuning).
{
 	for(new i = 0; i != sizeof(gSAZones); i++ )
 	{
		if(x >= gSAZones[i][SAZONE_AREA][0] && x <= gSAZones[i][SAZONE_AREA][3] && y >= gSAZones[i][SAZONE_AREA][1] && y <= gSAZones[i][SAZONE_AREA][4] && z >= gSAZones[i][SAZONE_AREA][2] && z <= gSAZones[i][SAZONE_AREA][5])
		{
		    return format(zone, len, gSAZones[i][SAZONE_NAME], 0);
		}
	}
	return 0;
}

stock Get2DPosZone(Float:x, Float:y, zone[], len)
{
 	for(new i = 0; i != sizeof(gSAZones); i++ )
 	{
		if(x >= gSAZones[i][SAZONE_AREA][0] && x <= gSAZones[i][SAZONE_AREA][3] && y >= gSAZones[i][SAZONE_AREA][1] && y <= gSAZones[i][SAZONE_AREA][4])
		{
		    return format(zone, len, gSAZones[i][SAZONE_NAME], 0);
		}
	}
	return 0;
}

stock IsPlayerInZone(playerid, zone[]) //Credits to Cueball, Betamaster, Mabako, and Simon (for finetuning).
{
	new TmpZone[MAX_ZONE_NAME];
	GetPlayer3DZone(playerid, TmpZone, sizeof(TmpZone));
	for(new i = 0; i != sizeof(gSAZones); i++)
	{
		if(strfind(TmpZone, zone, true) != -1)
			return 1;
	}
	return 0;
}
