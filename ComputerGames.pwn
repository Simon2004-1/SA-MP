#include a_samp
#include dini
#include sscanf2
#include 0SimonsInclude

#define Steuern 0

#define GAMESPEED_WALTON 6
#define GAMESPEED_PEREN 9
#define GAMESPEED_PICAD 12
#define GAMESPEED_ELEGY 14
#define GAMESPEED_URANUS 16
#define GAMESPEED_ZR350 18
#define GAMESPEED_CHEET 19
#define GAMESPEED_INFERN 20
#define GAMESPEED_RUSTLER 24

#define GAMEPRICE_WALTON 500
#define GAMEPRICE_PEREN 900
#define GAMEPRICE_PICAD 1300
#define GAMEPRICE_ELEGY 1700
#define GAMEPRICE_URANUS 2100
#define GAMEPRICE_ZR350 2600
#define GAMEPRICE_CHEET 3500
#define GAMEPRICE_INFERN 4900
#define GAMEPRICE_RUSTLER 10000

#define CARGAMEMONEYDIALOG 30

new CarGameLoadTimer;
new GameSecondsCount[MAX_PLAYERS];
new CarDirectionCount[MAX_PLAYERS];
new GameCar1Created[MAX_PLAYERS];
new GameCar2Created[MAX_PLAYERS];
new GameCar3Created[MAX_PLAYERS];
new GameCar4Created[MAX_PLAYERS];
new GameCar1Pos[MAX_PLAYERS];
new GameCar2Pos[MAX_PLAYERS];
new GameCar3Pos[MAX_PLAYERS];
new GameCar4Pos[MAX_PLAYERS];
new GameCar1C[MAX_PLAYERS];
new GameCar2C[MAX_PLAYERS];
new GameCar3C[MAX_PLAYERS];
new GameCar4C[MAX_PLAYERS];
new GameCar1[MAX_PLAYERS];
new GameCar2[MAX_PLAYERS];
new GameCar3[MAX_PLAYERS];
new GameCar4[MAX_PLAYERS];
new PlayerGameCarModel[MAX_PLAYERS];
new PlayerCarGamePoints[MAX_PLAYERS];
new PlayerCarGameMoney[MAX_PLAYERS];
new PlayerCarGameDistance[MAX_PLAYERS];
new GamePlayerCarColor[MAX_PLAYERS];

new PlayerText:CarGameBackGround[MAX_PLAYERS];
new PlayerText:CarGameLoadScreen[MAX_PLAYERS][5];
new PlayerText:CarGameMenu[MAX_PLAYERS][7];
new PlayerText:LeaveCarGame[MAX_PLAYERS];
new PlayerText:LeaveCarGameX[MAX_PLAYERS];
new PlayerText:GameCars[MAX_PLAYERS][2];
new PlayerText:GameCarShop[MAX_PLAYERS][2];
new PlayerText:GameCarPlay[MAX_PLAYERS][2];
new PlayerText:GameRoad[MAX_PLAYERS];
new PlayerText:GamePlayerCar[MAX_PLAYERS];
new PlayerText:GameCarLeft1[MAX_PLAYERS];
new PlayerText:GameCarLeft2[MAX_PLAYERS];
new PlayerText:GameCarRight1[MAX_PLAYERS];
new PlayerText:GameCarRight2[MAX_PLAYERS];
new PlayerText:CarDriveHUD[MAX_PLAYERS][5];
new PlayerText:CarGameBuyCar[MAX_PLAYERS][7];
new PlayerText:CarCrashExplosion[MAX_PLAYERS];
new PlayerText:SelectCarMenuExit[MAX_PLAYERS];
new PlayerText:CarGameShopMenu[MAX_PLAYERS][6];
new PlayerText:Bildschirm[MAX_PLAYERS][4];
new PlayerText:GameCarColorMenu[MAX_PLAYERS][2];

#define Filterscript

