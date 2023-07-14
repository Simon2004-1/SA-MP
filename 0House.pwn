#define FILTERSCRIPT
#if defined FILTERSCRIPT
#include <a_samp>
#include <streamer>
#include <zcmd>
#include <Dini>
#include <foreach>
#include <0SimonsInclude>
#pragma tabsize 0

//------------------------------------------------------------------------------

#define MAX_HOUSES 2500

//------------------------------------------------------------------------------

#define INFODIALOG 1
#define DIALOG_HOPTIONS 1500
#define DIALOG_PRICE 1501
#define DIALOG_PRICES 15010
#define DIALOG_INTERIOR 1502
#define DIALOG_SAVE 1503
#define DIALOG_REMOVEID 1504
#define DIALOG_GARAGE 1505
#define DIALOG_GARAGEE 1506
#define DIALOG_GARAGEEE 1507
#define DIALOG_GARAGEA 1508
#define DIALOG_GARAGEAA 1509
#define DIALOG_HOUSEOPT 1510
#define HOUSEMESSAGEDIALOG 1511
#define HOUSEOPTIONENDIALOG 1512
#define HDIALOG 8
#define UHDIALOG 9

#define STREAMDISTANCE_HOUSEMAPICONID 150

//------------------------------------------------------------------------------

enum hInfo
{
	hPrice,
	hMapIconID,
	hInterior,
	hLocked,
	hOwned,
	hPick,
	hWorld,
	hOwner[MAX_PLAYER_NAME],
	Text3D:hLabel,
	Float:hX,
	Float:hY,
	Float:hZ,
	Float:G1X,
	Float:G1Y,
	Float:G1Z,
	Float:G2X,
	Float:G2Y,
	Float:G2Z,
	Float:G3X,
	Float:G3Y,
	Float:G3Z,
	Float:GF1,
	Float:GF2,
	Float:GF3
}

//------------------------------------------------------------------------------

new HouseInfo[MAX_HOUSES][hInfo];
new houseid = 0, InHouse[MAX_PLAYERS][MAX_HOUSES];

stock DoesIconIDExist(mapiconid)
{
   if(IsValidDynamicMapIcon(mapiconid))
   {
      return 1;
   }
   return 0;
}

//------------------------------------------------------------------------------

CMD:house(playerid, params[])
{
	ShowPlayerDialog(playerid, DIALOG_HOPTIONS, DIALOG_STYLE_MSGBOX, "House options", "{FFFFFF}Please, select your option.", "Create", "Remove");
	SetPVarInt(playerid, "Haus", 1);
	SetPVarInt(playerid, "Garage", -1);
	return 1;
}

//------------------------------------------------------------------------------

CMD:iconids(playerid, params[])
{
	for(new i = 0; i < 20; i++)
	{
		  new string[40];
		  if(IsValidDynamicMapIcon(i))
	      {
		     format(string, sizeof string, "Iconid %i existiert", i);
	      }
	      else
	      {
		     format(string, sizeof string, "Iconid %i existiert {FF0000}NICHT", i);
	      }
		  DebugMessage(playerid, string);
	}
	return 1;
}

CMD:iconid(playerid, params[])
{
		  new string[40];
		  if(DoesIconIDExist(strval(params)))
	      {
		     format(string, sizeof string, "Iconid %i existiert", strval(params));
	      }
	      else
	      {
		     format(string, sizeof string, "Iconid %i existiert {FF0000}NICHT", strval(params));
	      }
		  DebugMessage(playerid, string);
	return 1;
}

//------------------------------------------------------------------------------

CMD:getid(playerid, params[])
{
    new i;
    new stringg[50];
    i = GetPVarInt(playerid, "IsPlayerInHouse");
    format(stringg, sizeof stringg, "  House ID: %i%, Interior ID: %i", i, HouseInfo[i][hInterior]);
    DebugMessage(playerid, stringg);
	return 1;
}

//------------------------------------------------------------------------------

CMD:sellhouse(playerid, params[])
{
	new name[MAX_PLAYER_NAME], Float:X, Float:Y, Float:Z, World, labelstring[144], string[144], file[50];
	World = GetPlayerVirtualWorld(playerid);
	GetPlayerPos(playerid, X, Y, Z);
	GetPlayerName(playerid, name, sizeof(name));
	for(new i = 0; i < MAX_HOUSES; i++)
	{
		if(IsPlayerInRangeOfPoint(playerid, 1.0, HouseInfo[i][hX], HouseInfo[i][hY], HouseInfo[i][hZ]))
		{
			if(HouseInfo[i][hOwned] == 0) return SendClientMessage(playerid, -1, "{FF0000}ERROR: {FFFFFF}This house isn't owned by someone.");
			if(strcmp(name, HouseInfo[i][hOwner], true)) return SendClientMessage(playerid, -1, "{FF0000}ERROR: {FFFFFF}This house isn't owned by you.");
			DestroyPickup(HouseInfo[i][hPick]);
			HouseInfo[i][hPick] = CreatePickup(1273, 1, HouseInfo[i][hX], HouseInfo[i][hY], HouseInfo[i][hZ], World);
			format(labelstring, sizeof(labelstring), "{15FF00}Price: {FFFFFF}%i\n{15FF00}Adress: {FFFFFF}%d\n{15FF00}Press {FFFFFF}~k~~SNEAK_ABOUT~ {15FF00}to buy this house.", HouseInfo[i][hPrice], i);
			Update3DTextLabelText(HouseInfo[i][hLabel], 0xFFFFFFFF, labelstring);
			HouseInfo[i][hOwned] = 0;
			HouseInfo[i][hOwner] = 0;
            HouseInfo[i][hLocked] = 0;
			format(string, sizeof(string), "You've sold your house: %d.", i);
			SendClientMessage(playerid,0x00FF00FF, string);
			format(file, sizeof(file), "Houses/%d.ini", i);
			if(fexist(file))
			{
				dini_IntSet(file, "Owned", 0);
				dini_IntSet(file, "Owner", 0);
                dini_FloatSet(file, "Locked", HouseInfo[i][hLocked]);
			}
		}
	}
	return 1;
}

//------------------------------------------------------------------------------

