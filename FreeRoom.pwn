//wichtig: nach "muss weg" suchen!
// für intro:     GameTextForPlayer(playerid, "~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~g~~h~Race Timer Started!", 3000, 3);

//Zeit stoppen für ausführung von scripts:
/*public HauptTimer()
{
new tCount = GetTickCount();
//alles was gestoppt werden soll
printf("HauptTimer: %dms",GetTickCount() - tCount);
return 1;
}*/

#define cmdnichtverfügbar "This Command doesn't exist (yet). Type /help to see all commands and key configurations"

#include <a_samp>
#include <admincars>
#include <GetVehicleColor>
#include <dini>
#include <streamer>
#include <OPMC>
#include <0SimonsInclude>
#include <gl_messages.inc>
#include <gl_common.inc>
#include <sscanf2>
#include <foreach>

new DayNightObject[5];

new Float:MoneyBagPos[3], MoneyBagFound=1, MoneyBagLocation[50], MoneyBagPickup, MoneyBagTimer;
new Float:pingHealth[MAX_PLAYERS];

enum mobileplayer_enum
{
    number
}
new MobilePlayer[MAX_PLAYERS][mobileplayer_enum];

new OnVote;
new Voted[MAX_PLAYERS];

enum VOTES
{
	Vote[50],
	VoteY,
	VoteN,
}
new Voting[VOTES];

#pragma tabsize 0

//Dialoge
#define INFODIALOG 1
#define REGISTERDIALOG 2
#define LOGINDIALOG 3
#define AUTOD 4
#define AUTOM 5
#define PLANED 6
#define PLANEM 7
#define HDIALOG 8
#define UHDIALOG 9
#define MAINHELPDIALOG 10
#define PSEARCHD 11
#define TITEL 12
#define TEXT 13
#define INTERNET 14
#define OPSEARCHD 15
#define MYVMENU 16
#define VMENU 17
#define CARKEYS 18
#define SELLCARPRICE 19
#define SELLCAR 20
#define VEHICLEINFO 21
#define JOBDIALOG 22
#define FIRMADIALOG 23
#define OFFLINEMESSAGES 24
#define AUTOANNAHMEDIALOG 25
#define SELECTMECHANICCARDIALOG 26
#define MINIGAMEDIALOG 27
#define POLIZEIDIALOG 28
#define POLIZEIANNAHMEDIALOG 29
#define HOUSEMESSAGEDIALOG 1511
#define HOUSEOPTIONENDIALOG 1512 //hier


//Farben

//     Hellrot     0xFF0000FF
//     Dunkelrot   0xB00000FF

//     Hellgrün    0x00FF00FF
//     Dunkelgrün  0x008900FF

//     Hellblau    0x0091FFFF
//     Dunkelblau  0x0000FFFF

new jobtime;
new entertownhall;
new exittownhall;
new enterjobroom;
new enterkennzeichenroom;
new mechanikerannahme;

new LoginKick;
new Text:IntroTextBackground[MAX_PLAYERS];
new Text:IntroText[MAX_PLAYERS];
new PlayerText:GeldC[MAX_PLAYERS];
new Geldtimer;
new GeldShowing[MAX_PLAYERS];
new Text:InventarH[MAX_PLAYERS];
new PlayerText:InventarN[MAX_PLAYERS];
new Text:InventarSkin[MAX_PLAYERS];
new Text:InventarStats[MAX_PLAYERS];
new Text:InventarPlatz[MAX_PLAYERS][2];
new PlayerText:InventarPlatzName[MAX_PLAYERS][2];

new OfficeActor;

//new RainbowCarTimer;
//new RainbowColor[MAX_VEHICLES];


new isFrozen[MAX_PLAYERS];

enum afk_info {
AFK_Time,
Float:AFK_Coord,
AFK_Stat
}
new PlayerAFK[MAX_PLAYERS][afk_info];
new AFK_Timer;
new Text3D:AFK_3DT[MAX_PLAYERS];

forward OnInfoBoxGameModeInit();
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////Krankenhaus///////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

new
	Death[MAX_PLAYERS],
	Dmsg[MAX_PLAYERS],
	LS[MAX_PLAYERS],
	SF[MAX_PLAYERS],
	LV[MAX_PLAYERS],
	WS[MAX_PLAYERS],
	FC[MAX_PLAYERS],
	RC[MAX_PLAYERS],
	TR[MAX_PLAYERS],
	BC[MAX_PLAYERS]
;

enum pInfo
{
    pPlaneDistance,
    pBikeDistance,
    pCarDistance,
    pOtherVehicleDistance,
    pKills,
    pDeaths
}
new Spieler[64];
new Sname [MAX_PLAYER_NAME];

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////Anfang des Gamemodes//////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
main( ) { }


public OnGameModeInit()
{
    DisableInteriorEnterExits();
    EnableStuntBonusForAll(0);
    ManualVehicleEngineAndLights();
	ShowPlayerMarkers(PLAYER_MARKERS_MODE_STREAMED);
	SetGameModeText("SCRoleplay");
	//AFK_Timer = SetTimer("AFKCheck",1000,1);
    AddStaticVehicle(520,-2136.3845,-2476.7717,31.2095,339.3210,0,0); // testhydra
	CreateDynamicObject(2165, -2220.39551, -2456.34473, 29.61790,   0.00000, 0.00000, 95.00000);
	CreateObject(10230, -3175.83, 2826.67, 6.22,   0.00, 0.00, 62.28); //Frachtschiff (Intro)
	CreateObject(10231, -3174.93, 2825.15, 7.12,   0.00, 0.00, 62.34); //Container (Intro)
	CreateObject(9698, -3163.56, 2826.17, 633.92,   0.00, 0.00, 0.00); //Führerhaus (Intro)
	CreateObject(9761, -3101.37, 2827.34, 631.92,   0.00, 0.00, 0.00); //Führerhaus (Intro)
    CreateObject(9819, -3160.09, 2833.92, 637.95,   0.00, 0.00, 0.00); //Führerhaus (Intro)
	CreateObject(9818, -3160.03, 2827.22, 638.66,   0.00, 0.00, 0.00); //Führerhaus (Intro)
	CreateObject(9822, -3160.80, 2833.41, 637.80,   0.00, 0.00, 0.00); //Führerhaus (Intro)
	CreateObject(71, -3160.38, 2829.08, 638.01,   90.00, 84.00, 0.00); //Schiffskapitän (Intro)
	CreateObject(16642, -3178.37, 2808.30, 617.50,   0.00, 0.00, 0.00); //Frachtraum (Intro)
	CreateObject(16665, -3201.73, 2807.07, 615.05,   0.00, 0.00, 0.52); //Frachtraum (Intro)
	CreateObject(16662, -3213.45, 2807.07, 615.29,   0.00, 0.00, 64.97); //Frachtraum (Intro)
	CreateObject(16782, -3214.90, 2807.04, 616.24,   0.00, 0.00, 0.00); //Frachtraum (Intro)
	CreateObject(3393, -3209.95, 2813.96, 614.03,   0.00, 0.00, 128.47); //Frachtraum (Intro)
	CreateObject(3391, -3209.95, 2800.29, 614.03,   0.00, 0.00, 230.94); //Frachtraum (Intro)
	CreateObject(14597, 355.26559, 162.09380, 1033.28125,   356.89841, 0.00000, 0.00000);//Office
	CreateObject(1999, 362.32281, 153.15630, 1031.82544,   356.85840, 0.00000, 3.15840);//Schreibtisch(Office)
	CreateObject(2164, 363.10941, 148.35410, 1031.98743,   363.63409, 0.14170, 181.16479);//Bücherregal(Office)
	CreateObject(2001, 361.20081, 148.63541, 1031.94934,   356.85840, 0.00000, -0.78540);//Pflanze(Office)
	CreateObject(1806, 363.36191, 152.1/*original:152.18480*/, 1031.94141,   3.14160, 0.00000, 2.74250);//Stuhl(Office)
	CreateObject(2059, 362.39691, 153.39090, 1032.63464,   -3.11740, -0.56680, -0.56680);//Bücher(Office)
	
	OfficeActor = CreateActor(150, 363.3001,152.5192,1033.8123,357.6914);
	ApplyActorAnimation(OfficeActor, "INT_OFFICE", "OFF_SIT_TYPE_LOOP", 4.1, 1, 0, 0, 0, 0);//stuhl muss zurück

entertownhall = CreatePickup(1318, 1, 1481.1022, -1772.1527,18.7958, 0);
exittownhall = CreatePickup(1318, 1, 1726.9147,-1639.0686,20.2235, 0);
enterjobroom = CreatePickup(1318, 1, 1735.0989,-1660.0570,23.7187, 0);
enterkennzeichenroom = CreatePickup(1318, 1, 1735.0801,-1654.1044,23.7318, 0);
mechanikerannahme = CreatePickup(1318, 1, 216.1411, 34.6930, 1.5344);

MoneyBagTimer = SetTimer("MoneyBag", 600000, true);
MoneyBag();
return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
          new vID,
	      tmp_engine,
     	  tmp_lights,
     	  tmp_alarm,
     	  tmp_doors,
	      tmp_hood,
          tmp_trunk,
     	  tmp_objective,
     	  tmp_driverdoor,
	      tmp_passengerdoor,
	      tmp_backrightdoor,
	      tmp_backleftdoor,
	      tmp_driverwindow,
	      tmp_passengerwindow,
	      tmp_backrightwindow,
	      tmp_backleftwindow;
	      GetVehicleParamsEx(vID,tmp_engine, tmp_lights, tmp_alarm, tmp_doors, tmp_hood, tmp_trunk, tmp_objective);
	      GetVehicleParamsCarDoors(vID,tmp_driverdoor, tmp_passengerdoor, tmp_backleftdoor, tmp_backrightdoor);
	      GetVehicleParamsCarWindows(vID, tmp_driverwindow, tmp_passengerwindow, tmp_backleftwindow, tmp_backrightwindow);
          if (newkeys == KEY_JUMP || newkeys == KEY_SPRINT)
          {
            if(IsPlayerDriver(playerid))
            {
                vID = GetPlayerVehicleID(playerid);
                GetVehicleParamsEx(vID,tmp_engine, tmp_lights, tmp_alarm, tmp_doors, tmp_hood, tmp_trunk, tmp_objective);
				if(tmp_engine == 0)
				{
				   new pmsg[MAX_PLAYERS];
				   format(pmsg,256,"Press 	~k~~VEHICLE_FIREWEAPON_ALT~ to start the engine");
				   return DebugMessage(playerid, pmsg);
				}
				else
				{
				   return 0;
				}
            }
          }
          if (newkeys == KEY_ACTION)                                            //muss weg
          {
            if(IsPlayerDriver(playerid))
            {
               vID = GetPlayerVehicleID(playerid);
	           tmp_engine = 1;
               SetVehicleParamsEx(vID, tmp_engine, tmp_lights, tmp_alarm, tmp_doors, tmp_hood, tmp_trunk, tmp_objective);
            }
          }


		  if(IsPlayerInRangeOfPoint(playerid, 1, 216.1411, 34.6930, 1.5344) && (newkeys & KEY_WALK))
          {
	         ShowPlayerDialog(playerid, AUTOANNAHMEDIALOG, DIALOG_STYLE_LIST, "Hello, what can I do for you?", "I want to buy a car\nI need a mechanic service for my car", "Okay", "Exit");
	         SetPVarInt(playerid, "Dialogid", 1);
          }
          if(IsPlayerInRangeOfPoint(playerid, 1, 1481.1022, -1772.1527,18.7958))
          {
             if (newkeys & KEY_WALK)
	         {
				 SetPlayerInterior(playerid, 18);
				 SetPlayerPos(playerid, 1726.9147,-1639.0686,20.2235);
				 SetTimerEx("EnterTownHall", 500, false, "%i", playerid);
	         }
          }
          if (newkeys & KEY_WALK)
          {
		     new string[20];
			 GetPVarString(playerid, "Interior", string, sizeof string);
             if(strcmp(string, "townhall") == 0)
	         {
                if(IsPlayerInRangeOfPoint(playerid, 1, 1726.9147,-1639.0686,20.2235))
	            {
	                SetPVarString(playerid, "Interior", "Wika<3");
				    SetPlayerInterior(playerid, 0);
				    SetPlayerPos(playerid, 1481.1022, -1772.1527,18.7958);
				}
                else if(IsPlayerInRangeOfPoint(playerid, 1, 1735.0989,-1660.0570,23.7187))
	            {
	                SetPVarString(playerid, "Interior", "Jobs");
					TogglePlayerSpectating(playerid, true);
					InterpolateCameraPos(playerid, 362.350982, 156.007125, 1033.400756, 362.350982, 156.007125, 1033.400756, 5000);
					InterpolateCameraLookAt(playerid, 362.601562, 151.014694, 1033.287475, 362.601562, 151.014694, 1033.287475, 5000);
				    SetPlayerInterior(playerid, 3);
				    ShowPlayerDialog(playerid, JOBDIALOG, DIALOG_STYLE_LIST, "Sign for a new career", "Pilot\nCar mechanic\nWika", "Okay", "Exit");
				    /*SetPlayerPos(playerid, 362.601562, 151.014694, 1033.287475);*/
				}
	         }
          }
return 0;
}

public OnPlayerPickUpPickup(playerid, pickupid)
{
    new pmsg[MAX_PLAYERS];
    if (pickupid == entertownhall)
    {
	    format(pmsg,256,"Press ~k~~SNEAK_ABOUT~ to enter the townhall");
	    SendClientMessage(playerid, Hellblau, pmsg);
	}
    else if (pickupid == exittownhall)
    {
	    format(pmsg,256,"Press ~k~~SNEAK_ABOUT~ to exit the townhall");
	    SendClientMessage(playerid, Hellblau, pmsg);
	}
    else if (pickupid == enterjobroom)
    {
	    format(pmsg,256,"Press ~k~~SNEAK_ABOUT~ to enter the employer room");
	    SendClientMessage(playerid, Hellblau, pmsg);
	}
    else if (pickupid == enterkennzeichenroom)
    {
	    format(pmsg,256,"Press ~k~~SNEAK_ABOUT~ to enter the vehicle registration room");
	    SendClientMessage(playerid, Hellblau, pmsg);
	}
    else if(pickupid == mechanikerannahme)
	{
	    if(GetPVarInt(playerid, "Dialogid") >= 1) return 0;
	    format(pmsg,256,"Press ~k~~SNEAK_ABOUT~");
	    SendClientMessage(playerid, Hellblau, pmsg);
	}
    else if(pickupid == MoneyBagPickup)
	{
	    new string[180], money = (5000 + random(5000));
	    format(string, sizeof(string), "%s found the money bag in %s. It contained $%d.", GetSname(playerid), MoneyBagLocation, money);
	    MoneyBagFound = 1;
	    SendClientMessageToAll(Hellblau, string);
	    DestroyPickup(MoneyBagPickup);
	    SendClientMessage(playerid, Hellgrün, "You have found the money bag.");
        ChangePlayerMoney(playerid, money, "Moneybag");
	    ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 4.0, 0, 0, 0, 0, 0);
	    format(Spieler,sizeof(Spieler),"/Spieler/%s.txt",GetSname(playerid));
	    new MoneyBagsFound = dini_Int(Spieler, "Moneybag");
		dini_IntSet(Spieler,"Moneybag", MoneyBagsFound+1);
	}
return 1;
}

public OnPlayerMoneyChange(playerid, amount, totalamount)
{
   if(NetStats_ConnectionStatus(playerid) == 8)
   {
      new string[100];
      if(GeldShowing[playerid] != 0)
      {
         amount = amount + GeldShowing[playerid];
         format(string, sizeof string, "%i", GeldShowing[playerid]);
         KillTimer(Geldtimer);
      }
	  if(amount == 0)
	  {
	     SendClientMessage(playerid, Weis, "You died. amount = 0");
	     return GeldTimer(playerid);
	  }
      if(LS[playerid] == 1 || LV[playerid] == 1 || SF[playerid] == 1 || WS[playerid] == 1
      || FC[playerid] == 1 || TR[playerid] == 1 || RC[playerid] == 1 || BC[playerid] == 1)
	  {
	     SendClientMessage(playerid, Weis, "You died. LS = 1");
	     return GeldTimer(playerid);
	  } 
      if (amount < 0)
      {
         format(string, sizeof(string), "%i", amount);
         PlayerTextDrawColor(playerid, PlayerText:GeldC[playerid], 0xC10000FF);
      }
      else
      {
         format(string, sizeof(string), "+%i", amount);
         PlayerTextDrawColor(playerid, PlayerText:GeldC[playerid], 0x00FF00FF);
      }
      GeldShowing[playerid] = amount;
      Geldtimer = SetTimerEx("GeldTimer", 5000, false, "i", playerid);
      PlayerTextDrawSetString(playerid, PlayerText:GeldC[playerid], string);
      PlayerTextDrawShow(playerid, PlayerText: GeldC[playerid]);
      GeldSpeichern(playerid);
   }
   return 1;
}