public OnPlayerConnect(playerid)
{
for(new i=0; i < MAX_PLAYERS; i++)
{
PlayerGameCarModel[playerid] = -1;
CarGameBackGround[i] = CreatePlayerTextDraw(i, 153.999908, 60.422237, "LD_SPAC:white");
PlayerTextDrawTextSize(i, CarGameBackGround[i], 299.712646, 288.247070);
PlayerTextDrawAlignment(i, CarGameBackGround[i], 1);
PlayerTextDrawColor(i, CarGameBackGround[i], -2139062017);
PlayerTextDrawSetShadow(i, CarGameBackGround[i], 0);
PlayerTextDrawUseBox(i, CarGameBackGround[i], 0);
PlayerTextDrawBackgroundColor(i, CarGameBackGround[i], 0);
PlayerTextDrawFont(i, CarGameBackGround[i], 4);
PlayerTextDrawSetProportional(i, CarGameBackGround[i], 0);

CarGameLoadScreen[i][0] = CreatePlayerTextDraw(i, 277.333374, 186.111312, "LD_SPAC:white");
PlayerTextDrawTextSize(i, CarGameLoadScreen[i][0], 58.000000, 58.000000);
PlayerTextDrawAlignment(i, CarGameLoadScreen[i][0], 1);
PlayerTextDrawColor(i, CarGameLoadScreen[i][0], 16777215);
PlayerTextDrawSetShadow(i, CarGameLoadScreen[i][0], 0);
PlayerTextDrawBackgroundColor(i, CarGameLoadScreen[i][0], 255);
PlayerTextDrawFont(i, CarGameLoadScreen[i][0], 4);
PlayerTextDrawSetProportional(i, CarGameLoadScreen[i][0], 0);

CarGameLoadScreen[i][1] = CreatePlayerTextDraw(i, 303.333496, 189.014877, "LD_NONE:explm05");
PlayerTextDrawTextSize(i, CarGameLoadScreen[i][1], 33.000000, 36.000000);
PlayerTextDrawAlignment(i, CarGameLoadScreen[i][1], 1);
PlayerTextDrawColor(i, CarGameLoadScreen[i][1], -1);
PlayerTextDrawSetShadow(i, CarGameLoadScreen[i][1], 0);
PlayerTextDrawBackgroundColor(i, CarGameLoadScreen[i][1], 255);
PlayerTextDrawFont(i, CarGameLoadScreen[i][1], 4);
PlayerTextDrawSetProportional(i, CarGameLoadScreen[i][1], 0);

CarGameLoadScreen[i][2] = CreatePlayerTextDraw(i, 305.666839, 260.103607, "Highway_Racer~n~Loading");
PlayerTextDrawLetterSize(i, CarGameLoadScreen[i][2], 0.400000, 1.600000);
PlayerTextDrawAlignment(i, CarGameLoadScreen[i][2], 2);
PlayerTextDrawColor(i, CarGameLoadScreen[i][2], 255);
PlayerTextDrawSetShadow(i, CarGameLoadScreen[i][2], 0);
PlayerTextDrawBackgroundColor(i, CarGameLoadScreen[i][2], 255);
PlayerTextDrawFont(i, CarGameLoadScreen[i][2], 1);
PlayerTextDrawSetProportional(i, CarGameLoadScreen[i][2], 1);

CarGameLoadScreen[i][3] = CreatePlayerTextDraw(i, 278.000091, 181.962966, "");
PlayerTextDrawTextSize(i, CarGameLoadScreen[i][3], 66.000000, 60.000000);
PlayerTextDrawAlignment(i, CarGameLoadScreen[i][3], 1);
PlayerTextDrawColor(i, CarGameLoadScreen[i][3], -1);
PlayerTextDrawSetShadow(i, CarGameLoadScreen[i][3], 0);
PlayerTextDrawFont(i, CarGameLoadScreen[i][3], 5);
PlayerTextDrawSetProportional(i, CarGameLoadScreen[i][3], 0);
PlayerTextDrawBackgroundColor(i, CarGameLoadScreen[i][3], 0);
PlayerTextDrawSetPreviewModel(i, CarGameLoadScreen[i][3], 404);
PlayerTextDrawSetPreviewRot(i, CarGameLoadScreen[i][3], -45.000000, 12.000000, 45.000000, 1.000000);
PlayerTextDrawSetPreviewVehCol(i, CarGameLoadScreen[i][3], 85, 85);

CarGameLoadScreen[i][4] = CreatePlayerTextDraw(i, 259.333251, 189.014755, "");
PlayerTextDrawTextSize(i, CarGameLoadScreen[i][4], 66.000000, 60.000000);
PlayerTextDrawAlignment(i, CarGameLoadScreen[i][4], 1);
PlayerTextDrawColor(i, CarGameLoadScreen[i][4], -1);
PlayerTextDrawSetShadow(i, CarGameLoadScreen[i][4], 0);
PlayerTextDrawFont(i, CarGameLoadScreen[i][4], 5);
PlayerTextDrawBackgroundColor(i, CarGameLoadScreen[i][4], 0);
PlayerTextDrawSetProportional(i, CarGameLoadScreen[i][4], 0);
PlayerTextDrawSetPreviewModel(i, CarGameLoadScreen[i][4], 411);
PlayerTextDrawSetPreviewRot(i, CarGameLoadScreen[i][4], -12.000000, 0.000000, 7.000000, 0.800000);
PlayerTextDrawSetPreviewVehCol(i, CarGameLoadScreen[i][4], 128, 1);

CarGameMenu[i][1] = CreatePlayerTextDraw(i, 153.666641, 315.948028, "LD_SPAC:white");
PlayerTextDrawTextSize(i, CarGameMenu[i][1], 301.000000, 35.000000);
PlayerTextDrawAlignment(i, CarGameMenu[i][1], 1);
PlayerTextDrawColor(i, CarGameMenu[i][1], -5963521);
PlayerTextDrawSetShadow(i, CarGameMenu[i][1], 0);
PlayerTextDrawBackgroundColor(i, CarGameMenu[i][1], 255);
PlayerTextDrawFont(i, CarGameMenu[i][1], 4);
PlayerTextDrawSetProportional(i, CarGameMenu[i][1], 0);

CarGameMenu[i][2] = CreatePlayerTextDraw(i, 360.666625, 59.592597, "LD_SPAC:white");
PlayerTextDrawTextSize(i, CarGameMenu[i][2], 95.000000, 44.000000);
PlayerTextDrawAlignment(i, CarGameMenu[i][2], 1);
PlayerTextDrawColor(i, CarGameMenu[i][2], -5963521);
PlayerTextDrawSetShadow(i, CarGameMenu[i][2], 0);
PlayerTextDrawBackgroundColor(i, CarGameMenu[i][2], 255);
PlayerTextDrawFont(i, CarGameMenu[i][2], 4);
PlayerTextDrawSetProportional(i, CarGameMenu[i][2], 0);

CarGameMenu[i][3] = CreatePlayerTextDraw(i, 363.666748, 65.970367, "Money:109853");
PlayerTextDrawLetterSize(i, CarGameMenu[i][3], 0.294333, 1.243259);
PlayerTextDrawTextSize(i, CarGameMenu[i][3], -20.000000, 0.000000);
PlayerTextDrawAlignment(i, CarGameMenu[i][3], 1);
PlayerTextDrawColor(i, CarGameMenu[i][3], 255);
PlayerTextDrawSetShadow(i, CarGameMenu[i][3], 0);
PlayerTextDrawBackgroundColor(i, CarGameMenu[i][3], 255);
PlayerTextDrawFont(i, CarGameMenu[i][3], 1);
PlayerTextDrawSetProportional(i, CarGameMenu[i][3], 1);

CarGameMenu[i][4] = CreatePlayerTextDraw(i, 366.666809, 81.318550, "Points:_54664");
PlayerTextDrawLetterSize(i, CarGameMenu[i][4], 0.294333, 1.243259);
PlayerTextDrawTextSize(i, CarGameMenu[i][4], -20.000000, 0.000000);
PlayerTextDrawAlignment(i, CarGameMenu[i][4], 1);
PlayerTextDrawColor(i, CarGameMenu[i][4], 255);
PlayerTextDrawSetShadow(i, CarGameMenu[i][4], 0);
PlayerTextDrawBackgroundColor(i, CarGameMenu[i][4], 255);
PlayerTextDrawFont(i, CarGameMenu[i][4], 1);
PlayerTextDrawSetProportional(i, CarGameMenu[i][4], 1);

CarGameMenu[i][5] = CreatePlayerTextDraw(i, 207.999923, 100.659233, "");
PlayerTextDrawTextSize(i, CarGameMenu[i][5], 199.000000, 197.000000);
PlayerTextDrawAlignment(i, CarGameMenu[i][5], 1);
PlayerTextDrawColor(i, CarGameMenu[i][5], -1);
PlayerTextDrawSetShadow(i, CarGameMenu[i][5], 0);
PlayerTextDrawFont(i, CarGameMenu[i][5], 5);
PlayerTextDrawBackgroundColor(i, CarGameMenu[i][5], 0);
PlayerTextDrawSetProportional(i, CarGameMenu[i][5], 0);
PlayerTextDrawSetPreviewModel(i, CarGameMenu[i][5], 19844);
PlayerTextDrawSetPreviewRot(i, CarGameMenu[i][5], -22.500000, 0.000000, 0.000000, 1.000000);

CarGameMenu[i][6] = CreatePlayerTextDraw(i, 233.666595, 101.488876, "");
PlayerTextDrawTextSize(i, CarGameMenu[i][6], 146.000000, 164.000000);
PlayerTextDrawAlignment(i, CarGameMenu[i][6], 1);
PlayerTextDrawColor(i, CarGameMenu[i][6], -1);
PlayerTextDrawSetShadow(i, CarGameMenu[i][6], 0);
PlayerTextDrawFont(i, CarGameMenu[i][6], 5);
PlayerTextDrawSetProportional(i, CarGameMenu[i][6], 0);
PlayerTextDrawBackgroundColor(i, CarGameMenu[i][6], 0);
PlayerTextDrawSetPreviewModel(i, CarGameMenu[i][6], PlayerGameCarModel[playerid]);
PlayerTextDrawSetPreviewRot(i, CarGameMenu[i][6], -20.000000, 0.000000, 0.000000, 1.000000);
PlayerTextDrawSetPreviewVehCol(i, CarGameMenu[i][6], 1, 1);

SelectCarMenuExit[i] = CreatePlayerTextDraw(i, 153.333465, 59.177795, "LD_SPAC:white");
PlayerTextDrawTextSize(i, SelectCarMenuExit[i], 39.000000, 41.000000);
PlayerTextDrawAlignment(i, SelectCarMenuExit[i], 1);
PlayerTextDrawColor(i, SelectCarMenuExit[i], -5963521);
PlayerTextDrawSetShadow(i, SelectCarMenuExit[i], 0);
PlayerTextDrawBackgroundColor(i, SelectCarMenuExit[i], 255);
PlayerTextDrawFont(i, SelectCarMenuExit[i], 4);
PlayerTextDrawSetProportional(i, SelectCarMenuExit[i], 1);
PlayerTextDrawSetSelectable(i, SelectCarMenuExit[i], true);

LeaveCarGame[i] = CreatePlayerTextDraw(i, 153.333465, 59.177795, "LD_SPAC:white");
PlayerTextDrawTextSize(i, LeaveCarGame[i], 39.000000, 41.000000);
PlayerTextDrawAlignment(i, LeaveCarGame[i], 1);
PlayerTextDrawColor(i, LeaveCarGame[i], -5963521);
PlayerTextDrawSetShadow(i, LeaveCarGame[i], 0);
PlayerTextDrawBackgroundColor(i, LeaveCarGame[i], 255);
PlayerTextDrawFont(i, LeaveCarGame[i], 4);
PlayerTextDrawSetProportional(i, LeaveCarGame[i], 0);
PlayerTextDrawSetSelectable(i, LeaveCarGame[i], true);

LeaveCarGameX[i] = CreatePlayerTextDraw(i, 166.333358, 67.214813, "X");
PlayerTextDrawLetterSize(i, LeaveCarGameX[i], 0.713333, 2.637481);
PlayerTextDrawTextSize(i, LeaveCarGameX[i], 2.000000, 0.000000);
PlayerTextDrawAlignment(i, LeaveCarGameX[i], 1);
PlayerTextDrawColor(i, LeaveCarGameX[i], -16776961);
PlayerTextDrawSetShadow(i, LeaveCarGameX[i], 0);
PlayerTextDrawBackgroundColor(i, LeaveCarGameX[i], 255);
PlayerTextDrawFont(i, LeaveCarGameX[i], 1);
PlayerTextDrawSetProportional(i, LeaveCarGameX[i], 1);

GameCars[i][0] = CreatePlayerTextDraw(i, 261.333435, 298.940704, "LD_OTB2:butnAo");
PlayerTextDrawTextSize(i, GameCars[i][0], 80.000000, 37.000000);
PlayerTextDrawAlignment(i, GameCars[i][0], 1);
PlayerTextDrawColor(i, GameCars[i][0], -5963521);
PlayerTextDrawSetShadow(i, GameCars[i][0], 0);
PlayerTextDrawBackgroundColor(i, GameCars[i][0], 255);
PlayerTextDrawFont(i, GameCars[i][0], 4);
PlayerTextDrawSetProportional(i, GameCars[i][0], 0);
PlayerTextDrawSetSelectable(i, GameCars[i][0], true);

GameCars[i][1] = CreatePlayerTextDraw(i, 286.000030, 304.074066, "Cars");
PlayerTextDrawLetterSize(i, GameCars[i][1], 0.400000, 1.600000);
PlayerTextDrawAlignment(i, GameCars[i][1], 1);
PlayerTextDrawColor(i, GameCars[i][1], 255);
PlayerTextDrawSetShadow(i, GameCars[i][1], 0);
PlayerTextDrawBackgroundColor(i, GameCars[i][1], 255);
PlayerTextDrawFont(i, GameCars[i][1], 1);
PlayerTextDrawSetProportional(i, GameCars[i][1], 1);

GameCarShop[i][0] = CreatePlayerTextDraw(i, 160.333328, 298.525939, "LD_OTB2:butnAo");
PlayerTextDrawTextSize(i, GameCarShop[i][0], 80.000000, 37.000000);
PlayerTextDrawAlignment(i, GameCarShop[i][0], 1);
PlayerTextDrawColor(i, GameCarShop[i][0], -5963521);
PlayerTextDrawSetShadow(i, GameCarShop[i][0], 0);
PlayerTextDrawBackgroundColor(i, GameCarShop[i][0], 255);
PlayerTextDrawFont(i, GameCarShop[i][0], 4);
PlayerTextDrawSetProportional(i, GameCarShop[i][0], 0);
PlayerTextDrawSetSelectable(i, GameCarShop[i][0], true);

GameCarShop[i][1] = CreatePlayerTextDraw(i, 185.000030, 303.659301, "Shop");
PlayerTextDrawLetterSize(i, GameCarShop[i][1], 0.400000, 1.600000);
PlayerTextDrawAlignment(i, GameCarShop[i][1], 1);
PlayerTextDrawColor(i, GameCarShop[i][1], 255);
PlayerTextDrawSetShadow(i, GameCarShop[i][1], 0);
PlayerTextDrawBackgroundColor(i, GameCarShop[i][1], 255);
PlayerTextDrawFont(i, GameCarShop[i][1], 1);
PlayerTextDrawSetProportional(i, GameCarShop[i][1], 1);

GameCarPlay[i][0] = CreatePlayerTextDraw(i, 367.333587, 299.770385, "LD_OTB2:butnAo");
PlayerTextDrawTextSize(i, GameCarPlay[i][0], 80.000000, 37.000000);
PlayerTextDrawAlignment(i, GameCarPlay[i][0], 1);
PlayerTextDrawColor(i, GameCarPlay[i][0], -5963521);
PlayerTextDrawSetShadow(i, GameCarPlay[i][0], 0);
PlayerTextDrawBackgroundColor(i, GameCarPlay[i][0], 255);
PlayerTextDrawFont(i, GameCarPlay[i][0], 4);
PlayerTextDrawSetProportional(i, GameCarPlay[i][0], 0);
PlayerTextDrawSetSelectable(i, GameCarPlay[i][0], true);

GameCarPlay[i][1] = CreatePlayerTextDraw(i, 395.000152, 304.074127, "Play");
PlayerTextDrawLetterSize(i, GameCarPlay[i][1], 0.400000, 1.600000);
PlayerTextDrawAlignment(i, GameCarPlay[i][1], 1);
PlayerTextDrawColor(i, GameCarPlay[i][1], 255);
PlayerTextDrawSetShadow(i, GameCarPlay[i][1], 0);
PlayerTextDrawBackgroundColor(i, GameCarPlay[i][1], 255);
PlayerTextDrawFont(i, GameCarPlay[i][1], 1);
PlayerTextDrawSetProportional(i, GameCarPlay[i][1], 1);

GameRoad[i] = CreatePlayerTextDraw(i, 251.333465, 63.740711, "");
PlayerTextDrawTextSize(i, GameRoad[i], 99.000000, 285.000000);
PlayerTextDrawAlignment(i, GameRoad[i], 1);
PlayerTextDrawColor(i, GameRoad[i], -1);
PlayerTextDrawSetShadow(i, GameRoad[i], 0);
PlayerTextDrawBackgroundColor(i, GameRoad[i], 0);
PlayerTextDrawFont(i, GameRoad[i], 5);
PlayerTextDrawSetProportional(i, GameRoad[i], 0);
PlayerTextDrawSetPreviewModel(i, GameRoad[i], 8045);
PlayerTextDrawSetPreviewRot(i, GameRoad[i], 90.000000, 0.000000, 0.000000, 0.600000);

GamePlayerCar[i] = CreatePlayerTextDraw(i, 282.666992, 294.792755, "");
PlayerTextDrawTextSize(i, GamePlayerCar[i], 36.000000, 36.000000);
PlayerTextDrawColor(i, GamePlayerCar[i], -1);
PlayerTextDrawFont(i, GamePlayerCar[i], 5);
PlayerTextDrawBackgroundColor(i, GamePlayerCar[i], 0);
PlayerTextDrawSetPreviewModel(i, GamePlayerCar[i], PlayerGameCarModel[playerid]);
PlayerTextDrawSetPreviewRot(i, GamePlayerCar[i], -90.000000, 0.000000, 180.000000, 0.899999);
PlayerTextDrawSetPreviewVehCol(i, GamePlayerCar[i], 1, 1);

GameCarLeft1[i] = CreatePlayerTextDraw(i, 258.667236, 41.755973, "");
PlayerTextDrawTextSize(i, GameCarLeft1[i], 36.000000, 36.000000);
PlayerTextDrawAlignment(i, GameCarLeft1[i], 1);
PlayerTextDrawColor(i, GameCarLeft1[i], -1);
PlayerTextDrawSetShadow(i, GameCarLeft1[i], 0);
PlayerTextDrawBackgroundColor(i, GameCarLeft1[i], 0);
PlayerTextDrawFont(i, GameCarLeft1[i], 5);
PlayerTextDrawSetProportional(i, GameCarLeft1[i], 0);
PlayerTextDrawSetPreviewModel(i, GameCarLeft1[i], 600);
PlayerTextDrawSetPreviewRot(i, GameCarLeft1[i], -90.000000, 0.000000, 0.000000, 0.899999);
PlayerTextDrawSetPreviewVehCol(i, GameCarLeft1[i], 1, 1);

GameCarLeft2[i] = CreatePlayerTextDraw(i, 271.667236, 42.170738, "");
PlayerTextDrawTextSize(i, GameCarLeft2[i], 36.000000, 36.000000);
PlayerTextDrawAlignment(i, GameCarLeft2[i], 1);
PlayerTextDrawColor(i, GameCarLeft2[i], -1);
PlayerTextDrawSetShadow(i, GameCarLeft2[i], 0);
PlayerTextDrawBackgroundColor(i, GameCarLeft2[i], 0);
PlayerTextDrawFont(i, GameCarLeft2[i], 5);
PlayerTextDrawSetProportional(i, GameCarLeft2[i], 0);
PlayerTextDrawSetPreviewModel(i, GameCarLeft2[i], 600);
PlayerTextDrawSetPreviewRot(i, GameCarLeft2[i], -90.000000, 0.000000, 0.000000, 0.899999);
PlayerTextDrawSetPreviewVehCol(i, GameCarLeft2[i], 1, 1);

GameCarRight1[i] = CreatePlayerTextDraw(i, 294.667572, 42.170684, "");
PlayerTextDrawTextSize(i, GameCarRight1[i], 36.000000, 36.000000);
PlayerTextDrawAlignment(i, GameCarRight1[i], 1);
PlayerTextDrawColor(i, GameCarRight1[i], -1);
PlayerTextDrawSetShadow(i, GameCarRight1[i], 0);
PlayerTextDrawBackgroundColor(i, GameCarRight1[i], 0);
PlayerTextDrawFont(i, GameCarRight1[i], 5);
PlayerTextDrawSetProportional(i, GameCarRight1[i], 0);
PlayerTextDrawSetPreviewModel(i, GameCarRight1[i], 404);
PlayerTextDrawSetPreviewRot(i, GameCarRight1[i], -90.000000, 0.000000, 180.000000, 0.899999);
PlayerTextDrawSetPreviewVehCol(i, GameCarRight1[i], 1, 1);

GameCarRight2[i] = CreatePlayerTextDraw(i, 308.000671, 42.170921, "");
PlayerTextDrawTextSize(i, GameCarRight2[i], 36.000000, 36.000000);
PlayerTextDrawAlignment(i, GameCarRight2[i], 1);
PlayerTextDrawColor(i, GameCarRight2[i], -1);
PlayerTextDrawSetShadow(i, GameCarRight2[i], 0);
PlayerTextDrawBackgroundColor(i, GameCarRight2[i], 0);
PlayerTextDrawFont(i, GameCarRight2[i], 5);
PlayerTextDrawSetProportional(i, GameCarRight2[i], 0);
PlayerTextDrawSetPreviewModel(i, GameCarRight2[i], 404);
PlayerTextDrawSetPreviewRot(i, GameCarRight2[i], -90.000000, 0.000000, 180.000000, 0.899999);
PlayerTextDrawSetPreviewVehCol(i, GameCarRight2[i], 1, 1);

CarDriveHUD[i][0] = CreatePlayerTextDraw(playerid, 243.666732, 59.177787, "LD_SPAC:white");
PlayerTextDrawTextSize(playerid, CarDriveHUD[i][0], 115.000000, 24.000000);
PlayerTextDrawAlignment(playerid, CarDriveHUD[i][0], 1);
PlayerTextDrawColor(playerid, CarDriveHUD[i][0], -5963521);
PlayerTextDrawSetShadow(playerid, CarDriveHUD[i][0], 0);
PlayerTextDrawBackgroundColor(playerid, CarDriveHUD[i][0], 255);
PlayerTextDrawFont(playerid, CarDriveHUD[i][0], 4);
PlayerTextDrawSetProportional(playerid, CarDriveHUD[i][0], 0);

CarDriveHUD[i][1] = CreatePlayerTextDraw(playerid, 245.666656, 330.051849, "LD_SPAC:white");
PlayerTextDrawTextSize(playerid, CarDriveHUD[i][1], 115.000000, 21.000000);
PlayerTextDrawAlignment(playerid, CarDriveHUD[i][1], 1);
PlayerTextDrawColor(playerid, CarDriveHUD[i][1], -5963521);
PlayerTextDrawSetShadow(playerid, CarDriveHUD[i][1], 0);
PlayerTextDrawBackgroundColor(playerid, CarDriveHUD[i][1], 255);
PlayerTextDrawFont(playerid, CarDriveHUD[i][1], 4);
PlayerTextDrawSetProportional(playerid, CarDriveHUD[i][1], 0);

CarDriveHUD[i][2] = CreatePlayerTextDraw(playerid, 300.666473, 333.526031, "Distance:_123456789");
PlayerTextDrawLetterSize(playerid, CarDriveHUD[i][2], 0.221333, 1.230814);
PlayerTextDrawAlignment(playerid, CarDriveHUD[i][2], 2);
PlayerTextDrawColor(playerid, CarDriveHUD[i][2], 255);
PlayerTextDrawSetShadow(playerid, CarDriveHUD[i][2], 0);
PlayerTextDrawBackgroundColor(playerid, CarDriveHUD[i][2], 255);
PlayerTextDrawFont(playerid, CarDriveHUD[i][2], 1);
PlayerTextDrawSetProportional(playerid, CarDriveHUD[i][2], 1);

CarDriveHUD[i][3] = CreatePlayerTextDraw(playerid, 302.666503, 65.140800, "Points:_123456789");
PlayerTextDrawLetterSize(playerid, CarDriveHUD[i][3], 0.221333, 1.230814);
PlayerTextDrawAlignment(playerid, CarDriveHUD[i][3], 2);
PlayerTextDrawColor(playerid, CarDriveHUD[i][3], 255);
PlayerTextDrawSetShadow(playerid, CarDriveHUD[i][3], 0);
PlayerTextDrawBackgroundColor(playerid, CarDriveHUD[i][3], 255);
PlayerTextDrawFont(playerid, CarDriveHUD[i][3], 1);
PlayerTextDrawSetProportional(playerid, CarDriveHUD[i][3], 1);

CarCrashExplosion[i] = CreatePlayerTextDraw(i, 286.000000, 291.473999, "LD_NONE:explm01");
PlayerTextDrawTextSize(i, CarCrashExplosion[i], 33.000000, 36.000000);
PlayerTextDrawAlignment(i, CarCrashExplosion[i], 1);
PlayerTextDrawColor(i, CarCrashExplosion[i], -1);
PlayerTextDrawSetShadow(i, CarCrashExplosion[i], 0);
PlayerTextDrawBackgroundColor(i, CarCrashExplosion[i], 255);
PlayerTextDrawFont(i, CarCrashExplosion[i], 4);
PlayerTextDrawSetProportional(i, CarCrashExplosion[i], 0);

CarGameBuyCar[i][1] = CreatePlayerTextDraw(playerid, 235.333251, 313.044555, "LD_SPAC:white");
PlayerTextDrawTextSize(playerid, CarGameBuyCar[i][1], 139.000000, 37.000000);
PlayerTextDrawAlignment(playerid, CarGameBuyCar[i][1], 1);
PlayerTextDrawColor(playerid, CarGameBuyCar[i][1], -5963521);
PlayerTextDrawSetShadow(playerid, CarGameBuyCar[i][1], 0);
PlayerTextDrawBackgroundColor(playerid, CarGameBuyCar[i][1], 255);
PlayerTextDrawFont(playerid, CarGameBuyCar[i][1], 4);
PlayerTextDrawSetProportional(playerid, CarGameBuyCar[i][1], 0);
PlayerTextDrawSetSelectable(playerid, CarGameBuyCar[i][1], true);

CarGameBuyCar[i][2] = CreatePlayerTextDraw(playerid, 305.333618, 321.496246, "Vehicle_Name");
PlayerTextDrawLetterSize(playerid, CarGameBuyCar[i][2], 0.382333, 1.570962);
PlayerTextDrawAlignment(playerid, CarGameBuyCar[i][2], 2);
PlayerTextDrawColor(playerid, CarGameBuyCar[i][2], 255);
PlayerTextDrawSetShadow(playerid, CarGameBuyCar[i][2], 0);
PlayerTextDrawBackgroundColor(playerid, CarGameBuyCar[i][2], 255);
PlayerTextDrawFont(playerid, CarGameBuyCar[i][2], 1);
PlayerTextDrawSetProportional(playerid, CarGameBuyCar[i][2], 1);

CarGameBuyCar[i][3] = CreatePlayerTextDraw(playerid, 211.666824, 122.229591, "");
PlayerTextDrawTextSize(playerid, CarGameBuyCar[i][3], 179.000000, 170.000000);
PlayerTextDrawAlignment(playerid, CarGameBuyCar[i][3], 1);
PlayerTextDrawColor(playerid, CarGameBuyCar[i][3], -1);
PlayerTextDrawBackgroundColor(playerid, CarGameBuyCar[i][3], PlayerGameCarModel[playerid]);
PlayerTextDrawSetShadow(playerid, CarGameBuyCar[i][3], 0);
PlayerTextDrawFont(playerid, CarGameBuyCar[i][3], 5);
PlayerTextDrawSetProportional(playerid, CarGameBuyCar[i][3], 0);
PlayerTextDrawSetPreviewModel(playerid, CarGameBuyCar[i][3], 478);
PlayerTextDrawSetPreviewRot(playerid, CarGameBuyCar[i][3], -22.000000, 0.000000, 45.000000, 0.850000);
PlayerTextDrawSetPreviewVehCol(playerid, CarGameBuyCar[i][3], 1, 1);

CarGameBuyCar[i][4] = CreatePlayerTextDraw(playerid, 382.000091, 322.585235, "LD_BEAT:right");
PlayerTextDrawTextSize(playerid, CarGameBuyCar[i][4], 21.000000, 17.000000);
PlayerTextDrawAlignment(playerid, CarGameBuyCar[i][4], 1);
PlayerTextDrawColor(playerid, CarGameBuyCar[i][4], -1);
PlayerTextDrawSetShadow(playerid, CarGameBuyCar[i][4], 0);
PlayerTextDrawBackgroundColor(playerid, CarGameBuyCar[i][4], 255);
PlayerTextDrawFont(playerid, CarGameBuyCar[i][4], 4);
PlayerTextDrawSetProportional(playerid, CarGameBuyCar[i][4], 0);
PlayerTextDrawSetSelectable(playerid, CarGameBuyCar[i][4], true);

CarGameBuyCar[i][5] = CreatePlayerTextDraw(playerid, 208.666824, 323.000061, "LD_BEAT:left");
PlayerTextDrawTextSize(playerid, CarGameBuyCar[i][5], 21.000000, 17.000000);
PlayerTextDrawAlignment(playerid, CarGameBuyCar[i][5], 1);
PlayerTextDrawColor(playerid, CarGameBuyCar[i][5], -1);
PlayerTextDrawSetShadow(playerid, CarGameBuyCar[i][5], 0);
PlayerTextDrawBackgroundColor(playerid, CarGameBuyCar[i][5], 255);
PlayerTextDrawFont(playerid, CarGameBuyCar[i][5], 4);
PlayerTextDrawSetProportional(playerid, CarGameBuyCar[i][5], 0);
PlayerTextDrawSetSelectable(playerid, CarGameBuyCar[i][5], true);

CarGameBuyCar[i][6] = CreatePlayerTextDraw(playerid, 299.333435, 202.444458, "Buy_this_car_for_1500$");
PlayerTextDrawLetterSize(playerid, CarGameBuyCar[i][6], 0.265666, 1.380147);
PlayerTextDrawAlignment(playerid, CarGameBuyCar[i][6], 2);
PlayerTextDrawColor(playerid, CarGameBuyCar[i][6], 255);
PlayerTextDrawSetShadow(playerid, CarGameBuyCar[i][6], 0);
PlayerTextDrawBackgroundColor(playerid, CarGameBuyCar[i][6], 255);
PlayerTextDrawFont(playerid, CarGameBuyCar[i][6], 1);
PlayerTextDrawSetProportional(playerid, CarGameBuyCar[i][6], 1);

CarGameBuyCar[i][0] = CreatePlayerTextDraw(playerid, 243.333206, 197.725952, "LD_SPAC:white");
PlayerTextDrawTextSize(playerid, CarGameBuyCar[i][0], 114.000000, 24.000000);
PlayerTextDrawAlignment(playerid, CarGameBuyCar[i][0], 1);
PlayerTextDrawColor(playerid, CarGameBuyCar[i][0], -5963521);
PlayerTextDrawSetShadow(playerid, CarGameBuyCar[i][0], 0);
PlayerTextDrawBackgroundColor(playerid, CarGameBuyCar[i][0], 255);
PlayerTextDrawFont(playerid, CarGameBuyCar[i][0], 4);
PlayerTextDrawSetProportional(playerid, CarGameBuyCar[i][0], 0);
PlayerTextDrawSetSelectable(playerid, CarGameBuyCar[i][0], true);

CarGameShopMenu[i][0] = CreatePlayerTextDraw(i, 224.666625, 132.185165, "LD_SPAC:white");
PlayerTextDrawTextSize(i, CarGameShopMenu[i][0], 166.000000, 29.000000);
PlayerTextDrawAlignment(i, CarGameShopMenu[i][0], 1);
PlayerTextDrawColor(i, CarGameShopMenu[i][0], -1);
PlayerTextDrawSetShadow(i, CarGameShopMenu[i][0], 0);
PlayerTextDrawBackgroundColor(i, CarGameShopMenu[i][0], 255);
PlayerTextDrawFont(i, CarGameShopMenu[i][0], 4);
PlayerTextDrawSetProportional(i, CarGameShopMenu[i][0], 0);
PlayerTextDrawSetSelectable(i, CarGameShopMenu[i][0], true);

CarGameShopMenu[i][1] = CreatePlayerTextDraw(i, 307.699157, 138.977767, "Points_to_Money");
PlayerTextDrawLetterSize(i, CarGameShopMenu[i][1], 0.400000, 1.600000);
PlayerTextDrawAlignment(i, CarGameShopMenu[i][1], 2);
PlayerTextDrawColor(i, CarGameShopMenu[i][1], 255);
PlayerTextDrawSetShadow(i, CarGameShopMenu[i][1], 0);
PlayerTextDrawBackgroundColor(i, CarGameShopMenu[i][1], 255);
PlayerTextDrawFont(i, CarGameShopMenu[i][1], 1);
PlayerTextDrawSetProportional(i, CarGameShopMenu[i][1], 1);

CarGameShopMenu[i][2] = CreatePlayerTextDraw(i, 224.666625, 192.184249, "LD_SPAC:white");
PlayerTextDrawTextSize(i, CarGameShopMenu[i][2], 166.000000, 29.000000);
PlayerTextDrawAlignment(i, CarGameShopMenu[i][2], 1);
PlayerTextDrawColor(i, CarGameShopMenu[i][2], -1);
PlayerTextDrawSetShadow(i, CarGameShopMenu[i][2], 0);
PlayerTextDrawBackgroundColor(i, CarGameShopMenu[i][2], 255);
PlayerTextDrawFont(i, CarGameShopMenu[i][2], 4);
PlayerTextDrawSetProportional(i, CarGameShopMenu[i][2], 0);
PlayerTextDrawSetSelectable(i, CarGameShopMenu[i][2], true);

CarGameShopMenu[i][3] = CreatePlayerTextDraw(i, 307.699157, 198.976870, "Money_to_Points");
PlayerTextDrawLetterSize(i, CarGameShopMenu[i][3], 0.400000, 1.600000);
PlayerTextDrawAlignment(i, CarGameShopMenu[i][3], 2);
PlayerTextDrawColor(i, CarGameShopMenu[i][3], 255);
PlayerTextDrawSetShadow(i, CarGameShopMenu[i][3], 0);
PlayerTextDrawBackgroundColor(i, CarGameShopMenu[i][3], 255);
PlayerTextDrawFont(i, CarGameShopMenu[i][3], 1);
PlayerTextDrawSetProportional(i, CarGameShopMenu[i][3], 1);

CarGameShopMenu[i][4] = CreatePlayerTextDraw(i, 224.666625, 252.184249, "LD_SPAC:white");
PlayerTextDrawTextSize(i, CarGameShopMenu[i][4], 166.000000, 29.000000);
PlayerTextDrawAlignment(i, CarGameShopMenu[i][4], 1);
PlayerTextDrawColor(i, CarGameShopMenu[i][4], -1);
PlayerTextDrawSetShadow(i, CarGameShopMenu[i][4], 0);
PlayerTextDrawBackgroundColor(i, CarGameShopMenu[i][4], 255);
PlayerTextDrawFont(i, CarGameShopMenu[i][4], 4);
PlayerTextDrawSetProportional(i, CarGameShopMenu[i][4], 0);
PlayerTextDrawSetSelectable(i, CarGameShopMenu[i][4], true);

CarGameShopMenu[i][5] = CreatePlayerTextDraw(i, 307.699157, 258.976870, "Money_to_$");
PlayerTextDrawLetterSize(i, CarGameShopMenu[i][5], 0.400000, 1.600000);
PlayerTextDrawAlignment(i, CarGameShopMenu[i][5], 2);
PlayerTextDrawColor(i, CarGameShopMenu[i][5], 255);
PlayerTextDrawSetShadow(i, CarGameShopMenu[i][5], 0);
PlayerTextDrawBackgroundColor(i, CarGameShopMenu[i][5], 255);
PlayerTextDrawFont(i, CarGameShopMenu[i][5], 1);
PlayerTextDrawSetProportional(i, CarGameShopMenu[i][5], 1);

GameCarColorMenu[i][0] = CreatePlayerTextDraw(playerid, 235.333251, 61.844207, "LD_SPAC:white");
PlayerTextDrawTextSize(playerid, GameCarColorMenu[i][0], 139.000000, 37.000000);
PlayerTextDrawAlignment(playerid, GameCarColorMenu[i][0], 1);
PlayerTextDrawColor(playerid, GameCarColorMenu[i][0], -5963521);
PlayerTextDrawSetShadow(playerid, GameCarColorMenu[i][0], 0);
PlayerTextDrawBackgroundColor(playerid, GameCarColorMenu[i][0], 255);
PlayerTextDrawFont(playerid, GameCarColorMenu[i][0], 4);
PlayerTextDrawSetProportional(playerid, GameCarColorMenu[i][0], 0);
PlayerTextDrawSetSelectable(i, GameCarColorMenu[i][0], true);

GameCarColorMenu[i][1] = CreatePlayerTextDraw(playerid, 305.333618, 71.795501, "Color");
PlayerTextDrawLetterSize(playerid, GameCarColorMenu[i][1], 0.382333, 1.570960);
PlayerTextDrawAlignment(playerid, GameCarColorMenu[i][1], 2);
PlayerTextDrawColor(playerid, GameCarColorMenu[i][1], 255);
PlayerTextDrawSetShadow(playerid, GameCarColorMenu[i][1], 0);
PlayerTextDrawBackgroundColor(playerid, GameCarColorMenu[i][1], 255);
PlayerTextDrawFont(playerid, GameCarColorMenu[i][1], 1);
PlayerTextDrawSetProportional(playerid, GameCarColorMenu[i][1], 1);


Bildschirm[i][0] = CreatePlayerTextDraw(i, 147.000030, 37.607418, "LD_SPAC:white");
PlayerTextDrawTextSize(i, Bildschirm[i][0], 314.000000, 25.000000);
PlayerTextDrawAlignment(i, Bildschirm[i][0], 1);
PlayerTextDrawColor(i, Bildschirm[i][0], -1);
PlayerTextDrawSetShadow(i, Bildschirm[i][0], 0);
PlayerTextDrawBackgroundColor(i, Bildschirm[i][0], 255);
PlayerTextDrawFont(i, Bildschirm[i][0], 4);
PlayerTextDrawSetProportional(i, Bildschirm[i][0], 0);

Bildschirm[i][1] = CreatePlayerTextDraw(i, 131.300048, 345.807708, "LD_SPAC:white");
PlayerTextDrawTextSize(i, Bildschirm[i][1], 345.6000000, 29.000000);
PlayerTextDrawAlignment(i, Bildschirm[i][1], 1);
PlayerTextDrawColor(i, Bildschirm[i][1], -1);
PlayerTextDrawSetShadow(i, Bildschirm[i][1], 0);
PlayerTextDrawBackgroundColor(i, Bildschirm[i][1], 255);
PlayerTextDrawFont(i, Bildschirm[i][1], 4);
PlayerTextDrawSetProportional(i, Bildschirm[i][1], 0);

Bildschirm[i][2] = CreatePlayerTextDraw(i, 157.500030, 37.607418, "LD_SPAC:white");
PlayerTextDrawTextSize(i, Bildschirm[i][2], -26.140434, 320.250091);
PlayerTextDrawAlignment(i, Bildschirm[i][2], 1);
PlayerTextDrawColor(i, Bildschirm[i][2], -1);
PlayerTextDrawSetShadow(i, Bildschirm[i][2], 0);
PlayerTextDrawBackgroundColor(i, Bildschirm[i][2], 255);
PlayerTextDrawFont(i, Bildschirm[i][2], 4);
PlayerTextDrawSetProportional(i, Bildschirm[i][2], 0);

Bildschirm[i][3] = CreatePlayerTextDraw(i, 476.935028, 37.607418, "LD_SPAC:white");
PlayerTextDrawTextSize(i, Bildschirm[i][3], -26.140434, 320.250091);
PlayerTextDrawAlignment(i, Bildschirm[i][3], 1);
PlayerTextDrawColor(i, Bildschirm[i][3], -1);
PlayerTextDrawSetShadow(i, Bildschirm[i][3], 0);
PlayerTextDrawBackgroundColor(i, Bildschirm[i][3], 255);
PlayerTextDrawFont(i, Bildschirm[i][3], 4);
PlayerTextDrawSetProportional(i, Bildschirm[i][3], 0);
}
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	new ccmd[256+1], idxx;
	ccmd = strtok(cmdtext, idxx);
	new ttmp[256+1];
	new string[20];
    if(strcmp(ccmd, "/timer", true) == 0)
	{
		  ttmp = strtok(cmdtext, idxx);
		  if(strlen(ttmp) == 0) return SendClientMessage(playerid, Hellrot, "/timer time");
		  SetPVarInt(playerid, "CarGameCarSpeed", strval(ttmp));
		  format(string, sizeof string, "Timer: %i", strval(ttmp));
		  DebugMessage(playerid, string);
	}
    if(strcmp(ccmd, "/money", true) == 0)
	{
		  ttmp = strtok(cmdtext, idxx);
		  PlayerCarGameMoney[playerid] = PlayerCarGameMoney[playerid] + strval(ttmp);
		  format(string, sizeof string, "%i$", PlayerCarGameMoney[playerid]);
		  DebugMessage(playerid, string);
	}
    if(strcmp(ccmd, "/state", true) == 0)
	{
		  format(string, sizeof string, "%i", GetPVarInt(playerid, "CarGame"));
		  DebugMessage(playerid, string);
	}
	return 0;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if(newkeys == KEY_WALK)
    {
        if(GetPVarInt(playerid, "comp") == 0)
		{
		   TogglePlayerControllable(playerid, 0);
		   PlayerTextDrawShow(playerid, CarGameBackGround[playerid]);
		   PlayerTextDrawShow(playerid, CarGameLoadScreen[playerid][0]);
		   PlayerTextDrawShow(playerid, CarGameLoadScreen[playerid][1]);
		   PlayerTextDrawShow(playerid, CarGameLoadScreen[playerid][2]);
		   PlayerTextDrawShow(playerid, CarGameLoadScreen[playerid][3]);
		   PlayerTextDrawShow(playerid, CarGameLoadScreen[playerid][4]);

		   PlayerTextDrawShow(playerid, Bildschirm[playerid][0]);
		   PlayerTextDrawShow(playerid, Bildschirm[playerid][1]);
		   PlayerTextDrawShow(playerid, Bildschirm[playerid][2]);
		   PlayerTextDrawShow(playerid, Bildschirm[playerid][3]);

		   CarGameLoadTimer = SetTimerEx("CompCarGameTimer", 125, true, "%i", playerid);
		   SelectTextDraw(playerid, TextdrawFarbe);
		   SetPVarInt(playerid, "comp", 1);
		   return 1;
		}
    }
    return 1;
}