forward LockHouseUnlock (playerid);
public LockHouseUnlock (playerid)
{
	new name[MAX_PLAYER_NAME];
	new file[35];
	GetPlayerName(playerid, name, sizeof(name));
	for(new i = 0; i < MAX_HOUSES; i++)//hier hous id bestimmen
	{
        if(strcmp(name, HouseInfo[i][hOwner], true)) return SendClientMessage(playerid, 0xFF0000FF, "This house isn't owned by you.");
		format(file, sizeof(file), "Houses/%d.ini", i);
        {
         if(HouseInfo[i][hLocked] == 0)
          {
           HouseInfo[i][hLocked] = 1;
           dini_FloatSet(file, "Locked", HouseInfo[i][hLocked]);
           SendClientMessage(playerid,  0x00FF00FF, "You have locked your house.");
           return 1;
          }
         else if(HouseInfo[i][hLocked] == 1)
          {
           HouseInfo[i][hLocked] = 0;
           dini_FloatSet(file, "Locked", HouseInfo[i][hLocked]);
           SendClientMessage(playerid,  0x00FF00FF, "You have unlocked your house.");
           return 1;
          }
		  }
	}
	return 1;
}

public OnPlayerConnect(playerid)
{
   SetPVarInt(playerid, "IsPlayerInHouse", -1);
   return 1;
}

