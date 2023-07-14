#include <a_samp>
#include <dini>
#include <0SimonsInclude>

new Spieler[64];
new CatchBallGameState[MAX_PLAYERS];
new CatchBallDifficulty[MAX_PLAYERS];
new CatchBallPoints[MAX_PLAYERS];
new CatchBallTimer;

new Text:ComputerBildschirm[MAX_PLAYERS][4];
new Text:GameBackGround[MAX_PLAYERS];
new Text:CatchTheBallMenu[MAX_PLAYERS][8];
new Text:LeaveCatchBall[MAX_PLAYERS][5];
new Text:BallCatchBall[MAX_PLAYERS];

public OnPlayerConnect(playerid)
{
CatchBallGameState[playerid] = -1;
format(Spieler,sizeof(Spieler),"/Spieler/%s.txt",GetSname(playerid));
CatchBallDifficulty[playerid] = dini_Int(Spieler, "CatchTheBallDifficulty");
CatchBallPoints[playerid] = dini_Int(Spieler, "CatchTheBallPunkte");

GameBackGround[playerid] = TextDrawCreate(153.999908, 60.422237, "LD_SPAC:white");
TextDrawTextSize(GameBackGround[playerid], 299.712646, 288.247070);
TextDrawAlignment(GameBackGround[playerid], 1);
TextDrawColor(GameBackGround[playerid], -2139062017);
TextDrawSetShadow(GameBackGround[playerid], 0);
TextDrawUseBox(GameBackGround[playerid], 0);
TextDrawBackgroundColor(GameBackGround[playerid], 0);
TextDrawFont(GameBackGround[playerid], 4);
TextDrawSetProportional(GameBackGround[playerid], 0);

CatchTheBallMenu[playerid][0] = TextDrawCreate(301.666656, 91.281455, "Catch_the_Ball!");
TextDrawLetterSize(CatchTheBallMenu[playerid][0], 0.411332, 2.749037);
TextDrawTextSize(CatchTheBallMenu[playerid][0], 0.000000, 85.000000);
TextDrawAlignment(CatchTheBallMenu[playerid][0], 2);
TextDrawColor(CatchTheBallMenu[playerid][0], 41215);
TextDrawSetShadow(CatchTheBallMenu[playerid][0], 0);
TextDrawBackgroundColor(CatchTheBallMenu[playerid][0], 255);
TextDrawFont(CatchTheBallMenu[playerid][0], 2);
TextDrawSetProportional(CatchTheBallMenu[playerid][0], 1);

CatchTheBallMenu[playerid][1] = TextDrawCreate(301.166687, 107.451896, "--------------------------");
TextDrawLetterSize(CatchTheBallMenu[playerid][1], 0.400000, 1.600000);
TextDrawAlignment(CatchTheBallMenu[playerid][1], 2);
TextDrawColor(CatchTheBallMenu[playerid][1], -1);
TextDrawSetShadow(CatchTheBallMenu[playerid][1], 0);
TextDrawBackgroundColor(CatchTheBallMenu[playerid][1], 255);
TextDrawFont(CatchTheBallMenu[playerid][1], 1);
TextDrawSetProportional(CatchTheBallMenu[playerid][1], 1);

CatchTheBallMenu[playerid][2] = TextDrawCreate(226.199707, 134.000000, "LD_SPAC:white");
TextDrawTextSize(CatchTheBallMenu[playerid][2], 149.589965, 35.799850);
TextDrawAlignment(CatchTheBallMenu[playerid][2], 1);
TextDrawColor(CatchTheBallMenu[playerid][2], -1);
TextDrawSetShadow(CatchTheBallMenu[playerid][2], 0);
TextDrawBackgroundColor(CatchTheBallMenu[playerid][2], 255);
TextDrawFont(CatchTheBallMenu[playerid][2], 4);
TextDrawSetProportional(CatchTheBallMenu[playerid][2], 0);
TextDrawSetSelectable(CatchTheBallMenu[playerid][2], true);

CatchTheBallMenu[playerid][3] = TextDrawCreate(301.000000, 143.955520, "Play");
TextDrawLetterSize(CatchTheBallMenu[playerid][3], 0.400000, 1.600000);
TextDrawAlignment(CatchTheBallMenu[playerid][3], 2);
TextDrawColor(CatchTheBallMenu[playerid][3], 255);
TextDrawSetShadow(CatchTheBallMenu[playerid][3], 0);
TextDrawBackgroundColor(CatchTheBallMenu[playerid][3], 255);
TextDrawFont(CatchTheBallMenu[playerid][3], 1);
TextDrawSetProportional(CatchTheBallMenu[playerid][3], 1);

CatchTheBallMenu[playerid][4] = TextDrawCreate(226.199707, 179.000000, "LD_SPAC:white");
TextDrawTextSize(CatchTheBallMenu[playerid][4], 149.589965, 35.799850);
TextDrawAlignment(CatchTheBallMenu[playerid][4], 1);
TextDrawColor(CatchTheBallMenu[playerid][4], -1);
TextDrawSetShadow(CatchTheBallMenu[playerid][4], 0);
TextDrawBackgroundColor(CatchTheBallMenu[playerid][4], 255);
TextDrawFont(CatchTheBallMenu[playerid][4], 4);
TextDrawSetProportional(CatchTheBallMenu[playerid][4], 0);
TextDrawSetSelectable(CatchTheBallMenu[playerid][4], true);

CatchTheBallMenu[playerid][5] = TextDrawCreate(301.000000, 188.370330, "Settings");
TextDrawLetterSize(CatchTheBallMenu[playerid][5], 0.400000, 1.600000);
TextDrawAlignment(CatchTheBallMenu[playerid][5], 2);
TextDrawColor(CatchTheBallMenu[playerid][5], 255);
TextDrawSetShadow(CatchTheBallMenu[playerid][5], 0);
TextDrawBackgroundColor(CatchTheBallMenu[playerid][5], 255);
TextDrawFont(CatchTheBallMenu[playerid][5], 1);
TextDrawSetProportional(CatchTheBallMenu[playerid][5], 1);

CatchTheBallMenu[playerid][6] = TextDrawCreate(226.199707, 224.000000, "LD_SPAC:white");
TextDrawTextSize(CatchTheBallMenu[playerid][6], 149.589965, 35.799850);
TextDrawAlignment(CatchTheBallMenu[playerid][6], 1);
TextDrawColor(CatchTheBallMenu[playerid][6], -1);
TextDrawSetShadow(CatchTheBallMenu[playerid][6], 0);
TextDrawBackgroundColor(CatchTheBallMenu[playerid][6], 255);
TextDrawFont(CatchTheBallMenu[playerid][6], 4);
TextDrawSetProportional(CatchTheBallMenu[playerid][6], 0);
TextDrawSetSelectable(CatchTheBallMenu[playerid][6], true);

CatchTheBallMenu[playerid][7] = TextDrawCreate(301.000000, 231.370330, "Exit");
TextDrawLetterSize(CatchTheBallMenu[playerid][7], 0.400000, 1.600000);
TextDrawAlignment(CatchTheBallMenu[playerid][7], 2);
TextDrawColor(CatchTheBallMenu[playerid][7], -16776961);
TextDrawSetShadow(CatchTheBallMenu[playerid][7], 0);
TextDrawBackgroundColor(CatchTheBallMenu[playerid][7], 255);
TextDrawFont(CatchTheBallMenu[playerid][7], 1);
TextDrawSetProportional(CatchTheBallMenu[playerid][7], 1);

LeaveCatchBall[playerid][0] = TextDrawCreate(429.368377, 62.796260, "LD_SPAC:white");
TextDrawTextSize(LeaveCatchBall[playerid][0], 21.469816, 18.000000);
TextDrawAlignment(LeaveCatchBall[playerid][0], 1);
TextDrawColor(LeaveCatchBall[playerid][0], -16776961);
TextDrawSetShadow(LeaveCatchBall[playerid][0], 0);
TextDrawBackgroundColor(LeaveCatchBall[playerid][0], 255);
TextDrawFont(LeaveCatchBall[playerid][0], 4);
TextDrawSetProportional(LeaveCatchBall[playerid][0], 0);
TextDrawSetSelectable(LeaveCatchBall[playerid][0], true);

LeaveCatchBall[playerid][1] = TextDrawCreate(435.666717, 63.481468, "X");
TextDrawLetterSize(LeaveCatchBall[playerid][1], 0.400000, 1.600000);
TextDrawAlignment(LeaveCatchBall[playerid][1], 1);
TextDrawColor(LeaveCatchBall[playerid][1], -1);
TextDrawSetShadow(LeaveCatchBall[playerid][1], 0);
TextDrawBackgroundColor(LeaveCatchBall[playerid][1], 255);
TextDrawFont(LeaveCatchBall[playerid][1], 1);
TextDrawSetProportional(LeaveCatchBall[playerid][1], 1);

LeaveCatchBall[playerid][2] = TextDrawCreate(360.269134, 62.796260, "LD_SPAC:white");
TextDrawTextSize(LeaveCatchBall[playerid][2], 68.939773, 18.000000);
TextDrawAlignment(LeaveCatchBall[playerid][2], 1);
TextDrawColor(LeaveCatchBall[playerid][2], 65535);
TextDrawSetShadow(LeaveCatchBall[playerid][2], 0);
TextDrawBackgroundColor(LeaveCatchBall[playerid][2], 255);
TextDrawFont(LeaveCatchBall[playerid][2], 4);
TextDrawSetProportional(LeaveCatchBall[playerid][2], 0);

LeaveCatchBall[playerid][3] = TextDrawCreate(364.166717, 64.311103, "Points:_123456");
TextDrawLetterSize(LeaveCatchBall[playerid][3], 0.256332, 1.496296);
TextDrawAlignment(LeaveCatchBall[playerid][3], 1);
TextDrawColor(LeaveCatchBall[playerid][3], -65281);
TextDrawSetShadow(LeaveCatchBall[playerid][3], 0);
TextDrawBackgroundColor(LeaveCatchBall[playerid][3], 255);
TextDrawFont(LeaveCatchBall[playerid][3], 1);
TextDrawSetProportional(LeaveCatchBall[playerid][3], 1);

LeaveCatchBall[playerid][4] = TextDrawCreate(373.000122, 79.659240, "MISSED!");
TextDrawLetterSize(LeaveCatchBall[playerid][4], 0.345000, 1.641481);
TextDrawAlignment(LeaveCatchBall[playerid][4], 1);
TextDrawColor(LeaveCatchBall[playerid][4], -16776961);
TextDrawSetShadow(LeaveCatchBall[playerid][4], 0);
TextDrawBackgroundColor(LeaveCatchBall[playerid][4], 255);
TextDrawFont(LeaveCatchBall[playerid][4], 1);
TextDrawSetProportional(LeaveCatchBall[playerid][4], 1);


ComputerBildschirm[playerid][0] = TextDrawCreate(147.000030, 37.607418, "LD_SPAC:white");
TextDrawTextSize(ComputerBildschirm[playerid][0], 314.000000, 25.000000);
TextDrawAlignment(ComputerBildschirm[playerid][0], 1);
TextDrawColor(ComputerBildschirm[playerid][0], -1);
TextDrawSetShadow(ComputerBildschirm[playerid][0], 0);
TextDrawBackgroundColor(ComputerBildschirm[playerid][0], 255);
TextDrawFont(ComputerBildschirm[playerid][0], 4);
TextDrawSetProportional(ComputerBildschirm[playerid][0], 0);

ComputerBildschirm[playerid][1] = TextDrawCreate(131.300048, 345.807708, "LD_SPAC:white");
TextDrawTextSize(ComputerBildschirm[playerid][1], 345.6000000, 29.000000);
TextDrawAlignment(ComputerBildschirm[playerid][1], 1);
TextDrawColor(ComputerBildschirm[playerid][1], -1);
TextDrawSetShadow(ComputerBildschirm[playerid][1], 0);
TextDrawBackgroundColor(ComputerBildschirm[playerid][1], 255);
TextDrawFont(ComputerBildschirm[playerid][1], 4);
TextDrawSetProportional(ComputerBildschirm[playerid][1], 0);

ComputerBildschirm[playerid][2] = TextDrawCreate(157.500030, 37.607418, "LD_SPAC:white");
TextDrawTextSize(ComputerBildschirm[playerid][2], -26.140434, 320.250091);
TextDrawAlignment(ComputerBildschirm[playerid][2], 1);
TextDrawColor(ComputerBildschirm[playerid][2], -1);
TextDrawSetShadow(ComputerBildschirm[playerid][2], 0);
TextDrawBackgroundColor(ComputerBildschirm[playerid][2], 255);
TextDrawFont(ComputerBildschirm[playerid][2], 4);
TextDrawSetProportional(ComputerBildschirm[playerid][2], 0);

ComputerBildschirm[playerid][3] = TextDrawCreate(476.935028, 37.607418, "LD_SPAC:white");
TextDrawTextSize(ComputerBildschirm[playerid][3], -26.140434, 320.250091);
TextDrawAlignment(ComputerBildschirm[playerid][3], 1);
TextDrawColor(ComputerBildschirm[playerid][3], -1);
TextDrawSetShadow(ComputerBildschirm[playerid][3], 0);
TextDrawBackgroundColor(ComputerBildschirm[playerid][3], 255);
TextDrawFont(ComputerBildschirm[playerid][3], 4);
TextDrawSetProportional(ComputerBildschirm[playerid][3], 0);
return 1;
}