forward CompCarGameTimer(i);
public CompCarGameTimer(i)
{
if (GetPVarInt(i, "CarGame") == 0)
{
  GameSecondsCount[i] ++;
  if(GameSecondsCount[i] == 4)
  {
     PlayerTextDrawSetString(i, CarGameLoadScreen[i][2], "Highway_Racer~n~Loading.");
  }
  if(GameSecondsCount[i] == 8)
  {
     PlayerTextDrawSetString(i, CarGameLoadScreen[i][2], "Highway_Racer~n~Loading..");
  }
  if(GameSecondsCount[i] == 12)
  {
     PlayerTextDrawSetString(i, CarGameLoadScreen[i][2], "Highway_Racer~n~Loading...");
  }
  if(GameSecondsCount[i] == 16)
  {
     PlayerTextDrawSetString(i, CarGameLoadScreen[i][2], "Highway_Racer~n~Loading");
  }
  if(GameSecondsCount[i] == 20)
  {
     PlayerTextDrawSetString(i, CarGameLoadScreen[i][2], "Highway_Racer~n~Loading.");
  }
  if(GameSecondsCount[i] == 24)
  {
     PlayerTextDrawSetString(i, CarGameLoadScreen[i][2], "Highway_Racer~n~Loading..");
  }
  if(GameSecondsCount[i] == 28)
  {
     PlayerTextDrawSetString(i, CarGameLoadScreen[i][2], "Highway_Racer~n~Loading...");
  }
  if(GameSecondsCount[i] == 32)
  {
     PlayerTextDrawSetString(i, CarGameLoadScreen[i][2], "Highway_Racer~n~Loading");
  }
  if(GameSecondsCount[i] == 36)
  {
     PlayerTextDrawSetString(i, CarGameLoadScreen[i][2], "Highway_Racer~n~Loading.");
  }
  if(GameSecondsCount[i] == 40)
  {
     PlayerTextDrawSetString(i, CarGameLoadScreen[i][2], "Highway_Racer~n~Loading..");
  }
  if(GameSecondsCount[i] == 44)
  {
     PlayerTextDrawSetString(i, CarGameLoadScreen[i][2], "Highway_Racer~n~Loading...");
  }
  if(GameSecondsCount[i] == 48)
  {
     //KillTimer(CarGameLoadTimer);
	 new Spieler[64];
	 format(Spieler, sizeof(Spieler), "Spieler/%s.txt", GetSname(i));
	 PlayerCarGamePoints[i] = dini_Int(Spieler, "CompAutoSpielPunkte");
	 PlayerCarGameMoney[i] = dini_Int(Spieler, "CompAutoSpielGeld");
     PlayerTextDrawHide(i, CarGameLoadScreen[i][0]);
     PlayerTextDrawHide(i, CarGameLoadScreen[i][1]);
     PlayerTextDrawHide(i, CarGameLoadScreen[i][2]);
     PlayerTextDrawHide(i, CarGameLoadScreen[i][3]);
     PlayerTextDrawHide(i, CarGameLoadScreen[i][4]);
     PlayerTextDrawShow(i, CarGameMenu[i][0]);
     PlayerTextDrawShow(i, CarGameMenu[i][1]);
	 PlayerTextDrawShow(i, CarGameMenu[i][2]);
     PlayerTextDrawShow(i, CarGameMenu[i][3]);
     PlayerTextDrawShow(i, CarGameMenu[i][4]);
     new string[17];
     format(string, sizeof string, "Points:_%i", PlayerCarGamePoints[i]);
     PlayerTextDrawSetString(i, CarGameMenu[i][4], string);
     format(string, sizeof string, "Money:_%i", PlayerCarGameMoney[i]);
     PlayerTextDrawSetString(i, CarGameMenu[i][3], string);
     PlayerTextDrawShow(i, CarGameMenu[i][5]);
	 PlayerTextDrawShow(i, CarGameMenu[i][6]);
	 PlayerTextDrawShow(i, LeaveCarGame[i]);
	 PlayerTextDrawShow(i, LeaveCarGameX[i]);
     PlayerTextDrawShow(i, GameCarShop[i][0]);
     PlayerTextDrawShow(i, GameCarShop[i][1]);
     PlayerTextDrawShow(i, GameCars[i][0]);
     PlayerTextDrawShow(i, GameCars[i][1]);
     PlayerTextDrawShow(i, GameCarPlay[i][0]);
     PlayerTextDrawShow(i, GameCarPlay[i][1]);
     GameSecondsCount[i] = 0;
	 SetPVarInt(i, "CarGame", 1);
  }
}
else if (GetPVarInt(i, "CarGame") == 1)
{
  GameSecondsCount[i] ++;
  PlayerTextDrawSetPreviewModel(i, CarGameMenu[i][6], PlayerGameCarModel[i]);
  PlayerTextDrawSetPreviewVehCol(i, CarGameMenu[i][6], GamePlayerCarColor[i], GamePlayerCarColor[i]);
  PlayerTextDrawSetPreviewRot(i, CarGameMenu[i][5], -20, 0.000000, -GameSecondsCount[i]*3, 1.000000);
  PlayerTextDrawSetPreviewRot(i, CarGameMenu[i][6], -20, 0.000000, -GameSecondsCount[i]*3, 1.000000);
  PlayerTextDrawShow(i, CarGameMenu[i][5]);
  PlayerTextDrawShow(i, CarGameMenu[i][6]);
  new string[50];
  format(string, sizeof string, "%i", GamePlayerCarColor[i]);
  DebugMessage(i, string);
  return 1;
}
else if (GetPVarInt(i, "CarGame") == 4)
{
   if(GameCar1Created[i] == 1)
   {
       GameCar1Pos[i] ++;
       PlayerTextDrawDestroy(i, GameCarLeft1[i]);
       GameCarLeft1[i] = CreatePlayerTextDraw(i, 271.667236, 37.0+/*15*/GetPVarInt(i, "CarGameCarSpeed")*GameCar1Pos[i], "");
       PlayerTextDrawTextSize(i, GameCarLeft1[i], 36.000000, 36.000000);
       PlayerTextDrawColor(i, GameCarLeft1[i], -1);
       PlayerTextDrawBackgroundColor(i, GameCarLeft1[i], 0);
       PlayerTextDrawFont(i, GameCarLeft1[i], 5);
       PlayerTextDrawSetPreviewModel(i, GameCarLeft1[i], GameCar1[i]);
       PlayerTextDrawSetPreviewRot(i, GameCarLeft1[i], -90.000000, 0.000000, 0.000000, 0.899999);
       PlayerTextDrawSetPreviewVehCol(i, GameCarLeft1[i], GameCar1C[i], GameCar1C[i]);
       PlayerTextDrawShow(i, PlayerText:GameCarLeft1[i]);
   }
   if(GameCar2Created[i] == 1)
   {
       GameCar2Pos[i] ++;
       PlayerTextDrawDestroy(i, GameCarLeft2[i]);
       GameCarLeft2[i] = CreatePlayerTextDraw(i, 258.667236, 37.0+/*15*/GetPVarInt(i, "CarGameCarSpeed")*GameCar2Pos[i], "");
       PlayerTextDrawTextSize(i, GameCarLeft2[i], 36.000000, 36.000000);
       PlayerTextDrawColor(i, GameCarLeft2[i], -1);
       PlayerTextDrawBackgroundColor(i, GameCarLeft2[i], 0);
       PlayerTextDrawFont(i, GameCarLeft2[i], 5);
       PlayerTextDrawSetPreviewModel(i, GameCarLeft2[i], GameCar2[i]);
       PlayerTextDrawSetPreviewRot(i, GameCarLeft2[i], -90.000000, 0.000000, 0.000000, 0.899999);
       PlayerTextDrawSetPreviewVehCol(i, GameCarLeft2[i], GameCar2C[i], GameCar2C[i]);
       PlayerTextDrawShow(i, PlayerText:GameCarLeft2[i]);
   }
   if(GameCar3Created[i] == 1)
   {
       GameCar3Pos[i] ++;
       PlayerTextDrawDestroy(i, GameCarRight1[i]);
       GameCarRight1[i] = CreatePlayerTextDraw(i, 294.667572, 37.0+/*15*/GetPVarInt(i, "CarGameCarSpeed")*GameCar3Pos[i], "");
       PlayerTextDrawTextSize(i, GameCarRight1[i], 36.000000, 36.000000);
       PlayerTextDrawColor(i, GameCarRight1[i], -1);
       PlayerTextDrawBackgroundColor(i, GameCarRight1[i], 0);
       PlayerTextDrawFont(i, GameCarRight1[i], 5);
       PlayerTextDrawSetPreviewModel(i, GameCarRight1[i], GameCar3[i]);
       PlayerTextDrawSetPreviewRot(i, GameCarRight1[i], -90.000000, 0.000000, 0.000000, 0.899999);
       PlayerTextDrawSetPreviewVehCol(i, GameCarRight1[i], GameCar3C[i], GameCar3C[i]);
       PlayerTextDrawShow(i, PlayerText:GameCarRight1[i]);
   }
   if(GameCar4Created[i] == 1)
   {
       GameCar4Pos[i] ++;
       PlayerTextDrawDestroy(i, GameCarRight2[i]);
       GameCarRight2[i] = CreatePlayerTextDraw(i, 308.000671, 37.0+/*15*/GetPVarInt(i, "CarGameCarSpeed")*GameCar4Pos[i], "");
       PlayerTextDrawTextSize(i, GameCarRight2[i], 36.000000, 36.000000);
       PlayerTextDrawColor(i, GameCarRight2[i], -1);
       PlayerTextDrawBackgroundColor(i, GameCarRight2[i], 0);
       PlayerTextDrawFont(i, GameCarRight2[i], 5);
       PlayerTextDrawSetPreviewModel(i, GameCarRight2[i], GameCar4[i]);
       PlayerTextDrawSetPreviewRot(i, GameCarRight2[i], -90.000000, 0.000000, 0.000000, 0.899999);
       PlayerTextDrawSetPreviewVehCol(i, GameCarRight2[i], GameCar4C[i], GameCar4C[i]);
       PlayerTextDrawShow(i, PlayerText:GameCarRight2[i]);
   }
   if(GameCar1Pos[i] >= 288/GetPVarInt(i, "CarGameCarSpeed"))
   {
       PlayerTextDrawHide(i, GameCarLeft1[i]);
       PlayerTextDrawDestroy(i, GameCarLeft1[i]);
       GameCar1Created[i] = 0;
       GameCar1Pos[i] = 0;
       GameCar1C[i] = 0;
       GameCarLeft1[i] = CreatePlayerTextDraw(i, 271.667236, 0, "");
       PlayerTextDrawTextSize(i, GameCarLeft1[i], 36.000000, 36.000000);
       PlayerTextDrawColor(i, GameCarLeft1[i], -1);
       PlayerTextDrawBackgroundColor(i, GameCarLeft1[i], 0);
       PlayerTextDrawFont(i, GameCarLeft1[i], 5);
       PlayerTextDrawSetPreviewModel(i, GameCarLeft1[i], 19281);
       PlayerTextDrawSetPreviewRot(i, GameCarLeft1[i], -90.000000, 0.000000, 0.000000, 0.899999);
       PlayerTextDrawSetPreviewVehCol(i, GameCarLeft1[i], 1, 1);
       PlayerTextDrawShow(i, PlayerText:GameCarLeft1[i]);
       PlayerTextDrawHide(i, PlayerText:GameCarLeft1[i]);
   }
   if(GameCar2Pos[i] >= 288/GetPVarInt(i, "CarGameCarSpeed"))
   {
       PlayerTextDrawHide(i, GameCarLeft2[i]);
       PlayerTextDrawDestroy(i, GameCarLeft2[i]);
       GameCar2Created[i] = 0;
       GameCar2Pos[i] = 0;
       GameCar2C[i] = 0;
       GameCarLeft2[i] = CreatePlayerTextDraw(i, 258.667236, 0, "");
       PlayerTextDrawTextSize(i, GameCarLeft2[i], 36.000000, 36.000000);
       PlayerTextDrawColor(i, GameCarLeft2[i], -1);
       PlayerTextDrawBackgroundColor(i, GameCarLeft2[i], 0);
       PlayerTextDrawFont(i, GameCarLeft2[i], 5);
       PlayerTextDrawSetPreviewModel(i, GameCarLeft2[i], 19281);
       PlayerTextDrawSetPreviewRot(i, GameCarLeft2[i], -90.000000, 0.000000, 0.000000, 0.899999);
       PlayerTextDrawSetPreviewVehCol(i, GameCarLeft2[i], 1, 1);
       PlayerTextDrawShow(i, PlayerText:GameCarLeft2[i]);
       PlayerTextDrawHide(i, PlayerText:GameCarLeft2[i]);
   }
   if(GameCar3Pos[i] >= 288/GetPVarInt(i, "CarGameCarSpeed"))
   {
       PlayerTextDrawHide(i, GameCarRight1[i]);
       PlayerTextDrawDestroy(i, GameCarRight1[i]);
       GameCar3Created[i] = 0;
       GameCar3Pos[i] = 0;
       GameCar3C[i] = 0;
       GameCarRight1[i] = CreatePlayerTextDraw(i, 294.667572, 0, "");
       PlayerTextDrawTextSize(i, GameCarRight1[i], 36.000000, 36.000000);
       PlayerTextDrawColor(i, GameCarRight1[i], -1);
       PlayerTextDrawBackgroundColor(i, GameCarRight1[i], 0);
       PlayerTextDrawFont(i, GameCarRight1[i], 5);
       PlayerTextDrawSetPreviewModel(i, GameCarRight1[i], 19281);
       PlayerTextDrawSetPreviewRot(i, GameCarRight1[i], -90.000000, 0.000000, 0.000000, 0.899999);
       PlayerTextDrawSetPreviewVehCol(i, GameCarRight1[i], 1, 1);
       PlayerTextDrawShow(i, PlayerText:GameCarRight1[i]);
       PlayerTextDrawHide(i, PlayerText:GameCarRight1[i]);
   }
   if(GameCar4Pos[i] >= 288/GetPVarInt(i, "CarGameCarSpeed"))
   {
       PlayerTextDrawHide(i, GameCarRight2[i]);
       PlayerTextDrawDestroy(i, GameCarRight2[i]);
       GameCar4Created[i] = 0;
       GameCar4Pos[i] = 0;
       GameCar4C[i] = 0;
       GameCarRight2[i] = CreatePlayerTextDraw(i, 308.000671, 0, "");
       PlayerTextDrawTextSize(i, GameCarRight2[i], 36.000000, 36.000000);
       PlayerTextDrawColor(i, GameCarRight2[i], -1);
       PlayerTextDrawBackgroundColor(i, GameCarRight2[i], 0);
       PlayerTextDrawFont(i, GameCarRight2[i], 5);
       PlayerTextDrawSetPreviewModel(i, GameCarRight2[i], 19281);
       PlayerTextDrawSetPreviewRot(i, GameCarRight2[i], -90.000000, 0.000000, 0.000000, 0.899999);
       PlayerTextDrawSetPreviewVehCol(i, GameCarRight2[i], 1, 1);
       PlayerTextDrawShow(i, PlayerText:GameCarRight2[i]);
       PlayerTextDrawHide(i, PlayerText:GameCarRight2[i]);
   }
   if (PlayerGameCarModel[i] != 476)
   {
   if(GameCar2Pos[i] >= 245/GetPVarInt(i, "CarGameCarSpeed"))
   {
       if(CarDirectionCount[i] >= -7 && CarDirectionCount[i] <= -4)
       {
		   DebugMessage(i, "You crashed, lane 1");
		   SetPVarInt(i, "CarGame", 654);
		   PlayerTextDrawColor(i, GameCarLeft2[i], 255);
		   PlayerTextDrawShow(i, GameCarLeft2[i]);
           PlayerTextDrawSetPreviewModel(i, GameCarLeft1[i], 19281);
           PlayerTextDrawSetPreviewModel(i, GameCarLeft2[i], 19281);
           PlayerTextDrawSetPreviewModel(i, GameCarRight1[i], 19281);
           PlayerTextDrawSetPreviewModel(i, GameCarRight2[i], 19281);
		   SetTimerEx("SendPlayerToGameMenu", 5, false, "%i,%i", i, 1);
       }
   }
   if(GameCar1Pos[i] >= 245/GetPVarInt(i, "CarGameCarSpeed"))
   {
       if(CarDirectionCount[i] >= -4 && CarDirectionCount[i] <= 0)
       {
		   DebugMessage(i, "You crashed, lane 2");
		   SetPVarInt(i, "CarGame", 654);
		   PlayerTextDrawColor(i, GameCarLeft1[i], 255);
		   PlayerTextDrawShow(i, GameCarLeft1[i]);
           PlayerTextDrawSetPreviewModel(i, GameCarLeft1[i], 19281);
           PlayerTextDrawSetPreviewModel(i, GameCarLeft2[i], 19281);
           PlayerTextDrawSetPreviewModel(i, GameCarRight1[i], 19281);
           PlayerTextDrawSetPreviewModel(i, GameCarRight2[i], 19281);
		   SetTimerEx("SendPlayerToGameMenu", 5, false, "%i,%i", i, 1);
       }
   }
   if(GameCar3Pos[i] >= 245/GetPVarInt(i, "CarGameCarSpeed"))
   {
       if(CarDirectionCount[i] >= 0 && CarDirectionCount[i] <= 4)
       {
		   DebugMessage(i, "You crashed, lane 3");
		   SetPVarInt(i, "CarGame", 654);
		   PlayerTextDrawColor(i, GameCarRight1[i], 255);
		   PlayerTextDrawShow(i, GameCarRight1[i]);
           PlayerTextDrawSetPreviewModel(i, GameCarLeft1[i], 19281);
           PlayerTextDrawSetPreviewModel(i, GameCarLeft2[i], 19281);
           PlayerTextDrawSetPreviewModel(i, GameCarRight1[i], 19281);
           PlayerTextDrawSetPreviewModel(i, GameCarRight2[i], 19281);
		   SetTimerEx("SendPlayerToGameMenu", 5, false, "%i,%i", i, 1);
       }
   }
   if(GameCar4Pos[i] >= 245/GetPVarInt(i, "CarGameCarSpeed"))
   {
       if(CarDirectionCount[i] >= 4 && CarDirectionCount[i] <= 7)
       {
		   DebugMessage(i, "You crashed, lane 4");
		   SetPVarInt(i, "CarGame", 654);
		   PlayerTextDrawColor(i, GameCarRight2[i], 255);
		   PlayerTextDrawShow(i, GameCarRight2[i]);
           PlayerTextDrawSetPreviewModel(i, GameCarLeft1[i], 19281);
           PlayerTextDrawSetPreviewModel(i, GameCarLeft2[i], 19281);
           PlayerTextDrawSetPreviewModel(i, GameCarRight1[i], 19281);
           PlayerTextDrawSetPreviewModel(i, GameCarRight2[i], 19281);
		   SetTimerEx("SendPlayerToGameMenu", 5, false, "%i,%i", i, 1);
       }
   }
   }
   PlayerCarGameDistance[i] = ((PlayerCarGameDistance[i] + 1) + 5*GetPVarInt(i, "CarGameCarSpeed")/19);
   
   new Spieler[64];
   format(Spieler, sizeof(Spieler), "Spieler/%s.txt", GetSname(i));
   PlayerCarGamePoints[i] = dini_Int(Spieler, "CompAutoSpielPunkte") + PlayerCarGameDistance[i]/10;
   new string[25];
   format(string, sizeof string, "Distance: %i", PlayerCarGameDistance[i]);
   PlayerTextDrawSetString(i, CarDriveHUD[i][2], string);
   format(string, sizeof string, "Points: %i", PlayerCarGamePoints[i]);
   PlayerTextDrawSetString(i, CarDriveHUD[i][3], string);
   SpawnRandomGameCar(i);
   new Keys, ud, lr;
   GetPlayerKeys(i, Keys, ud, lr);
   if (lr == KEY_LEFT)
   {
      MoveGameCar(i, 1);
   }
   else if (lr == KEY_RIGHT)
   {
      MoveGameCar(i, 2);
   }
}
return 0;
}