//------------------------------------------------------------------------------

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if(dialogid == UHDIALOG)
	{
		if(response)
		{
		   if(listitem == 0)
		   {
		      //return SendClientMessage(playerid, Weis, "Sending a message to the house owner");
		      return ShowPlayerDialog(playerid, HOUSEMESSAGEDIALOG,  DIALOG_STYLE_INPUT, "House Message","Enter your message for the house owner here:","Okay","Back");
		   }
		   if(listitem == 1)
		   {
		      return SendClientMessage(playerid, Weis, "no2");
		   }
		   if(listitem == 2)
		   {
		      return SendClientMessage(playerid, Weis, "no3");
		   }
		}
		else
		{
		   new a;
		   a = GetPVarInt(playerid, "IsPlayerInHouse");
		   if (strcmp(GetSname(playerid), HouseInfo[a][hOwner], false))return ShowPlayerDialog(playerid, UHDIALOG,  DIALOG_STYLE_LIST, "Menu","{FFFF00}Send Message to House Owner\nInventory\nHelp\n...","Select","Close");
		   return ShowPlayerDialog(playerid, HDIALOG,  DIALOG_STYLE_LIST, "Menu","{FFFF00}House Actions\nInventory\nHelp\n...","Select","Close");
		}
	}
	if(dialogid == HDIALOG)
	{
		if(response)
		{
		   if(listitem == 0)
		   {
		      return ShowPlayerDialog(playerid, HOUSEOPTIONENDIALOG, DIALOG_STYLE_LIST, "House Actions", "Lock/Unlock House \nHouse Inventory \nPlace Furniture\n \nVehicles \nSell House \n...", "Okay", "Back");//hier xenia
		   }
		   if(listitem == 1)
		   {
		      return SendClientMessage(playerid, Weis, "2");
		   }
		   if(listitem == 2)
		   {
		      return SendClientMessage(playerid, Weis, "3");
		   }
		}
		else
		{
		   new a;
		   a = GetPVarInt(playerid, "IsPlayerInHouse");
		   if (strcmp(GetSname(playerid), HouseInfo[a][hOwner], false))return ShowPlayerDialog(playerid, UHDIALOG,  DIALOG_STYLE_LIST, "Menu","{FFFF00}Send Message to House Owner\nInventory\nHelp\n...","Select","Close");
		   return ShowPlayerDialog(playerid, HDIALOG,  DIALOG_STYLE_LIST, "Menu","{FFFF00}House Actions\nInventory\nHelp\n...","Select","Close");
		}
	}
	if(dialogid == HOUSEMESSAGEDIALOG)
	{
		if(response)
		{
		   if(strlen(inputtext) <= 3)
		   {
		      return ShowPlayerDialog(playerid, HOUSEMESSAGEDIALOG,  DIALOG_STYLE_INPUT, "House Message","Enter your message for the house owner here. The Message has to contain at least a few letters!","Okay","Back");
		   }
		   new a;
		   new file[50];
		   a = GetPVarInt(playerid, "IsPlayerInHouse");
		   if(a < 0)
		   {
		      for(new i = 0; i < MAX_HOUSES; i++)
	          {
		         if(IsPlayerInRangeOfPoint(playerid, 1.5 , HouseInfo[i][hX], HouseInfo[i][hY], HouseInfo[i][hZ]))
		         {
				    a = i;
				 }
			  }
		   }
		   format(file, sizeof(file), "Houses/%d.ini", a);
		   new string[256];
		   new oldstring[256];
		   new pName[60];
		   oldstring = dini_Get(file, "MessageForOwner");
		   format(pName, sizeof pName, "From {FFFF00}%s{FFFFFF}:", GetSname(playerid));
		   strins(string, pName, 0, sizeof string);
		   format(string, sizeof string, "%s %s", string, inputtext);
		   if(strlen(oldstring) > 0)
		   {
		      format(string, sizeof string, "%s | / | / | %s", oldstring, string);
		   }
           dini_Set(file, "MessageForOwner", string);
		}
		else
		{
		   new a;
		   a = GetPVarInt(playerid, "IsPlayerInHouse");
		   if (strcmp(GetSname(playerid), HouseInfo[a][hOwner], false))return ShowPlayerDialog(playerid, UHDIALOG,  DIALOG_STYLE_LIST, "Menu","{FFFF00}Send Message to House Owner\nInventory\nHelp\n...","Select","Close");
		   return ShowPlayerDialog(playerid, HDIALOG,  DIALOG_STYLE_LIST, "Menu","{FFFF00}House Actions\nInventory\nHelp\n...","Select","Close");
		}
	}
    new Float:PX, Float:PY, Float:PZ, Float:ANG;
	if(dialogid == DIALOG_HOPTIONS)
	{
		if(response)
		{
			ShowPlayerDialog(playerid, DIALOG_PRICE, DIALOG_STYLE_INPUT, "Price", "{FFFFFF}Please, input below price of this house:", "Continue", "Back");
		}
		else
		{
			ShowPlayerDialog(playerid, DIALOG_REMOVEID, DIALOG_STYLE_INPUT, "Remove ID", "{FFFFFF}Please, input below the house ID, wich you want to remove:", "Continue", "Back");
		}
	}
	if(dialogid == DIALOG_PRICE)
	{
		if(response)
		{
            SendClientMessage(playerid, -1, "{FF0000}[HOUSE]: {FFFFFF}Price setted.");
			HouseInfo[houseid][hPrice] = strval(inputtext);//hier neue hausid?????
			new string[270];
			format(string, sizeof string, "Now go to the place where you want to have Garage 1.\nUse a Car to get better results\nUse the car HORN if in car, CROUCH if on foot if you are ready\nTipp: Exit and Enter the car so PlayerFacingAngle will get updated");
			ShowPlayerDialog(playerid, DIALOG_PRICES, DIALOG_STYLE_MSGBOX, "Garage 1.", string, "Okay", "No garage");
			return 1;
		}
		else
		{
		    ShowPlayerDialog(playerid, DIALOG_HOPTIONS, DIALOG_STYLE_MSGBOX, "House options", "{FFFFFF}Please, select your option.", "Create", "Remove");
		}
	}
	if(dialogid == DIALOG_PRICES)
	{
		if(response)
		{
			return 1;
		}
		else
		{
            SendClientMessage(playerid, -1, "{FF0000}[HOUSE]: {FFFFFF}No garage.");
			SetPVarInt(playerid, "Garage", 0);
			new string[70];
			format(string, sizeof string, "Now go to the house door \nPress the crouch key if you are there");
			ShowPlayerDialog(playerid, DIALOG_GARAGEAA, DIALOG_STYLE_MSGBOX, "House Door", string, "Okay", "No");
		}
	}
	if(dialogid == DIALOG_GARAGE)
	{
		if(response)
		{
			GetPlayerPos(playerid, PX, PY, PZ);
			HouseInfo[houseid][G1X] = PX;
			HouseInfo[houseid][G1Y] = PY;
			HouseInfo[houseid][G1Z] = PZ;
		    GetPlayerFacingAngle(playerid, ANG);
			HouseInfo[houseid][GF1] = ANG;
		    SendClientMessage(playerid, -1, "{FF0000}[HOUSE]: {FFFFFF}Garage 1 setted.");
			SetPVarInt(playerid, "Garage", 1);
			SendClientMessage(playerid, Weis, "1 Garagen 1");
			return 1;
		}
		else
		{
            SendClientMessage(playerid, -1, "{FF0000}[HOUSE]: {FFFFFF}Garagen setted.");
			new string[70];
			format(string, sizeof string, "Now go to the house door \nPress the crouch key if you are there");
			ShowPlayerDialog(playerid, DIALOG_GARAGEAA, DIALOG_STYLE_MSGBOX, "House Door", string, "Okay", "No");
			SetPVarInt(playerid, "Garage", 0);
			SendClientMessage(playerid, Weis, "3 Garagen 1");
		}
	}
	if(dialogid == DIALOG_GARAGEE)
	{
		if(response)
		{
		    //save garage 2 position
			GetPlayerPos(playerid, PX, PY, PZ);
			HouseInfo[houseid][G2X] = PX;
			HouseInfo[houseid][G2Y] = PY;
			HouseInfo[houseid][G2Z] = PZ;
		    GetPlayerFacingAngle(playerid, ANG);
			HouseInfo[houseid][GF2] = ANG;
		    SendClientMessage(playerid, -1, "{FF0000}[HOUSE]: {FFFFFF}Garage 2 setted.");
			SetPVarInt(playerid, "Garage", 2);
			SendClientMessage(playerid, Weis, "2 Garagen 2");
			return 1;
		}
		else
		{
            SendClientMessage(playerid, -1, "{FF0000}[HOUSE]: {FFFFFF}Garagen setted.");
			new string[70];
			format(string, sizeof string, "Now go to the house door \nPress the crouch key if you are there");
			ShowPlayerDialog(playerid, DIALOG_GARAGEAA, DIALOG_STYLE_MSGBOX, "House Door", string, "Okay", "No");
			SetPVarInt(playerid, "Garage", 1);
			SendClientMessage(playerid, Weis, "3 Garagen 2");
		}
	}
	if(dialogid == DIALOG_GARAGEEE)
	{
		if(response)
		{
			GetPlayerPos(playerid, PX, PY, PZ);
			HouseInfo[houseid][G3X] = PX;
			HouseInfo[houseid][G3Y] = PY;
			HouseInfo[houseid][G3Z] = PZ;
		    GetPlayerFacingAngle(playerid, ANG);
			HouseInfo[houseid][GF3] = ANG;
		    SendClientMessage(playerid, -1, "{FF0000}[HOUSE]: {FFFFFF}Garage 3 setted.");
			SetPVarInt(playerid, "Garage", 3);
			SendClientMessage(playerid, Weis, "3 Garagen 3");
			new string[50];
			format(string, sizeof string, "Now go to the house door \nPress the crouch key if you are there");
			ShowPlayerDialog(playerid, DIALOG_GARAGEAA, DIALOG_STYLE_MSGBOX, "House Door", string, "Okay", "No");
			return 1;
		}
		else
		{
            SendClientMessage(playerid, -1, "{FF0000}[HOUSE]: {FFFFFF}Garagen setted.");
			new string[70];
			format(string, sizeof string, "Now go to the house door \nPress the crouch key if you are there");
			ShowPlayerDialog(playerid, DIALOG_GARAGEAA, DIALOG_STYLE_MSGBOX, "House Door", string, "Okay", "No");
			SetPVarInt(playerid, "Garage", 2);
			SendClientMessage(playerid, Weis, "3 Garagen 3");
		}
	}
	if(dialogid == DIALOG_GARAGEAA)
	{
		if(response)
		{
			return 1;
		}
		else
		{
			ShowPlayerDialog(playerid, DIALOG_GARAGEAA, DIALOG_STYLE_MSGBOX, "GOOO", "GO TO THE FUCKING DOOR", "YES I DO", "");
		}
	}
	if(dialogid == DIALOG_GARAGEA)
	{
		if(response)
		{
		    //save garage turn position
			ShowPlayerDialog(playerid, DIALOG_INTERIOR, DIALOG_STYLE_LIST, "Interior", "Interior 1\nInterior 2\nInterior 3\nInterior 4\nInterior 5\nInterior 6 CJ\nInterior 7 Safehouse\nInterior 8 Ganghouse\nInterior 9 Madd Dogg", "Continue", "Back");
		}
		else
		{
		   return 1;
		}
	}
	if(dialogid == DIALOG_INTERIOR)
	{
  if(response)
		{
			if(listitem == 0)
			{
				SendClientMessage(playerid, -1, "{FF0000}[HOUSE]: {FFFFFF}Interior setted. {FF0000}Interior #1.");
				HouseInfo[houseid][hInterior] = 1;
			}
			if(listitem == 1)
			{
				SendClientMessage(playerid, -1, "{FF0000}[HOUSE]: {FFFFFF}Interior setted. {FF0000}Interior #2.");
				HouseInfo[houseid][hInterior] = 2;
			}
			if(listitem == 2)
			{
				SendClientMessage(playerid, -1, "{FF0000}[HOUSE]: {FFFFFF}Interior setted. {FF0000}Interior #3.");
				HouseInfo[houseid][hInterior] = 3;
			}
			if(listitem == 3)
			{
				SendClientMessage(playerid, -1, "{FF0000}[HOUSE]: {FFFFFF}Interior setted. {FF0000}Interior #4.");
				HouseInfo[houseid][hInterior] = 4;
			}
			if(listitem == 4)
			{
				SendClientMessage(playerid, -1, "{FF0000}[HOUSE]: {FFFFFF}Interior setted. {FF0000}Interior #5.");
				HouseInfo[houseid][hInterior] = 5;
			}
			if(listitem == 5)
			{
				SendClientMessage(playerid, -1, "{FF0000}[HOUSE]: {FFFFFF}Interior setted. {FF0000}Interior #6.");
				HouseInfo[houseid][hInterior] = 6;
			}
			if(listitem == 6)
			{
			    SendClientMessage(playerid, -1, "{FF0000}[HOUSE]: {FFFFFF}Interior setted. {FF0000}Interior #7.");
				HouseInfo[houseid][hInterior] = 7;
			}
			if(listitem == 7)
			{
				SendClientMessage(playerid, -1, "{FF0000}[HOUSE]: {FFFFFF}Interior setted. {FF0000}Interior #8.");
				HouseInfo[houseid][hInterior] = 8;
			}
			if(listitem == 8)
			{
				HouseInfo[houseid][hInterior] = 9;
		        SendClientMessage(playerid, -1, "{FF0000}[HOUSE]: {FFFFFF}Interior setted. {FF0000}Interior #9.");
			}
            new string[500];
		    format(string, sizeof(string), "{FFFFFF}Are you sure do you want save this house?\n\n{FF0000}House ID: {FFFFFF}%d\n{FF0000}House Price: {FFFFFF}%d\n{FF0000}House Interior: {FFFFFF}Interior %d \nGarages: %d.",
			houseid, HouseInfo[houseid][hPrice], HouseInfo[houseid][hInterior], GetPVarInt(playerid, "Garage"));
		    ShowPlayerDialog(playerid, DIALOG_SAVE, DIALOG_STYLE_MSGBOX, "Save", string, "Yes", "No");
		}
		else
		{
	    	ShowPlayerDialog(playerid, DIALOG_PRICE, DIALOG_STYLE_INPUT, "Price", "{FFFFFF}Please, input below price of this house:", "Continue", "Back");
		}
	}
	if(dialogid == DIALOG_SAVE)
	{
		if(response)
		{
			new Float:X, Float:Y, Float:Z, World, string[144], labelstring[144], file[40];
			World = GetPlayerVirtualWorld(playerid);
			format(string, sizeof(string), "{FF0000}[HOUSE]: {FFFFFF}House ID: {FF0000}%d {FFFFFF}was created succesfully.", houseid);
			format(labelstring, sizeof(labelstring), "{15FF00}Price: {FFFFFF}%i\n{15FF00}Adress: {FFFFFF}%d\n{15FF00}Press {FFFFFF}~k~~SNEAK_ABOUT~ {15FF00}to buy this house.", HouseInfo[houseid][hPrice], houseid);
			SendClientMessage(playerid, -1, string);
			GetPlayerPos(playerid, X, Y, Z);
			HouseInfo[houseid][hX] = X;
			HouseInfo[houseid][hY] = Y;
			HouseInfo[houseid][hZ] = Z;
			HouseInfo[houseid][hPick] = CreatePickup(1273, 1, X, Y, Z, World);
			HouseInfo[houseid][hLabel] = Create3DTextLabel(labelstring, 0xFFFFFFFF, X, Y, Z, 5.0, 0, 0);
			HouseInfo[houseid][hMapIconID] = CreateDynamicMapIcon(HouseInfo[houseid][hX], HouseInfo[houseid][hY], HouseInfo[houseid][hZ], 31, 0, -1, -1, -1, STREAMDISTANCE_HOUSEMAPICONID, MAPICON_LOCAL, STREAMER_TAG_AREA:-1, 0);
			new strings[50];
			format(strings, sizeof strings, "Houseiconid created: %i", HouseInfo[houseid][hMapIconID]);
			DebugMessage(playerid, strings);
			format(file, sizeof(file), "Houses/%d.ini", houseid);
			if(!fexist(file))
			{
				dini_Create(file);
				dini_IntSet(file, "Price", HouseInfo[houseid][hPrice]);
				dini_IntSet(file, "Interior", HouseInfo[houseid][hInterior]);
				dini_IntSet(file, "Owned", 0);
				dini_FloatSet(file, "PositionX", X);
				dini_FloatSet(file, "PositionY", Y);
				dini_FloatSet(file, "PositionZ", Z);
				
				dini_FloatSet(file, "Locked", HouseInfo[houseid][hLocked]);
				AddStaticVehicle(600,HouseInfo[houseid][G1X],HouseInfo[houseid][G1Y],HouseInfo[houseid][G1Z],HouseInfo[houseid][GF1],0,0);
				AddStaticVehicle(576,HouseInfo[houseid][G2X],HouseInfo[houseid][G2Y],HouseInfo[houseid][G2Z],HouseInfo[houseid][GF2],0,0);
				AddStaticVehicle(474,HouseInfo[houseid][G3X],HouseInfo[houseid][G3Y],HouseInfo[houseid][G3Z],HouseInfo[houseid][GF3],0,0);
				if(GetPVarInt(playerid, "Garage") == 0)
				{
				   dini_Set(file, "Garagen", "0");
				}
				else if(GetPVarInt(playerid, "Garage") == 1)
				{
				   dini_Set(file, "Garagen", "1");
			       dini_FloatSet(file, "Garage1X",HouseInfo[houseid][G1X]);
			       dini_FloatSet(file, "Garage1Y",HouseInfo[houseid][G1Y]);
			       dini_FloatSet(file, "Garage1Z",HouseInfo[houseid][G1Z]);
			       dini_FloatSet(file, "Garage1A",HouseInfo[houseid][GF1]);
				}
				else if(GetPVarInt(playerid, "Garage") == 2)
				{
				   dini_Set(file, "Garagen", "2");
			       dini_FloatSet(file, "Garage1X",HouseInfo[houseid][G1X]);
			       dini_FloatSet(file, "Garage1Y",HouseInfo[houseid][G1Y]);
			       dini_FloatSet(file, "Garage1Z",HouseInfo[houseid][G1Z]);
			       dini_FloatSet(file, "Garage1A",HouseInfo[houseid][GF1]);
			       dini_FloatSet(file, "Garage2X",HouseInfo[houseid][G2X]);
			       dini_FloatSet(file, "Garage2Y",HouseInfo[houseid][G2Y]);
			       dini_FloatSet(file, "Garage2Z",HouseInfo[houseid][G2Z]);
			       dini_FloatSet(file, "Garage2A",HouseInfo[houseid][GF2]);
				}
				if(GetPVarInt(playerid, "Garage") == 3)
				{
				   dini_Set(file, "Garagen", "3");
			       dini_FloatSet(file, "Garage1X",HouseInfo[houseid][G1X]);
			       dini_FloatSet(file, "Garage1Y",HouseInfo[houseid][G1Y]);
			       dini_FloatSet(file, "Garage1Z",HouseInfo[houseid][G1Z]);
			       dini_FloatSet(file, "Garage1A",HouseInfo[houseid][GF1]);
			       dini_FloatSet(file, "Garage2X",HouseInfo[houseid][G2X]);
			       dini_FloatSet(file, "Garage2Y",HouseInfo[houseid][G2Y]);
			       dini_FloatSet(file, "Garage2Z",HouseInfo[houseid][G2Z]);
			       dini_FloatSet(file, "Garage2A",HouseInfo[houseid][GF2]);
			       dini_FloatSet(file, "Garage3X",HouseInfo[houseid][G3X]);
			       dini_FloatSet(file, "Garage3Y",HouseInfo[houseid][G3Y]);
			       dini_FloatSet(file, "Garage3Z",HouseInfo[houseid][G3Z]);
			       dini_FloatSet(file, "Garage3A",HouseInfo[houseid][GF3]);
				}
	            SetPVarInt(playerid, "Garage", -1);
	            SetPVarInt(playerid, "Haus", -1);
		    }
		    houseid++;
		}
		else
		{
			SendClientMessage(playerid, -1, "{FF0000}[HOUSE]: {FFFFFF}Your house has been reseted.");
		}
	}
	if(dialogid == DIALOG_REMOVEID)
	{
		if(response)
		{
			new hID, file[50], string[100];
			if(strlen(inputtext) == 0)
			{
                SendClientMessage(playerid, Hellrot, "Nothing has been removed, House creating has been exited");
                return 1;
			}
			hID = strval(inputtext);
			format(file, sizeof(file), "Houses/%d.ini", hID);
			if(!fexist(file))
			{
                SendClientMessage(playerid, -1, "{FF0000}ERROR: {FFFFFF}This house ID isn't in our data-base.");
			}
			else
			{
				HouseInfo[hID][hPrice] = 0;
				HouseInfo[hID][hLocked] = 0;
				HouseInfo[hID][hOwned] = 0;
				HouseInfo[hID][hOwner] = 0;
				HouseInfo[hID][hX] = 0;
				HouseInfo[hID][hY] = 0;
				HouseInfo[hID][hZ] = 0;
				DestroyPickup(HouseInfo[hID][hPick]);
			if(!IsValidDynamicMapIcon(HouseInfo[hID][hMapIconID]))
			{
			   new strings[50];
			   format(strings, sizeof strings, "%i is not a valid Map Icon!", HouseInfo[hID][hMapIconID]);
			   DebugMessage(playerid, strings);
			   return 1;
			 }
			new strings[50];
			format(strings, sizeof strings, "Houseiconid removed: %i", HouseInfo[hID][hMapIconID]);
			SendClientMessageToAll(Weis, strings);
				DestroyDynamicMapIcon(HouseInfo[hID][hMapIconID]);
				Update3DTextLabelText(HouseInfo[hID][hLabel], 0xFFFFFFFF, " ");
				format(string, sizeof(string), "{FF0000}[HOUSE]: {FFFFFF}House ID: {FF0000}%d {FFFFFF}has been removed.");
				SendClientMessage(playerid, -1, string);
				dini_Remove(file);
			}
		}
		else
		{
		    ShowPlayerDialog(playerid, DIALOG_HOPTIONS, DIALOG_STYLE_MSGBOX, "House options", "{FFFFFF}Please, select your option.", "Create", "Remove");
		}
	}
	return 1;
}

