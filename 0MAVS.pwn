///////////////////////////////////////////////Go to line 9136//////////////////////////////////////////////////////////////////////////////////////////////////////









//Tankstellenschilder bei: Tankstelle 14 entfernen!
//Tankstelle 5 und 9 remappen!!











#define Spritpreis_DIESEL 1.385
#define Spritpreis_PETROL 1.573
#define Steuer 19



//==========================================================
// 	  Advanced Vehicle System version 1.0 by MadeMan
//==========================================================

#define FILTERSCRIPT

#include <a_samp>
#include <OnVehicleTakeDamage>
#include <getvehiclecolor>
#include <dini>
#include <foreach>
#include <streamer>
#include <0SimonsInclude>
#pragma tabsize 0
#pragma dynamic 65536
#define AUTOD 4
#define PLANED 6

//=========================SETTINGS=========================

#define MAX_DVEHICLES 1000
#define MAX_DEALERSHIPS 6

#define VEHICLE_FILE_PATH "Server/Autos/"
#define BLITZER_FILE_PATH "Server/Speedcameras/"
#define DEALERSHIP_FILE_PATH "Server/Autohauser/"

#define MAX_PLAYER_VEHICLES 10
#define DEFAULT_NUMBER_PLATE "_"

#define MAX_BLITZER 50

new modshoppos = 3000;
new RainbowCarTimer1;
new RainbowCarTimer2;
new RainbowColor[MAX_VEHICLES];

//==========================================================


#define COLOR_BLACK 0x000000FF
#define COLOR_RED 0xEE0000FF
#define COLOR_GREEN 0x00CC00FF
#define COLOR_BLUE 0x0000FFFF
#define COLOR_ORANGE 0xFF6600FF
#define COLOR_YELLOW 0xFFFF00FF
#define COLOR_LIGHTBLUE 0x00FFFFFF
#define COLOR_PURPLE 0xC2A2DAFF
#define COLOR_GREY 0xC0C0C0FF
#define COLOR_WHITE 0xFFFFFFFF

#define MYVMENU 16
#define VMENU 17
#define CARKEYS 18
#define SELLCARPRICE 19
#define SELLCAR 20
#define VEHICLEINFO 21
#define SELECTMECHANICCARDIALOG 26

#define VEHICLE_DEALERSHIP 1
#define VEHICLE_PLAYER 2

#define CMD:%1(%2)          \
			forward cmd_%1(%2); \
			public cmd_%1(%2)

#define ShowErrorDialog(%1,%2) ShowPlayerDialog(%1, DIALOG_ERROR, DIALOG_STYLE_MSGBOX, "ERROR", %2, "OK", "")

enum
{
	DIALOG_NONE=12345,
	DIALOG_ERROR=12346,
	DIALOG_VEHICLE=500,
    DIALOG_VEHICLE_BUY,
	DIALOG_VEHICLE_SELL,
	DIALOG_FINDVEHICLE,
	DIALOG_TRUNK,
	DIALOG_TRUNK_ACTION,
	DIALOG_VEHICLE_PLATE,
	DIALOG_EDITVEHICLE
};

new garage1, garage2, elevator[5], state1, state2, state3; //Mehcnaikergarage
new NewCarMechanicVehicle;

//Modshop
new PlayerText:TuningEnter[MAX_PLAYERS];
new PlayerText:TuningEnter_[MAX_PLAYERS];
new PlayerText:TuningLeave[MAX_PLAYERS];
new PlayerText:TuningLeave_[MAX_PLAYERS];
new PlayerText:NextModshopItem[MAX_PLAYERS];
new PlayerText:LastModshopItem[MAX_PLAYERS];
new PlayerText:TuningBackground[MAX_PLAYERS];
new PlayerText:ModObject[MAX_PLAYERS];
new PlayerText:ModName_[MAX_PLAYERS];
new PlayerText:ModName[MAX_PLAYERS];
new PlayerText:Farbauswahl[MAX_PLAYERS][20];
new PlayerText:ModshopPreis[MAX_PLAYERS];
new PlayerText:TuningObjectBackground[MAX_PLAYERS];
new PlayerText:ModDone[MAX_PLAYERS];
new PlayerText:ModDone_[MAX_PLAYERS];
new PlayerText:Mod_Listitem1[MAX_PLAYERS];
new PlayerText:Mod_Listitem1_[MAX_PLAYERS];
new PlayerText:Mod_Listitem2[MAX_PLAYERS];
new PlayerText:Mod_Listitem2_[MAX_PLAYERS];
new PlayerText:Mod_Listitem3[MAX_PLAYERS];
new PlayerText:Mod_Listitem3_[MAX_PLAYERS];
new Text:CustomModShopObjectRight;
new Text:CustomModShopObjectLeft;
new Rainbowmodshopcartimer;
new Rainbowmodshopcolortimer;
new Float:ModObjectX, Float:ModObjectY, Float:ModObjectZ;
new Float:ModObjectrX, Float:ModObjectrY, Float:ModObjectrZ;

#define ModObjekt_0 19917//Motor
#define ModObjekt_1 1008//Nitro
#define ModObjekt_2 1009//Nitro
#define ModObjekt_3 1010//Nitro
#define ModObjekt_4 1004//Inlet
#define ModObjekt_5 1005//Inlet
#define ModObjekt_6 1011//Inlet
#define ModObjekt_7 1012//Inlet
#define ModObjekt_8 1116//slamvan grill
#define ModObjekt_9 1018//auspuff doppelrohr zusammen nach oben
#define ModObjekt_10 1021 //auspuff einfach
#define ModObjekt_11 1113//auspuff doppelrohr zusammen lowrider
#define ModObjekt_12 1114//auspuff harley style
#define ModObjekt_13 1046//auspff doppelt jdm style
#define ModObjekt_14 1045//auspff doppelt jdm style
#define ModObjekt_15 1029//auspff doppelt jdm style
#define ModObjekt_16 18649
#define ModObjekt_17 18647
#define ModObjekt_18 18648
#define ModObjekt_19 1146 //elegy spoiler

//Schlüssel
new Text:Schluessel[MAX_PLAYERS][11];
new Text:FahrzeugBild[MAX_PLAYERS];
new Text:Aufsperren[MAX_PLAYERS];
new Text:Zusperren[MAX_PLAYERS];
new Text:Aufsperren_[MAX_PLAYERS][3];
new Text:Zusperren_[MAX_PLAYERS][3];
new Text:Parken[MAX_PLAYERS];
new Text:Parken_[MAX_PLAYERS];
new Text:FahrzeugParkBild[MAX_PLAYERS];
new Text:UNDEFINED[MAX_PLAYERS];
new Text:MoreButton[MAX_PLAYERS];
new Text:VehicleName[MAX_PLAYERS];

new savetimer;
new tracktimer;
new RainbowCarTimer;

new SaveVehicleIndex;

new TrackCar[MAX_PLAYERS];
new VehicleObject[MAX_PLAYERS];
new TrackNewCar[MAX_PLAYERS];
new DialogReturn[MAX_PLAYERS];

new VehicleCreated[MAX_DVEHICLES];
new VehicleID[MAX_DVEHICLES];
new VehicleModel[MAX_DVEHICLES];
new Float:VehiclePos[MAX_DVEHICLES][4];
new VehicleColor[MAX_DVEHICLES][2];
new VehicleInterior[MAX_DVEHICLES];
new VehicleWorld[MAX_DVEHICLES];
new VehicleOwner[MAX_DVEHICLES][MAX_PLAYER_NAME];
new CarKeyOwner[MAX_DVEHICLES][MAX_PLAYER_NAME];
new VehicleNumberPlate[MAX_DVEHICLES][13];
new VehicleValue[MAX_DVEHICLES];
new VehicleLock[MAX_DVEHICLES];
new VehicleTrunk[MAX_DVEHICLES][5][2];
new VehicleMods[MAX_DVEHICLES][14];
new VehicleObjekte[MAX_DVEHICLES][15][90];
new VehiclePaintjob[MAX_DVEHICLES] = {255, ...};
new VehicleCheckEngine[MAX_DVEHICLES];
new VehicleBatteryLight[MAX_DVEHICLES];
new VehicleMileage[MAX_DVEHICLES];
new Float:VehicleFuel[MAX_DVEHICLES];
new Float:VehicleHealth[MAX_DVEHICLES];
new VehicleSpeedocolor1[MAX_DVEHICLES];
new VehicleSpeedocolor2[MAX_DVEHICLES];
new VehicleSpeedocolor3[MAX_DVEHICLES];
new Text3D:VehicleLabel[MAX_DVEHICLES];
new NVehicleLocked[MAX_VEHICLES];

new DealershipCreated[MAX_DEALERSHIPS];
new Float:DealershipPos[MAX_DEALERSHIPS][3];
new Text3D:DealershipLabel[MAX_DEALERSHIPS];

new Tankgeld[MAX_PLAYERS] = -1;
new Tanktimer;

new VehicleNames[][] = {
	"Landstalker","Bravura","Buffalo","Linerunner","Perennial","Sentinel","Dumper","Firetruck","Trashmaster","Stretch","Manana","Infernus",
	"Voodoo","Pony","Mule","Cheetah","Ambulance","Leviathan","Moonbeam","Esperanto","Taxi","Washington","Bobcat","Mr Whoopee","BF Injection",
	"Hunter","Premier","Enforcer","Securicar","Banshee","Predator","Bus","Rhino","Barracks","Hotknife","Trailer","Previon","Coach","Cabbie",
	"Stallion","Rumpo","RC Bandit","Romero","Packer","Monster","Admiral","Squalo","Seasparrow","Pizzaboy","Tram","Trailer","Turismo","Speeder",
	"Reefer","Tropic","Flatbed","Yankee","Caddy","Solair","Berkley's RC Van","Skimmer","PCJ-600","Faggio","Freeway","RC Baron","RC Raider",
	"Glendale","Oceanic","Sanchez","Sparrow","Patriot","Quad","Coastguard","Dinghy","Hermes","Sabre","Rustler","ZR 350","Walton","Regina",
	"Comet","BMX","Burrito","Camper","Marquis","Baggage","Dozer","Maverick","News Chopper","Rancher","FBI Rancher","Virgo","Greenwood",
	"Jetmax","Hotring","Sandking","Blista Compact","Police Maverick","Boxville","Benson","Mesa","RC Goblin","Hotring Racer A","Hotring Racer B",
	"Bloodring Banger","Rancher","Super GT","Elegant","Journey","Bike","Mountain Bike","Beagle","Cropdust","Stunt","Tanker","RoadTrain",
	"Nebula","Majestic","Buccaneer","Shamal","Hydra","FCR-900","NRG-500","HPV1000","Cement Truck","Tow Truck","Fortune","Cadrona","FBI Truck",
	"Willard","Forklift","Tractor","Combine","Feltzer","Remington","Slamvan","Blade","Freight","Streak","Vortex","Vincent","Bullet","Clover",
	"Sadler","Firetruck","Hustler","Intruder","Primo","Cargobob","Tampa","Sunrise","Merit","Utility","Nevada","Yosemite","Windsor","Monster A",
	"Monster B","Uranus","Jester","Sultan","Stratum","Elegy","Raindance","RC Tiger","Flash","Tahoma","Savanna","Bandito","Freight","Trailer",
	"Kart","Mower","Duneride","Sweeper","Broadway","Tornado","AT-400","DFT-30","Huntley","Stafford","BF-400","Newsvan","Tug","Trailer A","Emperor",
	"Wayfarer","Euros","Hotdog","Club","Trailer B","Trailer C","Andromada","Dodo","RC Cam","Launch","Police Car (LSPD)","Police Car (SFPD)",
	"Police Car (LVPD)","Police Ranger","Picador","S.W.A.T. Van","Alpha","Phoenix","Glendale","Sadler","Luggage Trailer A","Luggage Trailer B",
	"Stair Trailer","Boxville","Farm Plow","Utility Trailer"
};

///////////////////////////////////////////////////////////////Tacho//////////////////////////////////////////////////////////////////////////////////
new BlinkerL[MAX_VEHICLES];
new BlinkerR[MAX_VEHICLES];
new BlinkerVL[MAX_VEHICLES];
new BlinkerVR[MAX_VEHICLES];
new BlinkerHL[MAX_VEHICLES];
new BlinkerHR[MAX_VEHICLES];

new LandingGearCRTL[MAX_PLAYERS];
new Text:Tacho[MAX_PLAYERS][56];
new Text:Licht[MAX_PLAYERS][4];
new Text:Batterie[MAX_PLAYERS][6];
new Text:Motorleuchte[MAX_PLAYERS][9];
new Text:Locked[MAX_PLAYERS][4];
new PlayerText:KMH[MAX_PLAYERS];
new PlayerText:AutoHP[MAX_PLAYERS][5];
new PlayerText:Sprit[MAX_PLAYERS];
new PlayerText:Kilometerstand[MAX_PLAYERS];
new PlayerText:Tachonadel[MAX_PLAYERS];
new PlayerText:Spritnadel[MAX_PLAYERS];
new PlayerText:Tacho_Mitte[MAX_PLAYERS];
new PlayerText:Sprit_Mitte[MAX_PLAYERS];
new PlayerText:BlinkerLinks[MAX_PLAYERS][2];
new PlayerText:BlinkerRechts[MAX_PLAYERS][2];
new PlayerText:Blitz[MAX_PLAYERS];
new PlayerText:Airspeed[MAX_PLAYERS];
new PlayerText:Airspeeed[MAX_PLAYERS];
new PlayerText:Airspeedindicator[MAX_PLAYERS];
new PlayerText:Airspeeddisplay[MAX_PLAYERS];
new PlayerText:Alittudegauge[MAX_PLAYERS];
new PlayerText:Altimeter[MAX_PLAYERS];
new PlayerText:Altdisplay[MAX_PLAYERS];
new PlayerText:Tausendnadel[MAX_PLAYERS];
new PlayerText:Hundertnadel[MAX_PLAYERS];
new PlayerText:SteigtSinkt[MAX_PLAYERS];
new PlayerText:SteigtHintergrund[MAX_PLAYERS];
new PlayerText:Steigtnadel[MAX_PLAYERS];
new PlayerText:Variometer[MAX_PLAYERS];
new PlayerText:Variodisplay[MAX_PLAYERS];
new PlayerText:Altideckel[MAX_PLAYERS];
new PlayerText:Airspeeddeckel[MAX_PLAYERS];
new PlayerText:ArtHorizon[MAX_PLAYERS];
new PlayerText:CRTLboard_plane[MAX_PLAYERS];
new PlayerText:CRTLboard1_plane[MAX_PLAYERS];
new PlayerText:CRTLboard2_plane[MAX_PLAYERS];
new PlayerText:Kompass_Gauge[MAX_PLAYERS];
new PlayerText:Kompass_Hintergrund[MAX_PLAYERS];
new PlayerText:Kompass_N[MAX_PLAYERS];
new PlayerText:Kompass_E[MAX_PLAYERS];
new PlayerText:Kompass_S[MAX_PLAYERS];
new PlayerText:Kompass_W[MAX_PLAYERS];
new PlayerText:Kompass_Icon[MAX_PLAYERS];
new PlayerText:Flug_Info[MAX_PLAYERS];
new PlayerText:Flug_InfoHintergrund[MAX_PLAYERS];
new PlayerText:Abgrenzung[MAX_PLAYERS][4];
new PlayerText:RFuel[MAX_PLAYERS];
new PlayerText:LFuel[MAX_PLAYERS];
new PlayerText:Fuel1[MAX_PLAYERS];
new PlayerText:Fuel2[MAX_PLAYERS];
new PlayerText:Condition[MAX_PLAYERS];
new PlayerText:Zustand[MAX_PLAYERS];
new PlayerText:Fname[MAX_PLAYERS];
new PlayerText:Distance[MAX_PLAYERS];
new PlayerText:KMStandFlieger[MAX_PLAYERS];
new PlayerText:Fuelpumpen[MAX_PLAYERS];
new PlayerText:FPON[MAX_PLAYERS];
new PlayerText:FPOFF[MAX_PLAYERS];
new PlayerText:PEngine[MAX_PLAYERS];
new PlayerText:PEON[MAX_PLAYERS];
new PlayerText:PEOFF[MAX_PLAYERS];
new PlayerText:LDGear[MAX_PLAYERS];
new PlayerText:LDGON[MAX_PLAYERS];
new PlayerText:LDGOFF[MAX_PLAYERS];
new PlayerText:LowFuel[MAX_PLAYERS];
new PlayerText:LowFuelW[MAX_PLAYERS];


new speedotimer;
new Planespeedotimer;
new Tachonadeltimer;
new BlinkerTimer;
new Float:Fuel[MAX_VEHICLES] = {100.0,...};
new Float:Pfuel[MAX_VEHICLES] = {100.0,...};
new Float:Milage[MAX_VEHICLES] = {0.0,...};
new Float:Pdistance[MAX_VEHICLES] = {0.0,...};
new Spieler[64];
new Sname [MAX_PLAYER_NAME];

new Blitztimer;
new NBlitzertimer;

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

forward SaveTimer();

enum E_VEHICLE_DATA
{
   Float:E_VEHICLE_NEW_HEALTH,
   Float:E_VEHICLE_OLD_HEALTH
};
new vehicle[MAX_VEHICLES][E_VEHICLE_DATA];

forward OnVehicleHealthChange(vehicleid, playerid, Float:newhealth, Float:oldhealth);
public OnVehicleHealthChange(vehicleid, playerid, Float:newhealth, Float:oldhealth)
{
    if(!IsValidVehicle(GetVehicleID(vehicleid))) return 1;
    VehicleHealth[GetVehicleID(vehicleid)] = newhealth;
    if(newhealth <= 250.0)
    {
	   VehicleHealth[GetVehicleID(vehicleid)] = 250.0;
    }
    SaveVehicle(GetVehicleID(vehicleid));
    return 1;
}

public OnPlayerUpdate(playerid)
{
   if(IsPlayerInAnyVehicle(playerid) && IsPlayerInRangeOfPoint(playerid, 8, 252.9363,27.8895,2.4549))
   {
   if(state1 == 0)
      {
	     MoveDynamicObject(garage1,255.000,31.583,5.278,0.25,0.000,88.099,0.000);
		 //PlayerPlaySound(playerid, 1153, 0, 0, 0);
		 SetTimerEx("CloseMechanicGate", 10000, false, "%i", 1);
		 state1 = 1;
	  }
   }
   if(IsPlayerInAnyVehicle(playerid) && IsPlayerInRangeOfPoint(playerid, 8, 254.792,17.663,5.244))
   {
   if(state2 == 0)
      {
	     MoveDynamicObject(garage2,254.792,17.663,5.244,0.25,0.000,87.999,0.000);
		 SetTimerEx("CloseMechanicGate", 10000, false, "%i", 2);
		 state2 = 1;
	  }
   }
   new vehicleid;
   if((vehicleid = GetPlayerVehicleID(playerid)) != 0 && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
   {
      GetVehicleHealth(vehicleid, vehicle[vehicleid][E_VEHICLE_NEW_HEALTH]);
      if(vehicle[vehicleid][E_VEHICLE_NEW_HEALTH] != vehicle[vehicleid][E_VEHICLE_OLD_HEALTH])
	  {
         CallLocalFunction("OnVehicleHealthChange", "iiff", vehicleid, playerid, vehicle[vehicleid][E_VEHICLE_NEW_HEALTH], vehicle[vehicleid][E_VEHICLE_OLD_HEALTH]);
         vehicle[vehicleid][E_VEHICLE_OLD_HEALTH] = vehicle[vehicleid][E_VEHICLE_NEW_HEALTH];
      }
   }
   return 1;
}

forward Hebebuhne(playerid);
public Hebebuhne(playerid)
{
	SetPlayerPos(playerid, 267.6326,26.3754,2.4424);
	SetPlayerFacingAngle(playerid, 0);
	SetCameraBehindPlayer(playerid);
	return 1;
}

forward CloseMechanicGate(gate);
public CloseMechanicGate(gate)
{
   for(new i=0;i<MAX_PLAYERS;i++)
   if(gate == 1)
   {
      if(!IsPlayerInRangeOfPoint(i, 5, 252.9363,27.8895,2.4549))
      {
         MoveDynamicObject(garage1,253.384,31.583,3.419,0.25,0.000,0.000,0.000);
		 state1 = 0;
		 return 1;
      }
   }
   else if(gate == 2)
   {
      if(!IsPlayerInRangeOfPoint(i, 5, 254.792,17.663,5.244))
      {
         MoveDynamicObject(garage2,253.384,17.663,3.419,0.25,0.000,0.000,0.000);
		 state2 = 0;
		 return 1;
      }
   }
   return 1;
}

stock PlayerName(playerid)
{
	new pName[MAX_PLAYER_NAME];
	GetPlayerName(playerid, pName, MAX_PLAYER_NAME);
	return pName;//mit GetSname wechslen
}

stock IsPlayerSpawned(playerid)
{
	switch(GetPlayerState(playerid))
	{
		case 1,2,3: return 1;
	}
	return 0;
}

stock IsMeleeWeapon(weaponid)
{
	switch(weaponid)
	{
		case 2 .. 15, 40, 44 .. 46: return 1;
	}
	return 0;
}

stock RemovePlayerWeapon(playerid, weaponid)
{
	new WeaponData[12][2];
	for(new i=1; i < sizeof(WeaponData); i++)
	{
		GetPlayerWeaponData(playerid, i, WeaponData[i][0], WeaponData[i][1]);
	}
	ResetPlayerWeapons(playerid);
	for(new i=1; i < sizeof(WeaponData); i++)
	{
		if(WeaponData[i][0] != weaponid)
		{
			GivePlayerWeapon(playerid, WeaponData[i][0], WeaponData[i][1]);
		}
	}
}

stock IsBicycle(vehicleid)
{
	switch(GetVehicleModel(vehicleid))
	{
		case 481,509,510: return 1;
	}
	return 0;
}

stock PlayerToPlayer(playerid, targetid, Float:dist)
{
	new Float:pos[3];
	GetPlayerPos(targetid, pos[0], pos[1], pos[2]);
	return IsPlayerInRangeOfPoint(playerid, dist, pos[0], pos[1], pos[2]);
}

stock PlayerToVehicle(playerid, vehicleid, Float:dist)
{
	new Float:pos[3];
	GetVehiclePos(vehicleid, pos[0], pos[1], pos[2]);
	return IsPlayerInRangeOfPoint(playerid, dist, pos[0], pos[1], pos[2]);
}

stock GetClosestVehicle(playerid)
{
	new Float:x, Float:y, Float:z;
	new Float:dist, Float:closedist=9999, closeveh;
	for(new i=1; i < MAX_VEHICLES; i++)
	{
		if(GetVehiclePos(i, x, y, z))
		{
			dist = GetPlayerDistanceFromPoint(playerid, x, y, z);
			if(dist < closedist)
			{
				closedist = dist;
				closeveh = i;
			}
		}
	}
	return closeveh;
}

stock ToggleEngine(vehicleid, toggle)
{
	new engine, lights, alarm, doors, bonnet, boot, objective;
	GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
	SetVehicleParamsEx(vehicleid, toggle, lights, alarm, doors, bonnet, boot, objective);
}

stock ToggleBoot(vehicleid, toggle)
{
	new engine, lights, alarm, doors, bonnet, boot, objective;
	GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
	SetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, toggle, objective);
}

stock StripNL(str[]) // credits to Y_Less for y_utils.inc
{
	new
		i = strlen(str);
	while (i-- && str[i] <= ' ') str[i] = '\0';
}

stock GetVehicleModelIDFromName(const vname[])
{
	for(new i=0; i < sizeof(VehicleNames); i++)
	{
		if(strfind(VehicleNames[i], vname, true) != -1) return i + 400;
	}
	return -1;
}

LoadVehicles()
{
	new string[64];
	new File:handle, count;
	new filename[64], line[256], s, key[64];
	for(new i=1; i < MAX_DVEHICLES; i++)
	{
		format(filename, sizeof(filename), VEHICLE_FILE_PATH "v%d.ini", i);
		if(!fexist(filename)) continue;
		handle = fopen(filename, io_read);
		while(fread(handle, line))
		{
			StripNL(line);
			s = strfind(line, "=");
			if(!line[0] || s < 1) continue;
			strmid(key, line, 0, s++);
			if(strcmp(key, "Created") == 0) VehicleCreated[i] = strval(line[s]);
			else if(strcmp(key, "Model") == 0) VehicleModel[i] = strval(line[s]);
			else if(strcmp(key, "Pos") == 0) sscanf(line[s], "p,ffff", VehiclePos[i][0], VehiclePos[i][1],
				VehiclePos[i][2], VehiclePos[i][3]);
			else if(strcmp(key, "Colors") == 0) sscanf(line[s], "p,dd", VehicleColor[i][0], VehicleColor[i][1]);
			else if(strcmp(key, "Interior") == 0) VehicleInterior[i] = strval(line[s]);
			else if(strcmp(key, "VirtualWorld") == 0) VehicleWorld[i] = strval(line[s]);
			else if(strcmp(key, "Owner") == 0) strmid(VehicleOwner[i], line, s, sizeof(line));
			else if(strcmp(key, "KeyOwner") == 0) strmid(CarKeyOwner[i], line, s, sizeof(line));
			else if(strcmp(key, "NumberPlate") == 0) strmid(VehicleNumberPlate[i], line, s, sizeof(line));
			else if(strcmp(key, "Value") == 0) VehicleValue[i] = strval(line[s]);
			else if(strcmp(key, "Lock") == 0) VehicleLock[i] = strval(line[s]);
			else if(strcmp(key, "Paintjob") == 0) VehiclePaintjob[i] = strval(line[s]);
			else if(strcmp(key, "CheckEngine") == 0) VehicleCheckEngine[i] = strval(line[s]);
			else if(strcmp(key, "Batterie") == 0) VehicleBatteryLight[i] = strval(line[s]);
			else if(strcmp(key, "SpeedoColor1") == 0) VehicleSpeedocolor1[i] = strval(line[s]);
			else if(strcmp(key, "SpeedoColor2") == 0) VehicleSpeedocolor2[i] = strval(line[s]);
			else if(strcmp(key, "SpeedoColor3") == 0) VehicleSpeedocolor3[i] = strval(line[s]);
			else if(strcmp(key, "Fahrzeugstrecke") == 0) VehicleMileage[i] = strval(line[s]);
			else if(strcmp(key, "Kraftstoff") == 0) VehicleFuel[i] = strval(line[s]);
			else if(strcmp(key, "Zustand") == 0) VehicleHealth[i] = strval(line[s]);
			else
			{
			    if(VehicleCreated[i] != VEHICLE_DEALERSHIP)
			    {
				   for(new t=0; t < sizeof(VehicleTrunk[]); t++)
				   {
				      format(string, sizeof(string), "Trunk%d", t+1);
					  if(strcmp(key, string) == 0) sscanf(line[s], "p,dd", VehicleTrunk[i][t][0], VehicleTrunk[i][t][1]);
				   }
				   for(new m=0; m < sizeof(VehicleMods[]); m++)
				   {
					  format(string, sizeof(string), "Mod%d", m);
					  if(strcmp(key, string) == 0) VehicleMods[i][m] = strval(line[s]);
				   }
				   for(new o=0; o < sizeof(VehicleObjekte[]); o++)
				   {
					  format(string, sizeof(string), "Objekte%d", o);
					  if(strcmp(key, string) == 0) strmid(VehicleObjekte[i][o], line, s, sizeof(line));if(i == 35){/*printf(line);*/}//Was ist hier
				   }
			    }
			}
	        if(VehicleCreated[i] == VEHICLE_DEALERSHIP)
	        {
               VehicleFuel[i] = 1;
               VehicleHealth[i] = 1000;
		    }
		}
		fclose(handle);
		if(VehicleCreated[i]) count++;
	}
	printf("  Loaded %d vehicles", count);
}

SaveVehicle(vehicleid)
{
	new filename[64], line[256];
	format(filename, sizeof(filename), VEHICLE_FILE_PATH "v%d.ini", vehicleid);
	new File:handle = fopen(filename, io_write);
	format(line, sizeof(line), "Created=%d\r\n", VehicleCreated[vehicleid]); fwrite(handle, line);
	format(line, sizeof(line), "Model=%d\r\n", VehicleModel[vehicleid]); fwrite(handle, line);
	format(line, sizeof(line), "Pos=%.3f,%.3f,%.3f,%.3f\r\n", VehiclePos[vehicleid][0], VehiclePos[vehicleid][1],
		VehiclePos[vehicleid][2], VehiclePos[vehicleid][3]);
	fwrite(handle, line);
	format(line, sizeof(line), "Colors=%d,%d\r\n", VehicleColor[vehicleid][0], VehicleColor[vehicleid][1]); fwrite(handle, line);
	format(line, sizeof(line), "Interior=%d\r\n", VehicleInterior[vehicleid]); fwrite(handle, line);
	format(line, sizeof(line), "VirtualWorld=%d\r\n", VehicleWorld[vehicleid]); fwrite(handle, line);
	format(line, sizeof(line), "Owner=%s\r\n", VehicleOwner[vehicleid]); fwrite(handle, line);
	format(line, sizeof(line), "KeyOwner=%s\r\n", CarKeyOwner[vehicleid]); fwrite(handle, line);
	format(line, sizeof(line), "NumberPlate=%s\r\n", VehicleNumberPlate[vehicleid]); fwrite(handle, line);
	format(line, sizeof(line), "Value=%d\r\n", VehicleValue[vehicleid]); fwrite(handle, line);
	format(line, sizeof(line), "Lock=%d\r\n", VehicleLock[vehicleid]); fwrite(handle, line);
	format(line, sizeof(line), "Paintjob=%d\r\n", VehiclePaintjob[vehicleid]); fwrite(handle, line);
	format(line, sizeof(line), "CheckEngine=%d\r\n", VehicleCheckEngine[vehicleid]); fwrite(handle, line);
	format(line, sizeof(line), "Batterie=%d\r\n", VehicleBatteryLight[vehicleid]); fwrite(handle, line);
	format(line, sizeof(line), "SpeedoColor1=%d\r\n", VehicleSpeedocolor1[vehicleid]); fwrite(handle, line);
	format(line, sizeof(line), "SpeedoColor2=%d\r\n", VehicleSpeedocolor2[vehicleid]); fwrite(handle, line);
	format(line, sizeof(line), "SpeedoColor3=%d\r\n", VehicleSpeedocolor3[vehicleid]); fwrite(handle, line);
	format(line, sizeof(line), "Fahrzeugstrecke=%d\r\n", VehicleMileage[vehicleid]); fwrite(handle, line);
	format(line, sizeof(line), "Kraftstoff=%f\r\n", VehicleFuel[vehicleid]); fwrite(handle, line);
	format(line, sizeof(line), "Zustand=%f\r\n", VehicleHealth[vehicleid]); fwrite(handle, line);
	for(new t=0; t < sizeof(VehicleTrunk[]); t++)
	{
		format(line, sizeof(line), "Trunk%d=%d,%d\r\n", t+1, VehicleTrunk[vehicleid][t][0], VehicleTrunk[vehicleid][t][1]);
		fwrite(handle, line);
	}
	for(new m=0; m < sizeof(VehicleMods[]); m++)
	{
		format(line, sizeof(line), "Mod%d=%d\r\n", m, VehicleMods[vehicleid][m]);
		fwrite(handle, line);
	}
	for(new o=0; o < sizeof(VehicleObjekte[]); o++)
	{
		format(line, sizeof(line), "Objekte%d=%s\r\n", o, VehicleObjekte[vehicleid][o]);
		fwrite(handle, line);
	}
	fclose(handle);
}

UpdateVehicle(vehicleid, removeold)
{
	if(VehicleCreated[vehicleid])
	{
		if(removeold)
		{
			new engine, lights, alarm, doors, bonnet, boot, objective;
			GetVehicleParamsEx(VehicleID[vehicleid], engine, lights, alarm, doors, bonnet, boot, objective);
			new panels, doorsd, lightsd, tires;
			GetVehicleDamageStatus(VehicleID[vehicleid], panels, doorsd, lightsd, tires);
			DestroyVehicle(VehicleID[vehicleid]);
			VehicleID[vehicleid] = CreateVehicle(VehicleModel[vehicleid], VehiclePos[vehicleid][0], VehiclePos[vehicleid][1],
				VehiclePos[vehicleid][2], VehiclePos[vehicleid][3], VehicleColor[vehicleid][0], VehicleColor[vehicleid][1], 3600);
			SetVehicleHealth(VehicleID[vehicleid], VehicleHealth[vehicleid]);
			SetVehicleParamsEx(VehicleID[vehicleid], engine, lights, alarm, doors, bonnet, boot, objective);
			UpdateVehicleDamageStatus(VehicleID[vehicleid], panels, doorsd, lightsd, tires);
		}
		else
		{
	       VehicleID[vehicleid] = CreateVehicle(VehicleModel[vehicleid], VehiclePos[vehicleid][0], VehiclePos[vehicleid][1],
	       VehiclePos[vehicleid][2], VehiclePos[vehicleid][3], VehicleColor[vehicleid][0], VehicleColor[vehicleid][1], 3600);
		}
		LinkVehicleToInterior(VehicleID[vehicleid], VehicleInterior[vehicleid]);
		SetVehicleVirtualWorld(VehicleID[vehicleid], VehicleWorld[vehicleid]);
		SetVehicleNumberPlate(VehicleID[vehicleid], VehicleNumberPlate[vehicleid]);
		for(new i=0; i < sizeof(VehicleMods[]); i++)
		{
			AddVehicleComponent(VehicleID[vehicleid], VehicleMods[vehicleid][i]);
		}
		ChangeVehiclePaintjob(VehicleID[vehicleid], VehiclePaintjob[vehicleid]);
		UpdateVehicleLabel(vehicleid, removeold);
	    OnVehicleSpawn(vehicleid);
		for(new o=0; o < sizeof(VehicleObjekte[]); o++)
		{
			new string[35];
			new objectid, Float:X, Float:Y, Float:Z;
			sscanf(VehicleObjekte[vehicleid][o], "ifff", objectid, X, Y, Z);
			if(objectid != 0)
			{
			   new object = CreateObject(objectid, 4001, 4001, 4001, 0, 0, 0);
               SetObjectNoCameraCol(object);
			   AttachObjectToVehicle(object, VehicleID[vehicleid], X, Y, Z, 0, 0, 0);
	           SetVehicleHealth(vehicleid, VehicleHealth[vehicleid]);
			   format(string, sizeof string, "%i: %i, %f, %f, %f", o, objectid, X, Y, Z);
			   printf(string);
			}
		}
	}
	return 0;
}

forward TrackPlayerCar(playerid);
public TrackPlayerCar(playerid)
{
			if(TrackNewCar[playerid])
			{
                SetVehicleParamsForPlayer(TrackNewCar[playerid], playerid, 1, 0);
			}
			if(TrackCar[playerid])
			{
				new Float:x, Float:y, Float:z;
				GetVehiclePos(TrackCar[playerid], x, y, z);
				SetPlayerCheckpoint(playerid, x, y, z, 3);
			}
		    return 1;
}

UpdateVehicleLabel(vehicleid, removeold)
{
	if(VehicleCreated[vehicleid] == VEHICLE_DEALERSHIP)
	{
		if(removeold)
		{
			Delete3DTextLabel(VehicleLabel[vehicleid]);
		}
		new labeltext[128];
		format(labeltext, sizeof(labeltext), "%s\nPrice: $%d\nHighspeed: %d km/h\nFuel: %s\nSeats: %i", VehicleNames[VehicleModel[vehicleid]-400], VehicleValue[vehicleid],
		GetVehicleMaxSpeed(GetVehicleModel(vehicleid)),GetVehicleFuelType(GetVehicleModel(vehicleid)),GetVehicleSeats(GetVehicleModel(vehicleid)));
		VehicleLabel[vehicleid] = Create3DTextLabel(labeltext, 0xBB7700DD, 0, 0, 0, 10.0, 0);
		Attach3DTextLabelToVehicle(VehicleLabel[vehicleid], VehicleID[vehicleid], 0, 0, 0);
	}
}

IsValidVehicle(vehicleid)
{
	if(vehicleid < 1 || vehicleid >= MAX_DVEHICLES) return 0;
	if(VehicleCreated[vehicleid]) return 1;
	return 0;
}

GetFreeVehicleID()
{
	for(new i=1; i < MAX_DVEHICLES; i++)
	{
		if(!VehicleCreated[i]) return i;
	}
	return 0;
}

GetVehicleID(vehicleid)
{
	for(new i=1; i < MAX_DVEHICLES; i++)
	{
		if(VehicleCreated[i] && VehicleID[i] == vehicleid) return i;
	}
	return 0;
}

GetPlayerVehicles(playerid)
{
	new playername[24];
	GetPlayerName(playerid, playername, sizeof(playername));
	new count;
	for(new i=1; i < MAX_DVEHICLES; i++)
	{
		if(VehicleCreated[i] == VEHICLE_PLAYER && strcmp(VehicleOwner[i], playername) == 0)
		{
			count++;
		}
	}
	return count;
}

GetPlayerVehicleAccess(playerid, vehicleid)
{
	if(IsValidVehicle(vehicleid))
	{
		if(VehicleCreated[vehicleid] == VEHICLE_DEALERSHIP)
		{
			if(IsPlayerAdmin(playerid))
			{
				return 1;
			}
		}
		else if(VehicleCreated[vehicleid] == VEHICLE_PLAYER)
		{
			if(strcmp(VehicleOwner[vehicleid], PlayerName(playerid)) == 0)
			{
				return 2;
			}
			if(strcmp(CarKeyOwner[vehicleid], PlayerName(playerid)) == 0)
			{
				return 2;
			}
		}
	}
	else
	{
		return 1;
	}
	return 0;
}

LoadDealerships()
{
	new File:handle, count;
	new filename[64], line[256], s, key[64];
	for(new i=1; i < MAX_DEALERSHIPS; i++)
	{
		format(filename, sizeof(filename), DEALERSHIP_FILE_PATH "d%d.ini", i);
		if(!fexist(filename)) continue;
		handle = fopen(filename, io_read);
		while(fread(handle, line))
		{
			StripNL(line);
			s = strfind(line, "=");
			if(!line[0] || s < 1) continue;
			strmid(key, line, 0, s++);
			if(strcmp(key, "Created") == 0) DealershipCreated[i] = strval(line[s]);
			else if(strcmp(key, "Pos") == 0) sscanf(line[s], "p,fff", DealershipPos[i][0],
				DealershipPos[i][1], DealershipPos[i][2]);
		}
		fclose(handle);
		if(DealershipCreated[i]) count++;
	}
	printf("  Loaded %d dealerships", count);
}

SaveDealership(dealerid)
{
	new filename[64], line[256];
	format(filename, sizeof(filename), DEALERSHIP_FILE_PATH "d%d.ini", dealerid);
	new File:handle = fopen(filename, io_write);
	format(line, sizeof(line), "Created=%d\r\n", DealershipCreated[dealerid]); fwrite(handle, line);
	format(line, sizeof(line), "Pos=%.3f,%.3f,%.3f\r\n", DealershipPos[dealerid][0],
		DealershipPos[dealerid][1], DealershipPos[dealerid][2]);
	fwrite(handle, line);
	fclose(handle);
}

UpdateDealership(dealerid, removeold)
{
	if(DealershipCreated[dealerid])
	{
		if(removeold)
		{
			Delete3DTextLabel(DealershipLabel[dealerid]);
		}
		new labeltext[32];
		format(labeltext, sizeof(labeltext), "Vehicle Dealership\nID: %d", dealerid);
		DealershipLabel[dealerid] = Create3DTextLabel(labeltext, 0x00BB00DD, DealershipPos[dealerid][0],
			DealershipPos[dealerid][1], DealershipPos[dealerid][2]+0.5, 20.0, 0);
	}
}

IsValidDealership(dealerid)
{
	if(dealerid < 1 || dealerid >= MAX_DEALERSHIPS) return 0;
	if(DealershipCreated[dealerid]) return 1;
	return 0;
}

public SaveTimer()
{
	SaveVehicleIndex++;
	if(SaveVehicleIndex >= MAX_DVEHICLES) SaveVehicleIndex = 1;
	if(IsValidVehicle(SaveVehicleIndex)) SaveVehicle(SaveVehicleIndex);
}

/*forward GetVehicleIDFromPlate(Plate[]);
public GetVehicleIDFromPlate(Plate[])
{
    for(new i=1; i < MAX_DVEHICLES; i++)
    {
        if(VehicleCreated[i] == VEHICLE_PLAYER && strcmp(VehicleNumberPlate[i], Plate) == 0)
        {
            return i;
        }
    }
    return 0;
}*/

public OnFilterScriptInit()
{
	LoadVehicles();
	LoadDealerships();

	for(new i=0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
			OnPlayerConnect(i);
		}
	}
	for(new i=1; i < MAX_DVEHICLES; i++)
	{
		UpdateVehicle(i, 0);
	}
	for(new i=1; i < MAX_DEALERSHIPS; i++)
	{
		UpdateDealership(i, 0);
	}

    savetimer = SetTimer("SaveTimer", 2222, true);
    
	new tmpobjid;
	CreateVehicle(525,255.779,37.085,2.327,273.444,2,0,-1);
    CreateVehicle(402,244.676,17.317,2.388,181.559,10,0,-1);
	//////////////////////////////Werkstatt////////////////////////////////////////////////////////////////
	tmpobjid = CreateDynamicObject(19447,253.384,26.360,2.193,90.000,0.000,0.000,-1,-1,-1,600.000,600.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 9507, "boxybld2_sfw", "gz_vic4e", 0);
	tmpobjid = CreateDynamicObject(19379,258.247,29.775,1.356,0.000,90.000,90.000,-1,-1,-1,600.000,600.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 12844, "cos_liquorstore", "b_wtilesreflect", 0);
	tmpobjid = CreateDynamicObject(19379,267.867,29.775,1.356,0.000,90.000,90.000,-1,-1,-1,600.000,600.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 12844, "cos_liquorstore", "b_wtilesreflect", 0);
	tmpobjid = CreateDynamicObject(19379,267.867,19.335,1.356,0.000,90.000,90.000,-1,-1,-1,600.000,600.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 12844, "cos_liquorstore", "b_wtilesreflect", 0);
	tmpobjid = CreateDynamicObject(19379,258.267,19.335,1.356,0.000,90.000,90.000,-1,-1,-1,600.000,600.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 12844, "cos_liquorstore", "b_wtilesreflect", 0);
	tmpobjid = CreateDynamicObject(19379,267.867,8.865,1.356,0.000,90.000,90.000,-1,-1,-1,600.000,600.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 12844, "cos_liquorstore", "b_wtilesreflect", 0);
	tmpobjid = CreateDynamicObject(19447,253.384,22.870,2.193,90.000,0.000,0.000,-1,-1,-1,600.000,600.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 9507, "boxybld2_sfw", "gz_vic4e", 0);
	tmpobjid = CreateDynamicObject(19428,253.379,29.843,6.202,90.000,0.000,0.000,-1,-1,-1,600.000,600.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 9507, "boxybld2_sfw", "gz_vic4e", 0);
	tmpobjid = CreateDynamicObject(19447,255.074,14.140,2.193,90.000,0.000,90.000,-1,-1,-1,600.000,600.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 9507, "boxybld2_sfw", "gz_vic4e", 0);
	tmpobjid = CreateDynamicObject(19447,258.523,14.140,2.193,90.000,0.000,90.000,-1,-1,-1,600.000,600.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 9507, "boxybld2_sfw", "gz_vic4e", 0);
	tmpobjid = CreateDynamicObject(19447,261.973,14.140,2.193,90.000,0.000,90.000,-1,-1,-1,600.000,600.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 9507, "boxybld2_sfw", "gz_vic4e", 0);
	tmpobjid = CreateDynamicObject(19447,255.053,35.130,2.193,90.000,0.000,90.000,-1,-1,-1,600.000,600.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 9507, "boxybld2_sfw", "gz_vic4e", 0);
	tmpobjid = CreateDynamicObject(19447,258.554,35.130,2.193,90.000,0.000,90.000,-1,-1,-1,600.000,600.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 9507, "boxybld2_sfw", "gz_vic4e", 0);
	tmpobjid = CreateDynamicObject(19447,262.043,35.130,2.193,90.000,0.000,90.000,-1,-1,-1,600.000,600.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 9507, "boxybld2_sfw", "gz_vic4e", 0);
	tmpobjid = CreateDynamicObject(19447,265.533,35.130,2.193,90.000,0.000,90.000,-1,-1,-1,600.000,600.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 9507, "boxybld2_sfw", "gz_vic4e", 0);
	tmpobjid = CreateDynamicObject(19447,269.023,35.130,2.193,90.000,0.000,90.000,-1,-1,-1,600.000,600.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 9507, "boxybld2_sfw", "gz_vic4e", 0);
	tmpobjid = CreateDynamicObject(19447,271.093,35.130,2.193,90.000,0.000,90.000,-1,-1,-1,600.000,600.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 9507, "boxybld2_sfw", "gz_vic4e", 0);
	tmpobjid = CreateDynamicObject(19447,272.763,33.440,2.193,90.000,0.000,180.000,-1,-1,-1,600.000,600.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 9507, "boxybld2_sfw", "gz_vic4e", 0);
	tmpobjid = CreateDynamicObject(19447,272.763,29.970,2.193,90.000,0.000,180.000,-1,-1,-1,600.000,600.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 9507, "boxybld2_sfw", "gz_vic4e", 0);
	tmpobjid = CreateDynamicObject(19447,272.763,26.480,2.193,90.000,0.000,180.000,-1,-1,-1,600.000,600.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 9507, "boxybld2_sfw", "gz_vic4e", 0);
	tmpobjid = CreateDynamicObject(19447,272.763,22.990,2.193,90.000,0.000,180.000,-1,-1,-1,600.000,600.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 9507, "boxybld2_sfw", "gz_vic4e", 0);
	tmpobjid = CreateDynamicObject(19447,272.763,19.510,2.193,90.000,0.000,180.000,-1,-1,-1,600.000,600.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 9507, "boxybld2_sfw", "gz_vic4e", 0);
	tmpobjid = CreateDynamicObject(19447,272.763,16.010,2.193,90.000,0.000,180.000,-1,-1,-1,600.000,600.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 9507, "boxybld2_sfw", "gz_vic4e", 0);
	tmpobjid = CreateDynamicObject(19428,265.429,14.133,6.202,90.000,0.000,90.000,-1,-1,-1,600.000,600.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 9507, "boxybld2_sfw", "gz_vic4e", 0);
	tmpobjid = CreateDynamicObject(19428,268.899,14.133,6.202,90.000,0.000,90.000,-1,-1,-1,600.000,600.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 9507, "boxybld2_sfw", "gz_vic4e", 0);
	tmpobjid = CreateDynamicObject(19428,271.049,14.163,6.202,90.000,0.699,90.000,-1,-1,-1,600.000,600.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 9507, "boxybld2_sfw", "gz_vic4e", 0);
	tmpobjid = CreateDynamicObject(19428,253.379,19.463,6.202,90.000,0.000,0.000,-1,-1,-1,600.000,600.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 9507, "boxybld2_sfw", "gz_vic4e", 0);
	tmpobjid = CreateDynamicObject(19428,253.379,15.973,6.202,90.000,0.000,0.000,-1,-1,-1,600.000,600.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 9507, "boxybld2_sfw", "gz_vic4e", 0);
	tmpobjid = CreateDynamicObject(19428,253.379,33.333,6.202,90.000,0.000,0.000,-1,-1,-1,600.000,600.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 9507, "boxybld2_sfw", "gz_vic4e", 0);
	tmpobjid = CreateDynamicObject(19379,258.267,19.335,6.906,0.000,90.000,90.000,-1,-1,-1,600.000,600.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 17298, "weefarmcuntw", "sjmscruffhut4", 0);
	tmpobjid = CreateDynamicObject(19379,267.897,19.335,6.906,0.000,90.000,90.000,-1,-1,-1,600.000,600.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 17298, "weefarmcuntw", "sjmscruffhut4", 0);
	tmpobjid = CreateDynamicObject(19379,267.897,29.805,6.906,0.000,90.000,90.000,-1,-1,-1,600.000,600.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 17298, "weefarmcuntw", "sjmscruffhut4", 0);
	tmpobjid = CreateDynamicObject(19379,258.277,29.805,6.906,0.000,90.000,90.000,-1,-1,-1,600.000,600.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 17298, "weefarmcuntw", "sjmscruffhut4", 0);
	tmpobjid = CreateDynamicObject(19379,267.867,8.865,4.846,0.000,90.000,90.000,-1,-1,-1,600.000,600.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 17298, "weefarmcuntw", "sjmscruffhut4", 0);
	tmpobjid = CreateDynamicObject(19428,271.049,14.163,5.652,90.000,0.699,90.000,-1,-1,-1,600.000,600.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 9507, "boxybld2_sfw", "gz_vic4e", 0);
	tmpobjid = CreateDynamicObject(19428,268.899,14.133,5.652,90.000,0.000,90.000,-1,-1,-1,600.000,600.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 9507, "boxybld2_sfw", "gz_vic4e", 0);
	tmpobjid = CreateDynamicObject(19428,265.429,14.133,5.652,90.000,0.000,90.000,-1,-1,-1,600.000,600.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 9507, "boxybld2_sfw", "gz_vic4e", 0);
	tmpobjid = CreateDynamicObject(19866,253.346,32.735,6.967,0.000,0.000,0.000,-1,-1,-1,600.000,600.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 6284, "bev_law2", "pierbild04_law", 0);
	tmpobjid = CreateDynamicObject(19866,253.346,27.755,6.967,0.000,0.000,0.000,-1,-1,-1,600.000,600.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 6284, "bev_law2", "pierbild04_law", 0);
	tmpobjid = CreateDynamicObject(19866,253.346,22.765,6.967,0.000,0.000,0.000,-1,-1,-1,600.000,600.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 6284, "bev_law2", "pierbild04_law", 0);
	tmpobjid = CreateDynamicObject(19866,253.346,17.835,6.967,0.000,0.000,0.000,-1,-1,-1,600.000,600.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 6284, "bev_law2", "pierbild04_law", 0);
	tmpobjid = CreateDynamicObject(19866,253.346,16.545,6.967,0.000,0.000,0.000,-1,-1,-1,600.000,600.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 6284, "bev_law2", "pierbild04_law", 0);
	tmpobjid = CreateDynamicObject(19866,255.756,14.075,6.967,0.000,0.000,90.000,-1,-1,-1,600.000,600.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 6284, "bev_law2", "pierbild04_law", 0);
	tmpobjid = CreateDynamicObject(19866,260.726,14.075,6.967,0.000,0.000,90.000,-1,-1,-1,600.000,600.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 6284, "bev_law2", "pierbild04_law", 0);
	tmpobjid = CreateDynamicObject(19866,265.706,14.075,6.967,0.000,0.000,90.000,-1,-1,-1,600.000,600.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 6284, "bev_law2", "pierbild04_law", 0);
	tmpobjid = CreateDynamicObject(19866,270.296,14.075,6.967,0.000,0.000,90.000,-1,-1,-1,600.000,600.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 6284, "bev_law2", "pierbild04_law", 0);
	tmpobjid = CreateDynamicObject(19866,272.766,16.495,6.967,0.000,0.000,180.000,-1,-1,-1,600.000,600.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 6284, "bev_law2", "pierbild04_law", 0);
	tmpobjid = CreateDynamicObject(19866,272.766,21.475,6.967,0.000,0.000,180.000,-1,-1,-1,600.000,600.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 6284, "bev_law2", "pierbild04_law", 0);
	tmpobjid = CreateDynamicObject(19866,272.766,26.465,6.967,0.000,0.000,180.000,-1,-1,-1,600.000,600.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 6284, "bev_law2", "pierbild04_law", 0);
	tmpobjid = CreateDynamicObject(19866,272.766,31.435,6.967,0.000,0.000,180.000,-1,-1,-1,600.000,600.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 6284, "bev_law2", "pierbild04_law", 0);
	tmpobjid = CreateDynamicObject(19866,272.766,32.725,6.967,0.000,0.000,180.000,-1,-1,-1,600.000,600.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 6284, "bev_law2", "pierbild04_law", 0);
	tmpobjid = CreateDynamicObject(19866,270.366,35.135,6.967,0.000,0.000,270.000,-1,-1,-1,600.000,600.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 6284, "bev_law2", "pierbild04_law", 0);
	tmpobjid = CreateDynamicObject(19866,265.376,35.135,6.967,0.000,0.000,270.000,-1,-1,-1,600.000,600.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 6284, "bev_law2", "pierbild04_law", 0);
	tmpobjid = CreateDynamicObject(19866,260.406,35.135,6.967,0.000,0.000,270.000,-1,-1,-1,600.000,600.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 6284, "bev_law2", "pierbild04_law", 0);
	tmpobjid = CreateDynamicObject(19866,255.746,35.135,6.967,0.000,0.000,270.000,-1,-1,-1,600.000,600.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 6284, "bev_law2", "pierbild04_law", 0);
	tmpobjid = CreateDynamicObject(19866,263.066,11.575,4.886,0.000,0.000,0.000,-1,-1,-1,600.000,600.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 6284, "bev_law2", "pierbild04_law", 0);
	tmpobjid = CreateDynamicObject(19866,263.066,7.145,4.886,0.000,0.000,0.000,-1,-1,-1,600.000,600.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 6284, "bev_law2", "pierbild04_law", 0);
	tmpobjid = CreateDynamicObject(19866,263.066,5.935,4.886,0.000,0.000,0.000,-1,-1,-1,600.000,600.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 6284, "bev_law2", "pierbild04_law", 0);
	tmpobjid = CreateDynamicObject(19866,263.066,5.935,4.886,0.000,0.000,0.000,-1,-1,-1,600.000,600.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 6284, "bev_law2", "pierbild04_law", 0);
	tmpobjid = CreateDynamicObject(19866,265.476,3.455,4.886,0.000,0.000,90.000,-1,-1,-1,600.000,600.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 6284, "bev_law2", "pierbild04_law", 0);
	tmpobjid = CreateDynamicObject(19866,270.186,3.455,4.886,0.000,0.000,90.000,-1,-1,-1,600.000,600.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 6284, "bev_law2", "pierbild04_law", 0);
	tmpobjid = CreateDynamicObject(19866,272.626,5.875,4.886,0.000,0.000,180.000,-1,-1,-1,600.000,600.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 6284, "bev_law2", "pierbild04_law", 0);
	tmpobjid = CreateDynamicObject(19866,272.626,9.845,4.886,0.000,0.000,180.000,-1,-1,-1,600.000,600.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 6284, "bev_law2", "pierbild04_law", 0);
	tmpobjid = CreateDynamicObject(19866,272.626,11.615,4.886,0.000,0.000,180.000,-1,-1,-1,600.000,600.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 6284, "bev_law2", "pierbild04_law", 0);
	tmpobjid = CreateDynamicObject(19482,253.435,31.879,9.261,0.000,0.000,180.000,-1,-1,-1,600.000,600.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 11301, "carshow_sfse", "ws_Transfender_dirty", 0);
	tmpobjid = CreateDynamicObject(19482,253.435,17.639,9.261,0.000,0.000,180.000,-1,-1,-1,600.000,600.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 10375, "subshops_sfs", "ws_archangels_dirty", 0);
	tmpobjid = CreateDynamicObject(19482,253.264,24.729,4.061,0.000,0.000,180.000,-1,-1,-1,600.000,600.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 13598, "destructo", "sunshinebillboard", 0);
	tmpobjid = CreateDynamicObject(19478,253.290,27.881,3.099,0.000,0.000,180.000,-1,-1,-1,600.000,600.000);
	SetDynamicObjectMaterialText(tmpobjid, 0, "Garage 1\nPress ALT_L", 60, "Ariel", 25, 1, -16777216, -1, 1);
	tmpobjid = CreateDynamicObject(19478,253.290,21.401,3.099,0.000,0.000,180.000,-1,-1,-1,600.000,600.000);
	SetDynamicObjectMaterialText(tmpobjid, 0, "Garage 2\nPress ALT_L", 60, "Ariel", 25, 1, -16777216, -1, 1);
	tmpobjid = CreateDynamicObject(19817,266.395,19.421,1.426,0.000,0.000,270.000,-1,-1,-1,600.000,600.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 16640, "a51", "ventb128", 0);
	tmpobjid = CreateDynamicObject(2960,267.498,27.480,2.282,0.000,90.000,180.000,-1,-1,-1,600.000,600.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 16322, "a51_stores", "dam_gencrane", 0);
	tmpobjid = CreateDynamicObject(2960,267.498,31.490,2.282,0.000,90.000,180.000,-1,-1,-1,600.000,600.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 16322, "a51_stores", "dam_gencrane", 0);
	tmpobjid = CreateDynamicObject(2960,267.628,27.320,2.282,0.000,90.000,270.000,-1,-1,-1,600.000,600.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 16640, "a51", "ventb128", 0);
	tmpobjid = CreateDynamicObject(2960,267.628,31.340,2.282,0.000,90.000,270.000,-1,-1,-1,600.000,600.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 16640, "a51", "ventb128", 0);
	elevator[0] = CreateDynamicObject(19867,266.948,28.492,1.502,630.000,0.000,580.000,-1,-1,-1,600.000,600.000);
	SetDynamicObjectMaterial(elevator[0], 0, 5150, "wiresetc_las2", "ganggraf01_LA_m", 0);
	SetDynamicObjectMaterial(elevator[0], 1, 5150, "wiresetc_las2", "ganggraf01_LA_m", 0);
	SetDynamicObjectMaterial(elevator[0], 2, 16640, "a51", "sl_metalwalk", 0);
	elevator[1] = CreateDynamicObject(19867,268.353,28.504,1.502,630.000,0.000,500.000,-1,-1,-1,600.000,600.000);
	SetDynamicObjectMaterial(elevator[1], 0, 5150, "wiresetc_las2", "ganggraf01_LA_m", 0);
	SetDynamicObjectMaterial(elevator[1], 1, 5150, "wiresetc_las2", "ganggraf01_LA_m", 0);
	SetDynamicObjectMaterial(elevator[1], 2, 16640, "a51", "sl_metalwalk", 0);
	elevator[2] = CreateDynamicObject(19867,266.926,30.458,1.502,630.000,0.000,680.000,-1,-1,-1,600.000,600.000);
	SetDynamicObjectMaterial(elevator[2], 0, 5150, "wiresetc_las2", "ganggraf01_LA_m", 0);
	SetDynamicObjectMaterial(elevator[2], 1, 5150, "wiresetc_las2", "ganggraf01_LA_m", 0);
	SetDynamicObjectMaterial(elevator[2], 2, 16640, "a51", "sl_metalwalk", 0);
	elevator[3] = CreateDynamicObject(19867,268.316,30.450,1.502,630.000,0.000,760.000,-1,-1,-1,600.000,600.000);
	SetDynamicObjectMaterial(elevator[3], 0, 5150, "wiresetc_las2", "ganggraf01_LA_m", 0);
	SetDynamicObjectMaterial(elevator[3], 1, 5150, "wiresetc_las2", "ganggraf01_LA_m", 0);
	SetDynamicObjectMaterial(elevator[3], 2, 16640, "a51", "sl_metalwalk", 0);
	elevator[4] = CreateDynamicObject(19860, 266.883117, 29.410875, 1.473332, -89.499977, 0.000000, 0.000000, -1, -1, -1, 900.00, 900.00);
	SetDynamicObjectMaterial(elevator[0], 0, 5150, "wiresetc_las2", "ganggraf01_LA_m", 0);
	SetDynamicObjectMaterial(elevator[0], 1, 5150, "wiresetc_las2", "ganggraf01_LA_m", 0);
	SetDynamicObjectMaterial(elevator[0], 2, 16640, "a51", "sl_metalwalk", 0);
	tmpobjid = CreateDynamicObject(2960,267.598,29.500,1.092,0.000,180.000,270.000,-1,-1,-1,600.000,600.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 16322, "a51_stores", "dam_gencrane", 0);
	tmpobjid = CreateDynamicObject(3761,271.681,8.696,2.662,0.000,0.000,540.000,-1,-1,-1,600.000,600.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 5150, "wiresetc_las2", "ganggraf01_LA_m", 0);
	tmpobjid = CreateDynamicObject(19087,264.178,10.662,2.182,0.000,90.000,270.000,-1,-1,-1,600.000,600.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 16640, "a51", "sl_metalwalk", 0);
	tmpobjid = CreateDynamicObject(2976,271.741,9.809,2.462,-43.599,92.100,225.000,-1,-1,-1,600.000,600.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0);
	SetDynamicObjectMaterial(tmpobjid, 1, 16640, "a51", "ventb128", 0);
	tmpobjid = CreateDynamicObject(3082,271.550,9.752,3.212,90.000,0.000,0.000,-1,-1,-1,600.000,600.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 16640, "a51", "ventb64", 0);
	tmpobjid = CreateDynamicObject(3082,271.990,9.752,3.212,90.000,0.000,0.000,-1,-1,-1,600.000,600.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 16640, "a51", "ventb64", 0);
	tmpobjid = CreateDynamicObject(3082,271.740,9.752,3.392,90.000,0.000,0.000,-1,-1,-1,600.000,600.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 16640, "a51", "ventb64", 0);
	tmpobjid = CreateDynamicObject(3082,271.738,9.092,3.202,90.000,94.799,0.000,-1,-1,-1,600.000,600.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 16640, "a51", "ventb64", 0);
	tmpobjid = CreateDynamicObject(14826,272.264,23.422,2.242,0.000,0.000,105.199,-1,-1,-1,600.000,600.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 5150, "wiresetc_las2", "ganggraf01_LA_m", 0);
	SetDynamicObjectMaterial(tmpobjid, 1, 5150, "wiresetc_las2", "ganggraf01_LA_m", 0);
	SetDynamicObjectMaterial(tmpobjid, 3, 5150, "wiresetc_las2", "ganggraf01_LA_m", 0);
	tmpobjid = CreateDynamicObject(3129,272.432,23.929,1.922,0.000,0.000,0.000,-1,-1,-1,600.000,600.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", -26317);
	SetDynamicObjectMaterial(tmpobjid, 1, 10101, "2notherbuildsfe", "ferry_build14", 0);
	tmpobjid = CreateDynamicObject(19483,254.166,26.411,2.258,0.000,90.000,180.000,-1,-1,-1,600.000,600.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 14776, "genintintcarint3", "toolwall1", 0);
	tmpobjid = CreateDynamicObject(19893,254.073,23.670,2.697,0.000,0.000,106.500,-1,-1,-1,600.000,600.000);
	SetDynamicObjectMaterial(tmpobjid, 1, 14776, "genintintcarint3", "auto_tune3", 0);
	tmpobjid = CreateDynamicObject(19477,259.257,34.998,3.747,-4.899,0.000,270.000,-1,-1,-1,600.000,600.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 2813, "gb_books01", "GB_magazine06", 0);
	tmpobjid = CreateDynamicObject(2715,264.719,35.000,3.662,0.000,0.000,0.000,-1,-1,-1,600.000,600.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 14859, "gf1", "mp_apt1_pos4", 0);
	tmpobjid = CreateDynamicObject(19482,272.663,20.077,4.902,0.000,0.000,0.000,-1,-1,-1,600.000,600.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 10439, "hashblock3_sfs", "ws_mural1", 0);
	tmpobjid = CreateDynamicObject(19482,272.663,30.087,4.022,2.599,0.000,180.000,-1,-1,-1,600.000,600.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 14801, "lee_bdupsmain", "Bdup_graf2", 0);
	tmpobjid = CreateDynamicObject(19482,259.693,14.237,3.248,2.599,0.000,810.000,-1,-1,-1,600.000,600.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 14801, "lee_bdupsmain", "Bdup_graf5", 0);
	tmpobjid = CreateDynamicObject(19483,267.595,35.034,3.612,0.000,0.000,270.000,-1,-1,-1,600.000,600.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 14530, "estate2", "Auto_Slamvan2", 0);
	tmpobjid = CreateDynamicObject(19483,270.715,35.034,3.612,-1.700,0.000,270.000,-1,-1,-1,600.000,600.000);
	SetDynamicObjectMaterial(tmpobjid, 0, 14530, "estate2", "Auto_monstera", 0);
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	garage1 = CreateDynamicObject(11313,253.384,31.583,3.419,0.000,0.000,0.000,-1,-1,-1,600.000,600.000);
	garage2 = CreateDynamicObject(11313,253.384,17.663,3.419,0.000,0.000,0.000,-1,-1,-1,600.000,600.000);
	tmpobjid = CreateDynamicObject(19371,263.091,12.472,3.163,0.000,0.000,0.000,-1,-1,-1,600.000,600.000);
	tmpobjid = CreateDynamicObject(19371,263.091,6.062,3.163,0.000,0.000,0.000,-1,-1,-1,600.000,600.000);
	tmpobjid = CreateDynamicObject(19398,263.094,9.273,3.162,0.000,0.000,0.000,-1,-1,-1,600.000,600.000);
	tmpobjid = CreateDynamicObject(19444,263.092,4.252,3.160,0.000,0.000,0.000,-1,-1,-1,600.000,600.000);
	tmpobjid = CreateDynamicObject(19371,264.651,3.532,3.163,0.000,0.000,90.000,-1,-1,-1,600.000,600.000);
	tmpobjid = CreateDynamicObject(19371,267.861,3.532,3.163,0.000,0.000,90.000,-1,-1,-1,600.000,600.000);
	tmpobjid = CreateDynamicObject(19371,271.071,3.532,3.163,0.000,0.000,90.000,-1,-1,-1,600.000,600.000);
	tmpobjid = CreateDynamicObject(19371,272.601,5.052,3.163,0.000,0.000,180.000,-1,-1,-1,600.000,600.000);
	tmpobjid = CreateDynamicObject(19371,272.601,8.252,3.163,0.000,0.000,180.000,-1,-1,-1,600.000,600.000);
	tmpobjid = CreateDynamicObject(19371,272.601,11.432,3.163,0.000,0.000,180.000,-1,-1,-1,600.000,600.000);
	tmpobjid = CreateDynamicObject(19444,272.602,13.492,3.160,0.000,0.000,0.000,-1,-1,-1,600.000,600.000);
	tmpobjid = CreateDynamicObject(1499,263.134,8.556,1.412,0.000,0.000,90.000,-1,-1,-1,600.000,600.000);
	tmpobjid = CreateDynamicObject(1466,254.194,31.839,8.146,0.000,0.000,90.000,-1,-1,-1,600.000,600.000);
	tmpobjid = CreateDynamicObject(1466,254.194,17.459,8.146,0.000,0.000,90.000,-1,-1,-1,600.000,600.000);
	tmpobjid = CreateDynamicObject(2960,259.898,32.708,6.717,0.000,0.000,90.000,-1,-1,-1,600.000,600.000);
	tmpobjid = CreateDynamicObject(2960,259.898,28.108,6.717,0.000,0.000,90.000,-1,-1,-1,600.000,600.000);
	tmpobjid = CreateDynamicObject(2960,259.898,23.508,6.717,0.000,0.000,90.000,-1,-1,-1,600.000,600.000);
	tmpobjid = CreateDynamicObject(2960,259.898,18.908,6.717,0.000,0.000,90.000,-1,-1,-1,600.000,600.000);
	tmpobjid = CreateDynamicObject(2960,259.868,16.508,6.717,0.000,0.000,270.000,-1,-1,-1,600.000,600.000);
	tmpobjid = CreateDynamicObject(2960,266.418,32.708,6.717,0.000,0.000,90.000,-1,-1,-1,600.000,600.000);
	tmpobjid = CreateDynamicObject(2960,266.418,28.098,6.717,0.000,0.000,90.000,-1,-1,-1,600.000,600.000);
	tmpobjid = CreateDynamicObject(2960,266.418,23.508,6.717,0.000,0.000,90.000,-1,-1,-1,600.000,600.000);
	tmpobjid = CreateDynamicObject(2960,266.418,18.918,6.717,0.000,0.000,90.000,-1,-1,-1,600.000,600.000);
	tmpobjid = CreateDynamicObject(2960,266.418,16.358,6.717,0.000,0.000,450.000,-1,-1,-1,600.000,600.000);
	tmpobjid = CreateDynamicObject(1893,259.886,17.492,6.333,0.000,0.000,90.000,-1,-1,-1,600.000,600.000);
	tmpobjid = CreateDynamicObject(1893,259.886,24.552,6.333,0.000,0.000,90.000,-1,-1,-1,600.000,600.000);
	tmpobjid = CreateDynamicObject(1893,259.886,31.522,6.333,0.000,0.000,90.000,-1,-1,-1,600.000,600.000);
	tmpobjid = CreateDynamicObject(1893,266.416,31.522,6.333,0.000,0.000,90.000,-1,-1,-1,600.000,600.000);
	tmpobjid = CreateDynamicObject(1893,266.416,24.552,6.333,0.000,0.000,90.000,-1,-1,-1,600.000,600.000);
	tmpobjid = CreateDynamicObject(1893,266.406,17.492,6.333,0.000,0.000,90.000,-1,-1,-1,600.000,600.000);
	tmpobjid = CreateDynamicObject(19826,253.298,27.885,2.895,0.000,0.000,270.000,-1,-1,-1,600.000,600.000);
	tmpobjid = CreateDynamicObject(19826,253.298,21.405,2.895,0.000,0.000,270.000,-1,-1,-1,600.000,600.000);
	tmpobjid = CreateDynamicObject(19903,266.479,26.791,1.442,0.000,0.000,-134.099,-1,-1,-1,600.000,600.000);
	tmpobjid = CreateDynamicObject(19826,267.632,27.243,3.022,0.000,0.000,0.000,-1,-1,-1,600.000,600.000);
	tmpobjid = CreateDynamicObject(3761,266.741,4.646,2.662,0.000,0.000,450.000,-1,-1,-1,600.000,600.000);
	tmpobjid = CreateDynamicObject(1327,264.291,6.637,1.442,0.000,90.000,0.000,-1,-1,-1,600.000,600.000);
	tmpobjid = CreateDynamicObject(1327,264.291,6.637,2.102,0.000,90.000,24.800,-1,-1,-1,600.000,600.000);
	tmpobjid = CreateDynamicObject(1327,264.291,6.637,2.752,0.000,90.000,9.500,-1,-1,-1,600.000,600.000);
	tmpobjid = CreateDynamicObject(1183,271.945,11.444,1.652,0.000,0.000,270.000,-1,-1,-1,600.000,600.000);
	tmpobjid = CreateDynamicObject(1183,271.443,11.274,1.743,38.500,0.000,270.000,-1,-1,-1,600.000,600.000);
	tmpobjid = CreateDynamicObject(1184,272.190,7.834,1.632,0.000,0.000,270.000,-1,-1,-1,600.000,600.000);
	tmpobjid = CreateDynamicObject(1184,271.580,8.344,1.632,0.000,0.000,270.000,-1,-1,-1,600.000,600.000);
	tmpobjid = CreateDynamicObject(1897,263.300,10.648,1.580,-53.899,0.000,270.000,-1,-1,-1,600.000,600.000);
	tmpobjid = CreateDynamicObject(1897,263.300,11.828,1.580,-53.899,0.000,270.000,-1,-1,-1,600.000,600.000);
	tmpobjid = CreateDynamicObject(1897,263.300,13.078,1.580,-53.899,0.000,270.000,-1,-1,-1,600.000,600.000);
	tmpobjid = CreateDynamicObject(1073,263.679,12.801,2.172,0.000,0.000,90.000,-1,-1,-1,600.000,600.000);
	tmpobjid = CreateDynamicObject(1073,263.679,12.481,2.172,0.000,0.000,90.000,-1,-1,-1,600.000,600.000);
	tmpobjid = CreateDynamicObject(1073,263.679,12.201,2.172,0.000,0.000,90.000,-1,-1,-1,600.000,600.000);
	tmpobjid = CreateDynamicObject(1073,263.679,11.621,2.172,0.000,0.000,270.000,-1,-1,-1,600.000,600.000);
	tmpobjid = CreateDynamicObject(1073,263.679,11.291,2.172,0.000,0.000,90.000,-1,-1,-1,600.000,600.000);
	tmpobjid = CreateDynamicObject(1073,263.679,10.901,2.172,0.000,0.000,90.000,-1,-1,-1,600.000,600.000);
	tmpobjid = CreateDynamicObject(2062,271.798,12.348,2.022,0.000,0.000,101.799,-1,-1,-1,600.000,600.000);
	tmpobjid = CreateDynamicObject(2062,272.029,13.540,2.022,0.000,0.000,101.799,-1,-1,-1,600.000,600.000);
	tmpobjid = CreateDynamicObject(2062,271.279,13.169,2.022,0.000,0.000,101.799,-1,-1,-1,600.000,600.000);
	tmpobjid = CreateDynamicObject(1116,271.538,10.978,2.332,98.999,0.000,90.000,-1,-1,-1,600.000,600.000);
	tmpobjid = CreateDynamicObject(1116,271.199,10.978,2.346,95.099,0.000,90.000,-1,-1,-1,600.000,600.000);
	tmpobjid = CreateDynamicObject(1116,271.438,10.728,2.469,60.900,-175.399,85.899,-1,-1,-1,600.000,600.000);
	tmpobjid = CreateDynamicObject(1059,271.699,8.904,2.952,0.000,0.000,0.000,-1,-1,-1,600.000,600.000);
	tmpobjid = CreateDynamicObject(1059,271.216,9.742,2.952,0.000,0.000,9.700,-1,-1,-1,600.000,600.000);
	tmpobjid = CreateDynamicObject(19816,271.683,7.890,3.162,90.000,0.000,0.000,-1,-1,-1,600.000,600.000);
	tmpobjid = CreateDynamicObject(19816,271.463,7.730,3.162,90.000,0.000,0.000,-1,-1,-1,600.000,600.000);
	tmpobjid = CreateDynamicObject(19816,271.903,7.430,3.162,90.000,0.000,0.000,-1,-1,-1,600.000,600.000);
	tmpobjid = CreateDynamicObject(19816,271.583,7.190,3.162,90.000,0.000,0.000,-1,-1,-1,600.000,600.000);
	tmpobjid = CreateDynamicObject(19816,271.233,7.190,3.162,90.000,0.000,0.000,-1,-1,-1,600.000,600.000);
	tmpobjid = CreateDynamicObject(19816,272.073,6.850,3.162,90.000,0.000,-17.800,-1,-1,-1,600.000,600.000);
	tmpobjid = CreateDynamicObject(1650,271.667,11.335,3.372,0.000,0.000,-29.299,-1,-1,-1,600.000,600.000);
	tmpobjid = CreateDynamicObject(1650,271.670,10.851,3.372,0.000,0.000,-29.299,-1,-1,-1,600.000,600.000);
	tmpobjid = CreateDynamicObject(1650,271.287,11.067,3.372,0.000,0.000,-29.299,-1,-1,-1,600.000,600.000);
	tmpobjid = CreateDynamicObject(1650,271.374,10.630,3.372,0.000,0.000,20.300,-1,-1,-1,600.000,600.000);
	tmpobjid = CreateDynamicObject(2057,271.675,10.777,4.062,0.000,0.000,0.000,-1,-1,-1,600.000,600.000);
	tmpobjid = CreateDynamicObject(2057,271.675,10.097,4.062,0.000,0.000,90.000,-1,-1,-1,600.000,600.000);
	tmpobjid = CreateDynamicObject(1139,271.741,8.433,4.012,90.000,0.000,270.000,-1,-1,-1,600.000,600.000);
	tmpobjid = CreateDynamicObject(1139,271.663,6.610,4.012,90.000,16.000,270.000,-1,-1,-1,600.000,600.000);
	tmpobjid = CreateDynamicObject(19899,254.004,23.548,1.447,0.000,0.000,0.000,-1,-1,-1,600.000,600.000);
	tmpobjid = CreateDynamicObject(19917,271.689,24.940,1.442,0.000,0.000,28.900,-1,-1,-1,600.000,600.000);
	tmpobjid = CreateDynamicObject(19900,263.735,21.736,1.445,0.000,0.000,0.000,-1,-1,-1,600.000,600.000);
	tmpobjid = CreateDynamicObject(19903,264.981,21.697,1.442,0.000,0.000,117.400,-1,-1,-1,600.000,600.000);
	tmpobjid = CreateDynamicObject(19900,270.875,21.736,1.445,0.000,0.000,-32.800,-1,-1,-1,600.000,600.000);
	tmpobjid = CreateDynamicObject(19900,270.966,23.022,1.445,0.000,0.000,0.899,-1,-1,-1,600.000,600.000);
	tmpobjid = CreateDynamicObject(2115,254.081,25.903,1.448,0.000,0.000,90.000,-1,-1,-1,600.000,600.000);
	tmpobjid = CreateDynamicObject(19815,253.504,26.471,3.388,0.000,0.000,90.000,-1,-1,-1,600.000,600.000);
	tmpobjid = CreateDynamicObject(1582,253.992,22.695,3.058,0.000,0.000,0.000,-1,-1,-1,600.000,600.000);
	tmpobjid = CreateDynamicObject(1582,253.992,22.666,3.118,0.000,0.000,77.500,-1,-1,-1,600.000,600.000);
	tmpobjid = CreateDynamicObject(19921,254.416,23.615,3.608,0.000,0.000,90.000,-1,-1,-1,600.000,600.000);
	tmpobjid = CreateDynamicObject(11738,254.243,22.655,2.727,0.000,0.000,90.000,-1,-1,-1,600.000,600.000);
	tmpobjid = CreateDynamicObject(2690,254.240,24.413,3.666,270.000,0.000,-35.900,-1,-1,-1,600.000,600.000);
	tmpobjid = CreateDynamicObject(11743,254.155,24.287,2.687,0.000,0.000,90.000,-1,-1,-1,600.000,600.000);
	tmpobjid = CreateDynamicObject(2057,254.160,22.714,3.688,0.000,0.000,270.000,-1,-1,-1,600.000,600.000);
	tmpobjid = CreateDynamicObject(11280,262.380,28.807,1.445,0.000,0.000,80.799,-1,-1,-1,600.000,600.000);
	tmpobjid = CreateDynamicObject(19898,268.730,23.501,1.452,0.000,0.000,0.000,-1,-1,-1,600.000,600.000);
	tmpobjid = CreateDynamicObject(19898,268.730,29.491,1.452,0.000,0.000,56.000,-1,-1,-1,600.000,600.000);
	tmpobjid = CreateDynamicObject(19898,267.051,18.935,1.452,0.000,0.000,175.100,-1,-1,-1,600.000,600.000);
	tmpobjid = CreateDynamicObject(19898,258.363,19.680,1.452,0.000,0.000,133.199,-1,-1,-1,600.000,600.000);
	tmpobjid = CreateDynamicObject(920,254.212,21.727,1.666,0.000,0.000,0.000,-1,-1,-1,600.000,600.000);
	tmpobjid = CreateDynamicObject(19898,259.461,25.157,1.452,0.000,0.000,-113.899,-1,-1,-1,600.000,600.000);
	tmpobjid = CreateDynamicObject(3594,258.944,12.206,1.874,0.000,0.000,90.000,-1,-1,-1,600.000,600.000);
	tmpobjid = CreateDynamicObject(3594,255.686,12.206,2.696,-12.599,0.000,90.000,-1,-1,-1,600.000,600.000);
	tmpobjid = CreateDynamicObject(1897,254.551,21.170,5.365,270.000,0.000,90.000,-1,-1,-1,600.000,600.000);
	tmpobjid = CreateDynamicObject(1897,254.551,28.060,5.365,270.000,0.000,90.000,-1,-1,-1,600.000,600.000);
	tmpobjid = CreateDynamicObject(1897,256.731,28.080,5.375,270.000,0.000,270.000,-1,-1,-1,600.000,600.000);
	tmpobjid = CreateDynamicObject(1897,256.731,21.200,5.375,270.000,0.000,270.000,-1,-1,-1,600.000,600.000);
	/////////////////////////////////////////////////////Shop///////////////////////////////////////////////////////////
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
tmpobjid = CreateDynamicObject(19457, 197.147415, -7.181853, 0.540603, 0.000000, 89.899948, 89.899971, -1, -1, -1, 300.00, 300.00);
SetDynamicObjectMaterialText(tmpobjid, 0, "{FF0000} X", 10, "Ariel", 20, 1, 0x00000255, 0x00000000, 0);
tmpobjid = CreateDynamicObject(19371, 206.202728, 25.943576, 1.873218, 0.000000, -0.100004, 89.400024, -1, -1, -1, 300.00, 300.00);
SetDynamicObjectMaterial(tmpobjid, 0, 3820, "boxhses_sfsx", "ws_garagedoor2_white", 0x00000000);
tmpobjid = CreateDynamicObject(19463, 217.352218, 25.826808, 1.873218, 0.000000, -0.100004, 89.400024, -1, -1, -1, 300.00, 300.00);
SetDynamicObjectMaterial(tmpobjid, 0, 3850, "carshowglass_sfsx", "ws_carshowwin1", 0x00000000);
tmpobjid = CreateDynamicObject(1491, 211.012573, 25.818174, 0.534634, 0.000000, 0.000000, 0.300048, -1, -1, -1, 300.00, 300.00);
SetDynamicObjectMaterial(tmpobjid, 0, 3945, "bistro_alpha", "creme128", 0x00000000);
SetDynamicObjectMaterial(tmpobjid, 1, 4829, "airport_las", "yellow", 0x00000000);
tmpobjid = CreateDynamicObject(19371, 209.422561, 25.909856, 1.873218, 0.000000, -0.100004, 89.400024, -1, -1, -1, 300.00, 300.00);
SetDynamicObjectMaterial(tmpobjid, 0, 3850, "carshowglass_sfsx", "ws_carshowwin1", 0x00000000);
tmpobjid = CreateDynamicObject(19371, 203.432998, 25.972597, 1.873218, 0.000000, -0.100004, 89.400024, -1, -1, -1, 300.00, 300.00);
SetDynamicObjectMaterial(tmpobjid, 0, 3820, "boxhses_sfsx", "ws_garagedoor2_white", 0x00000000);
tmpobjid = CreateDynamicObject(19362, 204.134643, 34.161838, 0.478465, 0.000000, -89.999992, 133.300064, -1, -1, -1, 300.00, 300.00);
SetDynamicObjectMaterial(tmpobjid, 0, 14787, "ab_sfgymbits02", "ab_rollmat02", 0x00000000);
tmpobjid = CreateDynamicObject(19362, 206.165283, 36.075317, 0.478465, 0.000000, -89.999992, 133.300064, -1, -1, -1, 300.00, 300.00);
SetDynamicObjectMaterial(tmpobjid, 0, 14787, "ab_sfgymbits02", "ab_rollmat02", 0x00000000);
tmpobjid = CreateDynamicObject(19362, 209.991912, 32.714698, 0.478466, 0.000000, -89.999992, 133.300064, -1, -1, -1, 300.00, 300.00);
SetDynamicObjectMaterial(tmpobjid, 0, 14787, "ab_sfgymbits02", "ab_rollmat02", 0x00000000);
tmpobjid = CreateDynamicObject(19362, 212.153381, 34.751586, 0.478466, 0.000000, -89.999992, 133.300064, -1, -1, -1, 300.00, 300.00);
SetDynamicObjectMaterial(tmpobjid, 0, 14787, "ab_sfgymbits02", "ab_rollmat02", 0x00000000);
tmpobjid = CreateDynamicObject(19362, 214.775970, 28.284795, 0.478468, 0.000000, -89.999992, 102.500106, -1, -1, -1, 300.00, 300.00);
SetDynamicObjectMaterial(tmpobjid, 0, 14787, "ab_sfgymbits02", "ab_rollmat02", 0x00000000);
tmpobjid = CreateDynamicObject(19362, 217.773223, 28.949274, 0.478468, 0.000000, -89.999992, 102.500106, -1, -1, -1, 300.00, 300.00);
SetDynamicObjectMaterial(tmpobjid, 0, 14787, "ab_sfgymbits02", "ab_rollmat02", 0x00000000);
tmpobjid = CreateDynamicObject(1491, 211.023559, 25.874176, 3.024631, 0.000000, 0.000000, -0.499993, -1, -1, -1, 300.00, 300.00);
SetDynamicObjectMaterial(tmpobjid, 0, 3850, "carshowglass_sfsx", "ws_carshowwin1", 0x00000000);
tmpobjid = CreateDynamicObject(19368, 212.598800, 40.518817, 1.915059, 0.000000, 0.000000, 77.100059, -1, -1, -1, 300.00, 300.00);
SetDynamicObjectMaterialText(tmpobjid, 0, "                Red County", 90, "Ariel", 30, 1, 0xFFFFFFFF, 0x00000500, 0);
tmpobjid = CreateDynamicObject(19368, 209.489410, 41.230983, 1.915059, 0.000000, 0.000000, 77.100059, -1, -1, -1, 300.00, 300.00);
SetDynamicObjectMaterialText(tmpobjid, 0, " Car Service", 90, "Ariel", 30, 1, 0xFFFFFFFF, 0x00000500, 0);
tmpobjid = CreateDynamicObject(19172, 211.068786, 40.951141, 2.104919, 0.099995, 0.000000, 167.000244, -1, -1, -1, 300.00, 300.00);
SetDynamicObjectMaterial(tmpobjid, 0, 14530, "estate2", "Auto_feltzer", 0x00000000);
tmpobjid = CreateDynamicObject(19172, 201.800140, 27.957641, 2.316417, -0.100004, 0.000000, 89.900161, -1, -1, -1, 300.00, 300.00);
SetDynamicObjectMaterial(tmpobjid, 0, 14530, "estate2", "Auto_windsor", 0x00000000);
tmpobjid = CreateDynamicObject(19172, 201.808441, 32.697639, 2.316417, -0.100004, 0.000000, 89.900161, -1, -1, -1, 300.00, 300.00);
SetDynamicObjectMaterial(tmpobjid, 0, 14530, "estate2", "Auto_Slamvan2", 0x00000000);
tmpobjid = CreateDynamicObject(19172, 222.013473, 29.782207, 2.351866, -0.100004, 0.000000, -90.099906, -1, -1, -1, 300.00, 300.00);
SetDynamicObjectMaterial(tmpobjid, 0, 14530, "estate2", "Auto_hustler", 0x00000000);
tmpobjid = CreateDynamicObject(19172, 217.379730, 38.331760, 2.356595, -0.100004, 0.000000, -0.599919, -1, -1, -1, 300.00, 300.00);
SetDynamicObjectMaterial(tmpobjid, 0, 14530, "estate2", "Auto_monstera", 0x00000000);
tmpobjid = CreateDynamicObject(19172, 208.650161, 38.423168, 2.356595, -0.100004, 0.000000, -0.599919, -1, -1, -1, 300.00, 300.00);
SetDynamicObjectMaterial(tmpobjid, 0, 14530, "estate2", "Auto_feltzer", 0x00000000);
tmpobjid = CreateDynamicObject(19482, 253.428909, 17.635507, 9.262208, 0.000000, 0.000000, -179.899932, -1, -1, -1, 300.00, 300.00);
SetDynamicObjectMaterial(tmpobjid, 0, 3850, "carshowglass_sfsx", "ws_carshowwin1", 0x00000000);
SetDynamicObjectMaterialText(tmpobjid, 0, "Red County\nCar Service", 50, "Ariel", 25, 1, 0xFFFFFFFF, 0x00000500, 1);
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
tmpobjid = CreateDynamicObject(8418, 211.654693, 7.432555, 1.003384, 0.000000, 0.000000, 0.400029, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(8650, 222.437805, 2.763894, 0.505838, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(8657, 201.237533, 11.580492, 0.904634, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(8657, 201.237533, 27.520473, 0.904634, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(8650, 222.437805, 23.133878, 0.505838, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(19362, 220.558563, 27.530836, 0.448466, 0.000000, -89.999992, 89.600021, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(19362, 217.368591, 27.553096, 0.448466, 0.000000, -89.999992, 89.600021, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(19362, 214.228652, 27.575014, 0.448466, 0.000000, -89.999992, 89.600021, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(19362, 211.108718, 27.596799, 0.448466, 0.000000, -89.999992, 89.600021, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(19362, 207.988845, 27.618579, 0.448466, 0.000000, -89.999992, 89.600021, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(19362, 204.788940, 27.640922, 0.448466, 0.000000, -89.999992, 89.600021, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(19362, 201.759002, 27.662076, 0.448466, 0.000000, -89.999992, 89.600021, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(19362, 201.782791, 31.081998, 0.448465, 0.000000, -89.999992, 89.600021, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(19362, 204.902786, 31.060228, 0.448465, 0.000000, -89.999992, 89.600021, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(19362, 208.042755, 31.038305, 0.448465, 0.000000, -89.999992, 89.600021, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(19362, 211.172729, 31.016462, 0.448465, 0.000000, -89.999992, 89.600021, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(19362, 214.282699, 30.994758, 0.448465, 0.000000, -89.999992, 89.600021, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(19362, 217.422653, 30.972845, 0.448465, 0.000000, -89.999992, 89.600021, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(19362, 220.592636, 30.950727, 0.448465, 0.000000, -89.999992, 89.600021, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(19362, 220.616256, 34.350688, 0.448465, 0.000000, -89.999992, 89.600021, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(19362, 217.456420, 34.372764, 0.448465, 0.000000, -89.999992, 89.600021, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(19362, 214.256576, 34.395118, 0.448465, 0.000000, -89.999992, 89.600021, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(19362, 211.056640, 34.417488, 0.448465, 0.000000, -89.999992, 89.600021, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(19362, 207.876754, 34.439720, 0.448465, 0.000000, -89.999992, 89.600021, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(19362, 204.686782, 34.462001, 0.448465, 0.000000, -89.999992, 89.600021, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(19362, 202.836868, 34.474922, 0.448465, 0.000000, -89.999992, 89.600021, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(19362, 202.941070, 37.924293, 0.448464, 0.000000, -89.999992, 89.600021, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(19362, 206.120971, 37.902076, 0.448464, 0.000000, -89.999992, 89.600021, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(19362, 209.330902, 37.879653, 0.448464, 0.000000, -89.999992, 89.600021, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(19362, 212.530838, 37.857280, 0.448464, 0.000000, -89.999992, 89.600021, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(19362, 215.730789, 37.834930, 0.448464, 0.000000, -89.999992, 89.600021, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(19362, 218.890716, 37.812850, 0.448464, 0.000000, -89.999992, 89.600021, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(19362, 220.900558, 37.798828, 0.448464, 0.000000, -89.999992, 89.600021, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(19463, 222.109939, 30.577022, 1.902526, 0.000000, -0.100004, -0.099988, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(19463, 222.115112, 33.617008, 1.902526, 0.000000, -0.100004, -0.099988, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(19463, 201.730056, 30.712549, 1.866956, 0.000000, -0.100004, -0.099988, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(19463, 201.743179, 38.272510, 1.866956, 0.000000, -0.100004, -0.099988, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(19463, 217.394058, 38.417060, 1.895193, 0.000000, -0.100004, 89.400024, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(19463, 206.554550, 38.530574, 1.895193, 0.000000, -0.100004, 89.400024, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(19463, 210.954330, 38.484504, 1.895193, 0.000000, -0.100004, 89.400024, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(19463, 206.421386, 41.918457, 1.859328, 0.000000, -0.100004, 77.100143, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(19463, 206.421386, 41.918457, 1.859328, 0.000000, -0.100004, 77.100143, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(19463, 215.827667, 39.764095, 1.859328, 0.000000, -0.100004, 77.100143, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(19463, 217.280166, 39.431495, 1.859328, 0.000000, -0.100004, 77.100143, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(18070, 220.363525, 35.202766, 1.024402, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(8650, 201.487518, -1.571263, -0.583772, 0.000000, -8.100030, -179.300109, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(19362, 220.558578, 27.530838, 3.578464, 0.000000, -89.999992, 89.600021, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(19362, 217.368896, 27.553129, 3.578464, 0.000000, -89.999992, 89.600021, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(19362, 214.179016, 27.575403, 3.578464, 0.000000, -89.999992, 89.600021, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(19362, 210.979141, 27.597732, 3.578464, 0.000000, -89.999992, 89.600021, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(19362, 207.789245, 27.620002, 3.578464, 0.000000, -89.999992, 89.600021, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(19362, 204.609390, 27.642198, 3.578464, 0.000000, -89.999992, 89.600021, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(19362, 203.259567, 27.651639, 3.578464, 0.000000, -89.999992, 89.600021, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(19362, 203.283218, 31.071550, 3.578464, 0.000000, -89.999992, 89.600021, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(19362, 206.433212, 31.049579, 3.578464, 0.000000, -89.999992, 89.600021, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(19362, 209.593093, 31.027534, 3.578464, 0.000000, -89.999992, 89.600021, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(19362, 212.712982, 31.005756, 3.578464, 0.000000, -89.999992, 89.600021, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(19362, 215.872955, 30.983703, 3.578464, 0.000000, -89.999992, 89.600021, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(19362, 219.012939, 30.961795, 3.578464, 0.000000, -89.999992, 89.600021, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(19362, 220.572799, 30.950885, 3.578464, 0.000000, -89.999992, 89.600021, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(19362, 220.586776, 34.390880, 3.578464, 0.000000, -89.999992, 89.600021, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(19362, 217.426757, 34.413009, 3.578464, 0.000000, -89.999992, 89.600021, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(19362, 214.296737, 34.434894, 3.578464, 0.000000, -89.999992, 89.600021, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(19362, 211.206832, 34.456485, 3.578464, 0.000000, -89.999992, 89.600021, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(19362, 208.067092, 34.478385, 3.578464, 0.000000, -89.999992, 89.600021, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(19362, 204.937194, 34.500244, 3.578464, 0.000000, -89.999992, 89.600021, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(19362, 203.367294, 34.511211, 3.578464, 0.000000, -89.999992, 89.600021, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(19362, 220.573120, 36.731174, 3.578464, 0.000000, -89.999992, 89.600021, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(19362, 217.403244, 36.753345, 3.578464, 0.000000, -89.999992, 89.600021, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(19362, 214.203277, 36.775733, 3.578464, 0.000000, -89.999992, 89.600021, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(19362, 211.033401, 36.797889, 3.578464, 0.000000, -89.999992, 89.600021, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(19362, 219.819061, 37.092926, 3.578464, 0.000000, -89.999992, 76.799926, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(19362, 216.752319, 37.812244, 3.578464, 0.000000, -89.999992, 76.799926, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(19362, 213.714752, 38.524684, 3.578464, 0.000000, -89.999992, 76.799926, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(19362, 210.677307, 39.237094, 3.578464, 0.000000, -89.999992, 76.799926, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(19362, 207.630050, 39.951820, 3.578464, 0.000000, -89.999992, 76.799926, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(19362, 204.563400, 40.671112, 3.578464, 0.000000, -89.999992, 76.799926, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(19362, 203.628829, 40.890338, 3.578464, 0.000000, -89.999992, 76.799926, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(19362, 207.853408, 36.820102, 3.578464, 0.000000, -89.999992, 89.600021, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(19362, 204.713500, 36.842033, 3.578464, 0.000000, -89.999992, 89.600021, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(19362, 203.383605, 36.851322, 3.578464, 0.000000, -89.999992, 89.600021, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(19362, 203.407836, 40.321250, 3.578464, 0.000000, -89.999992, 89.600021, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(19362, 204.517272, 40.233482, 3.578464, 0.000000, -89.999992, 89.600021, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(16779, 205.811538, 30.234176, 3.994629, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(16779, 212.081558, 30.234176, 3.994629, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(16779, 218.001525, 30.234176, 3.994629, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(16779, 218.001525, 34.474174, 3.994629, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(16779, 212.051513, 34.474174, 3.994629, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(16779, 205.801605, 34.474174, 3.994629, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(2165, 217.933166, 35.086700, 0.734402, 0.000000, 0.000000, 89.900016, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(2245, 217.594985, 33.502105, 1.794402, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(2465, 221.446533, 33.476818, 1.774402, 0.000000, 0.000000, -53.400012, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(2485, 217.287628, 36.385250, 1.574402, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(2953, 218.154891, 34.936378, 1.534402, 0.000000, 0.000000, 103.099983, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(2161, 222.026519, 37.809970, 0.514402, 0.000000, 0.000000, -91.100013, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(2161, 222.001510, 36.510189, 0.514402, 0.000000, 0.000000, -91.100013, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(2356, 218.931213, 35.599128, 0.534402, 0.000000, 0.000000, 89.200012, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(1713, 220.201995, 31.575445, 0.584402, 0.000000, 0.000000, -177.499938, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(11737, 211.752731, 25.409919, 0.534634, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(10281, 252.481491, 24.818881, 6.884812, 0.000000, -15.499999, -89.600051, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(10281, 211.859695, 25.023868, 5.501375, 0.000000, -14.400004, 0.000000, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(19362, 210.537658, 25.911075, 5.328222, 0.000000, 0.999985, 89.600021, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(19362, 213.097503, 25.893186, 5.328222, 0.000000, 0.999985, 89.600021, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(19295, 213.649795, -15.604928, 3.004635, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(1436, 211.877563, 26.659635, 5.174403, 0.000000, 0.000000, 179.699981, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(919, 205.860290, 34.522018, 4.086629, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(919, 212.010208, 34.522018, 4.086629, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(919, 217.950271, 34.522018, 4.086629, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(919, 217.950271, 30.152027, 4.086629, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(919, 212.010299, 30.152027, 4.086629, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
tmpobjid = CreateDynamicObject(919, 205.840255, 30.152027, 4.086629, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
////////////////////////////////////////////////////////Modshop///////////////////////////////////////////////////////////////////
tmpobjid = CreateDynamicObject(19905, 3616.080566, 2988.744384, 1000.222229, 0.000000, 0.000000, -179.800247, -1, -1, -1, 300.00, 300.00);//modshop
tmpobjid = CreateDynamicObject(19817, 3611.778076, 2988.732910, 999.050781, 0.000000, 0.000000, -89.500030, -1, -1, -1, 300.00, 300.00);//hebebühne modshop
tmpobjid = CreateDynamicObject(19817, 3621.057373, 2988.717529, 999.030761, 0.000000, 0.000000, 89.999977, -1, -1, -1, 300.00, 300.00);//hebebühne 2 modshop //vielleicht zum 0punkt?

    for(new i = 0; i < MAX_PLAYERS; i++)
    {
        if(!IsPlayerConnected(i)) continue;
        OnPlayerConnect(i);
    }
	return 1;
}

public OnFilterScriptExit()
{
	KillTimer(speedotimer);
	KillTimer(Tachonadeltimer);
	KillTimer(Planespeedotimer);
	KillTimer(savetimer);
    for(new i=0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
			OnPlayerDisconnect(i, 1);
		}
	}
	for(new i=1; i < MAX_DEALERSHIPS; i++)
	{
		if(DealershipCreated[i])
		{
			Delete3DTextLabel(DealershipLabel[i]);
		}
	}
	return 1;
}

public OnPlayerConnect(playerid)
{
RemoveBuildingForPlayer(playerid, 13062, 266.3594, 20.1328, 5.4844, 0.25);
RemoveBuildingForPlayer(playerid, 1440, 243.9531, 24.6172, 2.0156, 0.25);
RemoveBuildingForPlayer(playerid, 1684, 276.8438, -2.4297, 2.8828, 0.25);
RemoveBuildingForPlayer(playerid, 13059, 266.3594, 20.1328, 5.4844, 0.25);
RemoveBuildingForPlayer(playerid, 1440, 255.2734, 22.7734, 1.8984, 0.25);
RemoveBuildingForPlayer(playerid, 13068, 210.2969, 20.4766, -0.4297, 0.25);//Parkplatz/Annahme
RemoveBuildingForPlayer(playerid, 13065, 210.2969, 20.4766, -0.4297, 0.25);//Parkplatz/Annahme
    
TrackCar[playerid] = 0;
TrackNewCar[playerid] = 0;

//modshop
TuningEnter_[playerid] = CreatePlayerTextDraw(playerid, 330.666931, 217.377624, "Lets tune it!");
PlayerTextDrawLetterSize(playerid, TuningEnter_[playerid], 0.386333, 1.305482);
PlayerTextDrawTextSize(playerid, TuningEnter_[playerid], 539.000000, 200.000000);
PlayerTextDrawAlignment(playerid, TuningEnter_[playerid], 2);
PlayerTextDrawColor(playerid, TuningEnter_[playerid], -1);
PlayerTextDrawSetShadow(playerid, TuningEnter_[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, TuningEnter_[playerid], 255);
PlayerTextDrawFont(playerid, TuningEnter_[playerid], 1);
PlayerTextDrawSetProportional(playerid, TuningEnter_[playerid], 1);

TuningEnter[playerid] = CreatePlayerTextDraw(playerid, -34.333312, -17.562969, "LD_SPAC:white");
PlayerTextDrawTextSize(playerid, TuningEnter[playerid], 724.000000, 495.000000);
PlayerTextDrawAlignment(playerid, TuningEnter[playerid], 1);
PlayerTextDrawColor(playerid, TuningEnter[playerid], 16843033);
PlayerTextDrawSetShadow(playerid, TuningEnter[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, TuningEnter[playerid], 255);
PlayerTextDrawFont(playerid, TuningEnter[playerid], 4);
PlayerTextDrawSetProportional(playerid, TuningEnter[playerid], 0);
PlayerTextDrawSetSelectable(playerid, TuningEnter[playerid], true);

TuningLeave[playerid] = CreatePlayerTextDraw(playerid, 588.666503, 385.222198, "hud:skipicon");
PlayerTextDrawTextSize(playerid, TuningLeave[playerid], 49.000000, 50.000000);
PlayerTextDrawAlignment(playerid, TuningLeave[playerid], 1);
PlayerTextDrawColor(playerid, TuningLeave[playerid], -1);
PlayerTextDrawSetShadow(playerid, TuningLeave[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, TuningLeave[playerid], 255);
PlayerTextDrawFont(playerid, TuningLeave[playerid], 4);
PlayerTextDrawSetProportional(playerid, TuningLeave[playerid], 0);
PlayerTextDrawSetSelectable(playerid, TuningLeave[playerid], true);

TuningLeave_[playerid] = CreatePlayerTextDraw(playerid, 591.999877, 426.029785, "Leave");
PlayerTextDrawLetterSize(playerid, TuningLeave_[playerid], 0.400000, 1.600000);
PlayerTextDrawAlignment(playerid, TuningLeave_[playerid], 1);
PlayerTextDrawColor(playerid, TuningLeave_[playerid], -1);
PlayerTextDrawSetShadow(playerid, TuningLeave_[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, TuningLeave_[playerid], 255);
PlayerTextDrawFont(playerid, TuningLeave_[playerid], 1);
PlayerTextDrawSetProportional(playerid, TuningLeave_[playerid], 1);

TuningBackground[playerid] = CreatePlayerTextDraw(playerid, 227.333221, 341.666687, "LD_SPAC:white");
PlayerTextDrawTextSize(playerid, TuningBackground[playerid], 186.000000, 89.000000);
PlayerTextDrawAlignment(playerid, TuningBackground[playerid], 1);
PlayerTextDrawColor(playerid, TuningBackground[playerid], 16843158);
PlayerTextDrawSetShadow(playerid, TuningBackground[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, TuningBackground[playerid], 255);
PlayerTextDrawFont(playerid, TuningBackground[playerid], 4);
PlayerTextDrawSetProportional(playerid, TuningBackground[playerid], 0);

TuningObjectBackground[playerid] = CreatePlayerTextDraw(playerid, 5.666502, 195.237075, "LD_SPAC:white");
PlayerTextDrawTextSize(playerid, TuningObjectBackground[playerid], 203.000000, 221.000000);
PlayerTextDrawAlignment(playerid, TuningObjectBackground[playerid], 1);
PlayerTextDrawColor(playerid, TuningObjectBackground[playerid], 16843158);
PlayerTextDrawSetShadow(playerid, TuningObjectBackground[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, TuningObjectBackground[playerid], 255);
PlayerTextDrawFont(playerid, TuningObjectBackground[playerid], 4);
PlayerTextDrawSetProportional(playerid, TuningObjectBackground[playerid], 0);

ModDone[playerid] = CreatePlayerTextDraw(playerid, 55.999897, 376.925964, "LD_SPAC:white");
PlayerTextDrawTextSize(playerid, ModDone[playerid], 102.000000, 32.000000);
PlayerTextDrawAlignment(playerid, ModDone[playerid], 1);
PlayerTextDrawColor(playerid, ModDone[playerid], 16843058);
PlayerTextDrawSetShadow(playerid, ModDone[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, ModDone[playerid], 255);
PlayerTextDrawFont(playerid, ModDone[playerid], 4);
PlayerTextDrawSetProportional(playerid, ModDone[playerid], 0);
PlayerTextDrawSetSelectable(playerid, ModDone[playerid], true);

ModDone_[playerid] = CreatePlayerTextDraw(playerid, 104.333320, 384.548156, "Done");
PlayerTextDrawLetterSize(playerid, ModDone_[playerid], 0.400000, 1.600000);
PlayerTextDrawAlignment(playerid, ModDone_[playerid], 2);
PlayerTextDrawColor(playerid, ModDone_[playerid], -1);
PlayerTextDrawSetShadow(playerid, ModDone_[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, ModDone_[playerid], 255);
PlayerTextDrawFont(playerid, ModDone_[playerid], 1);
PlayerTextDrawSetProportional(playerid, ModDone_[playerid], 1);

NextModshopItem[playerid] = CreatePlayerTextDraw(playerid, 381.000000, 373.191260, "LD_BEAT:right");
PlayerTextDrawTextSize(playerid, NextModshopItem[playerid], 28.000000, 27.000000);
PlayerTextDrawAlignment(playerid, NextModshopItem[playerid], 1);
PlayerTextDrawColor(playerid, NextModshopItem[playerid], -1);
PlayerTextDrawSetShadow(playerid, NextModshopItem[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, NextModshopItem[playerid], 255);
PlayerTextDrawFont(playerid, NextModshopItem[playerid], 4);
PlayerTextDrawSetProportional(playerid, NextModshopItem[playerid], 0);
PlayerTextDrawSetSelectable(playerid, NextModshopItem[playerid], true);

LastModshopItem[playerid] = CreatePlayerTextDraw(playerid, 232.000061, 373.192657, "LD_BEAT:left");
PlayerTextDrawTextSize(playerid, LastModshopItem[playerid], 28.000000, 27.000000);
PlayerTextDrawAlignment(playerid, LastModshopItem[playerid], 1);
PlayerTextDrawColor(playerid, LastModshopItem[playerid], -1);
PlayerTextDrawSetShadow(playerid, LastModshopItem[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, LastModshopItem[playerid], 255);
PlayerTextDrawFont(playerid, LastModshopItem[playerid], 4);
PlayerTextDrawSetProportional(playerid, LastModshopItem[playerid], 0);
PlayerTextDrawSetSelectable(playerid, LastModshopItem[playerid], true);

ModObject[playerid] = CreatePlayerTextDraw(playerid, 270.666870, 292.718383, "");
PlayerTextDrawTextSize(playerid, ModObject[playerid], 90.000000, 90.000000);
PlayerTextDrawAlignment(playerid, ModObject[playerid], 1);
PlayerTextDrawColor(playerid, ModObject[playerid], -1);
PlayerTextDrawSetShadow(playerid, ModObject[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, ModObject[playerid], 0);
PlayerTextDrawFont(playerid, ModObject[playerid], 5);
PlayerTextDrawSetProportional(playerid, ModObject[playerid], 0);
PlayerTextDrawSetPreviewModel(playerid, ModObject[playerid], 411);
PlayerTextDrawSetPreviewRot(playerid, ModObject[playerid], -22.500000, 0.000000, 22.500000, 1.000000);
PlayerTextDrawSetPreviewVehCol(playerid, ModObject[playerid], 1, 1);

ModName_[playerid] = CreatePlayerTextDraw(playerid, 320.333557, 377.496246, "Wika");
PlayerTextDrawLetterSize(playerid, ModName_[playerid], 0.478333, 1.940148);
PlayerTextDrawTextSize(playerid, ModName_[playerid], 8000.000000, 5000.000000);
PlayerTextDrawAlignment(playerid, ModName_[playerid], 2);
PlayerTextDrawColor(playerid, ModName_[playerid], -1);
PlayerTextDrawSetShadow(playerid, ModName_[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, ModName_[playerid], 255);
PlayerTextDrawFont(playerid, ModName_[playerid], 1);
PlayerTextDrawSetProportional(playerid, ModName_[playerid], 1);

ModName[playerid] = CreatePlayerTextDraw(playerid, 274.0, 371.118652, "LD_SPAC:white");//276.333221, 371.118652
PlayerTextDrawTextSize(playerid, ModName[playerid], 93.000000, 32.000000);
PlayerTextDrawAlignment(playerid, ModName[playerid], 1);
PlayerTextDrawColor(playerid, ModName[playerid], 16843058);
PlayerTextDrawSetShadow(playerid, ModName[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, ModName[playerid], 255);
PlayerTextDrawFont(playerid, ModName[playerid], 4);
PlayerTextDrawSetProportional(playerid, ModName[playerid], 0);
PlayerTextDrawSetSelectable(playerid, ModName[playerid], true);

Farbauswahl[playerid][0] = CreatePlayerTextDraw(playerid, 15.0, 204.777755, "LD_SPAC:white");
PlayerTextDrawTextSize(playerid, Farbauswahl[playerid][0], 25.000000, 26.000000);
PlayerTextDrawColor(playerid, Farbauswahl[playerid][0], -1);
PlayerTextDrawBackgroundColor(playerid, Farbauswahl[playerid][0], 0);
PlayerTextDrawFont(playerid, Farbauswahl[playerid][0], 4);
PlayerTextDrawSetSelectable(playerid, Farbauswahl[playerid][0], true);

Farbauswahl[playerid][1] = CreatePlayerTextDraw(playerid, 55.0, 204.777755, "LD_SPAC:white");
PlayerTextDrawTextSize(playerid, Farbauswahl[playerid][1], 25.000000, 26.000000);
PlayerTextDrawColor(playerid, Farbauswahl[playerid][1], 225);
PlayerTextDrawFont(playerid, Farbauswahl[playerid][1], 4);
PlayerTextDrawBackgroundColor(playerid, Farbauswahl[playerid][1], 0);
PlayerTextDrawSetSelectable(playerid, Farbauswahl[playerid][1], true);

Farbauswahl[playerid][2] = CreatePlayerTextDraw(playerid, 95.0, 204.777755, "LD_SPAC:white");
PlayerTextDrawTextSize(playerid, Farbauswahl[playerid][2], 25.000000, 26.000000);
PlayerTextDrawColor(playerid, Farbauswahl[playerid][2], Hellrot);
PlayerTextDrawFont(playerid, Farbauswahl[playerid][2], 4);
PlayerTextDrawBackgroundColor(playerid, Farbauswahl[playerid][2], 0);
PlayerTextDrawSetSelectable(playerid, Farbauswahl[playerid][2], true);

Farbauswahl[playerid][3] = CreatePlayerTextDraw(playerid, 135.0, 204.777755, "LD_SPAC:white");
PlayerTextDrawTextSize(playerid, Farbauswahl[playerid][3], 25.000000, 26.000000);
PlayerTextDrawColor(playerid, Farbauswahl[playerid][3], Hellblau);
PlayerTextDrawFont(playerid, Farbauswahl[playerid][3], 4);
PlayerTextDrawBackgroundColor(playerid, Farbauswahl[playerid][3], 0);
PlayerTextDrawSetSelectable(playerid, Farbauswahl[playerid][3], true);

Farbauswahl[playerid][4] = CreatePlayerTextDraw(playerid, 175.0, 204.777755, "LD_SPAC:white");
PlayerTextDrawTextSize(playerid, Farbauswahl[playerid][4], 25.000000, 26.000000);
PlayerTextDrawColor(playerid, Farbauswahl[playerid][4], Hellgrün);
PlayerTextDrawFont(playerid, Farbauswahl[playerid][4], 4);
PlayerTextDrawBackgroundColor(playerid, Farbauswahl[playerid][4], 0);
PlayerTextDrawSetSelectable(playerid, Farbauswahl[playerid][4], true);

Farbauswahl[playerid][5] = CreatePlayerTextDraw(playerid, 15.0, 251.236938, "LD_SPAC:white");
PlayerTextDrawTextSize(playerid, Farbauswahl[playerid][5], 25.000000, 26.000000);
PlayerTextDrawColor(playerid, Farbauswahl[playerid][5], 0xFFFF00FF);
PlayerTextDrawFont(playerid, Farbauswahl[playerid][5], 4);
PlayerTextDrawBackgroundColor(playerid, Farbauswahl[playerid][5], 0);
PlayerTextDrawSetSelectable(playerid, Farbauswahl[playerid][5], true);

Farbauswahl[playerid][6] = CreatePlayerTextDraw(playerid, 55.0, 251.236938, "LD_SPAC:white");
PlayerTextDrawTextSize(playerid, Farbauswahl[playerid][6], 25.000000, 26.000000);
PlayerTextDrawColor(playerid, Farbauswahl[playerid][6], 0x808080FF);
PlayerTextDrawFont(playerid, Farbauswahl[playerid][6], 4);
PlayerTextDrawBackgroundColor(playerid, Farbauswahl[playerid][6], 0);
PlayerTextDrawSetSelectable(playerid, Farbauswahl[playerid][6], true);

Farbauswahl[playerid][7] = CreatePlayerTextDraw(playerid, 95.0, 251.236938, "LD_SPAC:white");
PlayerTextDrawTextSize(playerid, Farbauswahl[playerid][7], 25.000000, 26.000000);
PlayerTextDrawColor(playerid, Farbauswahl[playerid][7], 0x00FFFFFF);
PlayerTextDrawFont(playerid, Farbauswahl[playerid][7], 4);
PlayerTextDrawBackgroundColor(playerid, Farbauswahl[playerid][7], 0);
PlayerTextDrawSetSelectable(playerid, Farbauswahl[playerid][7], true);

Farbauswahl[playerid][8] = CreatePlayerTextDraw(playerid, 135.0, 251.236938, "LD_SPAC:white");
PlayerTextDrawTextSize(playerid, Farbauswahl[playerid][8], 25.000000, 26.000000);
PlayerTextDrawColor(playerid, Farbauswahl[playerid][8], 0xC0C0C0FF);
PlayerTextDrawFont(playerid, Farbauswahl[playerid][8], 4);
PlayerTextDrawBackgroundColor(playerid, Farbauswahl[playerid][8], 0);
PlayerTextDrawSetSelectable(playerid, Farbauswahl[playerid][8], true);

Farbauswahl[playerid][9] = CreatePlayerTextDraw(playerid, 175.0, 251.236938, "LD_SPAC:white");
PlayerTextDrawTextSize(playerid, Farbauswahl[playerid][9], 25.000000, 26.000000);
PlayerTextDrawColor(playerid, Farbauswahl[playerid][9], 0xFFA500FF);
PlayerTextDrawFont(playerid, Farbauswahl[playerid][9], 4);
PlayerTextDrawBackgroundColor(playerid, Farbauswahl[playerid][9], 0);
PlayerTextDrawSetSelectable(playerid, Farbauswahl[playerid][9], true);

Farbauswahl[playerid][10] = CreatePlayerTextDraw(playerid, 15.0, 297.7, "LD_SPAC:white");
PlayerTextDrawTextSize(playerid, Farbauswahl[playerid][10], 25.000000, 26.000000);
PlayerTextDrawColor(playerid, Farbauswahl[playerid][10], 0x800000FF);
PlayerTextDrawFont(playerid, Farbauswahl[playerid][10], 4);
PlayerTextDrawBackgroundColor(playerid, Farbauswahl[playerid][10], 0);
PlayerTextDrawSetSelectable(playerid, Farbauswahl[playerid][10], true);

Farbauswahl[playerid][11] = CreatePlayerTextDraw(playerid, 55.0, 297.7, "LD_SPAC:white");
PlayerTextDrawTextSize(playerid, Farbauswahl[playerid][11], 25.000000, 26.000000);
PlayerTextDrawColor(playerid, Farbauswahl[playerid][11], 0xE8FFABFF);
PlayerTextDrawFont(playerid, Farbauswahl[playerid][11], 4);
PlayerTextDrawBackgroundColor(playerid, Farbauswahl[playerid][11], 0);
PlayerTextDrawSetSelectable(playerid, Farbauswahl[playerid][11], true);

Farbauswahl[playerid][12] = CreatePlayerTextDraw(playerid, 95.0, 297.7, "LD_SPAC:white");
PlayerTextDrawTextSize(playerid, Farbauswahl[playerid][12], 25.000000, 26.000000);
PlayerTextDrawColor(playerid, Farbauswahl[playerid][12], 0x800080FF);
PlayerTextDrawFont(playerid, Farbauswahl[playerid][12], 4);
PlayerTextDrawBackgroundColor(playerid, Farbauswahl[playerid][12], 0);
PlayerTextDrawSetSelectable(playerid, Farbauswahl[playerid][12], true);

Farbauswahl[playerid][13] = CreatePlayerTextDraw(playerid, 135.0, 297.7, "LD_SPAC:white");
PlayerTextDrawTextSize(playerid, Farbauswahl[playerid][13], 25.000000, 26.000000);
PlayerTextDrawColor(playerid, Farbauswahl[playerid][13], 0x00A400FF);
PlayerTextDrawFont(playerid, Farbauswahl[playerid][13], 4);
PlayerTextDrawBackgroundColor(playerid, Farbauswahl[playerid][13], 0);
PlayerTextDrawSetSelectable(playerid, Farbauswahl[playerid][13], true);

Farbauswahl[playerid][14] = CreatePlayerTextDraw(playerid, 175.0, 297.7, "LD_SPAC:white");
PlayerTextDrawTextSize(playerid, Farbauswahl[playerid][14], 25.000000, 26.000000);
PlayerTextDrawColor(playerid, Farbauswahl[playerid][14], 0xD1D8B9FF);
PlayerTextDrawFont(playerid, Farbauswahl[playerid][14], 4);
PlayerTextDrawBackgroundColor(playerid, Farbauswahl[playerid][14], 0);
PlayerTextDrawSetSelectable(playerid, Farbauswahl[playerid][14], true);

Farbauswahl[playerid][15] = CreatePlayerTextDraw(playerid, 15.0, 344.2, "LD_SPAC:white");
PlayerTextDrawTextSize(playerid, Farbauswahl[playerid][15], 25.000000, 26.000000);
PlayerTextDrawColor(playerid, Farbauswahl[playerid][15], 0xFF98CCFF);
PlayerTextDrawFont(playerid, Farbauswahl[playerid][15], 4);
PlayerTextDrawBackgroundColor(playerid, Farbauswahl[playerid][15], 0);
PlayerTextDrawSetSelectable(playerid, Farbauswahl[playerid][15], true);

Farbauswahl[playerid][16] = CreatePlayerTextDraw(playerid, 55.0, 344.2, "LD_SPAC:white");
PlayerTextDrawTextSize(playerid, Farbauswahl[playerid][16], 25.000000, 26.000000);
PlayerTextDrawColor(playerid, Farbauswahl[playerid][16], 0xFF6FB7FF);
PlayerTextDrawFont(playerid, Farbauswahl[playerid][16], 4);
PlayerTextDrawBackgroundColor(playerid, Farbauswahl[playerid][16], 0);
PlayerTextDrawSetSelectable(playerid, Farbauswahl[playerid][16], true);

Farbauswahl[playerid][17] = CreatePlayerTextDraw(playerid, 95.0, 344.2, "LD_SPAC:white");
PlayerTextDrawTextSize(playerid, Farbauswahl[playerid][17], 25.000000, 26.000000);
PlayerTextDrawColor(playerid, Farbauswahl[playerid][17], 0x000063FF);
PlayerTextDrawFont(playerid, Farbauswahl[playerid][17], 4);
PlayerTextDrawBackgroundColor(playerid, Farbauswahl[playerid][17], 0);
PlayerTextDrawSetSelectable(playerid, Farbauswahl[playerid][17], true);

Farbauswahl[playerid][18] = CreatePlayerTextDraw(playerid, 135.0, 344.2, "LD_SPAC:white");
PlayerTextDrawTextSize(playerid, Farbauswahl[playerid][18], 25.000000, 26.000000);
PlayerTextDrawColor(playerid, Farbauswahl[playerid][18], 0xC8BE54FF);
PlayerTextDrawFont(playerid, Farbauswahl[playerid][18], 4);
PlayerTextDrawBackgroundColor(playerid, Farbauswahl[playerid][18], 0);
PlayerTextDrawSetSelectable(playerid, Farbauswahl[playerid][18], true);

Farbauswahl[playerid][19] = CreatePlayerTextDraw(playerid, 175.0, 344.2, "LD_SPAC:white");
PlayerTextDrawTextSize(playerid, Farbauswahl[playerid][19], 25.000000, 26.000000);
PlayerTextDrawColor(playerid, Farbauswahl[playerid][19], -1);
PlayerTextDrawFont(playerid, Farbauswahl[playerid][19], 4);
PlayerTextDrawBackgroundColor(playerid, Farbauswahl[playerid][19], 0);
PlayerTextDrawSetSelectable(playerid, Farbauswahl[playerid][19], true);

ModshopPreis[playerid] = CreatePlayerTextDraw(playerid, 319.999908, 408.607635, "50000$");
PlayerTextDrawLetterSize(playerid, ModshopPreis[playerid], 0.400000, 1.600000);
PlayerTextDrawAlignment(playerid, ModshopPreis[playerid], 2);
PlayerTextDrawColor(playerid, ModshopPreis[playerid], -1);
PlayerTextDrawSetShadow(playerid, ModshopPreis[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, ModshopPreis[playerid], 255);
PlayerTextDrawFont(playerid, ModshopPreis[playerid], 1);
PlayerTextDrawSetProportional(playerid, ModshopPreis[playerid], 1);

Mod_Listitem1[playerid] = CreatePlayerTextDraw(playerid, 26.666572, 215.977767, "LD_SPAC:white");
PlayerTextDrawTextSize(playerid, Mod_Listitem1[playerid], 142.000000, 31.000000);
PlayerTextDrawAlignment(playerid, Mod_Listitem1[playerid], 1);
PlayerTextDrawColor(playerid, Mod_Listitem1[playerid], 16843058);
PlayerTextDrawBackgroundColor(playerid, Mod_Listitem1[playerid], 255);
PlayerTextDrawFont(playerid, Mod_Listitem1[playerid], 4);
PlayerTextDrawSetSelectable(playerid, Mod_Listitem1[playerid], true);

Mod_Listitem1_[playerid] = CreatePlayerTextDraw(playerid, 34.333320, 221.940704, "1");
PlayerTextDrawLetterSize(playerid, Mod_Listitem1_[playerid], 0.400000, 1.600000);
PlayerTextDrawAlignment(playerid, Mod_Listitem1_[playerid], 1);
PlayerTextDrawColor(playerid, Mod_Listitem1_[playerid], -1);
PlayerTextDrawBackgroundColor(playerid, Mod_Listitem1_[playerid], 255);
PlayerTextDrawSetShadow(playerid, Mod_Listitem1_[playerid], 0);
PlayerTextDrawFont(playerid, Mod_Listitem1_[playerid], 1);

Mod_Listitem2[playerid] = CreatePlayerTextDraw(playerid, 26.663242, 262.971745, "LD_SPAC:white");
PlayerTextDrawTextSize(playerid, Mod_Listitem2[playerid], 142.000000, 31.000000);
PlayerTextDrawAlignment(playerid, Mod_Listitem2[playerid], 1);
PlayerTextDrawColor(playerid, Mod_Listitem2[playerid], 16843058);
PlayerTextDrawBackgroundColor(playerid, Mod_Listitem2[playerid], 255);
PlayerTextDrawFont(playerid, Mod_Listitem2[playerid], 4);
PlayerTextDrawSetSelectable(playerid, Mod_Listitem2[playerid], true);

Mod_Listitem2_[playerid] = CreatePlayerTextDraw(playerid, 34.333320, 268.940704, "2");
PlayerTextDrawLetterSize(playerid, Mod_Listitem2_[playerid], 0.400000, 1.600000);
PlayerTextDrawAlignment(playerid, Mod_Listitem2_[playerid], 1);
PlayerTextDrawColor(playerid, Mod_Listitem2_[playerid], -1);
PlayerTextDrawBackgroundColor(playerid, Mod_Listitem2_[playerid], 255);
PlayerTextDrawSetShadow(playerid, Mod_Listitem2_[playerid], 0);
PlayerTextDrawFont(playerid, Mod_Listitem2_[playerid], 1);

Mod_Listitem3[playerid] = CreatePlayerTextDraw(playerid, 26.663242, 309.971745, "LD_SPAC:white");
PlayerTextDrawTextSize(playerid, Mod_Listitem3[playerid], 142.000000, 31.000000);
PlayerTextDrawAlignment(playerid, Mod_Listitem3[playerid], 1);
PlayerTextDrawColor(playerid, Mod_Listitem3[playerid], 16843058);
PlayerTextDrawBackgroundColor(playerid, Mod_Listitem3[playerid], 255);
PlayerTextDrawFont(playerid, Mod_Listitem3[playerid], 4);
PlayerTextDrawSetSelectable(playerid, Mod_Listitem3[playerid], true);

Mod_Listitem3_[playerid] = CreatePlayerTextDraw(playerid, 34.333320, 315.940704, "3");
PlayerTextDrawLetterSize(playerid, Mod_Listitem3_[playerid], 0.400000, 1.600000);
PlayerTextDrawAlignment(playerid, Mod_Listitem3_[playerid], 1);
PlayerTextDrawColor(playerid, Mod_Listitem3_[playerid], -1);
PlayerTextDrawSetShadow(playerid, Mod_Listitem3_[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, Mod_Listitem3_[playerid], 255);
PlayerTextDrawFont(playerid, Mod_Listitem3_[playerid], 1);

CustomModShopObjectLeft = TextDrawCreate(10.800034, 381.814849, "LD_BEAT:left");
TextDrawTextSize(CustomModShopObjectLeft, 25.000000, 25.000000);
TextDrawAlignment(CustomModShopObjectLeft, 1);
TextDrawColor(CustomModShopObjectLeft, -1);
TextDrawSetShadow(CustomModShopObjectLeft, 0);
TextDrawBackgroundColor(CustomModShopObjectLeft, 255);
TextDrawFont(CustomModShopObjectLeft, 4);
TextDrawSetProportional(CustomModShopObjectLeft, 0);
TextDrawSetSelectable(CustomModShopObjectLeft, true);

CustomModShopObjectRight = TextDrawCreate(178.799774, 381.814849, "LD_BEAT:right");
TextDrawTextSize(CustomModShopObjectRight, 25.000000, 25.000000);
TextDrawAlignment(CustomModShopObjectRight, 1);
TextDrawColor(CustomModShopObjectRight, -1);
TextDrawSetShadow(CustomModShopObjectRight, 0);
TextDrawBackgroundColor(CustomModShopObjectRight, 255);
TextDrawFont(CustomModShopObjectRight, 4);
TextDrawSetProportional(CustomModShopObjectRight, 0);
TextDrawSetSelectable(CustomModShopObjectRight, true);

//Schlüssel
Schluessel[playerid][4] = TextDrawCreate(390.666870, 105.637077, "LD_SPAC:white");
TextDrawTextSize(Schluessel[playerid][4], 13.000000, 151.000000);
TextDrawAlignment(Schluessel[playerid][4], 1);
TextDrawColor(Schluessel[playerid][4], -1061109505);
TextDrawSetShadow(Schluessel[playerid][4], 0);
TextDrawBackgroundColor(Schluessel[playerid][4], 255);
TextDrawFont(Schluessel[playerid][4], 4);
TextDrawSetProportional(Schluessel[playerid][4], 0);

Schluessel[playerid][0] = TextDrawCreate(357.333312, 275.296295, "LD_SPAC:white");
TextDrawTextSize(Schluessel[playerid][0], 98.000000, 174.000000);
TextDrawAlignment(Schluessel[playerid][0], 1);
TextDrawColor(Schluessel[playerid][0], 255);
TextDrawSetShadow(Schluessel[playerid][0], 0);
TextDrawBackgroundColor(Schluessel[playerid][0], 255);
TextDrawFont(Schluessel[playerid][0], 4);
TextDrawSetProportional(Schluessel[playerid][0], 0);

Schluessel[playerid][1] = TextDrawCreate(351.333557, 242.520841, "LD_BEAT:chit");
TextDrawTextSize(Schluessel[playerid][1], 36.000000, 66.000000);
TextDrawAlignment(Schluessel[playerid][1], 1);
TextDrawColor(Schluessel[playerid][1], 255);
TextDrawSetShadow(Schluessel[playerid][1], 0);
TextDrawBackgroundColor(Schluessel[playerid][1], 255);
TextDrawFont(Schluessel[playerid][1], 4);
TextDrawSetProportional(Schluessel[playerid][1], 0);

Schluessel[playerid][2] = TextDrawCreate(425.333648, 242.526016, "LD_BEAT:chit");
TextDrawTextSize(Schluessel[playerid][2], 36.000000, 66.000000);
TextDrawAlignment(Schluessel[playerid][2], 1);
TextDrawColor(Schluessel[playerid][2], 255);
TextDrawSetShadow(Schluessel[playerid][2], 0);
TextDrawBackgroundColor(Schluessel[playerid][2], 255);
TextDrawFont(Schluessel[playerid][2], 4);
TextDrawSetProportional(Schluessel[playerid][2], 0);

Schluessel[playerid][3] = TextDrawCreate(367.999938, 253.725799, "LD_SPAC:white");
TextDrawTextSize(Schluessel[playerid][3], 77.000000, 44.000000);
TextDrawAlignment(Schluessel[playerid][3], 1);
TextDrawColor(Schluessel[playerid][3], 255);
TextDrawSetShadow(Schluessel[playerid][3], 0);
TextDrawBackgroundColor(Schluessel[playerid][3], 255);
TextDrawFont(Schluessel[playerid][3], 4);
TextDrawSetProportional(Schluessel[playerid][3], 0);

Schluessel[playerid][5] = TextDrawCreate(363.333709, 254.555603, "LD_BEAT:chit");
TextDrawTextSize(Schluessel[playerid][5], 34.000000, 39.000000);
TextDrawAlignment(Schluessel[playerid][5], 1);
TextDrawColor(Schluessel[playerid][5], -1061109505);
TextDrawSetShadow(Schluessel[playerid][5], 0);
TextDrawBackgroundColor(Schluessel[playerid][5], 255);
TextDrawFont(Schluessel[playerid][5], 4);
TextDrawSetProportional(Schluessel[playerid][5], 0);
TextDrawSetSelectable(Schluessel[playerid][5], true);

Schluessel[playerid][6] = TextDrawCreate(393.333496, 105.637107, "LD_SPAC:white");
TextDrawTextSize(Schluessel[playerid][6], 3.000000, 128.000000);
TextDrawAlignment(Schluessel[playerid][6], 1);
TextDrawColor(Schluessel[playerid][6], -2139062017);
TextDrawSetShadow(Schluessel[playerid][6], 0);
TextDrawBackgroundColor(Schluessel[playerid][6], 255);
TextDrawFont(Schluessel[playerid][6], 4);
TextDrawSetProportional(Schluessel[playerid][6], 0);

FahrzeugBild[playerid] = TextDrawCreate(393.000061, 254.970214, "");
TextDrawTextSize(FahrzeugBild[playerid], 55.000000, 55.000000);
TextDrawAlignment(FahrzeugBild[playerid], 1);
TextDrawColor(FahrzeugBild[playerid], -1);
TextDrawSetShadow(FahrzeugBild[playerid], 0);
TextDrawFont(FahrzeugBild[playerid], 5);
TextDrawSetProportional(FahrzeugBild[playerid], 0);
TextDrawSetPreviewModel(FahrzeugBild[playerid], 500);
TextDrawSetPreviewRot(FahrzeugBild[playerid], -20.000000, 0.000000, 45.000000, 0.900000);
TextDrawSetPreviewVehCol(FahrzeugBild[playerid], 226, 226);

Zusperren[playerid] = TextDrawCreate(366.000000, 305.681518, "LD_SPAC:white");
TextDrawTextSize(Zusperren[playerid], 34.000000, 40.000000);
TextDrawAlignment(Zusperren[playerid], 1);
TextDrawColor(Zusperren[playerid], -1);
TextDrawSetShadow(Zusperren[playerid], 0);
TextDrawBackgroundColor(Zusperren[playerid], 255);
TextDrawFont(Zusperren[playerid], 4);
TextDrawSetProportional(Zusperren[playerid], 0);
TextDrawSetSelectable(Zusperren[playerid], true);

Aufsperren[playerid] = TextDrawCreate(411.666778, 305.681488, "LD_SPAC:white");
TextDrawTextSize(Aufsperren[playerid], 34.000000, 40.000000);
TextDrawAlignment(Aufsperren[playerid], 1);
TextDrawColor(Aufsperren[playerid], -1);
TextDrawSetShadow(Aufsperren[playerid], 0);
TextDrawBackgroundColor(Aufsperren[playerid], 255);
TextDrawFont(Aufsperren[playerid], 4);
TextDrawSetProportional(Aufsperren[playerid], 0);
TextDrawSetSelectable(Aufsperren[playerid], true);

Zusperren_[playerid][0] = TextDrawCreate(374.200042, 320.814788, "LD_SPAC:white");
TextDrawTextSize(Zusperren_[playerid][0], 18.110008, 18.480010);
TextDrawAlignment(Zusperren_[playerid][0], 1);
TextDrawColor(Zusperren_[playerid][0], 255);
TextDrawSetShadow(Zusperren_[playerid][0], 0);
TextDrawBackgroundColor(Zusperren_[playerid][0], 255);
TextDrawFont(Zusperren_[playerid][0], 4);
TextDrawSetProportional(Zusperren_[playerid][0], 0);

Zusperren_[playerid][1] = TextDrawCreate(376.266784, 306.344573, "O");
TextDrawLetterSize(Zusperren_[playerid][1], 0.513667, 2.813629);
TextDrawAlignment(Zusperren_[playerid][1], 1);
TextDrawColor(Zusperren_[playerid][1], 255);
TextDrawSetShadow(Zusperren_[playerid][1], 0);
TextDrawBackgroundColor(Zusperren_[playerid][1], 255);
TextDrawFont(Zusperren_[playerid][1], 1);
TextDrawSetProportional(Zusperren_[playerid][1], 1);

Zusperren_[playerid][2] = TextDrawCreate(382.149932, 328.864611, "LD_SPAC:white");
TextDrawTextSize(Zusperren_[playerid][2], 1.940014, 6.300019);
TextDrawAlignment(Zusperren_[playerid][2], 1);
TextDrawColor(Zusperren_[playerid][2], -1);
TextDrawSetShadow(Zusperren_[playerid][2], 0);
TextDrawBackgroundColor(Zusperren_[playerid][2], 255);
TextDrawFont(Zusperren_[playerid][2], 4);
TextDrawSetProportional(Zusperren_[playerid][2], 0);

Aufsperren_[playerid][0] = TextDrawCreate(374.200042+45, 320.814788, "LD_SPAC:white");
TextDrawTextSize(Aufsperren_[playerid][0], 18.110008, 18.480010);
TextDrawAlignment(Aufsperren_[playerid][0], 1);
TextDrawColor(Aufsperren_[playerid][0], 255);
TextDrawSetShadow(Aufsperren_[playerid][0], 0);
TextDrawBackgroundColor(Aufsperren_[playerid][0], 255);
TextDrawFont(Aufsperren_[playerid][0], 4);
TextDrawSetProportional(Aufsperren_[playerid][0], 0);

Aufsperren_[playerid][1] = TextDrawCreate(420.000091, 308.092529, "G");
TextDrawLetterSize(Aufsperren_[playerid][1], 0.614666, 2.873481);
TextDrawTextSize(Aufsperren_[playerid][1], 79.000000, 0.000000);
TextDrawAlignment(Aufsperren_[playerid][1], 1);
TextDrawColor(Aufsperren_[playerid][1], 255);
TextDrawSetShadow(Aufsperren_[playerid][1], 0);
TextDrawBackgroundColor(Aufsperren_[playerid][1], 255);
TextDrawFont(Aufsperren_[playerid][1], 1);
TextDrawSetProportional(Aufsperren_[playerid][1], 1);

Aufsperren_[playerid][2] = TextDrawCreate(382.149932+45, 328.864611, "LD_SPAC:white");
TextDrawTextSize(Aufsperren_[playerid][2], 1.940014, 6.300019);
TextDrawAlignment(Aufsperren_[playerid][2], 1);
TextDrawColor(Aufsperren_[playerid][2], -1);
TextDrawSetShadow(Aufsperren_[playerid][2], 0);
TextDrawBackgroundColor(Aufsperren_[playerid][2], 255);
TextDrawFont(Aufsperren_[playerid][2], 4);
TextDrawSetProportional(Aufsperren_[playerid][2], 0);

Parken_[playerid] = TextDrawCreate(366.000000, 372.363128, "LD_SPAC:white");
TextDrawTextSize(Parken_[playerid], 34.000000, 40.000000);
TextDrawAlignment(Parken_[playerid], 1);
TextDrawColor(Parken_[playerid], -1);
TextDrawSetShadow(Parken_[playerid], 0);
TextDrawBackgroundColor(Parken_[playerid], 255);
TextDrawFont(Parken_[playerid], 4);
TextDrawSetProportional(Parken_[playerid], 0);
TextDrawSetSelectable(Parken_[playerid], true);

Parken[playerid] = TextDrawCreate(373.666717, 371.533325, "");
TextDrawTextSize(Parken[playerid], 18.000000, 28.000000);
TextDrawAlignment(Parken[playerid], 1);
TextDrawColor(Parken[playerid], -1);
TextDrawBackgroundColor(Parken[playerid], 0);
TextDrawFont(Parken[playerid], 5);
TextDrawSetProportional(Parken[playerid], 0);
TextDrawSetPreviewModel(Parken[playerid], 19130);
TextDrawSetPreviewRot(Parken[playerid], 0.000000, 0.000000, 90.000000, 1.000000);

FahrzeugParkBild[playerid] = TextDrawCreate(370.666809, 384.807525, "");
TextDrawTextSize(FahrzeugParkBild[playerid], 28.000000, 39.000000);
TextDrawAlignment(FahrzeugParkBild[playerid], 1);
TextDrawColor(FahrzeugParkBild[playerid], -1);
TextDrawBackgroundColor(FahrzeugParkBild[playerid], 0);
TextDrawFont(FahrzeugParkBild[playerid], 5);
TextDrawSetProportional(FahrzeugParkBild[playerid], 0);
TextDrawSetPreviewModel(FahrzeugParkBild[playerid], 576);
TextDrawSetPreviewRot(FahrzeugParkBild[playerid], 0.000000, 0.000000, 90.000000, 1.000000);
TextDrawSetPreviewVehCol(FahrzeugParkBild[playerid], 1, 1);

UNDEFINED[playerid] = TextDrawCreate(411.666778, 372.363128, "LD_SPAC:white");
TextDrawTextSize(UNDEFINED[playerid], 34.000000, 40.000000);
TextDrawAlignment(UNDEFINED[playerid], 1);
TextDrawColor(UNDEFINED[playerid], -1);
TextDrawSetShadow(UNDEFINED[playerid], 0);
TextDrawBackgroundColor(UNDEFINED[playerid], 255);
TextDrawFont(UNDEFINED[playerid], 4);
TextDrawSetProportional(UNDEFINED[playerid], 0);
TextDrawSetSelectable(UNDEFINED[playerid], true);

MoreButton[playerid] = TextDrawCreate(369.333221, 422.555572, "LD_SPAC:white");
TextDrawTextSize(MoreButton[playerid], 76.000000, 15.000000);
TextDrawAlignment(MoreButton[playerid], 1);
TextDrawColor(MoreButton[playerid], -1);
TextDrawSetShadow(MoreButton[playerid], 0);
TextDrawBackgroundColor(MoreButton[playerid], 255);
TextDrawFont(MoreButton[playerid], 4);
TextDrawSetSelectable(MoreButton[playerid], 1);

VehicleName[playerid] = TextDrawCreate(407.333465, 423.126068, "TDEditor");
TextDrawLetterSize(VehicleName[playerid], 0.240999, 1.313777);
TextDrawTextSize(VehicleName[playerid], 0.000000, -38.000000);
TextDrawAlignment(VehicleName[playerid], 2);
TextDrawColor(VehicleName[playerid], 255);
TextDrawSetShadow(VehicleName[playerid], 0);
TextDrawBackgroundColor(VehicleName[playerid], 255);
TextDrawFont(VehicleName[playerid], 2);
TextDrawSetProportional(VehicleName[playerid], 1);

////////////////////////////////////////////////////////////////////////////////Tacho///////////////////////////////////////////////////////

	speedotimer = SetTimerEx("Speedometer",555,true, "%i", playerid);
	Tachonadeltimer = SetTimerEx("Speedo",250,true, "%i", playerid);
	Planespeedotimer = SetTimerEx("PlaneSpeedo",250, true, "%i", playerid);

Tacho[playerid][19] = TextDrawCreate(458.666564, 335.444274, "LD_POOL:ball");
TextDrawTextSize(Tacho[playerid][19], 90.540115, 108.010002);
TextDrawAlignment(Tacho[playerid][19], 1);
TextDrawColor(Tacho[playerid][19], 255);
TextDrawBackgroundColor(Tacho[playerid][19], 255);
TextDrawFont(Tacho[playerid][19], 4);

Tacho[playerid][20] = TextDrawCreate(463.999969, 341.251800, "LD_POOL:ball");
TextDrawTextSize(Tacho[playerid][20], 80.000000, 96.000000);
TextDrawAlignment(Tacho[playerid][20], 1);
TextDrawColor(Tacho[playerid][20], -1);
TextDrawBackgroundColor(Tacho[playerid][20], 255);
TextDrawFont(Tacho[playerid][20], 4);

Tacho[playerid][21] = TextDrawCreate(525.066650, 312.214599, "LD_POOL:ball");
TextDrawTextSize(Tacho[playerid][21], 110.000000, 133.000000);
TextDrawAlignment(Tacho[playerid][21], 1);
TextDrawColor(Tacho[playerid][21], 255);
TextDrawBackgroundColor(Tacho[playerid][21], 255);
TextDrawFont(Tacho[playerid][21], 4);

Tacho[playerid][22] = TextDrawCreate(531.333374, 320.096069, "LD_POOL:ball");
TextDrawTextSize(Tacho[playerid][22], 98.000000, 117.000000);
TextDrawAlignment(Tacho[playerid][22], 1);
TextDrawColor(Tacho[playerid][22], -1);
TextDrawBackgroundColor(Tacho[playerid][22], 255);
TextDrawFont(Tacho[playerid][22], 4);

Tacho[playerid][23] = TextDrawCreate(538.000000, 400.570495, "");
TextDrawTextSize(Tacho[playerid][23], 23.000000, 23.000000);
TextDrawAlignment(Tacho[playerid][23], 1);
TextDrawColor(Tacho[playerid][23], 0x808080FF);
TextDrawFont(Tacho[playerid][23], 5);
TextDrawSetPreviewModel(Tacho[playerid][23], 3812);
TextDrawSetPreviewRot(Tacho[playerid][23], -90.000000, 0.000000, -41.000000, 2.000000);
TextDrawBackgroundColor(Tacho[playerid][23], 0);

Tacho[playerid][24] = TextDrawCreate(529.000305, 382.318450, "");
TextDrawTextSize(Tacho[playerid][24], 23.000000, 23.000000);
TextDrawAlignment(Tacho[playerid][24], 1);
TextDrawColor(Tacho[playerid][24], 0x808080FF);
TextDrawFont(Tacho[playerid][24], 5);
TextDrawSetPreviewModel(Tacho[playerid][24], 3812);
TextDrawSetPreviewRot(Tacho[playerid][24], -90.000000, 0.000000, 110.000000, 2.000000);
TextDrawBackgroundColor(Tacho[playerid][24], 0);

Tacho[playerid][25] = TextDrawCreate(527.000305, 361.162719, "");
TextDrawTextSize(Tacho[playerid][25], 23.000000, 23.000000);
TextDrawAlignment(Tacho[playerid][25], 1);
TextDrawColor(Tacho[playerid][25], 0x808080FF);
TextDrawFont(Tacho[playerid][25], 5);
TextDrawSetPreviewModel(Tacho[playerid][25], 3812);
TextDrawSetPreviewRot(Tacho[playerid][25], -90.000000, 0.000000, -99.000000, 2.000000);
TextDrawBackgroundColor(Tacho[playerid][25], 0);

Tacho[playerid][26] = TextDrawCreate(532.000183, 340.421966, "");
TextDrawTextSize(Tacho[playerid][26], 23.000000, 23.000000);
TextDrawAlignment(Tacho[playerid][26], 1);
TextDrawColor(Tacho[playerid][26], 0x808080FF);
TextDrawFont(Tacho[playerid][26], 5);
TextDrawSetPreviewModel(Tacho[playerid][26], 3812);
TextDrawSetPreviewRot(Tacho[playerid][26], -90.000000, 0.000000, 57.000000, 2.000000);
TextDrawBackgroundColor(Tacho[playerid][26], 0);

Tacho[playerid][27] = TextDrawCreate(544.000122, 324.658874, "");
TextDrawTextSize(Tacho[playerid][27], 23.000000, 23.000000);
TextDrawAlignment(Tacho[playerid][27], 1);
TextDrawColor(Tacho[playerid][27], 0x808080FF);
TextDrawFont(Tacho[playerid][27], 5);
TextDrawSetPreviewModel(Tacho[playerid][27], 3812);
TextDrawSetPreviewRot(Tacho[playerid][27], -90.000000, 0.000000, 30.000000, 2.000000);
TextDrawBackgroundColor(Tacho[playerid][27], 0);

Tacho[playerid][28] = TextDrawCreate(560.000122, 315.532928, "");
TextDrawTextSize(Tacho[playerid][28], 23.000000, 23.000000);
TextDrawAlignment(Tacho[playerid][28], 1);
TextDrawColor(Tacho[playerid][28], 0x808080FF);
TextDrawFont(Tacho[playerid][28], 5);
TextDrawSetPreviewModel(Tacho[playerid][28], 3812);
TextDrawSetPreviewRot(Tacho[playerid][28], -90.000000, 0.000000, 10.000000, 2.000000);
TextDrawBackgroundColor(Tacho[playerid][28], 0);

Tacho[playerid][29] = TextDrawCreate(577.666748, 315.947753, "");
TextDrawTextSize(Tacho[playerid][29], 23.000000, 23.000000);
TextDrawAlignment(Tacho[playerid][29], 1);
TextDrawColor(Tacho[playerid][29], 0x808080FF);
TextDrawFont(Tacho[playerid][29], 5);
TextDrawSetPreviewModel(Tacho[playerid][29], 3812);
TextDrawSetPreviewRot(Tacho[playerid][29], -90.000000, 0.000000, -11.000000, 2.000000);
TextDrawBackgroundColor(Tacho[playerid][29], 0);

Tacho[playerid][30] = TextDrawCreate(593.999816, 324.658905, "");
TextDrawTextSize(Tacho[playerid][30], 23.000000, 23.000000);
TextDrawAlignment(Tacho[playerid][30], 1);
TextDrawColor(Tacho[playerid][30], 0x808080FF);
TextDrawFont(Tacho[playerid][30], 5);
TextDrawSetPreviewModel(Tacho[playerid][30], 3812);
TextDrawSetPreviewRot(Tacho[playerid][30], -90.000000, 0.000000, -32.000000, 2.000000);
TextDrawBackgroundColor(Tacho[playerid][30], 0);

Tacho[playerid][31] = TextDrawCreate(605.666503, 340.421966, "");
TextDrawTextSize(Tacho[playerid][31], 23.000000, 23.000000);
TextDrawAlignment(Tacho[playerid][31], 1);
TextDrawColor(Tacho[playerid][31], 0x808080FF);
TextDrawFont(Tacho[playerid][31], 5);
TextDrawSetPreviewModel(Tacho[playerid][31], 3812);
TextDrawSetPreviewRot(Tacho[playerid][31], -90.000000, 0.000000, -55.000000, 2.000000);
TextDrawBackgroundColor(Tacho[playerid][31], 0);

Tacho[playerid][32] = TextDrawCreate(610.666137, 361.577606, "");
TextDrawTextSize(Tacho[playerid][32], 23.000000, 23.000000);
TextDrawAlignment(Tacho[playerid][32], 1);
TextDrawColor(Tacho[playerid][32], 0x808080FF);
TextDrawFont(Tacho[playerid][32], 5);
TextDrawSetPreviewModel(Tacho[playerid][32], 3812);
TextDrawSetPreviewRot(Tacho[playerid][32], -90.000000, 0.000000, -85.000000, 2.000000);
TextDrawBackgroundColor(Tacho[playerid][32], 0);

Tacho[playerid][33] = TextDrawCreate(609.332824, 382.733245, "");
TextDrawTextSize(Tacho[playerid][33], 23.000000, 23.000000);
TextDrawAlignment(Tacho[playerid][33], 1);
TextDrawColor(Tacho[playerid][33], 0x808080FF);
TextDrawFont(Tacho[playerid][33], 5);
TextDrawSetPreviewModel(Tacho[playerid][33], 3812);
TextDrawSetPreviewRot(Tacho[playerid][33], -90.000000, 0.000000, -109.000000, 2.000000);
TextDrawBackgroundColor(Tacho[playerid][33], 0);

Tacho[playerid][34] = TextDrawCreate(599.999633, 400.985168, "");
TextDrawTextSize(Tacho[playerid][34], 23.000000, 23.000000);
TextDrawAlignment(Tacho[playerid][34], 1);
TextDrawColor(Tacho[playerid][34], 0x808080FF);
TextDrawFont(Tacho[playerid][34], 5);
TextDrawSetPreviewModel(Tacho[playerid][34], 3812);
TextDrawSetPreviewRot(Tacho[playerid][34], -90.000000, 0.000000, -133.000000, 2.000000);
TextDrawBackgroundColor(Tacho[playerid][34], 0);

Tacho[playerid][35] = TextDrawCreate(530.999633, 393.103607, "");
TextDrawTextSize(Tacho[playerid][35], 23.000000, 23.000000);
TextDrawAlignment(Tacho[playerid][35], 1);
TextDrawColor(Tacho[playerid][35], 0x808080FF);
TextDrawSetShadow(Tacho[playerid][35], 0);
TextDrawFont(Tacho[playerid][35], 5);
TextDrawSetProportional(Tacho[playerid][35], 0);
TextDrawSetPreviewModel(Tacho[playerid][35], 3812);
TextDrawSetPreviewRot(Tacho[playerid][35], -90.000000, 0.000000, 126.000000, 3.000000);
TextDrawBackgroundColor(Tacho[playerid][35], 0);

Tacho[playerid][36] = TextDrawCreate(525.666442, 371.947937, "");
TextDrawTextSize(Tacho[playerid][36], 23.000000, 23.000000);
TextDrawAlignment(Tacho[playerid][36], 1);
TextDrawColor(Tacho[playerid][36], 0x808080FF);
TextDrawSetShadow(Tacho[playerid][36], 0);
TextDrawFont(Tacho[playerid][36], 5);
TextDrawSetProportional(Tacho[playerid][36], 0);
TextDrawSetPreviewModel(Tacho[playerid][36], 3812);
TextDrawSetPreviewRot(Tacho[playerid][36], -90.000000, 0.000000, 98.000000, 3.000000);
TextDrawBackgroundColor(Tacho[playerid][36], 0);

Tacho[playerid][37] = TextDrawCreate(527.332946, 349.962677, "");
TextDrawTextSize(Tacho[playerid][37], 23.000000, 23.000000);
TextDrawAlignment(Tacho[playerid][37], 1);
TextDrawColor(Tacho[playerid][37], 0x808080FF);
TextDrawSetShadow(Tacho[playerid][37], 0);
TextDrawFont(Tacho[playerid][37], 5);
TextDrawSetProportional( Tacho[playerid][37], 0);
TextDrawSetPreviewModel(Tacho[playerid][37], 3812);
TextDrawSetPreviewRot(Tacho[playerid][37], -90.000000, 0.000000, 79.000000, 3.000000);
TextDrawBackgroundColor(Tacho[playerid][37], 0);

Tacho[playerid][38] = TextDrawCreate(536.332885, 330.881011, "");
TextDrawTextSize(Tacho[playerid][38], 23.000000, 23.000000);
TextDrawAlignment(Tacho[playerid][38], 1);
TextDrawColor(Tacho[playerid][38], 0x808080FF);
TextDrawSetShadow(Tacho[playerid][38], 0);
TextDrawFont(Tacho[playerid][38], 5);
TextDrawSetProportional(Tacho[playerid][38], 0);
TextDrawSetPreviewModel(Tacho[playerid][38], 3812);
TextDrawSetPreviewRot(Tacho[playerid][38], -90.000000, 0.000000, 44.000000, 3.000000);
TextDrawBackgroundColor(Tacho[playerid][38], 0);

Tacho[playerid][39] = TextDrawCreate(550.999633, 318.021575, "");
TextDrawTextSize(Tacho[playerid][39], 23.000000, 23.000000);
TextDrawAlignment(Tacho[playerid][39], 1);
TextDrawColor(Tacho[playerid][39], 0x808080FF);
TextDrawSetShadow(Tacho[playerid][39], 0);
TextDrawFont(Tacho[playerid][39], 5);
TextDrawSetProportional(Tacho[playerid][39], 0);
TextDrawSetPreviewModel(Tacho[playerid][39], 3812);
TextDrawSetPreviewRot(Tacho[playerid][39], -90.000000, 0.000000, 20.000000, 3.000000);
TextDrawBackgroundColor(Tacho[playerid][39], 0);

Tacho[playerid][40] = TextDrawCreate(568.999572, 313.458587, "");
TextDrawTextSize(Tacho[playerid][40], 23.000000, 23.000000);
TextDrawAlignment(Tacho[playerid][40], 1);
TextDrawColor(Tacho[playerid][40], 0x808080FF);
TextDrawSetShadow(Tacho[playerid][40], 0);
TextDrawFont(Tacho[playerid][40], 5);
TextDrawSetProportional(Tacho[playerid][40], 0);
TextDrawSetPreviewModel(Tacho[playerid][40], 3812);
TextDrawSetPreviewRot(Tacho[playerid][40], -90.000000, 0.000000, 0.000000, 3.000000);
TextDrawBackgroundColor(Tacho[playerid][40], 0);

Tacho[playerid][41] = TextDrawCreate(586.666198, 318.021545, "");
TextDrawTextSize(Tacho[playerid][41], 23.000000, 23.000000);
TextDrawAlignment(Tacho[playerid][41], 1);
TextDrawColor(Tacho[playerid][41], 0x808080FF);
TextDrawSetShadow(Tacho[playerid][41], 0);
TextDrawFont(Tacho[playerid][41], 5);
TextDrawSetProportional(Tacho[playerid][41], 0);
TextDrawSetPreviewModel(Tacho[playerid][41], 3812);
TextDrawSetPreviewRot(Tacho[playerid][41], -90.000000, 0.000000, -21.000000, 3.000000);
TextDrawBackgroundColor(Tacho[playerid][41], 0);

Tacho[playerid][42] = TextDrawCreate(601.332763, 331.295745, "");
TextDrawTextSize(Tacho[playerid][42], 23.000000, 23.000000);
TextDrawAlignment(Tacho[playerid][42], 1);
TextDrawColor(Tacho[playerid][42], 0x808080FF);
TextDrawSetShadow(Tacho[playerid][42], 0);
TextDrawFont(Tacho[playerid][42], 5);
TextDrawSetProportional(Tacho[playerid][42], 0);
TextDrawSetPreviewModel(Tacho[playerid][42], 3812);
TextDrawSetPreviewRot(Tacho[playerid][42], -90.000000, 0.000000, -43.000000, 3.000000);
TextDrawBackgroundColor(Tacho[playerid][42], 0);

Tacho[playerid][43] = TextDrawCreate(610.332458, 349.962432, "");
TextDrawTextSize(Tacho[playerid][43], 23.000000, 23.000000);
TextDrawAlignment(Tacho[playerid][43], 1);
TextDrawColor(Tacho[playerid][43], 0x808080FF);
TextDrawSetShadow(Tacho[playerid][43], 0);
TextDrawFont(Tacho[playerid][43], 5);
TextDrawSetProportional(Tacho[playerid][43], 0);
TextDrawSetPreviewModel(Tacho[playerid][43], 3812);
TextDrawSetPreviewRot(Tacho[playerid][43], -90.000000, 0.000000, -65.000000, 3.000000);
TextDrawBackgroundColor(Tacho[playerid][43], 0);

Tacho[playerid][44] = TextDrawCreate(612.332214, 371.947662, "");
TextDrawTextSize(Tacho[playerid][44], 23.000000, 23.000000);
TextDrawAlignment(Tacho[playerid][44], 1);
TextDrawColor(Tacho[playerid][44], 0x808080FF);
TextDrawSetShadow(Tacho[playerid][44], 0);
TextDrawFont(Tacho[playerid][44], 5);
TextDrawSetProportional(Tacho[playerid][44], 0);
TextDrawSetPreviewModel(Tacho[playerid][44], 3812);
TextDrawSetPreviewRot(Tacho[playerid][44], -90.000000, 0.000000, -97.000000, 3.000000);
TextDrawBackgroundColor(Tacho[playerid][44], 0);

Tacho[playerid][45] = TextDrawCreate(606.665588, 393.103363, "");
TextDrawTextSize(Tacho[playerid][45], 23.000000, 23.000000);
TextDrawAlignment(Tacho[playerid][45], 1);
TextDrawColor(Tacho[playerid][45], 0x808080FF);
TextDrawSetShadow(Tacho[playerid][45], 0);
TextDrawFont(Tacho[playerid][45], 5);
TextDrawSetProportional(Tacho[playerid][45], 0);
TextDrawSetPreviewModel(Tacho[playerid][45], 3812);
TextDrawSetPreviewRot(Tacho[playerid][45], -90.000000, 0.000000, -125.000000, 3.000000);
TextDrawBackgroundColor(Tacho[playerid][45], 0);

Tacho[playerid][46] = TextDrawCreate(468.331909, 348.303253, "");
TextDrawTextSize(Tacho[playerid][46], 23.000000, 23.000000);
TextDrawAlignment(Tacho[playerid][46], 1);
TextDrawColor(Tacho[playerid][46], 0x808080FF);
TextDrawSetShadow(Tacho[playerid][46], 0);
TextDrawFont(Tacho[playerid][46], 5);
TextDrawSetProportional(Tacho[playerid][46], 0);
TextDrawSetPreviewModel(Tacho[playerid][46], 3812);
TextDrawSetPreviewRot(Tacho[playerid][46], -90.000000, 0.000000, 45.000000, 2.500000);
TextDrawBackgroundColor(Tacho[playerid][46], 0);

Tacho[playerid][47] = TextDrawCreate(471.433441, 398.966705, "LD_SPAC:white");
TextDrawTextSize(Tacho[playerid][47], 56.000000, 6.000000);
TextDrawAlignment(Tacho[playerid][47], 1);
TextDrawColor(Tacho[playerid][47], 255);
TextDrawSetShadow(Tacho[playerid][47], 0);
TextDrawFont(Tacho[playerid][47], 4);
TextDrawSetProportional(Tacho[playerid][47], 0);

Tacho[playerid][48] = TextDrawCreate(499.600097, 398.237097, ":D");
TextDrawLetterSize(Tacho[playerid][48], 0.124000, 0.674961);
TextDrawTextSize(Tacho[playerid][48], 23.000000, -20.000000);
TextDrawAlignment(Tacho[playerid][48], 2);
TextDrawColor(Tacho[playerid][48], 0x808080FF);
TextDrawSetShadow(Tacho[playerid][48], 0);
TextDrawFont(Tacho[playerid][48], 1);
TextDrawSetProportional(Tacho[playerid][48], 1);

KMH[playerid] = CreatePlayerTextDraw(playerid, 579.666320, 353.022186, "000_km/h");
PlayerTextDrawLetterSize(playerid, KMH[playerid], 0.161329, 1.060739);
PlayerTextDrawTextSize(playerid, KMH[playerid], 0.000000, 30.000000);
PlayerTextDrawAlignment(playerid, KMH[playerid], 2);
PlayerTextDrawColor(playerid, KMH[playerid], 0x808080FF);
PlayerTextDrawUseBox(playerid, KMH[playerid], 1);
PlayerTextDrawBoxColor(playerid, KMH[playerid], 255);
PlayerTextDrawSetShadow(playerid, KMH[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, KMH[playerid], 255);
PlayerTextDrawFont(playerid, KMH[playerid], 1);
PlayerTextDrawSetProportional(playerid, KMH[playerid], 1);

Kilometerstand[playerid] = CreatePlayerTextDraw(playerid, 580.332824, 415.244659, "000000_km");
PlayerTextDrawLetterSize(playerid, Kilometerstand[playerid], 0.164331, 1.135406);
PlayerTextDrawTextSize(playerid, Kilometerstand[playerid], 0.000000, 35.000000);
PlayerTextDrawAlignment(playerid, Kilometerstand[playerid], 2);
PlayerTextDrawColor(playerid, Kilometerstand[playerid], 0x808080FF);
PlayerTextDrawUseBox(playerid, Kilometerstand[playerid], 1);
PlayerTextDrawBoxColor(playerid, Kilometerstand[playerid], 255);
PlayerTextDrawSetShadow(playerid, Kilometerstand[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, Kilometerstand[playerid], 255);
PlayerTextDrawFont(playerid, Kilometerstand[playerid], 1);
PlayerTextDrawSetProportional(playerid, Kilometerstand[playerid], 1);

Sprit[playerid] = CreatePlayerTextDraw(playerid, 492.665710, 366.711425, "100");
PlayerTextDrawLetterSize(playerid, Sprit[playerid], 0.172664, 1.168591);
PlayerTextDrawTextSize(playerid, Sprit[playerid], 0.000000, 12.000000);
PlayerTextDrawAlignment(playerid, Sprit[playerid], 2);
PlayerTextDrawColor(playerid, Sprit[playerid], 0x808080FF);
PlayerTextDrawUseBox(playerid, Sprit[playerid], 1);
PlayerTextDrawBoxColor(playerid, Sprit[playerid], 255);
PlayerTextDrawSetShadow(playerid, Sprit[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, Sprit[playerid], 255);
PlayerTextDrawFont(playerid, Sprit[playerid], 1);
PlayerTextDrawSetProportional(playerid, Sprit[playerid], 1);

AutoHP[playerid][0] = CreatePlayerTextDraw(playerid, 513.000427, 387.037231, "200");
PlayerTextDrawLetterSize(playerid, AutoHP[playerid][0], 0.176332, 0.758406);
PlayerTextDrawTextSize(playerid, AutoHP[playerid][0], 525.000000, 0.000000);
PlayerTextDrawAlignment(playerid, AutoHP[playerid][0], 1);
PlayerTextDrawColor(playerid, AutoHP[playerid][0], 0x808080FF);
PlayerTextDrawUseBox(playerid, AutoHP[playerid][0], 1);
PlayerTextDrawBoxColor(playerid, AutoHP[playerid][0], 255);
PlayerTextDrawSetShadow(playerid, AutoHP[playerid][0], 0);
PlayerTextDrawBackgroundColor(playerid, AutoHP[playerid][0], 255);
PlayerTextDrawFont(playerid, AutoHP[playerid][0], 1);
PlayerTextDrawSetProportional(playerid, AutoHP[playerid][0], 1);

AutoHP[playerid][1] = CreatePlayerTextDraw(playerid, 515.666564, 377.340728, "LD_SPAC:white");//Hintergrund
PlayerTextDrawTextSize(playerid, AutoHP[playerid][1], 6.000000, 6.000000);
PlayerTextDrawAlignment(playerid, AutoHP[playerid][1], 1);
PlayerTextDrawColor(playerid, AutoHP[playerid][1], -16776961);
PlayerTextDrawSetShadow(playerid, AutoHP[playerid][1], 0);
PlayerTextDrawFont(playerid, AutoHP[playerid][1], 4);
PlayerTextDrawSetProportional(playerid, AutoHP[playerid][1], 0);

AutoHP[playerid][2] = CreatePlayerTextDraw(playerid, 515.666564, 369.873931, "LD_SPAC:white");
PlayerTextDrawTextSize(playerid, AutoHP[playerid][2], 6.000000, 6.000000);
PlayerTextDrawAlignment(playerid, AutoHP[playerid][2], 1);
PlayerTextDrawColor(playerid, AutoHP[playerid][2], -5963521);
PlayerTextDrawSetShadow(playerid, AutoHP[playerid][2], 0);
PlayerTextDrawFont(playerid, AutoHP[playerid][2], 4);
PlayerTextDrawSetProportional(playerid, AutoHP[playerid][2], 0);

AutoHP[playerid][3] = CreatePlayerTextDraw(playerid, 515.666564, 362.407134, "LD_SPAC:white");
PlayerTextDrawTextSize(playerid, AutoHP[playerid][3], 6.000000, 6.000000);
PlayerTextDrawAlignment(playerid, AutoHP[playerid][3], 1);
PlayerTextDrawColor(playerid, AutoHP[playerid][3], 16711935);
PlayerTextDrawSetShadow(playerid, AutoHP[playerid][3], 0);
PlayerTextDrawFont(playerid, AutoHP[playerid][3], 4);
PlayerTextDrawSetProportional(playerid, AutoHP[playerid][3], 0);

AutoHP[playerid][4] = CreatePlayerTextDraw(playerid, 515.666564, 354.940337, "LD_SPAC:white");
PlayerTextDrawTextSize(playerid, AutoHP[playerid][4], 6.000000, 6.000000);
PlayerTextDrawAlignment(playerid, AutoHP[playerid][4], 1);
PlayerTextDrawColor(playerid, AutoHP[playerid][4], -1);
PlayerTextDrawSetShadow(playerid, AutoHP[playerid][4], 0);
PlayerTextDrawFont(playerid, AutoHP[playerid][4], 4);
PlayerTextDrawSetProportional(playerid, AutoHP[playerid][4], 0);

/*AutoHP[playerid] = CreatePlayerTextDraw(playerid, 512.999084, 407.778137, "100_%");
PlayerTextDrawLetterSize(playerid, AutoHP[playerid], 0.172664, 1.168591);
PlayerTextDrawTextSize(playerid, AutoHP[playerid], 0.000000, 19.000000);
PlayerTextDrawAlignment(playerid, AutoHP[playerid], 2);
PlayerTextDrawColor(playerid, AutoHP[playerid], -1);
PlayerTextDrawUseBox(playerid, AutoHP[playerid], 1);
PlayerTextDrawBoxColor(playerid, AutoHP[playerid], 255);
PlayerTextDrawSetShadow(playerid, AutoHP[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, AutoHP[playerid], 255);
PlayerTextDrawFont(playerid, AutoHP[playerid], 1);
PlayerTextDrawSetProportional(playerid, AutoHP[playerid], 1);*/

Tachonadel[playerid]= CreatePlayerTextDraw(playerid, 516.333007, 327.148559, "");
PlayerTextDrawSetPreviewRot(playerid, Tachonadel[playerid], 0.000000, 132.500000, 0.000000, 2.00000);
PlayerTextDrawTextSize(playerid, Tachonadel[playerid], 120.000000, 150.000000);
PlayerTextDrawAlignment(playerid, Tachonadel[playerid], 1);
PlayerTextDrawColor(playerid, Tachonadel[playerid], -1);
PlayerTextDrawSetShadow(playerid, Tachonadel[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, Tachonadel[playerid],0);
PlayerTextDrawFont(playerid, Tachonadel[playerid], 5);
PlayerTextDrawSetProportional(playerid, Tachonadel[playerid], 0);
PlayerTextDrawSetPreviewModel(playerid, Tachonadel[playerid], 19348);

Spritnadel[playerid]= CreatePlayerTextDraw(playerid, 449.666534, 351.622955, "");
PlayerTextDrawSetPreviewRot(playerid, Spritnadel[playerid], 0.000000, 90.000000, 0.000000, 2.00000);
PlayerTextDrawTextSize(playerid, Spritnadel[playerid], 102.000000, 112.000000);
PlayerTextDrawAlignment(playerid, Spritnadel[playerid], 1);
PlayerTextDrawColor(playerid, Spritnadel[playerid], -1);
PlayerTextDrawSetShadow(playerid, Spritnadel[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, Spritnadel[playerid],0);
PlayerTextDrawFont(playerid, Spritnadel[playerid], 5);
PlayerTextDrawSetProportional(playerid, Spritnadel[playerid], 0);
PlayerTextDrawSetPreviewModel(playerid, Spritnadel[playerid], 19348);

Tacho_Mitte[playerid] = CreatePlayerTextDraw(playerid, 572.366394, 369.588958, "ld_pool:ball");
PlayerTextDrawTextSize(playerid, Tacho_Mitte[playerid], 15.000000, 17.000000);
PlayerTextDrawAlignment(playerid, Tacho_Mitte[playerid], 1);
PlayerTextDrawColor(playerid, Tacho_Mitte[playerid], 255);
PlayerTextDrawSetShadow(playerid, Tacho_Mitte[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, Tacho_Mitte[playerid], 255);
PlayerTextDrawFont(playerid, Tacho_Mitte[playerid], 4);
PlayerTextDrawSetProportional(playerid, Tacho_Mitte[playerid], 0);

Sprit_Mitte[playerid] = CreatePlayerTextDraw(playerid, 498.033020, 382.863098, "ld_pool:ball");
PlayerTextDrawTextSize(playerid, Sprit_Mitte[playerid], 11.500000, 13.500000);
PlayerTextDrawAlignment(playerid, Sprit_Mitte[playerid], 1);
PlayerTextDrawColor(playerid, Sprit_Mitte[playerid], 255);
PlayerTextDrawSetShadow(playerid, Sprit_Mitte[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, Sprit_Mitte[playerid], 255);
PlayerTextDrawFont(playerid, Sprit_Mitte[playerid], 4);
PlayerTextDrawSetProportional(playerid, Sprit_Mitte[playerid], 0);

Tacho[playerid][0] = TextDrawCreate(553.666564, 400.310791, "0");
TextDrawLetterSize(Tacho[playerid][0], 0.156332, 1.317926);
TextDrawTextSize(Tacho[playerid][0], -146.000000, 0.000000);
TextDrawAlignment(Tacho[playerid][0], 1);
TextDrawColor(Tacho[playerid][0], 0x808080FF);
TextDrawSetShadow(Tacho[playerid][0], 0);
TextDrawBackgroundColor(Tacho[playerid][0], 255);
TextDrawFont(Tacho[playerid][0], 1);
TextDrawSetProportional(Tacho[playerid][0], 1);

Tacho[playerid][1] = TextDrawCreate(545.666748, 383.718109, "20");
TextDrawLetterSize(Tacho[playerid][1], 0.156332, 1.317926);
TextDrawTextSize(Tacho[playerid][1], -146.000000, 0.000000);
TextDrawAlignment(Tacho[playerid][1], 1);
TextDrawColor(Tacho[playerid][1], 0x808080FF);
TextDrawSetShadow(Tacho[playerid][1], 0);
TextDrawBackgroundColor(Tacho[playerid][1], 255);
TextDrawFont(Tacho[playerid][1], 1);
TextDrawSetProportional(Tacho[playerid][1], 1);

Tacho[playerid][2] = TextDrawCreate(544.333496, 366.710601, "40");
TextDrawLetterSize(Tacho[playerid][2], 0.156332, 1.317926);
TextDrawTextSize(Tacho[playerid][2], -146.000000, 0.000000);
TextDrawAlignment(Tacho[playerid][2], 1);
TextDrawColor(Tacho[playerid][2], 0x808080FF);
TextDrawSetShadow(Tacho[playerid][2], 0);
TextDrawBackgroundColor(Tacho[playerid][2], 255);
TextDrawFont(Tacho[playerid][2], 1);
TextDrawSetProportional(Tacho[playerid][2], 1);

Tacho[playerid][3] = TextDrawCreate(548.333312, 350.117736, "60");
TextDrawLetterSize(Tacho[playerid][3], 0.156332, 1.317926);
TextDrawTextSize(Tacho[playerid][3], -146.000000, 0.000000);
TextDrawAlignment(Tacho[playerid][3], 1);
TextDrawColor(Tacho[playerid][3], 0x808080FF);
TextDrawSetShadow(Tacho[playerid][3], 0);
TextDrawBackgroundColor(Tacho[playerid][3], 255);
TextDrawFont(Tacho[playerid][3], 1);
TextDrawSetProportional(Tacho[playerid][3], 1);

Tacho[playerid][4] = TextDrawCreate(556.666503, 339.332580, "80");
TextDrawLetterSize(Tacho[playerid][4], 0.156332, 1.317926);
TextDrawTextSize(Tacho[playerid][4], -146.000000, 0.000000);
TextDrawAlignment(Tacho[playerid][4], 1);
TextDrawColor(Tacho[playerid][4], 0x808080FF);
TextDrawSetShadow(Tacho[playerid][4], 0);
TextDrawBackgroundColor(Tacho[playerid][4], 255);
TextDrawFont(Tacho[playerid][4], 1);
TextDrawSetProportional(Tacho[playerid][4], 1);

Tacho[playerid][5] = TextDrawCreate(567.999816, 333.525085, "100");
TextDrawLetterSize(Tacho[playerid][5], 0.156332, 1.317926);
TextDrawTextSize(Tacho[playerid][5], -146.000000, 0.000000);
TextDrawAlignment(Tacho[playerid][5], 1);
TextDrawColor(Tacho[playerid][5], 0x808080FF);
TextDrawSetShadow(Tacho[playerid][5], 0);
TextDrawBackgroundColor(Tacho[playerid][5], 255);
TextDrawFont(Tacho[playerid][5], 1);
TextDrawSetProportional(Tacho[playerid][5], 1);

Tacho[playerid][6] = TextDrawCreate(582.999816, 332.695495, "120");
TextDrawLetterSize(Tacho[playerid][6], 0.156332, 1.317926);
TextDrawTextSize(Tacho[playerid][6], -146.000000, 0.000000);
TextDrawAlignment(Tacho[playerid][6], 1);
TextDrawColor(Tacho[playerid][6], 0x808080FF);
TextDrawSetShadow(Tacho[playerid][6], 0);
TextDrawBackgroundColor(Tacho[playerid][6], 255);
TextDrawFont(Tacho[playerid][6], 1);
TextDrawSetProportional(Tacho[playerid][6], 1);

Tacho[playerid][7] = TextDrawCreate(594.665954, 339.332550, "140");
TextDrawLetterSize(Tacho[playerid][7], 0.156332, 1.317926);
TextDrawTextSize(Tacho[playerid][7], -146.000000, 0.000000);
TextDrawAlignment(Tacho[playerid][7], 1);
TextDrawColor(Tacho[playerid][7], 0x808080FF);
TextDrawSetShadow(Tacho[playerid][7], 0);
TextDrawBackgroundColor(Tacho[playerid][7], 255);
TextDrawFont(Tacho[playerid][7], 1);
TextDrawSetProportional(Tacho[playerid][7], 1);

Tacho[playerid][8] = TextDrawCreate(602.999328, 350.532379, "160");
TextDrawLetterSize(Tacho[playerid][8], 0.156332, 1.317926);
TextDrawTextSize(Tacho[playerid][8], -146.000000, 0.000000);
TextDrawAlignment(Tacho[playerid][8], 1);
TextDrawColor(Tacho[playerid][8], 0x808080FF);
TextDrawSetShadow(Tacho[playerid][8], 0);
TextDrawBackgroundColor(Tacho[playerid][8], 255);
TextDrawFont(Tacho[playerid][8], 1);
TextDrawSetProportional(Tacho[playerid][8], 1);

Tacho[playerid][9] = TextDrawCreate(608.332397, 367.539886, "180");
TextDrawLetterSize(Tacho[playerid][9], 0.156332, 1.317926);
TextDrawTextSize(Tacho[playerid][9], -146.000000, 0.000000);
TextDrawAlignment(Tacho[playerid][9], 1);
TextDrawColor(Tacho[playerid][9], 0x808080FF);
TextDrawSetShadow(Tacho[playerid][9], 0);
TextDrawBackgroundColor(Tacho[playerid][9], 255);
TextDrawFont(Tacho[playerid][9], 1);
TextDrawSetProportional(Tacho[playerid][9], 1);

Tacho[playerid][10] = TextDrawCreate(605.332580, 385.791870, "200");
TextDrawLetterSize(Tacho[playerid][10], 0.156332, 1.317926);
TextDrawTextSize(Tacho[playerid][10], -146.000000, 0.000000);
TextDrawAlignment(Tacho[playerid][10], 1);
TextDrawColor(Tacho[playerid][10], 0x808080FF);
TextDrawSetShadow(Tacho[playerid][10], 0);
TextDrawBackgroundColor(Tacho[playerid][10], 255);
TextDrawFont(Tacho[playerid][10], 1);
TextDrawSetProportional(Tacho[playerid][10], 1);

Tacho[playerid][11] = TextDrawCreate(596.999389, 400.725311, "220");
TextDrawLetterSize(Tacho[playerid][11], 0.156332, 1.317926);
TextDrawTextSize(Tacho[playerid][11], -146.000000, 0.000000);
TextDrawAlignment(Tacho[playerid][11], 1);
TextDrawColor(Tacho[playerid][11], 0x808080FF);
TextDrawSetShadow(Tacho[playerid][11], 0);
TextDrawBackgroundColor(Tacho[playerid][11], 255);
TextDrawFont(Tacho[playerid][11], 1);
TextDrawSetProportional(Tacho[playerid][11], 1);

Tacho[playerid][12] = TextDrawCreate(501.999389, 353.021453, "F");
TextDrawLetterSize(Tacho[playerid][12], 0.156332, 1.317926);
TextDrawTextSize(Tacho[playerid][12], -146.000000, 0.000000);
TextDrawAlignment(Tacho[playerid][12], 1);
TextDrawColor(Tacho[playerid][12], 0x808080FF);
TextDrawBackgroundColor(Tacho[playerid][12], 255);
TextDrawFont(Tacho[playerid][12], 1);
TextDrawSetProportional(Tacho[playerid][12], 1);
TextDrawSetShadow(Tacho[playerid][12], 0);

Tacho[playerid][13] = TextDrawCreate(472.666076, 382.473388, "E");
TextDrawLetterSize(Tacho[playerid][13], 0.156332, 1.317926);
TextDrawTextSize(Tacho[playerid][13], -146.000000, 0.000000);
TextDrawAlignment(Tacho[playerid][13], 1);
TextDrawColor(Tacho[playerid][13], -16776961);
TextDrawBackgroundColor(Tacho[playerid][13], 255);
TextDrawFont(Tacho[playerid][13], 1);
TextDrawSetProportional(Tacho[playerid][13], 1);
TextDrawSetOutline(Tacho[playerid][13], 1);

Tacho[playerid][14] = TextDrawCreate(465.666198, 383.717773, "-");
TextDrawLetterSize(Tacho[playerid][14], 0.510333, 0.961184);
TextDrawTextSize(Tacho[playerid][14], -1455.000000, 0.000000);
TextDrawAlignment(Tacho[playerid][14], 1);
TextDrawColor(Tacho[playerid][14], -16776961);
TextDrawSetShadow(Tacho[playerid][14], 0);
TextDrawBackgroundColor(Tacho[playerid][14], 255);
TextDrawFont(Tacho[playerid][14], 1);
TextDrawSetProportional(Tacho[playerid][14], 1);
TextDrawSetOutline(Tacho[playerid][14], 1);

Tacho[playerid][15] = TextDrawCreate(501.999572, 341.406799, "I");
TextDrawLetterSize(Tacho[playerid][15], 0.307999, 1.454815);
TextDrawTextSize(Tacho[playerid][15], -1521.000000, 0.000000);
TextDrawAlignment(Tacho[playerid][15], 1);
TextDrawColor(Tacho[playerid][15], 0x808080FF);
TextDrawSetShadow(Tacho[playerid][15], 0);
TextDrawBackgroundColor(Tacho[playerid][15], 255);
TextDrawFont(Tacho[playerid][15], 1);
TextDrawSetProportional(Tacho[playerid][15], 1);

Tacho[playerid][16] = TextDrawCreate(484.966705, 385.222320, "LD_SPAC:white");
TextDrawTextSize(Tacho[playerid][16], 4.050001, 9.000000);
TextDrawAlignment(Tacho[playerid][16], 1);
TextDrawColor(Tacho[playerid][16], -1);
TextDrawSetShadow(Tacho[playerid][16], 0);
TextDrawBackgroundColor(Tacho[playerid][16], 255);
TextDrawFont(Tacho[playerid][16], 4);
TextDrawSetProportional(Tacho[playerid][16], 0);

Tacho[playerid][17] = TextDrawCreate(485.466735, 385.822357, "LD_SPAC:white");
TextDrawTextSize(Tacho[playerid][17], 3.000000, 3.000000);
TextDrawAlignment(Tacho[playerid][17], 1);
TextDrawColor(Tacho[playerid][17], 255);
TextDrawSetShadow(Tacho[playerid][17], 0);
TextDrawBackgroundColor(Tacho[playerid][17], 255);
TextDrawFont(Tacho[playerid][17], 4);
TextDrawSetProportional(Tacho[playerid][17], 0);

Tacho[playerid][18] = TextDrawCreate(488.033508, 383.274291, "D");
TextDrawLetterSize(Tacho[playerid][18], 0.126999, 1.203112);
TextDrawAlignment(Tacho[playerid][18], 1);
TextDrawColor(Tacho[playerid][18], -1);
TextDrawSetShadow(Tacho[playerid][18], 0);
TextDrawBackgroundColor(Tacho[playerid][18], 255);
TextDrawFont(Tacho[playerid][18], 1);
TextDrawSetProportional(Tacho[playerid][18], 1);

BlinkerLinks[playerid][1] = CreatePlayerTextDraw(playerid, 472.366729, 402.144439, "LD_BEAT:chit");
PlayerTextDrawTextSize(playerid, BlinkerLinks[playerid][1], 16.600013, 19.320007);
PlayerTextDrawAlignment(playerid, BlinkerLinks[playerid][1], 1);
PlayerTextDrawColor(playerid, BlinkerLinks[playerid][1], 255);
PlayerTextDrawSetShadow(playerid, BlinkerLinks[playerid][1], 0);
PlayerTextDrawBackgroundColor(playerid, BlinkerLinks[playerid][1], 255);
PlayerTextDrawFont(playerid, BlinkerLinks[playerid][1], 4);

BlinkerLinks[playerid][0] = CreatePlayerTextDraw(playerid, 485.666046, 407.207489, "LD_BEAT:right");
PlayerTextDrawTextSize(playerid, BlinkerLinks[playerid][0], -10.000000, 9.000000);
PlayerTextDrawAlignment(playerid, BlinkerLinks[playerid][0], 1);
PlayerTextDrawColor(playerid, BlinkerLinks[playerid][0], 16711935);
PlayerTextDrawBackgroundColor(playerid, BlinkerLinks[playerid][0], 255);
PlayerTextDrawFont(playerid, BlinkerLinks[playerid][0], 4);
PlayerTextDrawSetSelectable(playerid, BlinkerLinks[playerid][0], true);

BlinkerRechts[playerid][1] = CreatePlayerTextDraw(playerid, 519.566528, 402.559234, "LD_BEAT:chit");
PlayerTextDrawTextSize(playerid, BlinkerRechts[playerid][1], 16.600013, 19.320007);
PlayerTextDrawAlignment(playerid, BlinkerRechts[playerid][1], 1);
PlayerTextDrawColor(playerid, BlinkerRechts[playerid][1], 255);
PlayerTextDrawBackgroundColor(playerid, BlinkerRechts[playerid][1], 255);
PlayerTextDrawFont(playerid, BlinkerRechts[playerid][1], 4);

BlinkerRechts[playerid][0] = CreatePlayerTextDraw(playerid, 522.666137, 407.622314, "LD_BEAT:right");
PlayerTextDrawTextSize(playerid, BlinkerRechts[playerid][0], 10.000000, 9.000000);
PlayerTextDrawAlignment(playerid, BlinkerRechts[playerid][0], 1);
PlayerTextDrawColor(playerid, BlinkerRechts[playerid][0], 16711935);
PlayerTextDrawBackgroundColor(playerid, BlinkerRechts[playerid][0], 255);
PlayerTextDrawFont(playerid, BlinkerRechts[playerid][0], 4);

Tacho[playerid][49] = TextDrawCreate(514.434020, 353.037048, "LD_SPAC:white");
TextDrawTextSize(Tacho[playerid][49], 8.459987, 32.020164);
TextDrawAlignment(Tacho[playerid][49], 1);
TextDrawColor(Tacho[playerid][49], 255);
TextDrawSetShadow(Tacho[playerid][49], 0);
TextDrawBackgroundColor(Tacho[playerid][49], 255);
TextDrawFont(Tacho[playerid][49], 4);
TextDrawSetProportional(Tacho[playerid][49], 0);

Tacho[playerid][50] = TextDrawCreate(585.333007, 361.577758, "LD_BEAT:chit");
TextDrawTextSize(Tacho[playerid][50], 22.789926, 25.919929);
TextDrawAlignment(Tacho[playerid][50], 1);
TextDrawColor(Tacho[playerid][50], 255);
TextDrawSetShadow(Tacho[playerid][50], 0);
TextDrawBackgroundColor(Tacho[playerid][50], 255);
TextDrawFont(Tacho[playerid][50], 4);
TextDrawSetProportional(Tacho[playerid][50], 0);

Tacho[playerid][51] = TextDrawCreate(583.999755, 379.414916, "LD_BEAT:chit");
TextDrawTextSize(Tacho[playerid][51], 22.789926, 25.919929);
TextDrawAlignment(Tacho[playerid][51], 1);
TextDrawColor(Tacho[playerid][51], 255);
TextDrawSetShadow(Tacho[playerid][51], 0);
TextDrawBackgroundColor(Tacho[playerid][51], 255);
TextDrawFont(Tacho[playerid][51], 4);
TextDrawSetProportional(Tacho[playerid][51], 0);

Tacho[playerid][52] = TextDrawCreate(554.000122, 379.300140, "LD_BEAT:chit");
TextDrawTextSize(Tacho[playerid][52], 22.789926, 25.919929);
TextDrawAlignment(Tacho[playerid][52], 1);
TextDrawColor(Tacho[playerid][52], 255);
TextDrawSetShadow(Tacho[playerid][52], 0);
TextDrawBackgroundColor(Tacho[playerid][52], 255);
TextDrawFont(Tacho[playerid][52], 4);
TextDrawSetProportional(Tacho[playerid][52], 0);

Tacho[playerid][53] = TextDrawCreate(550.999816, 361.992675, "LD_BEAT:chit");
TextDrawTextSize(Tacho[playerid][53], 22.789926, 25.919929);
TextDrawAlignment(Tacho[playerid][53], 1);
TextDrawColor(Tacho[playerid][53], 255);
TextDrawSetShadow(Tacho[playerid][53], 0);
TextDrawBackgroundColor(Tacho[playerid][53], 255);
TextDrawFont(Tacho[playerid][53], 4);
TextDrawSetProportional(Tacho[playerid][53], 0);

Tacho[playerid][54] = TextDrawCreate(494.000488, 407.622222, "LD_SPAC:white");
TextDrawTextSize(Tacho[playerid][54], 21.000000, 22.000000);
TextDrawAlignment(Tacho[playerid][54], 1);
TextDrawColor(Tacho[playerid][54], 255);
TextDrawSetShadow(Tacho[playerid][54], 0);
TextDrawBackgroundColor(Tacho[playerid][54], 255);
TextDrawFont(Tacho[playerid][54], 4);
TextDrawSetProportional(Tacho[playerid][54], 0);

Tacho[playerid][55] = TextDrawCreate(504.500244, 409.022430, "F");
TextDrawLetterSize(Tacho[playerid][55], 0.378333, 1.911110);
TextDrawTextSize(Tacho[playerid][55], 0.000000, -64.000000);
TextDrawAlignment(Tacho[playerid][55], 2);
TextDrawColor(Tacho[playerid][55], -1);
TextDrawSetShadow(Tacho[playerid][55], 0);
TextDrawBackgroundColor(Tacho[playerid][55], 255);
TextDrawFont(Tacho[playerid][55], 1);
TextDrawSetProportional(Tacho[playerid][55], 1);

Licht[playerid][0] = TextDrawCreate(596.733398, 366.925903, "D");
TextDrawLetterSize(Licht[playerid][0], -0.290333, 1.554370);
TextDrawAlignment(Licht[playerid][0], 1);
TextDrawColor(Licht[playerid][0], 8388863);
TextDrawSetShadow(Licht[playerid][0], 0);
TextDrawBackgroundColor(Licht[playerid][0], 255);
TextDrawFont(Licht[playerid][0], 1);
TextDrawSetProportional(Licht[playerid][0], 1);

Licht[playerid][1] = TextDrawCreate(602.231567, 365.140594, "-");
TextDrawLetterSize(Licht[playerid][1], -0.444331, 1.144371);
TextDrawAlignment(Licht[playerid][1], 1);
TextDrawColor(Licht[playerid][1], 8388863);
TextDrawSetShadow(Licht[playerid][1], 0);
TextDrawBackgroundColor(Licht[playerid][1], 255);
TextDrawFont(Licht[playerid][1], 1);
TextDrawSetProportional(Licht[playerid][1], 1);

Licht[playerid][2] = TextDrawCreate(602.231567, 370.340911, "-");
TextDrawLetterSize(Licht[playerid][2], -0.444331, 1.144371);
TextDrawAlignment(Licht[playerid][2], 1);
TextDrawColor(Licht[playerid][2], 8388863);
TextDrawSetShadow(Licht[playerid][2], 0);
TextDrawBackgroundColor(Licht[playerid][2], 255);
TextDrawFont(Licht[playerid][2], 1);
TextDrawSetProportional(Licht[playerid][2], 1);

Licht[playerid][3] = TextDrawCreate(602.231567, 367.740753, "-");
TextDrawLetterSize(Licht[playerid][3], -0.444331, 1.144371);
TextDrawAlignment(Licht[playerid][3], 1);
TextDrawColor(Licht[playerid][3], 8388863);
TextDrawSetShadow(Licht[playerid][3], 0);
TextDrawBackgroundColor(Licht[playerid][3], 255);
TextDrawFont(Licht[playerid][3], 1);
TextDrawSetProportional(Licht[playerid][3], 1);

Batterie[playerid][0] = TextDrawCreate(560.666503, 388.396484, "LD_SPAC:white");
TextDrawTextSize(Batterie[playerid][0], 9.549997, 7.699979);
TextDrawAlignment(Batterie[playerid][0], 1);
TextDrawColor(Batterie[playerid][0], -16776961);
TextDrawSetShadow(Batterie[playerid][0], 0);
TextDrawBackgroundColor(Batterie[playerid][0], 255);
TextDrawFont(Batterie[playerid][0], 4);
TextDrawSetProportional(Batterie[playerid][0], 0);

Batterie[playerid][1] = TextDrawCreate(561.066406, 388.696502, "LD_SPAC:white");
TextDrawTextSize(Batterie[playerid][1], 8.709997, 7.069979);
TextDrawAlignment(Batterie[playerid][1], 1);
TextDrawColor(Batterie[playerid][1], 255);
TextDrawSetShadow(Batterie[playerid][1], 0);
TextDrawBackgroundColor(Batterie[playerid][1], 255);
TextDrawFont(Batterie[playerid][1], 4);
TextDrawSetProportional(Batterie[playerid][1], 0);

Batterie[playerid][2] = TextDrawCreate(561.366333, 387.496429, "LD_SPAC:white");
TextDrawTextSize(Batterie[playerid][2], 1.989995, 1.189978);
TextDrawAlignment(Batterie[playerid][2], 1);
TextDrawColor(Batterie[playerid][2], -16776961);
TextDrawSetShadow(Batterie[playerid][2], 0);
TextDrawBackgroundColor(Batterie[playerid][2], 255);
TextDrawFont(Batterie[playerid][2], 4);
TextDrawSetProportional(Batterie[playerid][2], 0);

Batterie[playerid][3] = TextDrawCreate(567.064941, 387.496429, "LD_SPAC:white");
TextDrawTextSize(Batterie[playerid][3], 1.989995, 1.189978);
TextDrawAlignment(Batterie[playerid][3], 1);
TextDrawColor(Batterie[playerid][3], -16776961);
TextDrawSetShadow(Batterie[playerid][3], 0);
TextDrawBackgroundColor(Batterie[playerid][3], 255);
TextDrawFont(Batterie[playerid][3], 4);
TextDrawSetProportional(Batterie[playerid][3], 0);

Batterie[playerid][4] = TextDrawCreate(561.999816, 389.111175, "+");
TextDrawLetterSize(Batterie[playerid][4], 0.099666, 0.427555);
TextDrawTextSize(Batterie[playerid][4], -63.000000, 0.000000);
TextDrawAlignment(Batterie[playerid][4], 1);
TextDrawColor(Batterie[playerid][4], -16776961);
TextDrawSetShadow(Batterie[playerid][4], 0);
TextDrawBackgroundColor(Batterie[playerid][4], 255);
TextDrawFont(Batterie[playerid][4], 1);
TextDrawSetProportional(Batterie[playerid][4], 1);

Batterie[playerid][5] = TextDrawCreate(566.798645, 388.611145, "-");
TextDrawLetterSize(Batterie[playerid][5], 0.146666, 0.427555);
TextDrawTextSize(Batterie[playerid][5], -63.000000, 0.000000);
TextDrawAlignment(Batterie[playerid][5], 1);
TextDrawColor(Batterie[playerid][5], -16776961);
TextDrawSetShadow(Batterie[playerid][5], 0);
TextDrawBackgroundColor(Batterie[playerid][5], 255);
TextDrawFont(Batterie[playerid][5], 1);
TextDrawSetProportional(Batterie[playerid][5], 1);

Motorleuchte[playerid][0] = TextDrawCreate(558.732177, 372.277893, "LD_SPAC:white");
TextDrawTextSize(Motorleuchte[playerid][0], 6.919993, 5.389977);
TextDrawAlignment(Motorleuchte[playerid][0], 1);
TextDrawColor(Motorleuchte[playerid][0], -5963521);
TextDrawSetShadow(Motorleuchte[playerid][0], 0);
TextDrawBackgroundColor(Motorleuchte[playerid][0], 255);
TextDrawFont(Motorleuchte[playerid][0], 4);
TextDrawSetProportional(Motorleuchte[playerid][0], 0);

Motorleuchte[playerid][1] = TextDrawCreate(559.132080, 372.577911, "LD_SPAC:white");
TextDrawTextSize(Motorleuchte[playerid][1], 6.149992, 4.949976);
TextDrawAlignment(Motorleuchte[playerid][1], 1);
TextDrawColor(Motorleuchte[playerid][1], 255);
TextDrawSetShadow(Motorleuchte[playerid][1], 0);
TextDrawBackgroundColor(Motorleuchte[playerid][1], 255);
TextDrawFont(Motorleuchte[playerid][1], 4);
TextDrawSetProportional(Motorleuchte[playerid][1], 0);

Motorleuchte[playerid][2] = TextDrawCreate(560.831665, 371.477844, "LD_SPAC:white");
TextDrawTextSize(Motorleuchte[playerid][2], 1.899999, 1.000000);
TextDrawAlignment(Motorleuchte[playerid][2], 1);
TextDrawColor(Motorleuchte[playerid][2], -5963521);
TextDrawSetShadow(Motorleuchte[playerid][2], 0);
TextDrawBackgroundColor(Motorleuchte[playerid][2], 255);
TextDrawFont(Motorleuchte[playerid][2], 4);
TextDrawSetProportional(Motorleuchte[playerid][2], 0);

Motorleuchte[playerid][3] = TextDrawCreate(560.031860, 370.077758, "LD_SPAC:white");
TextDrawTextSize(Motorleuchte[playerid][3], 3.989999, 1.440000);
TextDrawAlignment(Motorleuchte[playerid][3], 1);
TextDrawColor(Motorleuchte[playerid][3], -5963521);
TextDrawSetShadow(Motorleuchte[playerid][3], 0);
TextDrawBackgroundColor(Motorleuchte[playerid][3], 255);
TextDrawFont(Motorleuchte[playerid][3], 4);
TextDrawSetProportional(Motorleuchte[playerid][3], 0);

Motorleuchte[playerid][4] = TextDrawCreate(557.832397, 373.977996, "LD_SPAC:white");
TextDrawTextSize(Motorleuchte[playerid][4], 1.240000, 1.440000);
TextDrawAlignment(Motorleuchte[playerid][4], 1);
TextDrawColor(Motorleuchte[playerid][4], -5963521);
TextDrawSetShadow(Motorleuchte[playerid][4], 0);
TextDrawBackgroundColor(Motorleuchte[playerid][4], 255);
TextDrawFont(Motorleuchte[playerid][4], 4);
TextDrawSetProportional(Motorleuchte[playerid][4], 0);

Motorleuchte[playerid][5] = TextDrawCreate(556.966003, 371.492645, "LD_SPAC:white");
TextDrawTextSize(Motorleuchte[playerid][5], 0.910000, 3.639997);
TextDrawAlignment(Motorleuchte[playerid][5], 1);
TextDrawColor(Motorleuchte[playerid][5], -5963521);
TextDrawSetShadow(Motorleuchte[playerid][5], 0);
TextDrawBackgroundColor(Motorleuchte[playerid][5], 255);
TextDrawFont(Motorleuchte[playerid][5], 4);
TextDrawSetProportional(Motorleuchte[playerid][5], 0);

Motorleuchte[playerid][6] = TextDrawCreate(565.763854, 373.292755, "LD_SPAC:white");
TextDrawTextSize(Motorleuchte[playerid][6], 0.910000, 3.089998);
TextDrawAlignment(Motorleuchte[playerid][6], 1);
TextDrawColor(Motorleuchte[playerid][6], -5963521);
TextDrawSetShadow(Motorleuchte[playerid][6], 0);
TextDrawBackgroundColor(Motorleuchte[playerid][6], 255);
TextDrawFont(Motorleuchte[playerid][6], 4);
TextDrawSetProportional(Motorleuchte[playerid][6], 0);

Motorleuchte[playerid][7] = TextDrawCreate(566.663635, 372.192687, "LD_SPAC:white");
TextDrawTextSize(Motorleuchte[playerid][7], 1.129999, 5.510000);
TextDrawAlignment(Motorleuchte[playerid][7], 1);
TextDrawColor(Motorleuchte[playerid][7], -5963521);
TextDrawSetShadow(Motorleuchte[playerid][7], 0);
TextDrawBackgroundColor(Motorleuchte[playerid][7], 255);
TextDrawFont(Motorleuchte[playerid][7], 4);
TextDrawSetProportional(Motorleuchte[playerid][7], 0);

Motorleuchte[playerid][8] = TextDrawCreate(557.265930, 374.292816, "LD_SPAC:white");
TextDrawTextSize(Motorleuchte[playerid][8], 0.910000, 3.639997);
TextDrawAlignment(Motorleuchte[playerid][8], 1);
TextDrawColor(Motorleuchte[playerid][8], -5963521);
TextDrawSetShadow(Motorleuchte[playerid][8], 0);
TextDrawBackgroundColor(Motorleuchte[playerid][8], 255);
TextDrawFont(Motorleuchte[playerid][8], 4);
TextDrawSetProportional(Motorleuchte[playerid][8], 0);

Locked[playerid][0] = TextDrawCreate(594.900146, 396.581481, "LD_BEAT:chit");
TextDrawTextSize(Locked[playerid][0], 7.619999, -8.780014);
TextDrawAlignment(Locked[playerid][0], 1);
TextDrawColor(Locked[playerid][0], -5963521);
TextDrawSetShadow(Locked[playerid][0], 0);
TextDrawBackgroundColor(Locked[playerid][0], 255);
TextDrawFont(Locked[playerid][0], 4);
TextDrawSetProportional(Locked[playerid][0], 0);

Locked[playerid][1] = TextDrawCreate(596.099853, 395.596221, "LD_BEAT:chit");
TextDrawTextSize(Locked[playerid][1], 5.140000, -6.300014);
TextDrawAlignment(Locked[playerid][1], 1);
TextDrawColor(Locked[playerid][1], 255);
TextDrawSetShadow(Locked[playerid][1], 0);
TextDrawBackgroundColor(Locked[playerid][1], 255);
TextDrawFont(Locked[playerid][1], 4);
TextDrawSetProportional(Locked[playerid][1], 0);

Locked[playerid][2] = TextDrawCreate(590.566589, 391.659271, "LD_SPAC:white");
TextDrawTextSize(Locked[playerid][2], 6.380000, 1.000000);
TextDrawAlignment(Locked[playerid][2], 1);
TextDrawColor(Locked[playerid][2], -5963521);
TextDrawSetShadow(Locked[playerid][2], 0);
TextDrawBackgroundColor(Locked[playerid][2], 255);
TextDrawFont(Locked[playerid][2], 4);
TextDrawSetProportional(Locked[playerid][2], 0);

Locked[playerid][3] = TextDrawCreate(590.566589, 392.659332, "LD_SPAC:white");
TextDrawTextSize(Locked[playerid][3], 2.660000, 0.999999);
TextDrawAlignment(Locked[playerid][3], 1);
TextDrawColor(Locked[playerid][3], -5963521);
TextDrawSetShadow(Locked[playerid][3], 0);
TextDrawBackgroundColor(Locked[playerid][3], 255);
TextDrawFont(Locked[playerid][3], 4);
TextDrawSetProportional(Locked[playerid][3], 0);

/*Tacho[playerid] = CreatePlayerTextDraw(playerid, 455.999969, 310.555694, "Tacho:Tacho");
PlayerTextDrawTextSize(playerid, Tacho[playerid], 184.000000, 140.000000);
PlayerTextDrawAlignment(playerid, Tacho[playerid], 1);
PlayerTextDrawColor(playerid, Tacho[playerid], -1);
PlayerTextDrawSetShadow(playerid, Tacho[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, Tacho[playerid], 255);
PlayerTextDrawFont(playerid, Tacho[playerid], 4);
PlayerTextDrawSetProportional(playerid, Tacho[playerid], 0);*/







Airspeeed[playerid] = CreatePlayerTextDraw(playerid, 539.999816, 333.370391, "Tacho:SteamGauge");
PlayerTextDrawTextSize(playerid, Airspeeed[playerid], 100.000000, 109.000000);
PlayerTextDrawAlignment(playerid, Airspeeed[playerid], 1);
PlayerTextDrawColor(playerid, Airspeeed[playerid], -1);
PlayerTextDrawSetShadow(playerid, Airspeeed[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, Airspeeed[playerid], 0);
PlayerTextDrawFont(playerid, Airspeeed[playerid], 4);
PlayerTextDrawSetProportional(playerid, Airspeeed[playerid], 0);

Airspeed[playerid] = CreatePlayerTextDraw(playerid, 547.999511, 343.325866, "Tacho:Airspeed");
PlayerTextDrawTextSize(playerid, Airspeed[playerid], 84.000000, 90.000000);
PlayerTextDrawAlignment(playerid, Airspeed[playerid], 1);
PlayerTextDrawColor(playerid, Airspeed[playerid], -1);
PlayerTextDrawSetShadow(playerid, Airspeed[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, Airspeed[playerid], 255);
PlayerTextDrawFont(playerid, Airspeed[playerid], 4);
PlayerTextDrawSetProportional(playerid, Airspeed[playerid], 0);

Airspeeddisplay[playerid] = CreatePlayerTextDraw(playerid, 585.666931, 392.429656, "000");
PlayerTextDrawLetterSize(playerid, Airspeeddisplay[playerid], 0.139665, 0.567109);
PlayerTextDrawTextSize(playerid, Airspeeddisplay[playerid], 594.000000, 0.000000);
PlayerTextDrawAlignment(playerid, Airspeeddisplay[playerid], 1);
PlayerTextDrawColor(playerid, Airspeeddisplay[playerid], -1);
PlayerTextDrawUseBox(playerid, Airspeeddisplay[playerid], 1);
PlayerTextDrawBoxColor(playerid, Airspeeddisplay[playerid], 255);
PlayerTextDrawSetShadow(playerid, Airspeeddisplay[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, Airspeeddisplay[playerid], 255);
PlayerTextDrawFont(playerid, Airspeeddisplay[playerid], 1);
PlayerTextDrawSetProportional(playerid, Airspeeddisplay[playerid], 1);

Airspeedindicator[playerid] = CreatePlayerTextDraw(playerid, 525.999511, 340.836730, "");
PlayerTextDrawTextSize(playerid, Airspeedindicator[playerid], 122.000000, 129.000000);
PlayerTextDrawAlignment(playerid, Airspeedindicator[playerid], 1);
PlayerTextDrawColor(playerid, Airspeedindicator[playerid], -16776961);
PlayerTextDrawSetShadow(playerid, Airspeedindicator[playerid], 0);
PlayerTextDrawFont(playerid, Airspeedindicator[playerid], 5);
PlayerTextDrawBackgroundColor(playerid, Airspeedindicator[playerid], 0);
PlayerTextDrawSetProportional(playerid, Airspeedindicator[playerid], 0);
PlayerTextDrawSetPreviewModel(playerid, Airspeedindicator[playerid], 19348);
PlayerTextDrawSetPreviewRot(playerid, Airspeedindicator[playerid], 0.000000, 325.000000, 0.000000, 2.500000);

Alittudegauge[playerid] = CreatePlayerTextDraw(playerid, 439.000061, 332.955566, "Tacho:SteamGauge");
PlayerTextDrawTextSize(playerid, Alittudegauge[playerid], 100.000000, 109.000000);
PlayerTextDrawAlignment(playerid, Alittudegauge[playerid], 1);
PlayerTextDrawColor(playerid, Alittudegauge[playerid], -1);
PlayerTextDrawSetShadow(playerid, Alittudegauge[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, Alittudegauge[playerid], 255);
PlayerTextDrawFont(playerid, Alittudegauge[playerid], 4);
PlayerTextDrawSetProportional(playerid, Alittudegauge[playerid], 0);

Altimeter[playerid] = CreatePlayerTextDraw(playerid, 450.333496, 344.570434, "Tacho:Altimeter");
PlayerTextDrawTextSize(playerid, Altimeter[playerid], 78.000000, 86.000000);
PlayerTextDrawAlignment(playerid, Altimeter[playerid], 1);
PlayerTextDrawColor(playerid, Altimeter[playerid], -1);
PlayerTextDrawSetShadow(playerid, Altimeter[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, Altimeter[playerid], 255);
PlayerTextDrawFont(playerid, Altimeter[playerid], 4);
PlayerTextDrawSetProportional(playerid, Altimeter[playerid], 0);

Altdisplay[playerid] = CreatePlayerTextDraw(playerid, 479.666992, 369.614746, "0000");
PlayerTextDrawLetterSize(playerid, Altdisplay[playerid], 0.221331, 1.089774);
PlayerTextDrawTextSize(playerid, Altdisplay[playerid], 485.000000, 0.000000);
PlayerTextDrawAlignment(playerid, Altdisplay[playerid], 1);
PlayerTextDrawColor(playerid, Altdisplay[playerid], -1);
PlayerTextDrawSetShadow(playerid, Altdisplay[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, Altdisplay[playerid], 255);
PlayerTextDrawFont(playerid, Altdisplay[playerid], 1);
PlayerTextDrawSetProportional(playerid, Altdisplay[playerid], 1);

Tausendnadel[playerid] = CreatePlayerTextDraw(playerid, 427.333007, 338.762634, "");
PlayerTextDrawTextSize(playerid, Tausendnadel[playerid], 118.000000, 139.000000);
PlayerTextDrawAlignment(playerid, Tausendnadel[playerid], 1);
PlayerTextDrawColor(playerid, Tausendnadel[playerid], -16776961);
PlayerTextDrawSetShadow(playerid, Tausendnadel[playerid], 0);
PlayerTextDrawFont(playerid, Tausendnadel[playerid], 5);
PlayerTextDrawBackgroundColor(playerid, Tausendnadel[playerid],0);
PlayerTextDrawSetProportional(playerid, Tausendnadel[playerid], 0);
PlayerTextDrawSetPreviewModel(playerid, Tausendnadel[playerid], 19348);
PlayerTextDrawSetPreviewRot(playerid, Tausendnadel[playerid], 0.000000, 0.000000, 0.000000, 2.500000);

Hundertnadel[playerid] = CreatePlayerTextDraw(playerid, 436.666320, 350.792602, "");
PlayerTextDrawTextSize(playerid, Hundertnadel[playerid], 100.000000, 110.000000);
PlayerTextDrawAlignment(playerid, Hundertnadel[playerid], 1);
PlayerTextDrawColor(playerid, Hundertnadel[playerid], -16776961);
PlayerTextDrawSetShadow(playerid, Hundertnadel[playerid], 0);
PlayerTextDrawFont(playerid, Hundertnadel[playerid], 5);
PlayerTextDrawBackgroundColor(playerid, Hundertnadel[playerid],0);
PlayerTextDrawSetProportional(playerid, Hundertnadel[playerid], 0);
PlayerTextDrawSetPreviewModel(playerid, Hundertnadel[playerid], 19348);
PlayerTextDrawSetPreviewRot(playerid, Hundertnadel[playerid], 0.000000, 0.000000, 0.000000, 2.500000);

SteigtSinkt[playerid] = CreatePlayerTextDraw(playerid, 338.999969, 332.125946, "Tacho:SteamGauge");
PlayerTextDrawTextSize(playerid, SteigtSinkt[playerid], 100.000000, 109.000000);
PlayerTextDrawAlignment(playerid, SteigtSinkt[playerid], 1);
PlayerTextDrawColor(playerid, SteigtSinkt[playerid], -1);
PlayerTextDrawSetShadow(playerid, SteigtSinkt[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, SteigtSinkt[playerid], 255);
PlayerTextDrawFont(playerid, SteigtSinkt[playerid], 4);
PlayerTextDrawSetProportional(playerid, SteigtSinkt[playerid], 0);

SteigtHintergrund[playerid] = CreatePlayerTextDraw(playerid, 486.666870, 387.296386, "LD_POOL:ball");
PlayerTextDrawTextSize(playerid, SteigtHintergrund[playerid], 6.000000, 7.000000);
PlayerTextDrawAlignment(playerid, SteigtHintergrund[playerid], 1);
PlayerTextDrawColor(playerid, SteigtHintergrund[playerid], 255);
PlayerTextDrawSetShadow(playerid, SteigtHintergrund[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, SteigtHintergrund[playerid], 255);
PlayerTextDrawFont(playerid, SteigtHintergrund[playerid], 4);
PlayerTextDrawSetProportional(playerid, SteigtHintergrund[playerid], 0);

Variometer[playerid] = CreatePlayerTextDraw(playerid, 350.000030, 343.740631, "Tacho:Variometer");
PlayerTextDrawTextSize(playerid, Variometer[playerid], 78.000000, 86.000000);
PlayerTextDrawAlignment(playerid, Variometer[playerid], 1);
PlayerTextDrawColor(playerid, Variometer[playerid], -1);
PlayerTextDrawSetShadow(playerid, Variometer[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, Variometer[playerid], 255);
PlayerTextDrawFont(playerid, Variometer[playerid], 4);
PlayerTextDrawSetProportional(playerid, Variometer[playerid], 0);

Variodisplay[playerid] = CreatePlayerTextDraw(playerid, 423.333801, 382.059234, "0000_ft/min");
PlayerTextDrawLetterSize(playerid, Variodisplay[playerid], 0.121996, 0.815994);
PlayerTextDrawTextSize(playerid, Variodisplay[playerid], 485.000000, 0.000000);
PlayerTextDrawAlignment(playerid, Variodisplay[playerid], 3);
PlayerTextDrawColor(playerid, Variodisplay[playerid], -1);
PlayerTextDrawSetShadow(playerid, Variodisplay[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, Variodisplay[playerid], 255);
PlayerTextDrawFont(playerid, Variodisplay[playerid], 1);
PlayerTextDrawSetProportional(playerid, Variodisplay[playerid], 1);

Steigtnadel[playerid] = CreatePlayerTextDraw(playerid, 337.999603, 344.570312, "");
PlayerTextDrawTextSize(playerid, Steigtnadel[playerid], 102.000000, 116.000000);
PlayerTextDrawAlignment(playerid, Steigtnadel[playerid], 1);
PlayerTextDrawColor(playerid, Steigtnadel[playerid], -16776961);
PlayerTextDrawSetShadow(playerid, Steigtnadel[playerid], 0);
PlayerTextDrawFont(playerid, Steigtnadel[playerid], 5);
PlayerTextDrawBackgroundColor(playerid, Steigtnadel[playerid],0);
PlayerTextDrawSetProportional(playerid, Steigtnadel[playerid], 0);
PlayerTextDrawSetPreviewModel(playerid, Steigtnadel[playerid], 19348);
PlayerTextDrawSetPreviewRot(playerid, Steigtnadel[playerid], 0.000000, 90.000000, 0.000000, 2.500000);

Altideckel[playerid] = CreatePlayerTextDraw(playerid, 586.666748, 385.637145, "LD_POOL:ball");
PlayerTextDrawTextSize(playerid, Altideckel[playerid], 6.000000, 7.000000);
PlayerTextDrawAlignment(playerid, Altideckel[playerid], 1);
PlayerTextDrawColor(playerid, Altideckel[playerid], 255);
PlayerTextDrawSetShadow(playerid, Altideckel[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, Altideckel[playerid], 255);
PlayerTextDrawFont(playerid, Altideckel[playerid], 4);
PlayerTextDrawSetProportional(playerid, Altideckel[playerid], 0);

Airspeeddeckel[playerid] = CreatePlayerTextDraw(playerid, 388.000091, 383.563049, "LD_POOL:ball");
PlayerTextDrawTextSize(playerid, Airspeeddeckel[playerid], 6.000000, 7.000000);
PlayerTextDrawAlignment(playerid, Airspeeddeckel[playerid], 1);
PlayerTextDrawColor(playerid, Airspeeddeckel[playerid], 255);
PlayerTextDrawSetShadow(playerid, Airspeeddeckel[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, Airspeeddeckel[playerid], 255);
PlayerTextDrawFont(playerid, Airspeeddeckel[playerid], 4);
PlayerTextDrawSetProportional(playerid, Airspeeddeckel[playerid], 0);

CRTLboard_plane[playerid] = CreatePlayerTextDraw(playerid, -19.666675, 346.644622, "LD_SPAC:white");
PlayerTextDrawTextSize(playerid, CRTLboard_plane[playerid], 56.000000, 64.000000);
PlayerTextDrawAlignment(playerid, CRTLboard_plane[playerid], 1);
PlayerTextDrawColor(playerid, CRTLboard_plane[playerid], 1094795775);
PlayerTextDrawSetShadow(playerid, CRTLboard_plane[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, CRTLboard_plane[playerid], 255);
PlayerTextDrawFont(playerid, CRTLboard_plane[playerid], 4);
PlayerTextDrawSetProportional(playerid, CRTLboard_plane[playerid], 0);

CRTLboard1_plane[playerid] = CreatePlayerTextDraw(playerid, -8.666679, 320.096343, "LD_SPAC:white");
PlayerTextDrawTextSize(playerid, CRTLboard1_plane[playerid], 56.000000, 35.000000);
PlayerTextDrawAlignment(playerid, CRTLboard1_plane[playerid], 1);
PlayerTextDrawColor(playerid, CRTLboard1_plane[playerid], 1094795775);
PlayerTextDrawSetShadow(playerid, CRTLboard1_plane[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, CRTLboard1_plane[playerid], 255);
PlayerTextDrawFont(playerid, CRTLboard1_plane[playerid], 4);
PlayerTextDrawSetProportional(playerid, CRTLboard1_plane[playerid], 0);

CRTLboard2_plane[playerid] = CreatePlayerTextDraw(playerid, -11.000013, 399.740844, "LD_SPAC:white");
PlayerTextDrawTextSize(playerid, CRTLboard2_plane[playerid], 56.000000, 35.000000);
PlayerTextDrawAlignment(playerid, CRTLboard2_plane[playerid], 1);
PlayerTextDrawColor(playerid, CRTLboard2_plane[playerid], 1094795775);
PlayerTextDrawSetShadow(playerid, CRTLboard2_plane[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, CRTLboard2_plane[playerid], 255);
PlayerTextDrawFont(playerid, CRTLboard2_plane[playerid], 4);
PlayerTextDrawSetProportional(playerid, CRTLboard2_plane[playerid], 0);

ArtHorizon[playerid] = CreatePlayerTextDraw(playerid, 12.666863, 313.459136, "Tacho:SteamGauge");
PlayerTextDrawTextSize(playerid,ArtHorizon[playerid], 114.000000, 129.000000);
PlayerTextDrawAlignment(playerid,ArtHorizon[playerid], 1);
PlayerTextDrawColor(playerid,ArtHorizon[playerid], -1);
PlayerTextDrawSetShadow(playerid,ArtHorizon[playerid], 0);
PlayerTextDrawBackgroundColor(playerid,ArtHorizon[playerid], 255);
PlayerTextDrawFont(playerid,ArtHorizon[playerid], 4);
PlayerTextDrawSetProportional(playerid,ArtHorizon[playerid], 0);

Kompass_Gauge[playerid] = CreatePlayerTextDraw(playerid, 239.000274, 332.125854, "Tacho:SteamGauge");
PlayerTextDrawTextSize(playerid, Kompass_Gauge[playerid], 100.000000, 109.000000);
PlayerTextDrawAlignment(playerid, Kompass_Gauge[playerid], 1);
PlayerTextDrawColor(playerid, Kompass_Gauge[playerid], -1);
PlayerTextDrawSetShadow(playerid, Kompass_Gauge[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, Kompass_Gauge[playerid], 255);
PlayerTextDrawFont(playerid, Kompass_Gauge[playerid], 4);
PlayerTextDrawSetProportional(playerid, Kompass_Gauge[playerid], 0);

Kompass_Hintergrund[playerid] = CreatePlayerTextDraw(playerid, 262.999893, 357.014770, "LD_SPAC:white");
PlayerTextDrawTextSize(playerid, Kompass_Hintergrund[playerid], 53.000000, 60.000000);
PlayerTextDrawAlignment(playerid, Kompass_Hintergrund[playerid], 1);
PlayerTextDrawColor(playerid, Kompass_Hintergrund[playerid], 255);
PlayerTextDrawSetShadow(playerid, Kompass_Hintergrund[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, Kompass_Hintergrund[playerid], 255);
PlayerTextDrawFont(playerid, Kompass_Hintergrund[playerid], 4);
PlayerTextDrawSetProportional(playerid, Kompass_Hintergrund[playerid], 0);

Kompass_N[playerid] = CreatePlayerTextDraw(playerid, 283.999938, 347.629608, "N");
PlayerTextDrawLetterSize(playerid, Kompass_N[playerid], 0.400000, 1.600000);
PlayerTextDrawAlignment(playerid, Kompass_N[playerid], 1);
PlayerTextDrawColor(playerid, Kompass_N[playerid], -1);
PlayerTextDrawSetShadow(playerid, Kompass_N[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, Kompass_N[playerid], 255);
PlayerTextDrawFont(playerid, Kompass_N[playerid], 1);
PlayerTextDrawSetProportional(playerid, Kompass_N[playerid], 1);

Kompass_E[playerid] = CreatePlayerTextDraw(playerid, 317.333343, 379.155700, "E");
PlayerTextDrawLetterSize(playerid, Kompass_E[playerid], 0.400000, 1.600000);
PlayerTextDrawAlignment(playerid, Kompass_E[playerid], 1);
PlayerTextDrawColor(playerid, Kompass_E[playerid], -1);
PlayerTextDrawSetShadow(playerid, Kompass_E[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, Kompass_E[playerid], 255);
PlayerTextDrawFont(playerid, Kompass_E[playerid], 1);
PlayerTextDrawSetProportional(playerid, Kompass_E[playerid], 1);

Kompass_S[playerid] = CreatePlayerTextDraw(playerid, 285.333221, 411.511352, "S");
PlayerTextDrawLetterSize(playerid, Kompass_S[playerid], 0.400000, 1.600000);
PlayerTextDrawAlignment(playerid, Kompass_S[playerid], 1);
PlayerTextDrawColor(playerid, Kompass_S[playerid], -1);
PlayerTextDrawSetShadow(playerid, Kompass_S[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, Kompass_S[playerid], 255);
PlayerTextDrawFont(playerid, Kompass_S[playerid], 1);
PlayerTextDrawSetProportional(playerid, Kompass_S[playerid], 1);

Kompass_W[playerid] = CreatePlayerTextDraw(playerid, 252.999969, 379.570434, "W");
PlayerTextDrawLetterSize(playerid, Kompass_W[playerid], 0.349666, 1.554370);
PlayerTextDrawAlignment(playerid, Kompass_W[playerid], 1);
PlayerTextDrawColor(playerid, Kompass_W[playerid], -1);
PlayerTextDrawSetShadow(playerid, Kompass_W[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, Kompass_W[playerid], 255);
PlayerTextDrawFont(playerid, Kompass_W[playerid], 1);
PlayerTextDrawSetProportional(playerid, Kompass_W[playerid], 1);

Kompass_Icon[playerid] = CreatePlayerTextDraw(playerid, 253.666580, 351.207550, "");
PlayerTextDrawTextSize(playerid, Kompass_Icon[playerid], 76.000000, 70.000000);
PlayerTextDrawAlignment(playerid, Kompass_Icon[playerid], 1);
PlayerTextDrawColor(playerid, Kompass_Icon[playerid], -1);
PlayerTextDrawSetShadow(playerid, Kompass_Icon[playerid], 0);
PlayerTextDrawFont(playerid, Kompass_Icon[playerid], 5);
PlayerTextDrawBackgroundColor(playerid, Kompass_Icon[playerid],0);
PlayerTextDrawSetProportional(playerid, Kompass_Icon[playerid], 0);
PlayerTextDrawSetPreviewModel(playerid, Kompass_Icon[playerid], 476);
PlayerTextDrawSetPreviewRot(playerid, Kompass_Icon[playerid], 90.000000, 180.000000, 0.000000, 1.000000);
PlayerTextDrawSetPreviewVehCol(playerid, Kompass_Icon[playerid], 1, 1);

Flug_Info[playerid] = CreatePlayerTextDraw(playerid, 137.000198, 332.540679, "Tacho:SteamGauge");
PlayerTextDrawTextSize(playerid, Flug_Info[playerid], 100.000000, 109.000000);
PlayerTextDrawAlignment(playerid, Flug_Info[playerid], 1);
PlayerTextDrawColor(playerid, Flug_Info[playerid], -1);
PlayerTextDrawSetShadow(playerid, Flug_Info[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, Flug_Info[playerid], 255);
PlayerTextDrawFont(playerid, Flug_Info[playerid], 4);
PlayerTextDrawSetProportional(playerid, Flug_Info[playerid], 0);

Flug_InfoHintergrund[playerid] = CreatePlayerTextDraw(playerid, 160.999908, 357.429565, "LD_SPAC:white");
PlayerTextDrawTextSize(playerid, Flug_InfoHintergrund[playerid], 53.000000, 60.000000);
PlayerTextDrawAlignment(playerid, Flug_InfoHintergrund[playerid], 1);
PlayerTextDrawColor(playerid, Flug_InfoHintergrund[playerid], 255);
PlayerTextDrawSetShadow(playerid, Flug_InfoHintergrund[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, Flug_InfoHintergrund[playerid], 255);
PlayerTextDrawFont(playerid, Flug_InfoHintergrund[playerid], 4);
PlayerTextDrawSetProportional(playerid, Flug_InfoHintergrund[playerid], 0);

Abgrenzung[playerid][1] = CreatePlayerTextDraw(playerid, 144.333419, 375.422302, "-");
PlayerTextDrawLetterSize(playerid, Abgrenzung[playerid][1], 6.089662, 0.662518);
PlayerTextDrawAlignment(playerid, Abgrenzung[playerid][1], 1);
PlayerTextDrawColor(playerid, Abgrenzung[playerid][1], -1);
PlayerTextDrawSetShadow(playerid, Abgrenzung[playerid][1], 0);
PlayerTextDrawBackgroundColor(playerid, Abgrenzung[playerid][1], 255);
PlayerTextDrawFont(playerid, Abgrenzung[playerid][1], 1);
PlayerTextDrawSetProportional(playerid, Abgrenzung[playerid][1], 1);

LFuel[playerid] = CreatePlayerTextDraw(playerid, 164.333267, 359.659423, "Fuel_L:");
PlayerTextDrawLetterSize(playerid, LFuel[playerid], 0.135666, 0.791111);
PlayerTextDrawTextSize(playerid, LFuel[playerid], -82.000000, 0.000000);
PlayerTextDrawAlignment(playerid, LFuel[playerid], 1);
PlayerTextDrawColor(playerid, LFuel[playerid], -1);
PlayerTextDrawSetShadow(playerid, LFuel[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, LFuel[playerid], 255);
PlayerTextDrawFont(playerid, LFuel[playerid], 1);
PlayerTextDrawSetProportional(playerid, LFuel[playerid], 1);

RFuel[playerid] = CreatePlayerTextDraw(playerid, 195.999862, 359.659332, "Fuel_R:");
PlayerTextDrawLetterSize(playerid, RFuel[playerid], 0.135666, 0.791111);
PlayerTextDrawTextSize(playerid, RFuel[playerid], -82.000000, 0.000000);
PlayerTextDrawAlignment(playerid, RFuel[playerid], 1);
PlayerTextDrawColor(playerid, RFuel[playerid], -1);
PlayerTextDrawSetShadow(playerid, RFuel[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, RFuel[playerid], 255);
PlayerTextDrawFont(playerid, RFuel[playerid], 1);
PlayerTextDrawSetProportional(playerid, RFuel[playerid], 1);

Fuel1[playerid] = CreatePlayerTextDraw(playerid, 164.666519, 368.370422, "100_%");
PlayerTextDrawLetterSize(playerid, Fuel1[playerid], 0.134663, 0.791109);
PlayerTextDrawTextSize(playerid, Fuel1[playerid], 222.000000, 0.000000);
PlayerTextDrawAlignment(playerid, Fuel1[playerid], 1);
PlayerTextDrawColor(playerid, Fuel1[playerid], -1);
PlayerTextDrawSetShadow(playerid, Fuel1[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, Fuel1[playerid], 255);
PlayerTextDrawFont(playerid, Fuel1[playerid], 1);
PlayerTextDrawSetProportional(playerid, Fuel1[playerid], 1);

Fuel2[playerid] = CreatePlayerTextDraw(playerid, 196.333175, 368.370422, "100_%");
PlayerTextDrawLetterSize(playerid, Fuel2[playerid], 0.134663, 0.791109);
PlayerTextDrawTextSize(playerid, Fuel2[playerid], 222.000000, 0.000000);
PlayerTextDrawAlignment(playerid, Fuel2[playerid], 1);
PlayerTextDrawColor(playerid, Fuel2[playerid], -1);
PlayerTextDrawSetShadow(playerid, Fuel2[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, Fuel2[playerid], 255);
PlayerTextDrawFont(playerid, Fuel2[playerid], 1);
PlayerTextDrawSetProportional(playerid, Fuel2[playerid], 1);

Condition[playerid] = CreatePlayerTextDraw(playerid, 158.999816, 384.133331, "Condition:");
PlayerTextDrawLetterSize(playerid, Condition[playerid], 0.135666, 0.791111);
PlayerTextDrawTextSize(playerid, Condition[playerid], -82.000000, 0.000000);
PlayerTextDrawAlignment(playerid, Condition[playerid], 1);
PlayerTextDrawColor(playerid, Condition[playerid], -1);
PlayerTextDrawSetShadow(playerid, Condition[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, Condition[playerid], 255);
PlayerTextDrawFont(playerid, Condition[playerid], 1);
PlayerTextDrawSetProportional(playerid, Condition[playerid], 1);

Zustand[playerid] = CreatePlayerTextDraw(playerid, 195.999832, 384.548065, "100%");
PlayerTextDrawLetterSize(playerid, Zustand[playerid], 0.135666, 0.791111);
PlayerTextDrawTextSize(playerid, Zustand[playerid], -82.000000, 0.000000);
PlayerTextDrawAlignment(playerid, Zustand[playerid], 1);
PlayerTextDrawColor(playerid, Zustand[playerid], -1);
PlayerTextDrawSetShadow(playerid, Zustand[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, Zustand[playerid], 255);
PlayerTextDrawFont(playerid, Zustand[playerid], 1);
PlayerTextDrawSetProportional(playerid, Zustand[playerid], 1);

Abgrenzung[playerid][2] = CreatePlayerTextDraw(playerid, 153.666763, 354.681488, "-");
PlayerTextDrawLetterSize(playerid, Abgrenzung[playerid][2], 5.388662, 0.753777);
PlayerTextDrawTextSize(playerid, Abgrenzung[playerid][2], -5585.000000, 0.000000);
PlayerTextDrawAlignment(playerid, Abgrenzung[playerid][2], 1);
PlayerTextDrawColor(playerid, Abgrenzung[playerid][2], -1);
PlayerTextDrawSetShadow(playerid, Abgrenzung[playerid][2], 0);
PlayerTextDrawBackgroundColor(playerid, Abgrenzung[playerid][2], 255);
PlayerTextDrawFont(playerid, Abgrenzung[playerid][2], 2);
PlayerTextDrawSetProportional(playerid, Abgrenzung[playerid][2], 1);

Fname[playerid] = CreatePlayerTextDraw(playerid, 187.333175, 348.459259, "Hydra");
PlayerTextDrawLetterSize(playerid, Fname[playerid], 0.135666, 0.791111);
PlayerTextDrawTextSize(playerid, Fname[playerid], -82.000000, 0.000000);
PlayerTextDrawAlignment(playerid, Fname[playerid], 2);
PlayerTextDrawColor(playerid, Fname[playerid], -1);
PlayerTextDrawSetShadow(playerid, Fname[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, Fname[playerid], 255);
PlayerTextDrawFont(playerid, Fname[playerid], 1);
PlayerTextDrawSetProportional(playerid, Fname[playerid], 1);

Abgrenzung[playerid][3] = CreatePlayerTextDraw(playerid, 143.333328, 394.503692, "-");
PlayerTextDrawLetterSize(playerid, Abgrenzung[playerid][3], 5.978998, 0.616888);
PlayerTextDrawAlignment(playerid, Abgrenzung[playerid][3], 1);
PlayerTextDrawColor(playerid, Abgrenzung[playerid][3], -1);
PlayerTextDrawSetShadow(playerid, Abgrenzung[playerid][3], 0);
PlayerTextDrawBackgroundColor(playerid, Abgrenzung[playerid][3], 255);
PlayerTextDrawFont(playerid, Abgrenzung[playerid][3], 1);
PlayerTextDrawSetProportional(playerid, Abgrenzung[playerid][3], 1);

Distance[playerid] = CreatePlayerTextDraw(playerid, 175.666412, 400.311157, "Distance:");
PlayerTextDrawLetterSize(playerid, Distance[playerid], 0.135666, 0.791111);
PlayerTextDrawTextSize(playerid, Distance[playerid], -82.000000, 0.000000);
PlayerTextDrawAlignment(playerid, Distance[playerid], 1);
PlayerTextDrawColor(playerid, Distance[playerid], -1);
PlayerTextDrawSetShadow(playerid, Distance[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, Distance[playerid], 255);
PlayerTextDrawFont(playerid, Distance[playerid], 1);
PlayerTextDrawSetProportional(playerid, Distance[playerid], 1);

KMStandFlieger[playerid] = CreatePlayerTextDraw(playerid, 199.333068, 411.096343, "0000000_NM");
PlayerTextDrawLetterSize(playerid, KMStandFlieger[playerid], 0.138997, 0.737183);
PlayerTextDrawTextSize(playerid, KMStandFlieger[playerid], -82.000000, 0.000000);
PlayerTextDrawAlignment(playerid, KMStandFlieger[playerid], 3);
PlayerTextDrawColor(playerid, KMStandFlieger[playerid], -1);
PlayerTextDrawSetShadow(playerid, KMStandFlieger[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, KMStandFlieger[playerid], 255);
PlayerTextDrawFont(playerid, KMStandFlieger[playerid], 1);
PlayerTextDrawSetProportional(playerid, KMStandFlieger[playerid], 1);

Fuelpumpen[playerid] = CreatePlayerTextDraw(playerid, 2.699625, 327.718475, "Fuel_~n~Pumps");
PlayerTextDrawLetterSize(playerid, Fuelpumpen[playerid], 0.137333, 0.513185);
PlayerTextDrawAlignment(playerid, Fuelpumpen[playerid], 1);
PlayerTextDrawColor(playerid, Fuelpumpen[playerid], -1);
PlayerTextDrawSetShadow(playerid, Fuelpumpen[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, Fuelpumpen[playerid], 255);
PlayerTextDrawFont(playerid, Fuelpumpen[playerid], 1);
PlayerTextDrawSetProportional(playerid, Fuelpumpen[playerid], 1);

FPON[playerid] = CreatePlayerTextDraw(playerid, 5.366291, 340.577789, "On");
PlayerTextDrawLetterSize(playerid, FPON[playerid], 0.137333, 0.513185);
PlayerTextDrawTextSize(playerid, FPON[playerid], 13.000000, 0.000000);
PlayerTextDrawAlignment(playerid, FPON[playerid], 1);
PlayerTextDrawColor(playerid, FPON[playerid], -1);
PlayerTextDrawUseBox(playerid, FPON[playerid], 1);
PlayerTextDrawBoxColor(playerid, FPON[playerid], 16711935);
PlayerTextDrawSetShadow(playerid, FPON[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, FPON[playerid], 16711935);
PlayerTextDrawFont(playerid, FPON[playerid], 1);
PlayerTextDrawSetProportional(playerid, FPON[playerid], 1);

FPOFF[playerid] = CreatePlayerTextDraw(playerid, 5.366291, 340.577789, "Off");
PlayerTextDrawLetterSize(playerid, FPOFF[playerid], 0.137333, 0.513185);
PlayerTextDrawTextSize(playerid, FPOFF[playerid], 13.000000, 0.000000);
PlayerTextDrawAlignment(playerid, FPOFF[playerid], 1);
PlayerTextDrawColor(playerid, FPOFF[playerid], -1);
PlayerTextDrawUseBox(playerid, FPOFF[playerid], 1);
PlayerTextDrawBoxColor(playerid, FPOFF[playerid], -16776961);
PlayerTextDrawSetShadow(playerid, FPOFF[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, FPOFF[playerid], 16711935);
PlayerTextDrawFont(playerid, FPOFF[playerid], 1);
PlayerTextDrawSetProportional(playerid, FPOFF[playerid], 1);

PEngine[playerid] = CreatePlayerTextDraw(playerid, 2.032958, 358.414764, "Engine");
PlayerTextDrawLetterSize(playerid, PEngine[playerid], 0.137333, 0.513185);
PlayerTextDrawAlignment(playerid, PEngine[playerid], 1);
PlayerTextDrawColor(playerid, PEngine[playerid], -1);
PlayerTextDrawSetShadow(playerid, PEngine[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, PEngine[playerid], 255);
PlayerTextDrawFont(playerid, PEngine[playerid], 1);
PlayerTextDrawSetProportional(playerid, PEngine[playerid], 1);

PEON[playerid] = CreatePlayerTextDraw(playerid, 5.032958, 367.540924, "On");
PlayerTextDrawLetterSize(playerid, PEON[playerid], 0.137333, 0.513185);
PlayerTextDrawTextSize(playerid, PEON[playerid], 13.000000, 0.000000);
PlayerTextDrawAlignment(playerid, PEON[playerid], 1);
PlayerTextDrawColor(playerid, PEON[playerid], -1);
PlayerTextDrawUseBox(playerid, PEON[playerid], 1);
PlayerTextDrawBoxColor(playerid, PEON[playerid], 16711935);
PlayerTextDrawSetShadow(playerid, PEON[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, PEON[playerid], 16711935);
PlayerTextDrawFont(playerid, PEON[playerid], 1);
PlayerTextDrawSetProportional(playerid, PEON[playerid], 1);

PEOFF[playerid] = CreatePlayerTextDraw(playerid, 5.032958, 367.540924, "Off");
PlayerTextDrawLetterSize(playerid, PEOFF[playerid], 0.137333, 0.513185);
PlayerTextDrawTextSize(playerid, PEOFF[playerid], 13.000000, 0.000000);
PlayerTextDrawAlignment(playerid, PEOFF[playerid], 1);
PlayerTextDrawColor(playerid, PEOFF[playerid], -1);
PlayerTextDrawUseBox(playerid, PEOFF[playerid], 1);
PlayerTextDrawBoxColor(playerid, PEOFF[playerid], -16776961);
PlayerTextDrawSetShadow(playerid, PEOFF[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, PEOFF[playerid], 16711935);
PlayerTextDrawFont(playerid, PEOFF[playerid], 1);
PlayerTextDrawSetProportional(playerid, PEOFF[playerid], 1);

LDGear[playerid] = CreatePlayerTextDraw(playerid, 0.699625, 382.888824, "Landing~n~Gear");
PlayerTextDrawLetterSize(playerid, LDGear[playerid], 0.137333, 0.513185);
PlayerTextDrawAlignment(playerid, LDGear[playerid], 1);
PlayerTextDrawColor(playerid, LDGear[playerid], -1);
PlayerTextDrawSetShadow(playerid, LDGear[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, LDGear[playerid], 255);
PlayerTextDrawFont(playerid, LDGear[playerid], 1);
PlayerTextDrawSetProportional(playerid, LDGear[playerid], 1);

LDGON[playerid] = CreatePlayerTextDraw(playerid, 3.366291, 396.992828, "Down");
PlayerTextDrawLetterSize(playerid, LDGON[playerid], 0.137333, 0.513185);
PlayerTextDrawTextSize(playerid, LDGON[playerid], 14.000000, 0.000000);
PlayerTextDrawAlignment(playerid, LDGON[playerid], 1);
PlayerTextDrawColor(playerid, LDGON[playerid], -1);
PlayerTextDrawUseBox(playerid, LDGON[playerid], 1);
PlayerTextDrawBoxColor(playerid, LDGON[playerid], 16711935);
PlayerTextDrawSetShadow(playerid, LDGON[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, LDGON[playerid], 16711935);
PlayerTextDrawFont(playerid, LDGON[playerid], 1);
PlayerTextDrawSetProportional(playerid, LDGON[playerid], 1);

LDGOFF[playerid] = CreatePlayerTextDraw(playerid, 3.366291, 396.992828, "Up");
PlayerTextDrawLetterSize(playerid, LDGOFF[playerid], 0.137333, 0.513185);
PlayerTextDrawTextSize(playerid, LDGOFF[playerid], 14.000000, 0.000000);
PlayerTextDrawAlignment(playerid, LDGOFF[playerid], 1);
PlayerTextDrawColor(playerid, LDGOFF[playerid], -1);
PlayerTextDrawUseBox(playerid, LDGOFF[playerid], 1);
PlayerTextDrawBoxColor(playerid, LDGOFF[playerid], -16776961);
PlayerTextDrawSetShadow(playerid, LDGOFF[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, LDGOFF[playerid], 16711935);
PlayerTextDrawFont(playerid, LDGOFF[playerid], 1);
PlayerTextDrawSetProportional(playerid, LDGOFF[playerid], 1);

LowFuel[playerid] = CreatePlayerTextDraw(playerid, 3.699624, 408.192687, "Low~n~Fuel");
PlayerTextDrawLetterSize(playerid, LowFuel[playerid], 0.137333, 0.513185);
PlayerTextDrawAlignment(playerid, LowFuel[playerid], 1);
PlayerTextDrawColor(playerid, LowFuel[playerid], -1);
PlayerTextDrawSetShadow(playerid, LowFuel[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, LowFuel[playerid], 255);
PlayerTextDrawFont(playerid, LowFuel[playerid], 1);
PlayerTextDrawSetProportional(playerid, LowFuel[playerid], 1);

LowFuelW[playerid] = CreatePlayerTextDraw(playerid, 2.032957, 423.541015, "Warning");
PlayerTextDrawLetterSize(playerid, LowFuelW[playerid], 0.137333, 0.513185);
PlayerTextDrawTextSize(playerid, LowFuelW[playerid], 20.000000, 0.000000);
PlayerTextDrawAlignment(playerid, LowFuelW[playerid], 1);
PlayerTextDrawColor(playerid, LowFuelW[playerid], -1);
PlayerTextDrawUseBox(playerid, LowFuelW[playerid], 1);
PlayerTextDrawBoxColor(playerid, LowFuelW[playerid], -16776961);
PlayerTextDrawSetShadow(playerid, LowFuelW[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, LowFuelW[playerid], 16711935);
PlayerTextDrawFont(playerid, LowFuelW[playerid], 1);
PlayerTextDrawSetProportional(playerid, LowFuelW[playerid], 1);
return 1;
}

public OnPlayerClickPlayerTextDraw(playerid, PlayerText:playertextid)
{
  if(playertextid == TuningEnter[playerid])
  {
	 PlayerTextDrawHide(playerid, PlayerText:TuningEnter[playerid]);
	 PlayerTextDrawHide(playerid, PlayerText:TuningEnter_[playerid]);
	 PlayerTextDrawSetString(playerid, PlayerText:ModName_[playerid], "Car Colors");
	 PlayerTextDrawShow(playerid, PlayerText:NextModshopItem[playerid]);
	 PlayerTextDrawShow(playerid, PlayerText:LastModshopItem[playerid]);
	 PlayerTextDrawShow(playerid, PlayerText:TuningBackground[playerid]);
	 PlayerTextDrawShow(playerid, PlayerText:ModName[playerid]);
	 PlayerTextDrawShow(playerid, PlayerText:ModName_[playerid]);
     Rainbowmodshopcartimer = SetTimerEx("ModRainbowCar", 750, true, "%i", playerid);
	 PlayerPlaySound(playerid, 1083, 0, 0, 0);
     return 1;
  }
  if(playertextid == TuningLeave[playerid])
  {
	 TogglePlayerSpectating(playerid, 1);
     new vehicleid = GetPVarInt(playerid, "VehicleID");
	 SetVehicleVirtualWorld(vehicleid, 0);
	 SetPlayerVirtualWorld(playerid, 0);
	 SetVehiclePos(vehicleid, -1944.9631,224.0898,33.7846);
	 SetPlayerPos(playerid, -1944.9631,224.0898,33.7846);
	 SetVehicleZAngle(vehicleid, 267.6341);
	 PlayerTextDrawHide(playerid, PlayerText:TuningEnter[playerid]);
	 PlayerTextDrawHide(playerid, PlayerText:TuningEnter_[playerid]);
     PlayerTextDrawHide(playerid, PlayerText:TuningLeave[playerid]);
	 PlayerTextDrawHide(playerid, PlayerText:TuningLeave_[playerid]);
	 PlayerTextDrawHide(playerid, PlayerText:NextModshopItem[playerid]);
	 PlayerTextDrawHide(playerid, PlayerText:LastModshopItem[playerid]);
	 PlayerTextDrawHide(playerid, PlayerText:TuningBackground[playerid]);
	 PlayerTextDrawHide(playerid, PlayerText:ModObject[playerid]);
	 PlayerTextDrawHide(playerid, PlayerText:ModName[playerid]);
	 PlayerTextDrawHide(playerid, PlayerText:ModName_[playerid]);
	 PlayerTextDrawHide(playerid, PlayerText:Farbauswahl[playerid][0]);
	 PlayerTextDrawHide(playerid, PlayerText:Farbauswahl[playerid][1]);
	 PlayerTextDrawHide(playerid, PlayerText:Farbauswahl[playerid][2]);
	 PlayerTextDrawHide(playerid, PlayerText:Farbauswahl[playerid][3]);
	 PlayerTextDrawHide(playerid, PlayerText:Farbauswahl[playerid][4]);
	 PlayerTextDrawHide(playerid, PlayerText:Farbauswahl[playerid][5]);
	 PlayerTextDrawHide(playerid, PlayerText:Farbauswahl[playerid][6]);
	 PlayerTextDrawHide(playerid, PlayerText:Farbauswahl[playerid][7]);
	 PlayerTextDrawHide(playerid, PlayerText:Farbauswahl[playerid][8]);
	 PlayerTextDrawHide(playerid, PlayerText:Farbauswahl[playerid][9]);
	 PlayerTextDrawHide(playerid, PlayerText:Farbauswahl[playerid][10]);
	 PlayerTextDrawHide(playerid, PlayerText:Farbauswahl[playerid][11]);
	 PlayerTextDrawHide(playerid, PlayerText:Farbauswahl[playerid][12]);
	 PlayerTextDrawHide(playerid, PlayerText:Farbauswahl[playerid][13]);
	 PlayerTextDrawHide(playerid, PlayerText:Farbauswahl[playerid][14]);
	 PlayerTextDrawHide(playerid, PlayerText:Farbauswahl[playerid][15]);
	 PlayerTextDrawHide(playerid, PlayerText:Farbauswahl[playerid][15]);
	 PlayerTextDrawHide(playerid, PlayerText:Farbauswahl[playerid][16]);
	 PlayerTextDrawHide(playerid, PlayerText:Farbauswahl[playerid][17]);
	 PlayerTextDrawHide(playerid, PlayerText:Farbauswahl[playerid][18]);
	 PlayerTextDrawHide(playerid, PlayerText:Farbauswahl[playerid][19]);
	 KillTimer(RainbowCarTimer1);
	 KillTimer(RainbowCarTimer2);
	 KillTimer(Rainbowmodshopcartimer);
	 KillTimer(Rainbowmodshopcolortimer);
	 PlayerPlaySound(playerid, 1084, 0, 0, 0);
	 TogglePlayerSpectating(playerid, 0);
	 PutPlayerInVehicle(playerid, vehicleid, 0);
     return 1;
  }
  if(playertextid == NextModshopItem[playerid])//Nächstes
  {
	 DebugMessage(playerid, "Weiter");
	 if(GetPVarInt(playerid, "BuyThatCar") == 1)//RCCS
	 {
	    DebugMessage(playerid, "nr.2");
	    InterpolateCameraPos(playerid, 203.475402, 29.622402, 2.754704, 210.577255, 28.831878, 2.923931, 1750);
	    InterpolateCameraLookAt(playerid, 204.796295, 34.193210, 1.217511, 210.811538, 33.364776, 0.826802, 1750);
	    SetPVarInt(playerid, "BuyThatCar", 2);
	    return 1;
	 }
	 if(GetPVarInt(playerid, "BuyThatCar") == 2)//RCCS
	 {
	    DebugMessage(playerid, "nr.3");
        InterpolateCameraPos(playerid, 210.577255, 28.831878, 2.923931, 210.522964, 29.737211, 2.492791, 2000);
        InterpolateCameraLookAt(playerid, 210.811538, 33.364776, 0.826802, 215.028198, 27.945598, 1.270917, 2000);
	    SetPVarInt(playerid, "BuyThatCar", 3);
	    return 1;
	 }
	 if(GetPVarInt(playerid, "BuyThatCar") == 3)//WANG
	 {
	    DebugMessage(playerid, " nicht nr.4");
	    //
        InterpolateCameraPos(playerid, -1963.572875, 298.637603, 36.779964, -1963.572875, 298.637603, 36.779964, 2250);
        InterpolateCameraLookAt(playerid, -1959.593017, 301.429565, 35.611190, -1959.593017, 301.429565, 35.611190, 2250);
	    SetPVarInt(playerid, "BuyThatCar", 4);
	    SetPlayerPos(playerid, -1961, 266, 36);
	    return 1;
	 }
	 if(GetPVarInt(playerid, "BuyThatCar") == 4)//WANG
	 {
	    DebugMessage(playerid, "nr.5");
        InterpolateCameraPos(playerid, -1963.572875, 298.637603, 36.779964, -1963.069580, 282.315917, 37.121726, 2250);
        InterpolateCameraLookAt(playerid, -1959.593017, 301.429565, 35.611190, -1959.232910, 285.070526, 35.480834, 2250);
	    SetPVarInt(playerid, "BuyThatCar", 5);
	    return 1;
	 }
	 if(GetPVarInt(playerid, "BuyThatCar") == 5)//WANG
	 {
	    DebugMessage(playerid, "nr.6");
	    InterpolateCameraPos(playerid, -1963.069580, 282.315917, 37.121726, -1961.783447, 266.975158, 36.986980, 2250);
	    InterpolateCameraLookAt(playerid, -1959.232910, 285.070526, 35.480834, -1958.939941, 270.867675, 35.659347, 2250);
	    SetPVarInt(playerid, "BuyThatCar", 6);
	    return 1;
	 }
	 if(GetPVarInt(playerid, "BuyThatCar") == 6)//WANG
	 {
	    DebugMessage(playerid, "nr.7");
	    InterpolateCameraPos(playerid, -1961.783447, 266.975158, 36.986980, -1950.007812, 262.570983, 36.118701, 2500);
        InterpolateCameraLookAt(playerid, -1958.939941, 270.867675, 35.659347, -1946.458862, 266.014587, 35.379238, 2500);
	    SetPVarInt(playerid, "BuyThatCar", 7);
	    return 1;
	 }
	 if(GetPVarInt(playerid, "BuyThatCar") == 7)//WANG
	 {
	    DebugMessage(playerid, "nr.8");
	    InterpolateCameraPos(playerid, -1950.007812, 262.570983, 36.118701, -1961.291870, 262.898864, 36.635154, 2500);
        InterpolateCameraLookAt(playerid, -1946.458862, 266.014587, 35.379238, -1958.535888, 258.935089, 35.333904, 2500);
	    SetPVarInt(playerid, "BuyThatCar", 8);
	    return 1;
	 }
	 if(GetPVarInt(playerid, "BuyThatCar") == 8)//WANG
	 {
	    DebugMessage(playerid, "nr.9");
	    InterpolateCameraPos(playerid, -1961.291870, 262.898864, 36.635154, -1961.186279, 256.855438, 42.352993, 2000);
        InterpolateCameraLookAt(playerid, -1958.535888, 258.935089, 35.333904, -1956.213989, 256.797363, 41.830513, 2000);
	    SetPVarInt(playerid, "BuyThatCar", 9);
	    return 1;
	 }
	 if(GetPVarInt(playerid, "BuyThatCar") == 9)//WANG
	 {
	    DebugMessage(playerid, "nr.10");
	    InterpolateCameraPos(playerid, -1961.186279, 256.855438, 42.352993, -1955.025634, 263.148834, 41.709693, 1750);
        InterpolateCameraLookAt(playerid, -1956.213989, 256.797363, 41.830513, -1950.167724, 264.114013, 41.024356, 1750);
	    SetPVarInt(playerid, "BuyThatCar", 10);
	    return 1;
	 }
	 if(GetPVarInt(playerid, "BuyThatCar") == 10)//WANG
	 {
	    DebugMessage(playerid, "nr.11");
	    InterpolateCameraPos(playerid, -1955.025634, 263.148834, 41.709693, -1955.454345, 270.523010, 41.738681, 2000);
        InterpolateCameraLookAt(playerid, -1950.167724, 264.114013, 41.024356, -1950.558715, 271.084045, 40.891231, 2000);
	    SetPVarInt(playerid, "BuyThatCar", 11);
	    return 1;
	 }
	 if(GetPVarInt(playerid, "BuyThatCar") == 11)//WANG
	 {
	    DebugMessage(playerid, "nr.12");
	    InterpolateCameraPos(playerid, -1955.454345, 270.523010, 41.738681, -1955.519287, 292.000579, 43.169898, 3750);
        InterpolateCameraLookAt(playerid, -1950.558715, 271.084045, 40.891231, -1954.369506, 296.155303, 40.636840, 3750);
	    SetPVarInt(playerid, "BuyThatCar", 12);
	    return 1;
	 }
	 if(GetPVarInt(playerid, "BuyThatCar") == 12)//WANG
	 {
	    DebugMessage(playerid, "nr.13");
	    InterpolateCameraPos(playerid, -1955.519287, 292.000579, 43.169898, -1957.686767, 304.087493, 43.481723, 2750);
        InterpolateCameraLookAt(playerid, -1954.369506, 296.155303, 40.636840, -1954.002563, 302.946777, 40.299640, 2750);
	    SetPVarInt(playerid, "BuyThatCar", 13);
	    return 1;
	 }
	 if(GetPVarInt(playerid, "BuyThatCar") == 13)//OTTO
	 {
	    DebugMessage(playerid, "nicht nr.14");
	    InterpolateCameraPos(playerid, -1652.203735, 1218.641967, 9.424687, -1652.203735, 1218.641967, 9.424687, 1750);
        InterpolateCameraLookAt(playerid, -1655.944091, 1215.509765, 8.329384, -1655.944091, 1215.509765, 8.329384, 1750);
	    SetPVarInt(playerid, "BuyThatCar", 14);
	    //
	    SetPlayerPos(playerid, -1652, 1218, 9);
	    return 1;
	 }
	 if(GetPVarInt(playerid, "BuyThatCar") == 14)//OTTO
	 {
	    DebugMessage(playerid, "nr.15");
	    InterpolateCameraPos(playerid, -1652.203735, 1218.641967, 9.424687, -1652.646728, 1220.103271, 14.271520, 1750);
        InterpolateCameraLookAt(playerid, -1655.944091, 1215.509765, 8.329384, -1657.437255, 1218.724365, 13.885187, 1750);
	    SetPVarInt(playerid, "BuyThatCar", 15);
	    return 1;
	 }
	 if(GetPVarInt(playerid, "BuyThatCar") == 15)//OTTO
	 {
	    DebugMessage(playerid, "nr.16");
	    InterpolateCameraPos(playerid, -1652.646728, 1220.103271, 14.271520, -1667.194702, 1209.757202, 16.355236, 2500);
        InterpolateCameraLookAt(playerid, -1657.437255, 1218.724365, 13.885187, -1670.624145, 1207.168212, 13.798641, 2500);
	    SetPVarInt(playerid, "BuyThatCar", 16);
	    return 1;
	 }
	 if(GetPVarInt(playerid, "BuyThatCar") == 16)//OTTO
	 {
	    DebugMessage(playerid, "nr.17");
	    InterpolateCameraPos(playerid, -1667.194702, 1209.757202, 16.355236, -1650.283447, 1217.304077, 15.908164, 2250);
        InterpolateCameraLookAt(playerid, -1670.624145, 1207.168212, 13.798641, -1654.072265, 1214.443725, 14.338706, 2250);
	    SetPVarInt(playerid, "BuyThatCar", 17);
	    return 1;
	 }
	 if(GetPVarInt(playerid, "BuyThatCar") == 17)//OTTO
	 {
	    DebugMessage(playerid, "nr.18");
	    InterpolateCameraPos(playerid, -1650.283447, 1217.304077, 15.908164, -1642.528808, 1209.526611, 22.482904, 2000);
        InterpolateCameraLookAt(playerid, -1654.072265, 1214.443725, 14.338706, -1647.101928, 1207.707031, 21.602016, 2000);
	    SetPVarInt(playerid, "BuyThatCar", 18);
	    return 1;
	 }
	 if(GetPVarInt(playerid, "BuyThatCar") == 18)//OTTO
	 {
	    DebugMessage(playerid, "nr.19");
	    InterpolateCameraPos(playerid, -1642.528808, 1209.526611, 22.482904, -1651.115478, 1213.769165, 22.941734, 2250);
        InterpolateCameraLookAt(playerid, -1647.101928, 1207.707031, 21.602016, -1654.709838, 1210.733398, 21.249280, 2250);
	    SetPVarInt(playerid, "BuyThatCar", 19);
	    return 1;
	 }
	 if(GetPVarInt(playerid, "BuyThatCar") == 19)//OTTO
	 {
	    DebugMessage(playerid, "nr.20");
	    InterpolateCameraPos(playerid, -1651.115478, 1213.769165, 22.941734, -1656.563598, 1217.435913, 22.297359, 1750);
        InterpolateCameraLookAt(playerid, -1654.709838, 1210.733398, 21.249280, -1661.183349, 1215.828002, 21.261938, 1750);
	    SetPVarInt(playerid, "BuyThatCar", 20);
	    return 1;
	 }
	 if(GetPVarInt(playerid, "BuyThatCar") == 20)//OTTO
	 {
	    DebugMessage(playerid, "nr.21");
		InterpolateCameraPos(playerid, -1656.563598, 1217.435913, 22.297359, -1658.828369, 1222.600708, 23.889711, 1750);
        InterpolateCameraLookAt(playerid, -1661.183349, 1215.828002, 21.261938, -1663.582763, 1222.750366, 22.349105, 1750);
	    SetPVarInt(playerid, "BuyThatCar", 21);
	    return 1;
	 }
	 if(GetPVarInt(playerid, "BuyThatCar") == 21)//OTTO
	 {
	    DebugMessage(playerid, "nr.22");
	    InterpolateCameraPos(playerid, -1658.828369, 1222.600708, 23.889711, -1666.418212, 1210.653930, 22.995586, 2500);
        InterpolateCameraLookAt(playerid, -1663.582763, 1222.750366, 22.349105, -1668.822875, 1206.845581, 20.824275, 2500);
	    SetPVarInt(playerid, "BuyThatCar", 22);
	    return 1;
	 }//hier: nächstes Dealership Kamera Szene Animation Cinematic Kinematik
	 new string[25];
	 GetPVarString(playerid, "Modshop", string, sizeof string);
	 if(strcmp(string, "Farben") == 0)
	 {
	    PlayerTextDrawSetString(playerid, PlayerText:ModName_[playerid], "Paintjob");
		SetPVarString(playerid, "Modshop", "Lackierung");
        PlayerTextDrawSetPreviewModel(playerid, ModObject[playerid], 365);
        PlayerTextDrawSetPreviewRot(playerid, ModObject[playerid], 0.0, 22.5, 0.0, 0.9);
        PlayerTextDrawShow(playerid, PlayerText:ModObject[playerid]);
	    KillTimer(Rainbowmodshopcartimer);
	    KillTimer(Rainbowmodshopcolortimer);
	 }
	 if(strcmp(string, "Lackierung") == 0)
	 {
	    PlayerTextDrawSetString(playerid, PlayerText:ModName_[playerid], "Wheels");
		SetPVarString(playerid, "Modshop", "Rader");
	    KillTimer(Rainbowmodshopcartimer);
	    KillTimer(Rainbowmodshopcolortimer);
        PlayerTextDrawSetPreviewModel(playerid, ModObject[playerid], 1085);
        PlayerTextDrawSetPreviewRot(playerid, ModObject[playerid], -22.500000, 0.000000, 22.500000, 1.5);
        PlayerTextDrawShow(playerid, PlayerText:ModObject[playerid]);
        InterpolateCameraPos(playerid, 606.746948+modshoppos, -7.408711+modshoppos, 1003.267333, 618.157409+modshoppos, -6.349669+modshoppos, 1003.675292, 2000);
        InterpolateCameraLookAt(playerid, 611.242797+modshoppos, -9.439126+modshoppos, 1002.452026, 617.420593+modshoppos, -10.720703+modshoppos, 1001.362060, 750);
	 }
	 else if(strcmp(string, "Rader") == 0)
	 {
	    PlayerTextDrawSetString(playerid, PlayerText:ModName_[playerid], "Hydraulics");
		SetPVarString(playerid, "Modshop", "Fahrwerk");
        PlayerTextDrawSetPreviewModel(playerid, ModObject[playerid], 19627);
        PlayerTextDrawSetPreviewRot(playerid, ModObject[playerid], -35, 0.000000, -55, 1.000000);
        PlayerTextDrawShow(playerid, PlayerText:ModObject[playerid]);
	 }
	 else if(strcmp(string, "Fahrwerk") == 0)
	 {
	    PlayerTextDrawSetString(playerid, PlayerText:ModName_[playerid], "Nitro");
		SetPVarString(playerid, "Modshop", "Nitro");
        PlayerTextDrawSetPreviewModel(playerid, ModObject[playerid], 1010);
        PlayerTextDrawSetPreviewRot(playerid, ModObject[playerid], -35, 0.000000, -55, 1.250);
        PlayerTextDrawShow(playerid, PlayerText:ModObject[playerid]);
	 }
	 else if(strcmp(string, "Nitro") == 0)
	 {
	    PlayerTextDrawSetString(playerid, PlayerText:ModName_[playerid], "Bumper 1");
		SetPVarString(playerid, "Modshop", "BumperVorn");
        PlayerTextDrawSetPreviewModel(playerid, ModObject[playerid], 1157);
        PlayerTextDrawSetPreviewRot(playerid, ModObject[playerid], -22.5, 0.0, 22.5, 1.3);
        PlayerTextDrawShow(playerid, PlayerText:ModObject[playerid]);
        InterpolateCameraPos(playerid, 618.157409+modshoppos, -6.349669+modshoppos, 1003.675292, 606.746948+modshoppos, -7.408711+modshoppos, 1003.267333, 2000);
        InterpolateCameraLookAt(playerid, 617.420593+modshoppos, -10.720703+modshoppos, 1001.362060, 611.242797+modshoppos, -9.439126+modshoppos, 1002.452026, 750);
	 }
	 else if(strcmp(string, "BumperVorn") == 0)
	 {
	    PlayerTextDrawSetString(playerid, PlayerText:ModName_[playerid], "Bumper 2");
		SetPVarString(playerid, "Modshop", "BumperHinten");
        PlayerTextDrawSetPreviewModel(playerid, ModObject[playerid], 1148);
        PlayerTextDrawSetPreviewRot(playerid, ModObject[playerid], -22.5, 0.0, 22.5, 1.35);
        PlayerTextDrawShow(playerid, PlayerText:ModObject[playerid]);
        InterpolateCameraPos(playerid, 606.746948+modshoppos, -7.408711+modshoppos, 1003.267333, 621.939453+modshoppos, -9.124627+modshoppos, 1002.0, 2000);
        InterpolateCameraLookAt(playerid, 611.242797+modshoppos, -9.439126+modshoppos, 1002.452026, 618.167968+modshoppos, -11.865140+modshoppos, 1002.0, 2000);
	 }
	 else if(strcmp(string, "BumperHinten") == 0)
	 {
	    PlayerTextDrawSetString(playerid, PlayerText:ModName_[playerid], "Spoiler");
		SetPVarString(playerid, "Modshop", "Spoiler");
        PlayerTextDrawSetPreviewModel(playerid, ModObject[playerid], 1003);
        PlayerTextDrawSetPreviewRot(playerid, ModObject[playerid], -22.5, 0.0, 22.5, 1.35);
        PlayerTextDrawShow(playerid, PlayerText:ModObject[playerid]);
        InterpolateCameraPos(playerid, 621.939453+modshoppos, -9.124627+modshoppos, 1002.0, 621.939453+modshoppos, -9.124627+modshoppos, 1003.5, 1000);
        InterpolateCameraLookAt(playerid, 618.167968+modshoppos, -11.865140+modshoppos, 1002.0, 618.167968+modshoppos, -11.865140+modshoppos, 1002.0, 1000);
	 }
	 else if(strcmp(string, "Spoiler") == 0)
	 {
	    PlayerTextDrawSetString(playerid, PlayerText:ModName_[playerid], "Exhaust");
		SetPVarString(playerid, "Modshop", "Auspuff");
        PlayerTextDrawSetPreviewModel(playerid, ModObject[playerid], 1018);
        PlayerTextDrawSetPreviewRot(playerid, ModObject[playerid], 22.5, 0.0, 22.5, 1.35);
        PlayerTextDrawShow(playerid, PlayerText:ModObject[playerid]);
        InterpolateCameraPos(playerid, 621.939453+modshoppos, -9.124627+modshoppos, 1003.5, 621.939453+4+modshoppos, -9.124627-2+modshoppos, 1000.5+1.5, 1000);
        InterpolateCameraLookAt(playerid, 618.167968+modshoppos, -11.865140+modshoppos, 1002.0, 618.167968+modshoppos, -11.865140+modshoppos, 1002.0, 1000);
	 }
	 else if(strcmp(string, "Auspuff") == 0)
	 {
	    PlayerTextDrawSetString(playerid, PlayerText:ModName_[playerid], "Hood");
		SetPVarString(playerid, "Modshop", "Motorhaube");
        PlayerTextDrawSetPreviewModel(playerid, ModObject[playerid], 1145);
        PlayerTextDrawSetPreviewRot(playerid, ModObject[playerid], -22.5, 0.0, 22.5, 1.35);
        PlayerTextDrawShow(playerid, PlayerText:ModObject[playerid]);
        InterpolateCameraPos(playerid, 621.939453+4+modshoppos, -9.124627-2+modshoppos, 1000.5+1.5, 611.147460+modshoppos, -10.383157+modshoppos, 1004.5, 2500);
        InterpolateCameraLookAt(playerid, 618.167968+modshoppos, -11.865140+modshoppos, 1002.0, 615.258789+modshoppos, -11.618631+modshoppos, 1001.038635, 2000);
	 }
	 else if(strcmp(string, "Motorhaube") == 0)
	 {
	    PlayerTextDrawSetString(playerid, PlayerText:ModName_[playerid], "Fog Lights");
		SetPVarString(playerid, "Modshop", "Nebelleuchten");
        PlayerTextDrawSetPreviewModel(playerid, ModObject[playerid], 1013);
        PlayerTextDrawSetPreviewRot(playerid, ModObject[playerid], -22.5, 0.0, 22.5, 1.35);
        PlayerTextDrawShow(playerid, PlayerText:ModObject[playerid]);
        InterpolateCameraPos(playerid, 611.147460+modshoppos, -10.383157+modshoppos, 1004.5, 608.043151+modshoppos, -11.396170+modshoppos, 1001.690673, 1500);
        InterpolateCameraLookAt(playerid, 615.258789+modshoppos, -11.618631+modshoppos, 1001.038635, 613.041137+modshoppos, -11.461208+modshoppos, 1001.564453, 1000);
	 }
	 else if(strcmp(string, "Nebelleuchten") == 0)
	 {
	    PlayerTextDrawSetString(playerid, PlayerText:ModName_[playerid], "Roof");
		SetPVarString(playerid, "Modshop", "Dach");
        PlayerTextDrawSetPreviewModel(playerid, ModObject[playerid], 1006);
        PlayerTextDrawSetPreviewRot(playerid, ModObject[playerid], -22.5, 0.0, 22.5, 1.35);
        PlayerTextDrawShow(playerid, PlayerText:ModObject[playerid]);
        InterpolateCameraPos(playerid, 608.043151+modshoppos, -11.396170+modshoppos, 1001.690673, 611.687316+modshoppos, -12.632326+modshoppos, 1005.292724, 1500);
        InterpolateCameraLookAt(playerid, 613.041137+modshoppos, -11.461208+modshoppos, 1001.564453, 615.516113+modshoppos, -11.591254+modshoppos, 1002.250305, 1000);
	 }
	 else if(strcmp(string, "Dach") == 0)
	 {
	    PlayerTextDrawSetString(playerid, PlayerText:ModName_[playerid], "Side Skirts");
		SetPVarString(playerid, "Modshop", "Schweller");
        PlayerTextDrawSetPreviewModel(playerid, ModObject[playerid], 1007);
        PlayerTextDrawSetPreviewRot(playerid, ModObject[playerid], 0.0, 0.0, 0.0, 1.35);
        PlayerTextDrawShow(playerid, PlayerText:ModObject[playerid]);
        InterpolateCameraPos(playerid, 611.687316+modshoppos, -12.632326+modshoppos, 1005.292724, 612.266845+modshoppos, -14.752271+modshoppos, 1001.859802, 1000);
        InterpolateCameraLookAt(playerid, 615.516113+modshoppos, -11.591254+modshoppos, 1002.250305, 616.333740+modshoppos, -11.909740+modshoppos, 1001.242980, 1000);
	 }
	 else if(strcmp(string, "Schweller") == 0)
     {
	   if(GetVehicleModel(GetPVarInt(playerid, "VehicleID"))==535)
	   {
          new X, Y;
		  GetVehicleColor(GetPVarInt(playerid, "VehicleID"), X, Y);
	      PlayerTextDrawSetString(playerid, PlayerText:ModName_[playerid], "Special");
		  SetPVarString(playerid, "Modshop", "SlSpezial");
          PlayerTextDrawSetPreviewModel(playerid, ModObject[playerid], 535);
          PlayerTextDrawSetPreviewRot(playerid, ModObject[playerid], -22.500000, 0.000000, 22.500000, 1.000000);
          PlayerTextDrawSetPreviewVehCol(playerid, ModObject[playerid], X, Y);
          PlayerTextDrawShow(playerid, PlayerText:ModObject[playerid]);
          InterpolateCameraPos(playerid, 612.266845+modshoppos, -14.752271+modshoppos, 1001.859802, 606.746948+modshoppos, -7.408711+modshoppos, 1003.267333, 1000);
          InterpolateCameraLookAt(playerid, 616.333740+modshoppos, -11.909740+modshoppos, 1001.242980, 611.242797+modshoppos, -9.439126+modshoppos, 1002.452026, 1000);
	   }
	   else if(GetVehicleModel(GetPVarInt(playerid, "VehicleID"))==534)
	   {
          new X, Y;
		  GetVehicleColor(GetPVarInt(playerid, "VehicleID"), X, Y);
	      PlayerTextDrawSetString(playerid, PlayerText:ModName_[playerid], "Special");
		  SetPVarString(playerid, "Modshop", "ReSpezial");
          PlayerTextDrawSetPreviewModel(playerid, ModObject[playerid], 534);
          PlayerTextDrawSetPreviewRot(playerid, ModObject[playerid], -22.500000, 0.000000, 22.500000, 1.000000);
          PlayerTextDrawSetPreviewVehCol(playerid, ModObject[playerid], X, Y);
          PlayerTextDrawShow(playerid, PlayerText:ModObject[playerid]);
          InterpolateCameraPos(playerid, 612.266845+modshoppos, -14.752271+modshoppos, 1001.859802, 606.746948+modshoppos, -7.408711+modshoppos, 1003.267333, 1000);
          InterpolateCameraLookAt(playerid, 616.333740+modshoppos, -11.909740+modshoppos, 1001.242980, 611.242797+modshoppos, -9.439126+modshoppos, 1002.452026, 1000);
	   }
	   else
	   {
	    PlayerTextDrawSetString(playerid, PlayerText:ModName_[playerid], "Car Objects");
		SetPVarString(playerid, "Modshop", "Objekte");
        PlayerTextDrawSetPreviewModel(playerid, ModObject[playerid], 19917);
        PlayerTextDrawSetPreviewRot(playerid, ModObject[playerid], -22.5, 0.0, 202.5, 1.35);
        PlayerTextDrawShow(playerid, PlayerText:ModObject[playerid]);
        InterpolateCameraPos(playerid, 612.266845+modshoppos, -14.752271+modshoppos, 1001.859802, 606.746948+modshoppos, -7.408711+modshoppos, 1003.267333, 1000);
        InterpolateCameraLookAt(playerid, 616.333740+modshoppos, -11.909740+modshoppos, 1001.242980, 611.242797+modshoppos, -9.439126+modshoppos, 1002.452026, 1000);
	   }
	 }
	 else if(strcmp(string, "SlSpezial") == 0)
	 {
	    PlayerTextDrawSetString(playerid, PlayerText:ModName_[playerid], "Car Objects");
		SetPVarString(playerid, "Modshop", "Objekte");
        PlayerTextDrawSetPreviewModel(playerid, ModObject[playerid], 19917);
        PlayerTextDrawSetPreviewRot(playerid, ModObject[playerid], -22.5, 0.0, 202.5, 1.35);
        PlayerTextDrawShow(playerid, PlayerText:ModObject[playerid]);
	 }
	 else if(strcmp(string, "ReSpezial") == 0)
	 {
	    PlayerTextDrawSetString(playerid, PlayerText:ModName_[playerid], "Car Objects");
		SetPVarString(playerid, "Modshop", "Objekte");
        PlayerTextDrawSetPreviewModel(playerid, ModObject[playerid], 19917);
        PlayerTextDrawSetPreviewRot(playerid, ModObject[playerid], -22.5, 0.0, 202.5, 1.35);
        PlayerTextDrawShow(playerid, PlayerText:ModObject[playerid]);
	 }
	 else if(strcmp(string, "Objekte") == 0)
	 {
	    PlayerTextDrawSetString(playerid, PlayerText:ModName_[playerid], "Tachometer");
		SetPVarString(playerid, "Modshop", "Tachofarbe");
		PlayerTextDrawColor(playerid, ModObject[playerid], 0x404040FF);
        PlayerTextDrawSetPreviewModel(playerid, ModObject[playerid], 19825);
        PlayerTextDrawSetPreviewRot(playerid, ModObject[playerid], -22.5, 0.0, 202.5, 1.35);
        PlayerTextDrawShow(playerid, PlayerText:ModObject[playerid]);
		PlayerTextDrawColor(playerid, ModObject[playerid], -1);
	 }
	 else if(strcmp(string, "Tachofarbe") == 0)
	 {
	    PlayerTextDrawSetString(playerid, PlayerText:ModName_[playerid], "Showroom");
		SetPVarString(playerid, "Modshop", "Showroom");
        PlayerTextDrawHide(playerid, PlayerText:ModObject[playerid]);
	 }
	 else if(strcmp(string, "Showroom") == 0)
	 {
	    PlayerTextDrawSetString(playerid, PlayerText:ModName_[playerid], "Car Colors");
		SetPVarString(playerid, "Modshop", "Farben");
        Rainbowmodshopcartimer = SetTimerEx("ModRainbowCar", 750, true, "%i", playerid);
        PlayerTextDrawSetPreviewModel(playerid, ModObject[playerid], GetVehicleModel(GetPVarInt(playerid, "VehicleID")));
        PlayerTextDrawSetPreviewRot(playerid, ModObject[playerid], -22.500000, 0.000000, 22.500000, 1.000000);
        PlayerTextDrawSetPreviewVehCol(playerid, ModObject[playerid], RandomColor(), RandomColor());
        PlayerTextDrawShow(playerid, PlayerText:ModObject[playerid]);
	 }
     PlayerTextDrawSetSelectable(playerid, PlayerText:ModName[playerid], 1);
     PlayerTextDrawShow(playerid, PlayerText:ModName[playerid]);
	 PlayerPlaySound(playerid, 1083, 0, 0, 0);
     return 1;
  }
  if(playertextid == LastModshopItem[playerid])//Zurück
  {
	 DebugMessage(playerid, "Zurück");
	 if(GetPVarInt(playerid, "BuyThatCar") == 1)//RCCS
	 {
	    return 1;
	 }
	 if(GetPVarInt(playerid, "BuyThatCar") == 2)//RCCS
	 {
	    DebugMessage(playerid, "nr.1");
	    InterpolateCameraPos(playerid, 210.577255, 28.831878, 2.923931, 203.475402, 29.622402, 2.754704, 2500);
	    InterpolateCameraLookAt(playerid, 210.811538, 33.364776, 0.826802, 204.796295, 34.193210, 1.217511, 2500);
	    SetPVarInt(playerid, "BuyThatCar", 1);
	    return 1;
	 }
	 if(GetPVarInt(playerid, "BuyThatCar") == 3)//RCCS
	 {
	    DebugMessage(playerid, "nr.2");
        InterpolateCameraPos(playerid, 210.522964, 29.737211, 2.492791, 210.577255, 28.831878, 2.923931, 2500);
        InterpolateCameraLookAt(playerid, 215.028198, 27.945598, 1.270917, 210.811538, 33.364776, 0.826802, 2500);
	    SetPVarInt(playerid, "BuyThatCar", 2);
	    return 1;
	 }
	 if(GetPVarInt(playerid, "BuyThatCar") == 4)/////////////////////WANG
	 {
	    DebugMessage(playerid, " nicht nr.3");
	    //
        InterpolateCameraPos(playerid, 210.577255, 28.831878, 2.923931, 210.577255, 28.831878, 2.923931, 2500);
        InterpolateCameraLookAt(playerid,  210.811538, 33.364776, 0.826802, 210.811538, 33.364776, 0.826802, 2500);
	    SetPVarInt(playerid, "BuyThatCar", 3);
	    SetPlayerPos(playerid, 203, 29, 2);
	    return 1;
	 }
	 if(GetPVarInt(playerid, "BuyThatCar") == 5)//WANG
	 {
	    DebugMessage(playerid, "nr.4");
        InterpolateCameraPos(playerid, -1963.069580, 282.315917, 37.121726, -1963.572875, 298.637603, 36.779964, 3000);
        InterpolateCameraLookAt(playerid, -1959.232910, 285.070526, 35.480834, -1959.593017, 301.429565, 35.611190, 3000);
	    SetPVarInt(playerid, "BuyThatCar", 4);
	    return 1;
	 }
	 if(GetPVarInt(playerid, "BuyThatCar") == 6)//WANG
	 {
	    DebugMessage(playerid, "nr.5");
	    InterpolateCameraPos(playerid, -1961.783447, 266.975158, 36.986980, -1963.069580, 282.315917, 37.121726, 3000);
	    InterpolateCameraLookAt(playerid, -1958.939941, 270.867675, 35.659347, -1959.232910, 285.070526, 35.480834, 3000);
	    SetPVarInt(playerid, "BuyThatCar", 5);
	    return 1;
	 }
	 if(GetPVarInt(playerid, "BuyThatCar") == 7)//WANG
	 {
	    DebugMessage(playerid, "nr.6");
	    InterpolateCameraPos(playerid, -1950.007812, 262.570983, 36.118701, -1961.783447, 266.975158, 36.986980, 3000);
        InterpolateCameraLookAt(playerid, -1946.458862, 266.014587, 35.379238, -1958.939941, 270.867675, 35.659347, 3000);
	    SetPVarInt(playerid, "BuyThatCar", 6);
	    return 1;
	 }
	 if(GetPVarInt(playerid, "BuyThatCar") == 8)//WANG
	 {
	    DebugMessage(playerid, "nr.7");
	    InterpolateCameraPos(playerid, -1961.291870, 262.898864, 36.635154, -1950.007812, 262.570983, 36.118701, 3000);
        InterpolateCameraLookAt(playerid, -1958.535888, 258.935089, 35.333904, -1946.458862, 266.014587, 35.379238, 3000);
	    SetPVarInt(playerid, "BuyThatCar", 7);
	    return 1;
	 }
	 if(GetPVarInt(playerid, "BuyThatCar") == 9)//WANG
	 {
	    DebugMessage(playerid, "nr.8");
	    InterpolateCameraPos(playerid, -1961.186279, 256.855438, 42.352993, -1961.291870, 262.898864, 36.635154, 2000);
        InterpolateCameraLookAt(playerid, -1956.213989, 256.797363, 41.830513, -1958.535888, 258.935089, 35.333904, 2000);
	    SetPVarInt(playerid, "BuyThatCar", 8);
	    return 1;
	 }
	 if(GetPVarInt(playerid, "BuyThatCar") == 10)//WANG
	 {
	    DebugMessage(playerid, "nr.9");
	    InterpolateCameraPos(playerid, -1955.025634, 263.148834, 41.709693, -1961.186279, 256.855438, 42.352993, 1750);
        InterpolateCameraLookAt(playerid, -1950.167724, 264.114013, 41.024356, -1956.213989, 256.797363, 41.830513, 1750);
	    SetPVarInt(playerid, "BuyThatCar", 9);
	    return 1;
	 }
	 if(GetPVarInt(playerid, "BuyThatCar") == 11)//WANG
	 {
	    DebugMessage(playerid, "nr.10");
	    InterpolateCameraPos(playerid, -1955.454345, 270.523010, 41.738681, -1955.025634, 263.148834, 41.709693, 2000);
        InterpolateCameraLookAt(playerid, -1950.558715, 271.084045, 40.891231, -1950.167724, 264.114013, 41.024356, 2000);
	    SetPVarInt(playerid, "BuyThatCar", 10);
	    return 1;
	 }
	 if(GetPVarInt(playerid, "BuyThatCar") == 12)//WANG
	 {
	    DebugMessage(playerid, "nr.11");
	    InterpolateCameraPos(playerid, -1955.519287, 292.000579, 43.169898, -1955.454345, 270.523010, 41.738681, 3750);
        InterpolateCameraLookAt(playerid, -1954.369506, 296.155303, 40.636840, -1950.558715, 271.084045, 40.891231, 3750);
	    SetPVarInt(playerid, "BuyThatCar", 11);
	    return 1;
	 }
	 if(GetPVarInt(playerid, "BuyThatCar") == 13)//WANG//
	 {
	    DebugMessage(playerid, "nr.12");
	    InterpolateCameraPos(playerid, -1957.686767, 304.087493, 43.481723, -1955.519287, 292.000579, 43.169898, 2750);
        InterpolateCameraLookAt(playerid, -1954.002563, 302.946777, 40.299640, -1954.369506, 296.155303, 40.636840, 2750);
	    SetPVarInt(playerid, "BuyThatCar", 12);
	    return 1;
	 }
	 new string[25];
	 GetPVarString(playerid, "Modshop", string, sizeof string);
	 if(strcmp(string, "Lackierung") == 0)
	 {
	    PlayerTextDrawSetString(playerid, PlayerText:ModName_[playerid], "Car Colors");
		SetPVarString(playerid, "Modshop", "Farben");
        Rainbowmodshopcartimer = SetTimerEx("ModRainbowCar", 750, true, "%i", playerid);
        PlayerTextDrawSetPreviewModel(playerid, ModObject[playerid], GetVehicleModel(GetPVarInt(playerid, "VehicleID")));
        PlayerTextDrawSetPreviewRot(playerid, ModObject[playerid], -22.500000, 0.000000, 22.500000, 1.000000);
        PlayerTextDrawSetPreviewVehCol(playerid, ModObject[playerid], RandomColor(), RandomColor());
        PlayerTextDrawShow(playerid, PlayerText:ModObject[playerid]);
	 }
	 if(strcmp(string, "Rader") == 0)
	 {
	    PlayerTextDrawSetString(playerid, PlayerText:ModName_[playerid], "Paint Job");
		SetPVarString(playerid, "Modshop", "Lackierung");
        PlayerTextDrawSetPreviewModel(playerid, ModObject[playerid], 365);
        PlayerTextDrawSetPreviewRot(playerid, ModObject[playerid], 0.0, 22.5, 0.0, 0.9);
        PlayerTextDrawShow(playerid, PlayerText:ModObject[playerid]);
        InterpolateCameraPos(playerid, 618.157409+modshoppos, -6.349669+modshoppos, 1003.675292, 606.746948+modshoppos, -7.408711+modshoppos, 1003.267333, 2000);
        InterpolateCameraLookAt(playerid, 617.420593+modshoppos, -10.720703+modshoppos, 1001.362060, 611.242797+modshoppos, -9.439126+modshoppos, 1002.452026, 750);
	 }
	 else if(strcmp(string, "Fahrwerk") == 0)
	 {
	    PlayerTextDrawSetString(playerid, PlayerText:ModName_[playerid], "Wheels");
		SetPVarString(playerid, "Modshop", "Rader");
        PlayerTextDrawSetPreviewModel(playerid, ModObject[playerid], 1085);
        PlayerTextDrawSetPreviewRot(playerid, ModObject[playerid], -22.500000, 0.000000, 22.500000, 1.5);
        PlayerTextDrawShow(playerid, PlayerText:ModObject[playerid]);
	 }
	 else if(strcmp(string, "Nitro") == 0)
	 {
	    PlayerTextDrawSetString(playerid, PlayerText:ModName_[playerid], "Hydraulics");
		SetPVarString(playerid, "Modshop", "Fahrwerk");
        PlayerTextDrawSetPreviewModel(playerid, ModObject[playerid], 19627);
        PlayerTextDrawSetPreviewRot(playerid, ModObject[playerid], -35, 0.000000, -55, 1.000000);
        PlayerTextDrawShow(playerid, PlayerText:ModObject[playerid]);
	 }
	 else if(strcmp(string, "BumperVorn") == 0)
	 {
	    PlayerTextDrawSetString(playerid, PlayerText:ModName_[playerid], "Nitro");
		SetPVarString(playerid, "Modshop", "Nitro");
        PlayerTextDrawSetPreviewModel(playerid, ModObject[playerid], 1010);
        PlayerTextDrawSetPreviewRot(playerid, ModObject[playerid], -35, 0.000000, -55, 1.250);
        PlayerTextDrawShow(playerid, PlayerText:ModObject[playerid]);
        InterpolateCameraPos(playerid, 606.746948+modshoppos, -7.408711+modshoppos, 1003.267333, 618.157409+modshoppos, -6.349669+modshoppos, 1003.675292, 2000);
        InterpolateCameraLookAt(playerid, 611.242797+modshoppos, -9.439126+modshoppos, 1002.452026, 617.420593+modshoppos, -10.720703+modshoppos, 1001.362060, 750);
	 }
	 else if(strcmp(string, "BumperHinten") == 0)
	 {
	    PlayerTextDrawSetString(playerid, PlayerText:ModName_[playerid], "Bumper 1");
		SetPVarString(playerid, "Modshop", "BumperVorn");
        PlayerTextDrawSetPreviewModel(playerid, ModObject[playerid], 1157);
        PlayerTextDrawSetPreviewRot(playerid, ModObject[playerid], -22.5, 0.0, 22.5, 1.3);
        PlayerTextDrawShow(playerid, PlayerText:ModObject[playerid]);
        InterpolateCameraPos(playerid, 621.939453+modshoppos, -9.124627+modshoppos, 1002.0,  606.746948+modshoppos, -7.408711+modshoppos, 1003.267333,2000);
        InterpolateCameraLookAt(playerid, 618.167968+modshoppos, -11.865140+modshoppos, 1002.0, 611.242797+modshoppos, -9.439126+modshoppos, 1002.452026, 2000);
	 }
	 else if(strcmp(string, "Spoiler") == 0)
	 {
	    PlayerTextDrawSetString(playerid, PlayerText:ModName_[playerid], "Bumper 2");
		SetPVarString(playerid, "Modshop", "BumperHinten");
        PlayerTextDrawSetPreviewModel(playerid, ModObject[playerid], 1148);
        PlayerTextDrawSetPreviewRot(playerid, ModObject[playerid], -22.5, 0.0, 22.5, 1.35);
        PlayerTextDrawShow(playerid, PlayerText:ModObject[playerid]);
        InterpolateCameraPos(playerid, 621.939453+modshoppos, -9.124627+modshoppos, 1003.5,  621.939453+modshoppos, -9.124627+modshoppos, 1002.0,1000);
        InterpolateCameraLookAt(playerid, 618.167968+modshoppos, -11.865140+modshoppos, 1002.0, 618.167968+modshoppos, -11.865140+modshoppos, 1002.0, 1000);
	 }
	 else if(strcmp(string, "Auspuff") == 0)
	 {
	    PlayerTextDrawSetString(playerid, PlayerText:ModName_[playerid], "Spoiler");
		SetPVarString(playerid, "Modshop", "Spoiler");
        PlayerTextDrawSetPreviewModel(playerid, ModObject[playerid], 1003);
        PlayerTextDrawSetPreviewRot(playerid, ModObject[playerid], -22.5, 0.0, 22.5, 1.35);
        PlayerTextDrawShow(playerid, PlayerText:ModObject[playerid]);
        InterpolateCameraPos(playerid, 621.939453+modshoppos+4, -9.124627+modshoppos-2, 1000.5+1.5, 621.939453+modshoppos, -9.124627+modshoppos, 1003.5, 1000);
        InterpolateCameraLookAt(playerid, 618.167968+modshoppos, -11.865140+modshoppos, 1002.0, 618.167968+modshoppos, -11.865140+modshoppos, 1002.0, 1000);
	 }
	 else if(strcmp(string, "Motorhaube") == 0)
	 {
	    PlayerTextDrawSetString(playerid, PlayerText:ModName_[playerid], "Exhaust");
		SetPVarString(playerid, "Modshop", "Auspuff");
        PlayerTextDrawSetPreviewModel(playerid, ModObject[playerid], 1018);
        PlayerTextDrawSetPreviewRot(playerid, ModObject[playerid], 22.5, 0.0, 22.5, 1.35);
        PlayerTextDrawShow(playerid, PlayerText:ModObject[playerid]);
        InterpolateCameraPos(playerid, 611.147460+modshoppos, -10.383157+modshoppos, 1004.5,  621.939453+modshoppos+4, -9.124627+modshoppos-2, 1000.5+1.5,2500);
        InterpolateCameraLookAt(playerid, 615.258789+modshoppos, -11.618631+modshoppos, 1001.038635, 618.167968+modshoppos, -11.865140+modshoppos, 1002.0, 2000);
	 }
	 else if(strcmp(string, "Nebelleuchten") == 0)
	 {
	    PlayerTextDrawSetString(playerid, PlayerText:ModName_[playerid], "Hood");
		SetPVarString(playerid, "Modshop", "Motorhaube");
        PlayerTextDrawSetPreviewModel(playerid, ModObject[playerid], 1145);
        PlayerTextDrawSetPreviewRot(playerid, ModObject[playerid], -22.5, 0.0, 22.5, 1.35);
        PlayerTextDrawShow(playerid, PlayerText:ModObject[playerid]);
        InterpolateCameraPos(playerid, 608.043151+modshoppos, -11.396170+modshoppos, 1001.690673, 611.147460+modshoppos, -10.383157+modshoppos, 1004.5, 1500);
        InterpolateCameraLookAt(playerid, 613.041137+modshoppos, -11.461208+modshoppos, 1001.564453, 615.258789+modshoppos, -11.618631+modshoppos, 1001.038635, 1000);
	 }
	 else if(strcmp(string, "Dach") == 0)
	 {
	    PlayerTextDrawSetString(playerid, PlayerText:ModName_[playerid], "Fog Lights");
		SetPVarString(playerid, "Modshop", "Nebelleuchten");
        PlayerTextDrawSetPreviewModel(playerid, ModObject[playerid], 1013);
        PlayerTextDrawSetPreviewRot(playerid, ModObject[playerid], -22.5, 0.0, 22.5, 1.35);
        PlayerTextDrawShow(playerid, PlayerText:ModObject[playerid]);
        InterpolateCameraPos(playerid, 611.687316+modshoppos, -12.632326+modshoppos, 1005.292724, 608.043151+modshoppos, -11.396170+modshoppos, 1001.690673, 1500);
        InterpolateCameraLookAt(playerid, 615.516113+modshoppos, -11.591254+modshoppos, 1002.250305, 613.041137+modshoppos, -11.461208+modshoppos, 1001.564453, 1000);
	 }
	 else if(strcmp(string, "Schweller") == 0)
	 {
	    PlayerTextDrawSetString(playerid, PlayerText:ModName_[playerid], "Roof");
		SetPVarString(playerid, "Modshop", "Dach");
        PlayerTextDrawSetPreviewModel(playerid, ModObject[playerid], 1006);
		PlayerTextDrawColor(playerid, ModObject[playerid], -1);
        PlayerTextDrawSetPreviewRot(playerid, ModObject[playerid], -22.5, 0.0, 22.5, 1.35);
        PlayerTextDrawShow(playerid, PlayerText:ModObject[playerid]);
        InterpolateCameraPos(playerid, 612.266845+modshoppos, -14.752271+modshoppos, 1001.859802, 611.687316+modshoppos, -12.632326+modshoppos, 1005.292724, 1000);
        InterpolateCameraLookAt(playerid, 616.333740+modshoppos, -11.909740+modshoppos, 1001.242980, 615.516113+modshoppos, -11.591254+modshoppos, 1002.250305, 1000);
	 }
	 else if(strcmp(string, "Objekte") == 0)
	 {
	   if(GetVehicleModel(GetPVarInt(playerid, "VehicleID"))==535)
	   {
          new X, Y;
		  GetVehicleColor(GetPVarInt(playerid, "VehicleID"), X, Y);
	      PlayerTextDrawSetString(playerid, PlayerText:ModName_[playerid], "Special");
		  SetPVarString(playerid, "Modshop", "SlSpezial");
          PlayerTextDrawSetPreviewModel(playerid, ModObject[playerid], 535);
          PlayerTextDrawSetPreviewRot(playerid, ModObject[playerid], -22.500000, 0.000000, 22.500000, 1.000000);
          PlayerTextDrawSetPreviewVehCol(playerid, ModObject[playerid], X, Y);
          PlayerTextDrawShow(playerid, PlayerText:ModObject[playerid]);
	   }
	   else if(GetVehicleModel(GetPVarInt(playerid, "VehicleID"))==534)
	   {
          new X, Y;
		  GetVehicleColor(GetPVarInt(playerid, "VehicleID"), X, Y);
	      PlayerTextDrawSetString(playerid, PlayerText:ModName_[playerid], "Special");
		  SetPVarString(playerid, "Modshop", "ReSpezial");
          PlayerTextDrawSetPreviewModel(playerid, ModObject[playerid], 534);
          PlayerTextDrawSetPreviewRot(playerid, ModObject[playerid], -22.500000, 0.000000, 22.500000, 1.000000);
          PlayerTextDrawSetPreviewVehCol(playerid, ModObject[playerid], X, Y);
          PlayerTextDrawShow(playerid, PlayerText:ModObject[playerid]);
	   }
	   else
	   {
	      PlayerTextDrawSetString(playerid, PlayerText:ModName_[playerid], "Side Skirts");
		  SetPVarString(playerid, "Modshop", "Schweller");
          PlayerTextDrawSetPreviewModel(playerid, ModObject[playerid], 1007);
          PlayerTextDrawSetPreviewRot(playerid, ModObject[playerid], 0.0, 0.0, 0.0, 1.35);
          PlayerTextDrawShow(playerid, PlayerText:ModObject[playerid]);
          InterpolateCameraPos(playerid, 606.746948+modshoppos, -7.408711+modshoppos, 1003.267333, 612.266845+modshoppos, -14.752271+modshoppos, 1001.859802, 1000);
          InterpolateCameraLookAt(playerid, 611.242797+modshoppos, -9.439126+modshoppos, 1002.452026, 616.333740+modshoppos, -11.909740+modshoppos, 1001.242980, 1000);
	   }
	 }
	 else if(strcmp(string, "SlSpezial") == 0)
	 {
	    PlayerTextDrawSetString(playerid, PlayerText:ModName_[playerid], "Side Skirts");
	    SetPVarString(playerid, "Modshop", "Schweller");
	    PlayerTextDrawSetPreviewModel(playerid, ModObject[playerid], 1007);
	    PlayerTextDrawSetPreviewRot(playerid, ModObject[playerid], 0.0, 0.0, 0.0, 1.35);
	    PlayerTextDrawShow(playerid, PlayerText:ModObject[playerid]);
	    InterpolateCameraPos(playerid, 606.746948+modshoppos, -7.408711+modshoppos, 1003.267333, 612.266845+modshoppos, -14.752271+modshoppos, 1001.859802, 1000);
	    InterpolateCameraLookAt(playerid, 611.242797+modshoppos, -9.439126+modshoppos, 1002.452026, 616.333740+modshoppos, -11.909740+modshoppos, 1001.242980, 1000);
	 }
	 else if(strcmp(string, "ReSpezial") == 0)
	 {
	    PlayerTextDrawSetString(playerid, PlayerText:ModName_[playerid], "Side Skirts");
	    SetPVarString(playerid, "Modshop", "Schweller");
	    PlayerTextDrawSetPreviewModel(playerid, ModObject[playerid], 1007);
	    PlayerTextDrawSetPreviewRot(playerid, ModObject[playerid], 0.0, 0.0, 0.0, 1.35);
	    PlayerTextDrawShow(playerid, PlayerText:ModObject[playerid]);
	    InterpolateCameraPos(playerid, 606.746948+modshoppos, -7.408711+modshoppos, 1003.267333, 612.266845+modshoppos, -14.752271+modshoppos, 1001.859802, 1000);
	    InterpolateCameraLookAt(playerid, 611.242797+modshoppos, -9.439126+modshoppos, 1002.452026, 616.333740+modshoppos, -11.909740+modshoppos, 1001.242980, 1000);
	 }
	 else if(strcmp(string, "Tachofarbe") == 0)
	 {
	    PlayerTextDrawSetString(playerid, PlayerText:ModName_[playerid], "Car Objects");
		SetPVarString(playerid, "Modshop", "Objekte");
        PlayerTextDrawSetPreviewModel(playerid, ModObject[playerid], 19917);
        PlayerTextDrawSetPreviewRot(playerid, ModObject[playerid], -22.5, 0.0, 202.5, 1.35);
        PlayerTextDrawShow(playerid, PlayerText:ModObject[playerid]);
	 }
	 else if(strcmp(string, "Showroom") == 0)
	 {
	    PlayerTextDrawSetString(playerid, PlayerText:ModName_[playerid], "Tachometer");
		SetPVarString(playerid, "Modshop", "Tachofarbe");
		PlayerTextDrawColor(playerid, ModObject[playerid], 0x404040FF);
        PlayerTextDrawSetPreviewModel(playerid, ModObject[playerid], 19825);
        PlayerTextDrawSetPreviewRot(playerid, ModObject[playerid], -22.5, 0.0, 202.5, 1.35);
        PlayerTextDrawShow(playerid, PlayerText:ModObject[playerid]);
		PlayerTextDrawColor(playerid, ModObject[playerid], -1);
	 }
	 else if(strcmp(string, "Farben") == 0)
	 {
	    PlayerTextDrawSetString(playerid, PlayerText:ModName_[playerid], "Showroom");
		SetPVarString(playerid, "Modshop", "Showroom");
	    KillTimer(Rainbowmodshopcartimer);
	    KillTimer(Rainbowmodshopcolortimer);
        PlayerTextDrawHide(playerid, PlayerText:ModObject[playerid]);
	 }
     PlayerTextDrawSetSelectable(playerid, PlayerText:ModName[playerid], 1);
     PlayerTextDrawShow(playerid, PlayerText:ModName[playerid]);
	 PlayerPlaySound(playerid, 1083, 0, 0, 0);
     return 1;
  }
  if(playertextid == ModName[playerid])
  {
	 new string[25];
	 PlayerPlaySound(playerid, 1083, 0, 0, 0);
     PlayerTextDrawSetSelectable(playerid, PlayerText:ModName[playerid], 0);
     PlayerTextDrawShow(playerid, PlayerText:ModName[playerid]);
     PlayerTextDrawHide(playerid, PlayerText:TuningLeave[playerid]);
     PlayerTextDrawHide(playerid, PlayerText:TuningLeave_[playerid]);
	 GetPVarString(playerid, "Modshop", string, sizeof string);
	 if(strcmp(string, "Farben") == 0)
	 {
	      PlayerTextDrawShow(playerid, PlayerText:Farbauswahl[playerid][0]);
	      PlayerTextDrawShow(playerid, PlayerText:Farbauswahl[playerid][1]);
	      PlayerTextDrawShow(playerid, PlayerText:Farbauswahl[playerid][2]);
	      PlayerTextDrawShow(playerid, PlayerText:Farbauswahl[playerid][3]);
	      PlayerTextDrawShow(playerid, PlayerText:Farbauswahl[playerid][4]);
	      PlayerTextDrawShow(playerid, PlayerText:Farbauswahl[playerid][5]);
	      PlayerTextDrawShow(playerid, PlayerText:Farbauswahl[playerid][6]);
	      PlayerTextDrawShow(playerid, PlayerText:Farbauswahl[playerid][7]);
	      PlayerTextDrawShow(playerid, PlayerText:Farbauswahl[playerid][8]);
	      PlayerTextDrawShow(playerid, PlayerText:Farbauswahl[playerid][9]);
	      PlayerTextDrawShow(playerid, PlayerText:Farbauswahl[playerid][10]);
	      PlayerTextDrawShow(playerid, PlayerText:Farbauswahl[playerid][11]);
	      PlayerTextDrawShow(playerid, PlayerText:Farbauswahl[playerid][12]);
	      PlayerTextDrawShow(playerid, PlayerText:Farbauswahl[playerid][13]);
	      PlayerTextDrawShow(playerid, PlayerText:Farbauswahl[playerid][14]);
	      PlayerTextDrawShow(playerid, PlayerText:Farbauswahl[playerid][15]);
	      PlayerTextDrawShow(playerid, PlayerText:Farbauswahl[playerid][16]);
	      PlayerTextDrawShow(playerid, PlayerText:Farbauswahl[playerid][17]);
	      PlayerTextDrawShow(playerid, PlayerText:Farbauswahl[playerid][18]);
	      PlayerTextDrawShow(playerid, PlayerText:Farbauswahl[playerid][19]);
          PlayerTextDrawShow(playerid, PlayerText:TuningObjectBackground[playerid]);
          PlayerTextDrawShow(playerid, PlayerText:ModDone[playerid]);
          PlayerTextDrawShow(playerid, PlayerText:ModDone_[playerid]);
          PlayerTextDrawHide(playerid, PlayerText:LastModshopItem[playerid]);
          PlayerTextDrawHide(playerid, PlayerText:NextModshopItem[playerid]);
	      PlayerTextDrawSetString(playerid, PlayerText:ModDone_[playerid], "Next");
	      KillTimer(Rainbowmodshopcolortimer);
		  Rainbowmodshopcolortimer = SetTimerEx("ModShopTextColor", 500, true, "%i", playerid);
		  SetPVarInt(playerid, "Farben", 1);
	 }
	 if(strcmp(string, "Lackierung") == 0)
	 {
          PlayerTextDrawShow(playerid, PlayerText:TuningObjectBackground[playerid]);
          PlayerTextDrawShow(playerid, PlayerText:ModDone[playerid]);
          PlayerTextDrawShow(playerid, PlayerText:ModDone_[playerid]);
          PlayerTextDrawHide(playerid, PlayerText:LastModshopItem[playerid]);
          PlayerTextDrawHide(playerid, PlayerText:NextModshopItem[playerid]);
          if(GetVehicleCompatibleLackierung(GetPVarInt(playerid, "VehicleID")))
		  {
            PlayerTextDrawShow(playerid, PlayerText:Mod_Listitem1[playerid]);
            PlayerTextDrawShow(playerid, PlayerText:Mod_Listitem1_[playerid]);
            PlayerTextDrawSetString(playerid, PlayerText:Mod_Listitem1_[playerid], "1");
            PlayerTextDrawSetString(playerid, PlayerText:Mod_Listitem2_[playerid], "2");
            PlayerTextDrawShow(playerid, PlayerText:Mod_Listitem2_[playerid]);
            PlayerTextDrawShow(playerid, PlayerText:Mod_Listitem2[playerid]);
            PlayerTextDrawSetString(playerid, PlayerText:Mod_Listitem3_[playerid], "3");
            PlayerTextDrawShow(playerid, PlayerText:Mod_Listitem3_[playerid]);
            PlayerTextDrawShow(playerid, PlayerText:Mod_Listitem3[playerid]);
            PlayerTextDrawHide(playerid, PlayerText:LastModshopItem[playerid]);
            PlayerTextDrawHide(playerid, PlayerText:NextModshopItem[playerid]);
		  }
		  else
		  {
			PlayerTextDrawSetSelectable(playerid, PlayerText:Mod_Listitem1[playerid], 0);
            PlayerTextDrawShow(playerid, PlayerText:Mod_Listitem1[playerid]);
		    PlayerTextDrawSetString(playerid, PlayerText:Mod_Listitem1_[playerid], "Not compatible.");
            PlayerTextDrawShow(playerid, PlayerText:Mod_Listitem1_[playerid]);
			PlayerTextDrawSetSelectable(playerid, PlayerText:Mod_Listitem1[playerid], 1);
		    return 1;
          }
	 }
	 if(strcmp(string, "Fahrwerk") == 0)
	 {
          PlayerTextDrawShow(playerid, PlayerText:TuningObjectBackground[playerid]);
          PlayerTextDrawShow(playerid, PlayerText:ModDone[playerid]);
          PlayerTextDrawShow(playerid, PlayerText:ModDone_[playerid]);
          PlayerTextDrawShow(playerid, PlayerText:Mod_Listitem1[playerid]);
          PlayerTextDrawSetString(playerid, PlayerText:Mod_Listitem1_[playerid], "Hydraulics");
          PlayerTextDrawShow(playerid, PlayerText:Mod_Listitem1_[playerid]);
          PlayerTextDrawHide(playerid, PlayerText:LastModshopItem[playerid]);
          PlayerTextDrawHide(playerid, PlayerText:NextModshopItem[playerid]);
	 }
	 if(strcmp(string, "Nitro") == 0)
	 {
          PlayerTextDrawShow(playerid, PlayerText:TuningObjectBackground[playerid]);
          PlayerTextDrawShow(playerid, PlayerText:ModDone[playerid]);
          PlayerTextDrawShow(playerid, PlayerText:ModDone_[playerid]);
          PlayerTextDrawSetString(playerid, PlayerText:Mod_Listitem1_[playerid], "2x Nitro");
          PlayerTextDrawShow(playerid, PlayerText:Mod_Listitem1_[playerid]);
          PlayerTextDrawShow(playerid, PlayerText:Mod_Listitem1[playerid]);
          PlayerTextDrawSetString(playerid, PlayerText:Mod_Listitem2_[playerid], "5x Nitro");
          PlayerTextDrawShow(playerid, PlayerText:Mod_Listitem2_[playerid]);
          PlayerTextDrawShow(playerid, PlayerText:Mod_Listitem2[playerid]);
          PlayerTextDrawSetString(playerid, PlayerText:Mod_Listitem3_[playerid], "10x Nitro");
          PlayerTextDrawShow(playerid, PlayerText:Mod_Listitem3_[playerid]);
          PlayerTextDrawShow(playerid, PlayerText:Mod_Listitem3[playerid]);
          PlayerTextDrawHide(playerid, PlayerText:LastModshopItem[playerid]);
          PlayerTextDrawHide(playerid, PlayerText:NextModshopItem[playerid]);
	 }
	 if(strcmp(string, "Rader") == 0)
	 {
	      PlayerTextDrawFont(playerid, PlayerText:Farbauswahl[playerid][0], 5);
	      PlayerTextDrawSetPreviewModel(playerid, Farbauswahl[playerid][0], 1096);
	      PlayerTextDrawSetPreviewRot(playerid, Farbauswahl[playerid][0], 0, 0, 40, 0.9);
	      PlayerTextDrawColor(playerid, Farbauswahl[playerid][0], -1);
	      PlayerTextDrawShow(playerid, PlayerText:Farbauswahl[playerid][0]);

	      PlayerTextDrawFont(playerid, PlayerText:Farbauswahl[playerid][1], 5);
	      PlayerTextDrawSetPreviewModel(playerid, Farbauswahl[playerid][1], 1083);
	      PlayerTextDrawSetPreviewRot(playerid, Farbauswahl[playerid][1], 0, 0, 40, 0.9);
	      PlayerTextDrawColor(playerid, Farbauswahl[playerid][1], -1);
	      PlayerTextDrawShow(playerid, PlayerText:Farbauswahl[playerid][1]);

	      PlayerTextDrawFont(playerid, PlayerText:Farbauswahl[playerid][2], 5);
	      PlayerTextDrawSetPreviewModel(playerid, Farbauswahl[playerid][2], 1084);
	      PlayerTextDrawSetPreviewRot(playerid, Farbauswahl[playerid][2], 0, 0, 40, 0.9);
	      PlayerTextDrawColor(playerid, Farbauswahl[playerid][2], -1);
	      PlayerTextDrawShow(playerid, PlayerText:Farbauswahl[playerid][2]);

	      PlayerTextDrawFont(playerid, PlayerText:Farbauswahl[playerid][3], 5);
	      PlayerTextDrawSetPreviewModel(playerid, Farbauswahl[playerid][3], 1081);
	      PlayerTextDrawSetPreviewRot(playerid, Farbauswahl[playerid][3], 0, 0, 40, 0.9);
	      PlayerTextDrawColor(playerid, Farbauswahl[playerid][3], -1);
	      PlayerTextDrawShow(playerid, PlayerText:Farbauswahl[playerid][3]);

	      PlayerTextDrawFont(playerid, PlayerText:Farbauswahl[playerid][4], 5);
	      PlayerTextDrawSetPreviewModel(playerid, Farbauswahl[playerid][4], 1097);
	      PlayerTextDrawSetPreviewRot(playerid, Farbauswahl[playerid][4], 0, 0, 40, 0.9);
	      PlayerTextDrawColor(playerid, Farbauswahl[playerid][4], -1);
	      PlayerTextDrawShow(playerid, PlayerText:Farbauswahl[playerid][4]);

	      PlayerTextDrawFont(playerid, PlayerText:Farbauswahl[playerid][5], 5);
	      PlayerTextDrawSetPreviewModel(playerid, Farbauswahl[playerid][5], 1098);
	      PlayerTextDrawSetPreviewRot(playerid, Farbauswahl[playerid][5], 0, 0, 40, 0.9);
	      PlayerTextDrawColor(playerid, Farbauswahl[playerid][5], -1);
	      PlayerTextDrawShow(playerid, PlayerText:Farbauswahl[playerid][5]);

	      PlayerTextDrawFont(playerid, PlayerText:Farbauswahl[playerid][6], 5);
	      PlayerTextDrawSetPreviewModel(playerid, Farbauswahl[playerid][6], 1025);
	      PlayerTextDrawSetPreviewRot(playerid, Farbauswahl[playerid][6], 0, 0, 40, 0.9);
	      PlayerTextDrawColor(playerid, Farbauswahl[playerid][6], -1);
	      PlayerTextDrawShow(playerid, PlayerText:Farbauswahl[playerid][6]);

	      PlayerTextDrawFont(playerid, PlayerText:Farbauswahl[playerid][7], 5);
	      PlayerTextDrawSetPreviewModel(playerid, Farbauswahl[playerid][7], 1085);
	      PlayerTextDrawSetPreviewRot(playerid, Farbauswahl[playerid][7], 0, 0, 40, 0.9);
	      PlayerTextDrawColor(playerid, Farbauswahl[playerid][7], -1);
	      PlayerTextDrawShow(playerid, PlayerText:Farbauswahl[playerid][7]);

	      PlayerTextDrawFont(playerid, PlayerText:Farbauswahl[playerid][8], 5);
	      PlayerTextDrawSetPreviewModel(playerid, Farbauswahl[playerid][8], 1082);
	      PlayerTextDrawSetPreviewRot(playerid, Farbauswahl[playerid][8], 0, 0, 40, 0.9);
	      PlayerTextDrawColor(playerid, Farbauswahl[playerid][8], -1);
	      PlayerTextDrawShow(playerid, PlayerText:Farbauswahl[playerid][8]);

	      PlayerTextDrawFont(playerid, PlayerText:Farbauswahl[playerid][9], 5);
	      PlayerTextDrawSetPreviewModel(playerid, Farbauswahl[playerid][9], 1080);
	      PlayerTextDrawSetPreviewRot(playerid, Farbauswahl[playerid][9], 0, 0, 40, 0.9);
	      PlayerTextDrawColor(playerid, Farbauswahl[playerid][9], -1);
	      PlayerTextDrawShow(playerid, PlayerText:Farbauswahl[playerid][9]);

	      PlayerTextDrawFont(playerid, PlayerText:Farbauswahl[playerid][10], 5);
	      PlayerTextDrawSetPreviewModel(playerid, Farbauswahl[playerid][10], 1073);
	      PlayerTextDrawSetPreviewRot(playerid, Farbauswahl[playerid][10], 0, 0, 40, 0.9);
	      PlayerTextDrawColor(playerid, Farbauswahl[playerid][10], -1);
	      PlayerTextDrawShow(playerid, PlayerText:Farbauswahl[playerid][10]);

	      PlayerTextDrawFont(playerid, PlayerText:Farbauswahl[playerid][11], 5);
	      PlayerTextDrawSetPreviewModel(playerid, Farbauswahl[playerid][11], 1079);
	      PlayerTextDrawSetPreviewRot(playerid, Farbauswahl[playerid][11], 0, 0, 40, 0.9);
	      PlayerTextDrawColor(playerid, Farbauswahl[playerid][11], -1);
	      PlayerTextDrawShow(playerid, PlayerText:Farbauswahl[playerid][11]);

	      PlayerTextDrawFont(playerid, PlayerText:Farbauswahl[playerid][12], 5);
	      PlayerTextDrawSetPreviewModel(playerid, Farbauswahl[playerid][12], 1078);
	      PlayerTextDrawSetPreviewRot(playerid, Farbauswahl[playerid][12], 0, 0, 40, 0.9);
	      PlayerTextDrawColor(playerid, Farbauswahl[playerid][12], -1);
	      PlayerTextDrawShow(playerid, PlayerText:Farbauswahl[playerid][12]);

	      PlayerTextDrawFont(playerid, PlayerText:Farbauswahl[playerid][13], 5);
	      PlayerTextDrawSetPreviewModel(playerid, Farbauswahl[playerid][13], 1077);
	      PlayerTextDrawSetPreviewRot(playerid, Farbauswahl[playerid][13], 0, 0, 40, 0.9);
	      PlayerTextDrawColor(playerid, Farbauswahl[playerid][13], -1);
	      PlayerTextDrawShow(playerid, PlayerText:Farbauswahl[playerid][13]);

	      PlayerTextDrawFont(playerid, PlayerText:Farbauswahl[playerid][14], 5);
	      PlayerTextDrawSetPreviewModel(playerid, Farbauswahl[playerid][14], 1076);
	      PlayerTextDrawSetPreviewRot(playerid, Farbauswahl[playerid][14], 0, 0, 40, 0.9);
	      PlayerTextDrawColor(playerid, Farbauswahl[playerid][14], -1);
	      PlayerTextDrawShow(playerid, PlayerText:Farbauswahl[playerid][14]);

	      PlayerTextDrawFont(playerid, PlayerText:Farbauswahl[playerid][15], 5);
	      PlayerTextDrawSetPreviewModel(playerid, Farbauswahl[playerid][15], 1075);
	      PlayerTextDrawSetPreviewRot(playerid, Farbauswahl[playerid][15], 0, 0, 40, 0.9);
	      PlayerTextDrawColor(playerid, Farbauswahl[playerid][15], -1);
	      PlayerTextDrawShow(playerid, PlayerText:Farbauswahl[playerid][15]);

	      PlayerTextDrawFont(playerid, PlayerText:Farbauswahl[playerid][16], 5);
	      PlayerTextDrawSetPreviewModel(playerid, Farbauswahl[playerid][16], 1074);
	      PlayerTextDrawSetPreviewRot(playerid, Farbauswahl[playerid][16], 0, 0, 40, 0.9);
	      PlayerTextDrawColor(playerid, Farbauswahl[playerid][16], -1);
	      PlayerTextDrawShow(playerid, PlayerText:Farbauswahl[playerid][16]);

          PlayerTextDrawShow(playerid, PlayerText:TuningObjectBackground[playerid]);
          PlayerTextDrawShow(playerid, PlayerText:ModDone[playerid]);
          PlayerTextDrawShow(playerid, PlayerText:ModDone_[playerid]);
          PlayerTextDrawHide(playerid, PlayerText:LastModshopItem[playerid]);
          PlayerTextDrawHide(playerid, PlayerText:NextModshopItem[playerid]);
	 }
	 if(strcmp(string, "BumperVorn") == 0)
	 {
          PlayerTextDrawShow(playerid, PlayerText:TuningObjectBackground[playerid]);
          PlayerTextDrawShow(playerid, PlayerText:ModDone[playerid]);
          PlayerTextDrawShow(playerid, PlayerText:ModDone_[playerid]);
          PlayerTextDrawHide(playerid, PlayerText:LastModshopItem[playerid]);
          PlayerTextDrawHide(playerid, PlayerText:NextModshopItem[playerid]);
          if(GetVehicleCompatibleBumperVorn(GetPVarInt(playerid, "VehicleID")))
		  {
            PlayerTextDrawShow(playerid, PlayerText:Mod_Listitem1[playerid]);
            PlayerTextDrawShow(playerid, PlayerText:Mod_Listitem1_[playerid]);
            PlayerTextDrawSetString(playerid, PlayerText:Mod_Listitem1_[playerid], "1");
            PlayerTextDrawSetString(playerid, PlayerText:Mod_Listitem2_[playerid], "2");
            PlayerTextDrawShow(playerid, PlayerText:Mod_Listitem2_[playerid]);
            PlayerTextDrawShow(playerid, PlayerText:Mod_Listitem2[playerid]);
            PlayerTextDrawSetString(playerid, PlayerText:Mod_Listitem3_[playerid], "3");
            PlayerTextDrawShow(playerid, PlayerText:Mod_Listitem3_[playerid]);
            PlayerTextDrawShow(playerid, PlayerText:Mod_Listitem3[playerid]);
            PlayerTextDrawHide(playerid, PlayerText:LastModshopItem[playerid]);
            PlayerTextDrawHide(playerid, PlayerText:NextModshopItem[playerid]);
		  }
		  else
		  {
			PlayerTextDrawSetSelectable(playerid, PlayerText:Mod_Listitem1[playerid], 0);
            PlayerTextDrawShow(playerid, PlayerText:Mod_Listitem1[playerid]);
		    PlayerTextDrawSetString(playerid, PlayerText:Mod_Listitem1_[playerid], "Not compatible.");
            PlayerTextDrawShow(playerid, PlayerText:Mod_Listitem1_[playerid]);
			PlayerTextDrawSetSelectable(playerid, PlayerText:Mod_Listitem2[playerid], 0);
            PlayerTextDrawShow(playerid, PlayerText:Mod_Listitem2[playerid]);
            PlayerTextDrawShow(playerid, PlayerText:Mod_Listitem2_[playerid]);
			PlayerTextDrawSetSelectable(playerid, PlayerText:Mod_Listitem3[playerid], 0);
            PlayerTextDrawShow(playerid, PlayerText:Mod_Listitem3[playerid]);
            PlayerTextDrawShow(playerid, PlayerText:Mod_Listitem3_[playerid]);
			PlayerTextDrawSetSelectable(playerid, PlayerText:Mod_Listitem1[playerid], 1);
			PlayerTextDrawSetSelectable(playerid, PlayerText:Mod_Listitem2[playerid], 1);
			PlayerTextDrawSetSelectable(playerid, PlayerText:Mod_Listitem3[playerid], 1);
		    return 1;
          }
	 }
	 if(strcmp(string, "BumperHinten") == 0)
	 {
          PlayerTextDrawShow(playerid, PlayerText:TuningObjectBackground[playerid]);
          PlayerTextDrawShow(playerid, PlayerText:ModDone[playerid]);
          PlayerTextDrawShow(playerid, PlayerText:ModDone_[playerid]);
          PlayerTextDrawHide(playerid, PlayerText:LastModshopItem[playerid]);
          PlayerTextDrawHide(playerid, PlayerText:NextModshopItem[playerid]);
          if(GetVehicleCompatibleBumper2(GetPVarInt(playerid, "VehicleID")))
		  {
            PlayerTextDrawShow(playerid, PlayerText:Mod_Listitem1[playerid]);
            PlayerTextDrawShow(playerid, PlayerText:Mod_Listitem1_[playerid]);
            PlayerTextDrawSetString(playerid, PlayerText:Mod_Listitem1_[playerid], "1");
            PlayerTextDrawSetString(playerid, PlayerText:Mod_Listitem2_[playerid], "2");
            PlayerTextDrawShow(playerid, PlayerText:Mod_Listitem2_[playerid]);
            PlayerTextDrawShow(playerid, PlayerText:Mod_Listitem2[playerid]);
            PlayerTextDrawSetString(playerid, PlayerText:Mod_Listitem3_[playerid], "3");
            PlayerTextDrawShow(playerid, PlayerText:Mod_Listitem3_[playerid]);
            PlayerTextDrawShow(playerid, PlayerText:Mod_Listitem3[playerid]);
            PlayerTextDrawHide(playerid, PlayerText:LastModshopItem[playerid]);
            PlayerTextDrawHide(playerid, PlayerText:NextModshopItem[playerid]);
		  }
		  else
		  {
			PlayerTextDrawSetSelectable(playerid, PlayerText:Mod_Listitem1[playerid], 0);
            PlayerTextDrawShow(playerid, PlayerText:Mod_Listitem1[playerid]);
		    PlayerTextDrawSetString(playerid, PlayerText:Mod_Listitem1_[playerid], "Not compatible.");
            PlayerTextDrawShow(playerid, PlayerText:Mod_Listitem1_[playerid]);
			PlayerTextDrawSetSelectable(playerid, PlayerText:Mod_Listitem2[playerid], 0);
            PlayerTextDrawShow(playerid, PlayerText:Mod_Listitem2[playerid]);
            PlayerTextDrawShow(playerid, PlayerText:Mod_Listitem2_[playerid]);
			PlayerTextDrawSetSelectable(playerid, PlayerText:Mod_Listitem3[playerid], 0);
            PlayerTextDrawShow(playerid, PlayerText:Mod_Listitem3[playerid]);
            PlayerTextDrawShow(playerid, PlayerText:Mod_Listitem3_[playerid]);
			PlayerTextDrawSetSelectable(playerid, PlayerText:Mod_Listitem1[playerid], 1);
			PlayerTextDrawSetSelectable(playerid, PlayerText:Mod_Listitem2[playerid], 1);
			PlayerTextDrawSetSelectable(playerid, PlayerText:Mod_Listitem3[playerid], 1);
		    return 1;
          }
	 }
	 if(strcmp(string, "Spoiler") == 0)
	 {
          PlayerTextDrawShow(playerid, PlayerText:TuningObjectBackground[playerid]);
          PlayerTextDrawShow(playerid, PlayerText:ModDone[playerid]);
          PlayerTextDrawShow(playerid, PlayerText:ModDone_[playerid]);
          PlayerTextDrawHide(playerid, PlayerText:LastModshopItem[playerid]);
          PlayerTextDrawHide(playerid, PlayerText:NextModshopItem[playerid]);
          if(GetVehicleCompatibleSpoiler(GetPVarInt(playerid, "VehicleID")))
		  {
            PlayerTextDrawShow(playerid, PlayerText:Mod_Listitem1[playerid]);
            PlayerTextDrawShow(playerid, PlayerText:Mod_Listitem1_[playerid]);
            PlayerTextDrawSetString(playerid, PlayerText:Mod_Listitem1_[playerid], "1");
            PlayerTextDrawSetString(playerid, PlayerText:Mod_Listitem2_[playerid], "2");
            PlayerTextDrawShow(playerid, PlayerText:Mod_Listitem2_[playerid]);
            PlayerTextDrawShow(playerid, PlayerText:Mod_Listitem2[playerid]);
            PlayerTextDrawSetString(playerid, PlayerText:Mod_Listitem3_[playerid], "3");
            PlayerTextDrawShow(playerid, PlayerText:Mod_Listitem3_[playerid]);
            PlayerTextDrawShow(playerid, PlayerText:Mod_Listitem3[playerid]);
            PlayerTextDrawHide(playerid, PlayerText:LastModshopItem[playerid]);
            PlayerTextDrawHide(playerid, PlayerText:NextModshopItem[playerid]);
		  }
		  else
		  {
			PlayerTextDrawSetSelectable(playerid, PlayerText:Mod_Listitem1[playerid], 0);
            PlayerTextDrawShow(playerid, PlayerText:Mod_Listitem1[playerid]);
		    PlayerTextDrawSetString(playerid, PlayerText:Mod_Listitem1_[playerid], "Not compatible.");
            PlayerTextDrawShow(playerid, PlayerText:Mod_Listitem1_[playerid]);
			PlayerTextDrawSetSelectable(playerid, PlayerText:Mod_Listitem2[playerid], 0);
            PlayerTextDrawShow(playerid, PlayerText:Mod_Listitem2[playerid]);
		    PlayerTextDrawSetString(playerid, PlayerText:Mod_Listitem2_[playerid], "Go to objects");
            PlayerTextDrawShow(playerid, PlayerText:Mod_Listitem2_[playerid]);
			PlayerTextDrawSetSelectable(playerid, PlayerText:Mod_Listitem3[playerid], 0);
            PlayerTextDrawShow(playerid, PlayerText:Mod_Listitem3[playerid]);
		    PlayerTextDrawSetString(playerid, PlayerText:Mod_Listitem3_[playerid], "for custom spoilers");
            PlayerTextDrawShow(playerid, PlayerText:Mod_Listitem3_[playerid]);
			PlayerTextDrawSetSelectable(playerid, PlayerText:Mod_Listitem1[playerid], 1);
			PlayerTextDrawSetSelectable(playerid, PlayerText:Mod_Listitem2[playerid], 1);
			PlayerTextDrawSetSelectable(playerid, PlayerText:Mod_Listitem3[playerid], 1);
		    return 1;
          }
	 }
	 if(strcmp(string, "Auspuff") == 0)
	 {
          PlayerTextDrawShow(playerid, PlayerText:TuningObjectBackground[playerid]);
          PlayerTextDrawShow(playerid, PlayerText:ModDone[playerid]);
          PlayerTextDrawShow(playerid, PlayerText:ModDone_[playerid]);
          PlayerTextDrawHide(playerid, PlayerText:LastModshopItem[playerid]);
          PlayerTextDrawHide(playerid, PlayerText:NextModshopItem[playerid]);
          if(GetVehicleCompatibleAuspuff(GetPVarInt(playerid, "VehicleID")))
		  {
            PlayerTextDrawShow(playerid, PlayerText:Mod_Listitem1[playerid]);
            PlayerTextDrawShow(playerid, PlayerText:Mod_Listitem1_[playerid]);
            PlayerTextDrawSetString(playerid, PlayerText:Mod_Listitem1_[playerid], "1");
            PlayerTextDrawSetString(playerid, PlayerText:Mod_Listitem2_[playerid], "2");
            PlayerTextDrawShow(playerid, PlayerText:Mod_Listitem2_[playerid]);
            PlayerTextDrawShow(playerid, PlayerText:Mod_Listitem2[playerid]);
            PlayerTextDrawSetString(playerid, PlayerText:Mod_Listitem3_[playerid], "3");
            PlayerTextDrawShow(playerid, PlayerText:Mod_Listitem3_[playerid]);
            PlayerTextDrawShow(playerid, PlayerText:Mod_Listitem3[playerid]);
            PlayerTextDrawHide(playerid, PlayerText:LastModshopItem[playerid]);
            PlayerTextDrawHide(playerid, PlayerText:NextModshopItem[playerid]);
		  }
		  else
		  {
			PlayerTextDrawSetSelectable(playerid, PlayerText:Mod_Listitem1[playerid], 0);
            PlayerTextDrawShow(playerid, PlayerText:Mod_Listitem1[playerid]);
		    PlayerTextDrawSetString(playerid, PlayerText:Mod_Listitem1_[playerid], "Not compatible.");
            PlayerTextDrawShow(playerid, PlayerText:Mod_Listitem1_[playerid]);
			PlayerTextDrawSetSelectable(playerid, PlayerText:Mod_Listitem2[playerid], 0);
            PlayerTextDrawShow(playerid, PlayerText:Mod_Listitem2[playerid]);
		    PlayerTextDrawSetString(playerid, PlayerText:Mod_Listitem2_[playerid], "Go to objects");
            PlayerTextDrawShow(playerid, PlayerText:Mod_Listitem2_[playerid]);
			PlayerTextDrawSetSelectable(playerid, PlayerText:Mod_Listitem3[playerid], 0);
            PlayerTextDrawShow(playerid, PlayerText:Mod_Listitem3[playerid]);
		    PlayerTextDrawSetString(playerid, PlayerText:Mod_Listitem3_[playerid], "for custom exhausts");
            PlayerTextDrawShow(playerid, PlayerText:Mod_Listitem3_[playerid]);
			PlayerTextDrawSetSelectable(playerid, PlayerText:Mod_Listitem1[playerid], 1);
			PlayerTextDrawSetSelectable(playerid, PlayerText:Mod_Listitem2[playerid], 1);
			PlayerTextDrawSetSelectable(playerid, PlayerText:Mod_Listitem3[playerid], 1);
		    return 1;
          }
	 }
	 if(strcmp(string, "Motorhaube") == 0)
	 {
          PlayerTextDrawShow(playerid, PlayerText:TuningObjectBackground[playerid]);
          PlayerTextDrawShow(playerid, PlayerText:ModDone[playerid]);
          PlayerTextDrawShow(playerid, PlayerText:ModDone_[playerid]);
          PlayerTextDrawHide(playerid, PlayerText:LastModshopItem[playerid]);
          PlayerTextDrawHide(playerid, PlayerText:NextModshopItem[playerid]);
          if(GetVehicleCompatibleMotorhaube(GetPVarInt(playerid, "VehicleID")))
		  {
            PlayerTextDrawShow(playerid, PlayerText:Mod_Listitem1[playerid]);
            PlayerTextDrawShow(playerid, PlayerText:Mod_Listitem1_[playerid]);
            PlayerTextDrawSetString(playerid, PlayerText:Mod_Listitem1_[playerid], "1");
            PlayerTextDrawSetString(playerid, PlayerText:Mod_Listitem2_[playerid], "2");
            PlayerTextDrawShow(playerid, PlayerText:Mod_Listitem2_[playerid]);
            PlayerTextDrawShow(playerid, PlayerText:Mod_Listitem2[playerid]);
            PlayerTextDrawSetString(playerid, PlayerText:Mod_Listitem3_[playerid], "3");
            PlayerTextDrawShow(playerid, PlayerText:Mod_Listitem3_[playerid]);
            PlayerTextDrawShow(playerid, PlayerText:Mod_Listitem3[playerid]);
            PlayerTextDrawHide(playerid, PlayerText:LastModshopItem[playerid]);
            PlayerTextDrawHide(playerid, PlayerText:NextModshopItem[playerid]);
		  }
		  else
		  {
			PlayerTextDrawSetSelectable(playerid, PlayerText:Mod_Listitem1[playerid], 0);
            PlayerTextDrawShow(playerid, PlayerText:Mod_Listitem1[playerid]);
		    PlayerTextDrawSetString(playerid, PlayerText:Mod_Listitem1_[playerid], "Not compatible.");
            PlayerTextDrawShow(playerid, PlayerText:Mod_Listitem1_[playerid]);
			PlayerTextDrawSetSelectable(playerid, PlayerText:Mod_Listitem2[playerid], 0);
            PlayerTextDrawShow(playerid, PlayerText:Mod_Listitem2[playerid]);
		    PlayerTextDrawSetString(playerid, PlayerText:Mod_Listitem2_[playerid], "Go to objects");
            PlayerTextDrawShow(playerid, PlayerText:Mod_Listitem2_[playerid]);
			PlayerTextDrawSetSelectable(playerid, PlayerText:Mod_Listitem3[playerid], 0);
            PlayerTextDrawShow(playerid, PlayerText:Mod_Listitem3[playerid]);
		    PlayerTextDrawSetString(playerid, PlayerText:Mod_Listitem3_[playerid], "for custom objects");
            PlayerTextDrawShow(playerid, PlayerText:Mod_Listitem3_[playerid]);
			PlayerTextDrawSetSelectable(playerid, PlayerText:Mod_Listitem1[playerid], 1);
			PlayerTextDrawSetSelectable(playerid, PlayerText:Mod_Listitem2[playerid], 1);
			PlayerTextDrawSetSelectable(playerid, PlayerText:Mod_Listitem3[playerid], 1);
		    return 1;
          }
	 }
	 if(strcmp(string, "Nebelleuchten") == 0)
	 {
          PlayerTextDrawShow(playerid, PlayerText:TuningObjectBackground[playerid]);
          PlayerTextDrawShow(playerid, PlayerText:ModDone[playerid]);
          PlayerTextDrawShow(playerid, PlayerText:ModDone_[playerid]);
          PlayerTextDrawHide(playerid, PlayerText:LastModshopItem[playerid]);
          PlayerTextDrawHide(playerid, PlayerText:NextModshopItem[playerid]);
          if(GetVehicleCompatibleLicht(GetPVarInt(playerid, "VehicleID")))
		  {
            PlayerTextDrawShow(playerid, PlayerText:Mod_Listitem1[playerid]);
            PlayerTextDrawShow(playerid, PlayerText:Mod_Listitem1_[playerid]);
            PlayerTextDrawSetString(playerid, PlayerText:Mod_Listitem1_[playerid], "1");
            PlayerTextDrawSetString(playerid, PlayerText:Mod_Listitem2_[playerid], "2");
            PlayerTextDrawShow(playerid, PlayerText:Mod_Listitem2_[playerid]);
            PlayerTextDrawShow(playerid, PlayerText:Mod_Listitem2[playerid]);
            PlayerTextDrawSetString(playerid, PlayerText:Mod_Listitem3_[playerid], "3");
            PlayerTextDrawShow(playerid, PlayerText:Mod_Listitem3_[playerid]);
            PlayerTextDrawShow(playerid, PlayerText:Mod_Listitem3[playerid]);
            PlayerTextDrawHide(playerid, PlayerText:LastModshopItem[playerid]);
            PlayerTextDrawHide(playerid, PlayerText:NextModshopItem[playerid]);
		  }
		  else
		  {
			PlayerTextDrawSetSelectable(playerid, PlayerText:Mod_Listitem1[playerid], 0);
            PlayerTextDrawShow(playerid, PlayerText:Mod_Listitem1[playerid]);
		    PlayerTextDrawSetString(playerid, PlayerText:Mod_Listitem1_[playerid], "Not compatible.");
            PlayerTextDrawShow(playerid, PlayerText:Mod_Listitem1_[playerid]);
			PlayerTextDrawSetSelectable(playerid, PlayerText:Mod_Listitem1[playerid], 1);
		    return 1;
          }
	 }
	 if(strcmp(string, "Dach") == 0)
	 {
          PlayerTextDrawShow(playerid, PlayerText:TuningObjectBackground[playerid]);
          PlayerTextDrawShow(playerid, PlayerText:ModDone[playerid]);
          PlayerTextDrawShow(playerid, PlayerText:ModDone_[playerid]);
          PlayerTextDrawHide(playerid, PlayerText:LastModshopItem[playerid]);
          PlayerTextDrawHide(playerid, PlayerText:NextModshopItem[playerid]);
          if(GetVehicleCompatibleDach(GetPVarInt(playerid, "VehicleID")))
		  {
            PlayerTextDrawShow(playerid, PlayerText:Mod_Listitem1[playerid]);
            PlayerTextDrawShow(playerid, PlayerText:Mod_Listitem1_[playerid]);
            PlayerTextDrawSetString(playerid, PlayerText:Mod_Listitem1_[playerid], "1");
            PlayerTextDrawSetString(playerid, PlayerText:Mod_Listitem2_[playerid], "2");
            PlayerTextDrawShow(playerid, PlayerText:Mod_Listitem2_[playerid]);
            PlayerTextDrawShow(playerid, PlayerText:Mod_Listitem2[playerid]);
            PlayerTextDrawSetString(playerid, PlayerText:Mod_Listitem3_[playerid], "3");
            PlayerTextDrawShow(playerid, PlayerText:Mod_Listitem3_[playerid]);
            PlayerTextDrawShow(playerid, PlayerText:Mod_Listitem3[playerid]);
            PlayerTextDrawHide(playerid, PlayerText:LastModshopItem[playerid]);
            PlayerTextDrawHide(playerid, PlayerText:NextModshopItem[playerid]);
		  }
		  else
		  {
			PlayerTextDrawSetSelectable(playerid, PlayerText:Mod_Listitem1[playerid], 0);
            PlayerTextDrawShow(playerid, PlayerText:Mod_Listitem1[playerid]);
		    PlayerTextDrawSetString(playerid, PlayerText:Mod_Listitem1_[playerid], "Not compatible.");
            PlayerTextDrawShow(playerid, PlayerText:Mod_Listitem1_[playerid]);
			PlayerTextDrawSetSelectable(playerid, PlayerText:Mod_Listitem2[playerid], 0);
            PlayerTextDrawShow(playerid, PlayerText:Mod_Listitem2[playerid]);
		    PlayerTextDrawSetString(playerid, PlayerText:Mod_Listitem2_[playerid], "Go to objects");
            PlayerTextDrawShow(playerid, PlayerText:Mod_Listitem2_[playerid]);
			PlayerTextDrawSetSelectable(playerid, PlayerText:Mod_Listitem3[playerid], 0);
            PlayerTextDrawShow(playerid, PlayerText:Mod_Listitem3[playerid]);
		    PlayerTextDrawSetString(playerid, PlayerText:Mod_Listitem3_[playerid], "for custom objects");
            PlayerTextDrawShow(playerid, PlayerText:Mod_Listitem3_[playerid]);
			PlayerTextDrawSetSelectable(playerid, PlayerText:Mod_Listitem1[playerid], 1);
			PlayerTextDrawSetSelectable(playerid, PlayerText:Mod_Listitem2[playerid], 1);
			PlayerTextDrawSetSelectable(playerid, PlayerText:Mod_Listitem3[playerid], 1);
		    return 1;
          }
	 }
	 if(strcmp(string, "Schweller") == 0)
	 {
          PlayerTextDrawShow(playerid, PlayerText:TuningObjectBackground[playerid]);
          PlayerTextDrawShow(playerid, PlayerText:ModDone[playerid]);
          PlayerTextDrawShow(playerid, PlayerText:ModDone_[playerid]);
          PlayerTextDrawHide(playerid, PlayerText:LastModshopItem[playerid]);
          PlayerTextDrawHide(playerid, PlayerText:NextModshopItem[playerid]);
          if(GetVehicleCompatibleSchweller(GetPVarInt(playerid, "VehicleID")))
		  {
            PlayerTextDrawShow(playerid, PlayerText:Mod_Listitem1[playerid]);
            PlayerTextDrawShow(playerid, PlayerText:Mod_Listitem1_[playerid]);
            PlayerTextDrawSetString(playerid, PlayerText:Mod_Listitem1_[playerid], "1");
            PlayerTextDrawSetString(playerid, PlayerText:Mod_Listitem2_[playerid], "2");
            PlayerTextDrawShow(playerid, PlayerText:Mod_Listitem2_[playerid]);
            PlayerTextDrawShow(playerid, PlayerText:Mod_Listitem2[playerid]);
            PlayerTextDrawSetString(playerid, PlayerText:Mod_Listitem3_[playerid], "3");
            PlayerTextDrawShow(playerid, PlayerText:Mod_Listitem3_[playerid]);
            PlayerTextDrawShow(playerid, PlayerText:Mod_Listitem3[playerid]);
            PlayerTextDrawHide(playerid, PlayerText:LastModshopItem[playerid]);
            PlayerTextDrawHide(playerid, PlayerText:NextModshopItem[playerid]);
		  }
		  else
		  {
			PlayerTextDrawSetSelectable(playerid, PlayerText:Mod_Listitem1[playerid], 0);
            PlayerTextDrawShow(playerid, PlayerText:Mod_Listitem1[playerid]);
		    PlayerTextDrawSetString(playerid, PlayerText:Mod_Listitem1_[playerid], "Not compatible.");
            PlayerTextDrawShow(playerid, PlayerText:Mod_Listitem1_[playerid]);
			PlayerTextDrawSetSelectable(playerid, PlayerText:Mod_Listitem2[playerid], 0);
            PlayerTextDrawShow(playerid, PlayerText:Mod_Listitem2[playerid]);
		    PlayerTextDrawSetString(playerid, PlayerText:Mod_Listitem2_[playerid], "Go to objects");
            PlayerTextDrawShow(playerid, PlayerText:Mod_Listitem2_[playerid]);
			PlayerTextDrawSetSelectable(playerid, PlayerText:Mod_Listitem3[playerid], 0);
            PlayerTextDrawShow(playerid, PlayerText:Mod_Listitem3[playerid]);
		    PlayerTextDrawSetString(playerid, PlayerText:Mod_Listitem3_[playerid], "for custom skirts");
            PlayerTextDrawShow(playerid, PlayerText:Mod_Listitem3_[playerid]);
			PlayerTextDrawSetSelectable(playerid, PlayerText:Mod_Listitem1[playerid], 1);
			PlayerTextDrawSetSelectable(playerid, PlayerText:Mod_Listitem2[playerid], 1);
			PlayerTextDrawSetSelectable(playerid, PlayerText:Mod_Listitem3[playerid], 1);
		    return 1;
          }
	 }
	 if(strcmp(string, "Tachofarbe") == 0)
	 {
          PlayerTextDrawShow(playerid, PlayerText:TuningObjectBackground[playerid]);
          PlayerTextDrawShow(playerid, PlayerText:ModDone[playerid]);
          PlayerTextDrawShow(playerid, PlayerText:ModDone_[playerid]);
          PlayerTextDrawSetString(playerid, PlayerText:Mod_Listitem1_[playerid], "Border");
          PlayerTextDrawShow(playerid, PlayerText:Mod_Listitem1_[playerid]);
          PlayerTextDrawShow(playerid, PlayerText:Mod_Listitem1[playerid]);
          PlayerTextDrawSetString(playerid, PlayerText:Mod_Listitem2_[playerid], "Inside");
          PlayerTextDrawShow(playerid, PlayerText:Mod_Listitem2_[playerid]);
          PlayerTextDrawShow(playerid, PlayerText:Mod_Listitem2[playerid]);
          PlayerTextDrawSetString(playerid, PlayerText:Mod_Listitem3_[playerid], "Numbers");
          PlayerTextDrawShow(playerid, PlayerText:Mod_Listitem3_[playerid]);
          PlayerTextDrawShow(playerid, PlayerText:Mod_Listitem3[playerid]);
          PlayerTextDrawHide(playerid, PlayerText:LastModshopItem[playerid]);
          PlayerTextDrawHide(playerid, PlayerText:NextModshopItem[playerid]);
          Speedometer_Show(playerid,1);
	 }
	 if(strcmp(string, "Objekte") == 0)
	 {
		  //TogglePlayerSpectating(playerid, 1);//Toggleplayerspectating wird eingeschaltet
	      InterpolateCameraPos(playerid, 606.746948+modshoppos, -7.408711+modshoppos, 1003.267333, 606.746948+modshoppos, -7.408711+modshoppos, 1003.267333, 1000);
	      InterpolateCameraLookAt(playerid, 611.242797+modshoppos, -9.439126+modshoppos, 1002.452026, 611.242797+modshoppos, -9.439126+modshoppos, 1002.452026, 1000);
	      PlayerTextDrawFont(playerid, PlayerText:Farbauswahl[playerid][0], 5);
	      PlayerTextDrawSetPreviewModel(playerid, Farbauswahl[playerid][0], ModObjekt_0);
	      PlayerTextDrawSetPreviewRot(playerid, Farbauswahl[playerid][0], -22.5, 0.0, 202.5, 0.9);
	      PlayerTextDrawColor(playerid, Farbauswahl[playerid][0], -1);
	      PlayerTextDrawShow(playerid, PlayerText:Farbauswahl[playerid][0]);

	      PlayerTextDrawFont(playerid, PlayerText:Farbauswahl[playerid][1], 5);
	      PlayerTextDrawSetPreviewModel(playerid, Farbauswahl[playerid][1], ModObjekt_1);
	      PlayerTextDrawSetPreviewRot(playerid, Farbauswahl[playerid][1], 0, 0, 40, 0.9);
	      PlayerTextDrawColor(playerid, Farbauswahl[playerid][1], -1);
	      PlayerTextDrawShow(playerid, PlayerText:Farbauswahl[playerid][1]);

	      PlayerTextDrawFont(playerid, PlayerText:Farbauswahl[playerid][2], 5);
	      PlayerTextDrawSetPreviewModel(playerid, Farbauswahl[playerid][2], ModObjekt_2);
	      PlayerTextDrawSetPreviewRot(playerid, Farbauswahl[playerid][2], 0, 0, 40, 0.9);
	      PlayerTextDrawColor(playerid, Farbauswahl[playerid][2], -1);
	      PlayerTextDrawShow(playerid, PlayerText:Farbauswahl[playerid][2]);

	      PlayerTextDrawFont(playerid, PlayerText:Farbauswahl[playerid][3], 5);
	      PlayerTextDrawSetPreviewModel(playerid, Farbauswahl[playerid][3], ModObjekt_3);
	      PlayerTextDrawSetPreviewRot(playerid, Farbauswahl[playerid][3], 0, 0, 40, 0.9);
	      PlayerTextDrawColor(playerid, Farbauswahl[playerid][3], -1);
	      PlayerTextDrawShow(playerid, PlayerText:Farbauswahl[playerid][3]);

	      PlayerTextDrawFont(playerid, PlayerText:Farbauswahl[playerid][4], 5);
	      PlayerTextDrawSetPreviewModel(playerid, Farbauswahl[playerid][4], ModObjekt_4);
	      PlayerTextDrawSetPreviewRot(playerid, Farbauswahl[playerid][4], 0, 0, 40, 0.9);
	      PlayerTextDrawColor(playerid, Farbauswahl[playerid][4], -1);
	      PlayerTextDrawShow(playerid, PlayerText:Farbauswahl[playerid][4]);

	      PlayerTextDrawFont(playerid, PlayerText:Farbauswahl[playerid][5], 5);
	      PlayerTextDrawSetPreviewModel(playerid, Farbauswahl[playerid][5], ModObjekt_5);
	      PlayerTextDrawSetPreviewRot(playerid, Farbauswahl[playerid][5], 0, 0, 40, 0.9);
	      PlayerTextDrawColor(playerid, Farbauswahl[playerid][5], -1);
	      PlayerTextDrawShow(playerid, PlayerText:Farbauswahl[playerid][5]);

	      PlayerTextDrawFont(playerid, PlayerText:Farbauswahl[playerid][6], 5);
	      PlayerTextDrawSetPreviewModel(playerid, Farbauswahl[playerid][6], ModObjekt_6);
	      PlayerTextDrawSetPreviewRot(playerid, Farbauswahl[playerid][6], 0, 0, 40, 0.9);
	      PlayerTextDrawColor(playerid, Farbauswahl[playerid][6], -1);
	      PlayerTextDrawShow(playerid, PlayerText:Farbauswahl[playerid][6]);

	      PlayerTextDrawFont(playerid, PlayerText:Farbauswahl[playerid][7], 5);
	      PlayerTextDrawSetPreviewModel(playerid, Farbauswahl[playerid][7], ModObjekt_7);
	      PlayerTextDrawSetPreviewRot(playerid, Farbauswahl[playerid][7], 0, 0, 40, 0.9);
	      PlayerTextDrawColor(playerid, Farbauswahl[playerid][7], -1);
	      PlayerTextDrawShow(playerid, PlayerText:Farbauswahl[playerid][7]);

	      PlayerTextDrawFont(playerid, PlayerText:Farbauswahl[playerid][8], 5);
	      PlayerTextDrawSetPreviewModel(playerid, Farbauswahl[playerid][8], ModObjekt_8);
	      PlayerTextDrawSetPreviewRot(playerid, Farbauswahl[playerid][8], 0, 0, 40, 0.9);
	      PlayerTextDrawColor(playerid, Farbauswahl[playerid][8], -1);
	      PlayerTextDrawShow(playerid, PlayerText:Farbauswahl[playerid][8]);

	      PlayerTextDrawFont(playerid, PlayerText:Farbauswahl[playerid][9], 5);
	      PlayerTextDrawSetPreviewModel(playerid, Farbauswahl[playerid][9], ModObjekt_9);
	      PlayerTextDrawSetPreviewRot(playerid, Farbauswahl[playerid][9], 0, 0, 40, 0.9);
	      PlayerTextDrawColor(playerid, Farbauswahl[playerid][9], -1);
	      PlayerTextDrawShow(playerid, PlayerText:Farbauswahl[playerid][9]);

	      PlayerTextDrawFont(playerid, PlayerText:Farbauswahl[playerid][10], 5);
	      PlayerTextDrawSetPreviewModel(playerid, Farbauswahl[playerid][10], ModObjekt_10);
	      PlayerTextDrawSetPreviewRot(playerid, Farbauswahl[playerid][10], 0, 0, 40, 0.9);
	      PlayerTextDrawColor(playerid, Farbauswahl[playerid][10], -1);
	      PlayerTextDrawShow(playerid, PlayerText:Farbauswahl[playerid][10]);

	      PlayerTextDrawFont(playerid, PlayerText:Farbauswahl[playerid][11], 5);
	      PlayerTextDrawSetPreviewModel(playerid, Farbauswahl[playerid][11], ModObjekt_11);
	      PlayerTextDrawSetPreviewRot(playerid, Farbauswahl[playerid][11], 0, 0, 40, 0.9);
	      PlayerTextDrawColor(playerid, Farbauswahl[playerid][11], -1);
	      PlayerTextDrawShow(playerid, PlayerText:Farbauswahl[playerid][11]);

	      PlayerTextDrawFont(playerid, PlayerText:Farbauswahl[playerid][12], 5);
	      PlayerTextDrawSetPreviewModel(playerid, Farbauswahl[playerid][12], ModObjekt_12);
	      PlayerTextDrawSetPreviewRot(playerid, Farbauswahl[playerid][12], 0, 0, 40, 0.9);
	      PlayerTextDrawColor(playerid, Farbauswahl[playerid][12], -1);
	      PlayerTextDrawShow(playerid, PlayerText:Farbauswahl[playerid][12]);

	      PlayerTextDrawFont(playerid, PlayerText:Farbauswahl[playerid][13], 5);
	      PlayerTextDrawSetPreviewModel(playerid, Farbauswahl[playerid][13], ModObjekt_13);
	      PlayerTextDrawSetPreviewRot(playerid, Farbauswahl[playerid][13], 0, 0, 40, 0.9);
	      PlayerTextDrawColor(playerid, Farbauswahl[playerid][13], -1);
	      PlayerTextDrawShow(playerid, PlayerText:Farbauswahl[playerid][13]);

	      PlayerTextDrawFont(playerid, PlayerText:Farbauswahl[playerid][14], 5);
	      PlayerTextDrawSetPreviewModel(playerid, Farbauswahl[playerid][14], ModObjekt_14);
	      PlayerTextDrawSetPreviewRot(playerid, Farbauswahl[playerid][14], 0, 0, 40, 0.9);
	      PlayerTextDrawColor(playerid, Farbauswahl[playerid][14], -1);
	      PlayerTextDrawShow(playerid, PlayerText:Farbauswahl[playerid][14]);

	      PlayerTextDrawFont(playerid, PlayerText:Farbauswahl[playerid][15], 5);
	      PlayerTextDrawSetPreviewModel(playerid, Farbauswahl[playerid][15], ModObjekt_15);
	      PlayerTextDrawSetPreviewRot(playerid, Farbauswahl[playerid][15], 0, 0, 40, 0.9);
	      PlayerTextDrawColor(playerid, Farbauswahl[playerid][15], -1);
	      PlayerTextDrawShow(playerid, PlayerText:Farbauswahl[playerid][15]);

	      PlayerTextDrawFont(playerid, PlayerText:Farbauswahl[playerid][16], 5);
	      PlayerTextDrawSetPreviewModel(playerid, Farbauswahl[playerid][16], ModObjekt_16);
	      PlayerTextDrawSetPreviewRot(playerid, Farbauswahl[playerid][16], 0, 0, 40, 0.9);
	      PlayerTextDrawColor(playerid, Farbauswahl[playerid][16], -1);
	      PlayerTextDrawShow(playerid, PlayerText:Farbauswahl[playerid][16]);

	      PlayerTextDrawFont(playerid, PlayerText:Farbauswahl[playerid][17], 5);
	      PlayerTextDrawSetPreviewModel(playerid, Farbauswahl[playerid][17], ModObjekt_17);
	      PlayerTextDrawSetPreviewRot(playerid, Farbauswahl[playerid][17], 0, 0, 40, 0.9);
	      PlayerTextDrawColor(playerid, Farbauswahl[playerid][17], -1);
	      PlayerTextDrawShow(playerid, PlayerText:Farbauswahl[playerid][17]);

	      PlayerTextDrawFont(playerid, PlayerText:Farbauswahl[playerid][18], 5);
	      PlayerTextDrawSetPreviewModel(playerid, Farbauswahl[playerid][18], ModObjekt_18);
	      PlayerTextDrawSetPreviewRot(playerid, Farbauswahl[playerid][18], 0, 0, 40, 0.9);
	      PlayerTextDrawColor(playerid, Farbauswahl[playerid][18], -1);
	      PlayerTextDrawShow(playerid, PlayerText:Farbauswahl[playerid][18]);

	      PlayerTextDrawFont(playerid, PlayerText:Farbauswahl[playerid][19], 5);
	      PlayerTextDrawSetPreviewModel(playerid, Farbauswahl[playerid][19], ModObjekt_19);
	      PlayerTextDrawSetPreviewRot(playerid, Farbauswahl[playerid][19], 0, 0, 40, 0.9);
	      PlayerTextDrawColor(playerid, Farbauswahl[playerid][19], -1);
	      PlayerTextDrawShow(playerid, PlayerText:Farbauswahl[playerid][19]);

          PlayerTextDrawShow(playerid, PlayerText:TuningObjectBackground[playerid]);
          PlayerTextDrawShow(playerid, PlayerText:ModDone[playerid]);
          PlayerTextDrawShow(playerid, PlayerText:ModDone_[playerid]);
          PlayerTextDrawHide(playerid, PlayerText:LastModshopItem[playerid]);
          PlayerTextDrawHide(playerid, PlayerText:NextModshopItem[playerid]);
          TextDrawShowForPlayer(playerid, CustomModShopObjectRight);
          TextDrawShowForPlayer(playerid, CustomModShopObjectLeft);
		  //PlayerTextDrawSetString(playerid, ModDone_[playerid], "Pick Object");
	 }
	 if(strcmp(string, "ReSpezial") == 0)
	 {
          PlayerTextDrawShow(playerid, PlayerText:TuningObjectBackground[playerid]);
          PlayerTextDrawShow(playerid, PlayerText:ModDone[playerid]);
          PlayerTextDrawShow(playerid, PlayerText:ModDone_[playerid]);
          PlayerTextDrawSetString(playerid, PlayerText:Mod_Listitem1_[playerid], "Skull");
          PlayerTextDrawShow(playerid, PlayerText:Mod_Listitem1_[playerid]);
          PlayerTextDrawShow(playerid, PlayerText:Mod_Listitem1[playerid]);
          PlayerTextDrawSetString(playerid, PlayerText:Mod_Listitem2_[playerid], "Chrome Grill");
          PlayerTextDrawShow(playerid, PlayerText:Mod_Listitem2_[playerid]);
          PlayerTextDrawShow(playerid, PlayerText:Mod_Listitem2[playerid]);
          PlayerTextDrawSetString(playerid, PlayerText:Mod_Listitem3_[playerid], "Light Covers");
          PlayerTextDrawShow(playerid, PlayerText:Mod_Listitem3_[playerid]);
          PlayerTextDrawShow(playerid, PlayerText:Mod_Listitem3[playerid]);
          PlayerTextDrawHide(playerid, PlayerText:LastModshopItem[playerid]);
          PlayerTextDrawHide(playerid, PlayerText:NextModshopItem[playerid]);
	 }
	 if(strcmp(string, "SlSpezial") == 0)
	 {
          PlayerTextDrawShow(playerid, PlayerText:TuningObjectBackground[playerid]);
          PlayerTextDrawShow(playerid, PlayerText:ModDone[playerid]);
          PlayerTextDrawShow(playerid, PlayerText:ModDone_[playerid]);
          PlayerTextDrawSetString(playerid, PlayerText:Mod_Listitem1_[playerid], "Bullbar 1");
          PlayerTextDrawShow(playerid, PlayerText:Mod_Listitem1_[playerid]);
          PlayerTextDrawShow(playerid, PlayerText:Mod_Listitem1[playerid]);
          PlayerTextDrawSetString(playerid, PlayerText:Mod_Listitem2_[playerid], "Bullbar 2");
          PlayerTextDrawShow(playerid, PlayerText:Mod_Listitem2_[playerid]);
          PlayerTextDrawShow(playerid, PlayerText:Mod_Listitem2[playerid]);
          PlayerTextDrawSetString(playerid, PlayerText:Mod_Listitem3_[playerid], "Rear Light Cover");
          PlayerTextDrawShow(playerid, PlayerText:Mod_Listitem3_[playerid]);
          PlayerTextDrawShow(playerid, PlayerText:Mod_Listitem3[playerid]);
          PlayerTextDrawHide(playerid, PlayerText:LastModshopItem[playerid]);
          PlayerTextDrawHide(playerid, PlayerText:NextModshopItem[playerid]);
	 }
     return 1;
  }
  if(playertextid == Mod_Listitem1[playerid])
  {
	 PlayerPlaySound(playerid, 1083, 0, 0, 0);
	 new string[25];
	 GetPVarString(playerid, "Modshop", string, sizeof string);
	 if(strcmp(string, "Nitro") == 0)
	 {
	    AddModVehicleComponent(GetPVarInt(playerid, "VehicleID"), 1009);
	    SetPVarInt(playerid, "ModShop_Nitro", 4500);
	 	new Preis = GetPVarInt(playerid, "ModShop_Nitro");
	 	format(string, sizeof string, "$%i", Preis);
	 	PlayerTextDrawSetString(playerid, PlayerText:ModshopPreis[playerid], string);
	 	PlayerTextDrawShow(playerid, PlayerText:ModshopPreis[playerid]);
	 }
	 if(strcmp(string, "Fahrwerk") == 0)
	 {
	    AddModVehicleComponent(GetPVarInt(playerid, "VehicleID"), 1087);
	    SetPVarInt(playerid, "ModShop_Fahrwerk", 10500);
	 	new Preis = GetPVarInt(playerid, "ModShop_Fahrwerk");
	 	format(string, sizeof string, "$%i", Preis);
	 	PlayerTextDrawSetString(playerid, PlayerText:ModshopPreis[playerid], string);
	 	PlayerTextDrawShow(playerid, PlayerText:ModshopPreis[playerid]);
	 }
	 if(strcmp(string, "Spoiler") == 0)
	 {
	    AddModVehicleComponent(GetPVarInt(playerid, "VehicleID"), 1000);
	    SetPVarInt(playerid, "ModShop_Spoiler", 8500);
	 	new Preis = GetPVarInt(playerid, "ModShop_Spoiler");
	 	format(string, sizeof string, "$%i", Preis);
	 	PlayerTextDrawSetString(playerid, PlayerText:ModshopPreis[playerid], string);
	 	PlayerTextDrawShow(playerid, PlayerText:ModshopPreis[playerid]);
	 }
	 if(strcmp(string, "Tachofarbe") == 0)
	 {
	    PlayerTextDrawHide(playerid, PlayerText:Mod_Listitem1[playerid]);
	    PlayerTextDrawHide(playerid, PlayerText:Mod_Listitem1_[playerid]);
	    PlayerTextDrawHide(playerid, PlayerText:Mod_Listitem2[playerid]);
	    PlayerTextDrawHide(playerid, PlayerText:Mod_Listitem2_[playerid]);
	    PlayerTextDrawHide(playerid, PlayerText:Mod_Listitem3[playerid]);
	    PlayerTextDrawHide(playerid, PlayerText:Mod_Listitem3_[playerid]);
	    PlayerTextDrawShow(playerid, PlayerText:Farbauswahl[playerid][0]);
	    PlayerTextDrawShow(playerid, PlayerText:Farbauswahl[playerid][1]);
	    PlayerTextDrawShow(playerid, PlayerText:Farbauswahl[playerid][2]);
	    PlayerTextDrawShow(playerid, PlayerText:Farbauswahl[playerid][3]);
	    PlayerTextDrawShow(playerid, PlayerText:Farbauswahl[playerid][4]);
	    PlayerTextDrawShow(playerid, PlayerText:Farbauswahl[playerid][5]);
	    PlayerTextDrawShow(playerid, PlayerText:Farbauswahl[playerid][6]);
	    PlayerTextDrawShow(playerid, PlayerText:Farbauswahl[playerid][7]);
	    PlayerTextDrawShow(playerid, PlayerText:Farbauswahl[playerid][8]);
	    PlayerTextDrawShow(playerid, PlayerText:Farbauswahl[playerid][9]);
	    PlayerTextDrawShow(playerid, PlayerText:Farbauswahl[playerid][10]);
	    PlayerTextDrawShow(playerid, PlayerText:Farbauswahl[playerid][11]);
	    PlayerTextDrawShow(playerid, PlayerText:Farbauswahl[playerid][12]);
	    PlayerTextDrawShow(playerid, PlayerText:Farbauswahl[playerid][13]);
	    PlayerTextDrawShow(playerid, PlayerText:Farbauswahl[playerid][14]);
	    PlayerTextDrawShow(playerid, PlayerText:Farbauswahl[playerid][15]);
	    PlayerTextDrawShow(playerid, PlayerText:Farbauswahl[playerid][16]);
	    PlayerTextDrawShow(playerid, PlayerText:Farbauswahl[playerid][17]);
	    PlayerTextDrawShow(playerid, PlayerText:Farbauswahl[playerid][18]);
	    SetPVarInt(playerid, "Tachofarbe", 1);
		SetPVarInt(playerid, "Tachobereich", 1);
	 }
	 if(strcmp(string, "SlSpezial") == 0)
	 {
	    AddModVehicleComponent(GetPVarInt(playerid, "VehicleID"), 1115);
	    SetPVarInt(playerid, "ModShop_Slamvan", 6200);
	 	new Preis = GetPVarInt(playerid, "ModShop_Slamvan");
	 	format(string, sizeof string, "$%i", Preis);
	 	PlayerTextDrawSetString(playerid, PlayerText:ModshopPreis[playerid], string);
	 	PlayerTextDrawShow(playerid, PlayerText:ModshopPreis[playerid]);
	 }
	 if(strcmp(string, "ReSpezial") == 0)
	 {
	    AddModVehicleComponent(GetPVarInt(playerid, "VehicleID"), 1100);
	    SetPVarInt(playerid, "ModShop_Remington", 5200);
	 	new Preis = GetPVarInt(playerid, "ModShop_Remington");
	 	format(string, sizeof string, "$%i", Preis);
	 	PlayerTextDrawSetString(playerid, PlayerText:ModshopPreis[playerid], string);
	 	PlayerTextDrawShow(playerid, PlayerText:ModshopPreis[playerid]);
	 }
	 PlayerPlaySound(playerid, 1083, 0, 0, 0);
  }
  if(playertextid == Mod_Listitem2[playerid])
  {
	 new string[25];
	 GetPVarString(playerid, "Modshop", string, sizeof string);
	 if(strcmp(string, "Nitro") == 0)
	 {
	    AddModVehicleComponent(GetPVarInt(playerid, "VehicleID"), 1008);
	    SetPVarInt(playerid, "ModShop_Nitro", 6800);
	 	new Preis = GetPVarInt(playerid, "ModShop_Nitro");
	 	format(string, sizeof string, "$%i", Preis);
	 	PlayerTextDrawSetString(playerid, PlayerText:ModshopPreis[playerid], string);
	 	PlayerTextDrawShow(playerid, PlayerText:ModshopPreis[playerid]);
	 }
	 if(strcmp(string, "Spoiler") == 0)
	 {
	    AddModVehicleComponent(GetPVarInt(playerid, "VehicleID"), 1001);
	    SetPVarInt(playerid, "ModShop_Spoiler", 8500);
	 	new Preis = GetPVarInt(playerid, "ModShop_Spoiler");
	 	format(string, sizeof string, "$%i", Preis);
	 	PlayerTextDrawSetString(playerid, PlayerText:ModshopPreis[playerid], string);
	 	PlayerTextDrawShow(playerid, PlayerText:ModshopPreis[playerid]);
	 }
	 if(strcmp(string, "Tachofarbe") == 0)
	 {
	    PlayerTextDrawHide(playerid, PlayerText:Mod_Listitem1[playerid]);
	    PlayerTextDrawHide(playerid, PlayerText:Mod_Listitem1_[playerid]);
	    PlayerTextDrawHide(playerid, PlayerText:Mod_Listitem2[playerid]);
	    PlayerTextDrawHide(playerid, PlayerText:Mod_Listitem2_[playerid]);
	    PlayerTextDrawHide(playerid, PlayerText:Mod_Listitem3[playerid]);
	    PlayerTextDrawHide(playerid, PlayerText:Mod_Listitem3_[playerid]);
	    PlayerTextDrawShow(playerid, PlayerText:Farbauswahl[playerid][0]);
	    PlayerTextDrawShow(playerid, PlayerText:Farbauswahl[playerid][1]);
	    PlayerTextDrawShow(playerid, PlayerText:Farbauswahl[playerid][2]);
	    PlayerTextDrawShow(playerid, PlayerText:Farbauswahl[playerid][3]);
	    PlayerTextDrawShow(playerid, PlayerText:Farbauswahl[playerid][4]);
	    PlayerTextDrawShow(playerid, PlayerText:Farbauswahl[playerid][5]);
	    PlayerTextDrawShow(playerid, PlayerText:Farbauswahl[playerid][6]);
	    PlayerTextDrawShow(playerid, PlayerText:Farbauswahl[playerid][7]);
	    PlayerTextDrawShow(playerid, PlayerText:Farbauswahl[playerid][8]);
	    PlayerTextDrawShow(playerid, PlayerText:Farbauswahl[playerid][9]);
	    PlayerTextDrawShow(playerid, PlayerText:Farbauswahl[playerid][10]);
	    PlayerTextDrawShow(playerid, PlayerText:Farbauswahl[playerid][11]);
	    PlayerTextDrawShow(playerid, PlayerText:Farbauswahl[playerid][12]);
	    PlayerTextDrawShow(playerid, PlayerText:Farbauswahl[playerid][13]);
	    PlayerTextDrawShow(playerid, PlayerText:Farbauswahl[playerid][14]);
	    PlayerTextDrawShow(playerid, PlayerText:Farbauswahl[playerid][15]);
	    PlayerTextDrawShow(playerid, PlayerText:Farbauswahl[playerid][16]);
	    PlayerTextDrawShow(playerid, PlayerText:Farbauswahl[playerid][17]);
	    PlayerTextDrawShow(playerid, PlayerText:Farbauswahl[playerid][18]);
	    SetPVarInt(playerid, "Tachofarbe", 1);
		SetPVarInt(playerid, "Tachobereich", 2);
	 }
	 if(strcmp(string, "SlSpezial") == 0)
	 {
	    AddModVehicleComponent(GetPVarInt(playerid, "VehicleID"), 1116);
	    SetPVarInt(playerid, "ModShop_Slamvan", 5000);
	 	new Preis = GetPVarInt(playerid, "ModShop_Slamvan");
	 	format(string, sizeof string, "$%i", Preis);
	 	PlayerTextDrawSetString(playerid, PlayerText:ModshopPreis[playerid], string);
	 	PlayerTextDrawShow(playerid, PlayerText:ModshopPreis[playerid]);
	 }
	 if(strcmp(string, "ReSpezial") == 0)
	 {
	    AddModVehicleComponent(GetPVarInt(playerid, "VehicleID"), 1123);
	    SetPVarInt(playerid, "ModShop_Remington", 4000);
	 	new Preis = GetPVarInt(playerid, "ModShop_Remington");
	 	format(string, sizeof string, "$%i", Preis);
	 	PlayerTextDrawSetString(playerid, PlayerText:ModshopPreis[playerid], string);
	 	PlayerTextDrawShow(playerid, PlayerText:ModshopPreis[playerid]);
	 }
	 PlayerPlaySound(playerid, 1083, 0, 0, 0);
  }
  if(playertextid == Mod_Listitem3[playerid])
  {
	 new string[25];
	 GetPVarString(playerid, "Modshop", string, sizeof string);
	 if(strcmp(string, "Nitro") == 0)
	 {
	    AddModVehicleComponent(GetPVarInt(playerid, "VehicleID"), 1010);
	    SetPVarInt(playerid, "ModShop_Nitro", 9500);
	 	new Preis = GetPVarInt(playerid, "ModShop_Nitro");
	 	format(string, sizeof string, "$%i", Preis);
	 	PlayerTextDrawSetString(playerid, PlayerText:ModshopPreis[playerid], string);
	 	PlayerTextDrawShow(playerid, PlayerText:ModshopPreis[playerid]);
	 }
	 if(strcmp(string, "Spoiler") == 0)
	 {
	    AddModVehicleComponent(GetPVarInt(playerid, "VehicleID"), 1002);
	    SetPVarInt(playerid, "ModShop_Spoiler", 9700);
	 	new Preis = GetPVarInt(playerid, "ModShop_Spoiler");
	 	format(string, sizeof string, "$%i", Preis);
	 	PlayerTextDrawSetString(playerid, PlayerText:ModshopPreis[playerid], string);
	 	PlayerTextDrawShow(playerid, PlayerText:ModshopPreis[playerid]);
	 }
	 if(strcmp(string, "Tachofarbe") == 0)
	 {
	    PlayerTextDrawHide(playerid, PlayerText:Mod_Listitem1[playerid]);
	    PlayerTextDrawHide(playerid, PlayerText:Mod_Listitem1_[playerid]);
	    PlayerTextDrawHide(playerid, PlayerText:Mod_Listitem2[playerid]);
	    PlayerTextDrawHide(playerid, PlayerText:Mod_Listitem2_[playerid]);
	    PlayerTextDrawHide(playerid, PlayerText:Mod_Listitem3[playerid]);
	    PlayerTextDrawHide(playerid, PlayerText:Mod_Listitem3_[playerid]);
	    PlayerTextDrawShow(playerid, PlayerText:Farbauswahl[playerid][0]);
	    PlayerTextDrawShow(playerid, PlayerText:Farbauswahl[playerid][1]);
	    PlayerTextDrawShow(playerid, PlayerText:Farbauswahl[playerid][2]);
	    PlayerTextDrawShow(playerid, PlayerText:Farbauswahl[playerid][3]);
	    PlayerTextDrawShow(playerid, PlayerText:Farbauswahl[playerid][4]);
	    PlayerTextDrawShow(playerid, PlayerText:Farbauswahl[playerid][5]);
	    PlayerTextDrawShow(playerid, PlayerText:Farbauswahl[playerid][6]);
	    PlayerTextDrawShow(playerid, PlayerText:Farbauswahl[playerid][7]);
	    PlayerTextDrawShow(playerid, PlayerText:Farbauswahl[playerid][8]);
	    PlayerTextDrawShow(playerid, PlayerText:Farbauswahl[playerid][9]);
	    PlayerTextDrawShow(playerid, PlayerText:Farbauswahl[playerid][10]);
	    PlayerTextDrawShow(playerid, PlayerText:Farbauswahl[playerid][11]);
	    PlayerTextDrawShow(playerid, PlayerText:Farbauswahl[playerid][12]);
	    PlayerTextDrawShow(playerid, PlayerText:Farbauswahl[playerid][13]);
	    PlayerTextDrawShow(playerid, PlayerText:Farbauswahl[playerid][14]);
	    PlayerTextDrawShow(playerid, PlayerText:Farbauswahl[playerid][15]);
	    PlayerTextDrawShow(playerid, PlayerText:Farbauswahl[playerid][16]);
	    PlayerTextDrawShow(playerid, PlayerText:Farbauswahl[playerid][17]);
	    PlayerTextDrawShow(playerid, PlayerText:Farbauswahl[playerid][18]);
	    SetPVarInt(playerid, "Tachofarbe", 1);
		SetPVarInt(playerid, "Tachobereich", 3);
	 }
	 if(strcmp(string, "SlSpezial") == 0)
	 {
	    AddModVehicleComponent(GetPVarInt(playerid, "VehicleID"), 1110);
	    SetPVarInt(playerid, "ModShop_Slamvan", 5500);
	 	new Preis = GetPVarInt(playerid, "ModShop_Slamvan");
	 	format(string, sizeof string, "$%i", Preis);
	 	PlayerTextDrawSetString(playerid, PlayerText:ModshopPreis[playerid], string);
	 	PlayerTextDrawShow(playerid, PlayerText:ModshopPreis[playerid]);
	 }
	 if(strcmp(string, "ReSpezial") == 0)
	 {
	    AddModVehicleComponent(GetPVarInt(playerid, "VehicleID"), 1125);
	    SetPVarInt(playerid, "ModShop_Remington", 6500);
	 	new Preis = GetPVarInt(playerid, "ModShop_Remington");
	 	format(string, sizeof string, "$%i", Preis);
	 	PlayerTextDrawSetString(playerid, PlayerText:ModshopPreis[playerid], string);
	 	PlayerTextDrawShow(playerid, PlayerText:ModshopPreis[playerid]);
	 }
	 PlayerPlaySound(playerid, 1083, 0, 0, 0);
  }
  if(playertextid == ModDone[playerid])
  {
	 PlayerPlaySound(playerid, 1083, 0, 0, 0);
	 PlayerTextDrawSetString(playerid, PlayerText:ModshopPreis[playerid], "");
	 PlayerTextDrawHide(playerid, PlayerText:ModshopPreis[playerid]);
	 new string[25];
	 GetPVarString(playerid, "Modshop", string, sizeof string);
	 if(strcmp(string, "Farben") == 0)
	 {
	   if(GetPVarInt(playerid, "Farben") == 1)
	   {
          PlayerTextDrawHide(playerid, PlayerText:TuningLeave[playerid]);
          PlayerTextDrawHide(playerid, PlayerText:TuningLeave_[playerid]);
	      SetPVarInt(playerid, "Farben", 2);
	      PlayerTextDrawSetString(playerid, PlayerText:ModDone_[playerid], "Done");
	      return 1;
	   }
	   if(GetPVarInt(playerid, "Farben") == 2)
	   {
	      PlayerTextDrawHide(playerid, PlayerText:Farbauswahl[playerid][0]);
	      PlayerTextDrawHide(playerid, PlayerText:Farbauswahl[playerid][1]);
	      PlayerTextDrawHide(playerid, PlayerText:Farbauswahl[playerid][2]);
	      PlayerTextDrawHide(playerid, PlayerText:Farbauswahl[playerid][3]);
	      PlayerTextDrawHide(playerid, PlayerText:Farbauswahl[playerid][4]);
	      PlayerTextDrawHide(playerid, PlayerText:Farbauswahl[playerid][5]);
	      PlayerTextDrawHide(playerid, PlayerText:Farbauswahl[playerid][6]);
	      PlayerTextDrawHide(playerid, PlayerText:Farbauswahl[playerid][7]);
	      PlayerTextDrawHide(playerid, PlayerText:Farbauswahl[playerid][8]);
	      PlayerTextDrawHide(playerid, PlayerText:Farbauswahl[playerid][9]);
	      PlayerTextDrawHide(playerid, PlayerText:Farbauswahl[playerid][10]);
	      PlayerTextDrawHide(playerid, PlayerText:Farbauswahl[playerid][11]);
	      PlayerTextDrawHide(playerid, PlayerText:Farbauswahl[playerid][12]);
	      PlayerTextDrawHide(playerid, PlayerText:Farbauswahl[playerid][13]);
	      PlayerTextDrawHide(playerid, PlayerText:Farbauswahl[playerid][14]);
	      PlayerTextDrawHide(playerid, PlayerText:Farbauswahl[playerid][15]);
	      PlayerTextDrawHide(playerid, PlayerText:Farbauswahl[playerid][15]);
	      PlayerTextDrawHide(playerid, PlayerText:Farbauswahl[playerid][16]);
	      PlayerTextDrawHide(playerid, PlayerText:Farbauswahl[playerid][17]);
	      PlayerTextDrawHide(playerid, PlayerText:Farbauswahl[playerid][18]);
	      PlayerTextDrawHide(playerid, PlayerText:Farbauswahl[playerid][19]);
          PlayerTextDrawHide(playerid, PlayerText:TuningObjectBackground[playerid]);
          PlayerTextDrawHide(playerid, PlayerText:ModDone[playerid]);
          PlayerTextDrawHide(playerid, PlayerText:ModDone_[playerid]);
          PlayerTextDrawShow(playerid, PlayerText:LastModshopItem[playerid]);
          PlayerTextDrawShow(playerid, PlayerText:NextModshopItem[playerid]);
          PlayerTextDrawSetSelectable(playerid, PlayerText:ModName[playerid], 1);
          PlayerTextDrawShow(playerid, PlayerText:ModName[playerid]);
	      KillTimer(Rainbowmodshopcolortimer);
	      DeletePVar(playerid, "Farben");
          PlayerTextDrawShow(playerid, PlayerText:TuningLeave[playerid]);
          PlayerTextDrawShow(playerid, PlayerText:TuningLeave_[playerid]);
	      return 1;
	   }
	 }
	 if(strcmp(string, "Lackierung") == 0)
	 {
          PlayerTextDrawHide(playerid, PlayerText:Mod_Listitem1[playerid]);
          PlayerTextDrawHide(playerid, PlayerText:Mod_Listitem1_[playerid]);
          PlayerTextDrawHide(playerid, PlayerText:Mod_Listitem2[playerid]);
          PlayerTextDrawHide(playerid, PlayerText:Mod_Listitem2_[playerid]);
          PlayerTextDrawHide(playerid, PlayerText:Mod_Listitem3[playerid]);
          PlayerTextDrawHide(playerid, PlayerText:Mod_Listitem3_[playerid]);
          PlayerTextDrawHide(playerid, PlayerText:TuningObjectBackground[playerid]);
          PlayerTextDrawHide(playerid, PlayerText:ModDone[playerid]);
          PlayerTextDrawHide(playerid, PlayerText:ModDone_[playerid]);
          PlayerTextDrawShow(playerid, PlayerText:LastModshopItem[playerid]);
          PlayerTextDrawShow(playerid, PlayerText:NextModshopItem[playerid]);
          PlayerTextDrawSetSelectable(playerid, PlayerText:ModName[playerid], 1);
          PlayerTextDrawShow(playerid, PlayerText:ModName[playerid]);
	      KillTimer(Rainbowmodshopcolortimer);
	      DeletePVar(playerid, "Farben");
          PlayerTextDrawShow(playerid, PlayerText:TuningLeave[playerid]);
          PlayerTextDrawShow(playerid, PlayerText:TuningLeave_[playerid]);
	      return 1;
	 }
	 if(strcmp(string, "Rader") == 0)
	 {
	      PlayerTextDrawHide(playerid, PlayerText:Farbauswahl[playerid][0]);
	      PlayerTextDrawHide(playerid, PlayerText:Farbauswahl[playerid][1]);
	      PlayerTextDrawHide(playerid, PlayerText:Farbauswahl[playerid][2]);
	      PlayerTextDrawHide(playerid, PlayerText:Farbauswahl[playerid][3]);
	      PlayerTextDrawHide(playerid, PlayerText:Farbauswahl[playerid][4]);
	      PlayerTextDrawHide(playerid, PlayerText:Farbauswahl[playerid][5]);
	      PlayerTextDrawHide(playerid, PlayerText:Farbauswahl[playerid][6]);
	      PlayerTextDrawHide(playerid, PlayerText:Farbauswahl[playerid][7]);
	      PlayerTextDrawHide(playerid, PlayerText:Farbauswahl[playerid][8]);
	      PlayerTextDrawHide(playerid, PlayerText:Farbauswahl[playerid][9]);
	      PlayerTextDrawHide(playerid, PlayerText:Farbauswahl[playerid][10]);
	      PlayerTextDrawHide(playerid, PlayerText:Farbauswahl[playerid][11]);
	      PlayerTextDrawHide(playerid, PlayerText:Farbauswahl[playerid][12]);
	      PlayerTextDrawHide(playerid, PlayerText:Farbauswahl[playerid][13]);
	      PlayerTextDrawHide(playerid, PlayerText:Farbauswahl[playerid][14]);
	      PlayerTextDrawHide(playerid, PlayerText:Farbauswahl[playerid][15]);
	      PlayerTextDrawHide(playerid, PlayerText:Farbauswahl[playerid][15]);
	      PlayerTextDrawHide(playerid, PlayerText:Farbauswahl[playerid][16]);
          PlayerTextDrawHide(playerid, PlayerText:TuningObjectBackground[playerid]);
          PlayerTextDrawHide(playerid, PlayerText:ModDone[playerid]);
          PlayerTextDrawHide(playerid, PlayerText:ModDone_[playerid]);
          PlayerTextDrawShow(playerid, PlayerText:LastModshopItem[playerid]);
          PlayerTextDrawShow(playerid, PlayerText:NextModshopItem[playerid]);
          PlayerTextDrawSetSelectable(playerid, PlayerText:ModName[playerid], 1);
          PlayerTextDrawShow(playerid, PlayerText:ModName[playerid]);
	      PlayerTextDrawSetString(playerid, PlayerText:Farbauswahl[playerid][0],"LD_SPAC:white");
	      PlayerTextDrawColor(playerid, Farbauswahl[playerid][0], -1);
	      PlayerTextDrawFont(playerid, Farbauswahl[playerid][0], 4);
	      PlayerTextDrawSetString(playerid, PlayerText:Farbauswahl[playerid][1],"LD_SPAC:white");
	      PlayerTextDrawColor(playerid, Farbauswahl[playerid][1], 225);
	      PlayerTextDrawFont(playerid, Farbauswahl[playerid][1], 4);
	      PlayerTextDrawSetString(playerid, PlayerText:Farbauswahl[playerid][2],"LD_SPAC:white");
	      PlayerTextDrawColor(playerid, Farbauswahl[playerid][2], Hellrot);
	      PlayerTextDrawFont(playerid, Farbauswahl[playerid][2], 4);
	      PlayerTextDrawSetString(playerid, PlayerText:Farbauswahl[playerid][3],"LD_SPAC:white");
	      PlayerTextDrawColor(playerid, Farbauswahl[playerid][3], Hellblau);
	      PlayerTextDrawFont(playerid, Farbauswahl[playerid][3], 4);
	      PlayerTextDrawSetString(playerid, PlayerText:Farbauswahl[playerid][4],"LD_SPAC:white");
	      PlayerTextDrawColor(playerid, Farbauswahl[playerid][4], Hellgrün);
	      PlayerTextDrawFont(playerid, Farbauswahl[playerid][4], 4);
	      PlayerTextDrawSetString(playerid, PlayerText:Farbauswahl[playerid][5],"LD_SPAC:white");
	      PlayerTextDrawColor(playerid, Farbauswahl[playerid][5], 0xFFFF00FF);
	      PlayerTextDrawFont(playerid, Farbauswahl[playerid][5], 4);
	      PlayerTextDrawSetString(playerid, PlayerText:Farbauswahl[playerid][6],"LD_SPAC:white");
	      PlayerTextDrawColor(playerid, Farbauswahl[playerid][6], 0x808080FF);
	      PlayerTextDrawFont(playerid, Farbauswahl[playerid][6], 4);
	      PlayerTextDrawSetString(playerid, PlayerText:Farbauswahl[playerid][7],"LD_SPAC:white");
	      PlayerTextDrawColor(playerid, Farbauswahl[playerid][7], 0x00FFFFFF);
	      PlayerTextDrawFont(playerid, Farbauswahl[playerid][7], 4);
	      PlayerTextDrawSetString(playerid, PlayerText:Farbauswahl[playerid][8],"LD_SPAC:white");
	      PlayerTextDrawColor(playerid, Farbauswahl[playerid][8], 0xC0C0C0FF);
	      PlayerTextDrawFont(playerid, Farbauswahl[playerid][8], 4);
	      PlayerTextDrawSetString(playerid, PlayerText:Farbauswahl[playerid][9],"LD_SPAC:white");
	      PlayerTextDrawColor(playerid, Farbauswahl[playerid][9], 0xFFA500FF);
	      PlayerTextDrawFont(playerid, Farbauswahl[playerid][9], 4);
	      PlayerTextDrawSetString(playerid, PlayerText:Farbauswahl[playerid][10],"LD_SPAC:white");
	      PlayerTextDrawColor(playerid, Farbauswahl[playerid][10], 0x800000FF);
	      PlayerTextDrawFont(playerid, Farbauswahl[playerid][10], 4);
	      PlayerTextDrawSetString(playerid, PlayerText:Farbauswahl[playerid][11],"LD_SPAC:white");
	      PlayerTextDrawColor(playerid, Farbauswahl[playerid][11], 0xE8FFABFF);
	      PlayerTextDrawFont(playerid, Farbauswahl[playerid][11], 4);
	      PlayerTextDrawSetString(playerid, PlayerText:Farbauswahl[playerid][12],"LD_SPAC:white");
	      PlayerTextDrawColor(playerid, Farbauswahl[playerid][12], 0x800080FF);
	      PlayerTextDrawFont(playerid, Farbauswahl[playerid][12], 4);
	      PlayerTextDrawSetString(playerid, PlayerText:Farbauswahl[playerid][13],"LD_SPAC:white");
	      PlayerTextDrawColor(playerid, Farbauswahl[playerid][13], 0x00A400FF);
	      PlayerTextDrawFont(playerid, Farbauswahl[playerid][13], 4);
	      PlayerTextDrawSetString(playerid, PlayerText:Farbauswahl[playerid][14],"LD_SPAC:white");
	      PlayerTextDrawColor(playerid, Farbauswahl[playerid][14], 0xD1D8B9FF);
	      PlayerTextDrawFont(playerid, Farbauswahl[playerid][14], 4);
	      PlayerTextDrawSetString(playerid, PlayerText:Farbauswahl[playerid][15],"LD_SPAC:white");
	      PlayerTextDrawColor(playerid, Farbauswahl[playerid][15], 0xFF98CCFF);
	      PlayerTextDrawFont(playerid, Farbauswahl[playerid][15], 4);
	      PlayerTextDrawSetString(playerid, PlayerText:Farbauswahl[playerid][16],"LD_SPAC:white");
	      PlayerTextDrawColor(playerid, Farbauswahl[playerid][16], 0xFF6FB7FF);
	      PlayerTextDrawFont(playerid, Farbauswahl[playerid][16], 4);
	      PlayerTextDrawSetString(playerid, PlayerText:Farbauswahl[playerid][17],"LD_SPAC:white");
	      PlayerTextDrawColor(playerid, Farbauswahl[playerid][17], 0x000063FF);
	      PlayerTextDrawFont(playerid, Farbauswahl[playerid][17], 4);
          PlayerTextDrawShow(playerid, PlayerText:TuningLeave[playerid]);
          PlayerTextDrawShow(playerid, PlayerText:TuningLeave_[playerid]);
	      return 1;
	 }
	 if(strcmp(string, "Fahrwerk") == 0)
	 {
          PlayerTextDrawHide(playerid, PlayerText:Mod_Listitem1[playerid]);
          PlayerTextDrawHide(playerid, PlayerText:Mod_Listitem1_[playerid]);
          PlayerTextDrawHide(playerid, PlayerText:TuningObjectBackground[playerid]);
          PlayerTextDrawHide(playerid, PlayerText:ModDone[playerid]);
          PlayerTextDrawHide(playerid, PlayerText:ModDone_[playerid]);
          PlayerTextDrawShow(playerid, PlayerText:LastModshopItem[playerid]);
          PlayerTextDrawShow(playerid, PlayerText:NextModshopItem[playerid]);
          PlayerTextDrawSetSelectable(playerid, PlayerText:ModName[playerid], 1);
          PlayerTextDrawShow(playerid, PlayerText:ModName[playerid]);
          PlayerTextDrawShow(playerid, PlayerText:TuningLeave[playerid]);
          PlayerTextDrawShow(playerid, PlayerText:TuningLeave_[playerid]);
	      return 1;
	 }
	 if(strcmp(string, "Nitro") == 0)
	 {
          PlayerTextDrawHide(playerid, PlayerText:Mod_Listitem1[playerid]);
          PlayerTextDrawHide(playerid, PlayerText:Mod_Listitem1_[playerid]);
          PlayerTextDrawHide(playerid, PlayerText:Mod_Listitem2[playerid]);
          PlayerTextDrawHide(playerid, PlayerText:Mod_Listitem2_[playerid]);
          PlayerTextDrawHide(playerid, PlayerText:Mod_Listitem3[playerid]);
          PlayerTextDrawHide(playerid, PlayerText:Mod_Listitem3_[playerid]);
          PlayerTextDrawHide(playerid, PlayerText:TuningObjectBackground[playerid]);
          PlayerTextDrawHide(playerid, PlayerText:ModDone[playerid]);
          PlayerTextDrawHide(playerid, PlayerText:ModDone_[playerid]);
          PlayerTextDrawShow(playerid, PlayerText:LastModshopItem[playerid]);
          PlayerTextDrawShow(playerid, PlayerText:NextModshopItem[playerid]);
          PlayerTextDrawSetSelectable(playerid, PlayerText:ModName[playerid], 1);
          PlayerTextDrawShow(playerid, PlayerText:ModName[playerid]);
          PlayerTextDrawShow(playerid, PlayerText:TuningLeave[playerid]);
          PlayerTextDrawShow(playerid, PlayerText:TuningLeave_[playerid]);
	      return 1;
	 }
	 if(strcmp(string, "BumperVorn") == 0)
	 {
          PlayerTextDrawHide(playerid, PlayerText:Mod_Listitem1[playerid]);
          PlayerTextDrawHide(playerid, PlayerText:Mod_Listitem1_[playerid]);
          PlayerTextDrawHide(playerid, PlayerText:Mod_Listitem2[playerid]);
          PlayerTextDrawHide(playerid, PlayerText:Mod_Listitem2_[playerid]);
          PlayerTextDrawHide(playerid, PlayerText:Mod_Listitem3[playerid]);
          PlayerTextDrawHide(playerid, PlayerText:Mod_Listitem3_[playerid]);
          PlayerTextDrawHide(playerid, PlayerText:TuningObjectBackground[playerid]);
          PlayerTextDrawHide(playerid, PlayerText:ModDone[playerid]);
          PlayerTextDrawHide(playerid, PlayerText:ModDone_[playerid]);
          PlayerTextDrawShow(playerid, PlayerText:LastModshopItem[playerid]);
          PlayerTextDrawShow(playerid, PlayerText:NextModshopItem[playerid]);
          PlayerTextDrawSetSelectable(playerid, PlayerText:ModName[playerid], 1);
          PlayerTextDrawShow(playerid, PlayerText:ModName[playerid]);
          PlayerTextDrawShow(playerid, PlayerText:TuningLeave[playerid]);
          PlayerTextDrawShow(playerid, PlayerText:TuningLeave_[playerid]);
	      return 1;
	 }
	 if(strcmp(string, "BumperHinten") == 0)
	 {
          PlayerTextDrawHide(playerid, PlayerText:Mod_Listitem1[playerid]);
          PlayerTextDrawHide(playerid, PlayerText:Mod_Listitem1_[playerid]);
          PlayerTextDrawHide(playerid, PlayerText:Mod_Listitem2[playerid]);
          PlayerTextDrawHide(playerid, PlayerText:Mod_Listitem2_[playerid]);
          PlayerTextDrawHide(playerid, PlayerText:Mod_Listitem3[playerid]);
          PlayerTextDrawHide(playerid, PlayerText:Mod_Listitem3_[playerid]);
          PlayerTextDrawHide(playerid, PlayerText:TuningObjectBackground[playerid]);
          PlayerTextDrawHide(playerid, PlayerText:ModDone[playerid]);
          PlayerTextDrawHide(playerid, PlayerText:ModDone_[playerid]);
          PlayerTextDrawShow(playerid, PlayerText:LastModshopItem[playerid]);
          PlayerTextDrawShow(playerid, PlayerText:NextModshopItem[playerid]);
          PlayerTextDrawSetSelectable(playerid, PlayerText:ModName[playerid], 1);
          PlayerTextDrawShow(playerid, PlayerText:ModName[playerid]);
          PlayerTextDrawShow(playerid, PlayerText:TuningLeave[playerid]);
          PlayerTextDrawShow(playerid, PlayerText:TuningLeave_[playerid]);
	      return 1;
	 }
	 if(strcmp(string, "Spoiler") == 0)
	 {
          PlayerTextDrawHide(playerid, PlayerText:Mod_Listitem1[playerid]);
          PlayerTextDrawHide(playerid, PlayerText:Mod_Listitem1_[playerid]);
          PlayerTextDrawHide(playerid, PlayerText:Mod_Listitem2[playerid]);
          PlayerTextDrawHide(playerid, PlayerText:Mod_Listitem2_[playerid]);
          PlayerTextDrawHide(playerid, PlayerText:Mod_Listitem3[playerid]);
          PlayerTextDrawHide(playerid, PlayerText:Mod_Listitem3_[playerid]);
          PlayerTextDrawHide(playerid, PlayerText:TuningObjectBackground[playerid]);
          PlayerTextDrawHide(playerid, PlayerText:ModDone[playerid]);
          PlayerTextDrawHide(playerid, PlayerText:ModDone_[playerid]);
          PlayerTextDrawShow(playerid, PlayerText:LastModshopItem[playerid]);
          PlayerTextDrawShow(playerid, PlayerText:NextModshopItem[playerid]);
          PlayerTextDrawSetSelectable(playerid, PlayerText:ModName[playerid], 1);
          PlayerTextDrawShow(playerid, PlayerText:ModName[playerid]);
          PlayerTextDrawShow(playerid, PlayerText:TuningLeave[playerid]);
          PlayerTextDrawShow(playerid, PlayerText:TuningLeave_[playerid]);
	      return 1;
	 }
	 if(strcmp(string, "Auspuff") == 0)
	 {
          PlayerTextDrawHide(playerid, PlayerText:Mod_Listitem1[playerid]);
          PlayerTextDrawHide(playerid, PlayerText:Mod_Listitem1_[playerid]);
          PlayerTextDrawHide(playerid, PlayerText:Mod_Listitem2[playerid]);
          PlayerTextDrawHide(playerid, PlayerText:Mod_Listitem2_[playerid]);
          PlayerTextDrawHide(playerid, PlayerText:Mod_Listitem3[playerid]);
          PlayerTextDrawHide(playerid, PlayerText:Mod_Listitem3_[playerid]);
          PlayerTextDrawHide(playerid, PlayerText:TuningObjectBackground[playerid]);
          PlayerTextDrawHide(playerid, PlayerText:ModDone[playerid]);
          PlayerTextDrawHide(playerid, PlayerText:ModDone_[playerid]);
          PlayerTextDrawShow(playerid, PlayerText:LastModshopItem[playerid]);
          PlayerTextDrawShow(playerid, PlayerText:NextModshopItem[playerid]);
          PlayerTextDrawSetSelectable(playerid, PlayerText:ModName[playerid], 1);
          PlayerTextDrawShow(playerid, PlayerText:ModName[playerid]);
          PlayerTextDrawShow(playerid, PlayerText:TuningLeave[playerid]);
          PlayerTextDrawShow(playerid, PlayerText:TuningLeave_[playerid]);
	      return 1;
	 }
	 if(strcmp(string, "Motorhaube") == 0)
	 {
          PlayerTextDrawHide(playerid, PlayerText:Mod_Listitem1[playerid]);
          PlayerTextDrawHide(playerid, PlayerText:Mod_Listitem1_[playerid]);
          PlayerTextDrawHide(playerid, PlayerText:Mod_Listitem2[playerid]);
          PlayerTextDrawHide(playerid, PlayerText:Mod_Listitem2_[playerid]);
          PlayerTextDrawHide(playerid, PlayerText:Mod_Listitem3[playerid]);
          PlayerTextDrawHide(playerid, PlayerText:Mod_Listitem3_[playerid]);
          PlayerTextDrawHide(playerid, PlayerText:TuningObjectBackground[playerid]);
          PlayerTextDrawHide(playerid, PlayerText:ModDone[playerid]);
          PlayerTextDrawHide(playerid, PlayerText:ModDone_[playerid]);
          PlayerTextDrawShow(playerid, PlayerText:LastModshopItem[playerid]);
          PlayerTextDrawShow(playerid, PlayerText:NextModshopItem[playerid]);
          PlayerTextDrawSetSelectable(playerid, PlayerText:ModName[playerid], 1);
          PlayerTextDrawShow(playerid, PlayerText:ModName[playerid]);
          PlayerTextDrawShow(playerid, PlayerText:TuningLeave[playerid]);
          PlayerTextDrawShow(playerid, PlayerText:TuningLeave_[playerid]);
	      return 1;
	 }
	 if(strcmp(string, "Dach") == 0)
	 {
          PlayerTextDrawHide(playerid, PlayerText:Mod_Listitem1[playerid]);
          PlayerTextDrawHide(playerid, PlayerText:Mod_Listitem1_[playerid]);
          PlayerTextDrawHide(playerid, PlayerText:Mod_Listitem2[playerid]);
          PlayerTextDrawHide(playerid, PlayerText:Mod_Listitem2_[playerid]);
          PlayerTextDrawHide(playerid, PlayerText:Mod_Listitem3[playerid]);
          PlayerTextDrawHide(playerid, PlayerText:Mod_Listitem3_[playerid]);
          PlayerTextDrawHide(playerid, PlayerText:TuningObjectBackground[playerid]);
          PlayerTextDrawHide(playerid, PlayerText:ModDone[playerid]);
          PlayerTextDrawHide(playerid, PlayerText:ModDone_[playerid]);
          PlayerTextDrawShow(playerid, PlayerText:LastModshopItem[playerid]);
          PlayerTextDrawShow(playerid, PlayerText:NextModshopItem[playerid]);
          PlayerTextDrawSetSelectable(playerid, PlayerText:ModName[playerid], 1);
          PlayerTextDrawShow(playerid, PlayerText:ModName[playerid]);
          PlayerTextDrawShow(playerid, PlayerText:TuningLeave[playerid]);
          PlayerTextDrawShow(playerid, PlayerText:TuningLeave_[playerid]);
	      KillTimer(Rainbowmodshopcolortimer);
	      return 1;
	 }
	 if(strcmp(string, "Nebelleuchten") == 0)
	 {
          PlayerTextDrawHide(playerid, PlayerText:Mod_Listitem1[playerid]);
          PlayerTextDrawHide(playerid, PlayerText:Mod_Listitem1_[playerid]);
          PlayerTextDrawHide(playerid, PlayerText:Mod_Listitem2[playerid]);
          PlayerTextDrawHide(playerid, PlayerText:Mod_Listitem2_[playerid]);
          PlayerTextDrawHide(playerid, PlayerText:Mod_Listitem3[playerid]);
          PlayerTextDrawHide(playerid, PlayerText:Mod_Listitem3_[playerid]);
          PlayerTextDrawHide(playerid, PlayerText:TuningObjectBackground[playerid]);
          PlayerTextDrawHide(playerid, PlayerText:ModDone[playerid]);
          PlayerTextDrawHide(playerid, PlayerText:ModDone_[playerid]);
          PlayerTextDrawShow(playerid, PlayerText:LastModshopItem[playerid]);
          PlayerTextDrawShow(playerid, PlayerText:NextModshopItem[playerid]);
          PlayerTextDrawSetSelectable(playerid, PlayerText:ModName[playerid], 1);
          PlayerTextDrawShow(playerid, PlayerText:ModName[playerid]);
	      KillTimer(Rainbowmodshopcolortimer);
          PlayerTextDrawShow(playerid, PlayerText:TuningLeave[playerid]);
          PlayerTextDrawShow(playerid, PlayerText:TuningLeave_[playerid]);
	      return 1;
	 }
	 if(strcmp(string, "Schweller") == 0)
	 {
          PlayerTextDrawHide(playerid, PlayerText:Mod_Listitem1[playerid]);
          PlayerTextDrawHide(playerid, PlayerText:Mod_Listitem1_[playerid]);
          PlayerTextDrawHide(playerid, PlayerText:Mod_Listitem2[playerid]);
          PlayerTextDrawHide(playerid, PlayerText:Mod_Listitem2_[playerid]);
          PlayerTextDrawHide(playerid, PlayerText:Mod_Listitem3[playerid]);
          PlayerTextDrawHide(playerid, PlayerText:Mod_Listitem3_[playerid]);
          PlayerTextDrawHide(playerid, PlayerText:TuningObjectBackground[playerid]);
          PlayerTextDrawHide(playerid, PlayerText:ModDone[playerid]);
          PlayerTextDrawHide(playerid, PlayerText:ModDone_[playerid]);
          PlayerTextDrawShow(playerid, PlayerText:LastModshopItem[playerid]);
          PlayerTextDrawShow(playerid, PlayerText:NextModshopItem[playerid]);
          PlayerTextDrawSetSelectable(playerid, PlayerText:ModName[playerid], 1);
          PlayerTextDrawShow(playerid, PlayerText:ModName[playerid]);
	      KillTimer(Rainbowmodshopcolortimer);
          PlayerTextDrawShow(playerid, PlayerText:TuningLeave[playerid]);
          PlayerTextDrawShow(playerid, PlayerText:TuningLeave_[playerid]);
	      return 1;
	 }
	 if(strcmp(string, "ReSpezial") == 0)
	 {
          PlayerTextDrawHide(playerid, PlayerText:Mod_Listitem1[playerid]);
          PlayerTextDrawHide(playerid, PlayerText:Mod_Listitem1_[playerid]);
          PlayerTextDrawHide(playerid, PlayerText:Mod_Listitem2[playerid]);
          PlayerTextDrawHide(playerid, PlayerText:Mod_Listitem2_[playerid]);
          PlayerTextDrawHide(playerid, PlayerText:Mod_Listitem3[playerid]);
          PlayerTextDrawHide(playerid, PlayerText:Mod_Listitem3_[playerid]);
          PlayerTextDrawHide(playerid, PlayerText:TuningObjectBackground[playerid]);
          PlayerTextDrawHide(playerid, PlayerText:ModDone[playerid]);
          PlayerTextDrawHide(playerid, PlayerText:ModDone_[playerid]);
          PlayerTextDrawShow(playerid, PlayerText:LastModshopItem[playerid]);
          PlayerTextDrawShow(playerid, PlayerText:NextModshopItem[playerid]);
          PlayerTextDrawSetSelectable(playerid, PlayerText:ModName[playerid], 1);
          PlayerTextDrawShow(playerid, PlayerText:ModName[playerid]);
          PlayerTextDrawShow(playerid, PlayerText:TuningLeave[playerid]);
          PlayerTextDrawShow(playerid, PlayerText:TuningLeave_[playerid]);
	      return 1;
	 }
	 if(strcmp(string, "SlSpezial") == 0)
	 {
          PlayerTextDrawHide(playerid, PlayerText:Mod_Listitem1[playerid]);
          PlayerTextDrawHide(playerid, PlayerText:Mod_Listitem1_[playerid]);
          PlayerTextDrawHide(playerid, PlayerText:Mod_Listitem2[playerid]);
          PlayerTextDrawHide(playerid, PlayerText:Mod_Listitem2_[playerid]);
          PlayerTextDrawHide(playerid, PlayerText:Mod_Listitem3[playerid]);
          PlayerTextDrawHide(playerid, PlayerText:Mod_Listitem3_[playerid]);
          PlayerTextDrawHide(playerid, PlayerText:TuningObjectBackground[playerid]);
          PlayerTextDrawHide(playerid, PlayerText:ModDone[playerid]);
          PlayerTextDrawHide(playerid, PlayerText:ModDone_[playerid]);
          PlayerTextDrawShow(playerid, PlayerText:LastModshopItem[playerid]);
          PlayerTextDrawShow(playerid, PlayerText:NextModshopItem[playerid]);
          PlayerTextDrawSetSelectable(playerid, PlayerText:ModName[playerid], 1);
          PlayerTextDrawShow(playerid, PlayerText:ModName[playerid]);
	      KillTimer(Rainbowmodshopcolortimer);
          PlayerTextDrawShow(playerid, PlayerText:TuningLeave[playerid]);
          PlayerTextDrawShow(playerid, PlayerText:TuningLeave_[playerid]);
	      return 1;
	 }
	 if(strcmp(string, "Tachofarbe") == 0)
	 {
	   if(GetPVarInt(playerid, "Tachofarbe") == 1)
	   {
	      PlayerTextDrawHide(playerid, PlayerText:Farbauswahl[playerid][0]);
	      PlayerTextDrawHide(playerid, PlayerText:Farbauswahl[playerid][1]);
	      PlayerTextDrawHide(playerid, PlayerText:Farbauswahl[playerid][2]);
	      PlayerTextDrawHide(playerid, PlayerText:Farbauswahl[playerid][3]);
	      PlayerTextDrawHide(playerid, PlayerText:Farbauswahl[playerid][4]);
	      PlayerTextDrawHide(playerid, PlayerText:Farbauswahl[playerid][5]);
	      PlayerTextDrawHide(playerid, PlayerText:Farbauswahl[playerid][6]);
	      PlayerTextDrawHide(playerid, PlayerText:Farbauswahl[playerid][7]);
	      PlayerTextDrawHide(playerid, PlayerText:Farbauswahl[playerid][8]);
	      PlayerTextDrawHide(playerid, PlayerText:Farbauswahl[playerid][9]);
	      PlayerTextDrawHide(playerid, PlayerText:Farbauswahl[playerid][10]);
	      PlayerTextDrawHide(playerid, PlayerText:Farbauswahl[playerid][11]);
	      PlayerTextDrawHide(playerid, PlayerText:Farbauswahl[playerid][12]);
	      PlayerTextDrawHide(playerid, PlayerText:Farbauswahl[playerid][13]);
	      PlayerTextDrawHide(playerid, PlayerText:Farbauswahl[playerid][14]);
	      PlayerTextDrawHide(playerid, PlayerText:Farbauswahl[playerid][15]);
	      PlayerTextDrawHide(playerid, PlayerText:Farbauswahl[playerid][15]);
	      PlayerTextDrawHide(playerid, PlayerText:Farbauswahl[playerid][16]);
	      PlayerTextDrawHide(playerid, PlayerText:Farbauswahl[playerid][17]);
	      PlayerTextDrawHide(playerid, PlayerText:Farbauswahl[playerid][18]);
	      PlayerTextDrawHide(playerid, PlayerText:Farbauswahl[playerid][19]);
	      PlayerTextDrawShow(playerid, Mod_Listitem1[playerid]);
	      PlayerTextDrawShow(playerid, Mod_Listitem1_[playerid]);
	      PlayerTextDrawShow(playerid, Mod_Listitem2[playerid]);
	      PlayerTextDrawShow(playerid, Mod_Listitem2_[playerid]);
	      PlayerTextDrawShow(playerid, Mod_Listitem3[playerid]);
	      PlayerTextDrawShow(playerid, Mod_Listitem3_[playerid]);
          SetPVarInt(playerid, "Tachofarbe", 0);
	      KillTimer(Rainbowmodshopcolortimer);
          PlayerTextDrawHide(playerid, PlayerText:TuningLeave[playerid]);
          PlayerTextDrawHide(playerid, PlayerText:TuningLeave_[playerid]);
	      return 1;
	   }
	   if(GetPVarInt(playerid, "Tachofarbe") == 0)
	   {
		  PlayerTextDrawHide(playerid, PlayerText:TuningObjectBackground[playerid]);
          PlayerTextDrawHide(playerid, PlayerText:ModDone[playerid]);
          PlayerTextDrawHide(playerid, PlayerText:ModDone_[playerid]);
          PlayerTextDrawShow(playerid, PlayerText:LastModshopItem[playerid]);
          PlayerTextDrawShow(playerid, PlayerText:NextModshopItem[playerid]);
          PlayerTextDrawSetSelectable(playerid, PlayerText:ModName[playerid], 1);
          PlayerTextDrawShow(playerid, PlayerText:ModName[playerid]);
	      PlayerTextDrawHide(playerid, Mod_Listitem1[playerid]);
	      PlayerTextDrawHide(playerid, Mod_Listitem1_[playerid]);
	      PlayerTextDrawHide(playerid, Mod_Listitem2[playerid]);
	      PlayerTextDrawHide(playerid, Mod_Listitem2_[playerid]);
	      PlayerTextDrawHide(playerid, Mod_Listitem3[playerid]);
	      PlayerTextDrawHide(playerid, Mod_Listitem3_[playerid]);
          PlayerTextDrawShow(playerid, PlayerText:TuningLeave[playerid]);
          PlayerTextDrawShow(playerid, PlayerText:TuningLeave_[playerid]);
          Speedometer_Hide(playerid);
          PlayerTextDrawSetSelectable(playerid, PlayerText:ModName[playerid], 1);
          PlayerTextDrawShow(playerid, PlayerText:ModName[playerid]);
	      DeletePVar(playerid, "Tachofarbe");
	      DeletePVar(playerid, "Tachobereich");
		  PlayerTextDrawShow(playerid, PlayerText:TuningLeave_[playerid]);
		  PlayerTextDrawShow(playerid, PlayerText:TuningLeave[playerid]);
	      return 1;
	   }
	 }
	 if(strcmp(string, "Objekte") == 0)
	 {
	      PlayerTextDrawHide(playerid, PlayerText:Farbauswahl[playerid][0]);
	      PlayerTextDrawHide(playerid, PlayerText:Farbauswahl[playerid][1]);
	      PlayerTextDrawHide(playerid, PlayerText:Farbauswahl[playerid][2]);
	      PlayerTextDrawHide(playerid, PlayerText:Farbauswahl[playerid][3]);
	      PlayerTextDrawHide(playerid, PlayerText:Farbauswahl[playerid][4]);
	      PlayerTextDrawHide(playerid, PlayerText:Farbauswahl[playerid][5]);
	      PlayerTextDrawHide(playerid, PlayerText:Farbauswahl[playerid][6]);
	      PlayerTextDrawHide(playerid, PlayerText:Farbauswahl[playerid][7]);
	      PlayerTextDrawHide(playerid, PlayerText:Farbauswahl[playerid][8]);
	      PlayerTextDrawHide(playerid, PlayerText:Farbauswahl[playerid][9]);
	      PlayerTextDrawHide(playerid, PlayerText:Farbauswahl[playerid][10]);
	      PlayerTextDrawHide(playerid, PlayerText:Farbauswahl[playerid][11]);
	      PlayerTextDrawHide(playerid, PlayerText:Farbauswahl[playerid][12]);
	      PlayerTextDrawHide(playerid, PlayerText:Farbauswahl[playerid][13]);
	      PlayerTextDrawHide(playerid, PlayerText:Farbauswahl[playerid][14]);
	      PlayerTextDrawHide(playerid, PlayerText:Farbauswahl[playerid][15]);
	      PlayerTextDrawHide(playerid, PlayerText:Farbauswahl[playerid][15]);
	      PlayerTextDrawHide(playerid, PlayerText:Farbauswahl[playerid][16]);
          PlayerTextDrawHide(playerid, PlayerText:TuningObjectBackground[playerid]);
          PlayerTextDrawHide(playerid, PlayerText:ModDone[playerid]);
          TextDrawHideForPlayer(playerid, CustomModShopObjectLeft);
          TextDrawHideForPlayer(playerid, CustomModShopObjectRight);
          PlayerTextDrawHide(playerid, PlayerText:ModDone_[playerid]);
          PlayerTextDrawShow(playerid, PlayerText:LastModshopItem[playerid]);
          PlayerTextDrawShow(playerid, PlayerText:NextModshopItem[playerid]);
          PlayerTextDrawSetSelectable(playerid, PlayerText:ModName[playerid], 1);
          PlayerTextDrawShow(playerid, PlayerText:ModName[playerid]);
	      PlayerTextDrawSetString(playerid, PlayerText:Farbauswahl[playerid][0],"LD_SPAC:white");
	      PlayerTextDrawColor(playerid, Farbauswahl[playerid][0], -1);
	      PlayerTextDrawFont(playerid, Farbauswahl[playerid][0], 4);
	      PlayerTextDrawSetString(playerid, PlayerText:Farbauswahl[playerid][1],"LD_SPAC:white");
	      PlayerTextDrawColor(playerid, Farbauswahl[playerid][1], 225);
	      PlayerTextDrawFont(playerid, Farbauswahl[playerid][1], 4);
	      PlayerTextDrawSetString(playerid, PlayerText:Farbauswahl[playerid][2],"LD_SPAC:white");
	      PlayerTextDrawColor(playerid, Farbauswahl[playerid][2], Hellrot);
	      PlayerTextDrawFont(playerid, Farbauswahl[playerid][2], 4);
	      PlayerTextDrawSetString(playerid, PlayerText:Farbauswahl[playerid][3],"LD_SPAC:white");
	      PlayerTextDrawColor(playerid, Farbauswahl[playerid][3], Hellblau);
	      PlayerTextDrawFont(playerid, Farbauswahl[playerid][3], 4);
	      PlayerTextDrawSetString(playerid, PlayerText:Farbauswahl[playerid][4],"LD_SPAC:white");
	      PlayerTextDrawColor(playerid, Farbauswahl[playerid][4], Hellgrün);
	      PlayerTextDrawFont(playerid, Farbauswahl[playerid][4], 4);
	      PlayerTextDrawSetString(playerid, PlayerText:Farbauswahl[playerid][5],"LD_SPAC:white");
	      PlayerTextDrawColor(playerid, Farbauswahl[playerid][5], 0xFFFF00FF);
	      PlayerTextDrawFont(playerid, Farbauswahl[playerid][5], 4);
	      PlayerTextDrawSetString(playerid, PlayerText:Farbauswahl[playerid][6],"LD_SPAC:white");
	      PlayerTextDrawColor(playerid, Farbauswahl[playerid][6], 0x808080FF);
	      PlayerTextDrawFont(playerid, Farbauswahl[playerid][6], 4);
	      PlayerTextDrawSetString(playerid, PlayerText:Farbauswahl[playerid][7],"LD_SPAC:white");
	      PlayerTextDrawColor(playerid, Farbauswahl[playerid][7], 0x00FFFFFF);
	      PlayerTextDrawFont(playerid, Farbauswahl[playerid][7], 4);
	      PlayerTextDrawSetString(playerid, PlayerText:Farbauswahl[playerid][8],"LD_SPAC:white");
	      PlayerTextDrawColor(playerid, Farbauswahl[playerid][8], 0xC0C0C0FF);
	      PlayerTextDrawFont(playerid, Farbauswahl[playerid][8], 4);
	      PlayerTextDrawSetString(playerid, PlayerText:Farbauswahl[playerid][9],"LD_SPAC:white");
	      PlayerTextDrawColor(playerid, Farbauswahl[playerid][9], 0xFFA500FF);
	      PlayerTextDrawFont(playerid, Farbauswahl[playerid][9], 4);
	      PlayerTextDrawSetString(playerid, PlayerText:Farbauswahl[playerid][10],"LD_SPAC:white");
	      PlayerTextDrawColor(playerid, Farbauswahl[playerid][10], 0x800000FF);
	      PlayerTextDrawFont(playerid, Farbauswahl[playerid][10], 4);
	      PlayerTextDrawSetString(playerid, PlayerText:Farbauswahl[playerid][11],"LD_SPAC:white");
	      PlayerTextDrawColor(playerid, Farbauswahl[playerid][11], 0xE8FFABFF);
	      PlayerTextDrawFont(playerid, Farbauswahl[playerid][11], 4);
	      PlayerTextDrawSetString(playerid, PlayerText:Farbauswahl[playerid][12],"LD_SPAC:white");
	      PlayerTextDrawColor(playerid, Farbauswahl[playerid][12], 0x800080FF);
	      PlayerTextDrawFont(playerid, Farbauswahl[playerid][12], 4);
	      PlayerTextDrawSetString(playerid, PlayerText:Farbauswahl[playerid][13],"LD_SPAC:white");
	      PlayerTextDrawColor(playerid, Farbauswahl[playerid][13], 0x00A400FF);
	      PlayerTextDrawFont(playerid, Farbauswahl[playerid][13], 4);
	      PlayerTextDrawSetString(playerid, PlayerText:Farbauswahl[playerid][14],"LD_SPAC:white");
	      PlayerTextDrawColor(playerid, Farbauswahl[playerid][14], 0xD1D8B9FF);
	      PlayerTextDrawFont(playerid, Farbauswahl[playerid][14], 4);
	      PlayerTextDrawSetString(playerid, PlayerText:Farbauswahl[playerid][15],"LD_SPAC:white");
	      PlayerTextDrawColor(playerid, Farbauswahl[playerid][15], 0xFF98CCFF);
	      PlayerTextDrawFont(playerid, Farbauswahl[playerid][15], 4);
	      PlayerTextDrawSetString(playerid, PlayerText:Farbauswahl[playerid][16],"LD_SPAC:white");
	      PlayerTextDrawColor(playerid, Farbauswahl[playerid][16], 0xFF6FB7FF);
	      PlayerTextDrawFont(playerid, Farbauswahl[playerid][16], 4);
	      PlayerTextDrawSetString(playerid, PlayerText:Farbauswahl[playerid][17],"LD_SPAC:white");
	      PlayerTextDrawColor(playerid, Farbauswahl[playerid][17], 0x000063FF);
	      PlayerTextDrawFont(playerid, Farbauswahl[playerid][17], 4);
          //InterpolateCameraPos(playerid, 606.746948+modshoppos, -7.408711+modshoppos, 1003.267333, 606.746948+modshoppos, -7.408711+modshoppos, 1003.267333, 100);
          //InterpolateCameraLookAt(playerid, 611.242797+modshoppos, -9.439126+modshoppos, 1002.452026, 611.242797+modshoppos, -9.439126+modshoppos, 1002.452026, 100);
          //toggleplayerspectating wird ausgeschalten
	      return 1;
	 }
     PlayerTextDrawShow(playerid, PlayerText:TuningLeave[playerid]);
     PlayerTextDrawShow(playerid, PlayerText:TuningLeave_[playerid]);
     return 1;
  }
  //Farben
  new X, Y;
  new vehicleid = GetPVarInt(playerid, "VehicleID");
  GetVehicleColor(vehicleid, X, Y);
  new string[25];
  new Preis;
  GetPVarString(playerid, "Modshop", string, sizeof string);

 if(strcmp(string, "Objekte") == 0)
 {
	if(playertextid == Farbauswahl[playerid][0])
	{
		   AddObjectToModCar(ModObjekt_0, playerid, vehicleid);
	       return 1;
  	}
	if(playertextid == Farbauswahl[playerid][1])
	{
		   AddObjectToModCar(ModObjekt_1, playerid, vehicleid);
	       return 1;
  	}
	if(playertextid == Farbauswahl[playerid][2])
	{
		   AddObjectToModCar(ModObjekt_2, playerid, vehicleid);
	       return 1;
  	}
	if(playertextid == Farbauswahl[playerid][3])
	{
		   AddObjectToModCar(ModObjekt_3, playerid, vehicleid);
	       return 1;
  	}
	if(playertextid == Farbauswahl[playerid][4])
	{
		   AddObjectToModCar(ModObjekt_4, playerid, vehicleid);
	       return 1;
  	}
	if(playertextid == Farbauswahl[playerid][5])
	{
		   AddObjectToModCar(ModObjekt_5, playerid, vehicleid);
	       return 1;
  	}
	if(playertextid == Farbauswahl[playerid][6])
	{
		   AddObjectToModCar(ModObjekt_6, playerid, vehicleid);
	       return 1;
  	}
	if(playertextid == Farbauswahl[playerid][7])//
	{
		   AddObjectToModCar(ModObjekt_7, playerid, vehicleid);
	       return 1;
  	}
	if(playertextid == Farbauswahl[playerid][8])
	{
		   AddObjectToModCar(ModObjekt_8, playerid, vehicleid);
	       return 1;
  	}
	if(playertextid == Farbauswahl[playerid][9])
	{
		   AddObjectToModCar(ModObjekt_9, playerid, vehicleid);
	       return 1;
  	}
	if(playertextid == Farbauswahl[playerid][10])
	{
		   AddObjectToModCar(ModObjekt_10, playerid, vehicleid);
	       return 1;
  	}
	if(playertextid == Farbauswahl[playerid][11])
	{
		   AddObjectToModCar(ModObjekt_11, playerid, vehicleid);
	       return 1;
  	}
	if(playertextid == Farbauswahl[playerid][12])
	{
		   AddObjectToModCar(ModObjekt_12, playerid, vehicleid);
	       return 1;
  	}
	if(playertextid == Farbauswahl[playerid][13])
	{
		   AddObjectToModCar(ModObjekt_13, playerid, vehicleid);
	       return 1;
  	}
	if(playertextid == Farbauswahl[playerid][14])
	{
		   AddObjectToModCar(ModObjekt_14, playerid, vehicleid);
	       return 1;
  	}
	if(playertextid == Farbauswahl[playerid][15])
	{
		   AddObjectToModCar(ModObjekt_15, playerid, vehicleid);
	       return 1;
  	}
	if(playertextid == Farbauswahl[playerid][16])
	{
		   AddObjectToModCar(ModObjekt_16, playerid, vehicleid);
	       return 1;
  	}
	if(playertextid == Farbauswahl[playerid][17])
	{
		   AddObjectToModCar(ModObjekt_17, playerid, vehicleid);
	       return 1;
  	}
  }
  if(strcmp(string, "Rader") == 0)
	{
	if(playertextid == Farbauswahl[playerid][0])
	{
	    AddModVehicleComponent(vehicleid, 1096);
	    PlayerPlaySound(playerid, 1083, 0, 0, 0);
	    SetPVarInt(playerid, "ModShop_Wheels", 3000);
	    Preis = GetPVarInt(playerid, "ModShop_Wheels");
	    format(string, sizeof string, "$%i", Preis);
	    PlayerTextDrawSetString(playerid, PlayerText:ModshopPreis[playerid], string);
	    PlayerTextDrawShow(playerid, PlayerText:ModshopPreis[playerid]);
	    return 1;
  	}
  	if(playertextid == Farbauswahl[playerid][1])
  	{
	    AddModVehicleComponent(vehicleid, 1083);
	 	PlayerPlaySound(playerid, 1083, 0, 0, 0);
	    SetPVarInt(playerid, "ModShop_Wheels", 3250);
	 	Preis = GetPVarInt(playerid, "ModShop_Wheels");
	 	format(string, sizeof string, "$%i", Preis);
	 	PlayerTextDrawSetString(playerid, PlayerText:ModshopPreis[playerid], string);
	 	PlayerTextDrawShow(playerid, PlayerText:ModshopPreis[playerid]);
     	return 1;
  	}
  	if(playertextid == Farbauswahl[playerid][2])
  	{
	    AddModVehicleComponent(vehicleid, 1084);
	 	PlayerPlaySound(playerid, 1083, 0, 0, 0);
	    SetPVarInt(playerid, "ModShop_Wheels", 3500);
	 	Preis = GetPVarInt(playerid, "ModShop_Wheels");
	 	format(string, sizeof string, "$%i", Preis);
	 	PlayerTextDrawSetString(playerid, PlayerText:ModshopPreis[playerid], string);
	 	PlayerTextDrawShow(playerid, PlayerText:ModshopPreis[playerid]);
     	return 1;
  	}
  	if(playertextid == Farbauswahl[playerid][3])
  	{
	    AddModVehicleComponent(vehicleid, 1081);
	 	PlayerPlaySound(playerid, 1083, 0, 0, 0);
	    SetPVarInt(playerid, "ModShop_Wheels", 3600);
	 	Preis = GetPVarInt(playerid, "ModShop_Wheels");
	 	format(string, sizeof string, "$%i", Preis);
	 	PlayerTextDrawSetString(playerid, PlayerText:ModshopPreis[playerid], string);
	 	PlayerTextDrawShow(playerid, PlayerText:ModshopPreis[playerid]);
     	return 1;
  	}
  	if(playertextid == Farbauswahl[playerid][4])
  	{
	    AddModVehicleComponent(vehicleid, 1097);
	 	PlayerPlaySound(playerid, 1083, 0, 0, 0);
	    SetPVarInt(playerid, "ModShop_Wheels", 2800);
	 	Preis = GetPVarInt(playerid, "ModShop_Wheels");
	 	format(string, sizeof string, "$%i", Preis);
	 	PlayerTextDrawSetString(playerid, PlayerText:ModshopPreis[playerid], string);
	 	PlayerTextDrawShow(playerid, PlayerText:ModshopPreis[playerid]);
     	return 1;
  	}
  	if(playertextid == Farbauswahl[playerid][5])
  	{
	    AddModVehicleComponent(vehicleid, 1098);
	 	PlayerPlaySound(playerid, 1083, 0, 0, 0);
	    SetPVarInt(playerid, "ModShop_Wheels", 2500);
	 	Preis = GetPVarInt(playerid, "ModShop_Wheels");
	 	format(string, sizeof string, "$%i", Preis);
	 	PlayerTextDrawSetString(playerid, PlayerText:ModshopPreis[playerid], string);
	 	PlayerTextDrawShow(playerid, PlayerText:ModshopPreis[playerid]);
     	return 1;
  	}
  	if(playertextid == Farbauswahl[playerid][6])
  	{
	    AddModVehicleComponent(vehicleid, 1025);
	 	PlayerPlaySound(playerid, 1083, 0, 0, 0);
	    SetPVarInt(playerid, "ModShop_Wheels", 3000);
	 	Preis = GetPVarInt(playerid, "ModShop_Wheels");
	 	format(string, sizeof string, "$%i", Preis);
	 	PlayerTextDrawSetString(playerid, PlayerText:ModshopPreis[playerid], string);
	 	PlayerTextDrawShow(playerid, PlayerText:ModshopPreis[playerid]);
     	return 1;
  	}
  	if(playertextid == Farbauswahl[playerid][7])
  	{
	    AddModVehicleComponent(vehicleid, 1085);
	 	PlayerPlaySound(playerid, 1083, 0, 0, 0);
	    SetPVarInt(playerid, "ModShop_Wheels", 3650);
	 	Preis = GetPVarInt(playerid, "ModShop_Wheels");
	 	format(string, sizeof string, "$%i", Preis);
	 	PlayerTextDrawSetString(playerid, PlayerText:ModshopPreis[playerid], string);
	 	PlayerTextDrawShow(playerid, PlayerText:ModshopPreis[playerid]);
     	return 1;
  	}
  	if(playertextid == Farbauswahl[playerid][8])
  	{
	    AddModVehicleComponent(vehicleid, 1082);
	 	PlayerPlaySound(playerid, 1083, 0, 0, 0);
	    SetPVarInt(playerid, "ModShop_Wheels", 3700);
	 	Preis = GetPVarInt(playerid, "ModShop_Wheels");
	 	format(string, sizeof string, "$%i", Preis);
	 	PlayerTextDrawSetString(playerid, PlayerText:ModshopPreis[playerid], string);
	 	PlayerTextDrawShow(playerid, PlayerText:ModshopPreis[playerid]);
     	return 1;
  	}
  	if(playertextid == Farbauswahl[playerid][9])
  	{
	    AddModVehicleComponent(vehicleid, 1080);
	 	PlayerPlaySound(playerid, 1083, 0, 0, 0);
	    SetPVarInt(playerid, "ModShop_Wheels", 3750);
	 	Preis = GetPVarInt(playerid, "ModShop_Wheels");
	 	format(string, sizeof string, "$%i", Preis);
	 	PlayerTextDrawSetString(playerid, PlayerText:ModshopPreis[playerid], string);
	 	PlayerTextDrawShow(playerid, PlayerText:ModshopPreis[playerid]);
     	return 1;
  	}
  	if(playertextid == Farbauswahl[playerid][10])
  	{
	    AddModVehicleComponent(vehicleid, 1073);
	 	PlayerPlaySound(playerid, 1083, 0, 0, 0);
	    SetPVarInt(playerid, "ModShop_Wheels", 3200);
	 	Preis = GetPVarInt(playerid, "ModShop_Wheels");
	 	format(string, sizeof string, "$%i", Preis);
	 	PlayerTextDrawSetString(playerid, PlayerText:ModshopPreis[playerid], string);
	 	PlayerTextDrawShow(playerid, PlayerText:ModshopPreis[playerid]);
     	return 1;
  	}
  	if(playertextid == Farbauswahl[playerid][11])
  	{
	    AddModVehicleComponent(vehicleid, 1079);
	 	PlayerPlaySound(playerid, 1083, 0, 0, 0);
	    SetPVarInt(playerid, "ModShop_Wheels", 3250);
	 	Preis = GetPVarInt(playerid, "ModShop_Wheels");
	 	format(string, sizeof string, "$%i", Preis);
	 	PlayerTextDrawSetString(playerid, PlayerText:ModshopPreis[playerid], string);
	 	PlayerTextDrawShow(playerid, PlayerText:ModshopPreis[playerid]);
     	return 1;
  	}
  	if(playertextid == Farbauswahl[playerid][12])
  	{
	    AddModVehicleComponent(vehicleid, 1078);
	 	PlayerPlaySound(playerid, 1083, 0, 0, 0);
	    SetPVarInt(playerid, "ModShop_Wheels", 3500);
	 	Preis = GetPVarInt(playerid, "ModShop_Wheels");
	 	format(string, sizeof string, "$%i", Preis);
	 	PlayerTextDrawSetString(playerid, PlayerText:ModshopPreis[playerid], string);
	 	PlayerTextDrawShow(playerid, PlayerText:ModshopPreis[playerid]);
     	return 1;
  	}
  	if(playertextid == Farbauswahl[playerid][13])
  	{
	    AddModVehicleComponent(vehicleid, 1077);
	 	PlayerPlaySound(playerid, 1083, 0, 0, 0);
	    SetPVarInt(playerid, "ModShop_Wheels", 3700);
	 	Preis = GetPVarInt(playerid, "ModShop_Wheels");
	 	format(string, sizeof string, "$%i", Preis);
	 	PlayerTextDrawSetString(playerid, PlayerText:ModshopPreis[playerid], string);
	 	PlayerTextDrawShow(playerid, PlayerText:ModshopPreis[playerid]);
     	return 1;
  	}
  	if(playertextid == Farbauswahl[playerid][14])
  	{
	    AddModVehicleComponent(vehicleid, 1076);
	 	PlayerPlaySound(playerid, 1083, 0, 0, 0);
	    SetPVarInt(playerid, "ModShop_Wheels", 3400);
	 	Preis = GetPVarInt(playerid, "ModShop_Wheels");
	 	format(string, sizeof string, "$%i", Preis);
	 	PlayerTextDrawSetString(playerid, PlayerText:ModshopPreis[playerid], string);
	 	PlayerTextDrawShow(playerid, PlayerText:ModshopPreis[playerid]);
     	return 1;
  	}
  	if(playertextid == Farbauswahl[playerid][15])
  	{
	    AddModVehicleComponent(vehicleid, 1075);
	 	PlayerPlaySound(playerid, 1083, 0, 0, 0);
	    SetPVarInt(playerid, "ModShop_Wheels", 3450);
	 	Preis = GetPVarInt(playerid, "ModShop_Wheels");
	 	format(string, sizeof string, "$%i", Preis);
	 	PlayerTextDrawSetString(playerid, PlayerText:ModshopPreis[playerid], string);
	 	PlayerTextDrawShow(playerid, PlayerText:ModshopPreis[playerid]);
     	return 1;
  	}
  	if(playertextid == Farbauswahl[playerid][16])
  	{
	    AddModVehicleComponent(vehicleid, 1074);
	 	PlayerPlaySound(playerid, 1083, 0, 0, 0);
	    SetPVarInt(playerid, "ModShop_Wheels", 3500);
	 	Preis = GetPVarInt(playerid, "ModShop_Wheels");
	 	format(string, sizeof string, "$%i", Preis);
	 	PlayerTextDrawSetString(playerid, PlayerText:ModshopPreis[playerid], string);
	 	PlayerTextDrawShow(playerid, PlayerText:ModshopPreis[playerid]);
     	return 1;
  	}
  }
  if(GetPVarInt(playerid, "Farben") == 1)
	{
	if(playertextid == Farbauswahl[playerid][0])//Weiß
	{
	    KillTimer(RainbowCarTimer1);
     	RainbowColor[vehicleid] = 0;
	 	ChangeVehicleColor(GetPVarInt(playerid, "VehicleID"), 1, Y);
	 	VehicleColor[GetVehicleID(GetPVarInt(playerid, "VehicleID"))][0] = 1;
	 	PlayerPlaySound(playerid, 1083, 0, 0, 0);
	    SetPVarInt(playerid, "ModShop_Farbe1", 2500);
	 	Preis = GetPVarInt(playerid, "ModShop_Farbe1");
	 	format(string, sizeof string, "$%i", Preis);
	 	PlayerTextDrawSetString(playerid, PlayerText:ModshopPreis[playerid], string);
	 	PlayerTextDrawShow(playerid, PlayerText:ModshopPreis[playerid]);
     	return 1;
  	}
  	if(playertextid == Farbauswahl[playerid][1])//Schwarz
  	{
	 	KillTimer(RainbowCarTimer1);
     	RainbowColor[vehicleid] = 0;
	 	ChangeVehicleColor(GetPVarInt(playerid, "VehicleID"), 0, Y);
	 	VehicleColor[GetVehicleID(GetPVarInt(playerid, "VehicleID"))][0] = 0;
	 	PlayerPlaySound(playerid, 1083, 0, 0, 0);
	    SetPVarInt(playerid, "ModShop_Farbe1", 2500);
	 	Preis = GetPVarInt(playerid, "ModShop_Farbe1");
	 	format(string, sizeof string, "$%i", Preis);
	 	PlayerTextDrawSetString(playerid, PlayerText:ModshopPreis[playerid], string);
	 	PlayerTextDrawShow(playerid, PlayerText:ModshopPreis[playerid]);
     	return 1;
  	}
  	if(playertextid == Farbauswahl[playerid][2])//Rot
  	{
	 	KillTimer(RainbowCarTimer1);
     	RainbowColor[vehicleid] = 0;
	 	ChangeVehicleColor(GetPVarInt(playerid, "VehicleID"), 3, Y);
	 	VehicleColor[GetVehicleID(GetPVarInt(playerid, "VehicleID"))][0] = 3;
	 	PlayerPlaySound(playerid, 1083, 0, 0, 0);
	    SetPVarInt(playerid, "ModShop_Farbe1", 2500);
	 	Preis = GetPVarInt(playerid, "ModShop_Farbe1");
	 	format(string, sizeof string, "$%i", Preis);
	 	PlayerTextDrawSetString(playerid, PlayerText:ModshopPreis[playerid], string);
	 	PlayerTextDrawShow(playerid, PlayerText:ModshopPreis[playerid]);
     	return 1;
  	}
  	if(playertextid == Farbauswahl[playerid][3])//Blau
  	{
	 	KillTimer(RainbowCarTimer1);
   		RainbowColor[vehicleid] = 0;
	 	ChangeVehicleColor(GetPVarInt(playerid, "VehicleID"), 93, Y);
	 	VehicleColor[GetVehicleID(GetPVarInt(playerid, "VehicleID"))][0] = 93;
	 	PlayerPlaySound(playerid, 1083, 0, 0, 0);
	    SetPVarInt(playerid, "ModShop_Farbe1", 2500);
	 	Preis = GetPVarInt(playerid, "ModShop_Farbe1");
	 	format(string, sizeof string, "$%i", Preis);
	 	PlayerTextDrawSetString(playerid, PlayerText:ModshopPreis[playerid], string);
	 	PlayerTextDrawShow(playerid, PlayerText:ModshopPreis[playerid]);
     	return 1;
  	}
  	if(playertextid == Farbauswahl[playerid][4])//Hellgrün
  	{
	 	KillTimer(RainbowCarTimer1);
     	RainbowColor[vehicleid] = 0;
	 	ChangeVehicleColor(GetPVarInt(playerid, "VehicleID"), 226, Y);
	 	VehicleColor[GetVehicleID(GetPVarInt(playerid, "VehicleID"))][0] = 226;
	 	PlayerPlaySound(playerid, 1083, 0, 0, 0);
	    SetPVarInt(playerid, "ModShop_Farbe1", 2500);
	 	Preis = GetPVarInt(playerid, "ModShop_Farbe1");
	 	format(string, sizeof string, "$%i", Preis);
	 	PlayerTextDrawSetString(playerid, PlayerText:ModshopPreis[playerid], string);
	 	PlayerTextDrawShow(playerid, PlayerText:ModshopPreis[playerid]);
     	return 1;
  	}
  	if(playertextid == Farbauswahl[playerid][5])//Gelb
  	{
		KillTimer(RainbowCarTimer1);
     	RainbowColor[vehicleid] = 0;
	 	ChangeVehicleColor(GetPVarInt(playerid, "VehicleID"), 6, Y);
	 	VehicleColor[GetVehicleID(GetPVarInt(playerid, "VehicleID"))][0] = 6;
	 	PlayerPlaySound(playerid, 1083, 0, 0, 0);
	    SetPVarInt(playerid, "ModShop_Farbe1", 2500);
	 	Preis = GetPVarInt(playerid, "ModShop_Farbe1");
	 	format(string, sizeof string, "$%i", Preis);
	 	PlayerTextDrawSetString(playerid, PlayerText:ModshopPreis[playerid], string);
	 	PlayerTextDrawShow(playerid, PlayerText:ModshopPreis[playerid]);
     	return 1;
  	}
  	if(playertextid == Farbauswahl[playerid][6])//Hellgrau
  	{
	 	KillTimer(RainbowCarTimer1);
     	RainbowColor[vehicleid] = 0;
	 	ChangeVehicleColor(GetPVarInt(playerid, "VehicleID"), 250, Y);
	 	VehicleColor[GetVehicleID(GetPVarInt(playerid, "VehicleID"))][0] = 250;
	 	PlayerPlaySound(playerid, 1083, 0, 0, 0);
	    SetPVarInt(playerid, "ModShop_Farbe1", 2500);
	 	Preis = GetPVarInt(playerid, "ModShop_Farbe1");
	 	format(string, sizeof string, "$%i", Preis);
	 	PlayerTextDrawSetString(playerid, PlayerText:ModshopPreis[playerid], string);
	 	PlayerTextDrawShow(playerid, PlayerText:ModshopPreis[playerid]);
     	return 1;
  	}
  	if(playertextid == Farbauswahl[playerid][7])//Hellblau
  	{
	 	KillTimer(RainbowCarTimer1);
     	RainbowColor[vehicleid] = 0;
	 	ChangeVehicleColor(GetPVarInt(playerid, "VehicleID"), 155, Y);
	 	VehicleColor[GetVehicleID(GetPVarInt(playerid, "VehicleID"))][0] = 155;
	 	PlayerPlaySound(playerid, 1083, 0, 0, 0);
	    SetPVarInt(playerid, "ModShop_Farbe1", 2500);
	 	Preis = GetPVarInt(playerid, "ModShop_Farbe1");
	 	format(string, sizeof string, "$%i", Preis);
	 	PlayerTextDrawSetString(playerid, PlayerText:ModshopPreis[playerid], string);
	 	PlayerTextDrawShow(playerid, PlayerText:ModshopPreis[playerid]);
     	return 1;
  	}
  	if(playertextid == Farbauswahl[playerid][8])//Grau
  	{
	 	KillTimer(RainbowCarTimer1);
     	RainbowColor[vehicleid] = 0;
	 	ChangeVehicleColor(GetPVarInt(playerid, "VehicleID"), 157, Y);
	 	VehicleColor[GetVehicleID(GetPVarInt(playerid, "VehicleID"))][0] = 157;
	 	PlayerPlaySound(playerid, 1083, 0, 0, 0);
	    SetPVarInt(playerid, "ModShop_Farbe1", 2500);
	 	Preis = GetPVarInt(playerid, "ModShop_Farbe1");
	 	format(string, sizeof string, "$%i", Preis);
	 	PlayerTextDrawSetString(playerid, PlayerText:ModshopPreis[playerid], string);
	 	PlayerTextDrawShow(playerid, PlayerText:ModshopPreis[playerid]);
     	return 1;
  	}
  	if(playertextid == Farbauswahl[playerid][9])//Orange
  	{
	 	KillTimer(RainbowCarTimer1);
     	RainbowColor[vehicleid] = 0;
	 	ChangeVehicleColor(GetPVarInt(playerid, "VehicleID"), 219, Y);
	 	VehicleColor[GetVehicleID(GetPVarInt(playerid, "VehicleID"))][0] = 219;
	 	PlayerPlaySound(playerid, 1083, 0, 0, 0);
	    SetPVarInt(playerid, "ModShop_Farbe1", 2500);
	 	Preis = GetPVarInt(playerid, "ModShop_Farbe1");
	 	format(string, sizeof string, "$%i", Preis);
	 	PlayerTextDrawSetString(playerid, PlayerText:ModshopPreis[playerid], string);
	 	PlayerTextDrawShow(playerid, PlayerText:ModshopPreis[playerid]);
     	return 1;
  	}
  	if(playertextid == Farbauswahl[playerid][10])//Dunkelrot
  	{
	 	KillTimer(RainbowCarTimer1);
     	RainbowColor[vehicleid] = 0;
	 	ChangeVehicleColor(GetPVarInt(playerid, "VehicleID"),181, Y);
	 	VehicleColor[GetVehicleID(GetPVarInt(playerid, "VehicleID"))][0] = 181;
	 	PlayerPlaySound(playerid, 1083, 0, 0, 0);
	    SetPVarInt(playerid, "ModShop_Farbe1", 2500);
	 	Preis = GetPVarInt(playerid, "ModShop_Farbe1");
	 	format(string, sizeof string, "$%i", Preis);
	 	PlayerTextDrawSetString(playerid, PlayerText:ModshopPreis[playerid], string);
	 	PlayerTextDrawShow(playerid, PlayerText:ModshopPreis[playerid]);
     	return 1;
  	}
  	if(playertextid == Farbauswahl[playerid][11])//Hellgelb
  	{
		 KillTimer(RainbowCarTimer1);
     	RainbowColor[vehicleid] = 0;
	 	ChangeVehicleColor(GetPVarInt(playerid, "VehicleID"), 200, Y);
	 	VehicleColor[GetVehicleID(GetPVarInt(playerid, "VehicleID"))][0] = 200;
	 	PlayerPlaySound(playerid, 1083, 0, 0, 0);
	    SetPVarInt(playerid, "ModShop_Farbe1", 2500);
	 	Preis = GetPVarInt(playerid, "ModShop_Farbe1");
	 	format(string, sizeof string, "$%i", Preis);
	 	PlayerTextDrawSetString(playerid, PlayerText:ModshopPreis[playerid], string);
	 	PlayerTextDrawShow(playerid, PlayerText:ModshopPreis[playerid]);
     	return 1;
  	}
  	if(playertextid == Farbauswahl[playerid][12])//Lila
  	{
	 	KillTimer(RainbowCarTimer1);
     	RainbowColor[vehicleid] = 0;
	 	ChangeVehicleColor(GetPVarInt(playerid, "VehicleID"), 171, Y);
	 	VehicleColor[GetVehicleID(GetPVarInt(playerid, "VehicleID"))][0] = 171;
	 	PlayerPlaySound(playerid, 1083, 0, 0, 0);
	    SetPVarInt(playerid, "ModShop_Farbe1", 2500);
	 	Preis = GetPVarInt(playerid, "ModShop_Farbe1");
	 	format(string, sizeof string, "$%i", Preis);
	 	PlayerTextDrawSetString(playerid, PlayerText:ModshopPreis[playerid], string);
	 	PlayerTextDrawShow(playerid, PlayerText:ModshopPreis[playerid]);
	 	return 1;
  	}
  	if(playertextid == Farbauswahl[playerid][13])//Dunkelgrün
  	{
	 	KillTimer(RainbowCarTimer1);
     	RainbowColor[vehicleid] = 0;
	 	ChangeVehicleColor(GetPVarInt(playerid, "VehicleID"),234, Y);
	 	VehicleColor[GetVehicleID(GetPVarInt(playerid, "VehicleID"))][0] = 234;
	 	PlayerPlaySound(playerid, 1083, 0, 0, 0);
	    SetPVarInt(playerid, "ModShop_Farbe1", 2500);
	 	Preis = GetPVarInt(playerid, "ModShop_Farbe1");
	 	format(string, sizeof string, "$%i", Preis);
	 	PlayerTextDrawSetString(playerid, PlayerText:ModshopPreis[playerid], string);
	 	PlayerTextDrawShow(playerid, PlayerText:ModshopPreis[playerid]);
     	return 1;
  	}
  	if(playertextid == Farbauswahl[playerid][14])//hässliches Gelb
  	{
	 	KillTimer(RainbowCarTimer1);
     	RainbowColor[vehicleid] = 0;
	 	ChangeVehicleColor(GetPVarInt(playerid, "VehicleID"),77, Y);
	 	VehicleColor[GetVehicleID(GetPVarInt(playerid, "VehicleID"))][0] = 77;
	 	PlayerPlaySound(playerid, 1083, 0, 0, 0);
	    SetPVarInt(playerid, "ModShop_Farbe1", 2500);
	 	Preis = GetPVarInt(playerid, "ModShop_Farbe1");
	 	format(string, sizeof string, "$%i", Preis);
	 	PlayerTextDrawSetString(playerid, PlayerText:ModshopPreis[playerid], string);
	 	PlayerTextDrawShow(playerid, PlayerText:ModshopPreis[playerid]);
     	return 1;
  	}
  	if(playertextid == Farbauswahl[playerid][15])//Pink
  	{
	 	KillTimer(RainbowCarTimer1);
     	RainbowColor[vehicleid] = 0;
	 	ChangeVehicleColor(GetPVarInt(playerid, "VehicleID"),126, Y);
	 	VehicleColor[GetVehicleID(GetPVarInt(playerid, "VehicleID"))][0] = 126;
	 	PlayerPlaySound(playerid, 1083, 0, 0, 0);
	    SetPVarInt(playerid, "ModShop_Farbe1", 2500);
	 	Preis = GetPVarInt(playerid, "ModShop_Farbe1");
	 	format(string, sizeof string, "$%i", Preis);
	 	PlayerTextDrawSetString(playerid, PlayerText:ModshopPreis[playerid], string);
	 	PlayerTextDrawShow(playerid, PlayerText:ModshopPreis[playerid]);
     	return 1;
  	}
  	if(playertextid == Farbauswahl[playerid][16])//Rosa
  	{
	 	KillTimer(RainbowCarTimer1);
     	RainbowColor[vehicleid] = 0;
	 	ChangeVehicleColor(GetPVarInt(playerid, "VehicleID"),136, Y);
	 	VehicleColor[GetVehicleID(GetPVarInt(playerid, "VehicleID"))][0] = 136;
	 	PlayerPlaySound(playerid, 1083, 0, 0, 0);
	    SetPVarInt(playerid, "ModShop_Farbe1", 2500);
	 	Preis = GetPVarInt(playerid, "ModShop_Farbe1");
	 	format(string, sizeof string, "$%i", Preis);
	 	PlayerTextDrawSetString(playerid, PlayerText:ModshopPreis[playerid], string);
	 	PlayerTextDrawShow(playerid, PlayerText:ModshopPreis[playerid]);
     	return 1;
  	}
  	if(playertextid == Farbauswahl[playerid][17])//keine Ahnung, dunkles Blau
  	{
		 KillTimer(RainbowCarTimer1);
     	RainbowColor[vehicleid] = 0;
	 	ChangeVehicleColor(GetPVarInt(playerid, "VehicleID"),205, Y);
	 	VehicleColor[GetVehicleID(GetPVarInt(playerid, "VehicleID"))][0] = 205;
	 	PlayerPlaySound(playerid, 1083, 0, 0, 0);
	    SetPVarInt(playerid, "ModShop_Farbe1", 2500);
	 	Preis = GetPVarInt(playerid, "ModShop_Farbe1");
	 	format(string, sizeof string, "$%i", Preis);
	 	PlayerTextDrawSetString(playerid, PlayerText:ModshopPreis[playerid], string);
	 	PlayerTextDrawShow(playerid, PlayerText:ModshopPreis[playerid]);
     	return 1;
  	}
  	if(playertextid == Farbauswahl[playerid][18])//Gold
  	{
	 	KillTimer(RainbowCarTimer1);
     	RainbowColor[vehicleid] = 0;
	 	ChangeVehicleColor(GetPVarInt(playerid, "VehicleID"), 228, Y);
	 	VehicleColor[GetVehicleID(GetPVarInt(playerid, "VehicleID"))][0] = 228;
	 	PlayerPlaySound(playerid, 1083, 0, 0, 0);
	    SetPVarInt(playerid, "ModShop_Farbe1", 3050);
	 	Preis = GetPVarInt(playerid, "ModShop_Farbe1");
	 	format(string, sizeof string, "$%i", Preis);
	 	PlayerTextDrawSetString(playerid, PlayerText:ModshopPreis[playerid], string);
	 	PlayerTextDrawShow(playerid, PlayerText:ModshopPreis[playerid]);
     	return 1;
  	}
  	if(playertextid == Farbauswahl[playerid][19])//Rainbow
  	{
	 	KillTimer(RainbowCarTimer1);
	 	RainbowCarTimer1 = SetTimerEx("RainbowCar1", 500, true, "%i, %i", playerid, vehicleid);
	 	VehicleColor[GetVehicleID(GetPVarInt(playerid, "VehicleID"))][0] = -1;
     	RainbowColor[vehicleid] = 1;
	 	PlayerPlaySound(playerid, 1083, 0, 0, 0);
	    SetPVarInt(playerid, "ModShop_Farbe1", 35000);
	 	Preis = GetPVarInt(playerid, "ModShop_Farbe1");
	 	format(string, sizeof string, "$%i", Preis);
	 	PlayerTextDrawSetString(playerid, PlayerText:ModshopPreis[playerid], string);
	 	PlayerTextDrawShow(playerid, PlayerText:ModshopPreis[playerid]);
     	return 1;
  	}
  }
  if(GetPVarInt(playerid, "Tachofarbe") == 1)
  {
	if(playertextid == Farbauswahl[playerid][0])//Weiß
	{
	    Tachofarbe(playerid, GetPVarInt(playerid, "Tachobereich"), Weis);
	 	PlayerPlaySound(playerid, 1083, 0, 0, 0);
	    SetPVarInt(playerid, "ModShop_TachoFarbe", 2500);
	 	Preis = GetPVarInt(playerid, "ModShop_TachoFarbe");
	 	format(string, sizeof string, "$%i", Preis);
	 	PlayerTextDrawSetString(playerid, PlayerText:ModshopPreis[playerid], string);
	 	PlayerTextDrawShow(playerid, PlayerText:ModshopPreis[playerid]);
     	return 1;
  	}
	if(playertextid == Farbauswahl[playerid][1])//Schwarz
	{
	    Tachofarbe(playerid, GetPVarInt(playerid, "Tachobereich"), 255);
	 	PlayerPlaySound(playerid, 1083, 0, 0, 0);
	    SetPVarInt(playerid, "ModShop_TachoFarbe", 2500);
	 	Preis = GetPVarInt(playerid, "ModShop_TachoFarbe");
	 	format(string, sizeof string, "$%i", Preis);
	 	PlayerTextDrawSetString(playerid, PlayerText:ModshopPreis[playerid], string);
	 	PlayerTextDrawShow(playerid, PlayerText:ModshopPreis[playerid]);
     	return 1;
  	}
	if(playertextid == Farbauswahl[playerid][2])//Rot
	{
	    Tachofarbe(playerid, GetPVarInt(playerid, "Tachobereich"), Hellrot);
	 	PlayerPlaySound(playerid, 1083, 0, 0, 0);
	    SetPVarInt(playerid, "ModShop_TachoFarbe", 2500);
	 	Preis = GetPVarInt(playerid, "ModShop_TachoFarbe");
	 	format(string, sizeof string, "$%i", Preis);
	 	PlayerTextDrawSetString(playerid, PlayerText:ModshopPreis[playerid], string);
	 	PlayerTextDrawShow(playerid, PlayerText:ModshopPreis[playerid]);
     	return 1;
  	}
	if(playertextid == Farbauswahl[playerid][3])//Rot
	{
	    Tachofarbe(playerid, GetPVarInt(playerid, "Tachobereich"), Hellblau);
	 	PlayerPlaySound(playerid, 1083, 0, 0, 0);
	    SetPVarInt(playerid, "ModShop_TachoFarbe", 2500);
	 	Preis = GetPVarInt(playerid, "ModShop_TachoFarbe");
	 	format(string, sizeof string, "$%i", Preis);
	 	PlayerTextDrawSetString(playerid, PlayerText:ModshopPreis[playerid], string);
	 	PlayerTextDrawShow(playerid, PlayerText:ModshopPreis[playerid]);
     	return 1;
  	}
	if(playertextid == Farbauswahl[playerid][4])//Rot
	{
	    Tachofarbe(playerid, GetPVarInt(playerid, "Tachobereich"), Hellgrün);
	 	PlayerPlaySound(playerid, 1083, 0, 0, 0);
	    SetPVarInt(playerid, "ModShop_TachoFarbe", 2500);
	 	Preis = GetPVarInt(playerid, "ModShop_TachoFarbe");
	 	format(string, sizeof string, "$%i", Preis);
	 	PlayerTextDrawSetString(playerid, PlayerText:ModshopPreis[playerid], string);
	 	PlayerTextDrawShow(playerid, PlayerText:ModshopPreis[playerid]);
     	return 1;
  	}
	if(playertextid == Farbauswahl[playerid][5])//Gelb
	{
	    Tachofarbe(playerid, GetPVarInt(playerid, "Tachobereich"), 0xFFFF00FF);
	 	PlayerPlaySound(playerid, 1083, 0, 0, 0);
	    SetPVarInt(playerid, "ModShop_TachoFarbe", 2500);
	 	Preis = GetPVarInt(playerid, "ModShop_TachoFarbe");
	 	format(string, sizeof string, "$%i", Preis);
	 	PlayerTextDrawSetString(playerid, PlayerText:ModshopPreis[playerid], string);
	 	PlayerTextDrawShow(playerid, PlayerText:ModshopPreis[playerid]);
     	return 1;
  	}
	if(playertextid == Farbauswahl[playerid][6])
	{
	    Tachofarbe(playerid, GetPVarInt(playerid, "Tachobereich"), 0x808080FF);
	 	PlayerPlaySound(playerid, 1083, 0, 0, 0);
	    SetPVarInt(playerid, "ModShop_TachoFarbe", 2500);
	 	Preis = GetPVarInt(playerid, "ModShop_TachoFarbe");
	 	format(string, sizeof string, "$%i", Preis);
	 	PlayerTextDrawSetString(playerid, PlayerText:ModshopPreis[playerid], string);
	 	PlayerTextDrawShow(playerid, PlayerText:ModshopPreis[playerid]);
     	return 1;
  	}
	if(playertextid == Farbauswahl[playerid][7])
	{
        Tachofarbe(playerid, GetPVarInt(playerid, "Tachobereich"), 0x00FFFFFF);
	 	PlayerPlaySound(playerid, 1083, 0, 0, 0);
	    SetPVarInt(playerid, "ModShop_TachoFarbe", 2500);
	 	Preis = GetPVarInt(playerid, "ModShop_TachoFarbe");
	 	format(string, sizeof string, "$%i", Preis);
	 	PlayerTextDrawSetString(playerid, PlayerText:ModshopPreis[playerid], string);
	 	PlayerTextDrawShow(playerid, PlayerText:ModshopPreis[playerid]);
     	return 1;
  	}
	if(playertextid == Farbauswahl[playerid][8])
	{
	    Tachofarbe(playerid, GetPVarInt(playerid, "Tachobereich"), 0xC0C0C0FF);
	 	PlayerPlaySound(playerid, 1083, 0, 0, 0);
	    SetPVarInt(playerid, "ModShop_TachoFarbe", 2500);
	 	Preis = GetPVarInt(playerid, "ModShop_TachoFarbe");
	 	format(string, sizeof string, "$%i", Preis);
	 	PlayerTextDrawSetString(playerid, PlayerText:ModshopPreis[playerid], string);
	 	PlayerTextDrawShow(playerid, PlayerText:ModshopPreis[playerid]);
     	return 1;
  	}
	if(playertextid == Farbauswahl[playerid][9])
	{
	    Tachofarbe(playerid, GetPVarInt(playerid, "Tachobereich"), 0xFFA500FF);
	 	PlayerPlaySound(playerid, 1083, 0, 0, 0);
	    SetPVarInt(playerid, "ModShop_TachoFarbe", 2500);
	 	Preis = GetPVarInt(playerid, "ModShop_TachoFarbe");
	 	format(string, sizeof string, "$%i", Preis);
	 	PlayerTextDrawSetString(playerid, PlayerText:ModshopPreis[playerid], string);
	 	PlayerTextDrawShow(playerid, PlayerText:ModshopPreis[playerid]);
     	return 1;
  	}
	if(playertextid == Farbauswahl[playerid][10])
	{
	    Tachofarbe(playerid, GetPVarInt(playerid, "Tachobereich"), 0x800000FF);
	 	PlayerPlaySound(playerid, 1083, 0, 0, 0);
	    SetPVarInt(playerid, "ModShop_TachoFarbe", 2500);
	 	Preis = GetPVarInt(playerid, "ModShop_TachoFarbe");
	 	format(string, sizeof string, "$%i", Preis);
	 	PlayerTextDrawSetString(playerid, PlayerText:ModshopPreis[playerid], string);
	 	PlayerTextDrawShow(playerid, PlayerText:ModshopPreis[playerid]);
     	return 1;
  	}
	if(playertextid == Farbauswahl[playerid][11])
	{
	    Tachofarbe(playerid, GetPVarInt(playerid, "Tachobereich"), 0xE8FFABFF);
	 	PlayerPlaySound(playerid, 1083, 0, 0, 0);
	    SetPVarInt(playerid, "ModShop_TachoFarbe", 2500);
	 	Preis = GetPVarInt(playerid, "ModShop_TachoFarbe");
	 	format(string, sizeof string, "$%i", Preis);
	 	PlayerTextDrawSetString(playerid, PlayerText:ModshopPreis[playerid], string);
	 	PlayerTextDrawShow(playerid, PlayerText:ModshopPreis[playerid]);
     	return 1;
  	}
	if(playertextid == Farbauswahl[playerid][12])
	{
	    Tachofarbe(playerid, GetPVarInt(playerid, "Tachobereich"), 0x800080FF);
	 	PlayerPlaySound(playerid, 1083, 0, 0, 0);
	    SetPVarInt(playerid, "ModShop_TachoFarbe", 2500);
	 	Preis = GetPVarInt(playerid, "ModShop_TachoFarbe");
	 	format(string, sizeof string, "$%i", Preis);
	 	PlayerTextDrawSetString(playerid, PlayerText:ModshopPreis[playerid], string);
	 	PlayerTextDrawShow(playerid, PlayerText:ModshopPreis[playerid]);
     	return 1;
  	}
	if(playertextid == Farbauswahl[playerid][13])
	{
	    Tachofarbe(playerid, GetPVarInt(playerid, "Tachobereich"), 0x00A400FF);
	 	PlayerPlaySound(playerid, 1083, 0, 0, 0);
	    SetPVarInt(playerid, "ModShop_TachoFarbe", 2500);
	 	Preis = GetPVarInt(playerid, "ModShop_TachoFarbe");
	 	format(string, sizeof string, "$%i", Preis);
	 	PlayerTextDrawSetString(playerid, PlayerText:ModshopPreis[playerid], string);
	 	PlayerTextDrawShow(playerid, PlayerText:ModshopPreis[playerid]);
     	return 1;
  	}
	if(playertextid == Farbauswahl[playerid][14])
	{
	    Tachofarbe(playerid, GetPVarInt(playerid, "Tachobereich"), 0xD1D8B9FF);
	 	PlayerPlaySound(playerid, 1083, 0, 0, 0);
	    SetPVarInt(playerid, "ModShop_TachoFarbe", 2500);
	 	Preis = GetPVarInt(playerid, "ModShop_TachoFarbe");
	 	format(string, sizeof string, "$%i", Preis);
	 	PlayerTextDrawSetString(playerid, PlayerText:ModshopPreis[playerid], string);
	 	PlayerTextDrawShow(playerid, PlayerText:ModshopPreis[playerid]);
     	return 1;
  	}
	if(playertextid == Farbauswahl[playerid][15])
	{
	    Tachofarbe(playerid, GetPVarInt(playerid, "Tachobereich"), 0xFF98CCFF);
	 	PlayerPlaySound(playerid, 1083, 0, 0, 0);
	    SetPVarInt(playerid, "ModShop_TachoFarbe", 2500);
	 	Preis = GetPVarInt(playerid, "ModShop_TachoFarbe");
	 	format(string, sizeof string, "$%i", Preis);
	 	PlayerTextDrawSetString(playerid, PlayerText:ModshopPreis[playerid], string);
	 	PlayerTextDrawShow(playerid, PlayerText:ModshopPreis[playerid]);
     	return 1;
  	}
	if(playertextid == Farbauswahl[playerid][16])
	{
	    Tachofarbe(playerid, GetPVarInt(playerid, "Tachobereich"), 0xFF6FB7FF);
	 	PlayerPlaySound(playerid, 1083, 0, 0, 0);
	    SetPVarInt(playerid, "ModShop_TachoFarbe", 2500);
	 	Preis = GetPVarInt(playerid, "ModShop_TachoFarbe");
	 	format(string, sizeof string, "$%i", Preis);
	 	PlayerTextDrawSetString(playerid, PlayerText:ModshopPreis[playerid], string);
	 	PlayerTextDrawShow(playerid, PlayerText:ModshopPreis[playerid]);
     	return 1;
  	}
	if(playertextid == Farbauswahl[playerid][17])
	{
	    Tachofarbe(playerid, GetPVarInt(playerid, "Tachobereich"), 0x000063FF);
	 	PlayerPlaySound(playerid, 1083, 0, 0, 0);
	    SetPVarInt(playerid, "ModShop_TachoFarbe", 2500);
	 	Preis = GetPVarInt(playerid, "ModShop_TachoFarbe");
	 	format(string, sizeof string, "$%i", Preis);
	 	PlayerTextDrawSetString(playerid, PlayerText:ModshopPreis[playerid], string);
	 	PlayerTextDrawShow(playerid, PlayerText:ModshopPreis[playerid]);
     	return 1;
  	}
	if(playertextid == Farbauswahl[playerid][18])
	{
	    Tachofarbe(playerid, GetPVarInt(playerid, "Tachobereich"), 0xC8BE54FF);
	 	PlayerPlaySound(playerid, 1083, 0, 0, 0);
	    SetPVarInt(playerid, "ModShop_TachoFarbe", 4000);
	 	Preis = GetPVarInt(playerid, "ModShop_TachoFarbe");
	 	format(string, sizeof string, "$%i", Preis);
	 	PlayerTextDrawSetString(playerid, PlayerText:ModshopPreis[playerid], string);
	 	PlayerTextDrawShow(playerid, PlayerText:ModshopPreis[playerid]);
     	return 1;
  	}
  }
  if(GetPVarInt(playerid, "Farben") == 2)
  {
	if(playertextid == Farbauswahl[playerid][0])//Weiß
	{
	    KillTimer(RainbowCarTimer2);
     	RainbowColor[vehicleid] = 0;
	 	ChangeVehicleColor(GetPVarInt(playerid, "VehicleID"), X, 1);
	 	VehicleColor[GetVehicleID(GetPVarInt(playerid, "VehicleID"))][1] = 1;
	 	PlayerPlaySound(playerid, 1083, 0, 0, 0);
	    SetPVarInt(playerid, "ModShop_Farbe1", 2750);
	 	Preis = GetPVarInt(playerid, "ModShop_Farbe1");
	 	format(string, sizeof string, "$%i", Preis);
	 	PlayerTextDrawSetString(playerid, PlayerText:ModshopPreis[playerid], string);
	 	PlayerTextDrawShow(playerid, PlayerText:ModshopPreis[playerid]);
     	return 1;
  	}
  	if(playertextid == Farbauswahl[playerid][1])//Schwarz
  	{
	 	KillTimer(RainbowCarTimer2);
     	RainbowColor[vehicleid] = 0;
	 	ChangeVehicleColor(GetPVarInt(playerid, "VehicleID"), X, 0);
	 	VehicleColor[GetVehicleID(GetPVarInt(playerid, "VehicleID"))][1] = 0;
	 	PlayerPlaySound(playerid, 1083, 0, 0, 0);
	    SetPVarInt(playerid, "ModShop_Farbe1", 2750);
	 	Preis = GetPVarInt(playerid, "ModShop_Farbe1");
	 	format(string, sizeof string, "$%i", Preis);
	 	PlayerTextDrawSetString(playerid, PlayerText:ModshopPreis[playerid], string);
	 	PlayerTextDrawShow(playerid, PlayerText:ModshopPreis[playerid]);
     	return 1;
  	}
  	if(playertextid == Farbauswahl[playerid][2])//Rot
  	{
	 	KillTimer(RainbowCarTimer2);
     	RainbowColor[vehicleid] = 0;
	 	ChangeVehicleColor(GetPVarInt(playerid, "VehicleID"), X, 3);
	 	VehicleColor[GetVehicleID(GetPVarInt(playerid, "VehicleID"))][1] = 3;
	 	PlayerPlaySound(playerid, 1083, 0, 0, 0);
	    SetPVarInt(playerid, "ModShop_Farbe1", 2750);
	 	Preis = GetPVarInt(playerid, "ModShop_Farbe1");
	 	format(string, sizeof string, "$%i", Preis);
	 	PlayerTextDrawSetString(playerid, PlayerText:ModshopPreis[playerid], string);
	 	PlayerTextDrawShow(playerid, PlayerText:ModshopPreis[playerid]);
     	return 1;
  	}
  	if(playertextid == Farbauswahl[playerid][3])//Blau
  	{
	 	KillTimer(RainbowCarTimer2);
   		RainbowColor[vehicleid] = 0;
	 	ChangeVehicleColor(GetPVarInt(playerid, "VehicleID"), X, 93);
	 	VehicleColor[GetVehicleID(GetPVarInt(playerid, "VehicleID"))][1] = 93;
	 	PlayerPlaySound(playerid, 1083, 0, 0, 0);
	    SetPVarInt(playerid, "ModShop_Farbe1", 2750);
	 	Preis = GetPVarInt(playerid, "ModShop_Farbe1");
	 	format(string, sizeof string, "$%i", Preis);
	 	PlayerTextDrawSetString(playerid, PlayerText:ModshopPreis[playerid], string);
	 	PlayerTextDrawShow(playerid, PlayerText:ModshopPreis[playerid]);
     	return 1;
  	}
  	if(playertextid == Farbauswahl[playerid][4])//Hellgrün
  	{
	 	KillTimer(RainbowCarTimer2);
     	RainbowColor[vehicleid] = 0;
	 	ChangeVehicleColor(GetPVarInt(playerid, "VehicleID"), X, 226);
	 	VehicleColor[GetVehicleID(GetPVarInt(playerid, "VehicleID"))][1] = 226;
	 	PlayerPlaySound(playerid, 1083, 0, 0, 0);
	    SetPVarInt(playerid, "ModShop_Farbe1", 2750);
	 	Preis = GetPVarInt(playerid, "ModShop_Farbe1");
	 	format(string, sizeof string, "$%i", Preis);
	 	PlayerTextDrawSetString(playerid, PlayerText:ModshopPreis[playerid], string);
	 	PlayerTextDrawShow(playerid, PlayerText:ModshopPreis[playerid]);
     	return 1;
  	}
  	if(playertextid == Farbauswahl[playerid][5])//Gelb
  	{
		KillTimer(RainbowCarTimer2);
     	RainbowColor[vehicleid] = 0;
	 	ChangeVehicleColor(GetPVarInt(playerid, "VehicleID"), X, 6);
	 	VehicleColor[GetVehicleID(GetPVarInt(playerid, "VehicleID"))][1] = 6;
	 	PlayerPlaySound(playerid, 1083, 0, 0, 0);
	    SetPVarInt(playerid, "ModShop_Farbe1", 2750);
	 	Preis = GetPVarInt(playerid, "ModShop_Farbe1");
	 	format(string, sizeof string, "$%i", Preis);
	 	PlayerTextDrawSetString(playerid, PlayerText:ModshopPreis[playerid], string);
	 	PlayerTextDrawShow(playerid, PlayerText:ModshopPreis[playerid]);
     	return 1;
  	}
  	if(playertextid == Farbauswahl[playerid][6])//Hellgrau
  	{
	 	KillTimer(RainbowCarTimer2);
     	RainbowColor[vehicleid] = 0;
	 	ChangeVehicleColor(GetPVarInt(playerid, "VehicleID"), X, 250);
	 	VehicleColor[GetVehicleID(GetPVarInt(playerid, "VehicleID"))][1] = 250;
	 	PlayerPlaySound(playerid, 1083, 0, 0, 0);
	    SetPVarInt(playerid, "ModShop_Farbe1", 2750);
	 	Preis = GetPVarInt(playerid, "ModShop_Farbe1");
	 	format(string, sizeof string, "$%i", Preis);
	 	PlayerTextDrawSetString(playerid, PlayerText:ModshopPreis[playerid], string);
	 	PlayerTextDrawShow(playerid, PlayerText:ModshopPreis[playerid]);
     	return 1;
  	}
  	if(playertextid == Farbauswahl[playerid][7])//Hellblau
  	{
	 	KillTimer(RainbowCarTimer2);
     	RainbowColor[vehicleid] = 0;
	 	ChangeVehicleColor(GetPVarInt(playerid, "VehicleID"), X, 155);
	 	VehicleColor[GetVehicleID(GetPVarInt(playerid, "VehicleID"))][1] = 155;
	 	PlayerPlaySound(playerid, 1083, 0, 0, 0);
	    SetPVarInt(playerid, "ModShop_Farbe1", 2750);
	 	Preis = GetPVarInt(playerid, "ModShop_Farbe1");
	 	format(string, sizeof string, "$%i", Preis);
	 	PlayerTextDrawSetString(playerid, PlayerText:ModshopPreis[playerid], string);
	 	PlayerTextDrawShow(playerid, PlayerText:ModshopPreis[playerid]);
     	return 1;
  	}
  	if(playertextid == Farbauswahl[playerid][8])//Grau
  	{
	 	KillTimer(RainbowCarTimer2);
     	RainbowColor[vehicleid] = 0;
	 	ChangeVehicleColor(GetPVarInt(playerid, "VehicleID"), X, 157);
	 	VehicleColor[GetVehicleID(GetPVarInt(playerid, "VehicleID"))][1] = 157;
	 	PlayerPlaySound(playerid, 1083, 0, 0, 0);
	    SetPVarInt(playerid, "ModShop_Farbe1", 2750);
	 	Preis = GetPVarInt(playerid, "ModShop_Farbe1");
	 	format(string, sizeof string, "$%i", Preis);
	 	PlayerTextDrawSetString(playerid, PlayerText:ModshopPreis[playerid], string);
	 	PlayerTextDrawShow(playerid, PlayerText:ModshopPreis[playerid]);
     	return 1;
  	}
  	if(playertextid == Farbauswahl[playerid][9])//Orange
  	{
	 	KillTimer(RainbowCarTimer2);
     	RainbowColor[vehicleid] = 0;
	 	ChangeVehicleColor(GetPVarInt(playerid, "VehicleID"), X, 219);
	 	VehicleColor[GetVehicleID(GetPVarInt(playerid, "VehicleID"))][1] = 219;
	 	PlayerPlaySound(playerid, 1083, 0, 0, 0);
	    SetPVarInt(playerid, "ModShop_Farbe1", 2750);
	 	Preis = GetPVarInt(playerid, "ModShop_Farbe1");
	 	format(string, sizeof string, "$%i", Preis);
	 	PlayerTextDrawSetString(playerid, PlayerText:ModshopPreis[playerid], string);
	 	PlayerTextDrawShow(playerid, PlayerText:ModshopPreis[playerid]);
     	return 1;
  	}
  	if(playertextid == Farbauswahl[playerid][10])//Dunkelrot
  	{
	 	KillTimer(RainbowCarTimer2);
     	RainbowColor[vehicleid] = 0;
	 	ChangeVehicleColor(GetPVarInt(playerid, "VehicleID"), X, 181);
	 	VehicleColor[GetVehicleID(GetPVarInt(playerid, "VehicleID"))][1] = 181;
	 	PlayerPlaySound(playerid, 1083, 0, 0, 0);
	    SetPVarInt(playerid, "ModShop_Farbe1", 2750);
	 	Preis = GetPVarInt(playerid, "ModShop_Farbe1");
	 	format(string, sizeof string, "$%i", Preis);
	 	PlayerTextDrawSetString(playerid, PlayerText:ModshopPreis[playerid], string);
	 	PlayerTextDrawShow(playerid, PlayerText:ModshopPreis[playerid]);
     	return 1;
  	}
  	if(playertextid == Farbauswahl[playerid][11])//Hellgelb
  	{
		KillTimer(RainbowCarTimer2);
     	RainbowColor[vehicleid] = 0;
	 	ChangeVehicleColor(GetPVarInt(playerid, "VehicleID"), X, 200);
	 	VehicleColor[GetVehicleID(GetPVarInt(playerid, "VehicleID"))][1] = 200;
	 	PlayerPlaySound(playerid, 1083, 0, 0, 0);
	    SetPVarInt(playerid, "ModShop_Farbe1", 2750);
	 	Preis = GetPVarInt(playerid, "ModShop_Farbe1");
	 	format(string, sizeof string, "$%i", Preis);
	 	PlayerTextDrawSetString(playerid, PlayerText:ModshopPreis[playerid], string);
	 	PlayerTextDrawShow(playerid, PlayerText:ModshopPreis[playerid]);
     	return 1;
  	}
  	if(playertextid == Farbauswahl[playerid][12])//Lila
  	{
	 	KillTimer(RainbowCarTimer2);
     	RainbowColor[vehicleid] = 0;
	 	ChangeVehicleColor(GetPVarInt(playerid, "VehicleID"), X, 171);
	 	VehicleColor[GetVehicleID(GetPVarInt(playerid, "VehicleID"))][1] = 171;
	 	PlayerPlaySound(playerid, 1083, 0, 0, 0);
	    SetPVarInt(playerid, "ModShop_Farbe1", 2750);
	 	Preis = GetPVarInt(playerid, "ModShop_Farbe1");
	 	format(string, sizeof string, "$%i", Preis);
	 	PlayerTextDrawSetString(playerid, PlayerText:ModshopPreis[playerid], string);
	 	PlayerTextDrawShow(playerid, PlayerText:ModshopPreis[playerid]);
     	return 1;
  	}
  	if(playertextid == Farbauswahl[playerid][13])//Dunkelgrün
  	{
	 	KillTimer(RainbowCarTimer2);
     	RainbowColor[vehicleid] = 0;
	 	ChangeVehicleColor(GetPVarInt(playerid, "VehicleID"), X, 234);
	 	VehicleColor[GetVehicleID(GetPVarInt(playerid, "VehicleID"))][1] = 234;
	 	PlayerPlaySound(playerid, 1083, 0, 0, 0);
	    SetPVarInt(playerid, "ModShop_Farbe1", 2750);
	 	Preis = GetPVarInt(playerid, "ModShop_Farbe1");
	 	format(string, sizeof string, "$%i", Preis);
	 	PlayerTextDrawSetString(playerid, PlayerText:ModshopPreis[playerid], string);
	 	PlayerTextDrawShow(playerid, PlayerText:ModshopPreis[playerid]);
     	return 1;
  	}
  	if(playertextid == Farbauswahl[playerid][14])//hässliches Gelb
  	{
	 	KillTimer(RainbowCarTimer2);
     	RainbowColor[vehicleid] = 0;
	 	ChangeVehicleColor(GetPVarInt(playerid, "VehicleID"),X, 77);
	 	VehicleColor[GetVehicleID(GetPVarInt(playerid, "VehicleID"))][1] = 77;
	 	PlayerPlaySound(playerid, 1083, 0, 0, 0);
	    SetPVarInt(playerid, "ModShop_Farbe1", 2750);
	 	Preis = GetPVarInt(playerid, "ModShop_Farbe1");
	 	format(string, sizeof string, "$%i", Preis);
	 	PlayerTextDrawSetString(playerid, PlayerText:ModshopPreis[playerid], string);
	 	PlayerTextDrawShow(playerid, PlayerText:ModshopPreis[playerid]);
     	return 1;
  	}
  	if(playertextid == Farbauswahl[playerid][15])//Pink
  	{
	 	KillTimer(RainbowCarTimer2);
     	RainbowColor[vehicleid] = 0;
	 	ChangeVehicleColor(GetPVarInt(playerid, "VehicleID"), X, 126);
	 	VehicleColor[GetVehicleID(GetPVarInt(playerid, "VehicleID"))][1] = 126;
	 	PlayerPlaySound(playerid, 1083, 0, 0, 0);
	    SetPVarInt(playerid, "ModShop_Farbe1", 2750);
	 	Preis = GetPVarInt(playerid, "ModShop_Farbe1");
	 	format(string, sizeof string, "$%i", Preis);
	 	PlayerTextDrawSetString(playerid, PlayerText:ModshopPreis[playerid], string);
	 	PlayerTextDrawShow(playerid, PlayerText:ModshopPreis[playerid]);
     	return 1;
  	}
  	if(playertextid == Farbauswahl[playerid][16])//Rosa
  	{
	 	KillTimer(RainbowCarTimer2);
     	RainbowColor[vehicleid] = 0;
	 	ChangeVehicleColor(GetPVarInt(playerid, "VehicleID"), X, 136);
	 	VehicleColor[GetVehicleID(GetPVarInt(playerid, "VehicleID"))][1] = 136;
	 	PlayerPlaySound(playerid, 1083, 0, 0, 0);
	    SetPVarInt(playerid, "ModShop_Farbe1", 2750);
	 	Preis = GetPVarInt(playerid, "ModShop_Farbe1");
	 	format(string, sizeof string, "$%i", Preis);
	 	PlayerTextDrawSetString(playerid, PlayerText:ModshopPreis[playerid], string);
	 	PlayerTextDrawShow(playerid, PlayerText:ModshopPreis[playerid]);
     	return 1;
  	}
  	if(playertextid == Farbauswahl[playerid][17])//keine Ahnung, dunkles Blau
  	{
		KillTimer(RainbowCarTimer2);
     	RainbowColor[vehicleid] = 0;
	 	ChangeVehicleColor(GetPVarInt(playerid, "VehicleID"), X, 205);
	 	VehicleColor[GetVehicleID(GetPVarInt(playerid, "VehicleID"))][1] = 205;
	 	PlayerPlaySound(playerid, 1083, 0, 0, 0);
	    SetPVarInt(playerid, "ModShop_Farbe1", 2750);
	 	Preis = GetPVarInt(playerid, "ModShop_Farbe1");
	 	format(string, sizeof string, "$%i", Preis);
	 	PlayerTextDrawSetString(playerid, PlayerText:ModshopPreis[playerid], string);
	 	PlayerTextDrawShow(playerid, PlayerText:ModshopPreis[playerid]);
     	return 1;
  	}
  	if(playertextid == Farbauswahl[playerid][18])//Gold
  	{
	 	KillTimer(RainbowCarTimer2);
     	RainbowColor[vehicleid] = 0;
	 	ChangeVehicleColor(GetPVarInt(playerid, "VehicleID"), X, 228);
	 	VehicleColor[GetVehicleID(GetPVarInt(playerid, "VehicleID"))][1] = 228;
	 	PlayerPlaySound(playerid, 1083, 0, 0, 0);
	    SetPVarInt(playerid, "ModShop_Farbe1", 3500);
	 	Preis = GetPVarInt(playerid, "ModShop_Farbe1");
	 	format(string, sizeof string, "$%i", Preis);
	 	PlayerTextDrawSetString(playerid, PlayerText:ModshopPreis[playerid], string);
	 	PlayerTextDrawShow(playerid, PlayerText:ModshopPreis[playerid]);
     	return 1;
  	}
  	if(playertextid == Farbauswahl[playerid][19])//Rainbow
  	{
	 	KillTimer(RainbowCarTimer2);
	 	RainbowCarTimer2 = SetTimerEx("RainbowCar2", 500, true, "%i, %i", playerid, vehicleid);
	 	VehicleColor[GetVehicleID(GetPVarInt(playerid, "VehicleID"))][1] = -1;
     	RainbowColor[vehicleid] = 1;
	 	PlayerPlaySound(playerid, 1083, 0, 0, 0);
	    SetPVarInt(playerid, "ModShop_Farbe1", 47500);
	 	Preis = GetPVarInt(playerid, "ModShop_Farbe1");
	 	format(string, sizeof string, "$%i", Preis);
	 	PlayerTextDrawSetString(playerid, PlayerText:ModshopPreis[playerid], string);
	 	PlayerTextDrawShow(playerid, PlayerText:ModshopPreis[playerid]);
     	return 1;
  	}
  }
  return 1;
}

AddModVehicleComponent(vehicleid, componentid)
{
   AddVehicleComponent(vehicleid, componentid);
   if(IsValidVehicle(GetVehicleID(vehicleid)))
   {
      for(new i=0; i < sizeof(VehicleMods[]); i++)
      {
         if(componentid == 1025 || componentid == 1073 || componentid == 1074 || componentid == 1075 || componentid == 1076 || componentid == 1077 || componentid == 1078 || componentid == 1079
         || componentid == 1080 || componentid == 1081 || componentid == 1082 || componentid == 1083 || componentid == 1084 || componentid == 1085 || componentid == 1096 || componentid == 1097
		 || componentid == 1098)
         {
            if(VehicleMods[GetVehicleID(vehicleid)][i] == 1025 || VehicleMods[GetVehicleID(vehicleid)][i] == 1073 || VehicleMods[GetVehicleID(vehicleid)][i] == 1074
			|| VehicleMods[GetVehicleID(vehicleid)][i] == 1075 || VehicleMods[GetVehicleID(vehicleid)][i] == 1076 || VehicleMods[GetVehicleID(vehicleid)][i] == 1077
			|| VehicleMods[GetVehicleID(vehicleid)][i] == 1078 || VehicleMods[GetVehicleID(vehicleid)][i] == 1079 || VehicleMods[GetVehicleID(vehicleid)][i] == 1080
			|| VehicleMods[GetVehicleID(vehicleid)][i] == 1081 || VehicleMods[GetVehicleID(vehicleid)][i] == 1082 || VehicleMods[GetVehicleID(vehicleid)][i] == 1083
			|| VehicleMods[GetVehicleID(vehicleid)][i] == 1084 || VehicleMods[GetVehicleID(vehicleid)][i] == 1085 || VehicleMods[GetVehicleID(vehicleid)][i] == 1096
			|| VehicleMods[GetVehicleID(vehicleid)][i] == 1097 || VehicleMods[GetVehicleID(vehicleid)][i] == 1098)
			{
               VehicleMods[GetVehicleID(vehicleid)][i] = componentid;
               SaveVehicle(GetVehicleID(vehicleid));//hier
               return 1;
			}
         }
         if(VehicleMods[GetVehicleID(vehicleid)][i] == 0)
	     {
            VehicleMods[GetVehicleID(vehicleid)][i] = componentid;
            SaveVehicle(GetVehicleID(vehicleid));//hier
            return 1;
	     }
	  }
   }
   return 0;
}

forward RainbowCar1(playerid, vehicleid);
public RainbowCar1(playerid, vehicleid)
{
   new X, Y;
   GetVehicleColor(vehicleid, X, Y);
   ChangeVehicleColor(vehicleid, RandomColor(), Y);
   return 1;
}

forward RainbowCar2(playerid, vehicleid);
public RainbowCar2(playerid, vehicleid)
{
   new X, Y;
   GetVehicleColor(vehicleid, X, Y);
   ChangeVehicleColor(vehicleid, X, RandomColor());
   return 1;
}

stock GetVehicleCompatibleSpoiler(vehicleid)
{
   switch(GetVehicleModel(vehicleid))
   {
	  case 565, 559, 562, 560, 561, 558, 401, 518, 527, 415, 585, 410, 603, 426, 436, 405, 580, 439, 550, 549, 420, 540, 529, 542, 491, 421, 546, 517, 551, 418, 516, 404, 489, 505, 496, 589, 492, 547:
	  return 1;
   }
   return 0;
}

stock GetVehicleCompatibleBumperVorn(vehicleid)
{
   switch(GetVehicleModel(vehicleid))
   {
	  case 565, 559, 562, 560, 561, 558, 536, 575, 534, 535, 567, 576: return 1;
   }
   return 0;
}

stock GetVehicleCompatibleBumper2(vehicleid)
{
   switch(GetVehicleModel(vehicleid))
   {
	  case 565, 559, 562, 560, 561, 558, 536, 575, 534, 567, 576: return 1;
   }
   return 0;
}

stock GetVehicleCompatibleAuspuff(vehicleid)
{
   switch(GetVehicleModel(vehicleid))
   {
	  case 565, 559, 562, 560, 561, 558, 496, 422, 401, 518, 527, 542, 589, 585, 400, 517, 410, 551, 500, 418, 516, 404, 603, 600, 436, 547, 489, 505, 405, 580, 550, 549, 540, 491, 478, 421, 529,
	  477, 426, 420, 415, 546, 536, 575, 534, 535, 567, 576: return 1;
   }
   return 0;
}

stock GetVehicleCompatibleMotorhaube(vehicleid)
{
   switch(GetVehicleModel(vehicleid))
   {
	  case 401, 518, 589, 492, 551, 600, 426, 550, 420, 478, 546, 516, 489, 505, 540, 549, 529, 496, 585, 603, 547, 439, 542, 517: return 1;
   }
   return 0;
}

stock GetVehicleCompatibleLackierung(vehicleid)
{
   switch(GetVehicleModel(vehicleid))
   {
	  case 562, 565, 559, 561, 560, 558, 536, 575, 534, 567, 535, 576: return 1;
   }
   return 0;
}

stock GetVehicleCompatibleDach(vehicleid)
{
   switch(GetVehicleModel(vehicleid))
   {
      case 565, 559, 562, 560, 561, 558, 469, 401, 518, 589, 585, 492, 546, 551, 418, 603, 600, 426, 436, 489, 505, 580, 550, 540, 529, 477, 536, 567: return 1;
   }
   return 0;
}

stock GetVehicleCompatibleLicht(vehicleid)
{
   switch(GetVehicleModel(vehicleid))
   {
      case 422, 401, 518, 589, 585, 400, 410, 500, 404, 600, 436, 489, 505, 439, 478, 546, 603, 540: return 1;
   }
   return 0;
}

stock GetVehicleCompatibleSchweller(vehicleid)
{
   switch(GetVehicleModel(vehicleid))
   {
      case 565, 559, 562, 560, 561, 558, 496, 422, 401, 518, 527, 415, 589, 585, 546, 517, 410, 516, 404, 603, 600, 436, 580, 439, 549, 540, 491, 529, 477, 536, 575, 534, 535, 567, 576: return 1;
   }
   return 0;
}

stock AddObjectToModCar(partid, playerid, vehicleid)
{
   TogglePlayerSpectating(playerid, 0);
   SetPlayerPos(playerid, 0, 0, 0),
   PlayerTextDrawHide(playerid, NextModshopItem[playerid]);
   PlayerTextDrawHide(playerid, LastModshopItem[playerid]);
   PlayerTextDrawHide(playerid, TuningBackground[playerid]);
   PlayerTextDrawHide(playerid, ModName[playerid]);
   PlayerTextDrawHide(playerid, ModName_[playerid]);
   PlayerTextDrawHide(playerid, ModObject[playerid]);
   PlayerTextDrawHide(playerid, Farbauswahl[playerid][0]);
   PlayerTextDrawHide(playerid, Farbauswahl[playerid][1]);
   PlayerTextDrawHide(playerid, Farbauswahl[playerid][2]);
   PlayerTextDrawHide(playerid, Farbauswahl[playerid][3]);
   PlayerTextDrawHide(playerid, Farbauswahl[playerid][4]);
   PlayerTextDrawHide(playerid, Farbauswahl[playerid][5]);
   PlayerTextDrawHide(playerid, Farbauswahl[playerid][6]);
   PlayerTextDrawHide(playerid, Farbauswahl[playerid][7]);
   PlayerTextDrawHide(playerid, Farbauswahl[playerid][8]);
   PlayerTextDrawHide(playerid, Farbauswahl[playerid][9]);
   PlayerTextDrawHide(playerid, Farbauswahl[playerid][10]);
   PlayerTextDrawHide(playerid, Farbauswahl[playerid][11]);
   PlayerTextDrawHide(playerid, Farbauswahl[playerid][12]);
   PlayerTextDrawHide(playerid, Farbauswahl[playerid][13]);
   PlayerTextDrawHide(playerid, Farbauswahl[playerid][14]);
   PlayerTextDrawHide(playerid, Farbauswahl[playerid][15]);
   PlayerTextDrawHide(playerid, Farbauswahl[playerid][16]);
   PlayerTextDrawHide(playerid, ModDone[playerid]);
   PlayerTextDrawHide(playerid, ModDone_[playerid]);
   PlayerTextDrawHide(playerid, TuningObjectBackground[playerid]);
   TextDrawHideForPlayer(playerid, CustomModShopObjectLeft);
   TextDrawHideForPlayer(playerid, CustomModShopObjectRight);
   PutPlayerInVehicle(playerid, vehicleid, 0);
   new ModShopObject;
   ModShopObject = CreateObject(partid, 0.0, 0.0, 0.0, 0.0, 0.0, 89.8974, 300.0);
   SetObjectNoCameraCol(ModShopObject);
   GetVehiclePos(vehicleid, ModObjectX, ModObjectY, ModObjectZ);
   SetObjectPos(ModShopObject, ModObjectX, ModObjectY, ModObjectZ);
   ModObjectX = 0.0; ModObjectY = 0.0; ModObjectZ = 0.0;
   CancelSelectTextDraw(playerid);
   SetTimerEx("EditModShopCarObject", 100, false, "iifff", playerid, ModShopObject, 0);
   TogglePlayerSpectating(playerid, 1);
   PlayerSpectateVehicle(playerid, vehicleid, SPECTATE_MODE_NORMAL);//hier xenia toggleplayerspectate
}

forward EditModShopCarObject(playerid, objectid, rotate);
public EditModShopCarObject(playerid, objectid, rotate)
{
#define KEY_AIM KEY_HANDBRAKE
   new string[90];
   new Keys, ud, lr;
   GetPlayerKeys(playerid,Keys,ud,lr);
   if(lr == KEY_RIGHT)
   {
	  if(rotate)
	  {
         ModObjectrX = ModObjectrX + 1;
	  }
	  else
	  {
         ModObjectX = ModObjectX + 0.025;
	  }
   }
   if(lr == KEY_LEFT)
   {
	  if(rotate)
	  {
         ModObjectrX = ModObjectrX - 1;
	  }
	  else
	  {
         ModObjectX = ModObjectX - 0.025;
	  }
   }
   if(ud == KEY_UP)
   {
	  if(rotate)
	  {
         ModObjectrY = ModObjectrY + 1;
	  }
	  else
	  {
         ModObjectY = ModObjectY + 0.025;
	  }
   }
   if(ud == KEY_DOWN)
   {
	  if(rotate)
	  {
         ModObjectrY = ModObjectrY - 1;
	  }
	  else
	  {
         ModObjectY = ModObjectY - 0.025;
	  }
   }
   if(Keys & KEY_AIM)
   {
	  if(rotate)
	  {
         ModObjectrZ = ModObjectrZ + 1;
	  }
	  else
	  {
         ModObjectZ = ModObjectZ + 0.025;
	  }
   }
   if(Keys & KEY_FIRE)
   {
	  if(rotate)
	  {
         ModObjectrZ = ModObjectrZ - 1;
	  }
	  else
	  {
         ModObjectZ = ModObjectZ - 0.025;
	  }
   }
   if(Keys & KEY_JUMP)
   {
	  if(rotate)
	  {
	     rotate = 0;
	     SendClientMessage(playerid, Weis, "Linear");
	  }
	  else
	  {
	     rotate = 1;
	     SendClientMessage(playerid, Weis, "Rotate");
	  }
   }
   if(Keys & KEY_SPRINT)
   {
      TogglePlayerSpectating(playerid, 0);//TogglePlayerSpectating wird ausgeschaltet
      PutPlayerInVehicle(playerid, GetPVarInt(playerid, "VehicleID"), 0);
      format(string, sizeof string, "objectid: %i", objectid);
      DebugMessage(playerid, string);
      PlayerTextDrawShow(playerid, TuningBackground[playerid]);
      PlayerTextDrawShow(playerid, ModName[playerid]);
      PlayerTextDrawShow(playerid, ModName_[playerid]);
      PlayerTextDrawHide(playerid, ModObject[playerid]);
      PlayerTextDrawShow(playerid, Farbauswahl[playerid][0]);
      PlayerTextDrawShow(playerid, Farbauswahl[playerid][1]);
      PlayerTextDrawShow(playerid, Farbauswahl[playerid][2]);
      PlayerTextDrawShow(playerid, Farbauswahl[playerid][3]);
      PlayerTextDrawShow(playerid, Farbauswahl[playerid][4]);
      PlayerTextDrawShow(playerid, Farbauswahl[playerid][5]);
      PlayerTextDrawShow(playerid, Farbauswahl[playerid][6]);
      PlayerTextDrawShow(playerid, Farbauswahl[playerid][7]);
      PlayerTextDrawShow(playerid, Farbauswahl[playerid][8]);
      PlayerTextDrawShow(playerid, Farbauswahl[playerid][9]);
      PlayerTextDrawShow(playerid, Farbauswahl[playerid][10]);
      PlayerTextDrawShow(playerid, Farbauswahl[playerid][11]);
      PlayerTextDrawShow(playerid, Farbauswahl[playerid][12]);
      PlayerTextDrawShow(playerid, Farbauswahl[playerid][13]);
      PlayerTextDrawShow(playerid, Farbauswahl[playerid][14]);
      PlayerTextDrawShow(playerid, Farbauswahl[playerid][15]);
      PlayerTextDrawShow(playerid, Farbauswahl[playerid][16]);
      PlayerTextDrawShow(playerid, ModDone[playerid]);
      PlayerTextDrawShow(playerid, ModDone_[playerid]);
      PlayerTextDrawShow(playerid, TuningObjectBackground[playerid]);
      TextDrawShowForPlayer(playerid, CustomModShopObjectLeft);
      TextDrawShowForPlayer(playerid, CustomModShopObjectRight);//?
	  InterpolateCameraPos(playerid, 606.746948+modshoppos, -7.408711+modshoppos, 1003.267333, 606.746948+modshoppos, -7.408711+modshoppos, 1003.267333, 1000);
	  InterpolateCameraLookAt(playerid, 611.242797+modshoppos, -9.439126+modshoppos, 1002.452026, 611.242797+modshoppos, -9.439126+modshoppos, 1002.452026, 1000);
	  RepairVehicle(GetPVarInt(playerid, "VehicleID"));
      format(string, sizeof string, "%i %f %f %f", ModObjectrX, ModObjectrY, ModObjectrZ);
	  SetTimerEx("RestoreModShop", 50, false, "i", playerid);
      SendClientMessage(playerid, Weis, string);
      if(!IsValidVehicle(GetVehicleID(GetPVarInt(playerid, "VehicleID")))) return 1;
      format(string, sizeof string, "%i %f %f %f", GetObjectModel(objectid), ModObjectX, ModObjectY, ModObjectZ);
      SendClientMessage(playerid, Hellrot, string);
      new count = 0;
	  for(new i=1; i < 15; i++)
	  {
	     if(strlen(VehicleObjekte[GetVehicleID(GetPVarInt(playerid, "VehicleID"))][count]) > 0)
		 {
		    count++;
		 }
	  }
      VehicleObjekte[GetVehicleID(GetPVarInt(playerid, "VehicleID"))][count] = string;//warte
      SaveVehicle(GetVehicleID(GetPVarInt(playerid, "VehicleID")));
      ModObjectX = 0.0; ModObjectY = 0.0; ModObjectZ = 0.0;
      ModObjectrX = 0.0; ModObjectrY = 0.0; ModObjectrZ = 0.0;//hier
      return 1;
   }
   AttachObjectToVehicle(objectid, GetPVarInt(playerid, "VehicleID"), ModObjectX, ModObjectY, ModObjectZ, ModObjectrX, ModObjectrY, ModObjectrZ);
   format(string, sizeof string, "Object Pos:  %f, %f, %f", ModObjectX, ModObjectY, ModObjectZ);//hier passts, beim speichern nicht
   SendClientMessage(playerid, Weis, string);
   format(string, sizeof string, "Object Rot:  %f, %f, %f", ModObjectrX, ModObjectrY, ModObjectrZ);
   SendClientMessage(playerid, Weis, string);
   SetTimerEx("EditModShopCarObject", 100, false, "iifff", playerid, objectid, rotate);
   return 1;
}

forward RestoreModShop(playerid);
public RestoreModShop(playerid)
{
   Speedometer_Disable(playerid);
   SelectTextDraw(playerid, TextdrawFarbe);
   return 1;
}

forward ModRainbowCar(playerid);
public ModRainbowCar(playerid)
{
   PlayerTextDrawSetPreviewModel(playerid, ModObject[playerid], GetVehicleModel(GetPVarInt(playerid, "VehicleID")));
   PlayerTextDrawSetPreviewRot(playerid, ModObject[playerid], -22.500000, 0.000000, 22.500000, 1.000000);
   PlayerTextDrawSetPreviewVehCol(playerid, ModObject[playerid], RandomColor(), RandomColor());
   PlayerTextDrawShow(playerid, PlayerText:ModObject[playerid]);
   return 1;
}

forward ModShopTextColor(playerid);
public ModShopTextColor(playerid)
{
PlayerTextDrawColor(playerid, PlayerText:Farbauswahl[playerid][19], RandomTextdrawColor());
PlayerTextDrawShow(playerid, PlayerText:Farbauswahl[playerid][19]);
return 1;
}

stock RandomTextdrawColor()
{
      new Wikaa = random(20);
      switch (Wikaa)
      {
            case 1: return 0xFF0000FF;
            case 2: return 0xFFFFFFFF;
            case 3: return 0x00FFFFFF;
            case 4: return 0xC0C0C0FF;
            case 5: return 0x0000FFFF;
            case 6: return 0x808080FF;
            case 7: return 0x0000A0FF;
            case 8: return 0x000000FF;
            case 9: return 0xADD8E6FF;
            case 10: return 0xFFA500FF;
            case 11: return 0x800080FF;
            case 12: return 0xA52A2AFF;
            case 13: return 0xFFFF00FF;
            case 14: return 0x800000FF;
            case 15: return 0x00FF00FF;
            case 16: return 0x008000FF;
            case 17: return 0xFF00FFFF;
            case 18: return 0x808000FF;
            case 19: return 0x00FF00FF;
      }
return 0xC0C0C0FF;
}

public OnPlayerClickTextDraw(playerid, Text:clickedid)
{
	       if(clickedid == Schluessel[playerid][5])
	       {
		      TextDrawHideForPlayer(playerid, Schluessel[playerid][0]);
		      TextDrawHideForPlayer(playerid, Schluessel[playerid][1]);
		      TextDrawHideForPlayer(playerid, Schluessel[playerid][2]);
		      TextDrawHideForPlayer(playerid, Schluessel[playerid][3]);
		      TextDrawHideForPlayer(playerid, Schluessel[playerid][4]);
		      TextDrawHideForPlayer(playerid, Schluessel[playerid][5]);
		      TextDrawHideForPlayer(playerid, Schluessel[playerid][6]);
		      TextDrawHideForPlayer(playerid, FahrzeugBild[playerid]);
		      TextDrawHideForPlayer(playerid, Aufsperren[playerid]);
		      TextDrawHideForPlayer(playerid, Zusperren[playerid]);
		      TextDrawHideForPlayer(playerid, Aufsperren_[playerid][0]);
		      TextDrawHideForPlayer(playerid, Aufsperren_[playerid][1]);
		      TextDrawHideForPlayer(playerid, Aufsperren_[playerid][2]);
		      TextDrawHideForPlayer(playerid, Zusperren_[playerid][0]);
		      TextDrawHideForPlayer(playerid, Zusperren_[playerid][1]);
		      TextDrawHideForPlayer(playerid, Zusperren_[playerid][2]);
		      TextDrawHideForPlayer(playerid, Parken[playerid]);
		      TextDrawHideForPlayer(playerid, Parken_[playerid]);
		      TextDrawHideForPlayer(playerid, FahrzeugParkBild[playerid]);
              TextDrawHideForPlayer(playerid, MoreButton[playerid]);
              TextDrawHideForPlayer(playerid, VehicleName[playerid]);
		      TextDrawHideForPlayer(playerid, UNDEFINED[playerid]);
		      CancelSelectTextDraw(playerid);
	       }
           else if(clickedid == Aufsperren[playerid])
           {
	         new vehicleid;
	         if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
		     {
			   	vehicleid = GetPlayerVehicleID(playerid);
		     }
	         else
		     {
			   	vehicleid = GetClosestVehicle(playerid);
                if(!IsPlayerInRangeOfVehicle(playerid, vehicleid, 15.0)) vehicleid = 0;
		     }
	         if(!vehicleid) return SendClientMessage(playerid, Hellrot, "You shouldn't be able to see this... maybe its  a bug.");
	         new id = GetVehicleID(vehicleid);
	         for (new i = 0; i < MAX_PLAYERS; i++)
			 if (VehicleLock[id] == 1)
	         {
		       	VehicleLock[id] = 0;
	            SaveVehicle(id);
                SendInfoText(playerid, "DOORS UNLOCKED");
	            SetVehicleParamsForPlayer(vehicleid, i, 0, 0);
	            BlinkerL[vehicleid] = BlinkerL[vehicleid] + 2;
	            BlinkerR[vehicleid] = BlinkerR[vehicleid] + 2;
	            AddBlinkerToCar(vehicleid);//hier ?
	            return 1;
	         }
	         else
	         {
		       	SendClientMessage(playerid, Hellrot, "The car is already unlocked");
		       	return 1;
             }
           }
           else if(clickedid == Zusperren[playerid])
           {
		     new vehicleid;
	         if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
		     {
			   	vehicleid = GetPlayerVehicleID(playerid);
		     }
	         else
		     {
		        vehicleid = GetClosestVehicle(playerid);
                if(!IsPlayerInRangeOfVehicle(playerid, vehicleid, 15.0)) vehicleid = 0;
			 }
	         if(!vehicleid) return SendClientMessage(playerid, Hellrot, "You shouldn't be able to see this... maybe its  a bug.");
	         new id = GetVehicleID(vehicleid);
			 for (new i = 0; i < MAX_PLAYERS; i++)
			 if (VehicleLock[id] == 0)
	         {
		       	VehicleLock[id] = 1;
	            SaveVehicle(id);
                SendInfoText(playerid, "DOORS LOCKED");
		       	if(i != playerid)
		       	{
	               SetVehicleParamsForPlayer(vehicleid, i, 0, 1);
		       	}
	            BlinkerL[vehicleid] = BlinkerL[vehicleid] + 4;
	            BlinkerR[vehicleid] = BlinkerR[vehicleid] + 4;
	            AddBlinkerToCar(vehicleid);
	            return 1;
	         }
	         else
	         {
		       	SendClientMessage(playerid, Hellrot, "The car is already locked");
		       	return 1;
             }

	       }
           else if(clickedid == Parken_[playerid])
           {
		     new id;
	         if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
		     {
			   	id = GetPlayerVehicleID(playerid);
		     }
	         else
		     {
		        id = GetClosestVehicle(playerid);
                if(!IsPlayerInRangeOfVehicle(playerid, id, 25.0)) id = -1;
			 }
	         if(!id) return SendClientMessage(playerid, Hellrot, "You shouldn't be able to see this... probably a bug.");
	         new vehicleid = GetVehicleID(id);
		     GetVehiclePos(VehicleID[vehicleid], VehiclePos[vehicleid][0], VehiclePos[vehicleid][1], VehiclePos[vehicleid][2]);
		     GetVehicleZAngle(VehicleID[vehicleid], VehiclePos[vehicleid][3]);
		     VehicleInterior[vehicleid] = GetPlayerInterior(playerid);
		     VehicleWorld[vehicleid] = GetPlayerVirtualWorld(playerid);
		     if(IsPlayerInAnyVehicle(playerid) && (GetPlayerState(playerid) == 2))
		     {
		        UpdateVehicle(vehicleid, 1);
		        PutPlayerInVehicle(playerid, VehicleID[vehicleid], 0);
		     }
		     else
		     {
		        UpdateVehicle(vehicleid, 1);
		     }
		     SaveVehicle(vehicleid);
		     new string[50];
             format(string, sizeof string, "You parked your %s here.", VehicleNames[VehicleModel[vehicleid]-400]);
		     SendClientMessage(playerid, Hellblau, string);
		   }
	       return 0;
}

stock AddBlinkerToCar(vehicleid)
{
   new Float:X, Float:Z, Float:Y, Float: VZ, Float: HZ;
   GetVehicleModelInfo(GetVehicleModel(vehicleid), VEHICLE_MODEL_INFO_FRONT_BUMPER_Z, X, Y, VZ);
   GetVehicleModelInfo(GetVehicleModel(vehicleid), VEHICLE_MODEL_INFO_REAR_BUMPER_Z, X, Y, HZ);
   GetVehicleModelInfo(GetVehicleModel(vehicleid), VEHICLE_MODEL_INFO_SIZE, X, Y, Z);
   if (BlinkerL[vehicleid] == 1 && BlinkerR[vehicleid] == 1)
   {
      DestroyAllCarBlinkers(vehicleid, 0);
      BlinkerVL[vehicleid] = CreateObject(19294, 0, 0, 0, 0, 0, 0, 100);
      AttachObjectToVehicle(BlinkerVL[vehicleid], vehicleid, -X/2, Y/2, VZ, 0, 0, 0);
      BlinkerHL[vehicleid] = CreateObject(19294, 0, 0, 0, 0, 0, 0, 100);
      AttachObjectToVehicle(BlinkerHL[vehicleid], vehicleid, -X/2, -Y/2, HZ, 0, 0, 0);
      BlinkerVR[vehicleid] = CreateObject(19294, 0, 0, 0, 0, 0, 0, 100);
      AttachObjectToVehicle(BlinkerVR[vehicleid], vehicleid, X/2, Y/2, VZ, 0, 0, 0);
      BlinkerHR[vehicleid] = CreateObject(19294, 0, 0, 0, 0, 0, 0, 100);
      AttachObjectToVehicle(BlinkerHR[vehicleid], vehicleid, X/2, -Y/2, HZ, 0, 0, 0);
   }
   else if (BlinkerR[vehicleid] == 1)
   {
      DestroyObject(BlinkerVR[vehicleid]);
      DestroyObject(BlinkerHR[vehicleid]);
      BlinkerVR[vehicleid] = CreateObject(19294, 0, 0, 0, 0, 0, 0, 100);
      AttachObjectToVehicle(BlinkerVR[vehicleid], vehicleid, X/2, Y/2, VZ, 0, 0, 0);
      BlinkerHR[vehicleid] = CreateObject(19294, 0, 0, 0, 0, 0, 0, 100);
      AttachObjectToVehicle(BlinkerHR[vehicleid], vehicleid, X/2, -Y/2, HZ, 0, 0, 0);
   }
   else if (BlinkerL[vehicleid] == 1)
   {
      DestroyObject(BlinkerVL[vehicleid]);
      DestroyObject(BlinkerHL[vehicleid]);
      BlinkerVL[vehicleid] = CreateObject(19294, 0, 0, 0, 0, 0, 0, 100);
      AttachObjectToVehicle(BlinkerVL[vehicleid], vehicleid, -X/2, Y/2, VZ, 0, 0, 0);
      BlinkerHL[vehicleid] = CreateObject(19294, 0, 0, 0, 0, 0, 0, 100);
      AttachObjectToVehicle(BlinkerHL[vehicleid], vehicleid, -X/2, -Y/2, HZ, 0, 0, 0);
   }
   else if (BlinkerL[vehicleid] > 1 && BlinkerL[vehicleid] < 4 && BlinkerR[vehicleid] > 1 && BlinkerR[vehicleid] < 4)//aufsperren - kurz blinken
   {
      DestroyAllCarBlinkers(vehicleid ,0);
      BlinkerVL[vehicleid] = CreateObject(19294, 0, 0, 0, 0, 0, 0, 100);
      AttachObjectToVehicle(BlinkerVL[vehicleid], vehicleid, -X/2, Y/2, VZ, 0, 0, 0);
      BlinkerHL[vehicleid] = CreateObject(19294, 0, 0, 0, 0, 0, 0, 100);
      AttachObjectToVehicle(BlinkerHL[vehicleid], vehicleid, -X/2, -Y/2, HZ, 0, 0, 0);
      BlinkerVR[vehicleid] = CreateObject(19294, 0, 0, 0, 0, 0, 0, 100);
      AttachObjectToVehicle(BlinkerVR[vehicleid], vehicleid, X/2, Y/2, VZ, 0, 0, 0);
      BlinkerHR[vehicleid] = CreateObject(19294, 0, 0, 0, 0, 0, 0, 100);
      AttachObjectToVehicle(BlinkerHR[vehicleid], vehicleid, X/2, -Y/2, HZ, 0, 0, 0);
	  BlinkerL[vehicleid] = BlinkerL[vehicleid] - 2;
	  BlinkerR[vehicleid] = BlinkerR[vehicleid] - 2;
      SetTimerEx("DestroyAllCarBlinkers", 2500, false, "%i, %i", vehicleid, 1);
   }
   else if (BlinkerL[vehicleid] > 3 && BlinkerL[vehicleid] < 6 && BlinkerR[vehicleid] > 3 && BlinkerR[vehicleid] < 6)//zusperren - lang blinken
   {
      DestroyAllCarBlinkers(vehicleid, 0);
      BlinkerVL[vehicleid] = CreateObject(19294, 0, 0, 0, 0, 0, 0, 100);
      AttachObjectToVehicle(BlinkerVL[vehicleid], vehicleid, -X/2, Y/2, VZ, 0, 0, 0);
      BlinkerHL[vehicleid] = CreateObject(19294, 0, 0, 0, 0, 0, 0, 100);
      AttachObjectToVehicle(BlinkerHL[vehicleid], vehicleid, -X/2, -Y/2, HZ, 0, 0, 0);
      BlinkerVR[vehicleid] = CreateObject(19294, 0, 0, 0, 0, 0, 0, 100);
      AttachObjectToVehicle(BlinkerVR[vehicleid], vehicleid, X/2, Y/2, VZ, 0, 0, 0);
      BlinkerHR[vehicleid] = CreateObject(19294, 0, 0, 0, 0, 0, 0, 100);
      AttachObjectToVehicle(BlinkerHR[vehicleid], vehicleid, X/2, -Y/2, HZ, 0, 0, 0);
	  BlinkerL[vehicleid] = BlinkerL[vehicleid] - 4;
	  BlinkerR[vehicleid] = BlinkerR[vehicleid] - 4;
      SetTimerEx("DestroyAllCarBlinkers", 1000, false, "%i, %i", vehicleid, 1);
   }
   return 0;
}

forward DestroyAllCarBlinkers(vehicleid, restart);
public DestroyAllCarBlinkers(vehicleid, restart)
{
   DestroyObject(BlinkerVR[vehicleid]);
   DestroyObject(BlinkerHR[vehicleid]);
   DestroyObject(BlinkerVL[vehicleid]);
   DestroyObject(BlinkerHL[vehicleid]);
   if(restart)
   {
      AddBlinkerToCar(vehicleid);
   }
   return 0;
}
   
public OnPlayerExitVehicle(playerid, vehicleid)
{
	new alarm, doors, hood, trunk, objective;
	GetVehicleParamsEx(vehicleid, alarm, alarm, alarm, doors, hood, trunk, objective);
	SetVehicleParamsEx(vehicleid, 0, 0, alarm, doors, hood, trunk, objective);
	new string[50];
    new id = GetVehicleID(vehicleid);
	if(!IsValidVehicle(id)) return 0;
	if(VehicleCreated[id] <= 1) return 0;
    new engfailure = random(500/(VehicleCheckEngine[id]+1));
	if (engfailure == 1)
	{
	   VehicleCheckEngine[id] = VehicleCheckEngine[id]+1;
	   SaveVehicle(id);
	}
	if (VehicleBatteryLight[id] > 0)
    {
	   VehicleBatteryLight[id] = VehicleBatteryLight[id] +1;
	}
    new altfailure = random(375/(VehicleBatteryLight[id]+1));
	if (altfailure == 1)
	{
	   VehicleBatteryLight[id] = VehicleBatteryLight[id]+1;
	   SaveVehicle(id);
	}
    format(string, sizeof string, "Motorfehler: %i Stufe: %i", engfailure, VehicleCheckEngine[id]);
    DebugMessage(playerid, string);
    format(string, sizeof string, "Batteriefehler: %i Stufe: %i", altfailure, VehicleBatteryLight[id]);
    DebugMessage(playerid, string);
    return 1;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	if(!ispassenger)
	{
		new id = GetVehicleID(vehicleid);
		if(!IsValidVehicle(id))
		{
	       if (NVehicleLocked[vehicleid] == 1)
	       {
	          GetPlayerName(playerid, Sname, sizeof(Sname));
	          if(strcmp(VehicleOwner[id], Sname) == 0)
	          {
	             SetVehicleParamsForPlayer(vehicleid, playerid, 0, 0);
	             DebugMessage(playerid, "You are owner");
	          }
	          else
	          {
	             SetVehicleParamsForPlayer(vehicleid, playerid, 0, 1);
	             DebugMessage(playerid, "You are not owner");
	             RemovePlayerFromVehicle(playerid);
	          }
	       }
		
		}
		if(!IsValidVehicle(id)) return 1;
	    Fuel[vehicleid] = VehicleFuel[id];
	    if (VehicleLock[id] == 1)
	    {
	      GetPlayerName(playerid, Sname, sizeof(Sname));
	      if(strcmp(VehicleOwner[id], Sname) == 0)
	      {
	        SetVehicleParamsForPlayer(id, playerid, 0, 0);
	        DebugMessage(playerid, "You are owner");
		  }
	      else if(strcmp(CarKeyOwner[id], Sname) == 0)
	      {
	        SetVehicleParamsForPlayer(id, playerid, 0, 0);
	        DebugMessage(playerid, "You are CarKey owner");
		  }
		  else
		  {
	        SetVehicleParamsForPlayer(id, playerid, 0, 1);
	        DebugMessage(playerid, "You are not owner");
	        RemovePlayerFromVehicle(playerid);
		  }
	    }
	}
	if (vehicleid == TrackCar[playerid])
	{
          new string[50];
          format(string, sizeof string, "Looks like you found your %s.", VehicleNames[VehicleModel[TrackCar[playerid]]-400]);
          SendClientMessage(playerid, Hellgrün, string);
          TrackCar[playerid] = 0;
          KillTimer(tracktimer);
		  DisablePlayerCheckpoint(playerid);
	}
    if (vehicleid == TrackNewCar[playerid])
    {
		  SetVehicleParamsForPlayer(TrackNewCar[playerid], playerid, 0, 0);
		  {
            new string[50];
		    format(string, sizeof string, "Have fun with your new car!");
		    SendClientMessage(playerid, Hellblau, string);
		  }
          TrackNewCar[playerid] = 0;
    }
	return 1;
}

forward Blinker(vehicleid, playerid);
public Blinker(vehicleid, playerid)
{
PlayerTextDrawHide(playerid, PlayerText:BlinkerLinks[playerid][0]);
PlayerTextDrawHide(playerid, PlayerText:BlinkerLinks[playerid][1]);
PlayerTextDrawHide(playerid, PlayerText:BlinkerRechts[playerid][0]);
PlayerTextDrawHide(playerid, PlayerText:BlinkerRechts[playerid][1]);
SetTimerEx("Blinker2", 400, false, "%i %i", vehicleid, playerid);
return 1;
}

forward Blinker2(vehicleid, playerid);
public Blinker2(vehicleid, playerid)
{
  if(GetPVarInt(playerid, "TachoHide") == 1) return 1;
  if (BlinkerR[vehicleid] == 1 && BlinkerL[vehicleid] == 1)
  {
	    if(IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER && GetPlayerVehicleID(playerid) == vehicleid)
	    {
           PlayerTextDrawShow(playerid, PlayerText:BlinkerRechts[playerid][0]);
           PlayerTextDrawShow(playerid, PlayerText:BlinkerRechts[playerid][1]);
           PlayerTextDrawShow(playerid, PlayerText:BlinkerLinks[playerid][0]);
           PlayerTextDrawShow(playerid, PlayerText:BlinkerLinks[playerid][1]);
	    }
	    KillTimer(BlinkerTimer);
	    BlinkerTimer = SetTimerEx("Blinker", 400, false, "%i, %i", vehicleid, playerid);
  }
  else if (BlinkerL[vehicleid] == 1)
  {
	    BlinkerTimer = SetTimerEx("Blinker", 400, false, "%i, %i", vehicleid, playerid);
	    if(IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER && GetPlayerVehicleID(playerid) == vehicleid)
	    {
           PlayerTextDrawShow(playerid, PlayerText:BlinkerLinks[playerid][0]);
           PlayerTextDrawShow(playerid, PlayerText:BlinkerLinks[playerid][1]);
	    }
  }
  else if (BlinkerR[vehicleid] == 1)
  {
	    BlinkerTimer = SetTimerEx("Blinker", 400, false, "%i, %i", vehicleid, playerid);
	    if(IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER && GetPlayerVehicleID(playerid) == vehicleid)
	    {
            PlayerTextDrawShow(playerid, PlayerText:BlinkerRechts[playerid][0]);
           PlayerTextDrawShow(playerid, PlayerText:BlinkerRechts[playerid][1]);
	    }
  }
  return 1;
}

stock IsPlayerDriver(playerid)
{
   return (IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER);
}

stock HealthColor(Float:percentage)
{
   new string[5];
   if (percentage<= 25)
	   format(string,sizeof(string), "r");
   else if (percentage <= 75)
	   format(string,sizeof(string), "y");
   else
	   format(string,sizeof(string), "g");
   return string;
}

stock SpeedColor(Float:speeed, playerid)
{
   new string[5];
   if (IsPlayerIn50Zone(speeed, playerid))
   {
       format(string,sizeof(string), "r");
   }
   else if (IsPlayerIn70Zone(speeed, playerid))
   {
       format(string,sizeof(string), "r");
   }
   else
   {
       format(string,sizeof(string), "");
   }
return string;
}

stock FuelColor(Float:fuel)
{
   new string[5];
   if (fuel >=15)
   {
	   format(string, sizeof(string), "w");
   }
   else
   {
	   format(string,sizeof(string), "r");
   }
   return string;
}

stock IsPlayerInRangeOf50Blitzer(Geschwindigkeit,playerid)
{
if(GetPVarInt(playerid, "Blitzertimer") == 0)
  {
  if (Geschwindigkeit >=55)
    {
    if (Player50BZone(playerid)==1)
       {
	   SetPVarInt(playerid, "Blitzertimer", 1);
	   ChangePlayerMoney(playerid, -((Geschwindigkeit-50)*10) , "Speed Camera");
       new Blitzernachricht[128];
       format(Blitzernachricht,sizeof(Blitzernachricht),"You were driving %i km/h in a 50-Zone. Thats %i km/h to fast and you have to pay $%i. Drive within the speed limit next time!",Geschwindigkeit, Geschwindigkeit-50,(Geschwindigkeit-50)*10);
       SendClientMessage(playerid,Hellrot,Blitzernachricht);
       Blitz[playerid] = CreatePlayerTextDraw(playerid, 0, 0, "LD_SPAC:white");
       PlayerTextDrawFont(playerid, Blitz[playerid], 4);
       PlayerTextDrawTextSize(playerid, Blitz[playerid], 29800.000000, 28600.000000);
       PlayerTextDrawShow(playerid, PlayerText:Blitz[playerid]);
       PlayerPlaySound(playerid, 1132, 0.0, 0.0, 0.0);
       Blitztimer = SetTimerEx("Blitzz", 125, false, "i", playerid);
	   NBlitzertimer = SetTimerEx("Blitzer", 5000, false, "i", playerid);
       format(Spieler, sizeof Spieler, "/Spieler/%s.txt", GetSname(playerid));
       new SaveBlitzer = dini_Int(Spieler, "Blitzer");
       dini_IntSet(Spieler,"Blitzer",SaveBlitzer+1);
       SaveBlitzer = dini_Int(Spieler, "BlitzerMoney");
       dini_IntSet(Spieler,"BlitzerMoney",SaveBlitzer+(Geschwindigkeit-50)*10);
	   }
    }
  }
  return 1;
}

stock Player50BZone(playerid)
{
  if (IsPlayerInRangeOfPoint(playerid, 25, -2094.7307,-2442.9524,30.6250))
  {
     return 1;
  }
  else if (IsPlayerInRangeOfPoint(playerid, 25, 222.8916, -88.4675, 1.5781))
  {
     return 1;
  }
  else if (IsPlayerInRangeOfPoint(playerid, 25, 2505.8149, 47.2566, 24.4844))
  {
     return 1;
  }
  /*else if (IsPlayerInRangeOfPoint(playerid, HIER EIGENEN BLITZER EINFÜGEN))
  {
     return 1;
  }*/
return 0;
}

forward Blitzz(playerid);
public Blitzz(playerid)
{
PlayerTextDrawHide(playerid, PlayerText:Blitz[playerid]);
PlayerTextDrawDestroy(playerid, PlayerText:Blitz[playerid]);
KillTimer(Blitztimer);
return 1;
}

forward Blitzer(playerid);
public Blitzer(playerid)
{
SetPVarInt(playerid, "Blitzertimer", 0);
KillTimer(NBlitzertimer);
return 1;
}

stock VHealth(Float:percentage, playerid)
{
 if (percentage >= 5)
 {
   SetPVarInt(playerid, "Healthcheck", 0);
 }
 if (percentage <= 5)
 {
   if(GetPVarInt(playerid, "Healthcheck") == 0)
   {
      TextDrawShowForPlayer(playerid, Motorleuchte[playerid][0]);
      TextDrawShowForPlayer(playerid, Motorleuchte[playerid][1]);
      TextDrawShowForPlayer(playerid, Motorleuchte[playerid][2]);
      TextDrawShowForPlayer(playerid, Motorleuchte[playerid][3]);
      TextDrawShowForPlayer(playerid, Motorleuchte[playerid][4]);
      TextDrawShowForPlayer(playerid, Motorleuchte[playerid][5]);
      TextDrawShowForPlayer(playerid, Motorleuchte[playerid][6]);
      TextDrawShowForPlayer(playerid, Motorleuchte[playerid][7]);
      TextDrawShowForPlayer(playerid, Motorleuchte[playerid][8]);
      TextDrawShowForPlayer(playerid, Tacho[playerid][53]);
      SetPVarInt(playerid, "Healthcheck", 1);
      new vehicleid = GetPlayerVehicleID(playerid);
      new id = GetVehicleID(vehicleid);
      if(IsValidVehicle(id) && VehicleCheckEngine[id] > 0) return 1;
      format(Spieler, sizeof Spieler, "/Spieler/%s.txt", GetSname(playerid));
      new MotorCL = dini_Int(Spieler, "MotorCheckLeuchte");
      dini_IntSet(Spieler,"MotorCheckLeuchte",MotorCL+1);
      if(IsValidVehicle(id) && VehicleCreated[id] >= 2 && VehicleCheckEngine[id] == 0)
      {
	     VehicleCheckEngine[id] = 1;
	     SaveVehicle(id);
      }
   }
 }
 return 1;
}


Float:GetPSpeed(vehicleid)
{
	new Float:vx, Float:vy, Float:vz, Float:vel;
	vel = GetVehicleVelocity(vehicleid, vx, vy, vz);
	vel = ((floatsqroot(((vx*vx)+(vy*vy)+(vz*vz)))* 229)*211/200);
	return vel;
}

stock IsPlayerIn70Zone(Float:Geschwindigkeit, playerid)
{
  if(IsPlayerDriver(playerid) && !IsAMountainBike(GetPlayerVehicleID(playerid)) && !IsAAircraft(GetPlayerVehicleID(playerid)) && !IsABoat(GetPlayerVehicleID(playerid)))
  {
   if (Geschwindigkeit >=70)
   {
	 if(IsPlayerInLosSantos(playerid)) return 1;
	 if(IsPlayerInLasVenturas(playerid)) return 1;
	 if(IsPlayerInSanFierro(playerid)) return 1;
   }
}
return 0;
}

stock IsPlayerIn50Zone(Float:Geschwindigkeit, playerid)
{
  if(IsPlayerDriver(playerid) && !IsAMountainBike(GetPlayerVehicleID(playerid)) && !IsAAircraft(GetPlayerVehicleID(playerid)) && !IsABoat(GetPlayerVehicleID(playerid)))
  {
   if (Geschwindigkeit >=50)
   {
   /*if (IsPlayerInRangeOfPoint(playerid, 175, -2149.3267,-2392.4822,37.7891))//Angel Pine
    {
    return 1;
    }
   else if (IsPlayerInRangeOfPoint(playerid, 175,  1303.4069,294.3828,19.5547))//Montgomery
    {
    return 1;
    }
   else if (IsPlayerInRangeOfPoint(playerid, 250,  2337.3416,30.1705,26.1799))//Palomino Creek
    {
    return 1;
    }
   else if (IsPlayerInRangeOfPoint(playerid, 150,  680.5602,-530.9727,15.8810))//Dillimore
    {
    return 1;
    }
   return 0;*/
  if(IsPlayerInRangeOfPoint(playerid, 175, -2149.3267,-2392.4822,37.7891))return 1;//Angel Pine
  else if (IsPlayerInRangeOfPoint(playerid, 210,  228.7886, -143.8747, 1.4297))return 1;//Blueberry
  else if(IsPlayerInZone(playerid, "Dillimore")) return 1;
  else if(IsPlayerInZone(playerid, "Montgomery")) return 1;
  else if(IsPlayerInZone(playerid, "Palomino Creek")) return 1;
  else if(IsPlayerInZone(playerid, "Bayside")) return 1;
  else if(IsPlayerInZone(playerid, "Las Payasadas")) return 1;
  }
}
return 0;
}

stock Checklights(playerid)
{
     new nvehicleid = GetPlayerVehicleID(playerid);
     new tmp_engine, tmp_lights, tmp_alarm, tmp_doors, tmp_hood, tmp_boot, tmp_objective;
	 GetVehicleParamsEx(nvehicleid, tmp_engine, tmp_lights, tmp_alarm, tmp_doors, tmp_hood, tmp_boot, tmp_objective);
	 if(IsPlayerDriver(playerid) && !IsAMountainBike(GetPlayerVehicleID(playerid)) && !IsAAircraft(GetPlayerVehicleID(playerid)) && !IsABoat(GetPlayerVehicleID(playerid)))
	 {
	    if(GetPVarInt(playerid, "TachoHide") == 1) return 1;
	    if (tmp_engine == 0)
	    {
 	 	   TextDrawShowForPlayer(playerid, Batterie[playerid][0]);
 	 	   TextDrawShowForPlayer(playerid, Batterie[playerid][1]);
 	 	   TextDrawShowForPlayer(playerid, Batterie[playerid][2]);
 	 	   TextDrawShowForPlayer(playerid, Batterie[playerid][3]);
 	 	   TextDrawShowForPlayer(playerid, Batterie[playerid][4]);
 	 	   TextDrawShowForPlayer(playerid, Batterie[playerid][5]);
 	       TextDrawShowForPlayer(playerid, Tacho[playerid][52]);
	    }
	    if (tmp_engine == 1)
	    {
 	 	   TextDrawHideForPlayer(playerid, Batterie[playerid][0]);
 	 	   TextDrawHideForPlayer(playerid, Batterie[playerid][1]);
 	 	   TextDrawHideForPlayer(playerid, Batterie[playerid][2]);
 	 	   TextDrawHideForPlayer(playerid, Batterie[playerid][3]);
 	 	   TextDrawHideForPlayer(playerid, Batterie[playerid][4]);
 	 	   TextDrawHideForPlayer(playerid, Batterie[playerid][5]);
 	       TextDrawHideForPlayer(playerid, Tacho[playerid][52]);
	    }
	    if (tmp_lights == 0)
	    {
	 	   TextDrawHideForPlayer(playerid, Licht[playerid][0]);
	 	   TextDrawHideForPlayer(playerid, Licht[playerid][1]);
	 	   TextDrawHideForPlayer(playerid, Licht[playerid][2]);
	 	   TextDrawHideForPlayer(playerid, Licht[playerid][3]);
 	       TextDrawHideForPlayer(playerid, Tacho[playerid][50]);
	    }
	    if (tmp_lights == 1)
	    {
		   TextDrawShowForPlayer(playerid, Licht[playerid][0]);
		   TextDrawShowForPlayer(playerid, Licht[playerid][1]);
		   TextDrawShowForPlayer(playerid, Licht[playerid][2]);
		   TextDrawShowForPlayer(playerid, Licht[playerid][3]);
 	       TextDrawShowForPlayer(playerid, Tacho[playerid][50]);
	    }
	    new id = GetVehicleID(nvehicleid);
	    if(IsValidVehicle(id))
	    {
	       if (VehicleLock[id] == 1)
	       {
		      TextDrawShowForPlayer(playerid, Locked[playerid][0]);
		      TextDrawShowForPlayer(playerid, Locked[playerid][1]);
		      TextDrawShowForPlayer(playerid, Locked[playerid][2]);
		      TextDrawShowForPlayer(playerid, Locked[playerid][3]);
		      TextDrawShowForPlayer(playerid, Tacho[playerid][51]);
	       }
	       if (VehicleLock[id] == 0)
	       {
		      TextDrawHideForPlayer(playerid, Locked[playerid][0]);
		      TextDrawHideForPlayer(playerid, Locked[playerid][1]);
		      TextDrawHideForPlayer(playerid, Locked[playerid][2]);
		      TextDrawHideForPlayer(playerid, Locked[playerid][3]);
		      TextDrawHideForPlayer(playerid, Tacho[playerid][51]);
	       }
	       if (VehicleCheckEngine[id] >= 1)
	       {
              TextDrawShowForPlayer(playerid, Motorleuchte[playerid][0]);
              TextDrawShowForPlayer(playerid, Motorleuchte[playerid][1]);
              TextDrawShowForPlayer(playerid, Motorleuchte[playerid][2]);
              TextDrawShowForPlayer(playerid, Motorleuchte[playerid][3]);
              TextDrawShowForPlayer(playerid, Motorleuchte[playerid][4]);
              TextDrawShowForPlayer(playerid, Motorleuchte[playerid][5]);
              TextDrawShowForPlayer(playerid, Motorleuchte[playerid][6]);
              TextDrawShowForPlayer(playerid, Motorleuchte[playerid][7]);
              TextDrawShowForPlayer(playerid, Motorleuchte[playerid][8]);
              TextDrawShowForPlayer(playerid, Tacho[playerid][53]);
	       }
	       if (VehicleCheckEngine[id] == 0)
	       {
              TextDrawHideForPlayer(playerid, Motorleuchte[playerid][0]);
              TextDrawHideForPlayer(playerid, Motorleuchte[playerid][1]);
              TextDrawHideForPlayer(playerid, Motorleuchte[playerid][2]);
              TextDrawHideForPlayer(playerid, Motorleuchte[playerid][3]);
              TextDrawHideForPlayer(playerid, Motorleuchte[playerid][4]);
              TextDrawHideForPlayer(playerid, Motorleuchte[playerid][5]);
              TextDrawHideForPlayer(playerid, Motorleuchte[playerid][6]);
              TextDrawHideForPlayer(playerid, Motorleuchte[playerid][7]);
              TextDrawHideForPlayer(playerid, Motorleuchte[playerid][8]);
              TextDrawHideForPlayer(playerid, Tacho[playerid][53]);
	       }
		   if (VehicleBatteryLight[id] >= 1)
		   {
			  TextDrawShowForPlayer(playerid, Batterie[playerid][0]);
			  TextDrawShowForPlayer(playerid, Batterie[playerid][1]);
			  TextDrawShowForPlayer(playerid, Batterie[playerid][2]);
			  TextDrawShowForPlayer(playerid, Batterie[playerid][3]);
			  TextDrawShowForPlayer(playerid, Batterie[playerid][4]);
			  TextDrawShowForPlayer(playerid, Batterie[playerid][5]);
			  TextDrawShowForPlayer(playerid, Tacho[playerid][52]);
		   }
		   if (VehicleBatteryLight[id] == 0 && tmp_engine == 1)
		   {
			  TextDrawHideForPlayer(playerid, Batterie[playerid][0]);
			  TextDrawHideForPlayer(playerid, Batterie[playerid][1]);
			  TextDrawHideForPlayer(playerid, Batterie[playerid][2]);
			  TextDrawHideForPlayer(playerid, Batterie[playerid][3]);
			  TextDrawHideForPlayer(playerid, Batterie[playerid][4]);
			  TextDrawHideForPlayer(playerid, Batterie[playerid][5]);
			  TextDrawHideForPlayer(playerid, Tacho[playerid][52]);
		   }
	    }
	    else if(!IsValidVehicle(id))
	    {
	       if (NVehicleLocked[nvehicleid] == 1)
	       {
		      TextDrawShowForPlayer(playerid, Locked[playerid][0]);
		      TextDrawShowForPlayer(playerid, Locked[playerid][1]);
		      TextDrawShowForPlayer(playerid, Locked[playerid][2]);
		      TextDrawShowForPlayer(playerid, Locked[playerid][3]);
		      TextDrawShowForPlayer(playerid, Tacho[playerid][51]);
	       }
	       if (NVehicleLocked[nvehicleid] == 0)
	       {
		      TextDrawHideForPlayer(playerid, Locked[playerid][0]);
		      TextDrawHideForPlayer(playerid, Locked[playerid][1]);
		      TextDrawHideForPlayer(playerid, Locked[playerid][2]);
		      TextDrawHideForPlayer(playerid, Locked[playerid][3]);
		      TextDrawHideForPlayer(playerid, Tacho[playerid][51]);
	       }
	       if(GetPVarInt(playerid, "Healthcheck") == 1)
	       {
              TextDrawShowForPlayer(playerid, Motorleuchte[playerid][0]);
              TextDrawShowForPlayer(playerid, Motorleuchte[playerid][1]);
              TextDrawShowForPlayer(playerid, Motorleuchte[playerid][2]);
              TextDrawShowForPlayer(playerid, Motorleuchte[playerid][3]);
              TextDrawShowForPlayer(playerid, Motorleuchte[playerid][4]);
              TextDrawShowForPlayer(playerid, Motorleuchte[playerid][5]);
              TextDrawShowForPlayer(playerid, Motorleuchte[playerid][6]);
              TextDrawShowForPlayer(playerid, Motorleuchte[playerid][7]);
              TextDrawShowForPlayer(playerid, Motorleuchte[playerid][8]);
              TextDrawShowForPlayer(playerid, Tacho[playerid][53]);
	       }
	       else if(GetPVarInt(playerid, "Healthcheck") == 0)
	       {
              TextDrawHideForPlayer(playerid, Motorleuchte[playerid][0]);
              TextDrawHideForPlayer(playerid, Motorleuchte[playerid][1]);
              TextDrawHideForPlayer(playerid, Motorleuchte[playerid][2]);
              TextDrawHideForPlayer(playerid, Motorleuchte[playerid][3]);
              TextDrawHideForPlayer(playerid, Motorleuchte[playerid][4]);
              TextDrawHideForPlayer(playerid, Motorleuchte[playerid][5]);
              TextDrawHideForPlayer(playerid, Motorleuchte[playerid][6]);
              TextDrawHideForPlayer(playerid, Motorleuchte[playerid][7]);
              TextDrawHideForPlayer(playerid, Motorleuchte[playerid][8]);
              TextDrawHideForPlayer(playerid, Tacho[playerid][53]);
	       }
	    }
	 }
	 else if (IsAAircraft(GetPlayerVehicleID(playerid)) && (IsPlayerDriver(playerid)))
	 {
	   if (tmp_engine == 0)
	   {
 		PlayerTextDrawShow(playerid, FPOFF[playerid]);
 		PlayerTextDrawShow(playerid, PEOFF[playerid]);
 		PlayerTextDrawHide(playerid, FPON[playerid]);
 		PlayerTextDrawHide(playerid, PEON[playerid]);
	   }
	   if (tmp_engine == 1)
	   {
 		PlayerTextDrawShow(playerid, FPON[playerid]);
 		PlayerTextDrawShow(playerid, PEON[playerid]);
 		PlayerTextDrawHide(playerid, FPOFF[playerid]);
 		PlayerTextDrawHide(playerid, PEOFF[playerid]);
	   }
	   }
return 1;
}

forward Tanken(playerid);
public Tanken(playerid)
{
   new string[75];
   Tankgeld[playerid] = Tankgeld[playerid] + 1;
   Fuel[GetPlayerVehicleID(playerid)] = Fuel[GetPlayerVehicleID(playerid)] + 1;
   string = GetVehicleFuelType(GetVehicleModel(GetPlayerVehicleID(playerid)));
   if(strcmp(string, "Petrol") == 0)
   {
      format(string, sizeof string, "%s ~n~%i ltrs (%.2f$)", string, Tankgeld[playerid], Tankgeld[playerid] * Spritpreis_PETROL);
   }
   if(strcmp(string, "Diesel") == 0)
   {
      format(string, sizeof string, "%s ~n~%i ltrs (%.2f$)", string, Tankgeld[playerid], Tankgeld[playerid] * Spritpreis_DIESEL);
   }
   if(Fuel[GetPlayerVehicleID(playerid)] >= 100)
   {
      format(string, sizeof string, "%s~n~~r~You are full!", string);
      Fuel[GetPlayerVehicleID(playerid)] = 100;
      ToggleCarRefueling(playerid, GetPlayerVehicleID(playerid), 0);
      SendInfoText(playerid, string);
      return 1;
   }
   SendInfoText(playerid, string);
   ToggleCarRefueling(playerid, GetPlayerVehicleID(playerid), 2);
   return 1;
}

stock ToggleCarRefueling(playerid, vehicleid, toggle)
{
   if(toggle == 1)
   {
      Tankgeld[playerid] = 0;
      new string[50];
      format(string, sizeof string, "%i", Tankgeld[playerid]);
      SendInfoText(playerid, string);
      Tanken(playerid);
   }
   if(toggle == 0)
   {
	  new string[20];
	  new Float:tankgeld;
      KillTimer(Tanktimer);
      string = GetVehicleFuelType(GetVehicleModel(GetPlayerVehicleID(playerid)));
      if(strcmp(string, "Petrol") == 0)
      {
         tankgeld = floatround((Tankgeld[playerid] * Spritpreis_PETROL), floatround_ceil);
      }
      if(strcmp(string, "Diesel") == 0)
      {
         tankgeld = floatround((Tankgeld[playerid] * Spritpreis_DIESEL), floatround_ceil);
      }
      format(string, sizeof string, "%f", tankgeld);
      ChangePlayerMoney(playerid, - strval(string), "Refueling");
      Tankgeld[playerid] = -1;
	  new id = GetVehicleID(vehicleid);
	  if(!IsValidVehicle(id)) return 1;
	  VehicleFuel[id] = Fuel[vehicleid];
	  SaveVehicle(id);
      return 1;
      
   }
   if(toggle == 2)
   {
      Tanktimer = SetTimerEx("Tanken", 250, false, "%i", playerid);
   }
   return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
     new vID=GetPlayerVehicleID(playerid),
	 tmp_engine,
	 tmp_lights,
	 tmp_alarm,
	 tmp_doors,
	 tmp_hood,
     tmp_trunk,
	 tmp_objective;
	 GetVehicleParamsEx(vID,tmp_engine, tmp_lights, tmp_alarm, tmp_doors, tmp_hood, tmp_trunk, tmp_objective);
	 
	 if(IsPlayerDriver(playerid) && !IsAMountainBike(GetPlayerVehicleID(playerid)) && !IsAAircraft(GetPlayerVehicleID(playerid)) && !IsABoat(GetPlayerVehicleID(playerid)))
	 {
	   if(newkeys != KEY_FIRE && Tankgeld[playerid] > 0)
	   {
	      ToggleCarRefueling(playerid, GetPlayerVehicleID(playerid), 0);
	   }
	   if(newkeys & KEY_FIRE)//Autoverschrottung
	   {
	      if(IsPlayerInRangeOfPoint(playerid, 10, -1870.0823,-1681.9326,21.7594))
	      {
	         new string[50];
	         new amount;
	         format(string, sizeof string, "%s scrapped", VehicleNames[GetVehicleModel(GetPlayerVehicleID(playerid))-400]);
	         amount = 150 + random(350);
	         if(IsValidVehicle(GetPlayerVehicleID(playerid)) && strcmp(VehicleOwner[GetVehicleID(GetPlayerVehicleID(playerid))], GetSname(playerid)) == 0)
	         {
			    amount = VehicleValue[GetVehicleID(GetPlayerVehicleID(playerid))];
				VehicleOwner[GetVehicleID(GetPlayerVehicleID(playerid))] = "";
				CarKeyOwner[GetVehicleID(GetPlayerVehicleID(playerid))] = "";
				SaveVehicle(GetPlayerVehicleID(playerid));
				VehicleCreated[GetVehicleID(GetPlayerVehicleID(playerid))] = 0;
				SaveVehicle(GetPlayerVehicleID(playerid));
			    DestroyVehicle(GetPlayerVehicleID(playerid));
	         }
	         RemovePlayerFromVehicle(playerid);
	         if(!IsValidVehicle(GetPlayerVehicleID(playerid)))
	         {
			    SetVehicleToRespawn(GetPlayerVehicleID(playerid));
	         }
	         ChangePlayerMoney(playerid, amount, string);
	      }
	   }
	   if(newkeys & KEY_FIRE && Tankgeld[playerid] <= 0)
	   {
	      if(IsPlayerInRangeOfPoint(playerid, 10, -2244.039, -2560.533, 31.4433) || IsPlayerInRangeOfPoint(playerid, 15, -1606.454, -2713.569, 48.263)
		  || IsPlayerInRangeOfPoint(playerid, 15, -90.469, -1169.377, 2.08) || IsPlayerInRangeOfPoint(playerid, 10, 655.395, -564.952, 16.063)
		  || IsPlayerInRangeOfPoint(playerid, 17, 1939.911, -1772.952, 13.429) || IsPlayerInRangeOfPoint(playerid, 8, 1382.883, 461.044, 20.153)
		  || IsPlayerInRangeOfPoint(playerid, 15, 2115.139, 920.078, 10.747) || IsPlayerInRangeOfPoint(playerid, 15, 2639.861, 1106.467, 10.747)
		  || IsPlayerInRangeOfPoint(playerid, 15, 1597.118, 2199.466, 10.747) || IsPlayerInRangeOfPoint(playerid, 15, 2147.286, 2748.268, 10.747)
		  || IsPlayerInRangeOfPoint(playerid, 22, 614.595, 1691.086, 7.011) || IsPlayerInRangeOfPoint(playerid, 15, -1328.356, 2677.409, 49.99)
		  || IsPlayerInRangeOfPoint(playerid, 15, -1471.582, 1864.145, 32.56) || IsPlayerInRangeOfPoint(playerid, 15, -2412.453, 976.237, 45.302))//Tankstellen
	      {
	         ToggleCarRefueling(playerid, GetPlayerVehicleID(playerid), 1);
	      }
	   }
	   if (newkeys & KEY_SPRINT || newkeys & KEY_JUMP)
 	   {
          if(GetPVarInt(playerid, "KEINSPRIT") == 1)
		  {
		    tmp_engine = 0;
		    SetVehicleParamsEx(GetPlayerVehicleID(playerid), tmp_engine, tmp_lights, tmp_alarm, tmp_doors, tmp_hood, tmp_trunk, tmp_objective);
		    return 0;
    	  }
          else
          {
		   new id = GetVehicleID(GetPlayerVehicleID(playerid));
		   if(IsValidVehicle(id))
		   {
		      if(VehicleCheckEngine[id] >= 5 || VehicleBatteryLight[id] >= 3)
		      {
		         tmp_engine = 0;
		         SetVehicleParamsEx(GetPlayerVehicleID(playerid), tmp_engine, tmp_lights, tmp_alarm, tmp_doors, tmp_hood, tmp_trunk, tmp_objective);
		         return 0;
		      }
		   }
		   tmp_engine = 1;
           SetVehicleParamsEx(GetPlayerVehicleID(playerid), tmp_engine, tmp_lights, tmp_alarm, tmp_doors, tmp_hood, tmp_trunk, tmp_objective);
         }
 	   }
	 }
	 //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
     if (newkeys == KEY_NO)
     {
       if(IsPlayerDriver(playerid) && IsAAircraft(GetPlayerVehicleID(playerid)))
       {
           ShowPlayerDialog(playerid, PLANED, DIALOG_STYLE_LIST, "Menu","{FFFF00}Aircraft Actions\nHelp\nInventory\nVehicle Stats\nPlayer Stats","Select","Close");
       }
     }
	 //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	 if (newkeys == KEY_NO)
     {
           ShowPlayerDialog(playerid, AUTOD, DIALOG_STYLE_LIST, "Menu","{FFFF00}Car Actions\nHelp\nInventory\nVehicle Stats\nPlayer Stats","Select","Close");
     }
	 //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	 if (newkeys & KEY_SUBMISSION)
	 {
	    if (IsAAircraft(GetPlayerVehicleID(playerid)) == 1)
	    {
	      if(LandingGearCRTL[playerid] == 1)
          {
           LandingGearCRTL[playerid] = 0;
           PlayerTextDrawShow(playerid, PlayerText: LDGOFF[playerid]);
           PlayerTextDrawHide(playerid, PlayerText: LDGON[playerid]);
          }
          else
          {
           LandingGearCRTL[playerid] = 1;
           PlayerTextDrawHide(playerid, PlayerText: LDGOFF[playerid]);
           PlayerTextDrawShow(playerid, PlayerText: LDGON[playerid]);
          }
	    }
	    SetVehicleParamsEx(vID, tmp_engine, tmp_lights, tmp_alarm, tmp_doors, tmp_hood, tmp_trunk, tmp_objective);
	 }
	 //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
     if (newkeys & KEY_LOOK_LEFT)
     {
	  new vehicleid = GetPlayerVehicleID(playerid);
	  if (BlinkerL[vehicleid] == 0)
	  {
	    BlinkerTimer = SetTimerEx("Blinker", 500, false, "%i, %i", vehicleid, playerid);
	    BlinkerL[vehicleid] = 1;
	    AddBlinkerToCar(vehicleid);
	    if(GetPVarInt(playerid, "TachoHide") == 1) return 1;
	    PlayerTextDrawShow(playerid, PlayerText:BlinkerLinks[playerid][0]);
	    PlayerTextDrawShow(playerid, PlayerText:BlinkerLinks[playerid][1]);
	  }
	  else if (BlinkerR[vehicleid] == 1 && BlinkerL[vehicleid] == 1)
	  {
		KillTimer(BlinkerTimer);
		BlinkerR[vehicleid] = 0;
		BlinkerL[vehicleid] = 0;
		DestroyAllCarBlinkers(vehicleid, 0);
		PlayerTextDrawHide(playerid, PlayerText:BlinkerRechts[playerid][0]);
		PlayerTextDrawHide(playerid, PlayerText:BlinkerLinks[playerid][0]);
		PlayerTextDrawHide(playerid, PlayerText:BlinkerRechts[playerid][1]);
		PlayerTextDrawHide(playerid, PlayerText:BlinkerLinks[playerid][1]);
	  }
	  else if (BlinkerL[vehicleid] == 1)
	  {
		KillTimer(BlinkerTimer);
		BlinkerL[vehicleid] = 0;
		DestroyAllCarBlinkers(vehicleid, 0);
		PlayerTextDrawHide(playerid, PlayerText:BlinkerLinks[playerid][0]);
		PlayerTextDrawHide(playerid, PlayerText:BlinkerLinks[playerid][1]);
	  }
     }
	 //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
     if (newkeys & KEY_LOOK_RIGHT)
     {
	  new vehicleid = GetPlayerVehicleID(playerid);
	  if (BlinkerR[vehicleid] == 0)
	  {
	    BlinkerR[vehicleid] = 1;
	    BlinkerTimer = SetTimerEx("Blinker", 500, false, "%i, %i", vehicleid, playerid);
	    PlayerTextDrawShow(playerid, PlayerText:BlinkerRechts[playerid][0]);
	    PlayerTextDrawShow(playerid, PlayerText:BlinkerRechts[playerid][1]);
        AddBlinkerToCar(vehicleid);
	  }
	  else if (BlinkerR[vehicleid] == 1 && BlinkerL[vehicleid] == 1)
	  {
		KillTimer(BlinkerTimer);
		BlinkerR[vehicleid] = 0;
		BlinkerL[vehicleid] = 0;
		DestroyAllCarBlinkers(vehicleid, 0);
		PlayerTextDrawHide(playerid, PlayerText:BlinkerRechts[playerid][0]);
		PlayerTextDrawHide(playerid, PlayerText:BlinkerLinks[playerid][0]);
		PlayerTextDrawHide(playerid, PlayerText:BlinkerRechts[playerid][1]);
		PlayerTextDrawHide(playerid, PlayerText:BlinkerLinks[playerid][1]);
	  }
	  else if (BlinkerR[vehicleid] == 1)
	  {
		KillTimer(BlinkerTimer);
		BlinkerR[vehicleid] = 0;
		DestroyAllCarBlinkers(vehicleid, 0);
		PlayerTextDrawHide(playerid, PlayerText:BlinkerRechts[playerid][0]);
		PlayerTextDrawHide(playerid, PlayerText:BlinkerRechts[playerid][1]);
	  }
     }
	    if((newkeys == KEY_YES) && (GetPlayerState(playerid)== 2) || ((newkeys & KEY_WALK) && (newkeys & KEY_YES) && (GetPlayerState(playerid) != 2)))
	    {
		   new vehicleid = GetPlayerVehicleID(playerid);
		   vehicleid = GetClosestVehicle(playerid);

		   if(!IsPlayerInRangeOfVehicle(playerid, vehicleid, 25.0)) return SendClientMessage(playerid, Hellrot, "You are not near a vehicle!");
           

           new id = GetVehicleID(vehicleid);
	       if(GetPlayerVehicleAccess(playerid, id) < 2)
	       return SendClientMessage(playerid, Hellrot, "You don't have the keys for this vehicle!");
		   SelectTextDraw(playerid, TextdrawFarbe);
		   TextDrawShowForPlayer(playerid, Schluessel[playerid][0]);
		   TextDrawShowForPlayer(playerid, Schluessel[playerid][1]);
		   TextDrawShowForPlayer(playerid, Schluessel[playerid][2]);
		   TextDrawShowForPlayer(playerid, Schluessel[playerid][3]);
		   TextDrawShowForPlayer(playerid, Schluessel[playerid][4]);
		   TextDrawShowForPlayer(playerid, Schluessel[playerid][5]);
		   TextDrawShowForPlayer(playerid, Schluessel[playerid][6]);
		   TextDrawShowForPlayer(playerid, Aufsperren[playerid]);
		   TextDrawShowForPlayer(playerid, Zusperren[playerid]);
		   TextDrawShowForPlayer(playerid, Aufsperren_[playerid][0]);
		   TextDrawShowForPlayer(playerid, Aufsperren_[playerid][1]);
		   TextDrawShowForPlayer(playerid, Aufsperren_[playerid][2]);
		   TextDrawShowForPlayer(playerid, Zusperren_[playerid][0]);
		   TextDrawShowForPlayer(playerid, Zusperren_[playerid][1]);
		   TextDrawShowForPlayer(playerid, Zusperren_[playerid][2]);
		   TextDrawShowForPlayer(playerid, Parken[playerid]);
		   TextDrawShowForPlayer(playerid, Parken_[playerid]);
		   TextDrawShowForPlayer(playerid, UNDEFINED[playerid]);
		   TextDrawShowForPlayer(playerid, MoreButton[playerid]);
		   
           TextDrawSetPreviewModel(FahrzeugBild[playerid], VehicleModel[id]);
           TextDrawSetPreviewModel(FahrzeugParkBild[playerid], VehicleModel[id]);
           TextDrawSetPreviewVehCol(FahrzeugBild[playerid], VehicleColor[id][0], VehicleColor[id][1]);
           TextDrawSetPreviewVehCol(FahrzeugParkBild[playerid], VehicleColor[id][0], VehicleColor[id][1]);
           TextDrawSetString(VehicleName[playerid], VehicleNames[VehicleModel[id]-400]);
		   TextDrawShowForPlayer(playerid, FahrzeugParkBild[playerid]);
		   TextDrawShowForPlayer(playerid, VehicleName[playerid]);
           TextDrawShowForPlayer(playerid, FahrzeugBild[playerid]);
           return 1;
	    }
	if(newkeys == KEY_WALK && IsPlayerInRangeOfPoint(playerid,1.5,252.9363,27.8895,2.4549))
	{
	    if(state1 == 0) { MoveDynamicObject(garage1,255.000,31.583,5.278,0.25,0.000,88.099,0.000); state1 = 1;
		                  SetTimerEx("CloseMechanicGate", 20000, false, "%i", 1);}
	    else { MoveDynamicObject(garage1,253.384,31.583,3.419,0.25,0.000,0.000,0.000); state1 = 0;}
	}
	if(newkeys == KEY_WALK && IsPlayerInRangeOfPoint(playerid,1.5,252.9376,21.4025,2.4548))
	{
	    if(state2 == 0) { MoveDynamicObject(garage2,254.792,17.663,5.244,0.25,0.000,87.999,0.000); state2 = 1;
		                  SetTimerEx("CloseMechanicGate", 20000, false, "%i", 2);}
	    else { MoveDynamicObject(garage2,253.384,17.663,3.419,0.25,0.000,0.000,0.000); state2 = 0;}
	}
	if(newkeys == KEY_WALK && IsPlayerInRangeOfPoint(playerid,0.5,267.6326,26.3754,2.4424))
	{
	    if(state3 == 0)
	    {
	        MoveDynamicObject(elevator[0],266.948,28.492,1.502+1,1.0);
	        MoveDynamicObject(elevator[1],268.353,28.504,1.502+1,1.0);
	        MoveDynamicObject(elevator[2],266.926,30.458,1.502+1,1.0);
	        MoveDynamicObject(elevator[3],268.316,30.450,1.502+1,1.0);
	        MoveDynamicObject(elevator[4],266.883117, 29.410875, 1.473332+1,1.0);
	        state3 = 1;
	    }
	    else if(state3 == 1)
	    {
			new vehicleid = GetPVarInt(playerid, "MechJobvid");
	        PutPlayerInVehicle(playerid, vehicleid, 0);
	        SetTimerEx("Hebebuhne", 100, false, "%i", playerid);
	        MoveDynamicObject(elevator[0],266.948,28.492,1.502+2,1.0);
	        MoveDynamicObject(elevator[1],268.353,28.504,1.502+2,1.0);
	        MoveDynamicObject(elevator[2],266.926,30.458,1.502+2,1.0);
	        MoveDynamicObject(elevator[3],268.316,30.450,1.502+2,1.0);
	        MoveDynamicObject(elevator[4],266.883117, 29.410875, 1.473332+2,1.0);
	        state3 = 2;
	    }
	    else if(state3 == 2)
	    {
			new vehicleid = GetPVarInt(playerid, "MechJobvid");
	        PutPlayerInVehicle(playerid, vehicleid, 0);
	        SetTimerEx("Hebebuhne", 100, false, "%i", playerid);
	        MoveDynamicObject(elevator[0],266.948,28.492,3.502-2,1.0);
	        MoveDynamicObject(elevator[1],268.353,28.504,3.502-2,1.0);
	        MoveDynamicObject(elevator[2],266.926,30.458,3.502-2,1.0);
	        MoveDynamicObject(elevator[3],268.316,30.450,3.502-2,1.0);
	        MoveDynamicObject(elevator[4],266.883117, 29.410875, 3.473332 -2,1.0);
	        state3 =0;
	    }
	}
	return 1;
}

forward Speedo();
public Speedo()
{
   foreach(new i : Player)
   if(IsPlayerDriver(i) && !IsAMountainBike(GetPlayerVehicleID(i)) && !IsAAircraft(GetPlayerVehicleID(i)) && !IsABoat(GetPlayerVehicleID(i)))
   {
     new Float:speed, Float:result;
	 {
	    if(GetPlayerState(i) != 2) continue;
		speed = GetPSpeed(GetPlayerVehicleID(i));
		if(speed > 260)
		{
		    PlayerTextDrawHide(i, Tachonadel[i]);
		    PlayerTextDrawSetPreviewRot(i, Tachonadel[i], 0.000000, -131.0, 0.000000, 2.000000);
		    if(GetPVarInt(i, "TachoHide") == 1) return 1;
		    PlayerTextDrawShow(i, Tachonadel[i]);
		    continue;
		}
		if(speed < 132.5)
		{
		    result = floatabs((132.5-speed));
		    PlayerTextDrawHide(i, Tachonadel[i]);
		    PlayerTextDrawSetPreviewRot(i, Tachonadel[i], 0.000000, result, 0.000000, 2.000000);
		    if(GetPVarInt(i, "TachoHide") == 1) return 1;
		    PlayerTextDrawShow(i, Tachonadel[i]);
		    continue;
		}
  		result = 132.5-speed;
  		PlayerTextDrawHide(i, Tachonadel[i]);
  		PlayerTextDrawSetPreviewRot(i, Tachonadel[i], 0.000000, result, 0.000000, 2.000000);
	    if(GetPVarInt(i, "TachoHide") == 1) return 1;
  		PlayerTextDrawShow(i, Tachonadel[i]);
	 }
   }
   return 1;
}

stock GetPlaneSpeed(playerid, bool: kmh = true)
{
   new Float:xx,
	   Float:yy,
	   Float:zz,
    Float:pSpeed;
   GetVehicleVelocity(GetPlayerVehicleID(playerid),xx,yy,zz);
   pSpeed = floatsqroot((xx * xx) + (yy * yy) + (zz * zz));
   return kmh ? floatround(pSpeed * 187.0/1.8) : floatround(pSpeed * 120.9/1.8);
}

stock NMGet(playerid)
{
if(IsPlayerDriver(playerid)/* && IsAAircraft(GetPlayerVehicleID(playerid))*/)
{
  if(GetPVarInt(playerid, "PKMLaden") == 0)
  {
     SetPVarInt(playerid, "PKMLaden",1);
     if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	  {
	    if(IsAPlane(GetPlayerVehicleID(playerid)))
	    {
          GetPlayerName(playerid,Sname,sizeof(Sname));
          format (Spieler,sizeof(Spieler),"/Spieler/%s.txt",Sname);
          return dini_Int(Spieler, "KMStandFlugzeug");
        }
        if(IsABoat(GetPlayerVehicleID(playerid)))
	    {
          GetPlayerName(playerid,Sname,sizeof(Sname));
          format (Spieler,sizeof(Spieler),"/Spieler/%s.txt",Sname);
          return dini_Int(Spieler, "KMStandBoot");
        }
		if(IsAHeli(GetPlayerVehicleID(playerid)))
	    {
          GetPlayerName(playerid,Sname,sizeof(Sname));
          format (Spieler,sizeof(Spieler),"/Spieler/%s.txt",Sname);
          return dini_Int(Spieler, "KMStandHubs");
        }
	}
  }
}
return 0;
}

stock GetVehicleRotation(vehicleid,&Float:rx,&Float:ry,&Float:rz)
{
	new Float:qw,Float:qx,Float:qy,Float:qz;
	GetVehicleRotationQuat(vehicleid,qw,qx,qy,qz);
	rx = asin(2*qy*qz-2*qx*qw);
	ry = -atan2(qx*qz+qy*qw,0.5-qx*qx-qy*qy);
	rz = -atan2(qx*qy+qz*qw,0.5-qx*qx-qz*qz);
}

stock VKMGet(vehicleid)
{
if(IsValidVehicle(vehicleid))
{
   return VehicleMileage[vehicleid];
}
return 0;
}

stock KMGet(playerid)
{
 if(IsPlayerDriver(playerid) && !IsAMountainBike(GetPlayerVehicleID(playerid)) && !IsAAircraft(GetPlayerVehicleID(playerid)) && !IsABoat(GetPlayerVehicleID(playerid)))
 {
  if(GetPVarInt(playerid, "KMLaden") == 0)
  {
   SetPVarInt(playerid, "KMLaden",1);
   if(IsPlayerConnected(playerid) && GetPlayerState(playerid) == 2)
   {
       format(Spieler,sizeof(Spieler),"/Spieler/%s.txt",GetSname(playerid));
       if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	   {
	    if(IsAMotorBike(GetPlayerVehicleID(playerid)))
	    {
          return dini_Int(Spieler, "KMStandMotorrad");
        }
        else if(IsATruck(GetPlayerVehicleID(playerid)))
	    {
          return dini_Int(Spieler, "KMStandLKW");
        }
        else if(!IsAAircraft(GetPlayerVehicleID(playerid)) && !IsABoat(GetPlayerVehicleID(playerid)) && !IsAMountainBike(GetPlayerVehicleID(playerid)) && !IsAMotorBike(GetPlayerVehicleID(playerid)) && !IsATruck(GetPlayerVehicleID(playerid)))
        {
          return dini_Int(Spieler, "KMStandAuto");
	    }
   }
  }
 }
}
return 0;
}

public OnPlayerDisconnect(playerid, reason)
{
	return 1;
}

public OnVehicleSpawn(vehicleid)
{
	new id = GetVehicleID(vehicleid);
	if(IsValidVehicle(id))
	{
		if(VehicleColor[id][0] >= 0 && VehicleColor[id][1] >= 0)
		ChangeVehicleColor(vehicleid, VehicleColor[id][0], VehicleColor[id][1]);
		LinkVehicleToInterior(vehicleid, VehicleInterior[id]);
		SetVehicleVirtualWorld(vehicleid, VehicleWorld[id]);
		for(new i=0; i < sizeof(VehicleMods[]); i++)
		{
			AddVehicleComponent(vehicleid, VehicleMods[id][i]);
		}
		ChangeVehiclePaintjob(vehicleid, VehiclePaintjob[id]);
		SetVehicleHealth(vehicleid, VehicleHealth[GetVehicleID(vehicleid)]);
		if((VehicleLock[id]) == 1)
		{
	         for(new i=0; i < MAX_PLAYERS; i++)
			 if (strcmp(VehicleOwner[id], GetSname(i)) == 0)
			 {
				  SetVehicleParamsForPlayer(id, i, 1,0);
				  new string[35];
				  format(string, sizeof string, "Your %s just respawned", VehicleNames[VehicleModel[id]-400]);
				  SendClientMessage(i, Hellblau, string);
			 }
			 else if (strcmp(CarKeyOwner[id], GetSname(i)) == 0)
			 {
				  SetVehicleParamsForPlayer(id, i, 1,0);
				  SendClientMessage(i, Hellblau, "A car you have the keys for just respawned.");
			 }
		}
	}
	else
	{
	   NVehicleLocked[vehicleid] = 0;
	   Fuel[vehicleid] = 20+random(80);
	}
	return 1;
}

CMD:vhelp(playerid, params[])
{
	new info[512];
	strcat(info, "/v  /tow  /eject  /ejectall\n", sizeof(info));
	strcat(info, "/vlock  /trunk  /clearmods  /sellv  /givecarkeys  /trackcar\n", sizeof(info));
	if(IsPlayerAdmin(playerid))
	{
		strcat(info, "/addv  /editv  /rac (respawnallcars)  /rtc (respawnthiscar)\n", sizeof(info));
		strcat(info, "/adddealership  /deletedealership  /movedealership  /gotodealership\n", sizeof(info));
	}
	ShowPlayerDialog(playerid, DIALOG_NONE, DIALOG_STYLE_MSGBOX, "Vehicle System Help", info, "OK", "");
	return 1;
}

CMD:flip(playerid, params[])
{
	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return SendClientMessage(playerid, COLOR_RED, "You are not driving a vehicle!");
	new vehicleid = GetPlayerVehicleID(playerid);
	new Float:angle;
	GetVehicleZAngle(vehicleid, angle);
	SetVehicleZAngle(vehicleid, angle);
	SendClientMessage(playerid, COLOR_WHITE, "Vehicle flipped");
	return 1;
}

CMD:tow(playerid, params[])
{
	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return SendClientMessage(playerid, COLOR_RED, "You are not driving a vehicle!");
	new vehicleid = GetPlayerVehicleID(playerid);
	if(IsTrailerAttachedToVehicle(vehicleid))
	{
		DetachTrailerFromVehicle(vehicleid);
		SendClientMessage(playerid, COLOR_WHITE, "You are not towing anymore");
		return 1;
	}
	new Float:x, Float:y, Float:z;
	new Float:dist, Float:closedist=50, closeveh;
	for(new i=1; i < MAX_VEHICLES; i++)
	{
		if(i != vehicleid && GetVehiclePos(i, x, y, z))
		{
			dist = GetPlayerDistanceFromPoint(playerid, x, y, z);
			if(dist < closedist)
			{
				closedist = dist;
				closeveh = i;
			}
		}
	}
	if(!closeveh) return SendClientMessage(playerid, COLOR_RED, "You are not close to a vehicle!");
	AttachTrailerToVehicle(closeveh, vehicleid);
	SendClientMessage(playerid, COLOR_WHITE, "You are now towing a vehicle");
	return 1;
}

CMD:clearmods(playerid, params[])
{
	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return SendClientMessage(playerid, COLOR_RED, "You are not driving a vehicle!");
	new vehicleid = GetPlayerVehicleID(playerid);
	new id = GetVehicleID(vehicleid);
	if(GetPlayerVehicleAccess(playerid, id) < 2)
		return SendClientMessage(playerid, COLOR_RED, "This is not your vehicle!");
	for(new i=0; i < sizeof(VehicleMods[]); i++)
	{
		RemoveVehicleComponent(VehicleID[id], GetVehicleComponentInSlot(VehicleID[id], i));
		VehicleMods[id][i] = 0;
	}
	VehiclePaintjob[id] = 255;
	ChangeVehiclePaintjob(VehicleID[id], 255);
	SaveVehicle(id);
	SendClientMessage(playerid, COLOR_WHITE, "You have removed all modifications from your vehicle");
	return 1;
}

CMD:v(playerid, params[])
{
	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return SendClientMessage(playerid, COLOR_RED, "You are not driving a vehicle!");
	new vehicleid = GetPlayerVehicleID(playerid);
	if(IsBicycle(vehicleid)) return SendClientMessage(playerid, COLOR_RED, "You are not driving a vehicle!");
	new id = GetVehicleID(vehicleid);
	if(GetPlayerVehicleAccess(playerid, id) < 1)
		return SendClientMessage(playerid, COLOR_RED, "You don't have the keys for this vehicle!");
	SetPVarInt(playerid, "DialogValue1", id);
	ShowDialog(playerid, DIALOG_VEHICLE);
	return 1;
}

CMD:sellv(playerid, params[])
{
	new pid, id, price, msg[128];
	if(sscanf(params, "udd", pid, id, price)) return SendClientMessage(playerid, COLOR_GREY, "USAGE: /sellv [player] [vehicleid] [price]");
	if(!IsPlayerConnected(pid)) return SendClientMessage(playerid, COLOR_RED, "Invalid player!");
	if(GetPlayerVehicleAccess(playerid, id) < 2)
		return SendClientMessage(playerid, COLOR_RED, "You are not the owner of this vehicle!");
	if(price < 1) return SendClientMessage(playerid, COLOR_RED, "Invalid price!");
	if(!PlayerToPlayer(playerid, pid, 10.0)) return SendClientMessage(playerid, COLOR_RED, "Player is too far!");
	SetPVarInt(pid, "DialogValue1", playerid);
	SetPVarInt(pid, "DialogValue2", id);
	SetPVarInt(pid, "DialogValue3", price);
	ShowDialog(pid, DIALOG_VEHICLE_SELL);
	format(msg, sizeof(msg), "You have offered %s (%d) to buy your vehicle for $%d", PlayerName(pid), pid, price);
	SendClientMessage(playerid, COLOR_WHITE, msg);
	return 1;
}

CMD:trunk(playerid, params[])
{
	new vehicleid = GetClosestVehicle(playerid);
	if(!PlayerToVehicle(playerid, vehicleid, 5.0)) vehicleid = 0;
	if(!vehicleid || IsBicycle(vehicleid) || IsPlayerInAnyVehicle(playerid))
		return SendClientMessage(playerid, COLOR_RED, "You are not close to a vehicle!");
	new id = GetVehicleID(vehicleid);
	if(!IsValidVehicle(id)) return SendClientMessage(playerid, COLOR_RED, "You don't have the keys for this vehicle!");
	if(GetPlayerVehicleAccess(playerid, id) < 2)
		return SendClientMessage(playerid, COLOR_RED, "You don't have the keys for this vehicle!");
	ToggleBoot(vehicleid, VEHICLE_PARAMS_ON);
	SetPVarInt(playerid, "DialogValue1", id);
	ShowDialog(playerid, DIALOG_TRUNK);
	return 1;
}

CMD:rac(playerid, params[])
{
	if(!IsPlayerAdmin(playerid)) return SendClientMessage(playerid, COLOR_RED, "You are not admin!");
	new bool:vehicleused[MAX_VEHICLES];
	for(new i=0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i) && IsPlayerInAnyVehicle(i))
		{
			vehicleused[GetPlayerVehicleID(i)] = true;
		}
	}
	for(new i=1; i < MAX_VEHICLES; i++)
	{
		if(!vehicleused[i])
		{
			SetVehicleToRespawn(i);
		}
	}
	new msg[128];
	format(msg, sizeof(msg), "Admin %s (%d) has respawned all unused vehicles", PlayerName(playerid), playerid);
	SendClientMessageToAll(COLOR_YELLOW, msg);
	return 1;
}

CMD:addv(playerid, params[])
{
	if(!IsPlayerAdmin(playerid)) return SendClientMessage(playerid, COLOR_RED, "You are not admin!");
	if(!IsPlayerSpawned(playerid)) return SendClientMessage(playerid, COLOR_RED, "You can't use this command now!");
	new model[32], modelid, dealerid, color1, color2, price;
	if(sscanf(params, "dsddd", dealerid, model, color1, color2, price))
		return SendClientMessage(playerid, COLOR_GREY, "USAGE: /addv [dealerid] [model] [color1] [color2] [price]");
	if(!IsValidDealership(dealerid)) return SendClientMessage(playerid, COLOR_RED, "Invalid dealerid!");
	if(IsNumeric(model)) modelid = strval(model);
	else modelid = GetVehicleModelIDFromName(model);
	if(modelid < 400 || modelid > 611) return SendClientMessage(playerid, COLOR_RED, "Invalid model ID!");
	if(color1 < 0 || color2 < 0) return SendClientMessage(playerid, COLOR_RED, "Invalid color!");
	if(price < 0) return SendClientMessage(playerid, COLOR_RED, "Invalid price!");
	new Float:X, Float:Y, Float:Z, Float:angle;
	GetPlayerPos(playerid, X, Y, Z);
	GetPlayerFacingAngle(playerid, angle);
	X += floatmul(floatsin(-angle, degrees), 4.0);
	Y += floatmul(floatcos(-angle, degrees), 4.0);
	for(new i=1; i < MAX_DVEHICLES; i++)
	{
		if(!VehicleCreated[i])
		{
			new msg[128];
			VehicleCreated[i] = VEHICLE_DEALERSHIP;
			VehicleModel[i] = modelid;
			VehiclePos[i][0] = X;
			VehiclePos[i][1] = Y;
			VehiclePos[i][2] = Z;
			VehiclePos[i][3] = angle+90.0;
			VehicleColor[i][0] = color1;
			VehicleColor[i][1] = color2;
			VehicleInterior[i] = GetPlayerInterior(playerid);
			VehicleWorld[i] = GetPlayerVirtualWorld(playerid);
			VehicleValue[i] = price;
			valstr(VehicleOwner[i], dealerid);
			valstr(CarKeyOwner[i], dealerid);
			VehicleNumberPlate[i] = DEFAULT_NUMBER_PLATE;
			for(new d=0; d < sizeof(VehicleTrunk[]); d++)
			{
				VehicleTrunk[i][d][0] = 0;
				VehicleTrunk[i][d][1] = 0;
			}
			for(new d=0; d < sizeof(VehicleMods[]); d++)
			{
				VehicleMods[i][d] = 0;
			}
			VehiclePaintjob[i] = 255;
			VehicleLock[i] = 0;
			UpdateVehicle(i, 0);
			SaveVehicle(i);
			format(msg, sizeof(msg), "Added vehicle id %d to dealerid %d", i, dealerid);
			SendClientMessage(playerid, COLOR_WHITE, msg);
			return 1;
		}
	}
	SendClientMessage(playerid, COLOR_RED, "You can't add any more vehicles!");
	return 1;
}

CMD:editv(playerid, params[])
{
	if(!IsPlayerAdmin(playerid)) return SendClientMessage(playerid, COLOR_RED, "You are not admin!");
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{
		new id = GetVehicleID(GetPlayerVehicleID(playerid));
		if(!IsValidVehicle(id)) return SendClientMessage(playerid, COLOR_RED, "This is not a dynamic vehicle!");
		SetPVarInt(playerid, "DialogValue1", id);
		ShowDialog(playerid, DIALOG_EDITVEHICLE);
		return 1;
	}
	new vehicleid;
	if(sscanf(params, "d", vehicleid)) return SendClientMessage(playerid, COLOR_GREY, "USAGE: /editv [vehicleid]");
	if(!IsValidVehicle(vehicleid)) return SendClientMessage(playerid, COLOR_RED, "Invalid vehicleid!");
	SetPVarInt(playerid, "DialogValue1", vehicleid);
	ShowDialog(playerid, DIALOG_EDITVEHICLE);
	return 1;
}

CMD:adddealership(playerid, params[])
{
	if(!IsPlayerAdmin(playerid)) return SendClientMessage(playerid, COLOR_RED, "You are not admin!");
	if(!IsPlayerSpawned(playerid)) return SendClientMessage(playerid, COLOR_RED, "You can't use this command now!");
	for(new i=1; i < MAX_DEALERSHIPS; i++)
	{
		if(!DealershipCreated[i])
		{
			new msg[128];
			DealershipCreated[i] = 1;
			GetPlayerPos(playerid, DealershipPos[i][0], DealershipPos[i][1], DealershipPos[i][2]);
			UpdateDealership(i, 0);
			SaveDealership(i);
			format(msg, sizeof(msg), "Added dealership id %d", i);
			SendClientMessage(playerid, COLOR_WHITE, msg);
			return 1;
		}
	}
	SendClientMessage(playerid, COLOR_RED, "Can't add any more dealerships!");
	return 1;
}

CMD:deletedealership(playerid, params[])
{
	if(!IsPlayerAdmin(playerid)) return SendClientMessage(playerid, COLOR_RED, "You are not admin!");
	new dealerid, msg[128];
	if(sscanf(params, "d", dealerid)) return SendClientMessage(playerid, COLOR_GREY, "USAGE: /deletedealership [dealerid]");
	if(!IsValidDealership(dealerid)) return SendClientMessage(playerid, COLOR_RED, "Invalid dealerid!");
	for(new i=1; i < MAX_DVEHICLES; i++)
	{
		if(VehicleCreated[i] == VEHICLE_DEALERSHIP && strval(VehicleOwner[i]) == dealerid)
		{
			DestroyVehicle(VehicleID[i]);
			Delete3DTextLabel(VehicleLabel[i]);
			VehicleCreated[i] = 0;
		}
	}
	DealershipCreated[dealerid] = 0;
	Delete3DTextLabel(DealershipLabel[dealerid]);
	SaveDealership(dealerid);
	format(msg, sizeof(msg), "Deleted dealership id %d", dealerid);
	SendClientMessage(playerid, COLOR_WHITE, msg);
	return 1;
}

CMD:movedealership(playerid, params[])
{
	if(!IsPlayerAdmin(playerid)) return SendClientMessage(playerid, COLOR_RED, "You are not admin!");
	new dealerid, msg[128];
	if(sscanf(params, "d", dealerid)) return SendClientMessage(playerid, COLOR_GREY, "USAGE: /movedealership [dealerid]");
	if(!IsValidDealership(dealerid)) return SendClientMessage(playerid, COLOR_RED, "Invalid dealerid!");
	GetPlayerPos(playerid, DealershipPos[dealerid][0], DealershipPos[dealerid][1], DealershipPos[dealerid][2]);
	UpdateDealership(dealerid, 1);
	SaveDealership(dealerid);
	format(msg, sizeof(msg), "Moved dealership id %d here", dealerid);
	SendClientMessage(playerid, COLOR_WHITE, msg);
	return 1;
}

CMD:gotodealership(playerid, params[])
{
	if(!IsPlayerAdmin(playerid)) return SendClientMessage(playerid, COLOR_RED, "You are not admin!");
	new dealerid, msg[128];
	if(sscanf(params, "d", dealerid)) return SendClientMessage(playerid, COLOR_GREY, "USAGE: /gotodealership [dealerid]");
	if(!IsValidDealership(dealerid)) return SendClientMessage(playerid, COLOR_RED, "Invalid dealerid!");
	SetPlayerPos(playerid, DealershipPos[dealerid][0], DealershipPos[dealerid][1], DealershipPos[dealerid][2]);
	format(msg, sizeof(msg), "Teleported to dealership id %d", dealerid);
	SendClientMessage(playerid, COLOR_WHITE, msg);
	return 1;
}

forward RainbowCar(playerid, vehicleid);
public RainbowCar(playerid, vehicleid)
{
ChangeVehicleColor(vehicleid, RandomColor(), RandomColor());
return 1;
}

forward Speedometer(playerid);
public Speedometer(playerid)
{
   new nvehicleid = GetPlayerVehicleID(playerid);//wenn jmd im auto ist funktioniert es für den anderen nicht
   new tmp_engine, tmp_lights, tmp_alarm, tmp_doors, tmp_hood, tmp_boot, tmp_objective;
   new string[100], strrr[50], struing[50];
   if(IsPlayerConnected(playerid) && (IsPlayerDriver(playerid) && !IsAMountainBike(GetPlayerVehicleID(playerid)) && !IsAAircraft(GetPlayerVehicleID(playerid)) && !IsABoat(GetPlayerVehicleID(playerid))))
	  {
		  new Speed = GetPlayerSpeed(playerid)*107/100;
		  nvehicleid = GetPlayerVehicleID(playerid);
		  if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
		  {
			 if((!IsABoat(nvehicleid) && (!IsAAircraft(nvehicleid) && Fuel[nvehicleid] > 0)))
			 SetPVarInt(playerid, "KEINSPRIT", 0);
			 {
	             if (tmp_engine == 1)
				 {
				    //?
				 }
				 else
				 {
				    new id = GetVehicleID(nvehicleid);
				    if(IsValidVehicle(id))
				    {
					   if(VehicleCheckEngine[id] >= 5 || VehicleBatteryLight[id] >= 3)
					   {
					      SendWarningText(playerid, "Your car is dead. Call a car mechanic.");
					   }
				    }
				    new Keys, ud, lr;
				    GetPlayerKeys(playerid, Keys, ud, lr);
				    if (Keys == KEY_SPRINT || Keys == KEY_JUMP)
				    {
        			   Fuel[nvehicleid] -= GetPlayerSpeed(playerid)/3000.0*GetPlayerSpeed(playerid)/500.0;
        			   if(IsValidVehicle(GetVehicleID(nvehicleid)))
        			   {
					      VehicleFuel[GetVehicleID(nvehicleid)] = Fuel[nvehicleid];
					      SaveVehicle(GetVehicleID(nvehicleid));//hier vielleciht nicht so oft speichern für performance?
        			   }
				    }
				    if(Fuel[nvehicleid] <= 1.0 && Fuel[nvehicleid] > 0)
				    {
					   SendWarningText(playerid, "Warning:~n~Low Fuel!");
				    }
				    if(Fuel[nvehicleid] <= 0)
				    {
					   SendWarningText(playerid, "You are out of Fuel.");
					   SetPVarInt(playerid, "KEINSPRIT", 1);
                       PlayerTextDrawSetPreviewRot(playerid,PlayerText:Spritnadel[playerid],0.000000, 90.0, 0.000000, 2.000000);
                       if(GetPVarInt(playerid, "TachoHide") == 0)
                       {
                          PlayerTextDrawShow(playerid,PlayerText:Spritnadel[playerid]);
                       }
					   GetVehicleParamsEx(nvehicleid,tmp_engine, tmp_lights, tmp_alarm, tmp_doors, tmp_hood, tmp_boot, tmp_objective);
					   if (tmp_engine == 1)
					   {
				  		 tmp_engine = 0;
					   }
					   SetVehicleParamsEx(nvehicleid, tmp_engine, tmp_lights, tmp_alarm, tmp_doors, tmp_hood, tmp_boot, tmp_objective);

				 }
				 if(Fuel[nvehicleid] <= 100)
				 PlayerTextDrawHide(playerid,PlayerText:Spritnadel[playerid]);
				 {
				    PlayerTextDrawSetPreviewRot(playerid,PlayerText:Spritnadel[playerid],0.000000, -(Fuel[nvehicleid] * 100 / 110) + 90, 0.000000, 2.000000);
				    if(GetPVarInt(playerid, "TachoHide") == 0)
				    {
                       PlayerTextDrawShow(playerid,PlayerText:Spritnadel[playerid]);
				    }
				 }
			 }
		  }
	      Checklights(playerid);
		  if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
		  {
		   if(GetPVarInt(playerid, "KMLaden") == 0)
		   {
		       Milage[nvehicleid] = 0;
		   }
           Milage[nvehicleid] += GetPlayerSpeed(playerid)/3600.0 + KMGet(playerid);
           if(Speed > 10 && Tankgeld[playerid] > -1)
           {
              ToggleCarRefueling(playerid, nvehicleid, 0);
           }
           if(Speed >= 250)
           {
              format(strrr,sizeof(strrr), "~%s~WTF", SpeedColor(Speed,playerid));
           }
           else
           {
		      format(strrr,sizeof(strrr), "~%s~%03d km/h", SpeedColor(Speed,playerid), Speed);
		   }
		   new Keys, ud, lr;
		   GetPlayerKeys(playerid, Keys, ud, lr);
		   GetVehicleParamsEx(nvehicleid,tmp_engine, tmp_lights, tmp_alarm, tmp_doors, tmp_hood, tmp_boot, tmp_objective);
		   if(Speed >= 5)
		   {
			  if(tmp_engine == 1)
			  {
			     if(IsVehicleDrivingBackwards(nvehicleid))
			     {
			        TextDrawSetString(Tacho[playerid][55], "R");
			     }
			     else
			     {
				    new gear;
				    gear = (Speed/46)+1;
				    format(string, sizeof string, "D%i", gear);
			        TextDrawSetString(Tacho[playerid][55], string);
			     }
			  }
			  else
			  {
			     TextDrawSetString(Tacho[playerid][55], "N");
			  }
		   }
		   else
		   {
              if(Keys & KEY_SPRINT)
              {
			     TextDrawSetString(Tacho[playerid][55], "D1");
              }
              else if(Keys == KEY_JUMP)
              {
			     TextDrawSetString(Tacho[playerid][55], "R");
              }
              else
              {
			     TextDrawSetString(Tacho[playerid][55], "P");
              }
              if(tmp_engine == 1)
              {
                 Fuel[nvehicleid] = Fuel[nvehicleid] - 0.00075;
              }
		   }
		   PlayerTextDrawSetString(playerid, KMH[playerid], strrr);
		   IsPlayerInRangeOf50Blitzer(Speed,playerid);
		   //IsPlayerInRangeOf70Blitzer(Speed,playerid);
	       if(Tankgeld[playerid] <= 0 && IsPlayerInRangeOfPoint(playerid, 10, -2244.039, -2560.533, 31.4433) || IsPlayerInRangeOfPoint(playerid, 15, -1606.454, -2713.569, 48.263)
		   || IsPlayerInRangeOfPoint(playerid, 15, -90.469, -1169.377, 2.08) || IsPlayerInRangeOfPoint(playerid, 10, 655.395, -564.952, 16.063)
		   || IsPlayerInRangeOfPoint(playerid, 17, 1939.911, -1772.952, 13.429) || IsPlayerInRangeOfPoint(playerid, 8, 1382.883, 461.044, 20.153)
		   || IsPlayerInRangeOfPoint(playerid, 15, 2115.139, 920.078, 10.747) || IsPlayerInRangeOfPoint(playerid, 15, 2639.861, 1106.467, 10.747)
		   || IsPlayerInRangeOfPoint(playerid, 15, 1597.118, 2199.466, 10.747) || IsPlayerInRangeOfPoint(playerid, 15, 2147.286, 2748.268, 10.747)
		   || IsPlayerInRangeOfPoint(playerid, 22, 614.595, 1691.086, 7.011) || IsPlayerInRangeOfPoint(playerid, 15, -1328.356, 2677.409, 49.99)
		   || IsPlayerInRangeOfPoint(playerid, 15, -1471.582, 1864.145, 32.56) || IsPlayerInRangeOfPoint(playerid, 15, -2412.453, 976.237, 45.302))
		   {
              if(Fuel[GetPlayerVehicleID(playerid)] < 99 && Tankgeld[playerid] <= 0)
              {
                 format(string, sizeof string, "Hold ~k~~VEHICLE_FIREWEAPON~ ~n~to refuel");
                 SendInfoText(playerid, string);
              }
		   }
		   if(IsPlayerInRangeOfPoint(playerid, 10, -1870.0823,-1681.9326,21.7594))
		   {
		      if(IsValidVehicle(GetVehicleID(GetPlayerVehicleID(playerid)))
		      && strcmp(VehicleOwner[GetVehicleID(GetPlayerVehicleID(playerid))], GetSname(playerid)) == 0)
		      {
                 format(string, sizeof string, "Warning: If you press ~k~~VEHICLE_FIREWEAPON~ you will scrap your car!");
                 SendWarningText(playerid, string);
		      }
		      else
		      {
                 format(string, sizeof string, "Press ~k~~VEHICLE_FIREWEAPON~ ~n~to scrap this car");
                 SendInfoText(playerid, string);
		      }
		   }
		  new Float: health;
		  GetVehicleHealth(nvehicleid, health);
		  new Float: percentage = (((health - 250.0) / (1000.0 - 250.0)) * 100.0);
		  if(percentage <= 0.0)
		  {
		     percentage = 000.0;
		  }
		  format(struing, sizeof(struing), "%03.0f", percentage);
		  if(percentage <= 25 && GetPVarInt(playerid, "TachoHide") == 0)
		  {
              PlayerTextDrawShow(playerid, AutoHP[playerid][1]);
              PlayerTextDrawHide(playerid, AutoHP[playerid][2]);
              PlayerTextDrawHide(playerid, AutoHP[playerid][3]);
              PlayerTextDrawHide(playerid, AutoHP[playerid][4]);
		  }
		  else if(percentage >= 25 && percentage <= 75 && GetPVarInt(playerid, "TachoHide") == 0)
		  {
              PlayerTextDrawShow(playerid, AutoHP[playerid][1]);
              PlayerTextDrawShow(playerid, AutoHP[playerid][2]);
              PlayerTextDrawHide(playerid, AutoHP[playerid][3]);
              PlayerTextDrawHide(playerid, AutoHP[playerid][4]);
		  }
		  else if(percentage >= 75 && percentage <= 100 && GetPVarInt(playerid, "TachoHide") == 0)
		  {
              PlayerTextDrawShow(playerid, AutoHP[playerid][1]);
              PlayerTextDrawShow(playerid, AutoHP[playerid][2]);
              PlayerTextDrawShow(playerid, AutoHP[playerid][3]);
              PlayerTextDrawHide(playerid, AutoHP[playerid][4]);
		  }
		  else if(percentage > 100 && GetPVarInt(playerid, "TachoHide") == 0)
		  {
              PlayerTextDrawShow(playerid, AutoHP[playerid][1]);
              PlayerTextDrawShow(playerid, AutoHP[playerid][2]);
              PlayerTextDrawShow(playerid, AutoHP[playerid][3]);
              PlayerTextDrawShow(playerid, AutoHP[playerid][4]);
		  }
		  PlayerTextDrawSetString(playerid, AutoHP[playerid][0], struing);
		  VHealth(percentage, playerid);

		  if(Fuel[nvehicleid] <= 10)
		  {
		     format(string,sizeof(string), "~r~%d", floatround(Fuel[nvehicleid]*1.0));
		  }
		  else
		  {
		     format(string,sizeof(string), "%d", floatround(Fuel[nvehicleid]*1.0));
		  }
		  PlayerTextDrawSetString(playerid, Sprit[playerid], string);

		  new Float:KMCompare = floatround(Milage[nvehicleid], floatround_floor);
		  if(GetPVarInt(playerid, "VehicleOdo") == 1)
		  {
		     new id = GetVehicleID(nvehicleid);
		     if(IsValidVehicle(id))
		     {
		        format(string,sizeof(string), "%06.0i km", VehicleMileage[id]);
		     }
		     else
		     {
		        format(string,sizeof(string), "%06.0f km", KMCompare);
		     }
		  }
		  else
		  {
		     format(string,sizeof(string), "%06.0f km", KMCompare);
		  }
		  PlayerTextDrawSetString(playerid, Kilometerstand[playerid], string);
		  format(Spieler,sizeof(Spieler),"/Spieler/%s.txt",GetSname(playerid));
		  
		  if(GetPlayerSpeed(playerid) >= 25)
		   {
		    if(IsPlayerInAnyVehicle(playerid))
		     {
		      if(IsAMotorBike(nvehicleid)&& (KMCompare > dini_Float(Spieler, "KMStandMotorrad")))
		      {
		        dini_FloatSet(Spieler,"KMStandMotorrad",KMCompare);
		        new id = GetVehicleID(nvehicleid);
		        if(IsValidVehicle(id))
		        {
				   VehicleMileage[id]++;
				   SaveVehicle(id);
				   new str[70];
		           DebugMessage(playerid, "Motorrad KM gespeichert");
				   format(str, sizeof str, "ID: %i  Mileage: %i", id, VehicleMileage[id]);
				   DebugMessage(playerid, str);
		        }
		      }
		      if(IsATruck(nvehicleid)&& (KMCompare > dini_Float(Spieler, "KMStandLKW")))
		      {
		        dini_FloatSet(Spieler,"KMStandLKW",KMCompare);
		        new id = GetVehicleID(nvehicleid);
		        if(IsValidVehicle(id))
		        {
				   VehicleMileage[id]++;
				   SaveVehicle(id);
				   new str[70];
		           DebugMessage(playerid, "LKW KM gespeichert");
				   format(str, sizeof str, "ID: %i  Mileage: %i", id, VehicleMileage[id]);
				   DebugMessage(playerid, str);
		        }
		      }
		      else if(!IsAAircraft(nvehicleid) && !IsABoat(nvehicleid) && !IsAMountainBike(nvehicleid) && !IsAMotorBike(nvehicleid) && !IsATruck(nvehicleid) && (KMCompare > dini_Float(Spieler, "KMStandAuto")))
              {
		        dini_FloatSet(Spieler,"KMStandAuto",KMCompare);
		        new id = GetVehicleID(nvehicleid);
		        if(IsValidVehicle(id))
		        {
				   VehicleMileage[id]++;
				   SaveVehicle(id);
				   new str[70];
				   format(str, sizeof str, "Auto KM gespeichert: %f", KMCompare);
		           DebugMessage(playerid, str);
				   format(str, sizeof str, "ID: %i  Mileage: %i", id, VehicleMileage[id]);
				   DebugMessage(playerid, str);
		        }
		      }
		      Milage[playerid] = 0;
		    }
		    return 1;
		  }}}}
       return 1;
}

CMD:tankstelle(playerid, params[])
{
	if(!IsPlayerSpawned(playerid)) return SendClientMessage(playerid, COLOR_RED, "You can't use this command now!");
    DisablePlayerCheckpoint(playerid);
	new ttmp, size;
	if(sscanf(params, "ii", ttmp, size)) return SendClientMessage(playerid, Hellrot, "/tankstelle 1 - 999");
		  if(ttmp > 14) return SendClientMessage(playerid, Hellrot, "There are not more than 14 Fuel stations");
		  if(ttmp < 0) return SendClientMessage(playerid, Hellrot, "You have to choose a fuel station");
          if (ttmp == 1)
          {
             DisablePlayerCheckpoint(playerid);
		     SetPlayerCheckpoint(playerid, -2244.039, -2560.533, 31.4433, size); //20
		     SetPlayerPos(playerid, -2244, -2560, 31);
          }
          if ((ttmp) == 2)
          {
             DisablePlayerCheckpoint(playerid);
		     SetPlayerCheckpoint(playerid, -1606.454, -2713.569, 48.263, size);//35
		     SetPlayerPos(playerid, -1606.454, -2713.569, 48.263);
          }
          if ((ttmp) == 3)
          {
             DisablePlayerCheckpoint(playerid);
		     SetPlayerCheckpoint(playerid, -90.469, -1169.377, 2.08, size);//30
		     SetPlayerPos(playerid, -90.469, -1169.377, 2.08);
          }
          if ((ttmp) == 4)
          {
             DisablePlayerCheckpoint(playerid);
		     SetPlayerCheckpoint(playerid, 655.395, -564.952, 16.063, size);//20
		     SetPlayerPos(playerid, 665.395, -564.952, 16.063);
          }
          if ((ttmp) == 5)
          {
             DisablePlayerCheckpoint(playerid);
		     SetPlayerCheckpoint(playerid, 1939.911, -1772.952, 13.429, size);//25
		     SetPlayerPos(playerid, 1939.911, -1772.952, 13.429);
          }
          if ((ttmp) == 6)
          {
             DisablePlayerCheckpoint(playerid);
		     SetPlayerCheckpoint(playerid, 1382.883, 461.044, 20.153, size);//17
		     SetPlayerPos(playerid, 1382.883, 461.044, 20.153);
          }
          if ((ttmp) == 7)
          {
             DisablePlayerCheckpoint(playerid);
		     SetPlayerCheckpoint(playerid, 2115.139, 920.078, 10.747, size);//30
		     SetPlayerPos(playerid, 2115.139, 920.078, 10.747);
          }
          if ((ttmp) == 8)
          {
             DisablePlayerCheckpoint(playerid);
		     SetPlayerCheckpoint(playerid, 2639.861, 1106.467, 10.747, size);//30
		     SetPlayerPos(playerid, 2639.861, 1106.467, 10.747);
          }
          if ((ttmp) == 9)
          {
             DisablePlayerCheckpoint(playerid);
		     SetPlayerCheckpoint(playerid, 1597.118, 2199.466, 10.747, size);//30
		     SetPlayerPos(playerid, 1597.118, 2199.466, 10.747);
          }
          if ((ttmp) == 10)
          {
             DisablePlayerCheckpoint(playerid);
		     SetPlayerCheckpoint(playerid, 2147.286, 2748.268, 10.747, size);//30
		     SetPlayerPos(playerid, 2147.286, 2748.268, 10.747);
          }
          if ((ttmp) == 11)
          {
             DisablePlayerCheckpoint(playerid);
		     SetPlayerCheckpoint(playerid, 614.595, 1691.086, 7.011, size);//45
		     SetPlayerPos(playerid, 614.595, 1691.086, 7.011);
          }
          if ((ttmp) == 12)
          {
             DisablePlayerCheckpoint(playerid);
		     SetPlayerCheckpoint(playerid, -1328.356, 2677.409, 49.99,  size);//30
		     SetPlayerPos(playerid, -1328.356, 2677.409, 49.99);
          }
          if ((ttmp) == 13)
          {
             DisablePlayerCheckpoint(playerid);
		     SetPlayerCheckpoint(playerid, -1471.582, 1864.145, 32.56, size);//30
		     SetPlayerPos(playerid, -1471.582, 1864.145, 32.56);
          }
          if ((ttmp) == 14)
          {
             DisablePlayerCheckpoint(playerid);
		     SetPlayerCheckpoint(playerid, -2412.453, 976.237, 45.302, size);//30
		     SetPlayerPos(playerid, -2412.453, 976.237, 45.302);
          }
	return 1;
}

forward FuelTimer(playerid, vehicleid);
public FuelTimer(playerid, vehicleid)
{
   if(!IsValidVehicle(GetVehicleID(vehicleid))) return 1;
   new string[20];
   format(string, sizeof string, "%f", Fuel[vehicleid]);
   SendClientMessage(playerid, Weis, string);
   return 1;
}

stock getINIString(filename[], section[], item[], result[])
{
  new File:inifile;
  new line[512];
  new sectionstr[64], itemstr[64];
  new sectionfound = 0;

  inifile = fopen( filename, io_read );
  if( !inifile ) {
    printf( "FATAL: Couldn't open \"%s\"!", filename);
    return 0;
  }

  format( sectionstr, 64, "[%s]", section );
  format( itemstr, 64, "%s=", item );

  while( fread( inifile, line )) {
    line[strlen( line )-2] = 0; /* Remove \r\n */

    if( line[0] == 0 ) {
      continue;
    }

    /* If !sectionfound is true, we're looking for the proper section. */
    if( /*!*/sectionfound ) {
      /* Check if wanted section is being opened. */
      if( !strcmp( line, sectionstr, true, strlen( sectionstr ))) {
        sectionfound = 1;
      }
    }
    else { /* Itemmode from here. */
      /* We're leaving the wanted section and didn't find the value yet.
       * So we'll never reach it. */
      if( line[0] == '[' ) {
        return 0;
       }

      /* Have we reached our wanted INI item? */
      if( !strcmp( line, itemstr, true, strlen( itemstr ))) {
        format( result, sizeof( line ), "%s", line[strlen( itemstr )] );
        return 1;
      }
    }
  }
  fclose(inifile);
  return 0;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	new ccmd[256+1], idxx;
	ccmd = strtok(cmdtext, idxx);
	if(strcmp(ccmd, "/addblitzer", true) == 0)
	{
	    if(IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid, Hellrot, "Get out of your shitbox");
	    {
		   new ttmp[256+1];
		   ttmp = strtok(cmdtext, idxx);
		   if(strval(ttmp) != 50 && strval(ttmp) != 70) return SendClientMessage(playerid, Hellrot, "/addblitzer 50 / 70");
		   new Float:X, Float: Y, Float:Z, Float:A;
		   GetPlayerPos(playerid, X, Y, Z);
		   GetPlayerFacingAngle(playerid, A);
		   CreateObject(18880, X, Y, Z-3.5, 0, 0, A+180);
		   SetPlayerPos(playerid, X, Y, Z+7);
		   SendClientMessage(playerid, Hellgrün, "Blitzer erstellt");//hier blitzer
		   for(new i=0;i<MAX_BLITZER;i++)
		   {
		      new string[75];
		      format(string, sizeof string, "b%i.ini", i);
		      format(string, sizeof string, "%s%s", BLITZER_FILE_PATH, string);
		      if(!fexist(string))
		      {
                 new File:ftw=fopen(string, io_write);
                 fwrite(ftw, "Created=0");
                 fclose(ftw);
		      }
		   }
		   /*for(new i=0;i<MAX_BLITZER;i++)
		   {
			  //if(i > 50) return 1;//max blitzer max. blitzer
			  new string[75];
		      format(string, sizeof string, "b%i.ini", i);
		      format(string, sizeof string, "%s%s", BLITZER_FILE_PATH, string);
		      if(!fexist(string))
		      {
                 new File:ftw=fopen(string, io_write);
                 fwrite(ftw, "Created=0");
			     SendClientMessage(playerid, Weis, "New file!");
                 fclose(ftw);
		      }
			  SendClientMessage(playerid, Weis, string);
			  getINIString(string, " ", "Created", ccmd);
			  SendClientMessage(playerid, Weis, ccmd);//wird nicht erkannt wird nicht gefunden
			  if(strval(ccmd) == 1)
			  {
			     return SendClientMessage(playerid, Weis, "Schon benutzt!");
			  }
			  if(strval(ccmd) == 0)
			  {
			     //neuer Blitzer
			     format(ccmd, sizeof ccmd, "Created=1\nGeschwindigkeit=%i\nPos=%f,%f,%f,%f\nBlitzercounter=0\nDurch_Geschwindigkeit=%i", strval(ttmp), X, Y, Z, A+180, 0);
		         if(!fexist(string)) return SendClientMessage(playerid, Weis, "No file!");
			     new File:ftw=fopen(string, io_write);
			     Wika(playerid);
                 fwrite(ftw, ccmd);
                 fclose(ftw);
			     //return SendClientMessage(playerid, Weis, ccmd);
			     //CreateBlitzer();
			  }
		   }*/
	    }
	    return 1;
	}
	if(strcmp("/tuning", cmdtext, true, 10) ==0)
	{
	   if(!IsPlayerInAnyVehicle(playerid))
	   {
		  new lol = CreateVehicle(576, -1944.9631,224.0898,33.7846, 0, 226, 0, 99999);
		  PutPlayerInVehicle(playerid, lol, 0);
	   }
	   KillTimer(RainbowCarTimer1);
	   KillTimer(RainbowCarTimer2);
	   KillTimer(Rainbowmodshopcartimer);
	   KillTimer(Rainbowmodshopcolortimer);
	   Speedometer_Disable(playerid);
	   new vehicleid = GetPlayerVehicleID(playerid);
	   SetPVarInt(playerid, "VehicleID", vehicleid);
	   SetVehiclePos(vehicleid, 3616.8911,2988.6980,1002.5);
	   SetVehicleZAngle(vehicleid, 89.8974);
	   InterpolateCameraPos(playerid, 606.746948+modshoppos, -7.408711+modshoppos, 1003.267333, 606.746948+modshoppos, -7.408711+modshoppos, 1003.267333, 1000);
	   InterpolateCameraLookAt(playerid, 611.242797+modshoppos, -9.439126+modshoppos, 1002.452026, 611.242797+modshoppos, -9.439126+modshoppos, 1002.452026, 1000);
       SelectTextDraw(playerid, TextdrawFarbe);
	   /*SetPlayerInterior(playerid, 1);
	   LinkVehicleToInterior(vehicleid, 1);*/
	   SetVehicleVirtualWorld(vehicleid, playerid);
	   SetPlayerVirtualWorld(playerid, playerid);
	   //MODSHOP-TEXTDRAWS
	   PlayerTextDrawShow(playerid, PlayerText:TuningEnter[playerid]);
	   PlayerTextDrawShow(playerid, PlayerText:TuningEnter_[playerid]);
	   if(!IsValidVehicle(GetVehicleID(vehicleid)))
	   {
	      PlayerTextDrawSetString(playerid, TuningEnter_[playerid], "Let's tune it! ~n~~r~Warning: This is a public Vehicle, no modifications you do to the car will be saved!");
	   }
	   if (strcmp(VehicleOwner[GetVehicleID(vehicleid)], GetSname(playerid)) == 1)
	   {
	      PlayerTextDrawSetString(playerid, TuningEnter_[playerid], "Let's tune it! ~n~~r~Warning: This is not your Vehicle, no modifications you do to the car will be saved!");
	   }
	   else
	   {
	      PlayerTextDrawSetString(playerid, TuningEnter_[playerid], "Let's tune it!");
	   }
	   PlayerTextDrawShow(playerid, PlayerText:TuningLeave[playerid]);
	   PlayerTextDrawShow(playerid, PlayerText:TuningLeave_[playerid]);
	   SetPVarString(playerid, "Modshop", "Farben");
	   PlayerTextDrawSetString(playerid, TuningLeave_[playerid], "Leave");
	   RepairVehicle(vehicleid);

	   new string[25];
	   format(string, sizeof string, "VID SAVED: %i", vehicleid);
	   DebugMessage(playerid, string);
	   return 1;
	}
	if(strcmp(cmdtext, "/xenia", true) == 0)
	{
	    new string[50];
	    if(IsPlayerInAnyVehicle(playerid))
	    {
		   new vehicleid = GetPlayerVehicleID(playerid);
		   SetPVarInt(playerid, "MechJobvid", vehicleid);
		   format(string, sizeof string, "Vehicle ID: %i", vehicleid);
		   SendClientMessage(playerid, Weis, string);
	    }
	    else
	    {
		   SendClientMessage(playerid, Hellrot, "You have to be in a car!");
		   SetPlayerPos(playerid, 238.7927,25.4719,2.5781);
	    }
	}
	if(strcmp(cmdtext, "/fueltimer", true) == 0)
	{
	    if(IsPlayerInAnyVehicle(playerid))
	    {
		   new vehicleid = GetPlayerVehicleID(playerid);
		   SetTimerEx("FuelTimer", 100, true, "ii", playerid, vehicleid);
	    }
	}
    if(strcmp(ccmd, "/setfuel", true) == 0)
	{
	    new vehicleid = GetPlayerVehicleID(playerid);
	    if(!IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid, Hellrot, "You are not in a car");
	    {
		  new ttmp[256+1];
		  ttmp = strtok(cmdtext, idxx);
		  if(strlen(ttmp) == 0) return SendClientMessage(playerid, Hellrot, "/setfuel amount_of_fuel");
		  if(strval(ttmp) > 100) return SendClientMessage(playerid, Hellrot, "You cannot have more than 100%% Fuel");
		  if(strval(ttmp) < 0) return SendClientMessage(playerid, Hellrot, "You cannot have less than 0%% Fuel");
		  Fuel[vehicleid] = (strval(ttmp));
	    }
	    return 1;
	}
    if(strcmp(ccmd, "/tankstelle", true) == 0)
	{
	    if(IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid, Hellrot, "You are in a car");
	    {
          new ttmp[256+1];
		  ttmp = strtok(cmdtext, idxx);
		  if(strlen(ttmp) == 0) return SendClientMessage(playerid, Hellrot, "/tankstelle tankstellennummer");
		  if(strval(ttmp) < 0) return SendClientMessage(playerid, Hellrot, "Du bist echt dumm");
		  switch(strval(ttmp))
		  {
		     case 1: return SetPlayerPos(playerid, -2244.039, -2560.533, 31.4433);
			 case 2: return SetPlayerPos(playerid, -1606.454, -2713.569, 48.263);
			 case 3: return SetPlayerPos(playerid, -90.469, -1169.377, 2.08);
			 case 4: return SetPlayerPos(playerid, 655.395, -564.952, 16.063);
			 case 5: return SetPlayerPos(playerid, 1939.911, -1772.952, 13.429);
			 case 6: return SetPlayerPos(playerid, 1382.883, 461.044, 20.153);
			 case 7: return SetPlayerPos(playerid, 2115.139, 920.078, 10.747);
			 case 8: return SetPlayerPos(playerid, 2639.861, 1106.467, 10.747);
			 case 9: return SetPlayerPos(playerid, 1597.118, 2199.466, 10.747);
			 case 10: return SetPlayerPos(playerid, 2147.286, 2748.268, 10.747);
			 case 11: return SetPlayerPos(playerid, 614.595, 1691.086, 7.011);
			 case 12: return SetPlayerPos(playerid, -1328.356, 2677.409, 49.99);
			 case 13: return SetPlayerPos(playerid, -1471.582, 1864.145, 32.56);
			 case 14: return SetPlayerPos(playerid, -2412.453, 976.237, 45.302);
		  }
	    }
	    return 1;
	}
    if(strcmp(ccmd, "/getfuel", true) == 0)
	{
	    new vehicleid = GetPlayerVehicleID(playerid);
	    if(!IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid, Hellrot, "You are not in a car");
	    {
		  new string[35];
		  format(string, sizeof string, "Normal: %f", Fuel[vehicleid]);
		  SendClientMessage(playerid, Weis, string);
		  format(string, sizeof string, "ValidVeh: %f", VehicleFuel[vehicleid]);
		  SendClientMessage(playerid, Weis, string);
	    }
	    return 1;
	}
    if(strcmp(ccmd, "/sethealth", true) == 0)
	{
	    new vehicleid = GetPlayerVehicleID(playerid);
	    if(!IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid, Hellrot, "You are not in a car");
	    {
		  new ttmp[256+1];
		  ttmp = strtok(cmdtext, idxx);
		  if(strlen(ttmp) == 0) return SendClientMessage(playerid, Hellrot, "/sethealth health");
		  if(strval(ttmp) > 175) return SendClientMessage(playerid, Hellrot, "You cannot have more than 200%% Health");
		  if(strval(ttmp) < 0) return SendClientMessage(playerid, Hellrot, "You cannot have less than 0%% Health");
		  SetVehicleHealth(vehicleid, strval(ttmp)*10.0);
	    }
	    return 1;
	}
    if(strcmp(cmdtext, "/gethealth", true) == 0)
	{
	    new vehicleid = GetPlayerVehicleID(playerid);
	    if(!IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid, Hellrot, "You are not in a car");
	    {
		  new Float: Health;
		  new string[30];
		  GetVehicleHealth(vehicleid, Health);
		  format(string, sizeof string, "Zustand: %f", Health);
		  SendClientMessage(playerid, Weis, string);
	    }
	    return 1;
	}
    if(strcmp(cmdtext, "/km", true) == 0)
	{
		new string[20];
	    format(string, sizeof string, "%f", Milage[GetPlayerVehicleID(playerid)]);
	    SendClientMessage(playerid, Hellblau, string);
	    return 1;
	}
	if(strcmp(ccmd, "/rainbow", true) == 0)
	{
	    new vehicleid = GetPlayerVehicleID(playerid);
	    if(!IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid, Hellrot, "You are not in a car");
	    {
		  new ttmp[256+1];
		  ttmp = strtok(cmdtext, idxx);
		  if(strlen(ttmp) == 0) return SendClientMessage(playerid, Hellrot, "/wika timer_in_milliseconds (1000 milliseconds is 1 second) recommended: something around 300");
		  if(strval(ttmp) < 100) return SendClientMessage(playerid, Hellrot, "Dont do it under 0.1 seconds. If it changes color every 0.1 seconds, it change color in a total of 10 times PER SECOND.");
		  KillTimer(RainbowCarTimer);
		  RainbowCarTimer = SetTimerEx("RainbowCar", (strval(ttmp)), true, "%i, %i", playerid, vehicleid);
		  RainbowColor[vehicleid] = 1;
		  new string[65];
		  format(string, sizeof string, "Rainbow on with a changetime of %i seconds (%i milliseconds)", strval(ttmp)/1000, strval(ttmp));
		  SendClientMessage(playerid, Hellgrün, string);
	    }
	    return 1;
	}
	if(strcmp("/rainbowoff", cmdtext, true, 10) ==0)
	{
	    new vehicleid = GetPlayerVehicleID(playerid);
	    if(!IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid, Hellrot, "You are not in a car");
	    if(RainbowColor[vehicleid] == 1)
	    {
		  KillTimer(RainbowCarTimer);
		  RainbowColor[vehicleid] = 0;
		  SendClientMessage(playerid, Hellblau, "Rainbow off");
 	    }
	    if(RainbowColor[vehicleid] == 0)
	    {
		  SendClientMessage(playerid, Hellrot, "Rainbow is already off");
 	    }
 	    return 1;
	}
	if(strcmp("/myvehicles", cmdtext, true, 10) ==0)
	{
	   new info[256], bool:found;
	   for(new i=1; i < MAX_DVEHICLES; i++)
	   {
	      if(VehicleCreated[i] == VEHICLE_PLAYER && strcmp(VehicleOwner[i], GetSname(playerid)) == 0)
		  {
	         found = true;
			 format(info, sizeof(info), "%s%s %d\n", info, VehicleNames[VehicleModel[i]-400], i);
		  }
	   }
	   if(!found) return SendClientMessage(playerid, COLOR_RED, "You don't have any vehicles!");
	   ShowPlayerDialog(playerid, MYVMENU, DIALOG_STYLE_LIST, "All your Vehicles", info, "Select", "Exit");
    }
	{
	   new pos, funcname[32];
	   while(cmdtext[++pos] > ' ')
	   {
		  funcname[pos-1] = tolower(cmdtext[pos]);
	   }
	   strins(funcname, "cmd_", 0, sizeof(funcname));
	   while (cmdtext[pos] == ' ') pos++;
	   if(!cmdtext[pos])
	   {
		  return CallLocalFunction(funcname, "is", playerid, "\1");
	   }
	   return CallLocalFunction(funcname, "is", playerid, cmdtext[pos]);
	}
}

/*forward GetDealershipVehicleNames(dealership);
public GetDealershipVehicleNames(dealership)
{
   new string[50];
   if (dealership == 1)
   {
   }
   else if (dealership == 2)
   {
   }
   else if (dealership == 3)
   {
   }
   else if (dealership == 4)
   {
   }
   else if (dealership == 5)
   {
	  new id1, id2, id3;
	  format(string, sizeof string, "%s \n%s \n%s", id1, id2, id3);
	  return string;
   }
   return string;
}*/

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	if(IsPlayerInAnyVehicle(playerid) && !IsAMountainBike(GetPlayerVehicleID(playerid)) && !IsAAircraft(GetPlayerVehicleID(playerid)) && !IsABoat(GetPlayerVehicleID(playerid)))
	{
		new vehicleid = GetPlayerVehicleID(playerid);
	    if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	    {
		   new id = GetVehicleID(vehicleid);
		   if (VehicleLock[id] == 1)
		   {
			  TextDrawShowForPlayer(playerid, Locked[playerid][0]);
			  TextDrawShowForPlayer(playerid, Locked[playerid][1]);
			  TextDrawShowForPlayer(playerid, Locked[playerid][2]);
			  TextDrawShowForPlayer(playerid, Locked[playerid][3]);
			  TextDrawShowForPlayer(playerid, Tacho[playerid][51]);
		   }
		   if (VehicleLock[id] == 0)
		   {
			  TextDrawHideForPlayer(playerid, Locked[playerid][0]);
			  TextDrawHideForPlayer(playerid, Locked[playerid][1]);
			  TextDrawHideForPlayer(playerid, Locked[playerid][2]);
			  TextDrawHideForPlayer(playerid, Locked[playerid][3]);
			  TextDrawHideForPlayer(playerid, Tacho[playerid][51]);
		   }
		   if (VehicleCheckEngine[id] >= 1)
		   {
			  TextDrawShowForPlayer(playerid, Motorleuchte[playerid][0]);
			  TextDrawShowForPlayer(playerid, Motorleuchte[playerid][1]);
			  TextDrawShowForPlayer(playerid, Motorleuchte[playerid][2]);
			  TextDrawShowForPlayer(playerid, Motorleuchte[playerid][3]);
			  TextDrawShowForPlayer(playerid, Motorleuchte[playerid][4]);
			  TextDrawShowForPlayer(playerid, Motorleuchte[playerid][5]);
			  TextDrawShowForPlayer(playerid, Motorleuchte[playerid][6]);
			  TextDrawShowForPlayer(playerid, Motorleuchte[playerid][7]);
			  TextDrawShowForPlayer(playerid, Motorleuchte[playerid][8]);
			  TextDrawShowForPlayer(playerid, Tacho[playerid][53]);
		   }
		   if (VehicleCheckEngine[id] == 0)
		   {
			  TextDrawHideForPlayer(playerid, Motorleuchte[playerid][0]);
			  TextDrawHideForPlayer(playerid, Motorleuchte[playerid][1]);
			  TextDrawHideForPlayer(playerid, Motorleuchte[playerid][2]);
			  TextDrawHideForPlayer(playerid, Motorleuchte[playerid][3]);
			  TextDrawHideForPlayer(playerid, Motorleuchte[playerid][4]);
			  TextDrawHideForPlayer(playerid, Motorleuchte[playerid][5]);
			  TextDrawHideForPlayer(playerid, Motorleuchte[playerid][6]);
			  TextDrawHideForPlayer(playerid, Motorleuchte[playerid][7]);
			  TextDrawHideForPlayer(playerid, Motorleuchte[playerid][8]);
			  TextDrawHideForPlayer(playerid, Tacho[playerid][53]);
		   }
	    }
	}
    if(newstate == PLAYER_STATE_ONFOOT)
    {
		  //PlayerTextDrawHide(playerid, PlayerText:VOwner[playerid]);
    }
	if(newstate == PLAYER_STATE_DRIVER)
	{
		new vehicleid = GetPlayerVehicleID(playerid);
		new id = GetVehicleID(vehicleid);
		if(IsValidVehicle(id))
		{
			if(VehicleCreated[id] == VEHICLE_DEALERSHIP)
			{
				SetPVarInt(playerid, "DialogValue1", id);
				ShowDialog(playerid, DIALOG_VEHICLE_BUY);
				Speedometer_Show(playerid, 0);
				return 1;
			}
		}
		if(IsBicycle(vehicleid))
		{
			ToggleEngine(vehicleid, VEHICLE_PARAMS_ON);
		}
	}
       new vID=GetPlayerVehicleID(playerid),
	   tmp_engine,
	   tmp_lights,
	   tmp_alarm,
	   tmp_doors,
	   tmp_hood,
       tmp_trunk,
	   tmp_objective;
	   GetVehicleParamsEx(vID,tmp_engine, tmp_lights, tmp_alarm, tmp_doors, tmp_hood, tmp_trunk, tmp_objective);

     if(IsPlayerDriver(playerid) && !IsAMountainBike(GetPlayerVehicleID(playerid)) && !IsAAircraft(GetPlayerVehicleID(playerid)) && !IsABoat(GetPlayerVehicleID(playerid)))
     {
 	   Speedometer_Show(playerid, 0);
 	   SetVehicleParamsEx(vID, 0, 0, tmp_alarm, tmp_doors, tmp_hood, tmp_trunk, tmp_objective);
	   SetPVarInt(playerid, "KMLaden",0);
       DeletePVar(playerid, "KEINSPRIT");
       if(GetSVarInt("NachtZeit") == 1 && tmp_lights == 0)
       {
		  return SendInfoText(playerid, "Switch your lights on!");
       }
     }
     else if(IsPlayerDriver(playerid) && IsAAircraft(GetPlayerVehicleID(playerid)))
     {
 	   PlayerTextDrawShow(playerid, Airspeeed[playerid]);
 	   PlayerTextDrawShow(playerid, Airspeed[playerid]);
 	   PlayerTextDrawShow(playerid, Airspeedindicator[playerid]);
 	   PlayerTextDrawShow(playerid, Airspeeddisplay[playerid]);
 	   PlayerTextDrawShow(playerid, Alittudegauge[playerid]);
 	   PlayerTextDrawShow(playerid, Altimeter[playerid]);
 	   PlayerTextDrawShow(playerid, Altdisplay[playerid]);
 	   PlayerTextDrawShow(playerid, Tausendnadel[playerid]);
 	   PlayerTextDrawShow(playerid, Hundertnadel[playerid]);
 	   PlayerTextDrawShow(playerid, SteigtSinkt[playerid]);
 	   PlayerTextDrawShow(playerid, SteigtHintergrund[playerid]);
 	   PlayerTextDrawShow(playerid, Steigtnadel[playerid]);
 	   PlayerTextDrawShow(playerid, Variometer[playerid]);
 	   PlayerTextDrawShow(playerid, Variodisplay[playerid]);
 	   PlayerTextDrawShow(playerid, Altideckel[playerid]);
 	   PlayerTextDrawShow(playerid, Airspeeddeckel[playerid]);
 	   PlayerTextDrawShow(playerid, ArtHorizon[playerid]);
 	   PlayerTextDrawShow(playerid, CRTLboard_plane[playerid]);
 	   PlayerTextDrawShow(playerid, CRTLboard1_plane[playerid]);
 	   PlayerTextDrawShow(playerid, CRTLboard2_plane[playerid]);
 	   PlayerTextDrawShow(playerid, Kompass_Gauge[playerid]);
 	   PlayerTextDrawShow(playerid, Kompass_Hintergrund[playerid]);
 	   PlayerTextDrawShow(playerid, Kompass_N[playerid]);
 	   PlayerTextDrawShow(playerid, Kompass_E[playerid]);
 	   PlayerTextDrawShow(playerid, Kompass_S[playerid]);
 	   PlayerTextDrawShow(playerid, Kompass_W[playerid]);
 	   PlayerTextDrawShow(playerid, Kompass_Icon[playerid]);
 	   PlayerTextDrawShow(playerid, Flug_Info[playerid]);
 	   PlayerTextDrawShow(playerid, Flug_InfoHintergrund[playerid]);
 	   PlayerTextDrawShow(playerid, Fname[playerid]);
 	   PlayerTextDrawShow(playerid, RFuel[playerid]);
 	   PlayerTextDrawShow(playerid, LFuel[playerid]);
 	   PlayerTextDrawShow(playerid, Fuel1[playerid]);
 	   PlayerTextDrawShow(playerid, Fuel2[playerid]);
 	   PlayerTextDrawShow(playerid, Abgrenzung[playerid][1]);
 	   PlayerTextDrawShow(playerid, Abgrenzung[playerid][2]);
 	   PlayerTextDrawShow(playerid, Abgrenzung[playerid][3]);
 	   PlayerTextDrawShow(playerid, Condition[playerid]);
 	   PlayerTextDrawShow(playerid, Zustand[playerid]);
 	   PlayerTextDrawShow(playerid, Distance[playerid]);
 	   PlayerTextDrawShow(playerid, KMStandFlieger[playerid]);
 	   PlayerTextDrawShow(playerid, Fuelpumpen[playerid]);
 	   PlayerTextDrawShow(playerid, LowFuel[playerid]);
 	   PlayerTextDrawShow(playerid, LDGear[playerid]);
 	   PlayerTextDrawShow(playerid, PEngine[playerid]);
 	   PlayerTextDrawShow(playerid, LDGON[playerid]);
 	   LandingGearCRTL[playerid] = 1;
       SetVehicleParamsEx(vID, 0, 0, 0, 0, 0, 0, 0);
	   SetPVarInt(playerid, "PKMLaden",0);
       DeletePVar(playerid, "KEINSPRIT");
     }
     else if(!IsPlayerDriver(playerid))
     {
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][0]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][1]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][2]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][3]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][4]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][5]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][6]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][7]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][8]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][9]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][10]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][11]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][12]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][13]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][14]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][15]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][16]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][17]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][18]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][19]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][20]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][21]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][22]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][23]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][24]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][25]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][26]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][27]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][28]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][29]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][30]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][31]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][32]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][33]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][34]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][35]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][36]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][37]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][38]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][39]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][40]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][41]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][42]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][43]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][44]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][45]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][46]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][47]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][48]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][49]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][50]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][51]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][52]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][53]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][54]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][55]);
       PlayerTextDrawHide(playerid, PlayerText:BlinkerRechts[playerid][0]);
       PlayerTextDrawHide(playerid, PlayerText:BlinkerLinks[playerid][0]);
       PlayerTextDrawHide(playerid, PlayerText:BlinkerRechts[playerid][1]);
       PlayerTextDrawHide(playerid, PlayerText:BlinkerLinks[playerid][1]);
	   PlayerTextDrawHide(playerid, Sprit[playerid]);
	   PlayerTextDrawHide(playerid, KMH[playerid]);
	   PlayerTextDrawHide(playerid, Kilometerstand[playerid]);
	   PlayerTextDrawHide(playerid, Tachonadel[playerid]);
	   PlayerTextDrawHide(playerid, Spritnadel[playerid]);
	   TextDrawHideForPlayer(playerid, Licht[playerid][0]);
	   TextDrawHideForPlayer(playerid, Licht[playerid][1]);
	   TextDrawHideForPlayer(playerid, Licht[playerid][2]);
	   TextDrawHideForPlayer(playerid, Licht[playerid][3]);
	   TextDrawHideForPlayer(playerid, Locked[playerid][0]);
	   TextDrawHideForPlayer(playerid, Locked[playerid][1]);
	   TextDrawHideForPlayer(playerid, Locked[playerid][2]);
	   TextDrawHideForPlayer(playerid, Locked[playerid][3]);
	   TextDrawHideForPlayer(playerid, Motorleuchte[playerid][0]);
	   TextDrawHideForPlayer(playerid, Motorleuchte[playerid][1]);
	   TextDrawHideForPlayer(playerid, Motorleuchte[playerid][2]);
	   TextDrawHideForPlayer(playerid, Motorleuchte[playerid][3]);
	   TextDrawHideForPlayer(playerid, Motorleuchte[playerid][4]);
	   TextDrawHideForPlayer(playerid, Motorleuchte[playerid][5]);
	   TextDrawHideForPlayer(playerid, Motorleuchte[playerid][6]);
	   TextDrawHideForPlayer(playerid, Motorleuchte[playerid][7]);
	   TextDrawHideForPlayer(playerid, Motorleuchte[playerid][8]);
	   TextDrawHideForPlayer(playerid, Batterie[playerid][0]);
	   TextDrawHideForPlayer(playerid, Batterie[playerid][1]);
	   TextDrawHideForPlayer(playerid, Batterie[playerid][2]);
	   TextDrawHideForPlayer(playerid, Batterie[playerid][3]);
	   TextDrawHideForPlayer(playerid, Batterie[playerid][4]);
	   TextDrawHideForPlayer(playerid, Batterie[playerid][5]);
	   PlayerTextDrawHide(playerid, AutoHP[playerid][0]);
	   PlayerTextDrawHide(playerid, AutoHP[playerid][1]);
	   PlayerTextDrawHide(playerid, AutoHP[playerid][2]);
	   PlayerTextDrawHide(playerid, AutoHP[playerid][3]);
	   PlayerTextDrawHide(playerid, AutoHP[playerid][4]);
	   PlayerTextDrawHide(playerid, Sprit_Mitte[playerid]);
	   PlayerTextDrawHide(playerid, Tacho_Mitte[playerid]);
	   PlayerTextDrawHide(playerid, Airspeed[playerid]);
	   PlayerTextDrawHide(playerid, Airspeeed[playerid]);
 	   PlayerTextDrawHide(playerid, Airspeedindicator[playerid]);
 	   PlayerTextDrawHide(playerid, Airspeeddisplay[playerid]);
 	   PlayerTextDrawHide(playerid, Alittudegauge[playerid]);
 	   PlayerTextDrawHide(playerid, Altimeter[playerid]);
 	   PlayerTextDrawHide(playerid, Altdisplay[playerid]);
 	   PlayerTextDrawHide(playerid, Tausendnadel[playerid]);
 	   PlayerTextDrawHide(playerid, Hundertnadel[playerid]);
 	   PlayerTextDrawHide(playerid, SteigtSinkt[playerid]);
 	   PlayerTextDrawHide(playerid, SteigtHintergrund[playerid]);
 	   PlayerTextDrawHide(playerid, Steigtnadel[playerid]);
 	   PlayerTextDrawHide(playerid, Variometer[playerid]);
 	   PlayerTextDrawHide(playerid, Variodisplay[playerid]);
 	   PlayerTextDrawHide(playerid, Altideckel[playerid]);
 	   PlayerTextDrawHide(playerid, Airspeeddeckel[playerid]);
 	   PlayerTextDrawHide(playerid, ArtHorizon[playerid]);
 	   PlayerTextDrawHide(playerid, CRTLboard_plane[playerid]);
 	   PlayerTextDrawHide(playerid, CRTLboard1_plane[playerid]);
 	   PlayerTextDrawHide(playerid, CRTLboard2_plane[playerid]);
 	   PlayerTextDrawHide(playerid, Kompass_Gauge[playerid]);
 	   PlayerTextDrawHide(playerid, Kompass_Hintergrund[playerid]);
 	   PlayerTextDrawHide(playerid, Kompass_N[playerid]);
 	   PlayerTextDrawHide(playerid, Kompass_E[playerid]);
 	   PlayerTextDrawHide(playerid, Kompass_S[playerid]);
 	   PlayerTextDrawHide(playerid, Kompass_W[playerid]);
 	   PlayerTextDrawHide(playerid, Kompass_Icon[playerid]);
 	   PlayerTextDrawHide(playerid, Flug_Info[playerid]);
 	   PlayerTextDrawHide(playerid, Flug_InfoHintergrund[playerid]);
 	   PlayerTextDrawHide(playerid, Fname[playerid]);
 	   PlayerTextDrawHide(playerid, RFuel[playerid]);
 	   PlayerTextDrawHide(playerid, LFuel[playerid]);
 	   PlayerTextDrawHide(playerid, Fuel1[playerid]);
 	   PlayerTextDrawHide(playerid, Fuel2[playerid]);
 	   PlayerTextDrawHide(playerid, Abgrenzung[playerid][1]);
 	   PlayerTextDrawHide(playerid, Abgrenzung[playerid][2]);
 	   PlayerTextDrawHide(playerid, Abgrenzung[playerid][3]);
 	   PlayerTextDrawHide(playerid, Condition[playerid]);
 	   PlayerTextDrawHide(playerid, Zustand[playerid]);
 	   PlayerTextDrawHide(playerid, Distance[playerid]);
 	   PlayerTextDrawHide(playerid, KMStandFlieger[playerid]);
 	   PlayerTextDrawHide(playerid, Fuelpumpen[playerid]);
 	   PlayerTextDrawHide(playerid, LowFuel[playerid]);
 	   PlayerTextDrawHide(playerid, LDGear[playerid]);
 	   PlayerTextDrawHide(playerid, PEngine[playerid]);
 	   PlayerTextDrawHide(playerid, LDGON[playerid]);
 	   PlayerTextDrawHide(playerid, LDGOFF[playerid]);
 	   PlayerTextDrawHide(playerid, FPON[playerid]);
 	   PlayerTextDrawHide(playerid, FPOFF[playerid]);
 	   PlayerTextDrawHide(playerid, PEON[playerid]);
 	   PlayerTextDrawHide(playerid, PEOFF[playerid]);
 	   PlayerTextDrawHide(playerid, LowFuelW[playerid]);
       DeletePVar(playerid, "KEINSPRIT");
     }
	return 1;
}

forward SwitchVOdometer(playerid, vehicleid);
public SwitchVOdometer(playerid, vehicleid)
{
   new id = GetVehicleID(vehicleid);
   if(!IsValidVehicle(id)) return SendWarningText(playerid, "This is a public vehicle.");
   {
      if(GetPVarInt(playerid, "VehicleOdo") == 1)
      {
	     DeletePVar(playerid, "VehicleOdo");
	     DebugMessage(playerid, "Odo aus");
      }
      else
      {
	     SetPVarInt(playerid, "VehicleOdo", 1);
	     DebugMessage(playerid, "Odo an");
      }
      return 1;
   }

}

forward CarLockUnlock(playerid, vehicleid);
public CarLockUnlock(playerid, vehicleid)
{
   new id = GetVehicleID(vehicleid);
   if(IsValidVehicle(id))
   {
	  if (VehicleCreated[id] == 1)
	  {
	     SendClientMessage(playerid, Hellrot, "You cant lock a dealership car!");
	     VehicleLock[id] = 0;
	     return 0;
	  }
	  if(VehicleLock[id] == 1)
	  {
	     OnPlayerClickTextDraw(playerid, Aufsperren[playerid]);
	  }
	  else
	  {
	     OnPlayerClickTextDraw(playerid, Zusperren[playerid]);
	  }
   }
   else if(!IsValidVehicle(id))
   {
	  for (new i = 0; i < MAX_PLAYERS; i++)
	  if (NVehicleLocked[vehicleid] == 1 || NVehicleLocked[vehicleid] == -1)
	  {
		 SetVehicleParamsForPlayer(vehicleid, i, 0, 0);
         SendInfoText(playerid, "DOORS UNLOCKED");
		 NVehicleLocked[vehicleid] = 0;
		 return 1;
	  }
	  else if (NVehicleLocked[vehicleid] == 0)
	  {
		 if(i != playerid)
		 {
		    SetVehicleParamsForPlayer(vehicleid, i, 0, 1);
		 }
         SendInfoText(playerid, "DOORS LOCKED");
		 NVehicleLocked[vehicleid] = 1;
		 return 1;
	  }
   }
   return 1;
}

public OnVehicleMod(playerid, vehicleid, componentid)
{
	new id = GetVehicleID(vehicleid);
	if(IsValidVehicle(id))
	{
		VehicleMods[id][GetVehicleComponentType(componentid)] = componentid;
		SaveVehicle(id);
	}
	return 1;
}

public OnVehiclePaintjob(playerid, vehicleid, paintjobid)
{
	new id = GetVehicleID(vehicleid);
	if(IsValidVehicle(id))
	{
		VehiclePaintjob[id] = paintjobid;
		SaveVehicle(id);
	}
	return 1;
}

public OnVehicleRespray(playerid, vehicleid, color1, color2)
{
	new id = GetVehicleID(vehicleid);
	if(IsValidVehicle(id))
	{
		VehicleColor[id][0] = color1;
		VehicleColor[id][1] = color2;
		SaveVehicle(id);
	}
	return 1;
}

ShowDialog(playerid, dialogid)
{
	switch(dialogid)
	{
		case DIALOG_VEHICLE:
		{
			new vehicleid = GetPVarInt(playerid, "DialogValue1");
			new caption[32], info[256];
			format(caption, sizeof(caption), "Vehicle ID %d", vehicleid);
			strcat(info, "Vehicle Info\nEngine\nLights\nHood\nTrunk", sizeof(info));
			strcat(info, "\nFill Tank", sizeof(info));
			if(GetPlayerVehicleAccess(playerid, vehicleid) >= 2)
			{
				new value = VehicleValue[vehicleid]/2;
				format(info, sizeof(info), "%s\nSell Vehicle  ($%d)\nPark Vehicle\nEdit License Plate", info, value);
			}
			ShowPlayerDialog(playerid, dialogid, DIALOG_STYLE_LIST, caption, info, "Select", "Cancel");
		}
		case DIALOG_VEHICLE_BUY:
		{
			new vehicleid = GetPVarInt(playerid, "DialogValue1");
			new caption[32], info[256];
			format(caption, sizeof(caption), "Vehicle ID %d", vehicleid);
			format(info, sizeof(info), "This vehicle is for sale ($%d)\n", VehicleValue[vehicleid]);
			ShowPlayerDialog(playerid, dialogid, DIALOG_STYLE_MSGBOX, caption, info, "BUY", "CANCEL");
		}
		case DIALOG_VEHICLE_SELL:
		{
			new targetid = GetPVarInt(playerid, "DialogValue1");
			new id = GetPVarInt(playerid, "DialogValue2");
			new price = GetPVarInt(playerid, "DialogValue3");
			new info[256];
			format(info, sizeof(info), "%s (%d) wants to sell you a %s for $%d.", PlayerName(targetid), targetid,
				VehicleNames[VehicleModel[id]-400], price);
			strcat(info, "\n\nWould you like to buy?", sizeof(info));
			ShowPlayerDialog(playerid, dialogid, DIALOG_STYLE_MSGBOX, "Buy Vehicle", info, "Yes", "No");
		}
		case DIALOG_TRUNK:
		{
			new vehicleid = GetPVarInt(playerid, "DialogValue1");
			new name[32], info[256];
			for(new i=0; i < sizeof(VehicleTrunk[]); i++)
			{
				if(VehicleTrunk[vehicleid][i][1] > 0)
				{
					GetWeaponName(VehicleTrunk[vehicleid][i][0], name, sizeof(name));
					format(info, sizeof(info), "%s%d. %s (%d)\n", info, i+1, name, VehicleTrunk[vehicleid][i][1]);
				}
				else
				{
					format(info, sizeof(info), "%s%d. Empty\n", info, i+1);
				}
			}
			ShowPlayerDialog(playerid, dialogid, DIALOG_STYLE_LIST, "Trunk", info, "Select", "Cancel");
		}
		case DIALOG_TRUNK_ACTION:
		{
			new info[128];
			strcat(info, "Put Into Trunk\nTake From Trunk", sizeof(info));
			ShowPlayerDialog(playerid, dialogid, DIALOG_STYLE_LIST, "Trunk", info, "Select", "Cancel");
		}
		case DIALOG_VEHICLE_PLATE:
		{
			ShowPlayerDialog(playerid, dialogid, DIALOG_STYLE_INPUT, "Edit License Plate", "Enter new license plate:", "Change", "Back");
		}
		case DIALOG_EDITVEHICLE:
		{
			new vehicleid = GetPVarInt(playerid, "DialogValue1");
			new caption[32], info[256];
			format(caption, sizeof(caption), "Edit Vehicle ID %d", vehicleid);
			format(info, sizeof(info), "1. Value: [$%d]\n2. Model: [%d (%s)]\n3. Colors: [%d]  [%d]\n4. License Plate: [%s]",
				VehicleValue[vehicleid], VehicleModel[vehicleid], VehicleNames[VehicleModel[vehicleid]-400],
				VehicleColor[vehicleid][0], VehicleColor[vehicleid][1], VehicleNumberPlate[vehicleid]);
			strcat(info, "\n5. Delete Vehicle\n6. Park Vehicle\n7. Go To Vehicle", sizeof(info));
			strcat(info, "\n\nEnter: [nr] [value1] [value2]", sizeof(info));
			ShowPlayerDialog(playerid, dialogid, DIALOG_STYLE_INPUT, caption, info, "OK", "Cancel");
		}
	}
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
new vehiclemodelstring[150];
format(vehiclemodelstring, 150, "Track Car\nEject all players\nDespawn Car\nRespawn Car\nManage Car Keys\n\nVehicle info\nSell Vehicle to player");
				
	if(dialogid == DIALOG_ERROR)
	{
		ShowDialog(playerid, DialogReturn[playerid]);
		return 0;
	}
	DialogReturn[playerid] = dialogid;

	if(dialogid == MYVMENU)
	{
		if(response)
		{
			new id;
			new name[50];
			new string1[50];
			sscanf(inputtext[0], "si", name, id);
			if(IsValidVehicle(id))
			{
				format(string1, sizeof string1, "%s (ID:%i)", name, id);
			    ShowPlayerDialog(playerid, VMENU, DIALOG_STYLE_LIST, string1, vehiclemodelstring, "Select", "Back");
			    VehicleObject[playerid] = id;
			}
		}
		return 0;
	}
	if(dialogid == SELECTMECHANICCARDIALOG)
	{
		if(response)
		{
			new id;
			new name[50];
			new string1[50];
			new carnamestring[70];
			sscanf(inputtext[0], "si", name, id);
			if(IsValidVehicle(id))
			{
				format(string1, sizeof string1, "%s (ID:%i)", name, id);
				format(carnamestring, sizeof carnamestring, "What can we do for your %s? Please add a few details here:", name);
			    ShowPlayerDialog(playerid, VMENU, DIALOG_STYLE_INPUT, string1, carnamestring, "Select", "Back");
			    NewCarMechanicVehicle = id;//hier
			}
		}
		return 0;
	}
	if(dialogid == VMENU)
	{
		if(response)
		{
			if(listitem ==0)
            {
	          {
	             new id;
	             new string[65];
	             id = VehicleObject[playerid];
	             
	             if(IsValidVehicle(id))
	             {
				  if(GetPlayerVehicleID(playerid) == id)
				  {
				     format(string, sizeof string, "You are already sitting in your %s!", VehicleNames[VehicleModel[id]-400]);
			         SendClientMessage(playerid, Hellrot, string);
				     new string1[185];
				     format(string1, sizeof string1, "%s (ID:%i)", VehicleNames[VehicleModel[VehicleObject[playerid]]-400], VehicleObject[playerid]);
			         return ShowPlayerDialog(playerid, VMENU, DIALOG_STYLE_LIST, string1, vehiclemodelstring, "Select", "Back");
				  }
			      if(TrackNewCar[playerid])
				  {
				     format(string, (sizeof string), "You are already tracking your new %s!", VehicleNames[VehicleModel[TrackNewCar[playerid]]-400]);
			         SendClientMessage(playerid, Hellrot, string);
				     new string1[185];
				     format(string1, sizeof string1, "%s (ID:%i)", VehicleNames[VehicleModel[VehicleObject[playerid]]-400], VehicleObject[playerid]);
			         return ShowPlayerDialog(playerid, VMENU, DIALOG_STYLE_LIST, string1, vehiclemodelstring, "Select", "Back");
				  }
			      if(TrackCar[playerid] == id)
				  {
	                 TrackCar[playerid] = 0;
	                 KillTimer(tracktimer);
	                 DisablePlayerCheckpoint(playerid);
	                 SendClientMessage(playerid, Hellblau, "You are not tracking your car anymore");
				     new string1[185];
				     format(string1, sizeof string1, "%s (ID:%i)", VehicleNames[VehicleModel[VehicleObject[playerid]]-400], VehicleObject[playerid]);
			         return ShowPlayerDialog(playerid, VMENU, DIALOG_STYLE_LIST, string1, vehiclemodelstring, "Select", "Back");
				  }
				  else
				  {
				     TrackCar[playerid] = VehicleID[id];
				     format(string, (sizeof string), "The location of your %s is displayed on the minimap", VehicleNames[VehicleModel[id]-400]);
				     SendClientMessage(playerid, Hellblau, string);
	                 tracktimer = SetTimerEx("TrackPlayerCar", 1000, true, "%i", playerid);
				     new string1[185];
				     format(string1, sizeof string1, "%s (ID:%i)", VehicleNames[VehicleModel[VehicleObject[playerid]]-400], VehicleObject[playerid]);
			         return ShowPlayerDialog(playerid, VMENU, DIALOG_STYLE_LIST, string1, vehiclemodelstring, "Select", "Back");
				  }
	             }
	             else
	             {
				    SendClientMessage(playerid, Hellrot, "Something went wrong...");
	             }
	          }
			}
			if(listitem ==1)
            {
                new vehicleid = VehicleObject[playerid];
                new msg[128];
                format(msg, sizeof(msg), "Vehicle owner %s (%d) has ejected you", PlayerName(playerid), playerid);
                for(new i=0; i < MAX_PLAYERS; i++)
                {
                  if(IsPlayerConnected(i) && i != playerid && IsPlayerInVehicle(i, vehicleid))
                  {
                	 RemovePlayerFromVehicle(i);
                	 SendClientMessage(i, Hellrot, msg);
                  }
                }
                SendClientMessage(playerid, Hellblau, "You have ejected all passengers");
				new string1[185];
				format(string1, sizeof string1, "%s (ID:%i)", VehicleNames[VehicleModel[VehicleObject[playerid]]-400], VehicleObject[playerid]);
			    return ShowPlayerDialog(playerid, VMENU, DIALOG_STYLE_LIST, string1, vehiclemodelstring, "Select", "Back");
			}
			else if (listitem ==2)
			{
                  DestroyVehicle(VehicleObject[playerid]);
                  SendClientMessage(playerid, Hellblau, "Vehicle despawned");
                  new string1[185];
				  format(string1, sizeof string1, "%s (ID:%i)", VehicleNames[VehicleModel[VehicleObject[playerid]]-400], VehicleObject[playerid]);
			      return ShowPlayerDialog(playerid, VMENU, DIALOG_STYLE_LIST, string1, vehiclemodelstring, "Select", "Back");
			}
			else if(listitem ==3)
			{
                  DestroyVehicle(VehicleObject[playerid]);
				  UpdateVehicle(VehicleObject[playerid], 0);
                  SendClientMessage(playerid, Hellblau, "Vehicle respawned");
				     new string1[185];
				     format(string1, sizeof string1, "%s (ID:%i)", VehicleNames[VehicleModel[VehicleObject[playerid]]-400], VehicleObject[playerid]);
			         return ShowPlayerDialog(playerid, VMENU, DIALOG_STYLE_LIST, string1, vehiclemodelstring, "Select", "Back");
			}
			else if(listitem ==4)
			{
				  if (!strcmp(VehicleOwner[VehicleObject[playerid]],CarKeyOwner[VehicleObject[playerid]]))
				  {
                     ShowPlayerDialog(playerid, CARKEYS, DIALOG_STYLE_INPUT, "Give your car keys to another player", "You can give your car keys to another player.\nThe other player can do things like lock, unlock or park your vehicle.\nEnter the playerid for the new car key owner here:", "Give", "Cancel");
                  }
                  else
                  {
                     ShowPlayerDialog(playerid, CARKEYS, DIALOG_STYLE_MSGBOX, "Get your car Keys back", "You can retrieve your carkeys back with this option.", "Get Keys", "Cancel");
                  }
                  return 1;
			}
			else if(listitem ==5)
			{
            new vehinfo[250];
            new id = VehicleObject[playerid];
            new mid = GetVehicleModel(id);
            new Float: x, Float: y, Float: z;
            GetVehicleModelInfo(mid, VEHICLE_MODEL_INFO_SIZE, x, y, z);
            format(vehinfo, sizeof vehinfo, "Vehicle Name:\t%s \nID:\t%i\nVehicle Odometer: \t%ikm \nVehicle Owner:\t%s\nCarKey Owner:\t%s\nHighspeed:\t%dkm/h\nModel ID:\t%i\nFuel Type:\t%s\nDrivetrain:\t%s\nVehicle Weight:\t%04.1fkg\nSeats:\t%i\nDimensions:\t%.1fm x%.1fm x%.1fm",
            VehicleNames[VehicleModel[id]-400],id,VehicleMileage[id],VehicleOwner[id], CarKeyOwner[id],GetVehicleMaxSpeed(mid),mid,GetVehicleFuelType(mid),GetVehicleDrivetrainType(mid),GetVehicleMass(mid),GetVehicleSeats(mid),
            x,y,z);
            ShowPlayerDialog(playerid, VEHICLEINFO, DIALOG_STYLE_TABLIST, "Vehicle Info", vehinfo, " ", "Back");
            return 1;
			}
			else if(listitem ==6)
			{
                ShowPlayerDialog(playerid, SELLCARPRICE, DIALOG_STYLE_INPUT, "Sell your vehicle", "Enter the price of the vehicle here:", "Enter", "Cancel");
				return 1;
			}
		}
		else
	    {
	    new info[256], bool:found;
	    for(new i=1; i < MAX_DVEHICLES; i++)
	    {
 	      if(VehicleCreated[i] == VEHICLE_PLAYER && strcmp(VehicleOwner[i], GetSname(playerid)) == 0)
	      {
			found = true;
			format(info, sizeof(info), "%s%s %d\n", info, VehicleNames[VehicleModel[i]-400], i);
		  }
	    }
	    if(!found) return SendClientMessage(playerid, COLOR_RED, "You don't have any vehicles!");
	    ShowPlayerDialog(playerid, MYVMENU, DIALOG_STYLE_LIST, "All your Vehicles", info, "Select", "Exit");
	    }
		return 0;
	}
	if(dialogid == CARKEYS)
	{
		if(response)
		{
		   if (!strcmp(VehicleOwner[VehicleObject[playerid]],CarKeyOwner[VehicleObject[playerid]]))
		   {
		    new pid, id, msg[128];
		    id = VehicleObject[playerid];
		    pid = (strval(inputtext[playerid]));//hier
	        if(!IsPlayerConnected(pid))
			{
			      SendClientMessage(playerid, Hellrot, "Invalid player!");
                  ShowPlayerDialog(playerid, CARKEYS, DIALOG_STYLE_INPUT, "Give your car keys to another player", "You can give your car keys to another player.\nThe other player can do things like lock, unlock or park your vehicle.\nEnter the playerid for the new car key owner here:", "Give", "Cancel");
                  return 1;
			}
	        if(pid == playerid)
			{
			      SendClientMessage(playerid, Hellrot, "You can't give your keys to yourself -_-");
                  ShowPlayerDialog(playerid, CARKEYS, DIALOG_STYLE_INPUT, "Give your car keys to another player", "You can give your car keys to another player.\nThe other player can do things like lock, unlock or park your vehicle.\nEnter the playerid for the new car key owner here:", "Give", "Cancel");
                  return 1;
			}
	        if(!PlayerToPlayer(playerid, pid, 15.0)) return SendClientMessage(playerid, Hellrot, "Player is too far!");
	        format(msg, sizeof(msg), "You have given your car keys from your %s to %s (%d)",VehicleNames[VehicleModel[id]-400], PlayerName(pid), pid);
	        SendClientMessage(playerid, Hellgrün, msg);
	        format(msg, sizeof(msg), "%s (%d) has given you the car keys for his %s", PlayerName(playerid), playerid, VehicleNames[VehicleModel[id]-400]);
	        SendClientMessage(pid, Hellgrün, msg);
	        GetPlayerName(pid, CarKeyOwner[id], sizeof(CarKeyOwner[]));
	        SaveVehicle(id);
				new string1[185];
				format(string1, sizeof string1, "%s (ID:%i)", VehicleNames[VehicleModel[id]-400], id);
			    return ShowPlayerDialog(playerid, VMENU, DIALOG_STYLE_LIST, string1, vehiclemodelstring, "Select", "Back");
		   }
		   else
		   {
		    new id;
		    id = VehicleObject[playerid];
	        GetPlayerName(playerid, CarKeyOwner[id], sizeof(CarKeyOwner[]));
	        SaveVehicle(id);
	        SendClientMessage(playerid, Hellgrün, "You got your car keys back.");
				new string1[185];
				format(string1, sizeof string1, "%s (ID:%i)", VehicleNames[VehicleModel[VehicleObject[playerid]]-400], VehicleObject[playerid]);
			    return ShowPlayerDialog(playerid, VMENU, DIALOG_STYLE_LIST, string1, vehiclemodelstring, "Select", "Back");
		   }
	    }
  	    else
  	    {
				new string1[185];
				format(string1, sizeof string1, "%s (ID:%i)", VehicleNames[VehicleModel[VehicleObject[playerid]]-400], VehicleObject[playerid]);
			    ShowPlayerDialog(playerid, VMENU, DIALOG_STYLE_LIST, string1, vehiclemodelstring, "Select", "Back");
  	    }
		return 1;
	}
	else if(dialogid == SELLCARPRICE)
	{
	    for(new i=0; i < MAX_PLAYERS; i++)
		if(response)
		{
				new msg[185];
				new price = (strval(inputtext[i]));
				if(!strlen(inputtext))
				{
				   SendClientMessage(playerid, Hellrot, "You need to enter something to get your shitbox sold");
				   return ShowPlayerDialog(playerid, SELLCARPRICE, DIALOG_STYLE_INPUT, "Sell your vehicle", "Enter the price of the vehicle here:", "Enter", "Cancel");
				}
                if(price <= 0)
				{
				  SendClientMessage(playerid, Hellrot, "Come on you can't sell a car for $0 or less!");
				  return ShowPlayerDialog(playerid, SELLCARPRICE, DIALOG_STYLE_INPUT, "Sell your vehicle", "Enter the price of the vehicle here:", "Enter", "Cancel");
			    }
                else if(price <= 1000)
				{
				  SendClientMessage(playerid, Hellrot, "A vehicle sold for under $1000? Sounds very suspicious...");
			    }
			    format(msg, sizeof msg, "Warning:This is your last return point. Do you really want to sell your %s for $%i?\nEnter the playerid of the buyer here:",VehicleNames[VehicleModel[VehicleObject[playerid]]-400], price);
			    ShowPlayerDialog(playerid, SELLCAR, DIALOG_STYLE_INPUT, "Sell your vehicle", msg, "Enter", "Cancel");
                SetPVarInt(playerid, "CarSellPrice", price);
                return 1;
  	    }
  	    else
  	    {
				new string1[185];
				format(string1, sizeof string1, "%s (ID:%i)", VehicleNames[VehicleModel[VehicleObject[playerid]]-400], VehicleObject[playerid]);
			    ShowPlayerDialog(playerid, VMENU, DIALOG_STYLE_LIST, string1, vehiclemodelstring, "Select", "Back");
  	    }
		return 1;
	}
	else if(dialogid == SELLCAR)
	{
		if(response)
		{
				new msg[185];
                new id = VehicleObject[playerid];
                new pid = (strval(inputtext[playerid]));
				new price = GetPVarInt(playerid, "CarSellPrice");
				if(!strlen(inputtext))
				{
				   SendClientMessage(playerid, Hellrot, "You need to enter something to get your shitbox sold");
				   format(msg, sizeof msg, "Warning:This is your last return point. Do you really want to sell your %s for $%i?\nENTER THE PLAYERID of the buyer here:",VehicleNames[VehicleModel[id]-400],price);
				   return ShowPlayerDialog(playerid, SELLCAR, DIALOG_STYLE_INPUT, "Sell your vehicle", msg, "Enter", "Cancel");
				}
                if(pid == playerid)
                {
				   SendClientMessage(playerid, Hellrot, "You can't sell a car to yourself -_-");
				   format(msg, sizeof msg, "Warning:This is your last return point. Do you really want to sell your %s for $%i?\nEnter the playerid OF THE BUYER, NOT YOURSELF here:",VehicleNames[VehicleModel[id]-400],price);
				   return ShowPlayerDialog(playerid, SELLCAR, DIALOG_STYLE_INPUT, "Sell your vehicle", msg, "Enter", "Cancel");
				}
				if(!IsPlayerConnected(pid))
				{
				   SendClientMessage(playerid, Hellrot, "Invalid player!");
				   format(msg, sizeof msg, "Warning:This is your last return point. Do you really want to sell your %s for $%i?\nEnter A VALID playerid of the buyer here:",VehicleNames[VehicleModel[id]-400],price);
				   return ShowPlayerDialog(playerid, SELLCAR, DIALOG_STYLE_INPUT, "Sell your vehicle", msg, "Enter", "Cancel");
			    }
				DeletePVar(playerid, "CarSellPrice");
				if(!PlayerToPlayer(playerid, pid, 10.0)) return SendClientMessage(playerid, Hellrot, "Player is too far!");
				SetPVarInt(pid, "DialogValue1", playerid);
				SetPVarInt(pid, "DialogValue2", id);
				SetPVarInt(pid, "DialogValue3", price);
				ShowDialog(pid, DIALOG_VEHICLE_SELL);
				format(msg, sizeof(msg), "You have offered %s (%d) to buy your %s for $%d", PlayerName(pid), pid,VehicleNames[VehicleModel[id]-400], price);
				SendClientMessage(playerid, Hellblau, msg);
	    }
	    else
	    {
				return ShowPlayerDialog(playerid, SELLCARPRICE, DIALOG_STYLE_INPUT, "Sell your vehicle", "Enter the price of the vehicle here:", "Enter", "Cancel");
	    }
		return 1;
	}
	if(dialogid == VEHICLEINFO)
	{
		if(response)
		{
         new vehinfo[250];
         new id = VehicleObject[playerid];
         new mid = GetVehicleModel(id);
         new Float: x, Float: y, Float: z;
         GetVehicleModelInfo(mid, VEHICLE_MODEL_INFO_SIZE, x, y, z);
         format(vehinfo, sizeof vehinfo, "Vehicle Name:\t%s \nID:\t%i\nVehicle Odometer: \t%ikm \nVehicle Owner:\t%s\nCarKey Owner:\t%s\nHighspeed:\t%dkm/h\nModel ID:\t%i\nFuel Type:\t%s\nDrivetrain:\t%s\nVehicle Weight:\t%04.1fkg\nSeats:\t%i\nDimensions:\t%.1fm x%.1fm x%.1fm",
         VehicleNames[VehicleModel[id]-400],id,VehicleMileage[id],VehicleOwner[id], CarKeyOwner[id],GetVehicleMaxSpeed(mid),mid,GetVehicleFuelType(mid),GetVehicleDrivetrainType(mid),GetVehicleMass(mid),GetVehicleSeats(mid),
         x,y,z);
         ShowPlayerDialog(playerid, VEHICLEINFO, DIALOG_STYLE_TABLIST, "Vehicle Info", vehinfo, "", "Back");
         return 1;
	    }
	    else
	    {
				new string1[185];
				format(string1, sizeof string1, "%s (ID:%i)", VehicleNames[VehicleModel[VehicleObject[playerid]]-400], VehicleObject[playerid]);
			    return ShowPlayerDialog(playerid, VMENU, DIALOG_STYLE_LIST, string1, vehiclemodelstring, "Select", "Back");
	    }
	}
	if(dialogid == DIALOG_VEHICLE)
	{
		if(response)
		{
			switch(listitem)
			{
				case 0:
				{
					new vehinfo[250];
					new id = VehicleObject[playerid];
					new mid = GetVehicleModel(id);
					new Float: x, Float: y, Float: z;
		 			GetVehicleModelInfo(mid, VEHICLE_MODEL_INFO_SIZE, x, y, z);
                    format(vehinfo, sizeof vehinfo, "Vehicle Name:\t%s \nID:\t%i\nVehicle Odometer: \t%ikm \nVehicle Owner:\t%s\nCarKey Owner:\t%s\nHighspeed:\t%dkm/h\nModel ID:\t%i\nFuel Type:\t%s\nDrivetrain:\t%s\nVehicle Weight:\t%04.1fkg\nSeats:\t%i\nDimensions:\t%.1fm x%.1fm x%.1fm",
                    VehicleNames[VehicleModel[id]-400],id,VehicleMileage[id],VehicleOwner[id], CarKeyOwner[id],GetVehicleMaxSpeed(mid),mid,GetVehicleFuelType(mid),GetVehicleDrivetrainType(mid),GetVehicleMass(mid),GetVehicleSeats(mid),
                    x,y,z);
					ShowPlayerDialog(playerid, VEHICLEINFO, DIALOG_STYLE_TABLIST, "Vehicle Info", vehinfo, " ", "Back");
					return 1;
				}
				case 1:
				{
					new vehicleid = GetPlayerVehicleID(playerid);
					new engine, lights, alarm, doors, bonnet, boot, objective;
					GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
					if(engine == 1) { engine = 0; lights = 0; }
					else { engine = 1; lights = 1; }
					SetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
				}
				case 2:
				{
					new vehicleid = GetPlayerVehicleID(playerid);
					new engine, lights, alarm, doors, bonnet, boot, objective;
					GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
					if(lights == 1) lights = 0; else lights = 1;
					SetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
				}
				case 3:
				{
					new vehicleid = GetPlayerVehicleID(playerid);
					new engine, lights, alarm, doors, bonnet, boot, objective;
					GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
					if(bonnet == 1) bonnet = 0; else bonnet = 1;
					SetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
				}
				case 4:
				{
					new vehicleid = GetPlayerVehicleID(playerid);
					new engine, lights, alarm, doors, bonnet, boot, objective;
					GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
					if(boot == 1) boot = 0; else boot = 1;
					SetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
				}
				case 5:
				{
					if(!GetPVarInt(playerid, "GasCan"))
					{
						ShowErrorDialog(playerid, "lol");
						return 1;
					}
				}
				case 6:
				{
					new id = GetPVarInt(playerid, "DialogValue1");
					if(GetPlayerVehicleAccess(playerid, id) < 2)
					{
						ShowErrorDialog(playerid, "You are not the owner of this vehicle!");
						return 1;
					}
					new msg[128];
					VehicleCreated[id] = 0;
					VehicleModel[id] = 0;
					new money = VehicleValue[id]/2;
					new string[35];
			        format(string, sizeof string, "%s sold", VehicleNames[VehicleModel[id]-400]);
					ChangePlayerMoney(playerid, money, string);
					format(msg, sizeof(msg), "You have sold your vehicle for $%d", money);
					SendClientMessage(playerid, COLOR_WHITE, msg);
					RemovePlayerFromVehicle(playerid);
					DestroyVehicle(VehicleID[id]);
					SaveVehicle(id);
				}
				case 7:
				{
					new vehicleid = GetPVarInt(playerid, "DialogValue1");
					if(GetPlayerVehicleAccess(playerid, vehicleid) < 2)
					{
						ShowErrorDialog(playerid, "You are not the owner of this vehicle!");
						return 1;
					}
					GetVehiclePos(VehicleID[vehicleid], VehiclePos[vehicleid][0], VehiclePos[vehicleid][1], VehiclePos[vehicleid][2]);
					GetVehicleZAngle(VehicleID[vehicleid], VehiclePos[vehicleid][3]);
					VehicleInterior[vehicleid] = GetPlayerInterior(playerid);
					VehicleWorld[vehicleid] = GetPlayerVirtualWorld(playerid);
					SendClientMessage(playerid, COLOR_WHITE, "You have parked this vehicle here");
					UpdateVehicle(vehicleid, 1);
					PutPlayerInVehicle(playerid, VehicleID[vehicleid], 0);
					SaveVehicle(vehicleid);
				}
				case 8:
				{
					ShowDialog(playerid, DIALOG_VEHICLE_PLATE);
				}
			}
		}
		return 1;
	}
	if(dialogid == DIALOG_VEHICLE_BUY)
	{
		if(response)
		{
			if(GetPlayerVehicles(playerid) >= MAX_PLAYER_VEHICLES)
			{
				ShowErrorDialog(playerid, "You can't buy any more vehicles! Max: " #MAX_PLAYER_VEHICLES );
				return 1;
			}
			new id = GetPVarInt(playerid, "DialogValue1");
			if(GetPlayerMoney(playerid) < VehicleValue[id])
			{
				ShowErrorDialog(playerid, "You don't have enough money to buy this vehicle!");
				return 1;
			}
			new freeid = GetFreeVehicleID();
			if(!freeid)
			{
				ShowErrorDialog(playerid, "Vehicle dealership is out of stock!");
				return 1;
			}
			new string[35];
			format(string, sizeof string, "%s bought", VehicleNames[VehicleModel[id]-400]);
			ChangePlayerMoney(playerid, -VehicleValue[id], string);
			new dealerid = strval(VehicleOwner[id]);
			VehicleCreated[freeid] = VEHICLE_PLAYER;
			VehicleModel[freeid] = VehicleModel[id];
			VehiclePos[freeid] = DealershipPos[dealerid];//HIER
			VehicleColor[freeid] = VehicleColor[id];
			VehicleInterior[freeid] = VehicleInterior[id];
			VehicleWorld[freeid] = VehicleWorld[id];
			VehicleValue[freeid] = VehicleValue[id];
			GetPlayerName(playerid, VehicleOwner[freeid], sizeof(VehicleOwner[]));
			GetPlayerName(playerid, CarKeyOwner[freeid], sizeof(CarKeyOwner[]));
			VehicleNumberPlate[freeid] = DEFAULT_NUMBER_PLATE;
			for(new d=0; d < sizeof(VehicleTrunk[]); d++)
			{
				VehicleTrunk[freeid][d][0] = 0;
				VehicleTrunk[freeid][d][1] = 0;
			}
			for(new d=0; d < sizeof(VehicleMods[]); d++)
			{
				VehicleMods[freeid][d] = 0;
			}
			for(new o=0; o < sizeof(VehicleObjekte[]); o++)
			{
				VehicleObjekte[freeid][o] = "";
			}
			VehiclePaintjob[freeid] = 255;
			VehicleSpeedocolor1[freeid] = 255;
			VehicleSpeedocolor2[freeid] = -1;
			VehicleSpeedocolor3[freeid] = 0x808080FF;
			VehicleMileage[freeid] = random(30);
			VehicleLock[freeid] = 0;
			VehicleCheckEngine[freeid] = 0;
			VehicleBatteryLight[freeid] = 0;
			VehicleFuel[freeid] = 100;
			VehicleHealth[freeid] = 2000;
			SaveVehicle(freeid);
			new msg[128];
			format(msg, sizeof(msg), "You have bought a %s for $%d",  VehicleNames[VehicleModel[freeid]-400], VehicleValue[id]);
			SendClientMessage(playerid, Hellgrün, msg);
		    SendClientMessage(playerid, Hellblau, "Go get your vehicle outside.");
			UpdateVehicle(freeid, 1);
		    if(IsValidVehicle(id))
		    {
			         if(VehicleCreated[id] == VEHICLE_DEALERSHIP)
			         {
                         if(strcmp(VehicleNumberPlate[id],"WANG") == 0 && !IsAMotorBike(id))
						 {
						     SetTimerEx("WangCarDestroy", 1900, false, "%i", id);
				         }
                         if(strcmp(VehicleNumberPlate[id],"WANG") == 0 && IsAMotorBike(id))
						 {
						     SetTimerEx("WangBikeDestroy", 1900, false, "%i", id);
				         }
                         if(strcmp(VehicleNumberPlate[id],"OTTO") == 0)
						 {
						     SetTimerEx("OttoCarDestroy", 1900, false, "%i", id);
				         }
                         if(strcmp(VehicleNumberPlate[id],"LSA") == 0)
						 {
						     SetTimerEx("LosSantosCarDestroy", 1900, false, "%i", id);
				         }
                         if(strcmp(VehicleNumberPlate[id],"LVAB") == 0)
						 {
						     SetTimerEx("LasVenturasCarDestroy", 1900, false, "%i", id);
				         }
                         if(strcmp(VehicleNumberPlate[id],"RCCS") == 0)
						 {
						     SetTimerEx("RedCountyCarDestroy", 1900, false, "%i", id);
				         }
			         }
		    }
		    RemovePlayerFromVehicle(playerid);
		    TrackCar[playerid] = 0;
		    DisablePlayerCheckpoint(playerid);
		    TrackNewCar[playerid] = VehicleID[freeid];
	        for(new i=1; i < MAX_DVEHICLES; i++)
	        {
		       if(VehicleCreated[i] == VEHICLE_PLAYER && strcmp(VehicleOwner[i], GetSname(playerid)) == 0)
		       {
			      UpdateVehicle(i, 1);
		       }
	        }
		    SetTimerEx("TrackPlayerCar", 2000, false, "%i", playerid);
		
		}
		else
		{
			if(!IsPlayerAdmin(playerid))
			{
				RemovePlayerFromVehicle(playerid);
		        SendClientMessage(playerid, Hellrot, "Are you sure you dont want that car?");
			}
			else
			{
				SendClientMessage(playerid, Hellgrün, "You are Admin");
			}
		}
		return 1;
	}
	if(dialogid == DIALOG_VEHICLE_SELL)
	{
		if(response == 1)
		{
			if(GetPlayerVehicles(playerid) >= MAX_PLAYER_VEHICLES)
			{
				ShowErrorDialog(playerid, "You can't buy any more vehicles! Max: " #MAX_PLAYER_VEHICLES );
				return 1;
			}
			new targetid = GetPVarInt(playerid, "DialogValue1");
			new id = GetPVarInt(playerid, "DialogValue2");
			new price = GetPVarInt(playerid, "DialogValue3");
			if(GetPlayerMoney(playerid) < price)
			{
				ShowErrorDialog(playerid, "You don't have enough money to buy this vehicle!");
				return 1;
			}
			new msg[128];
			GetPlayerName(playerid, VehicleOwner[id], sizeof(VehicleOwner[]));
			GetPlayerName(playerid, CarKeyOwner[id], sizeof(CarKeyOwner[]));
			new string[35];
			format(string, sizeof string, "%s bought", VehicleNames[VehicleModel[id]-400]);
			ChangePlayerMoney(playerid, -price, string);
			format(string, sizeof string, "%s sold", VehicleNames[VehicleModel[id]-400]);
			ChangePlayerMoney(targetid, price, string);
			SaveVehicle(id);
			format(msg, sizeof(msg), "You have bought this vehicle for $%d", price);
			SendClientMessage(playerid, Hellgrün, msg);
			format(msg, sizeof(msg), "%s (%d) has accepted your offer and bought the vehicle", PlayerName(playerid), playerid);
			SendClientMessage(targetid, Hellgrün, msg);
		}
		else if (response == 0)
		{
			new targetid = GetPVarInt(playerid, "DialogValue1");
			new msg[128];
			format(msg, sizeof(msg), "%s (%d) refused your offer", PlayerName(playerid), playerid);
			SendClientMessage(targetid, Hellrot, msg);
		}
		return 1;
	}
	if(dialogid == DIALOG_FINDVEHICLE)
	{
		if(response)
		{
			new id;
			new name[50];
		    new string[65];
			sscanf(inputtext[0], "si", name, id);
			format(name, sizeof name, "%i", id);
			if(IsValidVehicle(id))
			{
				  if(GetPlayerVehicleID(playerid) == id)
				  {
				     format(string, sizeof string, "You are already sitting in your %s!", VehicleNames[VehicleModel[id]-400]);
			         return SendClientMessage(playerid, Hellrot, string);
				  }
			      if(TrackNewCar[playerid])
				  {
				     format(string, (sizeof string), "You are already tracking your %s!", VehicleNames[VehicleModel[TrackNewCar[playerid]]-400]);
			         return SendClientMessage(playerid, Hellrot, string);
				  }
				  else
				  {
				     TrackCar[playerid] = VehicleID[id];
				     format(string, (sizeof string), "The location of your %s is displayed on the minimap", VehicleNames[VehicleModel[id]-400]);
				     SendClientMessage(playerid, Hellblau, string);
				  }
		    }
			else
			{
				SendClientMessage(playerid, Hellrot, "Something went wrong...");
			}
			tracktimer = SetTimerEx("TrackPlayerCar", 1000, true, "%i", playerid);
		}
		return 1;
	}
	if(dialogid == DIALOG_TRUNK)
	{
		if(response)
		{
			SetPVarInt(playerid, "DialogValue2", listitem);
			ShowDialog(playerid, DIALOG_TRUNK_ACTION);
		}
		else
		{
			new id = GetPVarInt(playerid, "DialogValue1");
			ToggleBoot(VehicleID[id], VEHICLE_PARAMS_OFF);
		}
		return 1;
	}
	if(dialogid == DIALOG_TRUNK_ACTION)
	{
		if(response)
		{
			new id = GetPVarInt(playerid, "DialogValue1");
			new slot = GetPVarInt(playerid, "DialogValue2");
			switch(listitem)
			{
			case 0:
			{
				new weaponid = GetPlayerWeapon(playerid);
				if(weaponid == 0)
				{
					ShowErrorDialog(playerid, "You don't have a weapon in your hands!");
					return 1;
				}
				VehicleTrunk[id][slot][0] = weaponid;
				if(IsMeleeWeapon(weaponid)) VehicleTrunk[id][slot][1] = 1;
				else VehicleTrunk[id][slot][1] = GetPlayerAmmo(playerid);
				RemovePlayerWeapon(playerid, weaponid);
				SaveVehicle(id);
			}
			case 1:
			{
				if(VehicleTrunk[id][slot][1] <= 0)
				{
					ShowErrorDialog(playerid, "This slot is empty!");
					return 1;
				}
				GivePlayerWeapon(playerid, VehicleTrunk[id][slot][0], VehicleTrunk[id][slot][1]);
				VehicleTrunk[id][slot][0] = 0;
				VehicleTrunk[id][slot][1] = 0;
				SaveVehicle(id);
			}
			}
		}
		ShowDialog(playerid, DIALOG_TRUNK);
		return 1;
	}
	if(dialogid == DIALOG_VEHICLE_PLATE)
	{
		if(response)
		{
			if(strlen(inputtext) < 1 || strlen(inputtext) >= sizeof(VehicleNumberPlate[]))//Farbige Kennzeichen
			{
				ShowErrorDialog(playerid, "Invalid length!");
				return 1;
			}
			new id = GetPVarInt(playerid, "DialogValue1");
			new vehicleid = VehicleID[id];
			strmid(VehicleNumberPlate[id], inputtext, 0, sizeof(VehicleNumberPlate[]));
			SaveVehicle(id);
			SetVehicleNumberPlate(vehicleid, inputtext);
			SetVehicleToRespawn(vehicleid);
			new msg[128];
			format(msg, sizeof(msg), "You have changed vehicle number plate to %s", inputtext);
			SendClientMessage(playerid, COLOR_WHITE, msg);
		}
		else ShowDialog(playerid, DIALOG_VEHICLE);
		return 1;
	}
	if(dialogid == DIALOG_EDITVEHICLE)
	{
		if(response)
		{
			new id = GetPVarInt(playerid, "DialogValue1");
			new nr, params[128];
			sscanf(inputtext, "ds", nr, params);
			switch(nr)
			{
			case 1:
			{
				new value = strval(params);
				if(value < 0) value = 0;
				VehicleValue[id] = value;
				UpdateVehicleLabel(id, 1);
				SaveVehicle(id);
				ShowDialog(playerid, DIALOG_EDITVEHICLE);
			}
			case 2:
			{
				new value;
				if(IsNumeric(params)) value = strval(params);
				else value = GetVehicleModelIDFromName(params);
				if(value < 400 || value > 611)
				{
					ShowErrorDialog(playerid, "Invalid vehicle model!");
					return 1;
				}
				VehicleModel[id] = value;
				for(new i=0; i < sizeof(VehicleMods[]); i++)
				{
					VehicleMods[id][i] = 0;
				}
				VehiclePaintjob[id] = 255;
				UpdateVehicle(id, 1);
				SaveVehicle(id);
				ShowDialog(playerid, DIALOG_EDITVEHICLE);
			}
			case 3:
			{
				new color1, color2;
				sscanf(params, "dd", color1, color2);
				VehicleColor[id][0] = color1;
				VehicleColor[id][1] = color2;
				SaveVehicle(id);
				ChangeVehicleColor(VehicleID[id], color1, color2);
				ShowDialog(playerid, DIALOG_EDITVEHICLE);
			}
			case 4:
			{
				if(strlen(params) < 1 || strlen(params) > 8)
				{
					ShowErrorDialog(playerid, "Invalid length!");
					return 1;
				}
				strmid(VehicleNumberPlate[id], params, 0, sizeof(params));
				SaveVehicle(id);
				SetVehicleNumberPlate(VehicleID[id], params);
				SetVehicleToRespawn(VehicleID[id]);
				ShowDialog(playerid, DIALOG_EDITVEHICLE);
			}
			case 5:
			{
				DestroyVehicle(VehicleID[id]);
				if(VehicleCreated[id] == VEHICLE_DEALERSHIP)
				{
					Delete3DTextLabel(VehicleLabel[id]);
				}
				VehicleCreated[id] = 0;
				SaveVehicle(id);
				new msg[128];
				format(msg, sizeof(msg), "You have deleted vehicle id %d", id);
				SendClientMessage(playerid, COLOR_WHITE, msg);
			}
			case 6:
			{
				if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
				{
					ShowErrorDialog(playerid, "You are not driving the vehicle!");
					return 1;
				}
				GetVehiclePos(VehicleID[id], VehiclePos[id][0], VehiclePos[id][1], VehiclePos[id][2]);
				GetVehicleZAngle(VehicleID[id], VehiclePos[id][3]);
				VehicleInterior[id] = GetPlayerInterior(playerid);
				VehicleWorld[id] = GetPlayerVirtualWorld(playerid);
				SendClientMessage(playerid, COLOR_WHITE, "You have parked this vehicle here");
				UpdateVehicle(id, 1);
				PutPlayerInVehicle(playerid, VehicleID[id], 0);
				SaveVehicle(id);
				ShowDialog(playerid, DIALOG_EDITVEHICLE);
			}
			case 7:
			{
				new Float:x, Float:y, Float:z;
				GetVehiclePos(VehicleID[id], x, y, z);
				SetPlayerPos(playerid, x, y, z+1);
				new msg[128];
				format(msg, sizeof(msg), "You have teleported to vehicle id %d", id);
				SendClientMessage(playerid, COLOR_WHITE, msg);
			}
			}
		}
		return 1;
	}
	return 0;
}

forward RedCountyCarDestroy(id);
public RedCountyCarDestroy(id)
{
   VehicleModel[id] = RCCSAutos();
   VehicleColor[id][0] = RandomColor();
   VehicleColor[id][1] = RandomColor();
   VehicleValue[id] = SetRCCSVehiclePrice(id);
   SaveVehicle(id);
   UpdateVehicle(id, 1);
   UpdateVehicleLabel(id,1);
   return 1;
}

stock RCCSAutos()
{
      new RCCScars = random(11);
      switch (RCCScars)
      {
            case 0: return 602;
            case 1: return 402;
            case 2: return 482;
            case 3: return 445;
            case 4: return 533;
            case 5: return 539;
            case 6: return 542;
            case 7: return 579;
            case 8: return 605;
            case 9: return 420;
            case 10: return 492;
      }
return 576;
}

stock SetRCCSVehiclePrice(id)
{
if (VehicleModel[id] == 576) return 27800;
if (VehicleModel[id] == 602) return 18410;
if (VehicleModel[id] == 402) return 21350;
if (VehicleModel[id] == 482) return 19050;
if (VehicleModel[id] == 445) return 20500;
if (VehicleModel[id] == 533) return 29000;
if (VehicleModel[id] == 537) return 37800;
if (VehicleModel[id] == 542) return 23300;
if (VehicleModel[id] == 579) return 22000;
if (VehicleModel[id] == 605) return 9800;
if (VehicleModel[id] == 420) return 35800;
if (VehicleModel[id] == 492) return 15800;
return 10000;
}

forward OttoCarDestroy(id);
public OttoCarDestroy(id)
{
   VehicleModel[id] = OttoAutos();
   VehicleColor[id][0] = RandomColor();
   VehicleColor[id][1] = RandomColor();
   VehicleValue[id] = SetOttoVehiclePrice(id);
   SaveVehicle(id);
   UpdateVehicle(id, 1);
   UpdateVehicleLabel(id,1);
   return 1;
}

stock OttoAutos()
{
      new Ottocars = random(37);
      switch (Ottocars)
      {
            case 0: return 411;
            case 1: return 561;
            case 2: return 480;
            case 3: return 429;
            case 4: return 541;
            case 5: return 415;
            case 6: return 562;
            case 7: return 565;
            case 8: return 477;
            case 9: return 503;
            case 10: return 559;
            case 11: return 560;
            case 12: return 506;
            case 13: return 451;
            case 14: return 558;
            case 15: return 555;
            case 16: return 445;
            case 17: return 529;
            case 18: return 507;
            case 19: return 585;
            case 20: return 466;
            case 21: return 492;
            case 22: return 546;
            case 23: return 551;
            case 24: return 516;
            case 25: return 467;
            case 26: return 426;
            case 27: return 547;
            case 28: return 405;
            case 29: return 580;
            case 30: return 409;
            case 31: return 550;
            case 32: return 566;
            case 33: return 540;
            case 34: return 421;
            case 35: return 545;
            case 36: return 533;
            //case MAX_NUMBER: return 434;
      }
return 576;
}

stock SetOttoVehiclePrice(id)
{
if (VehicleModel[id] == 411) return 69420;
if (VehicleModel[id] == 561) return 28300;
if (VehicleModel[id] == 480) return 86000;
if (VehicleModel[id] == 429) return 54600;
if (VehicleModel[id] == 541) return 68000;
if (VehicleModel[id] == 415) return 48300;
if (VehicleModel[id] == 562) return 30900;
if (VehicleModel[id] == 565) return 15500;
if (VehicleModel[id] == 503) return 79000;
if (VehicleModel[id] == 559) return 36300;
if (VehicleModel[id] == 560) return 28700;
if (VehicleModel[id] == 506) return 40000;
if (VehicleModel[id] == 451) return 45500;
if (VehicleModel[id] == 558) return 21000;
if (VehicleModel[id] == 555) return 38900;
if (VehicleModel[id] == 477) return 35100;
if (VehicleModel[id] == 445) return 21300;
if (VehicleModel[id] == 507) return 21000;
if (VehicleModel[id] == 585) return 19000;
if (VehicleModel[id] == 466) return 25900;
if (VehicleModel[id] == 492) return 21300;
if (VehicleModel[id] == 546) return 20000;
if (VehicleModel[id] == 551) return 22000;
if (VehicleModel[id] == 516) return 29800;
if (VehicleModel[id] == 467) return 28500;
if (VehicleModel[id] == 426) return 22000;
if (VehicleModel[id] == 547) return 20000;
if (VehicleModel[id] == 405) return 25800;
if (VehicleModel[id] == 580) return 88000;
if (VehicleModel[id] == 409) return 35800;
if (VehicleModel[id] == 550) return 18300;
if (VehicleModel[id] == 566) return 19500;
if (VehicleModel[id] == 540) return 23000;
if (VehicleModel[id] == 421) return 28600;
if (VehicleModel[id] == 529) return 21000;
if (VehicleModel[id] == 545) return 72700;
if (VehicleModel[id] == 533) return 52000;
return 10000;
}

forward WangCarDestroy(id);
public WangCarDestroy(id)
{
   VehicleModel[id] = WangAutos();
   VehicleColor[id][0] = RandomColor();
   VehicleColor[id][1] = RandomColor();
   VehicleValue[id] = SetWangVehiclePrice(id);
   SaveVehicle(id);
   UpdateVehicle(id, 1);
   UpdateVehicleLabel(id,1);
   return 0;
}

stock WangAutos()
{
      new Wangcars = random(30);
      switch (Wangcars)
      {
            case 0: return 411;
            case 1: return 602;
            case 2: return 600;
            case 3: return 589;
            case 4: return 587;
            case 5: return 549;
            case 6: return 545;
            case 7: return 404;
            case 8: return 527;
            case 9: return 526;
            case 10: return 518;
            case 11: return 517;
            case 12: return 496;
            case 13: return 491;
            case 14: return 474;
            case 15: return 439;
            case 16: return 436;
            case 17: return 419;
            case 18: return 410;
            case 19: return 401;
            case 20: return 483;
            case 21: return 561;
            case 22: return 480;
            case 23: return 475;
            case 24: return 575;
            case 25: return 576;
            case 26: return 458;
            case 27: return 402;
            case 28: return 542;
            case 29: return 603;
            //
      }
return 576;
}

stock SetWangVehiclePrice(id)
{
if (VehicleModel[id] == 411) return 87500;
if (VehicleModel[id] == 602) return 26800;
if (VehicleModel[id] == 480) return 75000;
if (VehicleModel[id] == 600) return 34600;
if (VehicleModel[id] == 589) return 12500;
if (VehicleModel[id] == 587) return 21300;
if (VehicleModel[id] == 549) return 29900;
if (VehicleModel[id] == 545) return 65900;
if (VehicleModel[id] == 527) return 26000;
if (VehicleModel[id] == 404) return 25800;
if (VehicleModel[id] == 526) return 21000;
if (VehicleModel[id] == 518) return 44000;
if (VehicleModel[id] == 517) return 36500;
if (VehicleModel[id] == 496) return 18000;
if (VehicleModel[id] == 491) return 38900;
if (VehicleModel[id] == 474) return 39100;
if (VehicleModel[id] == 439) return 35300;
if (VehicleModel[id] == 436) return 12000;
if (VehicleModel[id] == 419) return 41000;
if (VehicleModel[id] == 410) return 15900;
if (VehicleModel[id] == 401) return 12300;
if (VehicleModel[id] == 483) return 43000;
if (VehicleModel[id] == 561) return 25000;
if (VehicleModel[id] == 475) return 39900;
if (VehicleModel[id] == 575) return 48500;
if (VehicleModel[id] == 576) return 38000;
if (VehicleModel[id] == 458) return 18000;
if (VehicleModel[id] == 402) return 27900;
if (VehicleModel[id] == 542) return 18000;
if (VehicleModel[id] == 603) return 36000;
return 10000;
}

forward WangBikeDestroy(id);
public WangBikeDestroy(id)
{
   VehicleModel[id] = WangBike();
   VehicleColor[id][0] = RandomColor();
   VehicleColor[id][1] = RandomColor();
   VehicleValue[id] = SetWangBikePrice(id);
   SaveVehicle(id);
   UpdateVehicle(id, 1);
   UpdateVehicleLabel(id,1);
   return 0;
}

stock WangBike()
{
      new WangBikes = random(10);
      switch (WangBikes)
      {
            case 0: return 581;
            case 1: return 462;
            case 2: return 521;
            case 3: return 522;
            case 4: return 461;
            case 5: return 448;
            case 6: return 468;
            case 7: return 586;
            case 8: return 471;
            case 9: return 463;
      }
return 581;
}

stock SetWangBikePrice(id)
{
if (VehicleModel[id] == 581) return 9999;
if (VehicleModel[id] == 462) return 2000;
if (VehicleModel[id] == 521) return 8900;
if (VehicleModel[id] == 522) return 10800;
if (VehicleModel[id] == 461) return 8600;
if (VehicleModel[id] == 448) return 1550;
if (VehicleModel[id] == 468) return 6700;
if (VehicleModel[id] == 586) return 6900;
if (VehicleModel[id] == 463) return 9100;
if (VehicleModel[id] == 471) return 8000;
return 1000;
}

forward LosSantosCarDestroy(id);
public LosSantosCarDestroy(id)
{
   VehicleModel[id] = LosSantosAutos();
   VehicleColor[id][0] = RandomColor();
   VehicleColor[id][1] = RandomColor();
   VehicleValue[id] = LosSantosVehiclePrice(id);
   SaveVehicle(id);
   UpdateVehicle(id, 1);
   UpdateVehicleLabel(id,1);
   return 0;
}

stock LosSantosAutos()
{
      new LosSantosAuto = random(21);
      switch (LosSantosAuto)
      {
            case 1: return 536;
            case 2: return 534;
            case 3: return 567;
            case 4: return 535;
            case 5: return 576;
            case 6: return 412;
            case 7: return 575;
            case 8: return 561;
            case 9: return 483;
            case 10: return 545;
            case 11: return 518;
            case 12: return 466;
            case 13: return 467;
            case 14: return 580;
            case 15: return 438;
            case 16: return 434;
            case 17: return 504;
            case 18: return 539;
            case 19: return 555;
      }
return 576;
}

stock LosSantosVehiclePrice(id)
{
if (VehicleModel[id] == 536) return 38500;
if (VehicleModel[id] == 534) return 42600;
if (VehicleModel[id] == 567) return 37000;
if (VehicleModel[id] == 535) return 40500;
if (VehicleModel[id] == 576) return 32500;
if (VehicleModel[id] == 412) return 42000;
if (VehicleModel[id] == 575) return 58600;
if (VehicleModel[id] == 561) return 25900;
if (VehicleModel[id] == 483) return 41500;
if (VehicleModel[id] == 545) return 42300;
if (VehicleModel[id] == 518) return 38300;
if (VehicleModel[id] == 466) return 48000;
if (VehicleModel[id] == 467) return 48000;
if (VehicleModel[id] == 580) return 56500;
if (VehicleModel[id] == 438) return 28900;
if (VehicleModel[id] == 434) return 76000;
if (VehicleModel[id] == 504) return 58000;
if (VehicleModel[id] == 539) return 88900;
if (VehicleModel[id] == 555) return 39600;
return 10000;
}

forward LasVenturasCarDestroy(id);
public LasVenturasCarDestroy(id)
{
   VehicleModel[id] = LasVenturasAutos();
   VehicleColor[id][0] = RandomColor();
   VehicleColor[id][1] = RandomColor();
   VehicleValue[id] = LasVenturasVehiclePrice(id);
   SaveVehicle(id);
   UpdateVehicle(id, 1);
   UpdateVehicleLabel(id,1);
   return 0;
}

stock LasVenturasVehiclePrice(id)
{
if (VehicleModel[id] == 579) return 35300;
if (VehicleModel[id] == 400) return 17600;
if (VehicleModel[id] == 404) return 13900;
if (VehicleModel[id] == 489) return 30000;
if (VehicleModel[id] == 576) return 37400;
if (VehicleModel[id] == 505) return 45000;
if (VehicleModel[id] == 479) return 42600;
if (VehicleModel[id] == 458) return 19900;
if (VehicleModel[id] == 543) return 28500;
if (VehicleModel[id] == 422) return 22300;
if (VehicleModel[id] == 418) return 25300;
if (VehicleModel[id] == 413) return 29000;
if (VehicleModel[id] == 478) return 42000;
if (VehicleModel[id] == 554) return 36500;
if (VehicleModel[id] == 589) return 18900;
return 10000;
}

stock LasVenturasAutos()
{
      new LasVenturasAuto = random(16);
      switch (LasVenturasAuto)
      {
            case 1: return 579;
            case 2: return 400;
            case 3: return 404;
            case 4: return 489;
            case 5: return 576;
            case 6: return 505;
            case 7: return 479;
            case 8: return 458;
            case 9: return 543;
            case 10: return 422;
            case 11: return 418;
            case 12: return 413;
            case 13: return 478;
            case 14: return 554;
      }
return 589;
}

// otto autos        445 604  507 585 466 492 546 551 516 467 426 547 405 580 409 550 566 540 421 529   luxus
// otto autos        411 561 480 429 541 415 562 565 434 503 559 560 506 451 558 555 477                street racers

// wang autos        602 600  598 587 549 545 533 527 526 518 517 496 491 474 439 436 419 410 401       compact cars
// wang autos        402 542 603 475                                                                    muscle cars
// wang autos        483 508 500                                                                        andere

// lossantos         536 575 534 567 535 576 412                                                        lowrider

// lasventuras       543 422 418 413 478 554                                                            trucks and vans
// lasventuras       579 400 404 489 505 479 458                                                        SUV and Wagons

stock sscanf(string[], format[], {Float,_}:...)
{
	#if defined isnull
	if (isnull(string))
	#else
	if (string[0] == 0 || (string[0] == 1 && string[1] == 0))
	#endif
	{
		return format[0];
	}
	new
		formatPos = 0,
		stringPos = 0,
		paramPos = 2,
		paramCount = numargs(),
		delim = ' ';
	while (string[stringPos] && string[stringPos] <= ' ')
	{
		stringPos++;
	}
	while (paramPos < paramCount && string[stringPos])
	{
		switch (format[formatPos++])
		{
			case '\0':
			{
				return 0;
			}
			case 'i', 'd':
			{
				new
					neg = 1,
					num = 0,
					ch = string[stringPos];
				if (ch == '-')
				{
					neg = -1;
					ch = string[++stringPos];
				}
				do
				{
					stringPos++;
					if ('0' <= ch <= '9')
					{
						num = (num * 10) + (ch - '0');
					}
					else
					{
						return -1;
					}
				}
				while ((ch = string[stringPos]) > ' ' && ch != delim);
				setarg(paramPos, 0, num * neg);
			}
			case 'h', 'x':
			{
				new
					num = 0,
					ch = string[stringPos];
				do
				{
					stringPos++;
					switch (ch)
					{
						case 'x', 'X':
						{
							num = 0;
							continue;
						}
						case '0' .. '9':
						{
							num = (num << 4) | (ch - '0');
						}
						case 'a' .. 'f':
						{
							num = (num << 4) | (ch - ('a' - 10));
						}
						case 'A' .. 'F':
						{
							num = (num << 4) | (ch - ('A' - 10));
						}
						default:
						{
							return -1;
						}
					}
				}
				while ((ch = string[stringPos]) > ' ' && ch != delim);
				setarg(paramPos, 0, num);
			}
			case 'c':
			{
				setarg(paramPos, 0, string[stringPos++]);
			}
			case 'f':
			{
				new
					end = stringPos - 1,
					ch;
				while ((ch = string[++end]) && ch != delim) {}
				string[end] = '\0';
				setarg(paramPos,0,_:floatstr(string[stringPos]));
				string[end] = ch;
				stringPos = end;
			}
			case 'p':
			{
				delim = format[formatPos++];
				continue;
			}
			case '\'':
			{
				new
					end = formatPos - 1,
					ch;
				while ((ch = format[++end]) && ch != '\'') {}
				if (!ch)
				{
					return -1;
				}
				format[end] = '\0';
				if ((ch = strfind(string, format[formatPos], false, stringPos)) == -1)
				{
					if (format[end + 1])
					{
						return -1;
					}
					return 0;
				}
				format[end] = '\'';
				stringPos = ch + (end - formatPos);
				formatPos = end + 1;
			}
			case 'u':
			{
				new
					end = stringPos - 1,
					id = 0,
					bool:num = true,
					ch;
				while ((ch = string[++end]) && ch != delim)
				{
					if (num)
					{
						if ('0' <= ch <= '9')
						{
							id = (id * 10) + (ch - '0');
						}
						else
						{
							num = false;
						}
					}
				}
				if (num && IsPlayerConnected(id))
				{
					setarg(paramPos, 0, id);
				}
				else
				{
					#if !defined foreach
						#define foreach(%1,%2) for (new %2 = 0; %2 < MAX_PLAYERS; %2++) if (IsPlayerConnected(%2))
						#define __SSCANF_FOREACH__
					#endif
					string[end] = '\0';
					num = false;
					new
						name[MAX_PLAYER_NAME];
					id = end - stringPos;
					foreach (Player, playerid)
					{
						GetPlayerName(playerid, name, sizeof (name));
						if (!strcmp(name, string[stringPos], true, id))
						{
							setarg(paramPos, 0, playerid);
							num = true;
							break;
						}
					}
					if (!num)
					{
						setarg(paramPos, 0, INVALID_PLAYER_ID);
					}
					string[end] = ch;
					#if defined __SSCANF_FOREACH__
						#undef foreach
						#undef __SSCANF_FOREACH__
					#endif
				}
				stringPos = end;
			}
			case 's', 'z':
			{
				new
					i = 0,
					ch;
				if (format[formatPos])
				{
					while ((ch = string[stringPos++]) && ch != delim)
					{
						setarg(paramPos, i++, ch);
					}
					if (!i)
					{
						return -1;
					}
				}
				else
				{
					while ((ch = string[stringPos++]))
					{
						setarg(paramPos, i++, ch);
					}
				}
				stringPos--;
				setarg(paramPos, i, '\0');
			}
			default:
			{
				continue;
			}
		}
		while (string[stringPos] && string[stringPos] != delim && string[stringPos] > ' ')
		{
			stringPos++;
		}
		while (string[stringPos] && (string[stringPos] == delim || string[stringPos] <= ' '))
		{
			stringPos++;
		}
		paramPos++;
	}
	do
	{
		if ((delim = format[formatPos++]) > ' ')
		{
			if (delim == '\'')
			{
				while ((delim = format[formatPos++]) && delim != '\'') {}
			}
			else if (delim != 'z')
			{
				return delim;
			}
		}
	}
	while (delim > ' ');
	return 0;
}

forward PlaneSpeedo();
public PlaneSpeedo()
foreach(new i : Player)
if(IsPlayerDriver(i) && IsAAircraft(GetPlayerVehicleID(i)))
{
    new tmp_engine,
	   tmp_lights,
	   tmp_alarm,
	   tmp_doors,
	   tmp_hood,
       tmp_trunk,
	   tmp_objective;
	new Float:speed, Float:result;
    new vehicleid = GetPlayerVehicleID(i);
  	new Float:x, Float:y, Float:z;
  	new Float: rz;
	new Speed = GetPlaneSpeed(i);
	new strrri[4], fstr[13], struing[5], vstr[15];

    GetVehicleZAngle(vehicleid, rz);
    PlayerTextDrawSetPreviewRot(i, Kompass_Icon[i], 90.000000, 180, rz, 1.000000);
	PlayerTextDrawShow(i, Kompass_Icon[i]);


  	GetVehiclePos(vehicleid, x, y, z);
  	if (z <= 1)
  	{
 	format(struing,sizeof(struing), "0000");
	}
  	else
  	{
	format(struing,sizeof(struing), "%04.0f", z*3.3);
	}
  	PlayerTextDrawSetString(i, PlayerText:Altdisplay[i], struing);

	format(strrri,sizeof(strrri), "%03d", Speed);
	PlayerTextDrawSetString(i, Airspeeddisplay[i], strrri);


	Pfuel[vehicleid] -= GetPlayerSpeed(i)/5000.0;
			if(Pfuel[vehicleid] <= 0)
			{
				GameTextForPlayer(i, "~r~You are out of Fuel",3000,3);
				SetPVarInt(i, "KEINSPRIT", 1);
		        format(fstr,sizeof(fstr), "~r~0");
				GetVehicleParamsEx(vehicleid,tmp_engine, tmp_lights, tmp_alarm, tmp_doors, tmp_hood, tmp_trunk, tmp_objective);
				if (tmp_engine == 1)
				{
					tmp_engine = 0;
				}
				SetVehicleParamsEx(vehicleid, tmp_engine, tmp_lights, tmp_alarm, tmp_doors, tmp_hood, tmp_trunk, tmp_objective);

			}
			else
		    {
		    format(fstr,sizeof(fstr), "~%s~%d %", FuelColor(Pfuel[vehicleid]), floatround(Pfuel[vehicleid]*1.0));
		    }
		    PlayerTextDrawSetString(i, Fuel1[i], fstr);
		    PlayerTextDrawSetString(i, Fuel2[i], fstr);

		    if(Pfuel[vehicleid] <= 10)
		    {
		    	PlayerTextDrawShow(i,PlayerText:LowFuelW[i]);
		    }
	if(GetPlayerState(i) != 2) continue;
        {
    	   new Float:vx, Float:vy, Float:vz;
		   new strrruui[15];
		   GetVehicleVelocity(vehicleid, vx, vy, vz);
		   format(strrruui,sizeof(strrruui), "%0.0f ft/min", vz*10126);
		   PlayerTextDrawSetString(i, Variodisplay[i], strrruui);
		   PlayerTextDrawHide(i, Steigtnadel[i]);

	       format(vstr,sizeof(vstr),"%s", VehicleNames[GetVehicleModel(GetPlayerVehicleID(i))-400]);
           PlayerTextDrawSetString(i, Fname[i], vstr);

		   new Float: health;
		   new hstruing[15];
		   GetVehicleHealth(vehicleid, health);
		   new Float: percentage = (((health - 250.0) / (1000.0 - 250.0)) * 100.0);
		   format(hstruing, sizeof(hstruing), "~%s~%.0f%", HealthColor(percentage), percentage);
		   PlayerTextDrawSetString(i, Zustand[i], hstruing);

		   new strpkm[15];
           if(GetPVarInt(i, "PKMLaden") == 0)
		   {
		       Pdistance [vehicleid] = 0;
		   }
	       Pdistance [vehicleid] += GetPlaneSpeed(i)/3600.0 + NMGet(i);
		   format(strpkm,sizeof(strpkm), "%07.0f NM", Pdistance [vehicleid]);
		   PlayerTextDrawSetString(i, KMStandFlieger[i], strpkm);
		   GetPlayerName(i,Sname,sizeof(Sname));
           format (Spieler,sizeof(Spieler),"/Spieler/%s.txt",Sname);
           if(IsAPlane(GetPlayerVehicleID(i)))
		   {
              dini_Set(Spieler,"KMStandFlugzeug",strpkm);
           }
           if(IsABoat(GetPlayerVehicleID(i)))
		   {
              dini_Set(Spieler,"KMStandBoot",strpkm);
		   }
		   if(IsAHeli(GetPlayerVehicleID(i)))
		   {
              dini_Set(Spieler,"KMStandHubs",strpkm);
		   }
		   if (vz >= 0.5968449197860963)
		   {
		   PlayerTextDrawSetPreviewRot(i, Steigtnadel[i], 0.000000, 340, 0.000000, 2.500000);
		   PlayerTextDrawShow(i, Steigtnadel[i]);
		   }
		   else if (vz <= -0.5968449197860963)
		   {
		   PlayerTextDrawSetPreviewRot(i, Steigtnadel[i], 0.000000, 200, 0.000000, 2.500000);
		   PlayerTextDrawShow(i, Steigtnadel[i]);
		   }
		   else
		   {
		   PlayerTextDrawSetPreviewRot(i, Steigtnadel[i], 0.000000, (vz*187-90)*-1, 0.000000, 2.500000);
		   PlayerTextDrawShow(i, Steigtnadel[i]);
		   }
		   }
		   {
		    PlayerTextDrawHide(i, Hundertnadel[i]);
		    PlayerTextDrawSetPreviewRot(i, Hundertnadel[i], 0.000000, -(z*1.19)/10, 0.000000, 2.500000);
		    PlayerTextDrawShow(i, Hundertnadel[i]);
		   }
		   {
		    PlayerTextDrawHide(i, Tausendnadel[i]);
		    PlayerTextDrawSetPreviewRot(i, Tausendnadel[i], 0.000000, -z*1.19, 0.000000, 2.500000);
		    PlayerTextDrawShow(i, Tausendnadel[i]);
		   }

	{
	    if(GetPlayerState(i) != 2) continue;
	    {
		  speed = (GetPSpeed(GetPlayerVehicleID(i))/1.3);
		  {
		    if(speed > 300)
		    {
		    PlayerTextDrawHide(i, Airspeedindicator[i]);
		    PlayerTextDrawSetPreviewRot(i, Airspeedindicator[i], 0.000000, 60.0, 0.000000, 2.500000);
		    PlayerTextDrawShow(i, Airspeedindicator[i]);
		    continue;
		    }
            if(speed < 45)
		    {
		    PlayerTextDrawHide(i, Airspeedindicator[i]);
		    PlayerTextDrawSetPreviewRot(i, Airspeedindicator[i], 0.000000, 325, 0.000000, 2.500000);
		    PlayerTextDrawShow(i, Airspeedindicator[i]);
		    continue;
	        }
		    result = 22-speed;
		    PlayerTextDrawHide(i, Airspeedindicator[i]);
		    PlayerTextDrawSetPreviewRot(i, Airspeedindicator[i], 0.000000, result, 0.000000, 2.500000);
		    PlayerTextDrawShow(i, Airspeedindicator[i]);
		  }
		  /*speed = (GetPSpeed(GetPlayerVehicleID(i)));
		  PlayerTextDrawHide(i, Airspeedindicator[i]);
		  PlayerTextDrawSetPreviewRot(i, Airspeedindicator[i], 0.000000, -(speed/1.6)-36, 0.000000, 2.500000);//hier
		  PlayerTextDrawShow(i, Airspeedindicator[i]);*/

	}
	}
}

forward Car_Selector_Dialog(playerid);
public Car_Selector_Dialog(playerid)
{
   new info[256], bool:found;
   for(new i=1; i < MAX_DVEHICLES; i++)
   {
      if(VehicleCreated[i] == VEHICLE_PLAYER && strcmp(VehicleOwner[i], GetSname(playerid)) == 0)
      {
         found = true;
         format(info, sizeof(info), "%s%s %d\n", info, VehicleNames[VehicleModel[i]-400], i);
      }
   }
   if(!found) return SendClientMessage(playerid, COLOR_RED, "You don't have any vehicles!");
   ShowPlayerDialog(playerid, SELECTMECHANICCARDIALOG, DIALOG_STYLE_LIST, "All your Vehicles", info, "Select", "Exit");
   return 1;
}

forward Gauges_Disable(playerid);
public Gauges_Disable(playerid)
{
	   KillTimer(Planespeedotimer);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][0]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][1]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][2]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][3]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][4]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][5]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][6]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][7]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][8]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][9]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][10]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][11]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][12]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][13]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][14]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][15]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][16]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][17]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][18]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][19]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][20]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][21]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][22]);
 	   //?
	   PlayerTextDrawHide(playerid, Sprit[playerid]);
	   PlayerTextDrawHide(playerid, KMH[playerid]);
	   PlayerTextDrawHide(playerid, Kilometerstand[playerid]);
	   PlayerTextDrawHide(playerid, Tachonadel[playerid]);
	   PlayerTextDrawHide(playerid, Spritnadel[playerid]);
	   TextDrawHideForPlayer(playerid, Licht[playerid][0]);
	   TextDrawHideForPlayer(playerid, Licht[playerid][1]);
	   TextDrawHideForPlayer(playerid, Licht[playerid][2]);
	   TextDrawHideForPlayer(playerid, Licht[playerid][3]);
	   TextDrawHideForPlayer(playerid, Locked[playerid][0]);
	   TextDrawHideForPlayer(playerid, Locked[playerid][1]);
	   TextDrawHideForPlayer(playerid, Locked[playerid][2]);
	   TextDrawHideForPlayer(playerid, Locked[playerid][3]);
	   TextDrawHideForPlayer(playerid, Motorleuchte[playerid][0]);
	   TextDrawHideForPlayer(playerid, Motorleuchte[playerid][1]);
	   TextDrawHideForPlayer(playerid, Motorleuchte[playerid][2]);
	   TextDrawHideForPlayer(playerid, Motorleuchte[playerid][3]);
	   TextDrawHideForPlayer(playerid, Motorleuchte[playerid][4]);
	   TextDrawHideForPlayer(playerid, Motorleuchte[playerid][5]);
	   TextDrawHideForPlayer(playerid, Motorleuchte[playerid][6]);
	   TextDrawHideForPlayer(playerid, Motorleuchte[playerid][7]);
	   TextDrawHideForPlayer(playerid, Motorleuchte[playerid][8]);
	   TextDrawHideForPlayer(playerid, Batterie[playerid][0]);
	   TextDrawHideForPlayer(playerid, Batterie[playerid][1]);
	   TextDrawHideForPlayer(playerid, Batterie[playerid][2]);
	   TextDrawHideForPlayer(playerid, Batterie[playerid][3]);
	   TextDrawHideForPlayer(playerid, Batterie[playerid][4]);
	   TextDrawHideForPlayer(playerid, Batterie[playerid][5]);
	   PlayerTextDrawHide(playerid, AutoHP[playerid][0]);
	   PlayerTextDrawHide(playerid, AutoHP[playerid][1]);
	   PlayerTextDrawHide(playerid, AutoHP[playerid][2]);
	   PlayerTextDrawHide(playerid, AutoHP[playerid][3]);
	   PlayerTextDrawHide(playerid, AutoHP[playerid][4]);
	   PlayerTextDrawHide(playerid, Sprit_Mitte[playerid]);
	   PlayerTextDrawHide(playerid, Tacho_Mitte[playerid]);
	   PlayerTextDrawHide(playerid, Airspeed[playerid]);
	   PlayerTextDrawHide(playerid, Airspeeed[playerid]);
 	   PlayerTextDrawHide(playerid, Airspeedindicator[playerid]);
 	   PlayerTextDrawHide(playerid, Airspeeddisplay[playerid]);
 	   PlayerTextDrawHide(playerid, Alittudegauge[playerid]);
 	   PlayerTextDrawHide(playerid, Altimeter[playerid]);
 	   PlayerTextDrawHide(playerid, Altdisplay[playerid]);
 	   PlayerTextDrawHide(playerid, Tausendnadel[playerid]);
 	   PlayerTextDrawHide(playerid, Hundertnadel[playerid]);
 	   PlayerTextDrawHide(playerid, SteigtSinkt[playerid]);
 	   PlayerTextDrawHide(playerid, SteigtHintergrund[playerid]);
 	   PlayerTextDrawHide(playerid, Steigtnadel[playerid]);
 	   PlayerTextDrawHide(playerid, Variometer[playerid]);
 	   PlayerTextDrawHide(playerid, Variodisplay[playerid]);
 	   PlayerTextDrawHide(playerid, Altideckel[playerid]);
 	   PlayerTextDrawHide(playerid, Airspeeddeckel[playerid]);
 	   PlayerTextDrawHide(playerid, ArtHorizon[playerid]);
 	   PlayerTextDrawHide(playerid, CRTLboard_plane[playerid]);
 	   PlayerTextDrawHide(playerid, CRTLboard1_plane[playerid]);
 	   PlayerTextDrawHide(playerid, CRTLboard2_plane[playerid]);
 	   PlayerTextDrawHide(playerid, Kompass_Gauge[playerid]);
 	   PlayerTextDrawHide(playerid, Kompass_Hintergrund[playerid]);
 	   PlayerTextDrawHide(playerid, Kompass_N[playerid]);
 	   PlayerTextDrawHide(playerid, Kompass_E[playerid]);
 	   PlayerTextDrawHide(playerid, Kompass_S[playerid]);
 	   PlayerTextDrawHide(playerid, Kompass_W[playerid]);
 	   PlayerTextDrawHide(playerid, Kompass_Icon[playerid]);
 	   PlayerTextDrawHide(playerid, Flug_Info[playerid]);
 	   PlayerTextDrawHide(playerid, Flug_InfoHintergrund[playerid]);
 	   PlayerTextDrawHide(playerid, Fname[playerid]);
 	   PlayerTextDrawHide(playerid, RFuel[playerid]);
 	   PlayerTextDrawHide(playerid, LFuel[playerid]);
 	   PlayerTextDrawHide(playerid, Fuel1[playerid]);
 	   PlayerTextDrawHide(playerid, Fuel2[playerid]);
 	   PlayerTextDrawHide(playerid, Abgrenzung[playerid][1]);
 	   PlayerTextDrawHide(playerid, Abgrenzung[playerid][2]);
 	   PlayerTextDrawHide(playerid, Abgrenzung[playerid][3]);
 	   PlayerTextDrawHide(playerid, Condition[playerid]);
 	   PlayerTextDrawHide(playerid, Zustand[playerid]);
 	   PlayerTextDrawHide(playerid, Distance[playerid]);
 	   PlayerTextDrawHide(playerid, KMStandFlieger[playerid]);
 	   PlayerTextDrawHide(playerid, Fuelpumpen[playerid]);
 	   PlayerTextDrawHide(playerid, LowFuel[playerid]);
 	   PlayerTextDrawHide(playerid, LDGear[playerid]);
 	   PlayerTextDrawHide(playerid, PEngine[playerid]);
 	   PlayerTextDrawHide(playerid, LDGON[playerid]);
 	   PlayerTextDrawHide(playerid, LDGOFF[playerid]);
 	   PlayerTextDrawHide(playerid, FPON[playerid]);
 	   PlayerTextDrawHide(playerid, FPOFF[playerid]);
 	   PlayerTextDrawHide(playerid, PEON[playerid]);
 	   PlayerTextDrawHide(playerid, PEOFF[playerid]);
 	   PlayerTextDrawHide(playerid, LowFuelW[playerid]);
return 1;
}

forward Gauges_Enable(playerid);
public Gauges_Enable(playerid)
{
 	   PlayerTextDrawShow(playerid, Airspeeed[playerid]);
 	   PlayerTextDrawShow(playerid, Airspeed[playerid]);
 	   PlayerTextDrawShow(playerid, Airspeedindicator[playerid]);
 	   PlayerTextDrawShow(playerid, Airspeeddisplay[playerid]);
 	   PlayerTextDrawShow(playerid, Alittudegauge[playerid]);
 	   PlayerTextDrawShow(playerid, Altimeter[playerid]);
 	   PlayerTextDrawShow(playerid, Altdisplay[playerid]);
 	   PlayerTextDrawShow(playerid, Tausendnadel[playerid]);
 	   PlayerTextDrawShow(playerid, Hundertnadel[playerid]);
 	   PlayerTextDrawShow(playerid, SteigtSinkt[playerid]);
 	   PlayerTextDrawShow(playerid, SteigtHintergrund[playerid]);
 	   PlayerTextDrawShow(playerid, Steigtnadel[playerid]);
 	   PlayerTextDrawShow(playerid, Variometer[playerid]);
 	   PlayerTextDrawShow(playerid, Variodisplay[playerid]);
 	   PlayerTextDrawShow(playerid, Altideckel[playerid]);
 	   PlayerTextDrawShow(playerid, Airspeeddeckel[playerid]);
 	   PlayerTextDrawShow(playerid, ArtHorizon[playerid]);
 	   PlayerTextDrawShow(playerid, CRTLboard_plane[playerid]);
 	   PlayerTextDrawShow(playerid, CRTLboard1_plane[playerid]);
 	   PlayerTextDrawShow(playerid, CRTLboard2_plane[playerid]);
 	   PlayerTextDrawShow(playerid, Kompass_Gauge[playerid]);
 	   PlayerTextDrawShow(playerid, Kompass_Hintergrund[playerid]);
 	   PlayerTextDrawShow(playerid, Kompass_N[playerid]);
 	   PlayerTextDrawShow(playerid, Kompass_E[playerid]);
 	   PlayerTextDrawShow(playerid, Kompass_S[playerid]);
 	   PlayerTextDrawShow(playerid, Kompass_W[playerid]);
 	   PlayerTextDrawShow(playerid, Kompass_Icon[playerid]);
 	   PlayerTextDrawShow(playerid, Flug_Info[playerid]);
 	   PlayerTextDrawShow(playerid, Flug_InfoHintergrund[playerid]);
 	   PlayerTextDrawShow(playerid, Fname[playerid]);
 	   PlayerTextDrawShow(playerid, RFuel[playerid]);
 	   PlayerTextDrawShow(playerid, LFuel[playerid]);
 	   PlayerTextDrawShow(playerid, Fuel1[playerid]);
 	   PlayerTextDrawShow(playerid, Fuel2[playerid]);
 	   PlayerTextDrawShow(playerid, Abgrenzung[playerid][1]);
 	   PlayerTextDrawShow(playerid, Abgrenzung[playerid][2]);
 	   PlayerTextDrawShow(playerid, Abgrenzung[playerid][3]);
 	   PlayerTextDrawShow(playerid, Condition[playerid]);
 	   PlayerTextDrawShow(playerid, Zustand[playerid]);
 	   PlayerTextDrawShow(playerid, Distance[playerid]);
 	   PlayerTextDrawShow(playerid, KMStandFlieger[playerid]);
 	   PlayerTextDrawShow(playerid, Fuelpumpen[playerid]);
 	   PlayerTextDrawShow(playerid, LowFuel[playerid]);
 	   PlayerTextDrawShow(playerid, LDGear[playerid]);
 	   PlayerTextDrawShow(playerid, PEngine[playerid]);
 	   PlayerTextDrawShow(playerid, LDGON[playerid]);
 	   LandingGearCRTL[playerid] = 1;
	   Planespeedotimer = SetTimerEx("PlaneSpeedo",250, true, "%i", playerid);
return 1;
}

forward Speedometer_Disable(playerid);
public Speedometer_Disable(playerid)
{
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][0]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][1]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][2]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][3]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][4]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][5]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][6]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][7]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][8]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][9]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][10]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][11]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][12]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][13]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][14]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][15]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][16]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][17]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][18]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][19]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][20]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][21]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][22]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][23]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][24]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][25]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][26]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][27]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][28]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][29]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][30]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][31]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][32]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][33]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][34]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][35]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][36]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][37]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][38]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][39]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][40]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][41]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][42]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][43]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][44]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][45]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][46]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][47]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][48]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][49]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][50]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][51]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][52]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][53]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][54]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][55]);
	   PlayerTextDrawHide(playerid, Sprit[playerid]);
	   PlayerTextDrawHide(playerid, KMH[playerid]);
	   PlayerTextDrawHide(playerid, Kilometerstand[playerid]);
	   PlayerTextDrawHide(playerid, Tachonadel[playerid]);
	   PlayerTextDrawHide(playerid, Spritnadel[playerid]);
	   TextDrawHideForPlayer(playerid, Licht[playerid][0]);
	   TextDrawHideForPlayer(playerid, Licht[playerid][1]);
	   TextDrawHideForPlayer(playerid, Licht[playerid][2]);
	   TextDrawHideForPlayer(playerid, Licht[playerid][3]);
	   TextDrawHideForPlayer(playerid, Locked[playerid][0]);
	   TextDrawHideForPlayer(playerid, Locked[playerid][1]);
	   TextDrawHideForPlayer(playerid, Locked[playerid][2]);
	   TextDrawHideForPlayer(playerid, Locked[playerid][3]);
	   TextDrawHideForPlayer(playerid, Motorleuchte[playerid][0]);
	   TextDrawHideForPlayer(playerid, Motorleuchte[playerid][1]);
	   TextDrawHideForPlayer(playerid, Motorleuchte[playerid][2]);
	   TextDrawHideForPlayer(playerid, Motorleuchte[playerid][3]);
	   TextDrawHideForPlayer(playerid, Motorleuchte[playerid][4]);
	   TextDrawHideForPlayer(playerid, Motorleuchte[playerid][5]);
	   TextDrawHideForPlayer(playerid, Motorleuchte[playerid][6]);
	   TextDrawHideForPlayer(playerid, Motorleuchte[playerid][7]);
	   TextDrawHideForPlayer(playerid, Motorleuchte[playerid][8]);
       TextDrawHideForPlayer(playerid, Batterie[playerid][0]);
       TextDrawHideForPlayer(playerid, Batterie[playerid][1]);
       TextDrawHideForPlayer(playerid, Batterie[playerid][2]);
       TextDrawHideForPlayer(playerid, Batterie[playerid][3]);
       TextDrawHideForPlayer(playerid, Batterie[playerid][4]);
       TextDrawHideForPlayer(playerid, Batterie[playerid][5]);
	   PlayerTextDrawHide(playerid, AutoHP[playerid][0]);
	   PlayerTextDrawHide(playerid, AutoHP[playerid][1]);
	   PlayerTextDrawHide(playerid, AutoHP[playerid][2]);
	   PlayerTextDrawHide(playerid, AutoHP[playerid][3]);
	   PlayerTextDrawHide(playerid, AutoHP[playerid][4]);
	   PlayerTextDrawHide(playerid, Sprit_Mitte[playerid]);
	   PlayerTextDrawHide(playerid, Tacho_Mitte[playerid]);
	   PlayerTextDrawHide(playerid, BlinkerLinks[playerid][0]);
	   PlayerTextDrawHide(playerid, BlinkerRechts[playerid][0]);
	   PlayerTextDrawHide(playerid, BlinkerLinks[playerid][1]);
	   PlayerTextDrawHide(playerid, BlinkerRechts[playerid][1]);
	   SetPVarInt(playerid, "TachoHide", 1);
return 1;
}

forward Speedometer_Show(playerid, modshop);
public Speedometer_Show(playerid, modshop)
{
	   //if(IsPlayerInAnyVehicle(playerid))
	   {
	   	  new vehicleid = GetPlayerVehicleID(playerid);
		  new id = GetVehicleID(vehicleid);
		  if(IsValidVehicle(vehicleid))
		  {
	   	     TextDrawSetString(Tacho[playerid][48], VehicleOwner[id]);
	         Tachofarbe(playerid, 1, VehicleSpeedocolor1[id]);
	         Tachofarbe(playerid, 2, VehicleSpeedocolor2[id]);
	         Tachofarbe(playerid, 3, VehicleSpeedocolor3[id]);
	         new string[50];
	         format(string, sizeof string, "%i", id);
	         DebugMessage(playerid, string);
	         if(VehicleCreated[id] == 1)
	         {
	            Tachofarbe(playerid, 1, 255);
	            Tachofarbe(playerid, 2, -1);
	            Tachofarbe(playerid, 3, 0x808080FF);
	   	        TextDrawSetString(Tacho[playerid][48], "Not_yours_(yet)");
	         }
		  }
		  else
		  {
	         Tachofarbe(playerid, 1, 255);
	         Tachofarbe(playerid, 2, -1);
	         Tachofarbe(playerid, 3, 0x808080FF);
	   	     TextDrawSetString(Tacho[playerid][48], "Public_Vehicle");
		  }
	   }
	   PlayerTextDrawShow(playerid, Sprit[playerid]);
	   PlayerTextDrawShow(playerid, KMH[playerid]);
	   PlayerTextDrawShow(playerid, Kilometerstand[playerid]);
	   PlayerTextDrawSetPreviewRot(playerid, Tachonadel[playerid], 0.000000, 133.0, 0.000000, 2.000000);
       PlayerTextDrawSetPreviewRot(playerid,PlayerText:Spritnadel[playerid],0.000000, 0.0, 0.000000, 2.000000);
	   PlayerTextDrawShow(playerid, Tachonadel[playerid]);
	   PlayerTextDrawShow(playerid, Spritnadel[playerid]);
	   PlayerTextDrawShow(playerid, AutoHP[playerid][0]);
	   PlayerTextDrawShow(playerid, AutoHP[playerid][1]);
	   PlayerTextDrawShow(playerid, AutoHP[playerid][2]);
	   PlayerTextDrawShow(playerid, AutoHP[playerid][3]);
	   PlayerTextDrawShow(playerid, AutoHP[playerid][4]);
	   PlayerTextDrawShow(playerid, Sprit_Mitte[playerid]);
	   PlayerTextDrawShow(playerid, Tacho_Mitte[playerid]);
	   PlayerTextDrawSetString(playerid, KMH[playerid], "000 km/h");
	   PlayerTextDrawSetString(playerid, Sprit[playerid], "100");
	   PlayerTextDrawSetString(playerid, AutoHP[playerid][0], "100");
	   PlayerTextDrawSetString(playerid,Kilometerstand[playerid], "000000 km");
 	   TextDrawShowForPlayer(playerid, Tacho[playerid][0]);
 	   TextDrawShowForPlayer(playerid, Tacho[playerid][1]);
 	   TextDrawShowForPlayer(playerid, Tacho[playerid][2]);
 	   TextDrawShowForPlayer(playerid, Tacho[playerid][3]);
 	   TextDrawShowForPlayer(playerid, Tacho[playerid][4]);
 	   TextDrawShowForPlayer(playerid, Tacho[playerid][5]);
 	   TextDrawShowForPlayer(playerid, Tacho[playerid][6]);
 	   TextDrawShowForPlayer(playerid, Tacho[playerid][7]);
 	   TextDrawShowForPlayer(playerid, Tacho[playerid][8]);
 	   TextDrawShowForPlayer(playerid, Tacho[playerid][9]);
 	   TextDrawShowForPlayer(playerid, Tacho[playerid][10]);
 	   TextDrawShowForPlayer(playerid, Tacho[playerid][11]);
 	   TextDrawShowForPlayer(playerid, Tacho[playerid][12]);
 	   TextDrawShowForPlayer(playerid, Tacho[playerid][13]);
 	   TextDrawShowForPlayer(playerid, Tacho[playerid][14]);
 	   TextDrawShowForPlayer(playerid, Tacho[playerid][15]);
 	   TextDrawShowForPlayer(playerid, Tacho[playerid][16]);
 	   TextDrawShowForPlayer(playerid, Tacho[playerid][17]);
 	   TextDrawShowForPlayer(playerid, Tacho[playerid][18]);
 	   TextDrawShowForPlayer(playerid, Tacho[playerid][19]);
 	   TextDrawShowForPlayer(playerid, Tacho[playerid][20]);
 	   TextDrawShowForPlayer(playerid, Tacho[playerid][21]);
 	   TextDrawShowForPlayer(playerid, Tacho[playerid][22]);
 	   TextDrawShowForPlayer(playerid, Tacho[playerid][23]);
 	   TextDrawShowForPlayer(playerid, Tacho[playerid][24]);
 	   TextDrawShowForPlayer(playerid, Tacho[playerid][25]);
 	   TextDrawShowForPlayer(playerid, Tacho[playerid][26]);
 	   TextDrawShowForPlayer(playerid, Tacho[playerid][27]);
 	   TextDrawShowForPlayer(playerid, Tacho[playerid][28]);
 	   TextDrawShowForPlayer(playerid, Tacho[playerid][29]);
 	   TextDrawShowForPlayer(playerid, Tacho[playerid][30]);
 	   TextDrawShowForPlayer(playerid, Tacho[playerid][31]);
 	   TextDrawShowForPlayer(playerid, Tacho[playerid][32]);
 	   TextDrawShowForPlayer(playerid, Tacho[playerid][33]);
 	   TextDrawShowForPlayer(playerid, Tacho[playerid][34]);
 	   TextDrawShowForPlayer(playerid, Tacho[playerid][35]);
 	   TextDrawShowForPlayer(playerid, Tacho[playerid][36]);
 	   TextDrawShowForPlayer(playerid, Tacho[playerid][37]);
 	   TextDrawShowForPlayer(playerid, Tacho[playerid][38]);
 	   TextDrawShowForPlayer(playerid, Tacho[playerid][39]);
 	   TextDrawShowForPlayer(playerid, Tacho[playerid][40]);
 	   TextDrawShowForPlayer(playerid, Tacho[playerid][41]);
 	   TextDrawShowForPlayer(playerid, Tacho[playerid][42]);
 	   TextDrawShowForPlayer(playerid, Tacho[playerid][43]);
 	   TextDrawShowForPlayer(playerid, Tacho[playerid][44]);
 	   TextDrawShowForPlayer(playerid, Tacho[playerid][45]);
 	   TextDrawShowForPlayer(playerid, Tacho[playerid][46]);
 	   TextDrawShowForPlayer(playerid, Tacho[playerid][47]);
 	   TextDrawShowForPlayer(playerid, Tacho[playerid][48]);
 	   TextDrawShowForPlayer(playerid, Tacho[playerid][49]);
 	   TextDrawShowForPlayer(playerid, Tacho[playerid][54]);
 	   TextDrawShowForPlayer(playerid, Tacho[playerid][55]);
	   if(modshop == 1)
	   {
	      TextDrawShowForPlayer(playerid, Motorleuchte[playerid][0]);
	      TextDrawShowForPlayer(playerid, Motorleuchte[playerid][1]);
	      TextDrawShowForPlayer(playerid, Motorleuchte[playerid][2]);
	      TextDrawShowForPlayer(playerid, Motorleuchte[playerid][3]);
	      TextDrawShowForPlayer(playerid, Motorleuchte[playerid][4]);
	      TextDrawShowForPlayer(playerid, Motorleuchte[playerid][5]);
	      TextDrawShowForPlayer(playerid, Motorleuchte[playerid][6]);
	      TextDrawShowForPlayer(playerid, Motorleuchte[playerid][7]);
	      TextDrawShowForPlayer(playerid, Motorleuchte[playerid][8]);
	      PlayerTextDrawHide(playerid, BlinkerLinks[playerid][0]);
	      PlayerTextDrawHide(playerid, BlinkerRechts[playerid][0]);
	      PlayerTextDrawShow(playerid, BlinkerLinks[playerid][1]);
	      PlayerTextDrawShow(playerid, BlinkerRechts[playerid][1]);
 	      TextDrawShowForPlayer(playerid, Tacho[playerid][50]);
 	      TextDrawShowForPlayer(playerid, Tacho[playerid][51]);
 	      TextDrawShowForPlayer(playerid, Tacho[playerid][52]);
 	      TextDrawShowForPlayer(playerid, Tacho[playerid][53]);
	      TextDrawShowForPlayer(playerid, Locked[playerid][0]);
	      TextDrawShowForPlayer(playerid, Locked[playerid][1]);
	      TextDrawShowForPlayer(playerid, Locked[playerid][2]);
	      TextDrawShowForPlayer(playerid, Locked[playerid][3]);
	      TextDrawShowForPlayer(playerid, Licht[playerid][0]);
	      TextDrawShowForPlayer(playerid, Licht[playerid][1]);
	      TextDrawShowForPlayer(playerid, Licht[playerid][2]);
	      TextDrawShowForPlayer(playerid, Licht[playerid][3]);
	      TextDrawShowForPlayer(playerid, Batterie[playerid][0]);
	      TextDrawShowForPlayer(playerid, Batterie[playerid][1]);
	      TextDrawShowForPlayer(playerid, Batterie[playerid][2]);
	      TextDrawShowForPlayer(playerid, Batterie[playerid][3]);
	      TextDrawShowForPlayer(playerid, Batterie[playerid][4]);
	      TextDrawShowForPlayer(playerid, Batterie[playerid][5]);
	      return 1;
	   }
	   DeletePVar(playerid, "TachoHide");
return 1;
}

forward Speedometer_Hide(playerid);
public Speedometer_Hide(playerid)
{
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][0]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][1]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][2]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][3]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][4]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][5]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][6]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][7]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][8]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][9]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][10]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][11]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][12]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][13]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][14]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][15]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][16]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][17]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][18]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][19]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][20]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][21]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][22]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][23]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][24]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][25]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][26]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][27]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][28]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][29]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][30]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][31]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][32]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][33]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][34]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][35]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][36]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][37]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][38]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][39]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][40]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][41]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][42]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][43]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][44]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][45]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][46]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][47]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][48]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][49]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][50]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][51]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][52]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][53]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][54]);
 	   TextDrawHideForPlayer(playerid, Tacho[playerid][55]);
	   PlayerTextDrawHide(playerid, Sprit[playerid]);
	   PlayerTextDrawHide(playerid, KMH[playerid]);
	   PlayerTextDrawHide(playerid, Kilometerstand[playerid]);
	   PlayerTextDrawHide(playerid, Tachonadel[playerid]);
	   PlayerTextDrawHide(playerid, Spritnadel[playerid]);
	   TextDrawHideForPlayer(playerid, Licht[playerid][0]);
	   TextDrawHideForPlayer(playerid, Licht[playerid][1]);
	   TextDrawHideForPlayer(playerid, Licht[playerid][2]);
	   TextDrawHideForPlayer(playerid, Licht[playerid][3]);
	   TextDrawHideForPlayer(playerid, Locked[playerid][0]);
	   TextDrawHideForPlayer(playerid, Locked[playerid][1]);
	   TextDrawHideForPlayer(playerid, Locked[playerid][2]);
	   TextDrawHideForPlayer(playerid, Locked[playerid][3]);
	   TextDrawHideForPlayer(playerid, Batterie[playerid][0]);
	   TextDrawHideForPlayer(playerid, Batterie[playerid][1]);
	   TextDrawHideForPlayer(playerid, Batterie[playerid][2]);
	   TextDrawHideForPlayer(playerid, Batterie[playerid][3]);
	   TextDrawHideForPlayer(playerid, Batterie[playerid][4]);
	   TextDrawHideForPlayer(playerid, Batterie[playerid][5]);
	   PlayerTextDrawHide(playerid, AutoHP[playerid][0]);
	   PlayerTextDrawHide(playerid, AutoHP[playerid][1]);
	   PlayerTextDrawHide(playerid, AutoHP[playerid][2]);
	   PlayerTextDrawHide(playerid, AutoHP[playerid][3]);
	   PlayerTextDrawHide(playerid, AutoHP[playerid][4]);
	   PlayerTextDrawHide(playerid, Sprit_Mitte[playerid]);
	   PlayerTextDrawHide(playerid, Tacho_Mitte[playerid]);
	   TextDrawHideForPlayer(playerid, Motorleuchte[playerid][0]);
	   TextDrawHideForPlayer(playerid, Motorleuchte[playerid][1]);
	   TextDrawHideForPlayer(playerid, Motorleuchte[playerid][2]);
	   TextDrawHideForPlayer(playerid, Motorleuchte[playerid][3]);
	   TextDrawHideForPlayer(playerid, Motorleuchte[playerid][4]);
	   TextDrawHideForPlayer(playerid, Motorleuchte[playerid][5]);
	   TextDrawHideForPlayer(playerid, Motorleuchte[playerid][6]);
	   TextDrawHideForPlayer(playerid, Motorleuchte[playerid][7]);
	   TextDrawHideForPlayer(playerid, Motorleuchte[playerid][8]);
	   PlayerTextDrawHide(playerid, BlinkerLinks[playerid][0]);
	   PlayerTextDrawHide(playerid, BlinkerRechts[playerid][0]);
	   PlayerTextDrawHide(playerid, BlinkerLinks[playerid][1]);
	   PlayerTextDrawHide(playerid, BlinkerRechts[playerid][1]);
return 1;
}

forward Tachofarbe(playerid, farbbereich, farbe);
public Tachofarbe(playerid, farbbereich, farbe)
{
   new vehicleid = GetPVarInt(playerid, "VehicleID");
   new id = GetVehicleID(vehicleid);
   if (farbbereich == 1)//Rand
   {
	  TextDrawColor(Tacho[playerid][19], farbe);
	  TextDrawColor(Tacho[playerid][21], farbe);
 	  TextDrawShowForPlayer(playerid, Tacho[playerid][19]);
 	  TextDrawShowForPlayer(playerid, Tacho[playerid][21]);
 	  if(IsValidVehicle(id) && strcmp(VehicleOwner[GetVehicleID(vehicleid)], GetSname(playerid)) == 0)
 	  {
	     VehicleSpeedocolor1[id] = farbe;
 	  }
   }
   else if (farbbereich == 2)//Innen
   {
	  TextDrawColor(Tacho[playerid][20], farbe);
	  TextDrawColor(Tacho[playerid][22], farbe);
 	  TextDrawShowForPlayer(playerid, Tacho[playerid][20]);
 	  TextDrawShowForPlayer(playerid, Tacho[playerid][22]);
 	  if(IsValidVehicle(id) && strcmp(VehicleOwner[GetVehicleID(vehicleid)], GetSname(playerid)) == 0)
 	  {
	     VehicleSpeedocolor2[id] = farbe;
 	  }
   }
   if (farbbereich == 3)//Schrift
   {
	  TextDrawColor(Tacho[playerid][0], farbe);
	  TextDrawColor(Tacho[playerid][1], farbe);
	  TextDrawColor(Tacho[playerid][2], farbe);
	  TextDrawColor(Tacho[playerid][3], farbe);
	  TextDrawColor(Tacho[playerid][4], farbe);
	  TextDrawColor(Tacho[playerid][5], farbe);
	  TextDrawColor(Tacho[playerid][6], farbe);
	  TextDrawColor(Tacho[playerid][7], farbe);
	  TextDrawColor(Tacho[playerid][8], farbe);
	  TextDrawColor(Tacho[playerid][9], farbe);
	  TextDrawColor(Tacho[playerid][10], farbe);
	  TextDrawColor(Tacho[playerid][11], farbe);
	  TextDrawColor(Tacho[playerid][12], farbe);
	  TextDrawColor(Tacho[playerid][15], farbe);
	  TextDrawColor(Tacho[playerid][16], farbe);
	  TextDrawColor(Tacho[playerid][18], farbe);

	  TextDrawColor(Tacho[playerid][23], farbe);
	  TextDrawColor(Tacho[playerid][24], farbe);
	  TextDrawColor(Tacho[playerid][25], farbe);
	  TextDrawColor(Tacho[playerid][26], farbe);
	  TextDrawColor(Tacho[playerid][27], farbe);
	  TextDrawColor(Tacho[playerid][28], farbe);
	  TextDrawColor(Tacho[playerid][29], farbe);
	  TextDrawColor(Tacho[playerid][30], farbe);
	  TextDrawColor(Tacho[playerid][31], farbe);
	  TextDrawColor(Tacho[playerid][32], farbe);
	  TextDrawColor(Tacho[playerid][33], farbe);
	  TextDrawColor(Tacho[playerid][34], farbe);
	  TextDrawColor(Tacho[playerid][35], farbe);
	  TextDrawColor(Tacho[playerid][36], farbe);
	  TextDrawColor(Tacho[playerid][37], farbe);
	  TextDrawColor(Tacho[playerid][38], farbe);
	  TextDrawColor(Tacho[playerid][39], farbe);
	  TextDrawColor(Tacho[playerid][40], farbe);
	  TextDrawColor(Tacho[playerid][41], farbe);
	  TextDrawColor(Tacho[playerid][42], farbe);
	  TextDrawColor(Tacho[playerid][43], farbe);
	  TextDrawColor(Tacho[playerid][44], farbe);
	  TextDrawColor(Tacho[playerid][45], farbe);
	  TextDrawColor(Tacho[playerid][46], farbe);
	  TextDrawColor(Tacho[playerid][48], farbe);
	  TextDrawColor(Tacho[playerid][55], farbe);
	  PlayerTextDrawColor(playerid, KMH[playerid], farbe);
	  PlayerTextDrawColor(playerid, Kilometerstand[playerid], farbe);
	  PlayerTextDrawColor(playerid, Sprit[playerid], farbe);
	  PlayerTextDrawColor(playerid, AutoHP[playerid][0], farbe);
 	  TextDrawShowForPlayer(playerid, Tacho[playerid][0]);
 	  TextDrawShowForPlayer(playerid, Tacho[playerid][1]);
 	  TextDrawShowForPlayer(playerid, Tacho[playerid][2]);
 	  TextDrawShowForPlayer(playerid, Tacho[playerid][3]);
 	  TextDrawShowForPlayer(playerid, Tacho[playerid][4]);
 	  TextDrawShowForPlayer(playerid, Tacho[playerid][5]);
 	  TextDrawShowForPlayer(playerid, Tacho[playerid][6]);
 	  TextDrawShowForPlayer(playerid, Tacho[playerid][7]);
 	  TextDrawShowForPlayer(playerid, Tacho[playerid][8]);
 	  TextDrawShowForPlayer(playerid, Tacho[playerid][9]);
 	  TextDrawShowForPlayer(playerid, Tacho[playerid][10]);
 	  TextDrawShowForPlayer(playerid, Tacho[playerid][11]);
 	  TextDrawShowForPlayer(playerid, Tacho[playerid][12]);
 	  TextDrawShowForPlayer(playerid, Tacho[playerid][13]);
 	  TextDrawShowForPlayer(playerid, Tacho[playerid][14]);
 	  TextDrawShowForPlayer(playerid, Tacho[playerid][15]);
 	  TextDrawShowForPlayer(playerid, Tacho[playerid][16]);
 	  TextDrawShowForPlayer(playerid, Tacho[playerid][17]);
 	  TextDrawShowForPlayer(playerid, Tacho[playerid][18]);

 	  TextDrawShowForPlayer(playerid, Tacho[playerid][23]);
 	  TextDrawShowForPlayer(playerid, Tacho[playerid][24]);
 	  TextDrawShowForPlayer(playerid, Tacho[playerid][25]);
 	  TextDrawShowForPlayer(playerid, Tacho[playerid][26]);
 	  TextDrawShowForPlayer(playerid, Tacho[playerid][27]);
 	  TextDrawShowForPlayer(playerid, Tacho[playerid][28]);
 	  TextDrawShowForPlayer(playerid, Tacho[playerid][29]);
 	  TextDrawShowForPlayer(playerid, Tacho[playerid][30]);
 	  TextDrawShowForPlayer(playerid, Tacho[playerid][31]);
 	  TextDrawShowForPlayer(playerid, Tacho[playerid][32]);
 	  TextDrawShowForPlayer(playerid, Tacho[playerid][33]);
 	  TextDrawShowForPlayer(playerid, Tacho[playerid][34]);
 	  TextDrawShowForPlayer(playerid, Tacho[playerid][35]);
 	  TextDrawShowForPlayer(playerid, Tacho[playerid][36]);
 	  TextDrawShowForPlayer(playerid, Tacho[playerid][37]);
 	  TextDrawShowForPlayer(playerid, Tacho[playerid][38]);
 	  TextDrawShowForPlayer(playerid, Tacho[playerid][39]);
 	  TextDrawShowForPlayer(playerid, Tacho[playerid][40]);
 	  TextDrawShowForPlayer(playerid, Tacho[playerid][41]);
 	  TextDrawShowForPlayer(playerid, Tacho[playerid][42]);
 	  TextDrawShowForPlayer(playerid, Tacho[playerid][43]);
 	  TextDrawShowForPlayer(playerid, Tacho[playerid][44]);
 	  TextDrawShowForPlayer(playerid, Tacho[playerid][45]);
 	  TextDrawShowForPlayer(playerid, Tacho[playerid][46]);
 	  TextDrawShowForPlayer(playerid, Tacho[playerid][47]);
 	  TextDrawShowForPlayer(playerid, Tacho[playerid][48]);
 	  PlayerTextDrawShow(playerid, KMH[playerid]);
 	  PlayerTextDrawShow(playerid, Kilometerstand[playerid]);
 	  PlayerTextDrawShow(playerid, Sprit[playerid]);
 	  PlayerTextDrawShow(playerid, AutoHP[playerid][0]);
 	  if(IsValidVehicle(id) && strcmp(VehicleOwner[GetVehicleID(vehicleid)], GetSname(playerid)) == 0)
 	  {
	     VehicleSpeedocolor3[id] = farbe;
 	  }
   }
   SaveVehicle(id);
   return 1;
}

IsVehicleDrivingBackwards(vehicleid)
{
enum EVector2
{
    Float:EVector2_x,
    Float:EVector2_y
}

enum EVector3
{
    Float:EVector3_x,
    Float:EVector3_y,
    Float:EVector3_z
}
    new ret = false;
    //if (IsValidVehicle(vehicleid))
    {
        new v1[EVector3], v2[EVector2], v3[EVector2], Float:rot;
        GetVehicleVelocity(vehicleid, v1[EVector3_x], v1[EVector3_y], v1[EVector3_z]);
        NormalizeVector2(v1[EVector3_x], v1[EVector3_y], v1[EVector3_x], v1[EVector3_y]);
        GetVehicleZAngle(vehicleid, rot);
        RotationToForwardVector(rot, v2[EVector2_x], v2[EVector2_y]);
        v3[EVector2_x] = v1[EVector3_x] + v2[EVector2_x];
        v3[EVector2_y] = v1[EVector3_y] + v2[EVector2_y];
        ret = (((v3[EVector2_x] * v3[EVector2_x]) + (v3[EVector2_y] * v3[EVector2_y])) < 2.0);
    }
    return ret;
}

Float:Wrap(Float:x, Float:min, Float:max)
{
    new
        Float:ret = x,
        Float:delta = max - min;
    if (delta > 0.0)
    {
        while (ret < min)
        {
            ret += delta;
        }
        while (ret > max)
        {
            ret -= delta;
        }
    }
    else if (delta <= 0.0)
    {
        ret = min;
    }
    return x;
}

RotationToForwardVector(Float:angle, &Float:x, &Float:y)
{
    new Float:phi = (Wrap(angle, 0.0, 360.0) * 3.14159265) / 180.0;
    x = floatcos(phi) - floatsin(phi);
    y = floatsin(phi) + floatcos(phi);
}

NormalizeVector2(Float:x, Float:y, &Float:resultX, &Float:resultY)
{
#if !defined EPSILON
    #define  EPSILON 0.0001
#endif
#define IsFloatZero%1(%0)   ((EPSILON >= (%0)) && ((-EPSILON) <= (%0)))
#define IsNullVector2%2(%0,%1) (IsFloatZero(%0) && IsFloatZero(%1))
    if (IsNullVector2(x, y))
    {
        resultX = 0.0;
        resultY = 0.0;
    }
    else
    {
        new Float:mag = floatsqroot((x * x) + (y * y));
        resultX = x / mag;
        resultY = y / mag;
    }
}