stock SpawnRandomGameCar(playerid)
{
  if(GetGameCarRow() == 1)
  {
      if(GameCar1Created[playerid] == 1) return 0;
      PlayerTextDrawShow(playerid, PlayerText:GameCarLeft1[playerid]);
      GameCar1Created[playerid] = 1;
      GameCar1C[playerid] = GetRandomColor();
      GameCar1Pos[playerid] = 0;
      GameCar1[playerid] = GetGameRandomCar();
  }
  else if(GetGameCarRow() == 2)
  {
      if(GameCar2Created[playerid] == 1) return 0;
      PlayerTextDrawShow(playerid, PlayerText:GameCarLeft2[playerid]);
      GameCar2Created[playerid] = 1;
      GameCar2C[playerid] = GetRandomColor();
      GameCar2Pos[playerid] = 0;
      GameCar2[playerid] = GetGameRandomCar();
  }
  else if(GetGameCarRow() == 3)
  {
      if(GameCar3Created[playerid] == 1) return 0;
      PlayerTextDrawShow(playerid, PlayerText:GameCarRight1[playerid]);
      GameCar3Created[playerid] = 1;
      GameCar3C[playerid] = GetRandomColor();
      GameCar3Pos[playerid] = 0;
      GameCar3[playerid] = GetGameRandomCar();
  }
  else if(GetGameCarRow() == 4)
  {
      if(GameCar4Created[playerid] == 1) return 0;
      PlayerTextDrawShow(playerid, PlayerText:GameCarRight2[playerid]);
      GameCar4Created[playerid] = 1;
      GameCar4C[playerid] = GetRandomColor();
      GameCar4Pos[playerid] = 0;
      GameCar4[playerid] = GetGameRandomCar();
  }
  else
  {
      return 0;
  }
  return 1;
}