public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
   if (newkeys == KEY_WALK)
   {
	  TextDrawShowForPlayer(playerid, ComputerBildschirm[playerid][0]);
	  TextDrawShowForPlayer(playerid, ComputerBildschirm[playerid][1]);
	  TextDrawShowForPlayer(playerid, ComputerBildschirm[playerid][2]);
	  TextDrawShowForPlayer(playerid, ComputerBildschirm[playerid][3]);
      TextDrawShowForPlayer(playerid, GameBackGround[playerid]);
	  TextDrawShowForPlayer(playerid, CatchTheBallMenu[playerid][0]);
	  TextDrawShowForPlayer(playerid, CatchTheBallMenu[playerid][1]);
	  TextDrawShowForPlayer(playerid, CatchTheBallMenu[playerid][2]);
	  TextDrawShowForPlayer(playerid, CatchTheBallMenu[playerid][3]);
	  TextDrawShowForPlayer(playerid, CatchTheBallMenu[playerid][4]);
	  TextDrawShowForPlayer(playerid, CatchTheBallMenu[playerid][5]);
	  TextDrawShowForPlayer(playerid, CatchTheBallMenu[playerid][6]);
	  TextDrawShowForPlayer(playerid, CatchTheBallMenu[playerid][7]);
	  /*TextDrawShowForPlayer(playerid, LeaveCatchBall[playerid][0]);
	  TextDrawShowForPlayer(playerid, LeaveCatchBall[playerid][1]);
	  TextDrawShowForPlayer(playerid, LeaveCatchBall[playerid][2]);
	  TextDrawShowForPlayer(playerid, LeaveCatchBall[playerid][3]);
	  TextDrawShowForPlayer(playerid, LeaveCatchBall[playerid][4]);*/
	  CatchBallGameState[playerid] = 1;
      SelectTextDraw(playerid, TextdrawFarbe);
   }
   return 1;
}