//------------------------------------------------------------------------------

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
  for(new i = 0; i < MAX_HOUSES; i++)
  {
   if(newkeys == KEY_CROUCH)
   {
	 if(GetPVarInt(playerid, "Haus")== 1)
     {
       if(GetPVarInt(playerid, "Garage") == -1)//hier
       {
          ShowPlayerDialog(playerid, DIALOG_GARAGE, DIALOG_STYLE_MSGBOX, "Garage 1", "Garage Pos 1 entered\nPress OKAY for Garage 2 \nPress SKIP if only 1 Garage \nMake sure to exit and enter the car before saving so the Player Facing angle will be corrected", "Okay", "Skip");
       }
       else if(GetPVarInt(playerid, "Garage") == 1)
       {
          ShowPlayerDialog(playerid, DIALOG_GARAGEE, DIALOG_STYLE_MSGBOX, "Garage 2", "Garage Pos 2 entered\nPress OKAY for Garage 3 \nPress SKIP if only 2 Garages \nMake sure to exit and enter the car before saving so the Player Facing angle will be corrected", "Okay", "Skip");
       }
       else if(GetPVarInt(playerid, "Garage") == 2)
       {
          ShowPlayerDialog(playerid, DIALOG_GARAGEEE, DIALOG_STYLE_MSGBOX, "Garage 3", "Garage Pos 3 entered\nPress OKAY to move on to the house door pos", "Okay", "Skip");
       }
       else if(GetPVarInt(playerid, "Garage") == 3 || GetPVarInt(playerid, "Garage") == 0)
       {
          ShowPlayerDialog(playerid, DIALOG_GARAGEA, DIALOG_STYLE_MSGBOX, "House Door", "Here will be the door \nYou might need to click OKAY more than once, this dialog sometimes hangs", "Okay", "Cancel");
       }
	 }
  }
   if(newkeys == KEY_WALK)
   {
	if(GetPVarInt(playerid, "IsPlayerInHouse") < 0)
		{
	    if(IsPlayerInRangeOfPoint(playerid, 1.0, HouseInfo[i][hX], HouseInfo[i][hY], HouseInfo[i][hZ]))
		  {
			if(HouseInfo[i][hOwned] == 0)
			{
			   new name[MAX_PLAYER_NAME], Float:X, Float:Y, Float:Z, World, labelstring[144], string[144], file[50];
			   World = GetPlayerVirtualWorld(playerid);
			   GetPlayerPos(playerid, X, Y, Z);
			   GetPlayerName(playerid, name, sizeof(name));
			   {
			      if(GetPlayerMoney(playerid) < HouseInfo[i][hPrice]) return SendClientMessage(playerid, -1, "{FF0000}ERROR: {FFFFFF}You don't have enough cash to buy this house.");
			      HouseInfo[i][hOwner] = name;
			      HouseInfo[i][hOwned] = 1;
			      format(labelstring, sizeof(labelstring), "{15FF00}Owner: {FFFFFF}%s \n{15FF00}Price: {FFFFFF}%i\n {15FF00}Rent: {FFFFFF}%s \n{15FF00}Adress: {FFFFFF}%d", HouseInfo[i][hOwner], HouseInfo[i][hPrice], "WORK IN PROGRESS", i);
			      DestroyPickup(HouseInfo[i][hPick]);
			      HouseInfo[i][hPick] = CreatePickup(1272, 1, HouseInfo[i][hX], HouseInfo[i][hY], HouseInfo[i][hZ], World);
			      SetPlayerPos(playerid, HouseInfo[i][hX], HouseInfo[i][hY], HouseInfo[i][hZ]);
			      Update3DTextLabelText(HouseInfo[i][hLabel], 0xFFFFFFFF, labelstring);
			      format(string, sizeof(string), "{FF0000}[HOUSE]: {FFFFFF}You've bought house: {FF0000}%d {FFFFFF}for {FF0000}$ %d.", i, HouseInfo[i][hPrice]);
			if(!IsValidDynamicMapIcon(HouseInfo[i][hMapIconID]))
			{
			   new strings[50];
			   format(strings, sizeof strings, "%i is not a valid Map Icon!", HouseInfo[i][hMapIconID]);
			   DebugMessage(playerid, strings);
			   return 1;
			 }
			new strings[50];
			format(strings, sizeof strings, "Houseiconid bought: %i", HouseInfo[i][hMapIconID]);
			DebugMessage(playerid, strings);
				  DestroyDynamicMapIcon(HouseInfo[i][hMapIconID]);
				  HouseInfo[i][hMapIconID] = CreateDynamicMapIcon(HouseInfo[i][hX], HouseInfo[i][hY], HouseInfo[i][hZ], 32, 0, -1, -1, -1, STREAMDISTANCE_HOUSEMAPICONID, MAPICON_LOCAL, STREAMER_TAG_AREA:-1, 0);
			      SendClientMessage(playerid, -1, string);
			      format(file, sizeof(file), "Houses/%d.ini", i);
			      new mstr[20];
			      format(mstr, sizeof mstr, "House %i bought", i);
			      ChangePlayerMoney(playerid, -HouseInfo[i][hPrice], mstr);
			      if(fexist(file))
			      {
				     dini_IntSet(file, "Owned", 1);
				     dini_Set(file, "Owner", name);
			      }
			   }
			   return 1;
			}
			if(HouseInfo[i][hLocked] == 1)
			{
			   if (strcmp(GetSname(playerid), HouseInfo[i][hOwner], false))
			   {
			      SendClientMessage(playerid, 0xFF0000FF, "This house is locked.");
                  return ShowPlayerDialog(playerid, UHDIALOG,  DIALOG_STYLE_LIST, "Menu","{FFFF00}Send Message to House Owner\nInventory\nHelp\n...","Select","Close");
			   }
			}
			{
				new interior;
				new Float:interiorposX, Float: interiorposY, Float: interiorposZ;
				if(HouseInfo[i][hInterior] == 1)
				{
				   interior = 12;// :)
				   interiorposX = 446.5724;
				   interiorposY = 507.06123;
				   interiorposZ = 1001.419494;
				}
				else if (HouseInfo[i][hInterior] == 2)
				{
				   interior = 1;// :)
				   interiorposX = 2524.5623;
				   interiorposY = -1679.3256;
				   interiorposZ = 1015.498596;
				}
				else if (HouseInfo[i][hInterior] == 3)
				{
				   interior = 2;// :)
				   interiorposX = 2468.2266;
				   interiorposY = -1698.2561;
				   interiorposZ = 1013.515197;
				}
				else if (HouseInfo[i][hInterior] == 4)
				{
				   interior = 8;// :)
				   interiorposX = 2807.5789;
				   interiorposY = -1174.1206;
				   interiorposZ = 1025.570312;
				}
				else if (HouseInfo[i][hInterior] == 5)
				{
				   interior = 5;// :)
				   interiorposX = 318.6630;
				   interiorposY = 1115.0416;
				   interiorposZ = 1083.882812;
				}
				else if (HouseInfo[i][hInterior] == 6)
				{
				   interior = 3;// CJ
				   interiorposX = 2496.0020;
				   interiorposY = -1692.7585;
				   interiorposZ = 1014.742187;
				}
				else if (HouseInfo[i][hInterior] == 7)
				{
				   interior = 12;// Safehouse
				   interiorposX = 2324.4319;
				   interiorposY = -1148.9150;
				   interiorposZ = 1050.710083;
				}
				else if (HouseInfo[i][hInterior] == 8)
				{
				   interior = 5;// Ganghouse
				   interiorposX = 2352.4375;
				   interiorposY = -1180.8230;
				   interiorposZ = 1027.976562;
				}
				else if (HouseInfo[i][hInterior] == 9)
				{
				   interior = 5;// Madd Dogg
				   interiorposX = 1261.4501;
				   interiorposY = -785.3258;
				   interiorposZ = 1091.906250;
				}
				else
				{
				   new string[25];
				   format(string, sizeof string, "House ID: %i", i);
				   DebugMessage(playerid, string);
				   format(string, sizeof string, "Interiornummer: %i", HouseInfo[i][hInterior]);
				   DebugMessage(playerid, string);
				   format(string, sizeof string, "Interior ID: %i", interior);
				   DebugMessage(playerid, string);
				   return SendClientMessage(playerid, Hellrot, "Sorry, there has been a error. Please try again, if it doesnt work reconnect, if it still doesnt work do a /report. Thanks.");
				}
				SetPlayerInterior(playerid, interior);
                SetPlayerPos(playerid, interiorposX, interiorposY, interiorposZ);
                //SetPlayerInterior(playerid, 6);
                //SetPlayerPos(playerid, 761.412963,1440.191650,1102.703125);
			}
		    SetTimerEx("HouseEnter", 500, false, "i", i);
            /*new string[25];
            format(string, sizeof string, "Houseid: %d", i);
            SendClientMessage(playerid, Weis, string);*/
			SendClientMessage(playerid, -1, "Press ~k~~SNEAK_ABOUT~ to get out of the house");
			InHouse[playerid][i] = 1;
		    if(strcmp(GetSname(playerid), HouseInfo[i][hOwner], true)) return SendClientMessage(playerid, Hellrot, "This house isn't owned by you.");
			{
		       new file[50];
		       new string[256];
		       format(file, sizeof(file), "Houses/%d.ini", i);
		       string = dini_Get(file, "MessageForOwner");
		       if(strlen(string) <= 0) return 1;
		       format(string, sizeof string, "%s \n\nWarning! Pressing 'Okay' will delete this message.", string);
		       ShowPlayerDialog(playerid, INFODIALOG, DIALOG_STYLE_MSGBOX, "You have got a message!", string, "Okay", "");
               dini_Set(file, "MessageForOwner", "");
            }
		  }
		}
	    else if(GetPVarInt(playerid, "IsPlayerInHouse") >= 0)
	    {
		   new a;
		   a = GetPVarInt(playerid, "IsPlayerInHouse");
		   if(HouseInfo[a][hInterior] == 1 && IsPlayerInRangeOfPoint(playerid, 1.0, 446.5724,507.0690,1001.4195) ||
		   (HouseInfo[a][hInterior] == 2 && IsPlayerInRangeOfPoint(playerid, 1.0, 2524.5623,-1679.3256,1015.4986) ||
		   (HouseInfo[a][hInterior] == 3 && IsPlayerInRangeOfPoint(playerid, 1.0, 2468.2266,-1698.2561,1013.5078) ||
		   (HouseInfo[a][hInterior] == 4 && IsPlayerInRangeOfPoint(playerid, 1.0, 2807.5789,-1174.1206,1025.5703) ||
		   (HouseInfo[a][hInterior] == 5 && IsPlayerInRangeOfPoint(playerid, 1.0, 318.6630,1115.0416,1083.8828) ||
		   (HouseInfo[a][hInterior] == 6 && IsPlayerInRangeOfPoint(playerid, 1.0, 2496.0020,-1692.7585,1014.7422) ||
		   (HouseInfo[a][hInterior] == 7 && IsPlayerInRangeOfPoint(playerid, 1.0, 2324.4319,-1148.9150,1050.7101) ||
		   (HouseInfo[a][hInterior] == 8 && IsPlayerInRangeOfPoint(playerid, 1.0, 2352.4375,-1180.8230,1027.9766) ||
		   (HouseInfo[a][hInterior] == 9 && IsPlayerInRangeOfPoint(playerid, 1.0, 1261.4501,-785.3258,1091.9063))))))))))
		   {
		      new Float: HX, Float: HY, Float: HZ;
		      new string[25];
		      format(string, sizeof string, "Houses/%d.ini", GetPVarInt(playerid, "IsPlayerInHouse"));
              HX = dini_Float(string, "PositionX");
              HY = dini_Float(string, "PositionY");
              HZ = dini_Float(string, "PositionZ");
              SetPlayerPos(playerid, HX, HY, HZ);
              SetPlayerInterior(playerid, 0);
              SetPVarInt(playerid, "IsPlayerInHouse", -1);
		   }
		   else
		   {
			  if (strcmp(GetSname(playerid), HouseInfo[a][hOwner], false))return ShowPlayerDialog(playerid, UHDIALOG,  DIALOG_STYLE_LIST, "Menu","{FFFF00}Send Message to House Owner\nInventory\nHelp\n...","Select","Close");
		      ShowPlayerDialog(playerid, HDIALOG,  DIALOG_STYLE_LIST, "Menu","{FFFF00}House Actions\nInventory\nHelp\n...","Select","Close");//hier
		      new string[25];
              format(string, sizeof string, "Interior: %i", HouseInfo[a][hInterior]);
              SendClientMessage(playerid, Weis, string);
		      return 1;
		   }
	    }
      }
   }
   return 1;
}