stock GetGameRandomCar()
{
      new RandomGameCar = random(19);
      switch (RandomGameCar)
      {
            case 0: return 602;
            case 1: return 567;
            case 2: return 411;
            case 3: return 421;
            case 4: return 517;
            case 5: return 518;
            case 6: return 575;
            case 7: return 535;
            case 8: return 412;
            case 9: return 534;
            case 10: return 541;
            case 11: return 555;
            case 12: return 477;
            case 13: return 483;
            case 14: return 597;
            case 15: return 479;
            case 16: return 587;
            case 17: return 445;
            case 18: return 467;
      }
      return 0;
}

stock GetRandomColor()
{
new randomcolor = random(255);
return randomcolor;
}

stock GetGameCarRow()
{
      new RandomGameCar = random(19);
      switch (RandomGameCar)
      {
            case 0: return 1;
            case 1: return 2;
            case 2: return 3;
            case 3: return 4;
            case 4: return 0;
            case 5: return 0;
            case 6: return 0;
            case 7: return 0;
            case 8: return 0;
            case 9: return 0;
            case 10: return 0;
            case 11: return 0;
            case 12: return 0;
            case 13: return 0;
            case 14: return 0;
            case 15: return 0;
            case 16: return 0;
            case 17: return 0;
            case 18: return 0;
      }
      return 0;
}

stock MoveGameCar(playerid, direction)
{
   if (direction == 1)
   {
       if(CarDirectionCount[playerid] <= -7) return 0;
       PlayerTextDrawDestroy(playerid, GamePlayerCar[playerid]);
       CarDirectionCount[playerid] --;
       GamePlayerCar[playerid] = CreatePlayerTextDraw(playerid, 282.666992+4.5*CarDirectionCount[playerid], 291.473999, "");
       PlayerTextDrawTextSize(playerid, GamePlayerCar[playerid], 36.000000, 36.000000);
       PlayerTextDrawColor(playerid, GamePlayerCar[playerid], -1);
       PlayerTextDrawFont(playerid, GamePlayerCar[playerid], 5);
       PlayerTextDrawBackgroundColor(playerid, GamePlayerCar[playerid], 0);
       PlayerTextDrawSetPreviewModel(playerid, GamePlayerCar[playerid], PlayerGameCarModel[playerid]);
       PlayerTextDrawSetPreviewRot(playerid, GamePlayerCar[playerid], -90.000000, 0.000000, 180.000000, 0.899999);
       PlayerTextDrawSetPreviewVehCol(playerid, GamePlayerCar[playerid], GamePlayerCarColor[playerid], GamePlayerCarColor[playerid]);
   }
   else if (direction == 2)
   {
       if(CarDirectionCount[playerid] >= 7) return 0;
       PlayerTextDrawDestroy(playerid, GamePlayerCar[playerid]);
       CarDirectionCount[playerid] ++;
       GamePlayerCar[playerid] = CreatePlayerTextDraw(playerid, 282.666992+4.5*CarDirectionCount[playerid], 291.473999, "");
       PlayerTextDrawTextSize(playerid, GamePlayerCar[playerid], 36.000000, 36.000000);
       PlayerTextDrawColor(playerid, GamePlayerCar[playerid], -1);
       PlayerTextDrawFont(playerid, GamePlayerCar[playerid], 5);
       PlayerTextDrawBackgroundColor(playerid, GamePlayerCar[playerid], 0);
       PlayerTextDrawSetPreviewModel(playerid, GamePlayerCar[playerid], PlayerGameCarModel[playerid]);
       PlayerTextDrawSetPreviewRot(playerid, GamePlayerCar[playerid], -90.000000, 0.000000, 180.000000, 0.899999);
       PlayerTextDrawSetPreviewVehCol(playerid, GamePlayerCar[playerid], GamePlayerCarColor[playerid], GamePlayerCarColor[playerid]);
   }
   return PlayerTextDrawShow(playerid, PlayerText:GamePlayerCar[playerid]);
}

forward SendPlayerToGameMenu(playerid, progress);
public SendPlayerToGameMenu(playerid, progress)
{
   if(progress == 1)
   {
           PlayerTextDrawColor(playerid, GamePlayerCar[playerid], 255);
           PlayerTextDrawShow(playerid, GamePlayerCar[playerid]);
           PlayerTextDrawDestroy(playerid, CarCrashExplosion[playerid]);
           CarCrashExplosion[playerid] = CreatePlayerTextDraw(playerid, 282.666992+4.5*CarDirectionCount[playerid], 291.473999, "LD_NONE:explm01");
           PlayerTextDrawTextSize(playerid, CarCrashExplosion[playerid], 33.000000, 36.000000);
           PlayerTextDrawAlignment(playerid, CarCrashExplosion[playerid], 1);
           PlayerTextDrawColor(playerid, CarCrashExplosion[playerid], -1);
           PlayerTextDrawSetShadow(playerid, CarCrashExplosion[playerid], 0);
           PlayerTextDrawBackgroundColor(playerid, CarCrashExplosion[playerid], 255);
           PlayerTextDrawFont(playerid, CarCrashExplosion[playerid], 4);
           PlayerTextDrawSetProportional(playerid, CarCrashExplosion[playerid], 0);
		   PlayerTextDrawShow(playerid, CarCrashExplosion[playerid]);
		   SetTimerEx("SendPlayerToGameMenu", 100, false, "%i,%i", playerid, 2);
   }
   if(progress == 2)
   {
           PlayerTextDrawSetString(playerid, CarCrashExplosion[playerid], "LD_NONE:explm02");
		   PlayerTextDrawShow(playerid, CarCrashExplosion[playerid]);
		   SetTimerEx("SendPlayerToGameMenu", 100, false, "%i,%i", playerid, 3);
   }
   if(progress == 3)
   {
           PlayerTextDrawSetString(playerid, CarCrashExplosion[playerid], "LD_NONE:explm03");
		   PlayerTextDrawShow(playerid, CarCrashExplosion[playerid]);
		   SetTimerEx("SendPlayerToGameMenu", 100, false, "%i,%i", playerid, 4);
   }
   if(progress == 4)
   {
           PlayerTextDrawSetString(playerid, CarCrashExplosion[playerid], "LD_NONE:explm04");
		   PlayerTextDrawShow(playerid, CarCrashExplosion[playerid]);
		   SetTimerEx("SendPlayerToGameMenu", 100, false, "%i,%i", playerid, 5);
   }
   if(progress == 5)
   {
           PlayerTextDrawSetString(playerid, CarCrashExplosion[playerid], "LD_NONE:explm05");
		   PlayerTextDrawShow(playerid, CarCrashExplosion[playerid]);
		   SetTimerEx("SendPlayerToGameMenu", 100, false, "%i,%i", playerid, 6);
   }
   if(progress == 6)
   {
           PlayerTextDrawSetString(playerid, CarCrashExplosion[playerid], "LD_NONE:explm06");
		   PlayerTextDrawShow(playerid, CarCrashExplosion[playerid]);
		   SetTimerEx("SendPlayerToGameMenu", 100, false, "%i,%i", playerid, 7);
   }
   if(progress == 7)
   {
           PlayerTextDrawSetString(playerid, CarCrashExplosion[playerid], "LD_NONE:explm07");
		   PlayerTextDrawShow(playerid, CarCrashExplosion[playerid]);
		   SetTimerEx("SendPlayerToGameMenu", 100, false, "%i,%i", playerid, 8);
   }
   if(progress == 8)
   {
           PlayerTextDrawSetString(playerid, CarCrashExplosion[playerid], "LD_NONE:explm08");
		   PlayerTextDrawShow(playerid, CarCrashExplosion[playerid]);
		   SetTimerEx("SendPlayerToGameMenu", 100, false, "%i,%i", playerid, 9);
   }
   if(progress == 9)
   {
           PlayerTextDrawSetString(playerid, CarCrashExplosion[playerid], "LD_NONE:explm09");
		   PlayerTextDrawShow(playerid, CarCrashExplosion[playerid]);
		   SetTimerEx("SendPlayerToGameMenu", 100, false, "%i,%i", playerid, 10);
   }
   if(progress == 10)
   {
           PlayerTextDrawSetString(playerid, CarCrashExplosion[playerid], "LD_NONE:explm10");
		   PlayerTextDrawShow(playerid, CarCrashExplosion[playerid]);
		   SetTimerEx("SendPlayerToGameMenu", 100, false, "%i,%i", playerid, 11);
   }
   if(progress == 11)
   {
           PlayerTextDrawSetString(playerid, CarCrashExplosion[playerid], "LD_NONE:explm11");
		   PlayerTextDrawShow(playerid, CarCrashExplosion[playerid]);
		   SetTimerEx("SendPlayerToGameMenu", 100, false, "%i,%i", playerid, 12);
   }
   if(progress == 12)
   {
           PlayerTextDrawSetString(playerid, CarCrashExplosion[playerid], "LD_NONE:explm12");
		   PlayerTextDrawShow(playerid, CarCrashExplosion[playerid]);
		   SetTimerEx("SendPlayerToGameMenu", 100, false, "%i,%i", playerid, 13);
   }
   if(progress == 13)
   {
		   PlayerTextDrawHide(playerid, CarCrashExplosion[playerid]);
		   SetTimerEx("SendPlayerToGameMenu", 1500, false, "%i,%i", playerid, 14);
   }
   if(progress == 14)
   {
	 	   new Spieler[64];
	 	   format(Spieler, sizeof(Spieler), "Spieler/%s.txt", GetSname(playerid));
	 	   dini_IntSet(Spieler, "CompAutoSpielPunkte", PlayerCarGamePoints[playerid]);
	 	   dini_IntSet(Spieler, "CompAutoSpielGeld", PlayerCarGameMoney[playerid]);
	       new string[17];
	       format(string, sizeof string, "Points:_%i", PlayerCarGamePoints[playerid]);
	       PlayerTextDrawSetString(playerid, CarGameMenu[playerid][4], string);
	       format(string, sizeof string, "Money:_%i", PlayerCarGameMoney[playerid]);
	       PlayerTextDrawSetString(playerid, CarGameMenu[playerid][3], string);
	       
	 	   SetPVarInt(playerid, "CarGame", 1);
	 	   PlayerTextDrawHide(playerid, GameRoad[playerid]);
		   PlayerTextDrawHide(playerid, CarDriveHUD[playerid][0]);
	       PlayerTextDrawHide(playerid, CarDriveHUD[playerid][1]);
	       PlayerTextDrawHide(playerid, CarDriveHUD[playerid][2]);
	       PlayerTextDrawHide(playerid, CarDriveHUD[playerid][3]);
	       PlayerTextDrawHide(playerid, CarDriveHUD[playerid][4]);
	       PlayerTextDrawShow(playerid, CarGameMenu[playerid][0]);
	       PlayerTextDrawShow(playerid, CarGameMenu[playerid][1]);
	       PlayerTextDrawShow(playerid, CarGameMenu[playerid][2]);
	       PlayerTextDrawShow(playerid, CarGameMenu[playerid][3]);
	       PlayerTextDrawShow(playerid, CarGameMenu[playerid][4]);
	       PlayerTextDrawShow(playerid, CarGameMenu[playerid][5]);
	       PlayerTextDrawShow(playerid, CarGameMenu[playerid][6]);
	       PlayerTextDrawShow(playerid, LeaveCarGame[playerid]);
	       PlayerTextDrawShow(playerid, LeaveCarGameX[playerid]);
	       PlayerTextDrawShow(playerid, GameCarShop[playerid][0]);
	       PlayerTextDrawShow(playerid, GameCarShop[playerid][1]);
	       PlayerTextDrawShow(playerid, GameCars[playerid][0]);
	       PlayerTextDrawShow(playerid, GameCars[playerid][1]);
	       PlayerTextDrawShow(playerid, GameCarPlay[playerid][0]);
	       PlayerTextDrawShow(playerid, GameCarPlay[playerid][1]);
	       PlayerCarGameDistance[playerid] = 0;
	       GameCar1Created[playerid] = 0;
	       GameCar1C[playerid] = 0;
	       GameCar1Pos[playerid] = 0;
	       GameCar1[playerid] = 0;
	       GameCar2Created[playerid] = 0;
	       GameCar2C[playerid] = 0;
	       GameCar2Pos[playerid] = 0;
	       GameCar2[playerid] = 0;
	       GameCar3Created[playerid] = 0;
	       GameCar3C[playerid] = 0;
	       GameCar3Pos[playerid] = 0;
	       GameCar3[playerid] = 0;
	       GameCar4Created[playerid] = 0;
	       GameCar4C[playerid] = 0;
	       GameCar4Pos[playerid] = 0;
	       GameCar4[playerid] = 0;
	       CarDirectionCount[playerid] = 0;
 	       PlayerTextDrawHide(playerid, GameCarLeft1[playerid]);
	       PlayerTextDrawHide(playerid, GameCarLeft2[playerid]);
	       PlayerTextDrawHide(playerid, GameCarRight1[playerid]);
	       PlayerTextDrawHide(playerid, GameCarRight2[playerid]);
	       PlayerTextDrawHide(playerid, GamePlayerCar[playerid]);
	       SelectTextDraw(playerid, TextdrawFarbe);
   }
}