public OnPlayerClickTextDraw(playerid, Text:clickedid)
{
   if(clickedid == CatchTheBallMenu[playerid][2])
   {
	  if(CatchBallGameState[playerid] == 3)
	  {
	     TextDrawSetString(CatchTheBallMenu[playerid][3], "Play");
	     TextDrawSetString(CatchTheBallMenu[playerid][5], "Settings");
	     TextDrawSetString(CatchTheBallMenu[playerid][7], "Exit");
	     TextDrawColor(CatchTheBallMenu[playerid][7], -16776961);
	     TextDrawShowForPlayer(playerid, CatchTheBallMenu[playerid][7]);
	     TextDrawShowForPlayer(playerid, CatchTheBallMenu[playerid][1]);
	     TextDrawSetString(CatchTheBallMenu[playerid][0], "Catch_The_Ball!");
	     TextDrawFont(CatchTheBallMenu[playerid][0], 2);
	     TextDrawColor(CatchTheBallMenu[playerid][0], 41215);
	     TextDrawShowForPlayer(playerid, CatchTheBallMenu[playerid][0]);
	     CatchBallDifficulty[playerid] = 1;
         format(Spieler,sizeof(Spieler),"/Spieler/%s.txt",GetSname(playerid));
         dini_IntSet(Spieler, "CatchTheBallDifficulty", CatchBallDifficulty[playerid]);
	     CatchBallGameState[playerid] = 1;
		 return 1;
	  }
	  TextDrawShowForPlayer(playerid, LeaveCatchBall[playerid][0]);
	  TextDrawShowForPlayer(playerid, LeaveCatchBall[playerid][1]);
	  TextDrawShowForPlayer(playerid, LeaveCatchBall[playerid][2]);
	  TextDrawShowForPlayer(playerid, LeaveCatchBall[playerid][3]);
	  //TextDrawShowForPlayer(playerid, LeaveCatchBall[playerid][4]);//Missed
	  TextDrawHideForPlayer(playerid, CatchTheBallMenu[playerid][0]);
	  TextDrawHideForPlayer(playerid, CatchTheBallMenu[playerid][1]);
	  TextDrawHideForPlayer(playerid, CatchTheBallMenu[playerid][2]);
	  TextDrawHideForPlayer(playerid, CatchTheBallMenu[playerid][3]);
	  TextDrawHideForPlayer(playerid, CatchTheBallMenu[playerid][4]);
	  TextDrawHideForPlayer(playerid, CatchTheBallMenu[playerid][5]);
	  TextDrawHideForPlayer(playerid, CatchTheBallMenu[playerid][6]);
	  TextDrawHideForPlayer(playerid, CatchTheBallMenu[playerid][7]);
	  new string[20];
	  format(string, sizeof string, "Points:_%i", CatchBallPoints[playerid]);
	  TextDrawSetString(LeaveCatchBall[playerid][3], string);
	  CatchBallGameState[playerid] = 2;
	  CatchBallGame(playerid);
	  return 1;
   }
   if(clickedid == CatchTheBallMenu[playerid][4])
   {
	  if(CatchBallGameState[playerid] == 3)
	  {
	     TextDrawSetString(CatchTheBallMenu[playerid][3], "Play");
	     TextDrawSetString(CatchTheBallMenu[playerid][5], "Settings");
	     TextDrawSetString(CatchTheBallMenu[playerid][7], "Exit");
	     TextDrawColor(CatchTheBallMenu[playerid][7], -16776961);
	     TextDrawShowForPlayer(playerid, CatchTheBallMenu[playerid][7]);
	     TextDrawShowForPlayer(playerid, CatchTheBallMenu[playerid][1]);
	     TextDrawSetString(CatchTheBallMenu[playerid][0], "Catch_The_Ball!");
	     TextDrawFont(CatchTheBallMenu[playerid][0], 2);
	     TextDrawColor(CatchTheBallMenu[playerid][0], 41215);
	     TextDrawShowForPlayer(playerid, CatchTheBallMenu[playerid][0]);
	     CatchBallDifficulty[playerid] = 2;
         format(Spieler,sizeof(Spieler),"/Spieler/%s.txt",GetSname(playerid));
         dini_IntSet(Spieler, "CatchTheBallDifficulty", CatchBallDifficulty[playerid]);
	     CatchBallGameState[playerid] = 1;
		 return 1;
	  }
	  TextDrawSetString(CatchTheBallMenu[playerid][3], "Easy");
	  TextDrawSetString(CatchTheBallMenu[playerid][5], "Normal");
	  TextDrawSetString(CatchTheBallMenu[playerid][7], "Hard");
	  TextDrawColor(CatchTheBallMenu[playerid][7], 255);
	  TextDrawShowForPlayer(playerid, CatchTheBallMenu[playerid][7]);
	  TextDrawHideForPlayer(playerid, CatchTheBallMenu[playerid][1]);
	  TextDrawSetString(CatchTheBallMenu[playerid][0], "Difficulty");
	  TextDrawFont(CatchTheBallMenu[playerid][0], 1);
	  TextDrawColor(CatchTheBallMenu[playerid][0], -1);
	  TextDrawShowForPlayer(playerid, CatchTheBallMenu[playerid][0]);
	  CatchBallGameState[playerid] = 3;
	  return 1;
   }
   if(clickedid == CatchTheBallMenu[playerid][6])
   {
	  if(CatchBallGameState[playerid] == 3)
	  {
	     TextDrawSetString(CatchTheBallMenu[playerid][3], "Play");
	     TextDrawSetString(CatchTheBallMenu[playerid][5], "Settings");
	     TextDrawSetString(CatchTheBallMenu[playerid][7], "Exit");
	     TextDrawColor(CatchTheBallMenu[playerid][7], -16776961);
	     TextDrawShowForPlayer(playerid, CatchTheBallMenu[playerid][7]);
	     TextDrawShowForPlayer(playerid, CatchTheBallMenu[playerid][1]);
	     TextDrawSetString(CatchTheBallMenu[playerid][0], "Catch_The_Ball!");
	     TextDrawFont(CatchTheBallMenu[playerid][0], 2);
	     TextDrawColor(CatchTheBallMenu[playerid][0], 41215);
	     TextDrawShowForPlayer(playerid, CatchTheBallMenu[playerid][0]);
	     CatchBallDifficulty[playerid] = 3;
         format(Spieler,sizeof(Spieler),"/Spieler/%s.txt",GetSname(playerid));
         dini_IntSet(Spieler, "CatchTheBallDifficulty", CatchBallDifficulty[playerid]);
	     CatchBallGameState[playerid] = 1;
		 return 1;
	  }
	  TextDrawHideForPlayer(playerid, ComputerBildschirm[playerid][0]);
	  TextDrawHideForPlayer(playerid, ComputerBildschirm[playerid][1]);
	  TextDrawHideForPlayer(playerid, ComputerBildschirm[playerid][2]);
	  TextDrawHideForPlayer(playerid, ComputerBildschirm[playerid][3]);
      TextDrawHideForPlayer(playerid, GameBackGround[playerid]);
	  TextDrawHideForPlayer(playerid, CatchTheBallMenu[playerid][0]);
	  TextDrawHideForPlayer(playerid, CatchTheBallMenu[playerid][1]);
	  TextDrawHideForPlayer(playerid, CatchTheBallMenu[playerid][2]);
	  TextDrawHideForPlayer(playerid, CatchTheBallMenu[playerid][3]);
	  TextDrawHideForPlayer(playerid, CatchTheBallMenu[playerid][4]);
	  TextDrawHideForPlayer(playerid, CatchTheBallMenu[playerid][5]);
	  TextDrawHideForPlayer(playerid, CatchTheBallMenu[playerid][6]);
	  TextDrawHideForPlayer(playerid, CatchTheBallMenu[playerid][7]);
	  TextDrawHideForPlayer(playerid, LeaveCatchBall[playerid][0]);
	  TextDrawHideForPlayer(playerid, LeaveCatchBall[playerid][1]);
	  TextDrawHideForPlayer(playerid, LeaveCatchBall[playerid][2]);
	  TextDrawHideForPlayer(playerid, LeaveCatchBall[playerid][3]);
	  TextDrawHideForPlayer(playerid, LeaveCatchBall[playerid][4]);
	  TextDrawHideForPlayer(playerid, BallCatchBall[playerid]);
	  CatchBallGameState[playerid] = -1;
	  CancelSelectTextDraw(playerid);
	  return 1;
   }
   if(clickedid == LeaveCatchBall[playerid][0])
   {
	  TextDrawHideForPlayer(playerid, LeaveCatchBall[playerid][0]);
	  TextDrawHideForPlayer(playerid, LeaveCatchBall[playerid][1]);
	  TextDrawHideForPlayer(playerid, LeaveCatchBall[playerid][2]);
	  TextDrawHideForPlayer(playerid, LeaveCatchBall[playerid][3]);
	  TextDrawHideForPlayer(playerid, LeaveCatchBall[playerid][4]);
	  TextDrawShowForPlayer(playerid, CatchTheBallMenu[playerid][0]);
	  TextDrawShowForPlayer(playerid, CatchTheBallMenu[playerid][1]);
	  TextDrawShowForPlayer(playerid, CatchTheBallMenu[playerid][2]);
	  TextDrawShowForPlayer(playerid, CatchTheBallMenu[playerid][3]);
	  TextDrawShowForPlayer(playerid, CatchTheBallMenu[playerid][4]);
	  TextDrawShowForPlayer(playerid, CatchTheBallMenu[playerid][5]);
	  TextDrawShowForPlayer(playerid, CatchTheBallMenu[playerid][6]);
	  TextDrawShowForPlayer(playerid, CatchTheBallMenu[playerid][7]);
	  TextDrawHideForPlayer(playerid, BallCatchBall[playerid]);
	  TextDrawDestroy(BallCatchBall[playerid]);
	  CatchBallGameState[playerid] = 1;
	  return 1;
   }
   if(clickedid == BallCatchBall[playerid])
   {
	  TextDrawHideForPlayer(playerid, BallCatchBall[playerid]);
	  TextDrawDestroy(BallCatchBall[playerid]);
	  CatchBallPoints[playerid] = CatchBallPoints[playerid] +( 2 * CatchBallDifficulty[playerid] - 1);
	  format(Spieler, sizeof Spieler, "Points:_%i", CatchBallPoints[playerid]);
	  TextDrawSetString(LeaveCatchBall[playerid][3], Spieler);
      format(Spieler,sizeof(Spieler),"/Spieler/%s.txt",GetSname(playerid));
      dini_IntSet(Spieler, "CatchTheBallPunkte", CatchBallPoints[playerid]);
      TextDrawHideForPlayer(playerid, LeaveCatchBall[playerid][4]);
	  CatchBallGame(playerid);
	  return 1;
   }
   return 1;
}