forward GeldTimer(playerid);
public GeldTimer(playerid)
{
   GeldShowing[playerid] = 0;
   PlayerTextDrawHide(playerid, PlayerText: GeldC[playerid]);
   KillTimer(Geldtimer);
   return 1;
}


public OnGameModeExit()
{
for(new i=0;i<MAX_PLAYERS;i++)
    {
        Delete3DTextLabel(AFK_3DT[i]);
    }
    KillTimer(AFK_Timer);
	return 1;
}

/*public OnPlayerFinishedDownloading(playerid, virtualworld)
{
    SendClientMessage(playerid, 0x00FF00FF, "Texture Downloads finished.");
    return 1;
}*/
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////Intro und Registrierungssystem////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
public OnPlayerRequestClass(playerid)
{
     SetSpawnInfo(playerid, 0, 61, -2214.8840,-2450.3630,31.8163,111.7225,0,0,0,0,0,0);//Original: SetSpawnInfo(playerid, 0, 61, -2214.8840,-2450.3630,31.8163,111.7225,0,0,0,0,0,0);
     TogglePlayerSpectating(playerid, true);
	 InterpolateCameraPos(playerid, -3195.774902, 2726.408691, 13.310691, -3125.889648, 2864.192382, 10.777331, 13000);
     InterpolateCameraLookAt(playerid, -3194.178466, 2731.114257, 12.755210, -3130.873535, 2864.548339, 10.964787, 100);
     format (Spieler,sizeof(Spieler),"/Spieler/%s.txt",GetSname(playerid));
     if (dini_Exists(Spieler))
     {
	   deleteme(playerid);//ShowPlayerDialog(playerid,LOGIN,DIALOG_STYLE_INPUT,"Login","Type your password to enter the server","Okay","Exit Server");
	   LoginKick = SetTimer("LoginKick",60000,false);
	   SendClientMessage(playerid,0x0091FFFF,"Welcome back to Simon City!");
	   GameTextForPlayer(playerid,"~w~Welcome to: ~r~Simon City",5000,3);
	   SetPVarInt(playerid, "Loginkick", 0);
	 }
	 else
	 {
       /*SetTimerEx("NextScene", 14000, false, "ii", playerid,0);
	   SendClientMessage(playerid,0x0091FFFF,"Welcome to the Simon City Roleplayer Server!");
	   PlayerTextDrawShow(playerid,PlayerText:TDEditor_PTD[playerid]);
	   TextDrawShowForPlayer(playerid,Text:Intro);
	   SetTimer("Introtext",2500,false);*/
	   ShowPlayerDialog(playerid,REGISTERDIALOG,DIALOG_STYLE_INPUT,"Register for Simon City","Please enter a password to enter the Server","Okay","Exit server");
	   
	 }
	 return 1;
}
/*forward Introtext(playerid);
public Introtext(playerid)
{
	TextDrawHideForPlayer(playerid,Text:Intro);
	TextDrawShowForPlayer(playerid,Text:You);
	TextDrawShowForPlayer(playerid,Text:T1Y);//hier xenia
	SetTimer("Tt2",4000,false);
    return 1;
}
forward Tt2(playerid);
public Tt2(playerid)
{
	TextDrawShowForPlayer(playerid,Text:P2);
	TextDrawShowForPlayer(playerid,Text:T22);
	TextDrawHideForPlayer(playerid,Text:You);
	TextDrawHideForPlayer(playerid,Text:T1Y);
	SetTimer("Tt3",4000,false);
    return 1;
}
forward Tt3(playerid);
public Tt3(playerid)
{
	TextDrawShowForPlayer(playerid,Text:P1);
	TextDrawShowForPlayer(playerid,Text:T31);
	TextDrawHideForPlayer(playerid,Text:P2);
	TextDrawHideForPlayer(playerid,Text:T22);
	SetTimer("Tt4",5000,false);
    return 1;
}
forward Tt4(playerid);
public Tt4(playerid)
{
	TextDrawShowForPlayer(playerid,Text:You);
	TextDrawShowForPlayer(playerid,Text:T4Y);
	TextDrawHideForPlayer(playerid,Text:P1);
	TextDrawHideForPlayer(playerid,Text:T31);
	SetTimer("Tt5",6000,false);
    return 1;
}
forward Tt5(playerid);
public Tt5(playerid)
{
	TextDrawShowForPlayer(playerid,Text:P1);
	TextDrawShowForPlayer(playerid,Text:T51);
	TextDrawHideForPlayer(playerid,Text:You);
	TextDrawHideForPlayer(playerid,Text:T4Y);
	SetTimer("Tt6",4000,false);
    return 1;
}
forward Tt6(playerid);
public Tt6(playerid)
{
	TextDrawShowForPlayer(playerid,Text:You);
	TextDrawShowForPlayer(playerid,Text:T6Y);
	TextDrawHideForPlayer(playerid,Text:P1);
	TextDrawHideForPlayer(playerid,Text:T51);
	SetTimer("Tt7",6000,false);
    return 1;
}
forward Tt7(playerid);
public Tt7(playerid)
{
	TextDrawShowForPlayer(playerid,Text:P1);
	TextDrawShowForPlayer(playerid,Text:T71);
	TextDrawHideForPlayer(playerid,Text:You);
	TextDrawHideForPlayer(playerid,Text:T6Y);
	SetTimer("Tt8",6000,false);
    return 1;
}
forward Tt8(playerid);
public Tt8(playerid)
{
	TextDrawShowForPlayer(playerid,Text:You);
	TextDrawShowForPlayer(playerid,Text:T8Y);
	TextDrawHideForPlayer(playerid,Text:P1);
	TextDrawHideForPlayer(playerid,Text:T71);
	SetTimer("Tt9",5000,false);
    return 1;
}
forward Tt9(playerid);
public Tt9(playerid)
{
	TextDrawShowForPlayer(playerid,Text:P1);
	TextDrawShowForPlayer(playerid,Text:T91);
	TextDrawHideForPlayer(playerid,Text:You);
	TextDrawHideForPlayer(playerid,Text:T8Y);
	SetTimer("Tt10",4000,false);
    return 1;
}
forward Tt10(playerid);
public Tt10(playerid)
{
	TextDrawShowForPlayer(playerid,Text:You);
	TextDrawShowForPlayer(playerid,Text:T10Y);
	TextDrawHideForPlayer(playerid,Text:P1);
	TextDrawHideForPlayer(playerid,Text:T91);
	SetTimer("Tt11",3000,false);
    return 1;
}
forward Tt11(playerid);
public Tt11(playerid)
{
	TextDrawShowForPlayer(playerid,Text:P2);
	TextDrawShowForPlayer(playerid,Text:T112);
	TextDrawHideForPlayer(playerid,Text:You);
	TextDrawHideForPlayer(playerid,Text:T10Y);
	SetTimer("Tt12",1500,false);
    return 1;
}
forward Tt12(playerid);
public Tt12(playerid)
{
	TextDrawShowForPlayer(playerid,Text:P1);
	TextDrawShowForPlayer(playerid,Text:T121);
	TextDrawHideForPlayer(playerid,Text:P2);
	TextDrawHideForPlayer(playerid,Text:T112);
	SetTimer("Tt13",3000,false);
    return 1;
}
forward Tt13(playerid);
public Tt13(playerid)
{
	TextDrawShowForPlayer(playerid,Text:You);
	TextDrawShowForPlayer(playerid,Text:T13Y);
	TextDrawHideForPlayer(playerid,Text:P1);
	TextDrawHideForPlayer(playerid,Text:T121);
	SetTimer("Tt14",6000,false);
    return 1;
}
forward Tt14(playerid);
public Tt14(playerid)
{
	TextDrawShowForPlayer(playerid,Text:P1);
	TextDrawShowForPlayer(playerid,Text:T141);
	TextDrawHideForPlayer(playerid,Text:You);
	TextDrawHideForPlayer(playerid,Text:T13Y);
	SetTimer("Tt15",4000,false);
    return 1;
}
forward Tt15(playerid);
public Tt15(playerid)
{
	TextDrawShowForPlayer(playerid,Text:P3);
	TextDrawShowForPlayer(playerid,Text:T153);
	TextDrawHideForPlayer(playerid,Text:P1);
	TextDrawHideForPlayer(playerid,Text:T141);
	SetTimer("TtXYZ1",4000,false);
    return 1;
}
forward TtXYZ1(playerid);
public TtXYZ1(playerid)
{
	TextDrawShowForPlayer(playerid,Text:P1);
	TextDrawShowForPlayer(playerid,Text:TXYZ1);
	TextDrawHideForPlayer(playerid,Text:P3);
	TextDrawHideForPlayer(playerid,Text:T153);
	SetTimer("Tt16",2000,false);
    return 1;
}
forward Tt16(playerid);
public Tt16(playerid)
{
	TextDrawShowForPlayer(playerid,Text:T161);
	TextDrawHideForPlayer(playerid,Text:TXYZ1);
	SetTimer("Tt17",5000,false);
    return 1;
}
forward Tt17(playerid);
public Tt17(playerid)
{
	TextDrawShowForPlayer(playerid,Text:You);
	TextDrawShowForPlayer(playerid,Text:T17Y);
	TextDrawHideForPlayer(playerid,Text:P1);
	TextDrawHideForPlayer(playerid,Text:T161);
	SetTimer("Tt18",3000,false);
    return 1;
}
forward Tt18(playerid);
public Tt18(playerid)
{
	TextDrawShowForPlayer(playerid,Text:P1);
	TextDrawShowForPlayer(playerid,Text:T181);
	TextDrawHideForPlayer(playerid,Text:You);
	TextDrawHideForPlayer(playerid,Text:T17Y);
	SetTimer("Tt19",4000,false);
    return 1;
}
forward Tt19(playerid);
public Tt19(playerid)
{
	TextDrawShowForPlayer(playerid,Text:T191);
	TextDrawHideForPlayer(playerid,Text:T181);
	SetTimer("Tt20",2500,false);
    return 1;
}
forward Tt20(playerid);
public Tt20(playerid)
{
	TextDrawShowForPlayer(playerid,Text:You);
	TextDrawShowForPlayer(playerid,Text:T20Y);
	TextDrawHideForPlayer(playerid,Text:P1);
	TextDrawHideForPlayer(playerid,Text:T191);
	SetTimer("Tt21",2500,false);
    return 1;
}
forward Tt21(playerid);
public Tt21(playerid)
{
	TextDrawShowForPlayer(playerid,Text:T21Y);
	TextDrawHideForPlayer(playerid,Text:T20Y);
    return 1;
}*/