public OnPlayerClickPlayerTextDraw(playerid, PlayerText:playertextid)
{
  if(playertextid == LeaveCarGame[playerid])
  {
	 if(GetPVarInt(playerid, "CarGame") == 3)
	 {
        PlayerTextDrawShow(playerid, GameCarShop[playerid][0]);
        PlayerTextDrawShow(playerid, GameCarShop[playerid][1]);
        PlayerTextDrawShow(playerid, GameCars[playerid][0]);
        PlayerTextDrawShow(playerid, GameCars[playerid][1]);
        PlayerTextDrawShow(playerid, GameCarPlay[playerid][0]);
        PlayerTextDrawShow(playerid, GameCarPlay[playerid][1]);
        PlayerTextDrawShow(playerid, CarGameMenu[playerid][1]);
        PlayerTextDrawShow(playerid, CarGameMenu[playerid][5]);
	    PlayerTextDrawShow(playerid, CarGameMenu[playerid][6]);
        PlayerTextDrawHide(playerid, CarGameShopMenu[playerid][0]);
        PlayerTextDrawHide(playerid, CarGameShopMenu[playerid][1]);
        PlayerTextDrawHide(playerid, CarGameShopMenu[playerid][2]);
        PlayerTextDrawHide(playerid, CarGameShopMenu[playerid][3]);
        PlayerTextDrawHide(playerid, CarGameShopMenu[playerid][4]);
        PlayerTextDrawHide(playerid, CarGameShopMenu[playerid][5]);
	    SetPVarInt(playerid, "CarGame", 1);
		return 1;
	 }
	 KillTimer(CarGameLoadTimer);
	 CancelSelectTextDraw(playerid);
	 SetPVarInt(playerid, "comp", 0);
	 SetPVarInt(playerid, "CarGame", 0);
	 PlayerTextDrawHide(playerid, CarGameBackGround[playerid]);
	 PlayerTextDrawHide(playerid, CarGameLoadScreen[playerid][0]);
	 PlayerTextDrawHide(playerid, CarGameLoadScreen[playerid][1]);
	 PlayerTextDrawHide(playerid, CarGameLoadScreen[playerid][2]);
	 PlayerTextDrawHide(playerid, CarGameLoadScreen[playerid][3]);
	 PlayerTextDrawHide(playerid, CarGameLoadScreen[playerid][4]);
     PlayerTextDrawHide(playerid, CarGameMenu[playerid][0]);
     PlayerTextDrawHide(playerid, CarGameMenu[playerid][1]);
	 PlayerTextDrawHide(playerid, CarGameMenu[playerid][2]);
     PlayerTextDrawHide(playerid, CarGameMenu[playerid][3]);
     PlayerTextDrawHide(playerid, CarGameMenu[playerid][4]);
     PlayerTextDrawHide(playerid, CarGameMenu[playerid][5]);
	 PlayerTextDrawHide(playerid, CarGameMenu[playerid][6]);
	 PlayerTextDrawHide(playerid, LeaveCarGame[playerid]);
	 PlayerTextDrawHide(playerid, LeaveCarGameX[playerid]);
     PlayerTextDrawHide(playerid, GameCarShop[playerid][0]);
     PlayerTextDrawHide(playerid, GameCarShop[playerid][1]);
     PlayerTextDrawHide(playerid, GameCars[playerid][0]);
     PlayerTextDrawHide(playerid, GameCars[playerid][1]);
     PlayerTextDrawHide(playerid, GameCarPlay[playerid][0]);
     PlayerTextDrawHide(playerid, GameCarPlay[playerid][1]);
	 PlayerTextDrawHide(playerid, CarDriveHUD[playerid][0]);
	 PlayerTextDrawHide(playerid, CarDriveHUD[playerid][1]);
	 PlayerTextDrawHide(playerid, CarDriveHUD[playerid][2]);
	 PlayerTextDrawHide(playerid, CarDriveHUD[playerid][3]);
	 PlayerTextDrawHide(playerid, CarDriveHUD[playerid][4]);
	 PlayerTextDrawHide(playerid, Bildschirm[playerid][0]);
	 PlayerTextDrawHide(playerid, Bildschirm[playerid][1]);
	 PlayerTextDrawHide(playerid, Bildschirm[playerid][2]);
	 PlayerTextDrawHide(playerid, Bildschirm[playerid][3]);
     TogglePlayerControllable(playerid, 1);
	 return 1;
  }
  else if(playertextid == GameCarColorMenu[playerid][0])
  {
	 SetPVarInt(playerid, "CarGame", 8);
     PlayerTextDrawSetString(playerid, CarGameBuyCar[playerid][2], "100_Points");
	 PlayerTextDrawSetSelectable(playerid, GameCarColorMenu[playerid][0], false);
	 PlayerTextDrawShow(playerid, GameCarColorMenu[playerid][0]);
	 NextCarColor(playerid);
	 LastCarColor(playerid);
	 return 1;
  }
  else if(playertextid == GameCars[playerid][0])
  {
	 SetPVarInt(playerid, "CarGame", 2);
	 PlayerTextDrawHide(playerid, CarGameLoadScreen[playerid][0]);
	 PlayerTextDrawHide(playerid, CarGameLoadScreen[playerid][1]);
	 PlayerTextDrawHide(playerid, CarGameLoadScreen[playerid][2]);
	 PlayerTextDrawHide(playerid, CarGameLoadScreen[playerid][3]);
	 PlayerTextDrawHide(playerid, CarGameLoadScreen[playerid][4]);
     //PlayerTextDrawHide(playerid, CarGameMenu[playerid][0]);
     PlayerTextDrawHide(playerid, CarGameMenu[playerid][1]);
	 PlayerTextDrawHide(playerid, CarGameMenu[playerid][2]);
     PlayerTextDrawHide(playerid, CarGameMenu[playerid][3]);
     PlayerTextDrawHide(playerid, CarGameMenu[playerid][4]);
     PlayerTextDrawHide(playerid, CarGameMenu[playerid][5]);
	 PlayerTextDrawHide(playerid, CarGameMenu[playerid][6]);
	 PlayerTextDrawHide(playerid, LeaveCarGame[playerid]);
	 PlayerTextDrawHide(playerid, LeaveCarGameX[playerid]);
     PlayerTextDrawHide(playerid, GameCarShop[playerid][0]);
     PlayerTextDrawHide(playerid, GameCarShop[playerid][1]);
     PlayerTextDrawHide(playerid, GameCars[playerid][0]);
     PlayerTextDrawHide(playerid, GameCars[playerid][1]);
     PlayerTextDrawHide(playerid, GameCarPlay[playerid][0]);
     PlayerTextDrawHide(playerid, GameCarPlay[playerid][1]);
     PlayerTextDrawShow(playerid, CarGameBuyCar[playerid][0]);
     PlayerTextDrawShow(playerid, CarGameBuyCar[playerid][1]);
     PlayerTextDrawShow(playerid, CarGameBuyCar[playerid][2]);
     PlayerTextDrawShow(playerid, CarGameBuyCar[playerid][3]);
     PlayerTextDrawShow(playerid, CarGameBuyCar[playerid][4]);
     PlayerTextDrawShow(playerid, CarGameBuyCar[playerid][5]);
     PlayerTextDrawShow(playerid, CarGameBuyCar[playerid][6]);
     if(PlayerGameCarModel[playerid] <= 0)
     {
	    NextGameCar(playerid);
     }
     UpdateShopCar(playerid);
	 return 1;
  }
  else if(playertextid == CarGameBuyCar[playerid][1])
  {
	 if(GetPVarInt(playerid, "CarGame") == 8)
	 {
		if(PlayerCarGamePoints[playerid] < 100)
		{
	       UpdateShopCar(playerid);
	       PlayerTextDrawSetSelectable(playerid, GameCarColorMenu[playerid][0], true);
	       PlayerTextDrawShow(playerid, GameCarColorMenu[playerid][0]);
	       NextGameCar(playerid);
	       LastGameCar(playerid);
	       PlayerTextDrawSetString(playerid, GameCarColorMenu[playerid][1], "Not_enough_points!");
	       SetPVarInt(playerid, "CarGame", 2);
		   return 1;
		}
	    new Spieler[64];
        format(Spieler, sizeof(Spieler), "Spieler/%s.txt", GetSname(playerid));
        new string[256+1];
        string = dini_Get(Spieler,"CompAutoSpiel");
        new walton; new perennial; new picador; new elegy; new uranus; new zr350; new cheetah; new infernus; new rustler;
        sscanf(string, "iiiiiiiii", walton, perennial, picador, elegy, uranus, zr350, cheetah, infernus, rustler);
        new vehiclemodel = PlayerGameCarModel[playerid];
        switch(vehiclemodel)
        {
           case 478: walton = GamePlayerCarColor[playerid];
           case 404: perennial = GamePlayerCarColor[playerid];
           case 600: picador = GamePlayerCarColor[playerid];
           case 562: elegy = GamePlayerCarColor[playerid];
           case 558: uranus = GamePlayerCarColor[playerid];
           case 477: zr350 = GamePlayerCarColor[playerid];
           case 415: cheetah = GamePlayerCarColor[playerid];
           case 411: infernus = GamePlayerCarColor[playerid];
           case 476: rustler = GamePlayerCarColor[playerid];
        }
        format(string, sizeof(string), "%i %i %i %i %i %i %i %i %i", walton, perennial, picador, elegy, uranus, zr350, cheetah, infernus, rustler);
        dini_Set(Spieler, "CompAutoSpiel", string);
   
   
	    UpdateShopCar(playerid);
	    PlayerTextDrawSetSelectable(playerid, GameCarColorMenu[playerid][0], true);
	    PlayerTextDrawShow(playerid, GameCarColorMenu[playerid][0]);
	    PlayerTextDrawSetString(playerid, GameCarColorMenu[playerid][1], "Color");
	    SetPVarInt(playerid, "CarGame", 2);
	    NextGameCar(playerid);
	    LastGameCar(playerid);
        PlayerCarGamePoints[playerid] = PlayerCarGamePoints[playerid] - 100;//hier, je nach Farbe anderer Preis
	    return 1;
	 }
	 SetPVarInt(playerid, "CarGame", 1);
	 SetTimerEx("SendPlayerToGameMenu", 100, false, "%i,%i", playerid, 14);
     PlayerTextDrawHide(playerid, CarGameBuyCar[playerid][0]);
     PlayerTextDrawHide(playerid, CarGameBuyCar[playerid][1]);
     PlayerTextDrawHide(playerid, CarGameBuyCar[playerid][2]);
     PlayerTextDrawHide(playerid, CarGameBuyCar[playerid][3]);
     PlayerTextDrawHide(playerid, CarGameBuyCar[playerid][4]);
     PlayerTextDrawHide(playerid, CarGameBuyCar[playerid][5]);
     PlayerTextDrawHide(playerid, CarGameBuyCar[playerid][6]);
     PlayerTextDrawHide(playerid, GameCarColorMenu[playerid][0]);
     PlayerTextDrawHide(playerid, GameCarColorMenu[playerid][1]);
	 return 1;
  }
  else if(playertextid == CarGameBuyCar[playerid][4])//rechts
  {
	 if(GetPVarInt(playerid, "CarGame") == 8) return NextCarColor(playerid);
	 NextGameCar(playerid);
	 return 1;
  }
  else if(playertextid == CarGameBuyCar[playerid][5])//links
  {
	 if(GetPVarInt(playerid, "CarGame") == 8) return LastCarColor(playerid);
	 LastGameCar(playerid);
	 return 1;
  }
  else if(playertextid == CarGameBuyCar[playerid][0])
  {
     BuyGameCar(playerid);
	 return 1;
  }
  else if(playertextid == GameCarShop[playerid][0])
  {
	 SetPVarInt(playerid, "CarGame", 3);
     PlayerTextDrawHide(playerid, GameCarShop[playerid][0]);
     PlayerTextDrawHide(playerid, GameCarShop[playerid][1]);
     PlayerTextDrawHide(playerid, GameCars[playerid][0]);
     PlayerTextDrawHide(playerid, GameCars[playerid][1]);
     PlayerTextDrawHide(playerid, GameCarPlay[playerid][0]);
     PlayerTextDrawHide(playerid, GameCarPlay[playerid][1]);//Buttons
     PlayerTextDrawHide(playerid, CarGameMenu[playerid][1]);
     PlayerTextDrawHide(playerid, CarGameMenu[playerid][5]);
	 PlayerTextDrawHide(playerid, CarGameMenu[playerid][6]);
     PlayerTextDrawShow(playerid, CarGameShopMenu[playerid][0]);
     PlayerTextDrawShow(playerid, CarGameShopMenu[playerid][1]);
     PlayerTextDrawShow(playerid, CarGameShopMenu[playerid][2]);
     PlayerTextDrawShow(playerid, CarGameShopMenu[playerid][3]);
     PlayerTextDrawShow(playerid, CarGameShopMenu[playerid][4]);
     PlayerTextDrawShow(playerid, CarGameShopMenu[playerid][5]);
	 return 1;
  }
  else if(playertextid == GameCarPlay[playerid][0])
  {
	 if(PlayerGameCarModel[playerid] <= 0) return 0;
 	 SetPVarInt(playerid, "CarGame", 4);
	 GameSecondsCount[playerid] = 0;
	 PlayerTextDrawHide(playerid, CarGameLoadScreen[playerid][0]);
	 PlayerTextDrawHide(playerid, CarGameLoadScreen[playerid][1]);
	 PlayerTextDrawHide(playerid, CarGameLoadScreen[playerid][2]);
	 PlayerTextDrawHide(playerid, CarGameLoadScreen[playerid][3]);
	 PlayerTextDrawHide(playerid, CarGameLoadScreen[playerid][4]);
     PlayerTextDrawHide(playerid, CarGameMenu[playerid][0]);
     PlayerTextDrawHide(playerid, CarGameMenu[playerid][1]);
	 PlayerTextDrawHide(playerid, CarGameMenu[playerid][2]);
     PlayerTextDrawHide(playerid, CarGameMenu[playerid][3]);
     PlayerTextDrawHide(playerid, CarGameMenu[playerid][4]);
     PlayerTextDrawHide(playerid, CarGameMenu[playerid][5]);
	 PlayerTextDrawHide(playerid, CarGameMenu[playerid][6]);
	 PlayerTextDrawHide(playerid, LeaveCarGame[playerid]);
	 PlayerTextDrawHide(playerid, LeaveCarGameX[playerid]);
     PlayerTextDrawHide(playerid, GameCarShop[playerid][0]);
     PlayerTextDrawHide(playerid, GameCarShop[playerid][1]);
     PlayerTextDrawHide(playerid, GameCars[playerid][0]);
     PlayerTextDrawHide(playerid, GameCars[playerid][1]);
     PlayerTextDrawHide(playerid, GameCarPlay[playerid][0]);
     PlayerTextDrawHide(playerid, GameCarPlay[playerid][1]);
	 PlayerTextDrawShow(playerid, GameRoad[playerid]);
	 PlayerTextDrawShow(playerid, CarDriveHUD[playerid][0]);
	 PlayerTextDrawShow(playerid, CarDriveHUD[playerid][1]);
	 PlayerTextDrawShow(playerid, CarDriveHUD[playerid][2]);
	 PlayerTextDrawShow(playerid, CarDriveHUD[playerid][3]);
	 PlayerTextDrawShow(playerid, CarDriveHUD[playerid][4]);
	 PlayerTextDrawDestroy(playerid, GamePlayerCar[playerid]);
	 GamePlayerCar[playerid] = CreatePlayerTextDraw(playerid, 282.666992, 291.473999, "");
	 PlayerTextDrawTextSize(playerid, GamePlayerCar[playerid], 36.000000, 36.000000);
	 PlayerTextDrawColor(playerid, GamePlayerCar[playerid], -1);
	 PlayerTextDrawFont(playerid, GamePlayerCar[playerid], 5);
	 PlayerTextDrawBackgroundColor(playerid, GamePlayerCar[playerid], 0);
	 PlayerTextDrawSetPreviewModel(playerid, GamePlayerCar[playerid], PlayerGameCarModel[playerid]);
	 PlayerTextDrawSetPreviewRot(playerid, GamePlayerCar[playerid], -90.000000, 0.000000, 180.000000, 0.899999);
	 PlayerTextDrawSetPreviewVehCol(playerid, GamePlayerCar[playerid], GamePlayerCarColor[playerid], GamePlayerCarColor[playerid]);
	 PlayerTextDrawShow(playerid, GamePlayerCar[playerid]);
	 CancelSelectTextDraw(playerid);
	 return 1;
  }
  else if(playertextid == CarGameShopMenu[playerid][0])
  {
	 DebugMessage(playerid, "Punkte zu Spielgeld");
	 ShowPlayerDialog(playerid, CARGAMEMONEYDIALOG, DIALOG_STYLE_INPUT, "Money Transformer",
	 "Here you can get game money for your points. For 10 points you get 1 money.\nWarning: Make sure there is a 0 at the end of the number! Else, you will lose a few points.\nPlease enter the desired amount here", "Okay", "Exit");
	 SetPVarInt(playerid, "CarGame", 5);
	 return 1;
  }
  else if(playertextid == CarGameShopMenu[playerid][2])
  {
     new Spieler[64];
     new string[255];
     format(Spieler,sizeof(Spieler),"/Spieler/%s.txt",GetSname(playerid));
     string = dini_Get(Spieler,"CompAutoSpiel");
     if(!strcmp(string, "-1 -1 -1 -1 -1 -1 -1 -1 -1"))
     {
		return ShowPlayerDialog(playerid, CARGAMEMONEYDIALOG, DIALOG_STYLE_MSGBOX, "Money Transformer","You need to buy a car before you can do this!", "Okay", "");
     }
	 DebugMessage(playerid, "Spielgeld zu Punkte");
	 ShowPlayerDialog(playerid, CARGAMEMONEYDIALOG, DIALOG_STYLE_INPUT, "Money Transformer",
	 "Here you can get points for your game money. For 1 money you get 10 points. \nPlease enter the desired amount here", "Okay", "Exit");
	 SetPVarInt(playerid, "CarGame", 6);
	 return 1;
  }
  else if(playertextid == CarGameShopMenu[playerid][4])
  {
     new Spieler[64];
     new string[255];
     format(Spieler,sizeof(Spieler),"/Spieler/%s.txt",GetSname(playerid));
     string = dini_Get(Spieler,"CompAutoSpiel");
     if(!strcmp(string, "-1 -1 -1 -1 -1 -1 -1 -1 -1"))
     {
		return ShowPlayerDialog(playerid, CARGAMEMONEYDIALOG, DIALOG_STYLE_MSGBOX, "Money Transformer","You need to buy a car before you can do this!", "Okay", "");
     }
	 DebugMessage(playerid, "Spielgeld zu Geld");
	 ShowPlayerDialog(playerid, CARGAMEMONEYDIALOG, DIALOG_STYLE_INPUT, "Money Transformer",
	 "Here you can get money for your game money. For 10 game money you get 1$.\nWarning: Make sure there is a 0 at the end of the number! Else, you will lose a few money.\nPlease enter the desired amount here", "Okay", "Exit");
	 SetPVarInt(playerid, "CarGame", 7);
	 return 1;
  }
  return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    if(dialogid == CARGAMEMONEYDIALOG)
    {
		if(!response)
		{
		   SetPVarInt(playerid, "CarGame", 3);
		}
        if(response)
        {
		    new string[75];
            if(GetPVarInt(playerid, "CarGame") == 5)
            {
			   if(strval(inputtext) < 10)
			   {
	              ShowPlayerDialog(playerid, CARGAMEMONEYDIALOG, DIALOG_STYLE_INPUT, "Money Transformer",
				  "Here you can get game money for your points. For 10 points you get 1 money.\nWarning: Make sure there is a 0 at the end of the number! Else, you will lose a few points.\nPlease enter the desired amount here. It has to be bigger then 10!", "Okay", "Exit");
				  return 1;
			   }
			   else
			   {
			      if(PlayerCarGamePoints[playerid] < strval(inputtext))
			      {
			         format(string, sizeof string, "You are %i points short of doing this", -(PlayerCarGamePoints[playerid]-strval(inputtext)));
			         ShowPlayerDialog(playerid, CARGAMEMONEYDIALOG, DIALOG_STYLE_MSGBOX, "Money Transformer", string, "Okay", "");
			         SetPVarInt(playerid, "CarGame", 3);
			         return 1;
			      }
			      format(string, sizeof string, "You have successfully changed %i points to %i money", strval(inputtext), strval(inputtext)/10);
			      ShowPlayerDialog(playerid, CARGAMEMONEYDIALOG, DIALOG_STYLE_MSGBOX, "Money Transformer", string, "Okay", "");
			      SetPVarInt(playerid, "CarGame", 3);
			      PlayerCarGamePoints[playerid] = PlayerCarGamePoints[playerid] - (strval(inputtext));
			      PlayerCarGameMoney[playerid] = PlayerCarGameMoney[playerid] + (strval(inputtext)/10);
			   }
            }
            else if(GetPVarInt(playerid, "CarGame") == 6)
            {
			   if(strval(inputtext) <= 0)
			   {
	              ShowPlayerDialog(playerid, CARGAMEMONEYDIALOG, DIALOG_STYLE_INPUT, "Money Transformer",
				  "Here you can get points for your game money. For 1 money you get 10 points. \nPlease enter the desired amount here. It has to be bigger then 0!", "Okay", "Exit");
				  return 1;
			   }
			   else
			   {
			      if(PlayerCarGameMoney[playerid] < strval(inputtext))
			      {
			         format(string, sizeof string, "You are %i money short of doing this", -(PlayerCarGameMoney[playerid]-strval(inputtext)));
			         ShowPlayerDialog(playerid, CARGAMEMONEYDIALOG, DIALOG_STYLE_MSGBOX, "Money Transformer", string, "Okay", "");
			         SetPVarInt(playerid, "CarGame", 3);
			         return 1;
			      }
			      format(string, sizeof string, "You have successfully changed %i money to %i points", strval(inputtext), strval(inputtext)*10);
			      ShowPlayerDialog(playerid, CARGAMEMONEYDIALOG, DIALOG_STYLE_MSGBOX, "Money Transformer", string, "Okay", "");
			      SetPVarInt(playerid, "CarGame", 3);
			      PlayerCarGameMoney[playerid] = PlayerCarGameMoney[playerid] - (strval(inputtext));
			      PlayerCarGamePoints[playerid] = PlayerCarGamePoints[playerid] + (strval(inputtext)*10);
			   }
            }
            else if(GetPVarInt(playerid, "CarGame") == 7)
            {
			   if(strval(inputtext) < 10)
			   {
	              ShowPlayerDialog(playerid, CARGAMEMONEYDIALOG, DIALOG_STYLE_INPUT, "Money Transformer",
				  "Here you can get money for your game money. For 10 game money you get 1$.\nWarning: Make sure there is a 0 at the end of the number! Else, you will lose a few money.\nPlease enter the desired amount here. It has to be bigger then 10!", "Okay", "Exit");
				  return 1;
			   }
			   else
			   {
			      if(PlayerCarGameMoney[playerid] < strval(inputtext))
			      {
			         format(string, sizeof string, "You are %i money short of doing this", -(PlayerCarGameMoney[playerid]-strval(inputtext)));
			         ShowPlayerDialog(playerid, CARGAMEMONEYDIALOG, DIALOG_STYLE_MSGBOX, "Money Transformer", string, "Okay", "");
			         SetPVarInt(playerid, "CarGame", 3);
			         return 1;
			      }
			      format(string, sizeof string, "You have successfully changed %i money to %i$", strval(inputtext)*10, strval(inputtext));
			      ShowPlayerDialog(playerid, CARGAMEMONEYDIALOG, DIALOG_STYLE_MSGBOX, "Money Transformer", string, "Okay", "");
			      SetPVarInt(playerid, "CarGame", 3);
			      GivePlayerMoney(playerid, strval(inputtext));
			      PlayerCarGameMoney[playerid] = PlayerCarGameMoney[playerid] - (strval(inputtext)*10);
			   }
            }
        }
        new Spieler[64];
        format(Spieler, sizeof(Spieler), "Spieler/%s.txt", GetSname(playerid));
        dini_IntSet(Spieler, "CompAutoSpielPunkte", PlayerCarGamePoints[playerid]);
        dini_IntSet(Spieler, "CompAutoSpielGeld", PlayerCarGameMoney[playerid]);
        new string[15];
        format(string, sizeof string, "Points:_%i", PlayerCarGamePoints[playerid]);
        PlayerTextDrawSetString(playerid, CarGameMenu[playerid][4], string);
        format(string, sizeof string, "Money:_%i", PlayerCarGameMoney[playerid]);
        PlayerTextDrawSetString(playerid, CarGameMenu[playerid][3], string);
        return 1;
    }

    return 0;
}

