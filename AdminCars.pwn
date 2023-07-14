#include <a_samp>
#include <streamer>
#include <0SimonsInclude>
#pragma tabsize 0

#define PLAYERS 300

new PlayerText:Test[MAX_PLAYERS];

new admincar_0;
new admincar_1;
new admincar_2;
new admincar_5;
new admincar_4;
new admincar_3;
new admincar_6;
new admincar_7;

public OnPlayerConnect(playerid)
{
Test[playerid] = CreatePlayerTextDraw(playerid, 575.666503, 8.311092, "TDEditor");
PlayerTextDrawLetterSize(playerid, Test[playerid], 0.400000, 1.600000);
PlayerTextDrawAlignment(playerid, Test[playerid], 1);
PlayerTextDrawColor(playerid, Test[playerid], -1);
PlayerTextDrawSetShadow(playerid, Test[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, Test[playerid], 255);
PlayerTextDrawFont(playerid, Test[playerid], 1);
PlayerTextDrawSetProportional(playerid, Test[playerid], 1);

PlayerTextDrawShow(playerid, PlayerText:Test[playerid]);
return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
    new vehicleid;
    vehicleid = GetPlayerVehicleID(playerid);
    new NP[15];

    if (newstate == PLAYER_STATE_DRIVER)
    {
       new bromat[25];
       //format(bromat, sizeof(bromat), "%i", vehicleid);
       GetVehicleNumberPlate(vehicleid, bromat, sizeof bromat);
       PlayerTextDrawSetString(playerid, PlayerText:Test[playerid], bromat);
    }

    if(!IsPlayerAdmin(playerid))
      {
          if (newstate == PLAYER_STATE_DRIVER) //|| (newstate == PLAYER_STATE_PASSENGER)
      {
	GetVehicleNumberPlate(vehicleid, NP, sizeof NP);
    if (strcmp(NP, "Admin Car") == 1)
    {
        RemovePlayerFromVehicle(playerid);
        SendClientMessage(playerid, 0xFF0000FF, "OOPS! You are not a admin!");
    }
	}}
    return 1;
}

public OnPlayerCommandText(playerid,cmdtext[])
{
    for(new i=0; i<MAX_PLAYERS; i++)
  	
    if (!strcmp(cmdtext, "/tornado", true))
    {
    if (IsPlayerAdmin(playerid) == 0)return SendClientMessage(playerid, Hellrot, "This Command doesn't exist (yet). Type /help to see all commands and key configurations");
    new Float: X, Float:Y, Float:Z, Float: FA;
    GetPlayerPos(playerid, X, Y, Z);
    GetPlayerFacingAngle(playerid, FA);
    admincar_5 = CreateVehicle(576, X, Y, Z ,FA, 0, 0, -1,1);
    new tmpobjid;


    AddVehicleComponent(admincar_5, 1010);
    AddVehicleComponent(admincar_5, 1135);
    AddVehicleComponent(admincar_5, 1077);
    AddVehicleComponent(admincar_5, 1087);
    AddVehicleComponent(admincar_5, 1191);
    AddVehicleComponent(admincar_5, 1193);

    tmpobjid = CreateDynamicObject(2914,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
    AttachDynamicObjectToVehicle(tmpobjid, admincar_5, 1.030, 1.951, 0.000, 0.000, 0.000, -91.500);
    tmpobjid = CreateDynamicObject(2914,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
    AttachDynamicObjectToVehicle(tmpobjid, admincar_5, -1.030, 1.951, 0.000, 0.000, 0.000, -89.900);
    tmpobjid = CreateDynamicObject(921,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
    AttachDynamicObjectToVehicle(tmpobjid, admincar_5, 0.000, 0.479, 0.960, -91.099, 0.000, 0.000);
    tmpobjid = CreateDynamicObject(1006,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
    AttachDynamicObjectToVehicle(tmpobjid, admincar_5, 0.000, 1.560, 0.369, 0.000, 0.000, 0.000);
    tmpobjid = CreateDynamicObject(1023,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
    AttachDynamicObjectToVehicle(tmpobjid, admincar_5, 0.000, -2.922, 0.259, 0.000, 0.000, 0.000);

    tmpobjid = CreateDynamicObject(19294,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
    AttachDynamicObjectToVehicle(tmpobjid, admincar_5, 0.000, 0.490, 0.920, 0.000, 0.000, 0.000);
    tmpobjid = CreateDynamicObject(19294,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
    AttachDynamicObjectToVehicle(tmpobjid, admincar_5, 0.000, 0.490, 0.920, 0.000, 0.000, 0.000);
    tmpobjid = CreateDynamicObject(19294,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
    AttachDynamicObjectToVehicle(tmpobjid, admincar_5, 0.000, 0.490, 0.920, 0.000, 0.000, 0.000);
    
    tmpobjid = CreateDynamicObject(2731,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
    SetDynamicObjectMaterialText(tmpobjid, 0, "Admin Car", 50, "Calibri", 20, 0, -1, 0, 1);
    AttachDynamicObjectToVehicle(tmpobjid, admincar_5, -1.145, 1.212, 0.240, 0.000, 0.000, 86.399);
    tmpobjid = CreateDynamicObject(2731,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
    SetDynamicObjectMaterialText(tmpobjid, 0, "Admin Car", 50, "Calibri", 20, 0, -1, 0, 1);
    AttachDynamicObjectToVehicle(tmpobjid, admincar_5, 1.145, 1.212, 0.240, 0.000, 0.000, -86.399);
    PutPlayerInVehicle(playerid, admincar_5, 0);
    SetVehicleNumberPlate(admincar_5, "{FF0000}Admin Car");
    return 0;
    }
	else if (!strcmp(cmdtext, "/hermes", true))
    {
	if (IsPlayerAdmin(playerid) == 0)return SendClientMessage(playerid, Hellrot, "This Command doesn't exist (yet). Type /help to see all commands and key configurations");
    new Float: X, Float:Y, Float:Z, Float: FA;
    new tmpobjid;
    GetPlayerPos(playerid, X, Y, Z);
    GetPlayerFacingAngle(playerid, FA);
    admincar_1 = CreateVehicle(474, X, Y, Z, FA,0,1,-1,1);
    SetVehicleNumberPlate(admincar_1, "{FF0000}Admin Car");

    AddVehicleComponent(admincar_1, 1010);
    AddVehicleComponent(admincar_1, 1085);
    AddVehicleComponent(admincar_1, 1087);

    tmpobjid = CreateDynamicObject(1111,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
    AttachDynamicObjectToVehicle(tmpobjid, admincar_1, 0.000, 2.569, 0.359, 0.000, 0.000, 0.000);
    tmpobjid = CreateDynamicObject(1113,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
    AttachDynamicObjectToVehicle(tmpobjid, admincar_1, -0.650, -1.794, -0.620, 0.000, 0.000, 0.000);
    tmpobjid = CreateDynamicObject(1113,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
    AttachDynamicObjectToVehicle(tmpobjid, admincar_1, 0.520, -1.794, -0.620, 0.000, 0.000, 0.000);
    tmpobjid = CreateDynamicObject(2914,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
    AttachDynamicObjectToVehicle(tmpobjid, admincar_1, -0.971, -2.145, -0.063, 1.600, 0.000, -91.400);
    tmpobjid = CreateDynamicObject(2914,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
    AttachDynamicObjectToVehicle(tmpobjid, admincar_1, 0.971, -2.145, -0.063, -5.299, 0.000, -90.099);
    tmpobjid = CreateDynamicObject(1139,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
    AttachDynamicObjectToVehicle(tmpobjid, admincar_1, 0.000, -2.772, 0.169, 0.000, 0.000, 0.000);
    tmpobjid = CreateDynamicObject(1042,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
    AttachDynamicObjectToVehicle(tmpobjid, admincar_1, 1.151, 1.659, -0.104, -1.000, -2.300, 179.500);
    tmpobjid = CreateDynamicObject(1099,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
    AttachDynamicObjectToVehicle(tmpobjid, admincar_1, -1.143, 1.651, -0.060, 0.000, 0.000, 179.400);
    tmpobjid = CreateDynamicObject(921,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
    AttachDynamicObjectToVehicle(tmpobjid, admincar_1, 0.000, 0.110, 0.870, -89.800, 0.000, 0.000);

    tmpobjid = CreateDynamicObject(19294,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
    AttachDynamicObjectToVehicle(tmpobjid, admincar_1, 0.000, 0.110, 0.830, 0.000, 0.000, 0.000);
    tmpobjid = CreateDynamicObject(19294,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
    AttachDynamicObjectToVehicle(tmpobjid, admincar_1, 0.000, 0.110, 0.830, 0.000, 0.000, 0.000);
    tmpobjid = CreateDynamicObject(19294,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
    AttachDynamicObjectToVehicle(tmpobjid, admincar_1, 0.000, 0.110, 0.830, 0.000, 0.000, 0.000);
    
    tmpobjid = CreateDynamicObject(2731,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
    SetDynamicObjectMaterialText(tmpobjid, 0, "Admin", 100, "Ariel", 40, 0, -1, 0, 1);
    AttachDynamicObjectToVehicle(tmpobjid, admincar_1, 1.068, -1.369, 0.160, 11.899, 0.000, -93.499);
    tmpobjid = CreateDynamicObject(2731,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
    SetDynamicObjectMaterialText(tmpobjid, 0, "Admin", 100, "Ariel", 40, 0, -1, 0, 1);
    AttachDynamicObjectToVehicle(tmpobjid, admincar_1, -1.068, -1.369, 0.160, 11.899, 0.000, 93.499);
    tmpobjid = CreateDynamicObject(2731,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
    SetDynamicObjectMaterialText(tmpobjid, 0, "Car", 100, "Ariel", 40, 0, -1, 0, 1);
    AttachDynamicObjectToVehicle(tmpobjid, admincar_1, -1.148, -1.308, 0.003, -9.999, 0.000, -91.700);
    tmpobjid = CreateDynamicObject(2731,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
    SetDynamicObjectMaterialText(tmpobjid, 0, "Car", 100, "Ariel", 40, 0, -1, 0, 1);
    AttachDynamicObjectToVehicle(tmpobjid, admincar_1, 1.148, -1.308, 0.003, -9.999, 0.000, 91.700);
    PutPlayerInVehicle(playerid, admincar_1, 0);
    return 1;
    }
	else if (!strcmp(cmdtext, "/limo", true))
    {
	if (IsPlayerAdmin(playerid) == 0)return SendClientMessage(playerid, Hellrot, "This Command doesn't exist (yet). Type /help to see all commands and key configurations");
    new Float: X, Float:Y, Float:Z, Float: FA;
    new tmpobjid;
    GetPlayerPos(playerid, X, Y, Z);
    GetPlayerFacingAngle(playerid, FA);
    admincar_2 = CreateVehicle(409, X, Y, Z, FA,0,1,-1,1);
    SetVehicleNumberPlate(admincar_2, "{FF0000}Admin Car");

    AddVehicleComponent(admincar_2, 1009);
    AddVehicleComponent(admincar_2, 1085);
    AddVehicleComponent(admincar_2, 1087);

    tmpobjid = CreateDynamicObject(2914,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
    AttachDynamicObjectToVehicle(tmpobjid, admincar_2, -0.932, 3.081, -0.080, 0.000, 0.000, -93.999);
    tmpobjid = CreateDynamicObject(2914,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
    AttachDynamicObjectToVehicle(tmpobjid, admincar_2, 0.932, 3.081, -0.080, 0.000, 0.000, -91.900);
    tmpobjid = CreateDynamicObject(921,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
    AttachDynamicObjectToVehicle(tmpobjid, admincar_2, 0.000, 0.910, 0.864, -89.699, 0.000, 0.000);

    tmpobjid = CreateDynamicObject(19294,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
    AttachDynamicObjectToVehicle(tmpobjid, admincar_2, 0.000, 0.927, 0.810, 0.000, 0.000, 0.000);
    tmpobjid = CreateDynamicObject(19294,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
    AttachDynamicObjectToVehicle(tmpobjid, admincar_2, 0.000, 0.927, 0.810, 0.000, 0.000, 0.000);
    tmpobjid = CreateDynamicObject(19294,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
    AttachDynamicObjectToVehicle(tmpobjid, admincar_2, 0.000, 0.927, 0.810, 0.000, 0.000, 0.000);
    
    tmpobjid = CreateDynamicObject(19314,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
    AttachDynamicObjectToVehicle(tmpobjid, admincar_2, 0.020, 3.711, -0.001, 91.899, -89.499, -1.099);
    tmpobjid = CreateDynamicObject(2731,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
    SetDynamicObjectMaterialText(tmpobjid, 0, "Admin Car", 60, "Calibri", 35, 0, -1, 0, 0);
    AttachDynamicObjectToVehicle(tmpobjid, admincar_2, 1.099, -0.290, -0.441, -8.799, 0.000, 90.299);
    tmpobjid = CreateDynamicObject(2731,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
    SetDynamicObjectMaterialText(tmpobjid, 0, "Admin Car", 60, "Calibri", 35, 0, -1, 0, 0);
    AttachDynamicObjectToVehicle(tmpobjid, admincar_2, -1.099, -0.290, -0.441, -8.799, 0.000, -90.299);
    PutPlayerInVehicle(playerid, admincar_2, 0);
    return 1;
    }
	else if (!strcmp(cmdtext, "/infernus", true))
    {
	if (IsPlayerAdmin(playerid) == 0)return SendClientMessage(playerid, Hellrot, "This Command doesn't exist (yet). Type /help to see all commands and key configurations");
    new Float: X, Float:Y, Float:Z, Float: FA;
    new tmpobjid;
    GetPlayerPos(playerid, X, Y, Z);
    GetPlayerFacingAngle(playerid, FA);
    admincar_3 = CreateVehicle(411, X, Y, Z, FA,0,1,-1,1);
    SetVehicleNumberPlate(admincar_3, "{FF0000}Admin Car");

    AddVehicleComponent(admincar_3, 1010);
    AddVehicleComponent(admincar_3, 1085);
    AddVehicleComponent(admincar_3, 1087);

    tmpobjid = CreateDynamicObject(921,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
    AttachDynamicObjectToVehicle(tmpobjid, admincar_3, 0.000, 0.000, 0.740, -89.899, 0.000, 0.000);
    
    tmpobjid = CreateDynamicObject(19294,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
    AttachDynamicObjectToVehicle(tmpobjid, admincar_3, 0.000, 0.000, 0.720, 0.000, 0.000, 0.000);
    tmpobjid = CreateDynamicObject(19294,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
    AttachDynamicObjectToVehicle(tmpobjid, admincar_3, 0.000, 0.000, 0.720, 0.000, 0.000, 0.000);
    tmpobjid = CreateDynamicObject(19294,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
    AttachDynamicObjectToVehicle(tmpobjid, admincar_3, 0.000, 0.000, 0.720, 0.000, 0.000, 0.000);
    
    tmpobjid = CreateDynamicObject(2914,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
    AttachDynamicObjectToVehicle(tmpobjid, admincar_3, -0.017, -2.340, -0.129, -0.499, 0.000, -90.399);
    tmpobjid = CreateDynamicObject(2731,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
    SetDynamicObjectMaterialText(tmpobjid, 0, "Admin Car", 60, "Calibri", 35, 0, -1, 0, 0);
    AttachDynamicObjectToVehicle(tmpobjid, admincar_3, 1.081, 0.026, -0.640, 0.000, 0.000, -90.900);
    tmpobjid = CreateDynamicObject(2731,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
    SetDynamicObjectMaterialText(tmpobjid, 0, "Admin Car", 60, "Calibri", 35, 0, -1, 0, 0);
    AttachDynamicObjectToVehicle(tmpobjid, admincar_3, -1.081, 0.026, -0.640, 0.000, 0.000, 90.900);
    tmpobjid = CreateDynamicObject(2985,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
    AttachDynamicObjectToVehicle(tmpobjid, admincar_3, -0.005, -0.620, -0.210, 0.000, 0.000, 89.499);
    PutPlayerInVehicle(playerid, admincar_3, 0);
    return 1;
    }
	else if (!strcmp(cmdtext, "/truck", true))
    {
	if (IsPlayerAdmin(playerid) == 0)return SendClientMessage(playerid, Hellrot, "This Command doesn't exist (yet). Type /help to see all commands and key configurations");
    new Float: X, Float:Y, Float:Z, Float: FA;
    new tmpobjid;
    GetPlayerPos(playerid, X, Y, Z);
    GetPlayerFacingAngle(playerid, FA);
    admincar_4 = CreateVehicle(403, X, Y, Z, FA,0,1,-1,1);
    SetVehicleNumberPlate(admincar_4, "{FF0000}Admin Car");

	AddVehicleComponent(admincar_4, 1010);

    tmpobjid = CreateDynamicObject(13645,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
    AttachDynamicObjectToVehicle(tmpobjid, admincar_4, -0.005, 6.144, -0.406, 10.200, 0.000, 178.599);
    tmpobjid = CreateDynamicObject(921,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
    AttachDynamicObjectToVehicle(tmpobjid, admincar_4, 0.000, 3.595, 0.741, -89.700, 0.000, 0.000);

    tmpobjid = CreateDynamicObject(19294,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
    AttachDynamicObjectToVehicle(tmpobjid, admincar_4, 0.000, 3.571, 0.720, 0.000, 0.000, 0.000);
    tmpobjid = CreateDynamicObject(19294,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
    AttachDynamicObjectToVehicle(tmpobjid, admincar_4, 0.000, 3.571, 0.720, 0.000, 0.000, 0.000);
    tmpobjid = CreateDynamicObject(19294,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
    AttachDynamicObjectToVehicle(tmpobjid, admincar_4, 0.000, 3.571, 0.720, 0.000, 0.000, 0.000);
    
    tmpobjid = CreateDynamicObject(2914,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
    AttachDynamicObjectToVehicle(tmpobjid, admincar_4, -1.093, -1.452, 1.690, 0.000, 0.000, -90.700);
    tmpobjid = CreateDynamicObject(2914,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
    AttachDynamicObjectToVehicle(tmpobjid, admincar_4, 1.093, -1.452, 1.690, 0.000, 0.000, -89.299);
    tmpobjid = CreateDynamicObject(934,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
    AttachDynamicObjectToVehicle(tmpobjid, admincar_4, 0.000, -4.433, 0.810, 0.000, 0.000, 0.000);
    tmpobjid = CreateDynamicObject(2731,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
    SetDynamicObjectMaterialText(tmpobjid, 0, "Admin", 60, "Calibri", 50, 1, -1, 0, 1);
    AttachDynamicObjectToVehicle(tmpobjid, admincar_4, 1.283, -0.544, 0.650, 0.000, 0.000, 91.400);
    tmpobjid = CreateDynamicObject(2731,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
    SetDynamicObjectMaterialText(tmpobjid, 0, "Car", 60, "Calibri", 50, 1, -1, 0, 1);
    AttachDynamicObjectToVehicle(tmpobjid, admincar_4, 1.300, -0.484, 0.320, 0.000, 0.000, 93.700);
    tmpobjid = CreateDynamicObject(2731,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
    SetDynamicObjectMaterialText(tmpobjid, 0, "Car", 60, "Calibri", 50, 1, -1, 0, 1);
    AttachDynamicObjectToVehicle(tmpobjid, admincar_4, -1.300, -0.484, 0.320, 0.000, 0.000, -93.700);
    tmpobjid = CreateDynamicObject(2731,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
    SetDynamicObjectMaterialText(tmpobjid, 0, "Admin", 60, "Calibri", 50, 1, -1, 0, 1);
    AttachDynamicObjectToVehicle(tmpobjid, admincar_4, -1.283, -0.544, 0.650, 0.000, 0.000, -91.400);
    PutPlayerInVehicle(playerid, admincar_4, 0);
    return 1;
    }
	else if (!strcmp(cmdtext, "/slamvan", true))
    {
	if (IsPlayerAdmin(playerid) == 0)return SendClientMessage(playerid, Hellrot, "This Command doesn't exist (yet). Type /help to see all commands and key configurations");
    new Float: X, Float:Y, Float:Z, Float: FA;
    new tmpobjid;
    GetPlayerPos(playerid, X, Y, Z);
    GetPlayerFacingAngle(playerid, FA);
    admincar_7 = CreateVehicle(535, X, Y, Z, FA,0,1,-1,1);
    SetVehicleNumberPlate(admincar_7, "{FF0000}Admin Car");

	AddVehicleComponent(admincar_7, 1010);
    AddVehicleComponent(admincar_7, 1113);
    AddVehicleComponent(admincar_7, 1077);
    AddVehicleComponent(admincar_7, 1115);
    AddVehicleComponent(admincar_7, 1110);



    tmpobjid = CreateDynamicObject(19917,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
    AttachDynamicObjectToVehicle(tmpobjid, admincar_7, 0.015, -1.438, -0.000, 0.599, -0.599, 179.400);
    tmpobjid = CreateDynamicObject(1139,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
    AttachDynamicObjectToVehicle(tmpobjid, admincar_7, -0.020, -2.268, 0.389, 0.000, 0.000, 0.000);
    tmpobjid = CreateDynamicObject(1111,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
    AttachDynamicObjectToVehicle(tmpobjid, admincar_7, 0.000, 2.520, 0.259, 0.000, 0.000, 0.000);
    tmpobjid = CreateDynamicObject(2914,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
    AttachDynamicObjectToVehicle(tmpobjid, admincar_7, 0.835, -0.450, 0.409, 0.000, 0.000, -90.999);
    tmpobjid = CreateDynamicObject(2914,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
    AttachDynamicObjectToVehicle(tmpobjid, admincar_7, -0.835, -0.450, 0.409, 0.000, 0.000, -91.000);
    tmpobjid = CreateDynamicObject(921,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
    AttachDynamicObjectToVehicle(tmpobjid, admincar_7, -0.010, 0.634, 0.870, -88.099, 0.000, 0.000);

    tmpobjid = CreateDynamicObject(19294,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
    AttachDynamicObjectToVehicle(tmpobjid, admincar_7, -0.010, 0.658, 0.830, 0.000, 0.000, 0.000);
    tmpobjid = CreateDynamicObject(19294,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
    AttachDynamicObjectToVehicle(tmpobjid, admincar_7, -0.010, 0.658, 0.830, 0.000, 0.000, 0.000);
    tmpobjid = CreateDynamicObject(19294,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
    AttachDynamicObjectToVehicle(tmpobjid, admincar_7, -0.010, 0.658, 0.830, 0.000, 0.000, 0.000);
    
    tmpobjid = CreateDynamicObject(2731,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
    SetDynamicObjectMaterialText(tmpobjid, 0, "Admin Car", 50, "Calibri", 20, 0, -1, 0, 1);
    AttachDynamicObjectToVehicle(tmpobjid, admincar_7, 1.139, -0.855, 0.167, 12.900, 0.000, -89.999);
    tmpobjid = CreateDynamicObject(2731,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
    SetDynamicObjectMaterialText(tmpobjid, 0, "Admin Car", 50, "Calibri", 20, 0, -1, 0, 1);
    AttachDynamicObjectToVehicle(tmpobjid, admincar_7, -1.139, -0.855, 0.167, 12.900, 0.000, 89.999);
    PutPlayerInVehicle(playerid, admincar_7, 0);
    return 1;
    }
	else if (!strcmp(cmdtext, "/bus", true))
    {
	if (IsPlayerAdmin(playerid) == 0)return SendClientMessage(playerid, Hellrot, "This Command doesn't exist (yet). Type /help to see all commands and key configurations");
    new Float: X, Float:Y, Float:Z, Float: FA;
    new tmpobjid;
    GetPlayerPos(playerid, X, Y, Z);
    GetPlayerFacingAngle(playerid, FA);
    admincar_6 = CreateVehicle(431, X, Y, Z, FA,0,0,-1,1);
    SetVehicleNumberPlate(admincar_6, "{FF0000}Admin Car");

    AddVehicleComponent(admincar_6, 1010);

    tmpobjid = CreateDynamicObject(2914,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
    AttachDynamicObjectToVehicle(tmpobjid, admincar_6, -1.077, 5.531, 1.959, 0.000, 0.000, -88.900);
    tmpobjid = CreateDynamicObject(2914,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
    AttachDynamicObjectToVehicle(tmpobjid, admincar_6, 1.077, -5.531, 1.959, 0.000, 0.000, -88.400);
    tmpobjid = CreateDynamicObject(2914,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
    AttachDynamicObjectToVehicle(tmpobjid, admincar_6, 1.077, 5.531, 1.959, 0.000, 0.000, -89.699);
    tmpobjid = CreateDynamicObject(2914,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
    AttachDynamicObjectToVehicle(tmpobjid, admincar_6, -1.077, -5.531, 1.959, 0.000, 0.000, -89.699);
    tmpobjid = CreateDynamicObject(16442,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
    AttachDynamicObjectToVehicle(tmpobjid, admincar_6, -0.008, -1.094, 3.910, -0.999, 0.000, 95.200);
    tmpobjid = CreateDynamicObject(2661,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
    SetDynamicObjectMaterialText(tmpobjid, 0, "Admin Bus", 90, "Ariel", 50, 0, 1, 1, 1);
    AttachDynamicObjectToVehicle(tmpobjid, admincar_6, 1.367, -2.281, 0.600, 0.000, 0.000, 89.399);
    tmpobjid = CreateDynamicObject(2661,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
    SetDynamicObjectMaterialText(tmpobjid, 0, "Admin Bus", 90, "Ariel", 50, 0, 1, 1, 1);
    AttachDynamicObjectToVehicle(tmpobjid, admincar_6, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000);
    tmpobjid = CreateDynamicObject(2661,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
    SetDynamicObjectMaterialText(tmpobjid, 0, "Admin Bus", 90, "Ariel", 50, 0, 1, 1, 1);
    AttachDynamicObjectToVehicle(tmpobjid, admincar_6, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000);
    tmpobjid = CreateDynamicObject(2661,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
    SetDynamicObjectMaterialText(tmpobjid, 0, "Admin Bus", 90, "Ariel", 50, 0, -1, 1, 1);
    AttachDynamicObjectToVehicle(tmpobjid, admincar_6, -1.371, -2.868, 0.570, 0.000, 0.000, -89.399);
    tmpobjid = CreateDynamicObject(2661,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
    SetDynamicObjectMaterialText(tmpobjid, 0, "Admin Bus", 90, "Ariel", 50, 0, -1, 1, 1);
    AttachDynamicObjectToVehicle(tmpobjid, admincar_6, 0.002, 5.930, 0.499, 0.000, 0.000, -178.999);
    tmpobjid = CreateDynamicObject(2661,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
    SetDynamicObjectMaterialText(tmpobjid, 0, "Admin Bus", 90, "Ariel", 50, 0, -1, 1, 1);
    AttachDynamicObjectToVehicle(tmpobjid, admincar_6, -0.005, -5.750, 0.559, 0.000, 0.000, 0.699);
    tmpobjid = CreateDynamicObject(11701,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
    AttachDynamicObjectToVehicle(tmpobjid, admincar_6, 0.000, 5.013, 2.270, 0.000, 0.000, 0.000);
    tmpobjid = CreateDynamicObject(2661,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
    SetDynamicObjectMaterialText(tmpobjid, 0, "Admin Bus", 90, "Ariel", 50, 0, 1, 1, 1);
    AttachDynamicObjectToVehicle(tmpobjid, admincar_6, -1.356, -3.742, 0.600, 0.000, 0.000, -89.399);
    tmpobjid = CreateDynamicObject(2661,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
    SetDynamicObjectMaterialText(tmpobjid, 0, "Admin Bus", 90, "Ariel", 50, 0, 1, 1, 1);
    AttachDynamicObjectToVehicle(tmpobjid, admincar_6, 1.359, -3.162, 0.600, 0.000, 0.000, 89.399);
    tmpobjid = CreateDynamicObject(2661,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
    SetDynamicObjectMaterialText(tmpobjid, 0, "Admin Bus", 90, "Ariel", 50, 0, 1, 1, 1);
    AttachDynamicObjectToVehicle(tmpobjid, admincar_6, 1.356, -3.742, 0.600, 0.000, 0.000, 89.399);
    tmpobjid = CreateDynamicObject(2661,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
    SetDynamicObjectMaterialText(tmpobjid, 0, "Admin Bus", 90, "Ariel", 50, 0, 1, 1, 1);
    AttachDynamicObjectToVehicle(tmpobjid, admincar_6, -1.367, -2.281, 0.600, 0.000, 0.000, -89.399);
    tmpobjid = CreateDynamicObject(2661,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
    SetDynamicObjectMaterialText(tmpobjid, 0, "Admin Bus", 90, "Ariel", 50, 0, 1, 1, 1);
    AttachDynamicObjectToVehicle(tmpobjid, admincar_6, -1.359, -3.162, 0.600, 0.000, 0.000, -89.399);
    tmpobjid = CreateDynamicObject(2661,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
    SetDynamicObjectMaterialText(tmpobjid, 0, "Admin Bus", 90, "Ariel", 50, 0, 1, 1, 1);
    AttachDynamicObjectToVehicle(tmpobjid, admincar_6, 1.376, -2.278, 0.570, 0.000, 0.000, 89.399);
    tmpobjid = CreateDynamicObject(2661,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
    SetDynamicObjectMaterialText(tmpobjid, 0, "Admin Bus", 90, "Ariel", 50, 0, 1, 1, 1);
    AttachDynamicObjectToVehicle(tmpobjid, admincar_6, -1.360, -3.739, 0.570, 0.000, 0.000, -89.399);
    tmpobjid = CreateDynamicObject(2661,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
    SetDynamicObjectMaterialText(tmpobjid, 0, "Admin Bus", 90, "Ariel", 50, 0, 1, 1, 1);
    AttachDynamicObjectToVehicle(tmpobjid, admincar_6, -1.376, -2.278, 0.570, 0.000, 0.000, -89.399);
    tmpobjid = CreateDynamicObject(2661,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
    SetDynamicObjectMaterialText(tmpobjid, 0, "Admin Bus", 90, "Ariel", 50, 0, -1, 1, 1);
    AttachDynamicObjectToVehicle(tmpobjid, admincar_6, 1.371, -2.868, 0.570, 0.000, 0.000, 89.399);
    tmpobjid = CreateDynamicObject(2661,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
    SetDynamicObjectMaterialText(tmpobjid, 0, "Admin Bus", 90, "Ariel", 50, 0, 1, 1, 1);
    AttachDynamicObjectToVehicle(tmpobjid, admincar_6, 1.360, -3.739, 0.570, 0.000, 0.000, 89.399);
    tmpobjid = CreateDynamicObject(19803,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
    AttachDynamicObjectToVehicle(tmpobjid, admincar_6, 0.000, 4.924, 2.340, 0.000, 0.000, 0.000);
    PutPlayerInVehicle(playerid, admincar_6, 0);
    return 1;
    }
    return 0;
}

public OnVehicleSpawn(vehicleid)
{
    
    
    if(vehicleid == admincar_0)
    {
        AddVehicleComponent(admincar_0, 0);
        AddVehicleComponent(admincar_0, 0);
        AddVehicleComponent(admincar_0, 0);
        AddVehicleComponent(admincar_0, 0);
        AddVehicleComponent(admincar_0, 0);
        AddVehicleComponent(admincar_0, 0);
    }
    else if(vehicleid == admincar_1)
    {
        AddVehicleComponent(admincar_1, 0);
        AddVehicleComponent(admincar_1, 0);
        AddVehicleComponent(admincar_1, 0);
    }
    else if(vehicleid == admincar_2)
    {
        AddVehicleComponent(admincar_2, 0);
        AddVehicleComponent(admincar_2, 0);
        AddVehicleComponent(admincar_2, 0);
    }
    else if(vehicleid == admincar_5)
    {
        AddVehicleComponent(admincar_5, 0);
        AddVehicleComponent(admincar_5, 0);
        AddVehicleComponent(admincar_5, 0);
        AddVehicleComponent(admincar_5, 0);
        AddVehicleComponent(admincar_5, 0);
        AddVehicleComponent(admincar_5, 0);
    }
    else if(vehicleid == admincar_4)
    {
        AddVehicleComponent(admincar_4, 1010);
    }
    else if(vehicleid == admincar_3)
    {
        AddVehicleComponent(admincar_3, 0);
        AddVehicleComponent(admincar_3, 0);
        AddVehicleComponent(admincar_3, 0);
    }
    else if(vehicleid == admincar_6)
    {
        AddVehicleComponent(admincar_6, 1010);
    }
    return 0;
} 