stock RandomTextDrawColor()
{
   new Randomcolor = random(20);
   switch (Randomcolor)
   {
      case 0: return 0xA52A2AFF;
      case 1: return 0xFF0000FF;
      case 2: return 0xFFFFFFFF;
      case 3: return 0x00FFFFFF;
      case 4: return 0xC0C0C0FF;
      case 5: return 0x0000FFFF;
      case 6: return 0xA52A2AFF;
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

stock GetRandomBallShape()
{
   new Randomcolor = random(2);
   new string[15];
   switch (Randomcolor)
   {
      case 0: string = "LD_BEAT:chit";
      case 1: string = "LD_BEAT:cring";
   }
   return string;
}

/*TDEditor_TD[0] = TextDrawCreate(150.666793, 57.103698, "LD_BEAT:cring");
TextDrawTextSize(TDEditor_TD[0], 60.000000, 69.000000);
TextDrawFont(TDEditor_TD[0], 4);

TDEditor_TD[1] = TextDrawCreate(395.333465, 287.326110, "LD_BEAT:cring");
TextDrawTextSize(TDEditor_TD[1], 60.000000, 69.000000);
TextDrawFont(TDEditor_TD[1], 4);*/

stock CatchBallGame(playerid)
{
   KillTimer(CatchBallTimer);
   if(CatchBallGameState[playerid] != 2) return 1;
   new Float:X, Float:Y;
   new CatchBallTime;
   X = random(245) + 149 + CatchBallDifficulty[playerid] * 3;
   Y = random(230) + 56 + CatchBallDifficulty[playerid] * 3;
   BallCatchBall[playerid] = TextDrawCreate(X, Y, GetRandomBallShape());
   TextDrawTextSize(BallCatchBall[playerid], (60.0/CatchBallDifficulty[playerid]), (69.0/CatchBallDifficulty[playerid]));
   TextDrawFont(BallCatchBall[playerid], 4);
   TextDrawColor(BallCatchBall[playerid], RandomTextDrawColor());
   TextDrawSetSelectable(BallCatchBall[playerid], true);
   TextDrawShowForPlayer(playerid, BallCatchBall[playerid]);
   CatchBallTime = (random(60) + 10 + (120 / CatchBallDifficulty[playerid])) *10;
   new string[20];
   format(string, sizeof string, "%i", CatchBallTime);
   SendClientMessage(playerid, Weis, string);
   CatchBallTimer = SetTimerEx("CatchBallMissed", CatchBallTime, false, "%i", playerid);
   return 1;
}

forward CatchBallMissed(playerid);
public CatchBallMissed(playerid)
{
   TextDrawHideForPlayer(playerid, BallCatchBall[playerid]);
   if(CatchBallGameState[playerid] != 2) return 1;
   TextDrawShowForPlayer(playerid, LeaveCatchBall[playerid][4]);
   TextDrawDestroy(BallCatchBall[playerid]);
   CatchBallPoints[playerid] = CatchBallPoints[playerid] -1;
   format(Spieler, sizeof Spieler, "Points:_%i", CatchBallPoints[playerid]);
   TextDrawSetString(LeaveCatchBall[playerid][3], Spieler);
   format(Spieler,sizeof(Spieler),"/Spieler/%s.txt",GetSname(playerid));
   dini_IntSet(Spieler, "CatchTheBallPunkte", CatchBallPoints[playerid]);
   CatchBallGame(playerid);
   return 1;
}