stock NextCarColor(playerid)
{
   if(GamePlayerCarColor[playerid] == 1)
   {
	  GamePlayerCarColor[playerid] = 0;
      PlayerTextDrawSetString(playerid, GameCarColorMenu[playerid][1], "Black");
   }
   else if(GamePlayerCarColor[playerid] == 0)
   {
	  GamePlayerCarColor[playerid] = 128;
      PlayerTextDrawSetString(playerid, GameCarColorMenu[playerid][1], "Green");
   }
   else if(GamePlayerCarColor[playerid] == 128)
   {
	  GamePlayerCarColor[playerid] = 126;
      PlayerTextDrawSetString(playerid, GameCarColorMenu[playerid][1], "Pink");
   }
   else if(GamePlayerCarColor[playerid] == 126)
   {
	  GamePlayerCarColor[playerid] = 6;
      PlayerTextDrawSetString(playerid, GameCarColorMenu[playerid][1], "Yellow");
   }
   else if(GamePlayerCarColor[playerid] == 6)
   {
	  GamePlayerCarColor[playerid] = 198;
      PlayerTextDrawSetString(playerid, GameCarColorMenu[playerid][1], "Blue");
   }
   else if(GamePlayerCarColor[playerid] == 198)
   {
	  GamePlayerCarColor[playerid] = 3;
      PlayerTextDrawSetString(playerid, GameCarColorMenu[playerid][1], "Red");
   }
   else if(GamePlayerCarColor[playerid] == 3)
   {
	  GamePlayerCarColor[playerid] = 1;
      PlayerTextDrawSetString(playerid, GameCarColorMenu[playerid][1], "White");
   }
   new string[20];
   format(string, sizeof string, "%i",GamePlayerCarColor[playerid]);
   DebugMessage(playerid, string);
   PlayerTextDrawSetPreviewVehCol(playerid, CarGameBuyCar[playerid][3], GamePlayerCarColor[playerid], GamePlayerCarColor[playerid]);
   PlayerTextDrawShow(playerid, CarGameBuyCar[playerid][3]);
   return 1;
}

stock LastCarColor(playerid)
{
   if(GamePlayerCarColor[playerid] == 0)
   {
	  GamePlayerCarColor[playerid] = 1;
      PlayerTextDrawSetString(playerid, GameCarColorMenu[playerid][1], "White");
   }
   else if(GamePlayerCarColor[playerid] == 128)
   {
	  GamePlayerCarColor[playerid] = 0;
      PlayerTextDrawSetString(playerid, GameCarColorMenu[playerid][1], "Black");
   }
   else if(GamePlayerCarColor[playerid] == 126)
   {
	  GamePlayerCarColor[playerid] = 128;
      PlayerTextDrawSetString(playerid, GameCarColorMenu[playerid][1], "Green");
   }
   else if(GamePlayerCarColor[playerid] == 6)
   {
	  GamePlayerCarColor[playerid] = 126;
      PlayerTextDrawSetString(playerid, GameCarColorMenu[playerid][1], "Pink");
   }
   else if(GamePlayerCarColor[playerid] == 198)
   {
	  GamePlayerCarColor[playerid] = 6;
      PlayerTextDrawSetString(playerid, GameCarColorMenu[playerid][1], "Yellow");
   }
   else if(GamePlayerCarColor[playerid] == 3)
   {
	  GamePlayerCarColor[playerid] = 198;
      PlayerTextDrawSetString(playerid, GameCarColorMenu[playerid][1], "Blue");
   }
   else if(GamePlayerCarColor[playerid] == 1)
   {
	  GamePlayerCarColor[playerid] = 3;
      PlayerTextDrawSetString(playerid, GameCarColorMenu[playerid][1], "Red");
   }
   new string[20];
   format(string, sizeof string, "%i",GamePlayerCarColor[playerid]);
   DebugMessage(playerid, string);
   PlayerTextDrawSetPreviewVehCol(playerid, CarGameBuyCar[playerid][3], GamePlayerCarColor[playerid], GamePlayerCarColor[playerid]);
   PlayerTextDrawShow(playerid, CarGameBuyCar[playerid][3]);
   return 1;
}