forward HouseEnter(id);
public HouseEnter(id)
{
   for(new i = 0; i < MAX_PLAYERS; i++)
   {
      SetPVarInt(i, "IsPlayerInHouse", id);
      new string[25];
      format(string, sizeof string, "Houseid: %i", GetPVarInt(i, "IsPlayerInHouse"));
      SendClientMessage(i, Weis, string);
   }
   return 1;
}

/*forward HouseLeave(playerid);
public HouseLeave (playerid)
{
SetPVarInt(playerid, "IsPlayerInHouse", -1);
KillTimer(exittimer);
return 1;
}*/

//------------------------------------------------------------------------------

public OnPlayerPickUpPickup(playerid, pickupid)
{
    new string[50];
    if (pickupid == HouseInfo[playerid][hPick])
    {
	    format(string,sizeof string,"~b~Press ~k~~SNEAK_ABOUT~ to enter the house");
	    SendInfoText(playerid, string);
	}
return 1;
}

//------------------------------------------------------------------------------

public OnFilterScriptInit()//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
{
	LoadHouses();
	return 1;
}

//------------------------------------------------------------------------------

stock LoadHouses()
{
	new file[50], labelstring[144], stringlabel[144];
	for(new i = 0; i < MAX_HOUSES; i++)
	{
		format(file, sizeof(file), "Houses/%d.ini", i);
		if(fexist(file))
		{
			HouseInfo[i][hPrice] = dini_Int(file, "Price");
			HouseInfo[i][hLocked] = dini_Int(file, "Locked");
			HouseInfo[i][hInterior] = dini_Int(file, "Interior");
			HouseInfo[i][hOwned] = dini_Int(file, "Owned");
			HouseInfo[i][hX] = dini_Float(file, "PositionX");
			HouseInfo[i][hY] = dini_Float(file, "PositionY");
			HouseInfo[i][hZ] = dini_Float(file, "PositionZ");
			HouseInfo[i][G1X] = dini_Float(file, "Garage1X");
			HouseInfo[i][G1Y] = dini_Float(file, "Garage1Y");
			HouseInfo[i][G1Z] = dini_Float(file, "Garage1Z");
			HouseInfo[i][G2X] = dini_Float(file, "Garage2X");
			HouseInfo[i][G2Y] = dini_Float(file, "Garage2Y");
			HouseInfo[i][G2Z] = dini_Float(file, "Garage2Z");
			HouseInfo[i][G3X] = dini_Float(file, "Garage3X");
			HouseInfo[i][G3Y] = dini_Float(file, "Garage3Y");
			HouseInfo[i][G3Z] = dini_Float(file, "Garage3Z");
			HouseInfo[i][hMapIconID] = i;//hier
			strmid(HouseInfo[i][hOwner], dini_Get(file, "Owner"), false, strlen(dini_Get(file, "Owner")), MAX_PLAYER_NAME);
			format(labelstring, sizeof(labelstring), "{15FF00}Price: {FFFFFF}%i\n{15FF00}Adress: {FFFFFF}%d\n{15FF00}Press {FFFFFF}~k~~SNEAK_ABOUT~ {15FF00}to buy this house.", HouseInfo[i][hPrice], i);
			format(stringlabel, sizeof(stringlabel), "{15FF00}Owner: {FFFFFF}%s \n{15FF00}Price: {FFFFFF}%i\n {15FF00}Rent: {FFFFFF}%s \n{15FF00}Adress: {FFFFFF}%d", HouseInfo[i][hOwner], HouseInfo[i][hPrice], "WORK IN PROGRESS", i);
            if(HouseInfo[i][hOwned] == 0)
			{
				HouseInfo[i][hPick] = CreatePickup(1273, 1, HouseInfo[i][hX], HouseInfo[i][hY], HouseInfo[i][hZ], 0);
				HouseInfo[i][hLabel] = Create3DTextLabel(labelstring, 0xFFFFFFFF, HouseInfo[i][hX], HouseInfo[i][hY], HouseInfo[i][hZ], 5.0, 0, 0);
				HouseInfo[i][hMapIconID] = CreateDynamicMapIcon(HouseInfo[i][hX], HouseInfo[i][hY], HouseInfo[i][hZ], 31, 0, -1, -1, -1, STREAMDISTANCE_HOUSEMAPICONID, MAPICON_LOCAL, STREAMER_TAG_AREA:-1, 0);
			}
			else if(HouseInfo[i][hOwned] == 1)
			{
			    HouseInfo[i][hPick] = CreatePickup(1272, 1, HouseInfo[i][hX], HouseInfo[i][hY], HouseInfo[i][hZ], 0);
			    CreatePickup(1277, 1, HouseInfo[i][G1X], HouseInfo[i][G1Y], HouseInfo[i][G1Z], 0);
			    CreatePickup(1277, 1, HouseInfo[i][G2X], HouseInfo[i][G2Y], HouseInfo[i][G2Z], 0);
			    CreatePickup(1277, 1, HouseInfo[i][G3X], HouseInfo[i][G3Y], HouseInfo[i][G3Z], 0);
				HouseInfo[i][hLabel] = Create3DTextLabel(stringlabel, 0xFFFFFFFF, HouseInfo[i][hX], HouseInfo[i][hY], HouseInfo[i][hZ], 5.0, 0, 0);
				HouseInfo[i][hMapIconID] = CreateDynamicMapIcon(HouseInfo[i][hX], HouseInfo[i][hY], HouseInfo[i][hZ], 32, 0, -1, -1, -1, STREAMDISTANCE_HOUSEMAPICONID, MAPICON_LOCAL, STREAMER_TAG_AREA:-1, 0);
			}
			CreatePickup(1318, 1, 446.5724,507.0690,1001.4195, 0);//Interior 1;
			CreatePickup(1318, 1, 2524.5623,-1679.3256,1015.4986, 0);//Interior 2;
			CreatePickup(1318, 1, 2468.2266,-1698.2561,1013.5078, 0);//Interior 3;
			CreatePickup(1318, 1, 2807.5789,-1174.1206,1025.5703, 0);//Interior 4;
			CreatePickup(1318, 1, 318.6630,1115.0416,1083.8828, 0);//Interior 5;
			CreatePickup(1318, 1, 2496.0020,-1692.7585,1014.7422, 0);//Interior 6 CJ;
			CreatePickup(1318, 1, 2324.4319,-1148.9150,1050.7101, 0);//Interior 7;
			CreatePickup(1318, 1, 2352.4375,-1180.8230,1027.9766, 0);//Interior 8;
			CreatePickup(1318, 1, 1261.4501,-785.3258,1091.9063, 0);//Interior 9;
			new stringg[45];
			format(stringg, sizeof stringg, "  House ID: %i%, IconID: %i, Interior ID: %i", i, HouseInfo[i][hMapIconID], HouseInfo[i][hInterior]);
			print(stringg);
			houseid++;
		}
	}
	printf("  Geladene Häuser... %d", houseid);
	return 1;
}

//------------------------------------------------------------------------------
#endif
