#include <a_samp>
#include <0SimonsInclude>
#include <streamer>

#define FuelFireBurningTime 60
#define FuelPuddleEvaporateTime 120
#define FuelPuddleObjectID 3065 //18741
#define FuelFireObjectID 18688

#define MAX_KANISTEROBJ 5000


new Secondtimer;
new FuelFiretimer[MAX_KANISTEROBJ];
new Kanister[MAX_PLAYERS];
new Kanisterobj[MAX_KANISTEROBJ];
new FuelPouring[MAX_PLAYERS];

public OnFilterScriptInit()
{
	for(new i=0;i<MAX_PLAYERS;i++)
	{
	   Secondtimer = SetTimerEx("OneSecondtimer", 1000, true, "%i", i);
	   return 1;
	}
	for(new f=0;f<MAX_KANISTEROBJ;f++)
	{
	   FuelFiretimer[f] = -1;
	   return 1;
	}
	return 1;
}

public OnFilterScriptExit()
{
	KillTimer(Secondtimer);
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
    if(!strcmp("/gun", cmdtext, true))
    {
        {
            GivePlayerWeapon(playerid, 23, 500);
		    if(FuelPouring[playerid] == 1)
		    {
		       OnPlayerCommandText(playerid, "/jerry");
		    }
	    }
        return 1;
    }
	if (strcmp("/jerry", cmdtext, true, 10) == 0)
	{
		if(FuelPouring[playerid] == 1)
		{
		   RemovePlayerAttachedObject(playerid, Kanister[playerid]);
		   FuelPouring[playerid] = 0;
		   SendClientMessage(playerid, Weis, "Pouring stopped");
		   Kanister[playerid] = SetPlayerAttachedObject(playerid,0,1650,6,0.123999,0.019000,0.058999,-5.799998,-107.399986,-12.700001,1.000000,1.000000,1.000000);
		   SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
		}
		else
		{
		   RemovePlayerAttachedObject(playerid, Kanister[playerid]);
		   FuelPouring[playerid] = 1;
		   Kanister[playerid] = SetPlayerAttachedObject(playerid,0,1650,6,0.079999,-0.022000,-0.246000,105.000007,10.800010,99.700004,1.535999,1.438999,1.297000);
		   SendClientMessage(playerid, Weis, "Press LMB to pour Fuel");
		   SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
		}
		return 1;
	}
	return 0;
}

forward OneSecondtimer(playerid);
public OneSecondtimer(playerid)
{
   if(FuelPouring[playerid] == 1)
   {
      new Keys, ud, lr;
      GetPlayerKeys(playerid,Keys,ud,lr);
	  if(Keys & KEY_FIRE)
	  {
         new Float:X, Float:Y, Float:Z;
         GetPlayerPos(playerid, X, Y, Z);
         for(new i=0;i<MAX_KANISTEROBJ;i++)
         {
            if(Kanisterobj[i] == 0)
		    {
               new string[50];
		       format(string, sizeof string, "%i %f %f %f", 1, X, Y, Z);
		       Kanisterobj[i] = strval(string);
		       Kanisterobj[i] = CreateObject(FuelPuddleObjectID, X, Y, Z-0.95, 0, 0, 0);
		       FuelFiretimer[i] = 0;
		       format(string, sizeof string, "Created: %i: %f, %f, %f", i, X, Y, Z);
		       SendClientMessage(playerid, Hellblau, string);//Debug
		       return 1;
            }
         }
      }
   }
   for(new i=0;i<MAX_KANISTEROBJ;i++)
   {
      if(FuelFiretimer[i] >= 0)
      {
         FuelFiretimer[i]++;
      }
      if(GetObjectModel(Kanisterobj[i]) == FuelFireObjectID && FuelFiretimer[i] > FuelFireBurningTime)
      {
         //Feuer löschen
         DestroyObject(Kanisterobj[i]);
         FuelFiretimer[i] = -1;
         Kanisterobj[i] = 0;
      }
      if(GetObjectModel(Kanisterobj[i]) == FuelPuddleObjectID && FuelFiretimer[i] > FuelPuddleEvaporateTime)
      {
         //Sprit verdunstet
         DestroyObject(Kanisterobj[i]);
         FuelFiretimer[i] = -1;
         Kanisterobj[i] = 0;
      }
      if(GetObjectModel(Kanisterobj[i]) == FuelFireObjectID)
      {
	     new Float:X, Float:Y, Float:Z, Float:Xn, Float:Yn, Float:Zn;
	     GetObjectPos(Kanisterobj[i], Xn, Yn, Zn);
	     if(!IsPlayerInAnyVehicle(playerid))
	     {
	        GetPlayerPos(playerid, X, Y, Z);
	     }
	     else
	     {
		    GetVehiclePos(GetPlayerVehicleID(playerid), X, Y, Z);
	     }
	     if(IsPointInRangeOfPoint(X, Y, Z, 3, Xn, Yn, Zn))
	     {
	        if(!IsPlayerInAnyVehicle(playerid))
	        {
		       new Float:health;
			   GetPlayerHealth(playerid, health);
		       SetPlayerHealth(playerid, health-10);
	        }
	        else
	        {
		       new Float:health;
			   GetVehicleHealth(GetPlayerVehicleID(playerid), health);
		       SetVehicleHealth(GetPlayerVehicleID(playerid), health-50);
	        }
	     }
         for(new n=0;n<MAX_KANISTEROBJ;n++)
         {
            if(GetObjectModel(Kanisterobj[n]) == FuelPuddleObjectID)
            {
			   GetObjectPos(Kanisterobj[i], X, Y, Z);
			   GetObjectPos(Kanisterobj[n], Xn, Yn, Zn);
			   if(IsPointInRangeOfPoint(X, Y, Z, 3, Xn, Yn, Zn))
			   {
		          GetObjectPos(Kanisterobj[n], X, Y, Z);
		          DestroyObject(Kanisterobj[n]);
		          Kanisterobj[n] = CreateObject(FuelFireObjectID, X, Y, Z-1.55, 0, 0, 0);
		          FuelFiretimer[n] = 0;
		          return 1;
               }
            }
         }
      }
   }
   return 1;
}

IsPointInRangeOfPoint(Float:x1, Float:y1, Float:z1, Float:radius, Float:x2, Float:y2, Float:z2)
{
	x1 -= x2;
	y1 -= y2;
	z1 -= z2;
	return ((x1 * x1) + (y1 * y1) + (z1 * z1)) < (radius * radius);
}

public OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ)
{
    if(hittype == 3 && GetObjectModel(hitid) == FuelPuddleObjectID)
    {
	   for(new i=0;i<MAX_KANISTEROBJ;i++)
	   {
	      if(hitid == Kanisterobj[i])
		  {
		     new Float:X, Float:Y, Float:Z;
		     GetObjectPos(Kanisterobj[i], X, Y, Z);
		     DestroyObject(Kanisterobj[i]);
		     Kanisterobj[i] = CreateObject(FuelFireObjectID, X, Y, Z-1.55, 0, 0, 0);
		     FuelFiretimer[i] = 0;
		     new string[50];
		     format(string, sizeof string, "Feuer: %i", i);
		     SendClientMessage(playerid, Weis, string);
		     return 1;
	      }
	   }
    }
    return 1;
}

public OnPlayerConnect(playerid)
{
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	RemovePlayerAttachedObject(playerid, Kanister[playerid]);
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	return 1;
}

public OnPlayerUpdate(playerid)
{
	return 1;
}