stock NextGameCar(playerid)
{
if (PlayerGameCarModel[playerid] <= 0)
{
   PlayerGameCarModel[playerid] = 478;
   PlayerTextDrawSetString(playerid, CarGameBuyCar[playerid][2], "Walton");
   UpdateShopCar(playerid);
   SetPVarInt(playerid, "CarGameCarSpeed", GAMESPEED_WALTON);
}
else if (PlayerGameCarModel[playerid] == 478)
{
   PlayerGameCarModel[playerid] = 404;
   PlayerTextDrawSetString(playerid, CarGameBuyCar[playerid][2], "Perennial");
   UpdateShopCar(playerid);
   SetPVarInt(playerid, "CarGameCarSpeed", GAMESPEED_PEREN);
}
else if (PlayerGameCarModel[playerid] == 404)
{
   PlayerGameCarModel[playerid] = 600;
   PlayerTextDrawSetString(playerid, CarGameBuyCar[playerid][2], "Picador");
   UpdateShopCar(playerid);
   SetPVarInt(playerid, "CarGameCarSpeed", GAMESPEED_PICAD);
}
else if (PlayerGameCarModel[playerid] == 600)
{
   PlayerGameCarModel[playerid] = 562;
   PlayerTextDrawSetString(playerid, CarGameBuyCar[playerid][2], "Elegy");
   UpdateShopCar(playerid);
   SetPVarInt(playerid, "CarGameCarSpeed", GAMESPEED_ELEGY);
}
else if (PlayerGameCarModel[playerid] == 562)
{
   PlayerGameCarModel[playerid] = 558;
   PlayerTextDrawSetString(playerid, CarGameBuyCar[playerid][2], "Uranus");
   UpdateShopCar(playerid);
   SetPVarInt(playerid, "CarGameCarSpeed", GAMESPEED_URANUS);
}
else if (PlayerGameCarModel[playerid] == 558)
{
   PlayerGameCarModel[playerid] = 477;
   PlayerTextDrawSetString(playerid, CarGameBuyCar[playerid][2], "ZR-350");
   UpdateShopCar(playerid);
   SetPVarInt(playerid, "CarGameCarSpeed", GAMESPEED_ZR350);
}
else if (PlayerGameCarModel[playerid] == 477)
{
   PlayerGameCarModel[playerid] = 415;
   PlayerTextDrawSetString(playerid, CarGameBuyCar[playerid][2], "Cheetah");
   UpdateShopCar(playerid);
   SetPVarInt(playerid, "CarGameCarSpeed", GAMESPEED_CHEET);
}
else if (PlayerGameCarModel[playerid] == 415)
{
   PlayerGameCarModel[playerid] = 411;
   PlayerTextDrawSetString(playerid, CarGameBuyCar[playerid][2], "Infernus");
   UpdateShopCar(playerid);
   SetPVarInt(playerid, "CarGameCarSpeed", GAMESPEED_INFERN);
}
else if (PlayerGameCarModel[playerid] == 411)
{
   PlayerGameCarModel[playerid] = 476;
   PlayerTextDrawSetString(playerid, CarGameBuyCar[playerid][2], "Rustler");
   UpdateShopCar(playerid);
   SetPVarInt(playerid, "CarGameCarSpeed", GAMESPEED_RUSTLER);
}
else if (PlayerGameCarModel[playerid] == 476)
{
   PlayerGameCarModel[playerid] = 478;
   PlayerTextDrawSetString(playerid, CarGameBuyCar[playerid][2], "Walton");
   UpdateShopCar(playerid);
   SetPVarInt(playerid, "CarGameCarSpeed", GAMESPEED_WALTON);
}
PlayerTextDrawSetString(playerid, GameCarColorMenu[playerid][1], "Color");
PlayerTextDrawSetPreviewModel(playerid, CarGameBuyCar[playerid][3], PlayerGameCarModel[playerid]);
PlayerTextDrawShow(playerid, CarGameBuyCar[playerid][3]);
new string[20];
format(string, sizeof string, "%i", GetPVarInt(playerid, "CarGameCarSpeed"));
DebugMessage(playerid, string);

return 1;
}

stock LastGameCar(playerid)
{
//if (PlayerGameCarModel[playerid] <= 0) {PlayerGameCarModel[playerid] = 476;}
if (PlayerGameCarModel[playerid] == 404)
{
   PlayerGameCarModel[playerid] = 478;
   PlayerTextDrawSetString(playerid, CarGameBuyCar[playerid][2], "Walton");
   UpdateShopCar(playerid);
   SetPVarInt(playerid, "CarGameCarSpeed", GAMESPEED_WALTON);
}
else if (PlayerGameCarModel[playerid] == 600)
{
   PlayerGameCarModel[playerid] = 404;
   PlayerTextDrawSetString(playerid, CarGameBuyCar[playerid][2], "Perennial");
   UpdateShopCar(playerid);
   SetPVarInt(playerid, "CarGameCarSpeed", GAMESPEED_PEREN);
}
else if (PlayerGameCarModel[playerid] == 562)
{
   PlayerGameCarModel[playerid] = 600;
   PlayerTextDrawSetString(playerid, CarGameBuyCar[playerid][2], "Picador");
   UpdateShopCar(playerid);
   SetPVarInt(playerid, "CarGameCarSpeed", GAMESPEED_PICAD);
}
else if (PlayerGameCarModel[playerid] == 558)
{
   PlayerGameCarModel[playerid] = 562;
   PlayerTextDrawSetString(playerid, CarGameBuyCar[playerid][2], "Elegy");
   UpdateShopCar(playerid);
   SetPVarInt(playerid, "CarGameCarSpeed", GAMESPEED_ELEGY);
}
else if (PlayerGameCarModel[playerid] == 477)
{
   PlayerGameCarModel[playerid] = 558;
   PlayerTextDrawSetString(playerid, CarGameBuyCar[playerid][2], "Uranus");
   UpdateShopCar(playerid);
   SetPVarInt(playerid, "CarGameCarSpeed", GAMESPEED_URANUS);
}
else if (PlayerGameCarModel[playerid] == 415)
{
   PlayerGameCarModel[playerid] = 477;
   PlayerTextDrawSetString(playerid, CarGameBuyCar[playerid][2], "ZR-350");
   UpdateShopCar(playerid);
   SetPVarInt(playerid, "CarGameCarSpeed", GAMESPEED_ZR350);
}
else if (PlayerGameCarModel[playerid] == 411)
{
   PlayerGameCarModel[playerid] = 415;
   PlayerTextDrawSetString(playerid, CarGameBuyCar[playerid][2], "Cheetah");
   UpdateShopCar(playerid);
   SetPVarInt(playerid, "CarGameCarSpeed", GAMESPEED_CHEET);
}
else if (PlayerGameCarModel[playerid] == 476)
{
   PlayerGameCarModel[playerid] = 411;
   PlayerTextDrawSetString(playerid, CarGameBuyCar[playerid][2], "Infernus");
   UpdateShopCar(playerid);
   SetPVarInt(playerid, "CarGameCarSpeed", GAMESPEED_INFERN);
}
else if (PlayerGameCarModel[playerid] == 478)
{
   PlayerGameCarModel[playerid] = 476;
   PlayerTextDrawSetString(playerid, CarGameBuyCar[playerid][2], "Rustler");
   SetPVarInt(playerid, "CarGameCarSpeed", GAMESPEED_RUSTLER);
   UpdateShopCar(playerid);
}
PlayerTextDrawSetString(playerid, GameCarColorMenu[playerid][1], "Color");
PlayerTextDrawSetPreviewModel(playerid, CarGameBuyCar[playerid][3], PlayerGameCarModel[playerid]);
PlayerTextDrawShow(playerid, CarGameBuyCar[playerid][3]);
new string[20];
format(string, sizeof string, "%i", GetPVarInt(playerid, "CarGameCarSpeed"));
DebugMessage(playerid, string);
return 1;
}

stock UpdateShopCar(playerid)
{
   new string[256+1];
   new modelid = PlayerGameCarModel[playerid];
   new Spieler[64];
   format(Spieler,sizeof(Spieler),"/Spieler/%s.txt",GetSname(playerid));
   string = dini_Get(Spieler,"CompAutoSpiel");
   new walton; new perennial; new picador; new elegy; new uranus; new zr350; new cheetah; new infernus; new rustler;
   sscanf(string, "iiiiiiiii", walton, perennial, picador, elegy, uranus, zr350, cheetah, infernus, rustler);
   
   new striing[200];
   format(striing, sizeof striing, "Walton: %i, Peren: %i, Pic: %i, Ele: %i, Uran: %i, ZR350: %i, Chee: %i, Infer: %i, Rust: %i", walton, perennial, picador, elegy, uranus, zr350, cheetah, infernus, rustler);
   DebugMessage(playerid, striing);
   switch(modelid)
   {
      case 478: if(walton > -1) return UseCarDisplay(playerid, walton);
      case 404: if(perennial > -1) return UseCarDisplay(playerid, perennial);
      case 600: if(picador > -1) return UseCarDisplay(playerid, picador);
      case 562: if(elegy > -1) return UseCarDisplay(playerid, elegy);
      case 558: if(uranus > -1) return UseCarDisplay(playerid, uranus);
      case 477: if(zr350 > -1) return UseCarDisplay(playerid, zr350);
      case 415: if(cheetah > -1) return UseCarDisplay(playerid, cheetah);
      case 411: if(infernus > -1) return UseCarDisplay(playerid, infernus);
      case 476: if(rustler > -1) return UseCarDisplay(playerid, rustler);
   }
   BuyCarDisplay(playerid);
return 0;
}

stock BuyCarDisplay(playerid)//random farben nach dem kaufen nach dem neu laden ?
{
   new string[50];
   new modelid = PlayerGameCarModel[playerid];
   switch(modelid)
   {
      case 478: format(string, sizeof string, "Buy this car for %i$", GAMEPRICE_WALTON+Steuern);
      case 404: format(string, sizeof string, "Buy this car for %i$", GAMEPRICE_PEREN+Steuern);
      case 600: format(string, sizeof string, "Buy this car for %i$", GAMEPRICE_PICAD+Steuern);
      case 562: format(string, sizeof string, "Buy this car for %i$", GAMEPRICE_ELEGY+Steuern);
      case 558: format(string, sizeof string, "Buy this car for %i$", GAMEPRICE_URANUS+Steuern);
      case 477: format(string, sizeof string, "Buy this car for %i$", GAMEPRICE_ZR350+Steuern);
      case 415: format(string, sizeof string, "Buy this car for %i$", GAMEPRICE_CHEET+Steuern);
      case 411: format(string, sizeof string, "Buy this car for %i$", GAMEPRICE_INFERN+Steuern);
      case 476: format(string, sizeof string, "Buy this for %i$", GAMEPRICE_RUSTLER+Steuern);
   }
   GamePlayerCarColor[playerid] = 1;
   PlayerTextDrawSetPreviewVehCol(playerid, CarGameBuyCar[playerid][3], GamePlayerCarColor[playerid], GamePlayerCarColor[playerid]);
   PlayerTextDrawSetString(playerid, CarGameBuyCar[playerid][6], string);
   PlayerTextDrawSetSelectable(playerid, CarGameBuyCar[playerid][1], 0);
   PlayerTextDrawShow(playerid, CarGameBuyCar[playerid][1]);
   PlayerTextDrawShow(playerid, CarGameBuyCar[playerid][6]);
   PlayerTextDrawShow(playerid, CarGameBuyCar[playerid][0]);
   PlayerTextDrawHide(playerid, GameCarColorMenu[playerid][0]);
   PlayerTextDrawHide(playerid, GameCarColorMenu[playerid][1]);
   return 1;
}

stock UseCarDisplay(playerid, carcolor)
{
   PlayerTextDrawSetString(playerid, GameCarColorMenu[playerid][1], "Color");
   GamePlayerCarColor[playerid] = carcolor;
   PlayerTextDrawSetPreviewVehCol(playerid, CarGameBuyCar[playerid][3], carcolor, carcolor);
   PlayerTextDrawSetSelectable(playerid, CarGameBuyCar[playerid][1], 1);
   PlayerTextDrawShow(playerid, CarGameBuyCar[playerid][1]);
   PlayerTextDrawShow(playerid, GameCarColorMenu[playerid][0]);
   PlayerTextDrawShow(playerid, GameCarColorMenu[playerid][1]);
   PlayerTextDrawHide(playerid, CarGameBuyCar[playerid][6]);
   PlayerTextDrawHide(playerid, CarGameBuyCar[playerid][0]);
   return 1;
}

stock BuyGameCar(playerid)
{
   new vehiclemodel = PlayerGameCarModel[playerid];
   switch(vehiclemodel)
   {
      case 478: if(PlayerCarGameMoney[playerid] < GAMEPRICE_WALTON+Steuern) return PlayerTextDrawSetString(playerid, CarGameBuyCar[playerid][6], "Not enough money"); // walton
      case 404: if(PlayerCarGameMoney[playerid] < GAMEPRICE_PEREN+Steuern) return PlayerTextDrawSetString(playerid, CarGameBuyCar[playerid][6], "Not enough money"); //perennial
      case 600: if(PlayerCarGameMoney[playerid] < GAMEPRICE_PICAD+Steuern) return PlayerTextDrawSetString(playerid, CarGameBuyCar[playerid][6], "Not enough money"); //picador
      case 562: if(PlayerCarGameMoney[playerid] < GAMEPRICE_ELEGY+Steuern) return PlayerTextDrawSetString(playerid, CarGameBuyCar[playerid][6], "Not enough money"); //elegy
      case 558: if(PlayerCarGameMoney[playerid] < GAMEPRICE_URANUS+Steuern) return PlayerTextDrawSetString(playerid, CarGameBuyCar[playerid][6], "Not enough money"); //uranus
      case 477: if(PlayerCarGameMoney[playerid] < GAMEPRICE_ZR350+Steuern) return PlayerTextDrawSetString(playerid, CarGameBuyCar[playerid][6], "Not enough money"); //zr350
      case 415: if(PlayerCarGameMoney[playerid] < GAMEPRICE_CHEET+Steuern) return PlayerTextDrawSetString(playerid, CarGameBuyCar[playerid][6], "Not enough money"); //cheetah
      case 411: if(PlayerCarGameMoney[playerid] < GAMEPRICE_INFERN+Steuern) return PlayerTextDrawSetString(playerid, CarGameBuyCar[playerid][6], "Not enough money"); //infernus
      case 476: if(PlayerCarGameMoney[playerid] < GAMEPRICE_RUSTLER+Steuern) return PlayerTextDrawSetString(playerid, CarGameBuyCar[playerid][6], "Not enough money"); //rustler
   }
   new Spieler[64];
   format(Spieler, sizeof(Spieler), "Spieler/%s.txt", GetSname(playerid));
   new string[256+1];
   string = dini_Get(Spieler,"CompAutoSpiel");
   new walton; new perennial; new picador; new elegy; new uranus; new zr350; new cheetah; new infernus; new rustler;
   sscanf(string, "iiiiiiiii", walton, perennial, picador, elegy, uranus, zr350, cheetah, infernus, rustler);
   if(vehiclemodel == 478)
   {
      walton = 1;
      PlayerCarGameMoney[playerid] = PlayerCarGameMoney[playerid] -GAMEPRICE_WALTON+Steuern;
   }
   if(vehiclemodel == 404)
   {
      perennial = 1;
      PlayerCarGameMoney[playerid] = PlayerCarGameMoney[playerid] -GAMEPRICE_PEREN+Steuern;
   }
   if(vehiclemodel == 600)
   {
      picador = 1;
      PlayerCarGameMoney[playerid] = PlayerCarGameMoney[playerid] -GAMEPRICE_PICAD+Steuern;
   }
   if(vehiclemodel == 562)
   {
      elegy = 1;
      PlayerCarGameMoney[playerid] = PlayerCarGameMoney[playerid] -GAMEPRICE_ELEGY+Steuern;
   }
   if(vehiclemodel == 558)
   {
      uranus = 1;
      PlayerCarGameMoney[playerid] = PlayerCarGameMoney[playerid] -GAMEPRICE_URANUS+Steuern;
   }
   if(vehiclemodel == 477)
   {
      zr350 = 1;
      PlayerCarGameMoney[playerid] = PlayerCarGameMoney[playerid] -GAMEPRICE_ZR350+Steuern;
   }
   if(vehiclemodel == 415)
   {
      cheetah = 1;
      PlayerCarGameMoney[playerid] = PlayerCarGameMoney[playerid] -GAMEPRICE_CHEET+Steuern;
   }
   if(vehiclemodel == 411)
   {
      infernus = 1;
      PlayerCarGameMoney[playerid] = PlayerCarGameMoney[playerid] -GAMEPRICE_INFERN+Steuern;
   }
   if(vehiclemodel == 476)
   {
      rustler = 1;
      PlayerCarGameMoney[playerid] = PlayerCarGameMoney[playerid] -GAMEPRICE_RUSTLER+Steuern;
   }
   GamePlayerCarColor[playerid] = 1;
   format(string, sizeof(string), "%i %i %i %i %i %i %i %i %i", walton, perennial, picador, elegy, uranus, zr350, cheetah, infernus, rustler);
   dini_Set(Spieler, "CompAutoSpiel", string);
   dini_IntSet(Spieler, "CompAutoSpielGeld", PlayerCarGameMoney[playerid]);
   UpdateShopCar(playerid);
   return 1;
}