public OnPlayerConnect(playerid)
{
  DisableInteriorEnterExits();
  SetWeather(2);
  LS[playerid] = 0;
  SF[playerid] = 0;
  LV[playerid] = 0;
  WS[playerid] = 0;
  FC[playerid] = 0;
  RC[playerid] = 0;
  TR[playerid] = 0;
  BC[playerid] = 0;
  Death[playerid] = 0;
  Dmsg[playerid] = 0;
  isFrozen[playerid] = false;


new file[24];
GetPlayerName(playerid, file, 24);
format(file, sizeof(file), "Handys/%s.txt", file);
if(fexist(file))
{
		new File:ftw = fopen(file, io_read);
		new tmp[5];
		fread(ftw, tmp);
		MobilePlayer[playerid][number] = strval(tmp);
		fclose(ftw);
}
else
{
        do MobilePlayer[playerid][number] = 10000 + random(89999);
		while(NumberUsed(playerid));
 		new File:handle1 = fopen(file, io_write);
	    new tmp[7];
	    format(tmp, 7, "%d", MobilePlayer[playerid][number]);
	    fwrite(handle1, tmp);
	    fclose(handle1);
	    /*GetPlayerName(playerid, file, 24);
	    format(file, sizeof(file), "Spieler/%s.txt", file);
	    handle1 = fopen(file, io_write);
		new astring[20];
		format(astring, sizeof astring, "Telefonnummer=%d", MobilePlayer[playerid][number]);
	    fwrite(handle1, astring);
	    fclose(handle1);*/
	    /*GetPlayerName(playerid, Sname, sizeof Sname);
        format(Spieler,sizeof(Spieler),"/Spieler/%s.txt",Sname);
        dini_Set(Spieler, "Telefonnummer", tmp);*/

        new File:handle2;
        if (!fexist("Handys/00Nummern.txt"))
        {
            format(tmp, 8, "%d", MobilePlayer[playerid][number]);
            handle2 = fopen("Handys/00Nummern.txt", io_write);
            fwrite(handle2, tmp);
            fclose(handle2);
        }
        else
        {
            format(tmp, 10, "\r\n%d", MobilePlayer[playerid][number]);
            handle2 = fopen("Handys/00Nummern.txt", io_append);
            fwrite(handle2, tmp);
            fclose(handle2);
        }
}
/*TDEditor_PTD[playerid] = CreatePlayerTextDraw(playerid, -3.666699, 411.770782, "LD_SPAC:black");//hier??
PlayerTextDrawTextSize(playerid, TDEditor_PTD[playerid], 661.000000, 59.000000);
PlayerTextDrawAlignment(playerid, TDEditor_PTD[playerid], 1);
PlayerTextDrawColor(playerid, TDEditor_PTD[playerid], -1);
PlayerTextDrawSetShadow(playerid, TDEditor_PTD[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, TDEditor_PTD[playerid], 255);
PlayerTextDrawFont(playerid, TDEditor_PTD[playerid], 4);
PlayerTextDrawSetProportional(playerid, TDEditor_PTD[playerid], 0);*/

GeldC[playerid] = CreatePlayerTextDraw(playerid, 606.999572, 97.496269, "Geldunterschied");
PlayerTextDrawLetterSize(playerid, GeldC[playerid], 0.548665, 1.998220);
PlayerTextDrawAlignment(playerid, GeldC[playerid], 3);
PlayerTextDrawSetOutline(playerid, GeldC[playerid], 2);
PlayerTextDrawBackgroundColor(playerid, GeldC[playerid], 255);
PlayerTextDrawFont(playerid, GeldC[playerid], 3);
PlayerTextDrawSetProportional(playerid, GeldC[playerid], 1);




InventarH[playerid] = TextDrawCreate(102.399871, 50.299835, "LD_SPAC:white");
TextDrawTextSize(InventarH[playerid], 435.711181, 335.430145);
TextDrawAlignment(InventarH[playerid], 1);
TextDrawColor(InventarH[playerid], TextdrawFarbe);
TextDrawSetShadow(InventarH[playerid], 0);
TextDrawBackgroundColor(InventarH[playerid], 255);
TextDrawFont(InventarH[playerid], 4);
TextDrawSetProportional(InventarH[playerid], 0);

InventarN[playerid] = CreatePlayerTextDraw(playerid, 105.833297, 54.170364, "Inventory_Playername");
PlayerTextDrawLetterSize(playerid, InventarN[playerid], 0.400000, 1.600000);
PlayerTextDrawTextSize(playerid, InventarN[playerid], 534.572021, 0.000000);
PlayerTextDrawAlignment(playerid, InventarN[playerid], 1);
PlayerTextDrawColor(playerid, InventarN[playerid], 255);
PlayerTextDrawUseBox(playerid, InventarN[playerid], 1);
PlayerTextDrawBoxColor(playerid, InventarN[playerid], -16776961);
PlayerTextDrawSetShadow(playerid, InventarN[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, InventarN[playerid], 255);
PlayerTextDrawFont(playerid, InventarN[playerid], 2);
PlayerTextDrawSetProportional(playerid, InventarN[playerid], 1);

InventarSkin[playerid] = TextDrawCreate(102.833343, 78.259231, "");
TextDrawTextSize(InventarSkin[playerid], 102.000000, 109.000000);
TextDrawAlignment(InventarSkin[playerid], 1);
TextDrawColor(InventarSkin[playerid], -1);
TextDrawSetShadow(InventarSkin[playerid], 0);
TextDrawBackgroundColor(InventarSkin[playerid], 0);
TextDrawFont(InventarSkin[playerid], 5);
TextDrawSetProportional(InventarSkin[playerid], 0);
TextDrawSetPreviewModel(InventarSkin[playerid], 0);
TextDrawSetPreviewRot(InventarSkin[playerid], 0.000000, 0.000000, 0.000000, 1.000000);

InventarStats[playerid] = TextDrawCreate(109.333374, 196.637023, "Player_Stats:~n~Food:_20%~n~Seat:_1~n~Money:_-500$");
TextDrawLetterSize(InventarStats[playerid], 0.400000, 1.600000);
TextDrawAlignment(InventarStats[playerid], 1);
TextDrawColor(InventarStats[playerid], 255);
TextDrawSetShadow(InventarStats[playerid], 0);
TextDrawBackgroundColor(InventarStats[playerid], 255);
TextDrawFont(InventarStats[playerid], 1);
TextDrawSetProportional(InventarStats[playerid], 1);

InventarPlatz[playerid][0] = TextDrawCreate(224.666656, 100.088912, "");
TextDrawTextSize(InventarPlatz[playerid][0], 64.749946, 81.689933);
TextDrawAlignment(InventarPlatz[playerid][0], 1);
TextDrawColor(InventarPlatz[playerid][0], -1);
TextDrawSetShadow(InventarPlatz[playerid][0], 0);
TextDrawBackgroundColor(InventarPlatz[playerid][0], 255);
TextDrawFont(InventarPlatz[playerid][0], 5);
TextDrawSetProportional(InventarPlatz[playerid][0], 0);
TextDrawSetSelectable(InventarPlatz[playerid][0], true);
TextDrawSetPreviewModel(InventarPlatz[playerid][0], 19621);
TextDrawSetPreviewRot(InventarPlatz[playerid][0], -45.000000, 0.000000, 135.000000, 1.000000);

/*InventarPlatzName[playerid][0] = TextDrawCreate(257.000000, 101.000000, "Itemname_1");
TextDrawLetterSize(InventarPlatzName[playerid][0], 0.292001, 1.010000);
TextDrawTextSize(InventarPlatzName[playerid][0], -0.990000, 0.000000);
TextDrawAlignment(InventarPlatzName[playerid][0], 2);
TextDrawColor(InventarPlatzName[playerid][0], -1);
TextDrawSetShadow(InventarPlatzName[playerid][0], 0);
TextDrawBackgroundColor(InventarPlatzName[playerid][0], 255);
TextDrawFont(InventarPlatzName[playerid][0], 1);
TextDrawSetProportional(InventarPlatzName[playerid][0], 1);*/

InventarPlatz[playerid][1] = TextDrawCreate(224.666656, 195.088912, "");
TextDrawTextSize(InventarPlatz[playerid][1], 64.749946, 81.689933);
TextDrawAlignment(InventarPlatz[playerid][1], 1);
TextDrawColor(InventarPlatz[playerid][1], -1);
TextDrawSetShadow(InventarPlatz[playerid][1], 0);
TextDrawBackgroundColor(InventarPlatz[playerid][1], 255);
TextDrawFont(InventarPlatz[playerid][1], 5);
TextDrawSetProportional(InventarPlatz[playerid][1], 0);
TextDrawSetSelectable(InventarPlatz[playerid][1], true);
TextDrawSetPreviewModel(InventarPlatz[playerid][1], 19621);
TextDrawSetPreviewRot(InventarPlatz[playerid][1], -45.000000, 0.000000, 135.000000, 1.000000);









PlayerAFK[playerid][AFK_Time] = 0;
PlayerAFK[playerid][AFK_Stat] = 0;

/*Intro = TextDrawCreate(4.333303, 417.318603, "INTRODUCTION");
TextDrawLetterSize(Intro, 0.492000, 2.769777);
You = TextDrawCreate(4.333303, 417.318603, "~g~You:");
TextDrawLetterSize(You, 0.492000, 2.769777);
P1 = TextDrawCreate(4.333303, 417.318603, "~r~Person 1:");
TextDrawLetterSize(P1, 0.492000, 2.769777);
P2 = TextDrawCreate(4.333303, 417.318603, "~b~Person 2:");
TextDrawLetterSize(P2, 0.492000, 2.769777);
P3 = TextDrawCreate(4.333303, 417.318603, "~y~Person 3:");
TextDrawLetterSize(P3, 0.492000, 2.769777);
T1Y = TextDrawCreate(42.999965, 417.318603, "What the f-? Where am I?");
TextDrawLetterSize(T1Y, 0.492000, 2.769777);
new introstring[128];
format(introstring,sizeof(introstring),"Hey, doc! Our number %i just woke up!",playerid);
T22 = TextDrawCreate(85.000053, 417.318603, introstring);
TextDrawLetterSize(T22, 0.492000, 2.769777);
T31 = TextDrawCreate(85.000053, 417.318603, "Hello. You are on our ship. You will be part of a experiment.");
TextDrawLetterSize(T31, 0.492000, 2.769777);
T4Y = TextDrawCreate(42.999965, 417.318603, "But... I did not agree to it! And Experiments on humans are forbidden!");
TextDrawLetterSize(T4Y, 0.492000, 2.769777);
T51 = TextDrawCreate(85.000053, 417.318603, "No one will find out. We will put you on a abandoned island.");
TextDrawLetterSize(T51, 0.492000, 2.769777);
T6Y = TextDrawCreate(42.999965, 417.318603, "But you KIDNAPPED me! Why? What did you do to my wife and kids?");
TextDrawLetterSize(T6Y, 0.492000, 2.769777);
T71 = TextDrawCreate(85.000053, 417.318603, "Don't worry, they're fine. They think that you are dead.");
TextDrawLetterSize(T71, 0.492000, 2.769777);
T8Y = TextDrawCreate(42.999965, 417.318603, "You... MORON! Why did you take me, not someone else?");
TextDrawLetterSize(T8Y, 0.492000, 2.769777);
T91 = TextDrawCreate(85.000053, 417.318603, "We choose random people and let them on that island.");
TextDrawLetterSize(T91, 0.492000, 2.769777);
T10Y = TextDrawCreate(42.999965, 417.318603, "Why? Where is the sense? When can I go back home?");
TextDrawLetterSize(T10Y, 0.492000, 2.769777);
T112 = TextDrawCreate(85.000053, 417.318603, "You wouldn't unders...");
TextDrawLetterSize(T112, 0.492000, 2.769777);
T121 = TextDrawCreate(85.000053, 417.318603, "Shut up and do your work, Hans.");
TextDrawLetterSize(T121, 0.492000, 2.769777);
T13Y = TextDrawCreate(42.999965, 417.318603, "Please, just let me go! I wont say anything! I have alot of money!");
TextDrawLetterSize(T13Y, 0.492000, 2.769777);
T141 = TextDrawCreate(85.000053, 417.318603, "You are already here. I won't let you go now.");
TextDrawLetterSize(T141, 0.492000, 2.769777);
T153 = TextDrawCreate(85.000053, 417.318603, "Hey Doc, get ready. We are already near the destination.");
TextDrawLetterSize(T153, 0.492000, 2.769777);
TXYZ1 = TextDrawCreate(85.000053, 417.318603, "Aye Aye, Captain!");
TextDrawLetterSize(TXYZ1, 0.492000, 2.769777);
T161 = TextDrawCreate(85.000053, 417.318603, "See? There is no back now. You will live a new live there.");
TextDrawLetterSize(T161, 0.492000, 2.769777);
T17Y = TextDrawCreate(42.999965, 417.318603, "Tell me the sense of this stupid experiment!");
TextDrawLetterSize(T17Y, 0.492000, 2.769777);
T181 = TextDrawCreate(85.000053, 417.318603, "No. You wouldnt get it. And if you would, you will forget it.");
TextDrawLetterSize(T181, 0.492000, 2.769777);
T191 = TextDrawCreate(85.000053, 417.318603, "Hans, bring our little forget machine.");
TextDrawLetterSize(T191, 0.492000, 2.769777);
T20Y = TextDrawCreate(42.999965, 417.318603, "Wait... No... Please Stop...");
TextDrawLetterSize(T20Y, 0.492000, 2.769777);
T21Y = TextDrawCreate(42.999965, 417.318603, "AAAAAAAAAAAAAAAAHHHHHHHHHHHHHHHH!");
TextDrawLetterSize(T21Y, 0.492000, 2.769777);*/


     if (IsPlayerNPC(playerid)) return 1;
      {
	  
      new pname[MAX_PLAYER_NAME], string[22 + MAX_PLAYER_NAME];
      new nachricht[128];
      GetPlayerName(playerid, pname, sizeof(pname));
      format(string, sizeof(string), "%s has joined the server", pname);
      SendClientMessageToAll(0xAAAAAAAA, string);
      format(nachricht,sizeof(nachricht),"You have connected to the server successfully. You are ID %i. Have fun on the server!",playerid);
      SendClientMessage(playerid,0x00FF00FF,nachricht);
      

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////Objekte////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
new tmpobjid;
//tmpobjid = CreateDynamicObject(3337, 1418.519531, 1445.463500, 104.974990, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);?
SetDynamicObjectMaterial(tmpobjid, 0, 2591, "ab_partition1", "ab_fabricCheck2", 0x00000000);
tmpobjid = CreateDynamicObject(2731, -2215.937255, -2447.766357, 31.149894, 0.000000, -0.000000, -128.600021, -1, -1, -1, 300.00, 300.00);
SetDynamicObjectMaterialText(tmpobjid, 0, "Admin's House", 130, "Calibri", 100, 0, 0xFFFFFFFF, 0x00000001, 1);
tmpobjid = CreateDynamicObject(500, 1378.235717, 1470.161987, 9.444897, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
//tmpobjid = CreateDynamicObject(19872, 616.192565, -11.283224, 999.001525, 0.000000, 0.000000, 89.999931, -1, -1, -1, 900.00, 900.00);//alte modshop hebebühne


//Wheel Arch Angels Tor
RemoveBuildingForPlayer(playerid, 10575, -2716.3516, 217.4766, 5.3828, 0.25);
//CreateDynamicObject(11313, -1935.85938, 239.53125, 35.35156,   3.14159, 0.00000, 1.57080);

//Transfender San Fierro Tor      tuning modshop
//RemoveBuildingForPlayer(playerid, 11313, -1935.8594, 239.5313, 35.3516, 0.25);
//CreateDynamicObject(971, -1935.85938, 239.53125, 35.35156, 3.14159, 0.00000, 0);
return 1;
}
}

stock NumberUsed(playerid)
{
    for(new i=0; i<MAX_PLAYERS; i++)
        if(MobilePlayer[i][number] == MobilePlayer[playerid][number] && i != playerid) return 1;

    if(fexist("phones/numbers_used.txt"))
    {
        new File:ftw = fopen("phones/numbers_used.txt", io_read);
        new tmp[7];
        while(fread(ftw, tmp))
        {
            printf("[%d]", strval(tmp));
            if(strval(tmp) == MobilePlayer[playerid][number]) return 1;
        }
        fclose(ftw);
    }
    return 0;
}

forward NextScene(playerid, sceneid);
public NextScene(playerid,sceneid)
{
    if(sceneid == 0){
        InterpolateCameraPos(playerid, -3198.921386, 2756.338867, 10.441742, -3198.921386, 2756.338867, 10.441742, 9000);
        InterpolateCameraLookAt(playerid, -3197.996337, 2761.192382, 9.675248, -3197.996337, 2761.192382, 9.675248, 9000);
        SetTimerEx("NextScene", 11000, false, "ii", playerid,1);
        return 1;
    }
    if(sceneid == 1){
        InterpolateCameraPos(playerid, -3182.803955, 2807.267089, 617.085693, -3211.959960, 2807.117187, 616.371643, 10000);
        InterpolateCameraLookAt(playerid, -3187.802246, 2807.365478, 616.996154, -3216.957031, 2807.024169, 616.227416, 10000);
        SetTimerEx("NextScene", 15000, false, "ii", playerid,2);
        return 1;
    }
    if(sceneid == 2){
        InterpolateCameraPos(playerid, -3164.647949, 2830.031738, 629.743164, -3164.099853, 2817.077392, 635.064514, 5000);
        InterpolateCameraLookAt(playerid, -3164.669677, 2825.239257, 631.168457, -3169.064208, 2817.229492, 634.487670, 3500);
        SetTimerEx("NextScene", 4250, false, "ii", playerid,3);
        return 1;
    }
    if(sceneid == 3){
        InterpolateCameraPos(playerid, -3164.099853, 2817.077392, 635.064514, -3167.646240, 2816.322021, 635.216369, 3000);
        InterpolateCameraLookAt(playerid, -3169.064208, 2817.229492, 634.487670, -3167.874023, 2821.186279, 636.350952, 1500);
        SetTimerEx("NextScene", 2500, false, "ii", playerid,4);
        return 1;
    }
    if(sceneid == 4){
        InterpolateCameraPos(playerid, -3167.646240, 2816.322021, 635.216369, -3168.443359, 2829.904296, 638.726379, 7000);
        InterpolateCameraLookAt(playerid, -3167.874023, 2821.186279, 636.350952, -3163.446777, 2830.092041, 638.722473, 4500);
        SetTimerEx("NextScene", 7500, false, "ii", playerid,5);
        return 1;
    }
    if(sceneid == 5){
        InterpolateCameraPos(playerid, -3201.247558, 2806.898925, 618.102539, -3201.247558, 2806.898925, 618.102539, 9000);
        InterpolateCameraLookAt(playerid, -3205.598144, 2806.795898, 615.640563, -3205.598144, 2806.795898, 615.640563, 9000);
        SetTimerEx("NextScene", 11000, false, "ii", playerid,6);
        return 1;
    }
    if(sceneid == 6){
        InterpolateCameraPos(playerid, -3163.179199, 2818.222900, 638.720092, -3162.604736, 2836.413330, 638.554748, 12000);
        InterpolateCameraLookAt(playerid, -3159.166259, 2821.205078, 638.654907, -3157.996582, 2838.353271, 638.598937, 12000);
        SetTimerEx("NextScene", 13000, false, "ii", playerid,7);
        return 1;
    }
    if(sceneid == 7){
        InterpolateCameraPos(playerid, -3202.577392, 2772.619628, 12.834774, -3154.178710, 2864.945800, 18.175601, 11000);
        InterpolateCameraLookAt(playerid, -3205.045166, 2768.299804, 12.335927, -3156.507080, 2860.540283, 17.762012, 11000);
        SetTimerEx("NextScene", 12000, false, "ii", playerid,8);
        return 1;
    }
    if(sceneid == 8){
        InterpolateCameraPos(playerid, -3195.774902, 2726.408691, 13.310691, -3125.889648, 2864.192382, 10.777331, 10000);
        InterpolateCameraLookAt(playerid, -3194.178466, 2731.114257, 12.755210, -3130.873535, 2864.548339, 10.964787, 1000);
        /*PlayerTextDrawHide(playerid,PlayerText:TDEditor_PTD[playerid]);
		TextDrawHideForPlayer(playerid,Text:T21Y);
	    TextDrawHideForPlayer(playerid,Text:You);*/
        ShowPlayerDialog(playerid,REGISTERDIALOG,DIALOG_STYLE_INPUT,"Register for Simon City","This is your last chance to return to normal life. \nIf you really want to join set your password here:","Okay","Exit server");
        return 1;
    }
    return 1;
}



stock StatsCheck(playerid)
{
  format(Spieler, sizeof Spieler, "/Spieler/%s.txt", GetSname(playerid));
  new topstat[1000];
  new dist = dini_Int(Spieler, "Tode");
  new Maxdist = dini_Int("/Server/Stats/Stats.txt", "MaxTod");
  if(dist > Maxdist)
  {
	  format(topstat, sizeof topstat, "Congratulations! You are the player with the most Deaths on this Server!\nYou died %i times! Take a look in /stats. Old record: %i deaths\n\n", dist, Maxdist);
      dini_IntSet("/Server/Stats/Stats.txt","MaxTod",dist);
      dini_Set("/Server/Stats/Stats.txt", "MaxTodName", GetSname(playerid));
  }
  //SendClientMessage(playerid, Hellgrün, "Tode");
  dist = dini_Int(Spieler, "Kills");
  Maxdist = dini_Int("/Server/Stats/Stats.txt", "MaxKill");
  if(dist > Maxdist)
  {
	  format(topstat, sizeof topstat, "%sCongratulations! You are the player with the most Kills on this Server!\nYou killed %i people! Take a look in /stats. Old record: %i Kills\n\n", topstat, dist, Maxdist);
      dini_IntSet("/Server/Stats/Stats.txt","MaxKill",dist);
      dini_Set("/Server/Stats/Stats.txt", "MaxKillName", GetSname(playerid));
  }
  //SendClientMessage(playerid, Hellgrün, "Kills");
  dist = dini_Int(Spieler, "KMStandFlugzeug");
  Maxdist = dini_Int("/Server/Stats/Stats.txt", "MaxFlugzeug");
  if(dist > Maxdist)
  {
	  format(topstat, sizeof topstat, "%sCongratulations! You are the player with the longest distance travelled by plane on this Server!\nYou travelled %i nautical miles which is %i km (%i miles)! Old record: %i nm\n\n", topstat, dist, dist*1852/1000, dist*1852/1000*1000/1609, Maxdist);
      dini_IntSet("/Server/Stats/Stats.txt","MaxFlugzeug",dist);
      dini_Set("/Server/Stats/Stats.txt", "MaxFlugzeugName", GetSname(playerid));
  }
  //SendClientMessage(playerid, Hellgrün, "Flieger");
  dist = dini_Int(Spieler, "KMStandAuto");
  Maxdist = dini_Int("/Server/Stats/Stats.txt", "MaxAuto");
  if(dist > Maxdist)
  {
	  format(topstat, sizeof topstat, "%sCongratulations! You are the player with the longest distance travelled by car on this Server!\nYou travelled %i km (%i miles)! Old record: %i km\n\n", topstat, dist, dist*1000/1609, Maxdist);
      dini_IntSet("/Server/Stats/Stats.txt","MaxAuto",dist);
      dini_Set("/Server/Stats/Stats.txt", "MaxAutoName", GetSname(playerid));
  }
  //SendClientMessage(playerid, Hellgrün, "Auto");
  dist = dini_Int(Spieler, "KMStandMotorrad");
  Maxdist = dini_Int("/Server/Stats/Stats.txt", "MaxMotorrad");
  if(dist > Maxdist)
  {
	  format(topstat, sizeof topstat, "%sCongratulations! You are the player with the longest distance travelled by motor bike on this Server!\nYou travelled %i km (%i miles)! Old record: %i km\n\n", topstat, dist, dist*1000/1609, Maxdist);
      dini_IntSet("/Server/Stats/Stats.txt","MaxMotorrad",dist);
      dini_Set("/Server/Stats/Stats.txt", "MaxMotorradName", GetSname(playerid));
  }
  //SendClientMessage(playerid, Hellgrün, "Moto");
  dist = dini_Int(Spieler, "KMStandLKW");
  Maxdist = dini_Int("/Server/Stats/Stats.txt", "MaxLKW");
  if(dist > Maxdist)
  {
	  format(topstat, sizeof topstat, "%sCongratulations! You are the player with the longest distance travelled by lorrys or trucks on this Server!\nYou travelled %i km (%i miles)! Old record: %i km\n\n", topstat, dist, dist*1000/1609, Maxdist);
      dini_IntSet("/Server/Stats/Stats.txt","MaxLKW",dist);
      dini_Set("/Server/Stats/Stats.txt", "MaxLKWName", GetSname(playerid));
  }
  //SendClientMessage(playerid, Hellgrün, "LkW");
  dist = dini_Int(Spieler, "KMStandHubs");
  Maxdist = dini_Int("/Server/Stats/Stats.txt", "MaxHubs");
  if(dist > Maxdist)
  {
	  format(topstat, sizeof topstat, "%sCongratulations! You are the player with the longest distance travelled by helicopters on this Server!\nYou travelled %i nautical miles which is %i km (%i miles)! Old record: %i nm\n\n", topstat, dist, dist*1852/1000, dist*1852/1000*1000/1609, Maxdist);
      dini_IntSet("/Server/Stats/Stats.txt","MaxHubs",dist);
      dini_Set("/Server/Stats/Stats.txt", "MaxHubsName", GetSname(playerid));
  }
  //SendClientMessage(playerid, Hellgrün, "HUBs");
  dist = dini_Int(Spieler, "Geld");
  Maxdist = dini_Int("/Server/Stats/Stats.txt", "MaxMoney");
  if(dist > Maxdist)
  {
	  format(topstat, sizeof topstat, "%sCongratulations! You are the player with the most money on this Server!\nYou have $%i! Old record: $%i\n\n", topstat, dist, Maxdist);
      dini_IntSet("/Server/Stats/Stats.txt","MaxMoney",dist);
      dini_Set("/Server/Stats/Stats.txt", "MaxMoneyName", GetSname(playerid));
  }
  //SendClientMessage(playerid, Hellgrün, "Geld");
  dist = dini_Int(Spieler, "MotorCheckLeuchte");
  Maxdist = dini_Int("/Server/Stats/Stats.txt", "MaxMotorCheckLeuchte");
  if(dist > Maxdist)
  {
	  format(topstat, sizeof topstat, "%sCongratulations! You are the player with the most caused check engine lights on this Server!\nYou have caused %i engine checklights! Old record: %i times\n\n", topstat, dist, Maxdist);
      dini_IntSet("/Server/Stats/Stats.txt","MaxMotorCheckLeuchte",dist);
      dini_Set("/Server/Stats/Stats.txt", "MaxMotorCheckLeuchteName", GetSname(playerid));
  }
  //SendClientMessage(playerid, Hellgrün, "Motorkontrollleuchte");
  dist = dini_Int(Spieler, "Blitzer");
  Maxdist = dini_Int("/Server/Stats/Stats.txt", "MaxBlitzer");
  if(dist > Maxdist)
  {
	  format(topstat, sizeof topstat, "%sCongratulations! You are the player who got caught in the speed camera the most!\nYou have been flashed %i times! Old record: %i times\n\n", topstat, dist, Maxdist);
      dini_IntSet("/Server/Stats/Stats.txt","MaxBlitzer",dist);
      dini_Set("/Server/Stats/Stats.txt", "MaxBlitzerName", GetSname(playerid));
  }
  //SendClientMessage(playerid, Hellgrün, "Blitzer");
  dist = dini_Int(Spieler, "BlitzerMoney");
  Maxdist = dini_Int("/Server/Stats/Stats.txt", "MaxBlitzerMoney");
  if(dist > Maxdist)
  {
	  format(topstat, sizeof topstat, "%sCongratulations! You are the player who lost the most money due to speed camerast!\nYou have lost $%i! Old record: $%i\n\n", topstat, dist, Maxdist);
      dini_IntSet("/Server/Stats/Stats.txt","MaxBlitzerMoney",dist);
      dini_Set("/Server/Stats/Stats.txt", "MaxBlitzerMoneyName", GetSname(playerid));
  }
  //SendClientMessage(playerid, Hellgrün, "Blitzergeld");
  dist = dini_Int(Spieler, "VerbrauchterSprit");
  Maxdist = dini_Int("/Server/Stats/Stats.txt", "MaxVerbrauchterSprit");
  if(dist > Maxdist)
  {
	  format(topstat, sizeof topstat, "%sCongratulations! You are the player who wasted the most fuel!\nIf EVERY vehicle would have a 80l (21 gallon) fuel tank,\nyou would have wasted ca. %i liters (%i gallons) (In %% added from all vehicles: %i%%)! Old record: %i l\n", topstat, dist*100/125, dist*100/125*1000/3785, dist, Maxdist*100/125);
      dini_IntSet("/Server/Stats/Stats.txt","MaxVerbrauchterSprit",dist);
      dini_Set("/Server/Stats/Stats.txt", "MaxVerbrauchterSpritName", GetSname(playerid));
  }
  //SendClientMessage(playerid, Hellgrün, "Sprit");
  dist = dini_Int(Spieler, "Moneybag");
  Maxdist = dini_Int("/Server/Stats/Stats.txt", "MaxMoneybags");
  if(dist > Maxdist)
  {
	  format(topstat, sizeof topstat, "%sCongratulations! You are the player who found the most money bags!\nYou have found %i money bags! Old record: %i\n", topstat, dist, Maxdist);
      dini_IntSet("/Server/Stats/Stats.txt","MaxMoneybags",dist);
      dini_Set("/Server/Stats/Stats.txt", "MaxMoneybagsName", GetSname(playerid));
  }
  //SendClientMessage(playerid, Hellgrün, "Money Bags");
  ShowPlayerDialog(playerid, OFFLINEMESSAGES, DIALOG_STYLE_MSGBOX, "You broke a new Record!", topstat, "Nice", "");
return 0;
}

forward Loginkick(playerid);
public Loginkick(playerid)
{
	SendClientMessage(playerid,0xFF0000FF,"Login timeout. Try logging in in the next 60 Seconds");
    SetTimerEx("DelayedKick",10,false, "%i", playerid);
    return 1;
}

forward SetNight(night);
public SetNight(night)
{
   if(night == 1)
   {
      SetSVarInt("NachtZeit", 1);
      DayNightObject[1] = CreateDynamicObject(19281, 210.326080, 24.727222, 5.634638, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
      DayNightObject[2] = CreateDynamicObject(19281, 213.416213, 24.727222, 5.634638, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
      DayNightObject[3] = CreateDynamicObject(19281, 252.186248, 26.347223, 6.994638, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
      DayNightObject[4] = CreateDynamicObject(19281, 252.186248, 23.287231, 6.994638, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
      SendClientMessageToAll(Weis, "Nacht");
      return 1;
   }
   else if(night == 0)
   {
      SetSVarInt("NachtZeit", 0);
	  DestroyDynamicObject(DayNightObject[1]);
	  DestroyDynamicObject(DayNightObject[2]);
	  DestroyDynamicObject(DayNightObject[3]);
	  DestroyDynamicObject(DayNightObject[4]);
      SendClientMessageToAll(Weis, "Tag");
	  return 1;
   }
   return 0;
}

public OnPlayerUpdate(playerid)
{
   new H, M, S;
   gettime(H, M, S);
   SetWorldTime(H);
   if(H == 7 || H == 8 || H == 9 || H == 10 || H == 11 || H == 12 || H == 13 || H == 14 || H == 15 || H == 15 || H == 16 || H == 17 || H == 18 || H == 19 || H == 20)
   {
      if(GetSVarInt("NachtZeit") == 1)
      {
         SetNight(0);
      }
   }
   else if(H == 21 || H == 22 || H == 23 || H == 24 || H == 25 || H == 26 || H == 27 || H == 28 || H == 29 || H == 30 || H == 1 || H == 2 || H == 3 || H == 4 || H == 5 || H == 6)
   {
      if(GetSVarInt("NachtZeit") == 0)
      {
         SetNight(1);
      }
   }
  format (Spieler,sizeof(Spieler),"/Spieler/%s.txt",GetSname(playerid));
  if(!strcmp("Online",dini_Get(Spieler,"SpielerStatus"),true))
  {
   if(GetPlayerPing(playerid) > 500)
    {
    if(!isFrozen[playerid])
        {
            GameTextForPlayer(playerid, "~r~Your ping exceeds the servers expectations. ~b~You will be ping banned until your ping is normal.", 3000, 5);
            GetPlayerHealth(playerid, pingHealth[playerid]);
            TogglePlayerControllable(playerid, 0);
            SetPlayerHealth(playerid, 9999999);
            new string[40];
   			format(string, sizeof(string), "%s has been ping banned.", GetSname(playerid));
            SendClientMessageToAll(Hellrot, string);
            SendClientMessage(playerid, Hellrot, "If this happens often, please try to get a better internet connection or contact an admin");
            isFrozen[playerid] = true;
        }
    }
    else if(GetPlayerPing(playerid) < 250)
    {
        if(isFrozen[playerid])
        {
            TogglePlayerControllable(playerid, 1);
            isFrozen[playerid] = false;
            if(pingHealth[playerid] <= 0)
            {
               SetPlayerHealth(playerid, 100);
			   SendClientMessage(playerid, Hellblau, "Your health has been set to 100 since the system didnt save your health properly. Sorry for that.");
            }
            else
            {
               SetPlayerHealth(playerid, pingHealth[playerid]);
               format(Spieler, sizeof Spieler, "Your health has been set back to %0.0f", pingHealth[playerid]);
			   SendClientMessage(playerid, Hellblau, Spieler);
            }
        }
    }
  }
  return 1;
}

forward afkstart(playerid);
public afkstart(playerid)
{
            PlayerAFK[playerid][AFK_Stat] = 1;
            PlayerAFK[playerid][AFK_Time] = 1;
            return 1;
}

forward AFKCheck();
public AFKCheck()
{
    new Float:AFKCoords[3];
    for(new i = 0;i<MAX_PLAYERS;i++)
    {
        if(!IsPlayerConnected(i)){continue;}
        if(IsPlayerNPC(i)){continue;}

        GetPlayerPos(i,AFKCoords[0],AFKCoords[1],AFKCoords[2]);

        if(AFKCoords[0] == PlayerAFK[i][AFK_Coord])
        {
            PlayerAFK[i][AFK_Time]++;
        }
        else
        {
            PlayerAFK[i][AFK_Time] = 0;
            if(PlayerAFK[i][AFK_Stat] != 0) { Delete3DTextLabel(AFK_3DT[i]); PlayerAFK[i][AFK_Stat] = 0; }
        }

        PlayerAFK[i][AFK_Coord] = AFKCoords[0];

        if(PlayerAFK[i][AFK_Time] == 1 && PlayerAFK[i][AFK_Stat] == 0)
        {
            AFK_3DT[i] = Create3DTextLabel("AFK", 0xFF0000FF, 0, 0, 0, 15.0, 0, 0);
            Attach3DTextLabelToPlayer(AFK_3DT[i], i, 0.0, 0.0, 0.3);
            PlayerAFK[i][AFK_Stat] = 1;
        }
        if(PlayerAFK[i][AFK_Stat] == 1)
        {
            new str[16]; format(str,16,"AFK: %d sec",PlayerAFK[i][AFK_Time]);
            Update3DTextLabelText(AFK_3DT[i], 0xFF0000FF, str);
        }
        if(IsPlayerAdmin(i)){continue;}

        if(PlayerAFK[i][AFK_Time] > 120)
        {
            SendClientMessage(i, 0xFF0000FF,"You were too long inactive.");
            if(!IsPlayerAdmin(i))
            {
            SetTimerEx("DelayedKick", 10, false, "i", i);
            new KNAME[MAX_PLAYER_NAME];
            new string[70];
			GetPlayerName(i, KNAME, sizeof KNAME);
            format(string, sizeof string, "%s was too long afk.", KNAME);
            print(string);
            }
            continue;
        }

        if(PlayerAFK[i][AFK_Time] == 1)
        {
            SendClientMessage(i, 0xFF0000FF,"You are now afk.");
            continue;
        }
        if(PlayerAFK[i][AFK_Time] == 60)
        {
            SendClientMessage(i, 0xFF0000FF,"You are too long inactive!");
            PlayerPlaySound(i,17802,0.0,0.0,0.0);
            continue;
        }
        if(PlayerAFK[i][AFK_Time] == 115)
        {
            SendClientMessage(i, 0xFF0000FF,"Getting kicked in 5 seconds... Move to prevent from getting kicked.");
            PlayerPlaySound(i,17802,0.0,0.0,0.0);
            continue;
        }
    }
    return 1;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////Dini Speichern////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
public OnPlayerDisconnect(playerid, reason)
{
    DeletePVar(playerid, "KMStand");
    DeletePVar(playerid, "Fuel");
    StopAudioStreamForPlayer(playerid);
	LS[playerid] = 0;
	SF[playerid] = 0;
	LV[playerid] = 0;
	WS[playerid] = 0;
	FC[playerid] = 0;
	RC[playerid] = 0;
	TR[playerid] = 0;
	BC[playerid] = 0;
	Death[playerid] = 0;
	Dmsg[playerid] = 0;
	
	PlayerAFK[playerid][AFK_Time] = 0;
    if(PlayerAFK[playerid][AFK_Stat] != 0) { Delete3DTextLabel(AFK_3DT[playerid]); PlayerAFK[playerid][AFK_Stat] = 0; }
    
    {
	 if (IsPlayerNPC(playerid)) return 1;
	 new Year, Month, Day;
	 getdate(Year, Month, Day);
	 new datestr[30];
	 format(datestr,sizeof(datestr),"%02d/%s/%s",Day,GetMonth(Month),GetYearFormat00(Year));
	 dini_Set(Spieler,"SpielerStatus",datestr);
	 gettime(Year, Month, Day);
	 format(datestr,sizeof(datestr),"%i:%i",Year,Month);
	 dini_Set(Spieler,"SpielerStatusZ",datestr);
     ResetPlayerMoney(playerid);
    }
	
    new pname[MAX_PLAYER_NAME], string[39 + MAX_PLAYER_NAME];
    GetPlayerName(playerid, pname, sizeof(pname));
    switch(reason)
    {
        case 0: format(string, sizeof(string), "%s has lost the Connection to the server.", pname);
        case 1: format(string, sizeof(string), "%s has left the server.", pname);
        case 2: format(string, sizeof(string), "%s has been kicked from the server.", pname);
    }
    SendClientMessageToAll(0xAAAAAAAA, string);
    return 1;
}

stock GetMonth(Month)
{
    new MonthStr[15];
    switch(Month)
    {
        case 1:  MonthStr = "1";
        case 2:  MonthStr = "2";
        case 3:  MonthStr = "3";
        case 4:  MonthStr = "4";
        case 5:  MonthStr = "5";
        case 6:  MonthStr = "6";
        case 7:  MonthStr = "7";
        case 8:  MonthStr = "8";
        case 9:  MonthStr = "9";
        case 10: MonthStr = "10";
        case 11: MonthStr = "11";
        case 12: MonthStr = "12";
    }
    return MonthStr;
}

stock GetYearFormat00(Year)
{
    new YearStr[25];
    switch(Year)
    {
        case 2021: 	YearStr = "2021";
        case 2022: 	YearStr = "2022";
        case 2023: 	YearStr = "2023";
        case 2024: 	YearStr = "2024";
        case 2025: 	YearStr = "2025";
        case 2026: 	YearStr = "2026";
        case 2027: 	YearStr = "2027";
        case 2028: 	YearStr = "2028";
        case 2029: 	YearStr = "2029";
        case 2030: 	YearStr = "2030";
        case 2031: 	YearStr = "2031";
        case 2032: 	YearStr = "2032";
        case 2033: 	YearStr = "2033";
        case 2034: 	YearStr = "2034";
        case 2035: 	YearStr = "2035";
        case 2036: 	YearStr = "2036";
        case 2037: 	YearStr = "2037";
        case 2038: 	YearStr = "2038";
        case 2039: 	YearStr = "2039";
        case 2040: 	YearStr = "2040";

    }
    return YearStr;
}

forward MoneyBag();
public MoneyBag()
{
    	new string[175];
        if(!MoneyBagFound)
        {
            format(string, sizeof(string), "There is a money bag somewhere in %s. Go find the bag and collect the money.", MoneyBagLocation);
            SendClientMessageToAll(Hellblau, string);
        }
        else if(MoneyBagFound)
        {
            MoneyBagFound = 0;
            new randombag = random(sizeof(MBSPAWN));
            MoneyBagPos[0] = MBSPAWN[randombag][XPOS];
            MoneyBagPos[1] = MBSPAWN[randombag][YPOS];
            MoneyBagPos[2] = MBSPAWN[randombag][ZPOS];
            format(MoneyBagLocation, sizeof(MoneyBagLocation), "%s", MBSPAWN[randombag][Position]);
            format(string, sizeof(string), "There is a money bag somewhere in %s. Go find the bag and collect the money.", MoneyBagLocation);
        	SendClientMessageToAll(Hellblau, string);
         	MoneyBagPickup = CreatePickup(1550, 2, MoneyBagPos[0], MoneyBagPos[1], MoneyBagPos[2], -1);
        }
        return 1;
}

forward GeldSpeichern(playerid);
public GeldSpeichern(playerid)
{
  format (Spieler,sizeof(Spieler),"/Spieler/%s.txt",GetSname(playerid));
  if(!strcmp("Online",dini_Get(Spieler,"SpielerStatus"),true))
  {
   GetPlayerName(playerid,Sname,sizeof(Sname));
   format (Spieler,sizeof(Spieler),"/Spieler/%s.txt",Sname);
   dini_IntSet(Spieler,"Temp_Durchschnittsverbrauch",GetPlayerMoney(playerid)*5);
   dini_IntSet(Spieler,"Geld",GetPlayerMoney(playerid));
  }
  return 1;
}

stock GeldLaden(playerid)

{
 GetPlayerName(playerid,Sname,sizeof(Sname));
 format (Spieler,sizeof(Spieler),"/Spieler/%s.txt",Sname);
 if (dini_Exists(Spieler))
 {
  SetPlayerMoney(playerid,dini_Int(Spieler,"Temp_Durchschnittsverbrauch")/5);
 }
  return 1;
}

public OnPlayerSpawn(playerid)
{
KillTimer(LoginKick);
CancelSelectTextDraw(playerid);
    if(Death[playerid] == 1)
    GivePlayerMoney(playerid, 100);
	GeldTimer(playerid);
	{
		Death[playerid] = 0;
	    ResetPlayerWeapons(playerid);
        if(!Dmsg[playerid])
	    if(LS[playerid] == 1)
	    {
	        new rand = random(2);
			LS[playerid] = 0;
	        switch(rand)
	        {
	            case 0: {
					SetPlayerPos(playerid, 1172.2102,-1323.7317,15.4038);
					SetPlayerFacingAngle(playerid,265.0548);
	            }
	            case 1: {
	                SetPlayerPos(playerid, 2033.6859,-1401.7554,17.2902);
	                SetPlayerFacingAngle(playerid,171.9480);
	            }
	        }
   		}
	    else if(LV[playerid] == 1)
	    {
	            SetPlayerPos(playerid, 1583.7286,1768.5331,10.8203);
	            SetPlayerFacingAngle(playerid,86.9690);
	            LV[playerid] = 0;
     	}
	    else if(SF[playerid] == 1)
	    {
     		SetPlayerPos(playerid, -2665.4229,640.0861,14.4531);
     		SetPlayerFacingAngle(playerid,172.2198);
     		SF[playerid] = 0;
	    }
	    else if(WS[playerid] == 1)
        {
    		SetPlayerPos(playerid, -2203.9724, -2309.4512, 31.3750);
    		SetPlayerFacingAngle(playerid,231.2955);
            WS[playerid] = 0;
        }
        else if(FC[playerid] == 1)
        {
    		SetPlayerPos(playerid, -2203.9724, -2309.4512, 31.3750);
    		SetPlayerFacingAngle(playerid,231.2955);
            FC[playerid] = 0;
        }
        else if(TR[playerid] == 1)
        {
    		SetPlayerPos(playerid, -1514.4232,2519.1870,56.0703);
    		SetPlayerFacingAngle(playerid,1.1382);
            TR[playerid] = 0;
        }
        else if(RC[playerid] == 1)
        {
    		SetPlayerPos(playerid, 1241.6947,326.2329,19.7555);
    		SetPlayerFacingAngle(playerid,334.1913);
            RC[playerid] = 0;
        }
        else if(BC[playerid] == 1)
        {
    		SetPlayerPos(playerid, -318.8487,1048.2350,20.3403);
    		SetPlayerFacingAngle(playerid,357.9815);
            BC[playerid] = 0;
        }
	}
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	format(Spieler, sizeof Spieler, "/Spieler/%s.txt", GetSname(playerid));
	new Tod = dini_Int(Spieler, "Tode");
	dini_IntSet(Spieler,"Tode",Tod+1);
	format(Spieler, sizeof Spieler, "/Spieler/%s.txt", GetSname(killerid));
	new Kill = dini_Int(Spieler, "Kills");
	dini_IntSet(Spieler,"Kills",Kill+1);
 	if (killerid != INVALID_PLAYER_ID)
	{
		SendDeathMessage(killerid,playerid,reason);
	}
	else
	{
		SendDeathMessage(INVALID_PLAYER_ID,playerid,reason);
	}
	Death[playerid] = 1;
    if(IsPlayerInLosSantos(playerid))
    {
		LS[playerid] = 1;
	}
    if(IsPlayerInLasVenturas(playerid))
    {
    	LV[playerid] = 1;
 	}
    if(IsPlayerInSanFierro(playerid))
    {
 		SF[playerid] = 1;
    }
    if(IsPlayerInWhetstone(playerid))
    {
        WS[playerid] = 1;
    }
    if(IsPlayerInFlintCounty(playerid))
    {
        FC[playerid] = 1;
    }
    if(IsPlayerInRedCounty(playerid))
    {
        RC[playerid] = 1;
	}
	if(IsPlayerInTierraRobada(playerid))
	{
	    TR[playerid] = 1;
	}
	if(IsPlayerInBoneCounty(playerid))
	{
	    BC[playerid] = 1;
	}
   GameTextForPlayer(playerid,"                          ~r~You passed out.                              ~g~You will respawn in hospital.",5000,5);
   //dini_IntSet(Spieler,"Temp_Durchschnittsverbrauch",0);
   return 1;
}

/*forward RainbowCar(playerid, vehicleid);
public RainbowCar(playerid, vehicleid)
{
ChangeVehicleColor(vehicleid, RandomColor(), RandomColor());
return 1;
}

stock RandomColor()
{
new randomcolor = random(255);
return randomcolor;
}*/

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////RCON, Befehle/////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
public OnPlayerCommandText(playerid, cmdtext[])
{
AdminCarCMDText(playerid, cmdtext);
new	tmp[256+1];

#if !defined isnull
	#define isnull(%1) \
				((!(%1[0])) || (((%1[0]) == '\1') && (!(%1[1]))))
#endif

	new ccmd[256+1], idxx;
	ccmd = strtok(cmdtext, idxx);
    if(!strcmp("/scene", cmdtext, true))
    {
        SetTimerEx("NextScene", 14000, false, "ii", playerid,0);
        TogglePlayerSpectating(playerid, true);
	    InterpolateCameraPos(playerid, -3195.774902, 2726.408691, 13.310691, -3125.889648, 2864.192382, 10.777331, 13000);
        InterpolateCameraLookAt(playerid, -3194.178466, 2731.114257, 12.755210, -3130.873535, 2864.548339, 10.964787, 100);
	    /*PlayerTextDrawShow(playerid,PlayerText:TDEditor_PTD[playerid]);
	    TextDrawShowForPlayer(playerid,Text:Intro);*/
	    SetTimer("Introtext",2500,false);
        return 1;
    }
    if(!strcmp("/inventory", cmdtext, true))
    {
		TextDrawShowForPlayer(playerid, InventarH[playerid]);
		PlayerTextDrawShow(playerid, InventarN[playerid]);
		new string[46];
		format(string, sizeof string, "%s Inventory", GetSname(playerid));
		PlayerTextDrawSetString(playerid, InventarN[playerid], string);
		TextDrawShowForPlayer(playerid, InventarSkin[playerid]);
		TextDrawShowForPlayer(playerid, InventarStats[playerid]);
		TextDrawShowForPlayer(playerid, InventarPlatz[playerid][0]);
		TextDrawShowForPlayer(playerid, InventarPlatz[playerid][1]);
        return 1;
    }
	if(!strcmp("/moneyhistory", cmdtext, true))
	{
	   new string[255];
       format(Spieler,sizeof(Spieler),"/Spieler/%s.txt",GetSname(playerid));
	   format(string, sizeof string, "%s \n%s \n%s \n%s \n%s", dini_Get(Spieler, "Geld1"), dini_Get(Spieler, "Geld2"), dini_Get(Spieler, "Geld3"),
	   dini_Get(Spieler, "Geld4"), dini_Get(Spieler, "Geld5"));
	   format(string, sizeof string, "%s \n%s \n%s \n%s \n%s", string, dini_Get(Spieler, "Geld6"), dini_Get(Spieler, "Geld7"), dini_Get(Spieler, "Geld8"),
	   dini_Get(Spieler, "Geld9"));
	   format(string, sizeof string, "%s \n%s", string, dini_Get(Spieler, "Geld10"));
	   ShowPlayerDialog(playerid, INFODIALOG, DIALOG_STYLE_LIST, "Money History", string, "Okay", "Exit");
	   return 1;
	}
	/*if(strcmp(ccmd, "/rainbow", true) == 0)
	{
	    new vehicleid = GetPlayerVehicleID(playerid);
	    if(!IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid, Hellrot, "You are not in a car");
	    {
		  new ttmp[256+1];
		  ttmp = strtok(cmdtext, idxx);
		  if(strlen(ttmp) == 0) return SendClientMessage(playerid, Hellrot, "/rainbow timer_in_milliseconds (1000 milliseconds is 1 second)");
		  if(strval(ttmp) < 100) return SendClientMessage(playerid, Hellrot, "Dont do it under 0.1 seconds. If it changes color every 0.1 seconds, it change color in a total of 10 times PER SECOND.");
		  KillTimer(RainbowCarTimer);
		  RainbowCarTimer = SetTimerEx("RainbowCar", (strval(ttmp)), true, "%i, %i", playerid, vehicleid);
		  RainbowColor[vehicleid] = 1;
		  new string[50];
		  format(string, sizeof string, "Rainbow on with a changetime of %i seconds (%i milliseconds)", strval(ttmp)/1000, strval(ttmp));
		  SendClientMessage(playerid, Hellgrün, string);
		  return 1;
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
	}*/
	/*if(strcmp("/wikaa", cmdtext, true, 10) ==0)
	{
	   ApplyAnimation(playerid, "INT_OFFICE", "OFF_SIT_TYPE_LOOP", 4.1, 1, 0, 0, 0, 0, 1);
	   return 1;
	}*/
    if(!strcmp("/raketenwerfer", cmdtext, true))
    {
        if (IsPlayerAdmin(playerid) == 0)return SendClientMessage(playerid, Hellrot, cmdnichtverfügbar);
        {
            GivePlayerWeapon(playerid, 35, 500);
	    }
        return 1;
    }
    if(!strcmp("/9mm", cmdtext, true))
    {
        if (IsPlayerAdmin(playerid) == 0)return SendClientMessage(playerid, Hellrot, cmdnichtverfügbar);
        {
            GivePlayerWeapon(playerid, 22, 500);
	    }
        return 1;
    }
    if(!strcmp("/minigun", cmdtext, true))
    {
        if (IsPlayerAdmin(playerid) == 0)return SendClientMessage(playerid, Hellrot, cmdnichtverfügbar);
        {
            GivePlayerWeapon(playerid, 38, 5000);
	    }
        return 1;
    }
    if(!strcmp("/ak", cmdtext, true))
    {
        if (IsPlayerAdmin(playerid) == 0)return SendClientMessage(playerid, Hellrot, cmdnichtverfügbar);
        {
            GivePlayerWeapon(playerid, 30, 5000);
	    }
        return 1;
    }
    if(!strcmp("/neunmm", cmdtext, true))
    {
        if (IsPlayerAdmin(playerid) == 0)return SendClientMessage(playerid, Hellrot, cmdnichtverfügbar);
        {
            GivePlayerWeapon(playerid, 22, 500);
	    }
        return 1;
    }
    if(strcmp(ccmd, "/money", true) == 0)
	{
	   new ttmp[256+1];
	   ttmp = strtok(cmdtext, idxx);
	   if(strlen(ttmp) == 0) return SendClientMessage(playerid, Hellrot, "/money amount");
	   ChangePlayerMoney(playerid, strval(ttmp), "Hacks");
	   return 1;
	}
	if(strcmp("/respawn", cmdtext, true, 10) ==0)
	{
	   SetPlayerPos(playerid,-2214.8840,-2450.3630,31.8163);
	   SetPlayerInterior(playerid, 0);
	   SetPlayerVirtualWorld(playerid, 0);
	   SetPVarString(playerid, "Job", "Pilot");
	   TogglePlayerSpectating(playerid, 0);
	   return 1;
	}
	if(strcmp("/wika", cmdtext, true, 10) ==0)
	{
	   SetPlayerPos(playerid, 1481.1022, -1772.1527,18.7958);
	   SetPlayerInterior(playerid, 0);
	   SetPlayerVirtualWorld(playerid, 0);
	   SetPVarString(playerid, "Job", "Pilot");
	   TogglePlayerSpectating(playerid, 0);
	   return 1;
	}
	if(strcmp("/wikalein", cmdtext, true, 10) ==0)
	{
	   SetPlayerPos(playerid, 266.948,28.492,3.502);
	   SetPlayerInterior(playerid, 0);
	   SetPlayerVirtualWorld(playerid, 0);
	   return 1;
	}
	if(strcmp("/select", cmdtext, true, 10) ==0)
	{
		 SelectTextDraw(playerid, TextdrawFarbe);
		 return 1;
	}
	if(strcmp("/tunin", cmdtext, true, 10) ==0)
	{
		 new lol = CreateVehicle(566, -1944.9631,224.0898,33.7846, 0, 226, 0, 99999);
		 PutPlayerInVehicle(playerid, lol, 0);
		 return 1;
	}
    if(strcmp(ccmd, "/spawnv", true) == 0)
	{
	    if(IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid, Hellrot, "You are in a car");
	    {
		  new ttmp[256+1];
		  ttmp = strtok(cmdtext, idxx);
		  if(strlen(ttmp) == 0) return SendClientMessage(playerid, Hellrot, "/spawnv vehicleid");
		  new Float: X, Float:Y, Float:Z, Float: FA;
		  GetPlayerPos(playerid, X, Y, Z);
		  GetPlayerFacingAngle(playerid, FA);
		  new car = CreateVehicle(strval(ttmp), X, Y, Z ,FA, 0, 0, 60000);
		  PutPlayerInVehicle(playerid, car, 0);
	      new tmp_engine,
     	  tmp_lights,
     	  tmp_alarm,
     	  tmp_doors,
	      tmp_hood,
          tmp_trunk,
     	  tmp_objective;
     	  tmp_engine = 0;
     	  CallRemoteFunction("OnVehicleSpawn", "%i", car);
	      SetVehicleParamsEx(car,tmp_engine, tmp_lights, tmp_alarm, tmp_doors, tmp_hood, tmp_trunk, tmp_objective);
	    }
	    return 1;
	}
    if(strcmp(ccmd, "/skin", true) == 0)
	{
	    if(IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid, Hellrot, "You are in a car");
	    {
		  new ttmp[256+1];
		  ttmp = strtok(cmdtext, idxx);
		  if(strlen(ttmp) == 0) return SendClientMessage(playerid, Hellrot, "/skin skinid");
		  SetPlayerSkin(playerid, strval(ttmp));
	    }
	    return 1;
	}
	if(strcmp(ccmd, "/sound", true) == 0)//2,12,7,9,10,16
	{
		new ttmp[256+1];
		ttmp = strtok(cmdtext, idxx);

		if(strlen(ttmp) == 0) return SendClientMessage(playerid, Hellblau, "sound soundid");

		PlayerPlaySound(playerid, strval(ttmp), 0, 0, 0);
		return 1;
	}
	if(strcmp(ccmd, "/wetter", true) == 0)//2,12,7,9,10,16
	{
		new ttmp[256+1];
		ttmp = strtok(cmdtext, idxx);
		SendClientMessage(playerid, Hellblau, "Benutzbare Wetterids: 2,12,7,9,10,16");

		if(strlen(ttmp) == 0) return SendClientMessage(playerid, Hellrot, "/wetter wetterid");

		SetWeather(strval(ttmp));
		return 1;
	}
	if(strcmp(ccmd, "/zeit", true) == 0)//2,12,7,9,10,16
	{
		new ttmp[256+1];
		ttmp = strtok(cmdtext, idxx);

		if(strlen(ttmp) == 0) return SendClientMessage(playerid, Hellrot, "/zeit stunde");

		SetWorldTime(strval(ttmp));
		return 1;
	}
	if(strcmp("/gotomoneybag", cmdtext, true, 10) ==0)
	{
		if(!IsPlayerAdmin(playerid)) return 0;
		SetPlayerPos(playerid, MoneyBagPos[0], MoneyBagPos[1] +3, MoneyBagPos[2]);
		return SendClientMessage(playerid, Hellgrün, "You have been teleported to the money bag");
	}
	if(strcmp("/startmoneybag", cmdtext, true, 10) ==0)
	{
		MoneyBagFound = 1;
		KillTimer(MoneyBagTimer);
		MoneyBagTimer = SetTimer("MoneyBag", 600000, true);
		MoneyBag();
		return 1;
	}
	if(strcmp("/stopmoneybag", cmdtext, true, 10) ==0)
	{
		KillTimer(MoneyBagTimer);
		MoneyBagFound = 1;
		return 1;
	}
	if(strcmp("/moneybag", cmdtext, true, 10) ==0)
	{
		new string[100];
		if(!MoneyBagFound)
        {
            format(string, sizeof(string), "There is a money bag somewhere in %s. Go find the bag and claim the money.", MoneyBagLocation);
            return SendClientMessage(playerid, Hellblau, string);
        }
        else if(MoneyBagFound)
        {
            return SendClientMessage(playerid, Hellrot, "There is currently no moneybag.");
        }
	}
	if(strcmp("/myvehicles", cmdtext, true, 10) ==0)
	{
	   return 1;
	}
	if(strcmp("/kickme", cmdtext, true, 10) ==0)
	{
	   Kick(playerid);
	   return 1;
	}
	if(!strcmp("/kill", cmdtext, true) || !strcmp("/suicide", cmdtext, true))
	{
	   SetPlayerHealth(playerid,0);
	   return 1;
	}
	if(strcmp("/help", cmdtext, true, 10) ==0)
	{
	   ShowPlayerDialog(playerid, MAINHELPDIALOG, DIALOG_STYLE_LIST, "Help", "Commands \nKeys \nMoney \nJobs \nHouses \nVehicles \nComputer \nPhones \n...", "Okay", "Exit");
	   return 1;
	}
	if(strcmp("/hesoyam", cmdtext, true, 10) ==0)
	{
	  new Float:hp;
      ChangePlayerMoney(playerid, 1, "Money Cheat");
	  GetPlayerHealth(playerid, hp);
	  SetPlayerHealth(playerid, hp+1);
	  return 1;
	}
	{
      new cmd[255];
      new Message[256];
      new idx;
      new actiontext[MAX_CHATBUBBLE_LENGTH+1];
      cmd = strtok(cmdtext, idx);
      if(strcmp("/ghost", cmd, true) == 0)
      {
         Message = strrest(cmdtext,idx);
         format(actiontext,MAX_CHATBUBBLE_LENGTH,"%s",Message);
         SendClientMessageToAll(Weis,actiontext);
         return 1;
      }
      if(!strcmp("/l", cmd, true) || !strcmp("/local", cmd, true) ||  !strcmp("/here", cmd, true) || !strcmp("/around", cmd, true))
      {
         Message = strrest(cmdtext,idx);
         format(actiontext,MAX_CHATBUBBLE_LENGTH,"%s",Message);
       	 SetPlayerChatBubble(playerid,actiontext,Weis,30.0,10000);
       	 format(actiontext,MAX_CHATBUBBLE_LENGTH,"{696969}(Speech bubble over your head):{FFFFFF}%s",Message);
       	 SendClientMessage(playerid,ACTION_COLOR,actiontext);
		 return 1;
      }
      if(!strcmp("/id", cmd, true))
      {
	     Message = strrest(cmdtext,idx);
		 GetPlayerName(playerid, Sname, sizeof Sname);
       	 format(actiontext,MAX_CHATBUBBLE_LENGTH,"%s (%i): %s",Sname, playerid, Message);
       	 SendClientMessageToAll(Weis,actiontext);
		 return 1;
      }
      if(ProcessChatCommands(playerid,cmdtext))
      {
         return 1;
      }
      if(!strcmp("/vote", cmd, true))
      {
         //tmp = strtok(cmdtext,idx);
         //strins(string, lastchars("Only the last 5 characters will be SAVED", 5));
         tmp = strrest(cmdtext,idx);

         if(!strlen(tmp)) return SendClientMessage(playerid, 0xFF0000FF, "Voting: /vote <Text>");
         if(OnVote == 1) return SendClientMessage(playerid,0xFF0000FF,"There is already a vote");
         new str[128];
         strcpy(Voting[Vote], tmp, 50);
         if(!IsPlayerAdmin(playerid))
         {
            if(GetPVarInt(playerid,"CMDVOTE") > GetTickCount()) return SendClientMessage(playerid,0xFF0000FF,"You have to wait 10 minutes to vote again");
            format(str, sizeof(str), "%s has started a vote: {00FF00}%s", GetSname(playerid), tmp);
            SendClientMessageToAll(0x0091FFFF, str);
            SendClientMessageToAll(0x0091FFFF, "Type {00FF00}/yes {0091FF}or {FF0000}/no {0091FF}to vote");
            SetPVarInt(playerid,"CMDVOTE",GetTickCount()+600000);
            SetTimerEx("CancelVote",30000, 0, "%i", playerid);
            OnVote = 1;
            Voted[playerid] = 1;
         }
         else
         {
            return 1;
         }
         return 1;
      }
         if(strcmp("/yes", cmdtext, true, 10) ==0)
      {
      new str[128];
      if(OnVote == 1)
      {
         if(Voted[playerid] != 0) return SendClientMessage(playerid, 0xFF0000FF, "You have already voted, You can't vote again!");
         Voted[playerid] = 1;
		 Voting[VoteY]++;
		 format(str, sizeof(str), "Vote: %s - {00FF00}Yes: %d {FF0000}No: %d", Voting[Vote], Voting[VoteY], Voting[VoteN]);
		 SendClientMessage(playerid, 0x0091FFFF, str);
		 return 1;
      }
         else return SendClientMessage(playerid, 0xFF0000FF, "There is no vote currently");
      }
      if(strcmp("/no", cmdtext, true, 10) ==0)
         {
         new str[128];
         if(OnVote == 1)
         {
            if(Voted[playerid] != 0) return SendClientMessage(playerid, 0xFF0000FF, "You have already voted, You can't vote again!");
            Voted[playerid] = 1;
            Voting[VoteN]++;
            format(str, sizeof(str), "Vote: %s - {00FF00}Yes: %d {FF0000}No: %d", Voting[Vote], Voting[VoteY], Voting[VoteN]);
            SendClientMessage(playerid, 0x0091FFFF, str);
            return 1;
         }
         else return SendClientMessage(playerid, 0xFF0000FF, "There is no vote currently");
      }
      if(strcmp("/cancelvote", cmdtext, true, 10) ==0)
      {
         new str[128], res[50];
         if(!IsPlayerAdmin(playerid)) return SendClientMessage(playerid, 0xFF0000FF, "You're not allowed to use this command");
         if(sscanf(cmdtext, "S()[50]", res)) return SendClientMessage(playerid, 0xFF0000FF, "Cancel vote: /cvote <Reason>");
         if(OnVote == 0) return SendClientMessage(playerid, 0xFF0000FF, "There is no vote currently");

         if(!isnull(res))
         format(str, sizeof(str), "Administrator %s has canceled the vote: %s", GetSname(playerid), res);
         else format(str, sizeof(str), "Administrator %s has canceled the vote", GetSname(playerid));
         SendClientMessageToAll(0xFF0000FF, str);
         OnVote = 0;
         foreach(new i : Player) Voted[i] = -1;
         Voting[VoteY] = 0;
         Voting[VoteN] = 0;
         return 1;
      }
      if(strcmp("/votes", cmdtext, true, 10) ==0)
      {
         new Players = 0;
         new string[500], str[128];
         if(!IsPlayerAdmin(playerid)) return SendClientMessage(playerid, 0xFF0000FF, "You're not allowed to use this command");
         new vote_res[][] = {"No", "Yes"};
         string = "{FFFFFF}";

         foreach(new i : Player)
         {
            if (Voted[i] != -1)
            {
               format(str, 128, "{FFFFFF}%s - {00FF00}%s\n", GetSname(i), vote_res[Voted[i]]);
               strcat(string, str, sizeof(string));
               Players++;
            }
         }
         if(Players == 0)
         ShowPlayerDialog(playerid, 135,DIALOG_STYLE_MSGBOX,"Note","{FF0000}No one has voted" ,"Close","");
         if(OnVote == 0)
         ShowPlayerDialog(playerid, 136,DIALOG_STYLE_MSGBOX,"Note","{FF0000}There is no vote currently" ,"Close","");
         else ShowPlayerDialog(playerid,165,DIALOG_STYLE_LIST,"Players Votes",string,"OK","");
         return 1;
      }
      else
      {
         SendClientMessage(playerid, Hellrot, cmdnichtverfügbar);
      return 1;
      }
    }
}

forward CancelVote(playerid);
public CancelVote(playerid)
{
	if(OnVote == 0) return 0;
	new str[128], str2[128];
	foreach(new i : Player) Voted[i] = -1;
	format(str, sizeof(str), "Vote: {00FF00}%s {0091FF}is over!", Voting[Vote]);
	format(str2, sizeof(str2), "{00FF00}Yes: %d {FF0000}No: %d", Voting[VoteY], Voting[VoteN]);
	SendClientMessageToAll(0x0091FFFF, str);
	SendClientMessageToAll(0x0091FFFF, str2);
	OnVote = 0;
	Voting[VoteY] = 0;
	Voting[VoteN] = 0;
    Voted[playerid] = 0;
	return 1;
}

public OnPlayerText(playerid, text[])
{
	 if(strlen(text) > 9980) return 0;
	 new to_others[MAX_CHATBUBBLE_LENGTH+51];
	 new to_around[MAX_CHATBUBBLE_LENGTH+51];
	 format(to_around,MAX_CHATBUBBLE_LENGTH+50,"%s",text);
	 format(to_others,MAX_CHATBUBBLE_LENGTH+50,"%s: %s", GetSname(playerid), text);
     SetPlayerChatBubble(playerid, to_around, Weis, 35.0, 500*strlen(text)+5000);
     SendClientMessageToAll(Weis, to_others);
     return 0; // can't do normal chat with this loaded
}

stock ProcessActionText(playerid, message[], actiontype)
{
    new ActionText[256+1];
    new ActionBubble[MAX_CHATBUBBLE_LENGTH+1];
    new PlayerName[MAX_PLAYER_NAME+1];

    GetPlayerName(playerid, PlayerName, sizeof(PlayerName));

	if(actiontype == ACTION_DO) {
		format(ActionText, 256, "%s %s", PlayerName, message);
		format(ActionBubble, MAX_CHATBUBBLE_LENGTH, "%s %s", PlayerName, message);
	} else {
	    format(ActionText, 256, "%s  %s", PlayerName, message);
		format(ActionBubble, MAX_CHATBUBBLE_LENGTH, "%s %s", PlayerName, message);
	}

    LocalMessage(ACTION_DISTANCE, playerid, 0xFFFFFFFF, ActionText);
   	SetPlayerChatBubble(playerid, ActionBubble, 0xFFFFFFFF, ACTION_DISTANCE, 10000);
}

stock ProcessWhisper(playerid, toplayerid, message[])
{
	new PlayerName[MAX_PLAYER_NAME+1];
	new ToPlayerName[MAX_PLAYER_NAME+1];
	new PmMessage[256+1];
	GetPlayerName(playerid,PlayerName,sizeof(PlayerName));
	GetPlayerName(toplayerid,ToPlayerName,sizeof(ToPlayerName));
    if(playerid == toplayerid)
    {
	    format(PmMessage, sizeof(PmMessage), "You to yourself: %s", message);
	    PlayerMessage(playerid, 0x00FF00FF, PmMessage);
	    format(PmMessage, sizeof(PmMessage), "From you: %s", message);
	    PlayerMessage(toplayerid, Gelb, PmMessage);
	    return 1;
    }
	format(PmMessage, sizeof(PmMessage), "You to %s (%d): %s", ToPlayerName, toplayerid, message);
	PlayerMessage(playerid, 0x00FF00FF, PmMessage);
	format(PmMessage, sizeof(PmMessage), "From %s (%d): %s", PlayerName, playerid, message);
	PlayerMessage(toplayerid, Gelb, PmMessage);
	PlayerPlaySound(toplayerid, 1056, 0.0, 0.0, 0.0);
	return 1;
}

stock ProcessChatCommands(playerid, cmdtext[])
{
    new cmd[256+1];
	new message[256+1];
	new	tmp[256+1];
	new	idx;

	cmd = strtok(cmdtext, idx);

    // Action commands
	if(!strcmp("/me", cmd, true))
	{
  	    message = strrest(cmdtext,idx);
  	    if(!strlen(message)) {
			SendClientMessage(playerid,0xFF0000FF, "/me [message]");
			return 1;
		}
		ProcessActionText(playerid, message, ACTION_DO);
		return 1;
	}
	if(!strcmp("/w", cmd, true) || !strcmp("/message", cmd, true) || !strcmp("/pm", cmd, true))
	{
		tmp = strtok(cmdtext,idx);

		if(!strlen(tmp)) {
			SendClientMessage(playerid, Hellrot, "/pm  <playerid/Name>  <message>");
			return 1;
		}

		new toplayerid = ReturnUser(tmp);

	    if(toplayerid == RETURN_USER_MULTIPLE) {
			SendClientMessage(playerid,Hellrot, "Multiple matches found for that [name]. Please narrow the search.");
			return 1;
		}
		if(toplayerid == RETURN_USER_FAILURE || !IsPlayerConnected(toplayerid)) {
		    SendClientMessage(playerid,0xFF0000FF, "This player isn't connected right now.");
			return 1;
		}

		message = strrest(cmdtext,idx);

		if(!strlen(message)) {
			SendClientMessage(playerid,0xFF0000FF, "/pm  playerid/Name  message");
			return 1;
		}

		if(IsPlayerConnected(toplayerid)) {
		     ProcessWhisper(playerid, toplayerid, message);
		}
		return 1;
	}


	return 0;
}

forward EnterTownHall(playerid);
public EnterTownHall(playerid)
{
SetPVarString(playerid, "Interior", "townhall");
return 1;
}

stock IsPlayerDriver(playerid)
{
   return (IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER);
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////Dialoge und Co////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
public OnDialogResponse(playerid,dialogid,response,listitem,inputtext[])
{
new vID=GetPlayerVehicleID(playerid),
	 tmp_engine,
	 tmp_lights,
	 tmp_alarm,
	 tmp_doors,
	 tmp_hood,
     tmp_trunk,
	 tmp_objective,
	 tmp_driverdoor,
	 tmp_passengerdoor,
	 tmp_backrightdoor,
	 tmp_backleftdoor,
	 tmp_driverwindow,
	 tmp_passengerwindow,
	 tmp_backrightwindow,
	 tmp_backleftwindow;
	 
	 if (dialogid == LOGINDIALOG)
	 {
		  if (response == 0)
		  {
			   SendClientMessage(playerid,0xFF0000FF,"You have exited the login.");
			   SetTimerEx("DelayedKick", 50, false, "i", playerid);
			   return 1;
		  }
		  if (response == 1)
		  {
			   if (!strlen(inputtext))
			   {
					SendClientMessage(playerid,0xFF0000FF,"Enter your password to login");
					ShowPlayerDialog(playerid,LOGINDIALOG,DIALOG_STYLE_INPUT,"Login","Type your password to enter the server","Okay","Exit Server");
			   }
			   else
	           {
			         Login(playerid,inputtext);
               }
			   return 1;
		  }
     }
	 if (dialogid == REGISTERDIALOG)
	 {
		  if (response == 0)
		  {
			   SendClientMessage(playerid,0xFF0000FF,"You have canceled register. Rejoin if you want to try again.");
			   SetTimerEx("DelayedKick", 10, false, "i", playerid);
			   return 1;
		  }
		  if (response == 1)
		  {
			   if (!strlen(inputtext))
			   {
					SendClientMessage(playerid,0xFF0000FF,"Enter a password to register");
					ShowPlayerDialog(playerid,REGISTERDIALOG,DIALOG_STYLE_INPUT,"Register for Simon City","Please enter a password to enter the Server","Okay","Exit server");
			   }
			   else
	           {
			         Register(playerid,inputtext);
               }
			   return 1;
		  }
		  return 1;
	 }
	 if (dialogid == AUTOD)
	 {
		  if (response == 0)
		  {
			   return 1;
		  }
		  if (response == 1)
		    {
		    if (listitem == 0)
		    {
			   if(GetPVarInt(playerid, "TachoHide") == 1)
			   {
	 		      ShowPlayerDialog(playerid, AUTOM, DIALOG_STYLE_LIST, "Vehicle Menu","Lights\nEngine\nLock Car\nSwitch Vehicle Odometer \nEnable Speedometer\nClose everything\nOpen / Close hood\nOpen / Close trunk\nOpen / Close Driver's door\nOpen / Close Passenger's Door\nOpen / Close Left Door\nOpen / Close Right Door","Select","Close");
			   }
			   else
			   {
	 		      ShowPlayerDialog(playerid, AUTOM, DIALOG_STYLE_LIST, "Vehicle Menu","Lights\nEngine\nLock Car\nSwitch Vehicle Odometer \nDisable Speedometer\nClose everything\nOpen / Close hood\nOpen / Close trunk\nOpen / Close Driver's door\nOpen / Close Passenger's Door\nOpen / Close Left Door\nOpen / Close Right Door","Select","Close");
			   }
		    }
		    else if (listitem == 1)
		    {
                 //Inventory
		    }
	      }
     }
     if (dialogid == AUTOM)
	 {
		  if (response == 0)
		  {
			   return 1;
		  }
		  if (response == 1)
		  {
		       GetVehicleParamsEx(vID,tmp_engine, tmp_lights, tmp_alarm, tmp_doors, tmp_hood, tmp_trunk, tmp_objective);
		       GetVehicleParamsCarDoors(vID, tmp_driverdoor, tmp_passengerdoor, tmp_backleftdoor, tmp_backrightdoor);
		       GetVehicleParamsCarWindows(vID, tmp_driverwindow, tmp_passengerwindow, tmp_backleftwindow, tmp_backrightwindow);
			   if (listitem == 0)
			   {
				if (tmp_lights == 0)
				{
					tmp_lights = 1;
			        SendInfoText(playerid, "Lights: On");
				}
				else if (tmp_lights == 1)
				{
					tmp_lights = 0;
			        SendInfoText(playerid, "Lights: Off");
				}
			   }
			   if (listitem == 1)
			   {
				if (tmp_engine == 1)
				{
					tmp_engine = 0;
			        SendInfoText(playerid, "Engine: Off");
				}
				else if (tmp_engine == 0)
				{
					tmp_engine = 1;
			        SendInfoText(playerid, "Engine: On");
				}
			   }
			   if (listitem == 2)
			   {
			      CallRemoteFunction("CarLockUnlock", "%i,%i", playerid, vID);
			   }
			   if (listitem == 3)
			   {
			      CallRemoteFunction("SwitchVOdometer", "%i,%i", playerid, GetPlayerVehicleID(playerid));
			   }
			   if (listitem == 4)
			   {
	                if(GetPVarInt(playerid, "TachoHide") == 1)
	                {
			           CallRemoteFunction("Speedometer_Show", "i, i", playerid, 0);
			           SendInfoText(playerid, "Speedometer Enabled");
			           return 1;
	                }
	                else
	                {
			           CallRemoteFunction("Speedometer_Disable", "i", playerid);
			           SendInfoText(playerid, "Speedometer Disabled");
	                }
	                
			   }
			   if (listitem == 5)
			   {
			       tmp_hood = 0;
				   tmp_trunk = 0;
				   tmp_driverdoor = 0;
				   tmp_passengerdoor = 0;
				   tmp_backleftdoor = 0;
				   tmp_backrightdoor = 0;
				   SendInfoText(playerid, "Everything closed");
				   
				   new string[30];
				   format(string, sizeof string, "Hood state:%i", tmp_hood);
				   DebugMessage(playerid, string);
				   format(string, sizeof string, "Trunk state:%i", tmp_trunk);
				   DebugMessage(playerid, string);
				   format(string, sizeof string, "Driverdoor state:%i", tmp_driverdoor);
				   DebugMessage(playerid, string);
				   format(string, sizeof string, "Passengerdoor state:%i", tmp_passengerdoor);
				   DebugMessage(playerid, string);
   			   }
			   if (listitem == 6)
			   {
				   new string[20];
				   format(string, sizeof string, "Hood state:%i", tmp_hood);
				   DebugMessage(playerid, string);
				if (tmp_hood == 1)
				{
					tmp_hood = 0;
			        SendInfoText(playerid, "Hood: Closed");
				}
				else
				{
					tmp_hood = 1;
			        SendInfoText(playerid, "Hood: Opened");
				}
			   }
			   if (listitem == 7)
			   {
				if (tmp_trunk == 1)
				{
					tmp_trunk = 0;
			        SendInfoText(playerid, "Trunk: Closed");
				}
				else
				{
					tmp_trunk = 1;
			        SendInfoText(playerid, "Trunk: Opened");
				}
			   }
			   if (listitem == 8)
			   {
				   new string[20];
				   format(string, sizeof string, "Tür state:%i", tmp_driverdoor);
				   DebugMessage(playerid, string);
				   
				 if (tmp_driverdoor == 1)
				 {
			        tmp_driverdoor = 0;
			        SendInfoText(playerid, "Driver Door: Closed");
				 }
				 else
				 {
			        tmp_driverdoor = 1;
			        SendInfoText(playerid, "Driver Door: Opened");
				 }
				   format(string, sizeof string, "Tür state:%i", tmp_driverdoor);
				   DebugMessage(playerid, string);
			   }
			   if (listitem == 9)
			   {
				 if (tmp_passengerdoor == 1)
				 {
			        tmp_passengerdoor = 0;
			        SendInfoText(playerid, "Passenger Door: Closed");
				 }
				 else
				 {
			        tmp_passengerdoor = 1;
			        SendInfoText(playerid, "Passenger Door: Opened");
				 }
			   }
			   if (listitem == 10)
			   {
				 if (tmp_backleftdoor == 1)
				 {
			        SendInfoText(playerid, "Left Door: Closed");
					SetVehicleParamsCarDoors(vID, tmp_driverdoor, tmp_passengerdoor, 0, tmp_backrightdoor);
				 }
				 else
				 {
			        SendInfoText(playerid, "Left Door: Opened");
					SetVehicleParamsCarDoors(vID, tmp_driverdoor, tmp_passengerdoor, 1, tmp_backrightdoor);
				 }
			   }
			   if (listitem == 11)
			   {
				 if (tmp_backrightdoor == 1)
				 {
			        SendInfoText(playerid, "Right Door: Closed");
					SetVehicleParamsCarDoors(vID, tmp_driverdoor, tmp_passengerdoor, tmp_backleftdoor, 0);
				 }
				 else
				 {
			        SendInfoText(playerid, "Right Door: Opened");
					SetVehicleParamsCarDoors(vID, tmp_driverdoor, tmp_passengerdoor, tmp_backleftdoor, 1);
				 }
			   }
		  }
		  SetVehicleParamsEx(vID, tmp_engine, tmp_lights, tmp_alarm, tmp_doors, tmp_hood, tmp_trunk, tmp_objective);
		  SetVehicleParamsCarWindows(vID, tmp_driverwindow, tmp_passengerwindow, tmp_backleftwindow, tmp_backrightwindow);
		  SetVehicleParamsCarDoors(vID,tmp_driverdoor, tmp_passengerdoor, tmp_backleftdoor, tmp_backrightdoor);
	 }
	 if (dialogid == PLANED)
	 {
		  if (response)
		    {
		    if (listitem == 0)
		    {
	 		   ShowPlayerDialog(playerid, PLANEM, DIALOG_STYLE_LIST, "Vehicle Menu","Engine(s) On\nEngine(s) Off\nEnable Gauges\nDisable Gauges \nalarm\ndoors\nhood\ntrunk\nobjective","Select","Close");
		    }
		    else if (listitem == 1)
		    {
		 	   //Inventory
		    }
	      }
		  else
		  {
			   return 1;
		  }
	 }
	 if (dialogid == PLANEM)
	 {
		GetVehicleParamsEx(vID,tmp_engine, tmp_lights, tmp_alarm, tmp_doors, tmp_hood, tmp_trunk, tmp_objective);
		GetVehicleParamsCarDoors(vID, tmp_driverdoor, tmp_passengerdoor, tmp_backleftdoor, tmp_backrightdoor);
		GetVehicleParamsCarWindows(vID, tmp_driverwindow, tmp_passengerwindow, tmp_backleftwindow, tmp_backrightwindow);
		if (listitem == 0)
        {
		 	   tmp_engine = 1;
        }
        else if (listitem == 1)
        {
		 	   tmp_engine = 0;
        }
        else if (listitem == 2)
        {
		 	   CallRemoteFunction("Gauges_Enable", "if", playerid);
        }
        else if (listitem == 3)
        {
		 	   CallRemoteFunction("Gauges_Disable", "if", playerid);
			   SendClientMessage(playerid,Hellrot,"Warning: If you disable the Cockpit Gauges, you won't make any progress at the flown distance!");
        }
        SetVehicleParamsEx(vID, tmp_engine, tmp_lights, tmp_alarm, tmp_doors, tmp_hood, tmp_trunk, tmp_objective);
        SetVehicleParamsCarWindows(vID, tmp_driverwindow, tmp_passengerwindow, tmp_backleftwindow, tmp_backrightwindow);
        SetVehicleParamsCarDoors(vID,tmp_driverdoor, tmp_passengerdoor, tmp_backleftdoor, tmp_backrightdoor);
        return 1;
	 }
	 /*if (dialogid == HDIALOG)
	 {
		if (listitem == 0)
        {
		 	   ShowPlayerDialog(playerid, HAUSOPTIONENDIALOG, DIALOG_STYLE_LIST, "House Actions", "Lock/Unlock House \nHouse Inventory \nPlace Furniture\n \nVehicles \nSell House \n...", "Okay", "Back");
        }
        else if (listitem == 1)
        {
		 	   //tmp_engine = 0;
        }
        else if (listitem == 2)
        {
		 	   //CallRemoteFunction("Gauges_Enable", "if", playerid);
        }
        else if (listitem == 3)
        {
		 	   //CallRemoteFunction("Gauges_Disable", "if", playerid);
			   //SendClientMessage(playerid,Hellrot,"Warning: If you disable the Cockpit Gauges, you won't make any progress at the driven distance!");
        }
        return 1;
	 }
	 if (dialogid == UHDIALOG)
	 {
		if (listitem == 0)
        {
		 	   // andere dialogid ShowPlayerDialog(playerid, HAUSOPTIONENDIALOG, DIALOG_STYLE_LIST, "House Actions", "{FFFF00}Send Message to House Owner\nInventory\nHelp\n...", "Okay", "Back");
        }
        else if (listitem == 1)
        {
		 	   //tmp_engine = 0;
        }
        else if (listitem == 2)
        {
		 	   //CallRemoteFunction("Gauges_Enable", "i", playerid);
        }
        else if (listitem == 3)
        {
		 	   //CallRemoteFunction("Gauges_Disable", "i", playerid);
			   //SendClientMessage(playerid,Hellrot,"Warning: If you disable the Cockpit Gauges, you won't make any progress at the driven distance!");
        }
        return 1;
	 }
	 if (dialogid == HAUSOPTIONENDIALOG)
	 {
		if (listitem == 0)
        {
		 	   CallRemoteFunction("LockHouseUnlock", "i", playerid);
        }
        else if (listitem == 1)
        {
		 	   //tmp_engine = 0;
        }
        else if (listitem == 2)
        {
		 	   //CallRemoteFunction("Gauges_Enable", "i", playerid);
        }
        else if (listitem == 3)
        {
		 	   //CallRemoteFunction("Gauges_Disable", "if", playerid);
			   //SendClientMessage(playerid,Hellrot,"Warning: If you disable the Cockpit Gauges, you won't make any progress at the driven distance!");
        }
        return 1;
	 }*/
	 if (dialogid == JOBDIALOG)
	 {
	   new string[40];
	   if(response == 1)
	   {
        if (listitem == 0)
        {
		  GetPVarString(playerid, "Job", string, sizeof string);
		  if(strcmp(string, "Pilot") == 0)
		  {
			 SendClientMessage(playerid, Hellgrün, "du bist jetz pilot");
			 ShowPlayerDialog(playerid, FIRMADIALOG, DIALOG_STYLE_LIST, "Choose the company you will be working for", "Companies lol\nWika again of course", "Okay", "Exit");
		  }
		  else
		  {
			 SendClientMessage(playerid, Hellrot, "Du wurdest von WIKAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA geript");
			 ShowPlayerDialog(playerid, JOBDIALOG, DIALOG_STYLE_LIST, "Sign for a new career", "Pilot\nCar mechanic\nWika", "Okay", "Exit");
		  }
        }
        else if (listitem == 1)
        {
		  GetPVarString(playerid, "Job", string, sizeof string);
		  if(strcmp(string, "Automechanigger") == 0)
		  {
			 SendClientMessage(playerid, Hellgrün, "du bist jetz automechanigger");
			 ShowPlayerDialog(playerid, FIRMADIALOG, DIALOG_STYLE_LIST, "Choose the company you will be working for", "Companies lol\nWika again of course", "Okay", "Exit");
		  }
		  else
		  {
			 SendClientMessage(playerid, Hellrot, "Du wurdest von WIKAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA geript");
			 ShowPlayerDialog(playerid, JOBDIALOG, DIALOG_STYLE_LIST, "Sign for a new career", "Pilot\nCar mechanic\nWika", "Okay", "Exit");
		  }
        }
        else if (listitem == 2)
        {
		  GetPVarString(playerid, "Job", string, sizeof string);
		  if(strcmp(string, "Elektriker") == 0)
		  {
			 SendClientMessage(playerid, Hellgrün, "du bist jetz elektriker");
			 ShowPlayerDialog(playerid, FIRMADIALOG, DIALOG_STYLE_LIST, "Choose the company you will be working for", "Companies lol\nWika again of course", "Okay", "Exit");
		  }
		  else
		  {
			 SendClientMessage(playerid, Hellrot, "Du wurdest von WIKAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA geript");
			 ShowPlayerDialog(playerid, JOBDIALOG, DIALOG_STYLE_LIST, "Sign for a new career", "Pilot\nCar mechanic\nWika", "Okay", "Exit");
		  }
        }
        return 1;
	   }
	   else
	   {
	    SetPVarString(playerid, "Interior", "townhall");
	    TogglePlayerSpectating(playerid, false);
	    SetPlayerPos(playerid, 1735.0989,-1660.0570,23.7187);
		SetPlayerInterior(playerid, 18);
        return 1;
	   }
	 }
	 if (dialogid == FIRMADIALOG)
	 {
	   if(response == 1)
	   {
        if (listitem == 0)
        {
	    SetPVarString(playerid, "Interior", "townhall");
	    TogglePlayerSpectating(playerid, false);
	    SetPlayerPos(playerid, 1735.0989,-1660.0570,23.7187);
		SetPlayerInterior(playerid, 18);
        return 1;
        }
        else if (listitem == 1)
        {
	    SetPVarString(playerid, "Interior", "townhall");
	    TogglePlayerSpectating(playerid, false);
	    SetPlayerPos(playerid, 1735.0989,-1660.0570,23.7187);
		SetPlayerInterior(playerid, 18);
        return 1;
        }
	   }
	   else
	   {
	    SetPVarString(playerid, "Interior", "townhall");
	    TogglePlayerSpectating(playerid, false);
	    SetPlayerPos(playerid, 1735.0989,-1660.0570,23.7187);
		SetPlayerInterior(playerid, 18);
        return 1;
	   }
	 }
	 if (dialogid == AUTOANNAHMEDIALOG)
	 {
	   /*if(GetPVarInt(playerid, "Dialogid") == 1)
	   {
	     if(response == 1)
	     {
          if (listitem == 0)
          {
	        //ShowPlayerDialog(playerid, AUTOANNAHMEDIALOG, DIALOG_STYLE_LIST, "Which Car do you want to  buy?", "Infernus\nTornado\nAlexia", "Okay", "Back");
	        //hier
	        //PlayerTextDrawSetString(playerid, TuningLeave_[playerid], "Exit");
	        PlayerTextDrawShow(playerid, NextModshopItem[playerid]);//hier
	        PlayerTextDrawShow(playerid, LastModshopItem[playerid]);
	        PlayerTextDrawShow(playerid, TuningBackground[playerid]);
	        PlayerTextDrawShow(playerid, TuningLeave[playerid]);
	        PlayerTextDrawShow(playerid, TuningLeave_[playerid]);
	        PlayerTextDrawShow(playerid, ModName[playerid]);
	        PlayerTextDrawShow(playerid, ModName_[playerid]);
	        SelectTextDraw(playerid, TextdrawFarbe);
	        //PlayerTextDrawShow(playerid, TuningObjectBackground[playerid]);
	        //PlayerTextDrawShow(playerid, ModDone[playerid]);
	        //PlayerTextDrawShow(playerid, ModDone_[playerid]);
	        InterpolateCameraPos(playerid, 203.475402, 29.622402, 2.754704, 203.475402, 29.622402, 2.754704, 100);
	        InterpolateCameraLookAt(playerid, 204.796295, 34.193210, 1.217511, 204.796295, 34.193210, 1.217511, 100);
	        SetPVarInt(playerid, "Dialogid", 2);
	        SetPVarInt(playerid, "BuyThatCar", 1);//je nach autohaus
            return 1;
          }
          else if (listitem == 1)
          {
	        //ShowPlayerDialog(playerid, AUTOANNAHMEDIALOG, DIALOG_STYLE_LIST, "Whats wrong with your car?", "I don't know \nCheck Engine light is on \nIt won't start \nI want to modify it", "Yep", "Back");
            CallRemoteFunction("Car_Selector_Dialog", "i, i", playerid);
	        SetPVarInt(playerid, "Dialogid", 3);
            return 1;
          }
	     }
	     else
	     {
	        ShowPlayerDialog(playerid, AUTOANNAHMEDIALOG, DIALOG_STYLE_LIST, "Bye :)", "Have a nice day!", "Exit", "");
	        DeletePVar(playerid, "Dialogid");
            return 1;
	     }
	   }*/
	   if(GetPVarInt(playerid, "Dialogid") == 3)
	   {
	     if(response == 1)
	     {
          if (listitem == 0)
          {
	        ShowPlayerDialog(playerid, AUTOANNAHMEDIALOG, DIALOG_STYLE_INPUT, "We repair your car!", "Whats wrong with it? Please describe it in a few words.", "Okay", "Back");
	        SetPVarInt(playerid, "Dialogid", 5);
            return 1;
          }
          else if (listitem == 1)
          {
	        ShowPlayerDialog(playerid, AUTOANNAHMEDIALOG, DIALOG_STYLE_INPUT, "Enter the ID of your car with check engine light.", "Select your car. If you have more cars with the same name and don't know the ID, click Okay and enter your car.", "Okay", "Back");
	        SetPVarInt(playerid, "Dialogid", 6);
            return 1;
          }
          else if (listitem == 2)
          {
	        ShowPlayerDialog(playerid, AUTOANNAHMEDIALOG, DIALOG_STYLE_INPUT, "Enter the ID of your not starting car.", "Select your car. If you have more cars with the same name and don't know the ID, click Okay and enter your car.", "Okay", "Back");
	        SetPVarInt(playerid, "Dialogid", 6);
            return 1;
          }
          else if (listitem == 3)
          {
	        ShowPlayerDialog(playerid, AUTOANNAHMEDIALOG, DIALOG_STYLE_INPUT, "Enter the ID of your car.", "Select your car. If you have more cars with the same name and don't know the ID, click Okay and enter your car.", "Okay", "Back");
	        SetPVarInt(playerid, "Dialogid", 6);
	        return 1;
          }
	     }
	     else
	     {
	        ShowPlayerDialog(playerid, AUTOANNAHMEDIALOG, DIALOG_STYLE_LIST, "What can I do for you?", "I want to buy a car\nI need a mechanic service for my car", "Okay", "Exit");
	        SetPVarInt(playerid, "Dialogid", 1);
            return 1;
	     }
	   }
	   if(GetPVarInt(playerid, "Dialogid") == 2)
	   {
	     if(response == 1)
	     {
          if (listitem == 0)
          {
	        ShowPlayerDialog(playerid, AUTOANNAHMEDIALOG, DIALOG_STYLE_TABLIST, "Infernus", "Price:\t5000$ \nHorsepower:\t10 \nMax Speed:\t20 km/h", "Buy", "Back");
	        SetPVarInt(playerid, "Dialogid", 4);
            return 1;
          }
          else if (listitem == 1)
          {
	        ShowPlayerDialog(playerid, AUTOANNAHMEDIALOG, DIALOG_STYLE_TABLIST, "Tornado", "Price:\t5000$ \nHorsepower:\t10 \nMax Speed:\t20 km/h", "Buy", "Back");
	        SetPVarInt(playerid, "Dialogid", 4);
            return 1;
          }
          else if (listitem == 2)
          {
	        ShowPlayerDialog(playerid, AUTOANNAHMEDIALOG, DIALOG_STYLE_TABLIST, "Alexia", "Price:\t554454536456$ \nHorsepower:\t14560 \nMax Speed:\t24530 km/h", "Buy", "Back");
	        SetPVarInt(playerid, "Dialogid", 4);
            return 1;
          }
	     }
	     else
	     {
	        ShowPlayerDialog(playerid, AUTOANNAHMEDIALOG, DIALOG_STYLE_LIST, "What can I do for you?", "I want to buy a car\nI need a mechanic service for my car", "Okay", "Exit");
	        SetPVarInt(playerid, "Dialogid", 1);
            return 1;
	     }
	   }
	   if(GetPVarInt(playerid, "Dialogid") == 4)
	   {
	     if(response == 1)
	     {
          return 0;
          //if (listitem <= 0)
          //SendClientMessage(playerid, Weis, "Auto gekauft");
	     }
	     else
	     {
			new dealership;
			if(IsPlayerInRangeOfPoint(playerid, 30, -1984.808,304.171,34.776)) {dealership = 1;}
			if(IsPlayerInRangeOfPoint(playerid, 30, -1643.514,1214.501,7.179)) {dealership = 2;}
			if(IsPlayerInRangeOfPoint(playerid, 30, 561.424,-1266.943,17.242)) {dealership = 3;}
			if(IsPlayerInRangeOfPoint(playerid, 30, 2157.549,1403.705,10.430)) {dealership = 4;}
			if(IsPlayerInRangeOfPoint(playerid, 30, 204.8887,21.3773,1.2617)) {dealership = 5;}
		    ShowPlayerDialog(playerid, AUTOANNAHMEDIALOG, DIALOG_STYLE_LIST, "Which Car do you want to  buy?", "GetDealershipVehicleNames(dealership)", "Okay", "Back");
	        SetPVarInt(playerid, "Dialogid", 2);
            return 1;
	     }
	   }
	   if(GetPVarInt(playerid, "Dialogid") == 5)
	   {
	     if(response == 1)
	     {
	        ShowPlayerDialog(playerid, AUTOANNAHMEDIALOG, DIALOG_STYLE_INPUT, "Enter the ID of your car.", "Select your car. If you have more cars with the same name and don't know the ID, click Okay and enter your car.", "Okay", "Back");
	        SetPVarInt(playerid, "Dialogid", 6);
	     }
	     else
	     {
            return 1;
	     }
	   }
	 }
	 return 0;
}

stock Register(playerid,key[])
{
	 new tmp[36];
     GetPlayerName(playerid,Sname,sizeof(Sname));
	 format(Spieler,sizeof(Spieler),"/Spieler/%s.txt",Sname);
	 dini_Create(Spieler);
	 dini_Set(Spieler,"Passwort",key);
	 dini_Set(Spieler,"Bild","Nichts");
	 dini_IntSet(Spieler,"Kills",0);
	 dini_IntSet(Spieler,"Tode",0);
	 dini_IntSet(Spieler,"Führerschein",0);
	 dini_IntSet(Spieler,"Flugschein",0);
	 dini_IntSet(Spieler,"Bootsschein",0);
	 dini_Set(Spieler,"Farbe","Nichts");
	 dini_Set(Spieler,"Replay","Aus");
	 dini_Set(Spieler,"SpielerStatus","Online");
	 dini_Set(Spieler,"SpielerName",Sname);
	 dini_Set(Spieler,"Klingelton", "20600");
	 dini_Set(Spieler,"Nachrichtenton", "1058");
	 dini_Set(Spieler,"HandyTon", "Ein");
	 dini_IntSet(Spieler, "CatchTheBallDifficulty", 1);
	 format(tmp, sizeof tmp, "-1 -1 -1 -1 -1 -1 -1 -1 -1");
	 dini_Set(Spieler,"CompAutoSpiel",tmp);
	 dini_IntSet(Spieler,"CompAutoSpielGeld",500);
	 dini_IntSet(Spieler,"CompAutoSpielPunkte",0);
	 format(tmp, 9, "%05.0d", MobilePlayer[playerid][number]);
	 GetPlayerName(playerid, Sname, sizeof Sname);
	 format(Spieler,sizeof(Spieler),"/Spieler/%s.txt",Sname);
	 dini_Set(Spieler, "Telefonnummer", tmp);
	 SendClientMessage(playerid,0x00FF00FF,"You have successfully registered. Have fun on my Server.");
	 TogglePlayerSpectating(playerid, false);
	 SpawnPlayer(playerid);
	 return 1;
}

stock deleteme(playerid)
{
		  SendClientMessage(playerid,0x00FF00FF,"You have logged in. You can continue playing!");
          GeldLaden(playerid);
		  dini_Set(Spieler,"SpielerStatus","Online");
		  TogglePlayerSpectating(playerid, false);
		  SpawnPlayer(playerid);
		  DeletePVar(playerid,"Loginkick");
		  KillTimer(LoginKick);
          new hour, minute, second, stringi[32];
          gettime(hour, minute, second);
          format(stringi, sizeof(stringi), "The time is %02d:%02d:%02d.", hour, minute, second); // will output something like 09:45:02
          SendClientMessage(playerid, -1, stringi);
          StatsCheck(playerid);
          return 1;
}

stock Login(playerid,key[])
{
     GetPlayerName(playerid,Sname,sizeof(Sname));
	 format (Spieler,sizeof(Spieler),"/Spieler/%s.txt",Sname);
	 if(!strcmp(key,dini_Get(Spieler,"Passwort"),false, cellmax))
	 {
		  SendClientMessage(playerid,0x00FF00FF,"You have logged in. You can continue playing!");
          GeldLaden(playerid);
		  dini_Set(Spieler,"SpielerStatus","Online");
		  TogglePlayerSpectating(playerid, false);
		  SpawnPlayer(playerid);
		  DeletePVar(playerid,"Loginkick");
		  KillTimer(LoginKick);
          new hour, minute, second, stringi[32];
          gettime(hour, minute, second);
          format(stringi, sizeof(stringi), "The time is %02d:%02d:%02d.", hour, minute, second); // will output something like 09:45:02
          SendClientMessage(playerid, -1, stringi);
          StatsCheck(playerid);
	 }
     else
	 {
	      SetTimerEx("LoginKickk", 10, false, "i", playerid);
	 }
	 return 1;
}

forward LoginKickk(playerid);
public LoginKickk(playerid)
{
   if(GetPVarInt(playerid, "Loginkick") == 0)
   {
          SendClientMessage(playerid,0xFF0000FF,"You have entered the wrong password.");
          ShowPlayerDialog(playerid,LOGINDIALOG,DIALOG_STYLE_INPUT,"Login","Type your password to enter the server","Okay","Exit Server");
          SetPVarInt(playerid, "Loginkick", 1);
          return 1;
   }
   if(GetPVarInt(playerid, "Loginkick") == 1)
   {
          SendClientMessage(playerid,0xFF0000FF,"You have entered the wrong password. You have one more try.");
          ShowPlayerDialog(playerid,LOGINDIALOG,DIALOG_STYLE_INPUT,"Login","Type your password to enter the server","Okay","Exit Server");
          SetPVarInt(playerid, "Loginkick", 2);
          return 1;
   }
   if(GetPVarInt(playerid, "Loginkick") == 2)
   {
          SendClientMessage(playerid,0xFF0000FF,"You have entered the wrong password. If you forgot your password, contact me at Discord: ?imon#3318");
          SetTimerEx("DelayedKick", 10, false, "i", playerid);
          DeletePVar(playerid,"Loginkick");
   }
   return 1;
}

forward ServerRestart(playerid);
public ServerRestart(playerid)
{
   SendRconCommand("gmx");
   return 1;
}
forward DelayedKick(playerid);
public DelayedKick(playerid)
{
    Kick(playerid);
    return 1;
}

