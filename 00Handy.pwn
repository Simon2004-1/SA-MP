#include a_samp
#include dini
#include 0SimonsInclude

new Spieler[64];

new HandyShowing[MAX_PLAYERS];
new HandyCaller[MAX_PLAYERS];
new HandyCalling[MAX_PLAYERS];
new WaitForCallingTimer;
new Handyliedtimer;

new PlayerText:Handy[MAX_PLAYERS];
new PlayerText:HandyPlatzhalter[MAX_PLAYERS];
new PlayerText:HandyBildschirm[MAX_PLAYERS];
new PlayerText:HandyAnrufen[MAX_PLAYERS][3];
new PlayerText:HandyAuflegen[MAX_PLAYERS][3];
new PlayerText:HandyZruck[MAX_PLAYERS];
new PlayerText:HandyTelefonbuchZruck[MAX_PLAYERS];
new PlayerText:HandyAnrufenZruck[MAX_PLAYERS];
new PlayerText:HandyHome[MAX_PLAYERS][3];
new PlayerText:HandyTasten[MAX_PLAYERS][30];
new PlayerText:HandyZeit[MAX_PLAYERS];
new PlayerText:HandyOrt[MAX_PLAYERS];
new PlayerText:HandyTelefonbuch[MAX_PLAYERS][6];
new PlayerText:HandyCalender[MAX_PLAYERS][5];
new PlayerText:HandyCalender_Monday[MAX_PLAYERS];
new PlayerText:HandyCalender_Tuesday[MAX_PLAYERS];
new PlayerText:HandyCalender_Wednesday[MAX_PLAYERS];
new PlayerText:HandyCalender_Thursday[MAX_PLAYERS];
new PlayerText:HandyCalender_Friday[MAX_PLAYERS];
new PlayerText:HandyCalender_Saturday[MAX_PLAYERS];
new PlayerText:HandyCalender_Sunday[MAX_PLAYERS];
new PlayerText:HandyCalender_Monday_[MAX_PLAYERS];
new PlayerText:HandyCalender_Tuesday_[MAX_PLAYERS];
new PlayerText:HandyCalender_Wednesday_[MAX_PLAYERS];
new PlayerText:HandyCalender_Thursday_[MAX_PLAYERS];
new PlayerText:HandyCalender_Friday_[MAX_PLAYERS];
new PlayerText:HandyCalender_Saturday_[MAX_PLAYERS];
new PlayerText:HandyCalender_Sunday_[MAX_PLAYERS];
new PlayerText:HandyMusik[MAX_PLAYERS][7];
new PlayerText:HandyEinstellungen[MAX_PLAYERS][3];
new PlayerText:Handy_Telefonbuch_AlleK[MAX_PLAYERS][5];
new PlayerText:Handy_Telefonbuch_Freunde[MAX_PLAYERS][7];
new PlayerText:Handy_Telefonbuch_publicService[MAX_PLAYERS][2];
new PlayerText:Handy_Telefonbuch_Suchen[MAX_PLAYERS][4];
new PlayerText:HandyAddFriendContact[MAX_PLAYERS];
new PlayerText:HandyAddFriendContact_[MAX_PLAYERS];
new PlayerText:HandyCallContact[MAX_PLAYERS];
new PlayerText:HandyCallContact_[MAX_PLAYERS];
new PlayerText:HandyCHProfile[MAX_PLAYERS];
new PlayerText:HandyCHProfile_[MAX_PLAYERS];
new PlayerText:HandyInfo_Nummer[MAX_PLAYERS];
new PlayerText:HandyInfo_Status[MAX_PLAYERS];
new PlayerText:HandyKontaktProfilFarbe[MAX_PLAYERS];
new PlayerText:HandyKontaktProfilBild[MAX_PLAYERS];
new PlayerText:HandyKlingelton[MAX_PLAYERS];
new PlayerText:HandyKlingelton1[MAX_PLAYERS];
new PlayerText:HandyKlingelton2[MAX_PLAYERS];
new PlayerText:HandyKlingelton3[MAX_PLAYERS];
new PlayerText:HandyKlingelton1_[MAX_PLAYERS];
new PlayerText:HandyKlingelton2_[MAX_PLAYERS];
new PlayerText:HandyKlingelton3_[MAX_PLAYERS];
new PlayerText:HandyNachrichtenton[MAX_PLAYERS];
new PlayerText:HandyNachrichtenton1[MAX_PLAYERS];
new PlayerText:HandyNachrichtenton2[MAX_PLAYERS];
new PlayerText:HandyNachrichtenton3[MAX_PLAYERS];
new PlayerText:HandyNachrichtenton1_[MAX_PLAYERS];
new PlayerText:HandyNachrichtenton2_[MAX_PLAYERS];
new PlayerText:HandyNachrichtenton3_[MAX_PLAYERS];
new PlayerText:HandyMute[MAX_PLAYERS][5];
new PlayerText:HandyTonEinstellungen[MAX_PLAYERS][4];
new PlayerText:HandyEinstellungenZruck[MAX_PLAYERS];
new PlayerText:HandyAnrufMenu[MAX_PLAYERS][7];
new PlayerText:HandyAngerufen[MAX_PLAYERS][4];
new PlayerText:HandyMusikApp[MAX_PLAYERS][16];

public OnPlayerConnect(playerid)
{
HandyCaller[playerid] = -1;
HandyCalling[playerid] = -1;
HandyShowing[playerid] = 0;
DeletePVar(playerid, "HandyAnrufState");
DeletePVar(playerid, "Handypause");
DeletePVar(playerid, "HandyKontakteSkroll");
DeletePVar(playerid, "HandyKontakte");
DeletePVar(playerid, "HandyServicesSkroll");
DeletePVar(playerid, "HandyPublicService");
DeletePVar(playerid, "HandyFreundeSkroll");
DeletePVar(playerid, "HandyFreundesliste");
Handy[playerid] = CreatePlayerTextDraw(playerid, 522.667358, 184.451751, "LD_SPAC:white");
PlayerTextDrawTextSize(playerid, Handy[playerid], 111.000000, 257.000000);
PlayerTextDrawAlignment(playerid, Handy[playerid], 1);
PlayerTextDrawColor(playerid, Handy[playerid], -1);
PlayerTextDrawSetShadow(playerid, Handy[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, Handy[playerid], 255);
PlayerTextDrawFont(playerid, Handy[playerid], 4);
PlayerTextDrawSetProportional(playerid, Handy[playerid], 0);

HandyPlatzhalter[playerid] = CreatePlayerTextDraw(playerid, 531.667236, 199.385345, "LD_SPAC:white");
PlayerTextDrawTextSize(playerid, HandyPlatzhalter[playerid], 95.000000, 13.000000);
PlayerTextDrawAlignment(playerid, HandyPlatzhalter[playerid], 1);
PlayerTextDrawColor(playerid, HandyPlatzhalter[playerid], 255);
PlayerTextDrawSetShadow(playerid, HandyPlatzhalter[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, HandyPlatzhalter[playerid], 255);
PlayerTextDrawFont(playerid, HandyPlatzhalter[playerid], 4);
PlayerTextDrawSetProportional(playerid, HandyPlatzhalter[playerid], 0);

HandyZeit[playerid] = CreatePlayerTextDraw(playerid, 623.332824, 201.200027, "00:00");
PlayerTextDrawLetterSize(playerid, HandyZeit[playerid], 0.179333, 1.010963);
PlayerTextDrawColor(playerid,HandyZeit[playerid], -1);
PlayerTextDrawAlignment(playerid, HandyZeit[playerid], 3);
PlayerTextDrawBoxColor(playerid, HandyZeit[playerid], 255);
PlayerTextDrawSetShadow(playerid, HandyZeit[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, HandyZeit[playerid], 255);
PlayerTextDrawFont(playerid, HandyZeit[playerid], 1);
PlayerTextDrawSetProportional(playerid, HandyZeit[playerid], 1);

HandyOrt[playerid] = CreatePlayerTextDraw(playerid, 533.667053, 201.540710, "No GPS");
PlayerTextDrawLetterSize(playerid, HandyOrt[playerid], 0.168665, 0.907257);
PlayerTextDrawTextSize(playerid, HandyOrt[playerid], 626.000000, 0.000000);
PlayerTextDrawAlignment(playerid, HandyOrt[playerid], 1);
PlayerTextDrawColor(playerid, HandyOrt[playerid], -1);
PlayerTextDrawUseBox(playerid, HandyOrt[playerid], 0);
PlayerTextDrawBoxColor(playerid, HandyOrt[playerid], 255);
PlayerTextDrawSetShadow(playerid, HandyOrt[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, HandyOrt[playerid], 255);
PlayerTextDrawFont(playerid, HandyOrt[playerid], 1);
PlayerTextDrawSetProportional(playerid, HandyOrt[playerid], 1);

HandyBildschirm[playerid] = CreatePlayerTextDraw(playerid, 531.666564, 212.244445, "LD_SPAC:white");
PlayerTextDrawTextSize(playerid, HandyBildschirm[playerid], 94.761016, 93.230690);
PlayerTextDrawAlignment(playerid, HandyBildschirm[playerid], 1);
PlayerTextDrawColor(playerid, HandyBildschirm[playerid], -1061109505);
PlayerTextDrawSetShadow(playerid, HandyBildschirm[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, HandyBildschirm[playerid], 255);
PlayerTextDrawFont(playerid, HandyBildschirm[playerid], 4);
PlayerTextDrawSetProportional(playerid, HandyBildschirm[playerid], 0);

HandyAnrufen[playerid][1] = CreatePlayerTextDraw(playerid, 531.433776, 313.044281, "LD_SPAC:white");
PlayerTextDrawTextSize(playerid, HandyAnrufen[playerid][1], 35.000000, 18.000000);
PlayerTextDrawAlignment(playerid, HandyAnrufen[playerid][1], 1);
PlayerTextDrawColor(playerid, HandyAnrufen[playerid][1], 16711935);
PlayerTextDrawSetShadow(playerid, HandyAnrufen[playerid][1], 0);
PlayerTextDrawBackgroundColor(playerid, HandyAnrufen[playerid][1], 255);
PlayerTextDrawFont(playerid, HandyAnrufen[playerid][1], 4);
PlayerTextDrawSetProportional(playerid, HandyAnrufen[playerid][1], 0);

HandyAuflegen[playerid][1] = CreatePlayerTextDraw(playerid, 591.666625, 313.044281, "LD_SPAC:white");
PlayerTextDrawTextSize(playerid, HandyAuflegen[playerid][1], 35.000000, 18.000000);
PlayerTextDrawAlignment(playerid, HandyAuflegen[playerid][1], 1);
PlayerTextDrawColor(playerid, HandyAuflegen[playerid][1], -16776961);
PlayerTextDrawSetShadow(playerid, HandyAuflegen[playerid][1], 0);
PlayerTextDrawBackgroundColor(playerid, HandyAuflegen[playerid][1], 255);
PlayerTextDrawFont(playerid, HandyAuflegen[playerid][1], 4);
PlayerTextDrawSetProportional(playerid, HandyAuflegen[playerid][1], 0);

HandyAnrufen[playerid][0] = CreatePlayerTextDraw(playerid, 533.067016, 314.703552, "LD_SPAC:white");
PlayerTextDrawTextSize(playerid, HandyAnrufen[playerid][0], 32.000000, 15.000000);
PlayerTextDrawAlignment(playerid, HandyAnrufen[playerid][0], 1);
PlayerTextDrawColor(playerid, HandyAnrufen[playerid][0], -1);
PlayerTextDrawSetShadow(playerid, HandyAnrufen[playerid][0], 0);
PlayerTextDrawBackgroundColor(playerid, HandyAnrufen[playerid][0], 255);
PlayerTextDrawFont(playerid, HandyAnrufen[playerid][0], 4);
PlayerTextDrawSetProportional(playerid, HandyAnrufen[playerid][0], 0);
PlayerTextDrawSetSelectable(playerid, HandyAnrufen[playerid][0], true);

HandyAuflegen[playerid][0] = CreatePlayerTextDraw(playerid, 593.133911, 314.703552, "LD_SPAC:white");
PlayerTextDrawTextSize(playerid, HandyAuflegen[playerid][0], 32.000000, 15.000000);
PlayerTextDrawAlignment(playerid, HandyAuflegen[playerid][0], 1);
PlayerTextDrawColor(playerid, HandyAuflegen[playerid][0], -1);
PlayerTextDrawSetShadow(playerid, HandyAuflegen[playerid][0], 0);
PlayerTextDrawBackgroundColor(playerid, HandyAuflegen[playerid][0], 255);
PlayerTextDrawFont(playerid, HandyAuflegen[playerid][0], 4);
PlayerTextDrawSetProportional(playerid, HandyAuflegen[playerid][0], 0);
PlayerTextDrawSetSelectable(playerid, HandyAuflegen[playerid][0], true);

HandyZruck[playerid] = CreatePlayerTextDraw(playerid, 593.133911, 314.703552, "LD_SPAC:white");
PlayerTextDrawTextSize(playerid, HandyZruck[playerid], 32.000000, 15.000000);
PlayerTextDrawAlignment(playerid, HandyZruck[playerid], 1);
PlayerTextDrawColor(playerid, HandyZruck[playerid], -1);
PlayerTextDrawSetShadow(playerid, HandyZruck[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, HandyZruck[playerid], 255);
PlayerTextDrawFont(playerid, HandyZruck[playerid], 4);
PlayerTextDrawSetProportional(playerid, HandyZruck[playerid], 0);
PlayerTextDrawSetSelectable(playerid, HandyZruck[playerid], true);

HandyTelefonbuchZruck[playerid] = CreatePlayerTextDraw(playerid, 593.133911, 314.703552, "LD_SPAC:white");
PlayerTextDrawTextSize(playerid, HandyTelefonbuchZruck[playerid], 32.000000, 15.000000);
PlayerTextDrawAlignment(playerid, HandyTelefonbuchZruck[playerid], 1);
PlayerTextDrawColor(playerid, HandyTelefonbuchZruck[playerid], -1);
PlayerTextDrawSetShadow(playerid, HandyTelefonbuchZruck[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, HandyTelefonbuchZruck[playerid], 255);
PlayerTextDrawFont(playerid, HandyTelefonbuchZruck[playerid], 4);
PlayerTextDrawSetProportional(playerid, HandyTelefonbuchZruck[playerid], 0);
PlayerTextDrawSetSelectable(playerid, HandyTelefonbuchZruck[playerid], true);

HandyAnrufenZruck[playerid] = CreatePlayerTextDraw(playerid, 593.133911, 314.703552, "LD_SPAC:white");
PlayerTextDrawTextSize(playerid, HandyAnrufenZruck[playerid], 32.000000, 15.000000);
PlayerTextDrawAlignment(playerid, HandyAnrufenZruck[playerid], 1);
PlayerTextDrawColor(playerid, HandyAnrufenZruck[playerid], -1);
PlayerTextDrawSetShadow(playerid, HandyAnrufenZruck[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, HandyAnrufenZruck[playerid], 255);
PlayerTextDrawFont(playerid, HandyAnrufenZruck[playerid], 4);
PlayerTextDrawSetProportional(playerid, HandyAnrufenZruck[playerid], 0);
PlayerTextDrawSetSelectable(playerid, HandyAnrufenZruck[playerid], true);

HandyEinstellungenZruck[playerid] = CreatePlayerTextDraw(playerid, 593.133911, 314.703552, "LD_SPAC:white");
PlayerTextDrawTextSize(playerid, HandyEinstellungenZruck[playerid], 32.000000, 15.000000);
PlayerTextDrawAlignment(playerid, HandyEinstellungenZruck[playerid], 1);
PlayerTextDrawColor(playerid, HandyEinstellungenZruck[playerid], -1);
PlayerTextDrawSetShadow(playerid, HandyEinstellungenZruck[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, HandyEinstellungenZruck[playerid], 255);
PlayerTextDrawFont(playerid, HandyEinstellungenZruck[playerid], 4);
PlayerTextDrawSetProportional(playerid, HandyEinstellungenZruck[playerid], 0);
PlayerTextDrawSetSelectable(playerid, HandyEinstellungenZruck[playerid], true);

HandyAnrufen[playerid][2] = CreatePlayerTextDraw(playerid, 538.000000, 326.059234, "U");
PlayerTextDrawLetterSize(playerid, HandyAnrufen[playerid][2], 0.988332, -0.785185);
PlayerTextDrawAlignment(playerid, HandyAnrufen[playerid][2], 1);
PlayerTextDrawColor(playerid, HandyAnrufen[playerid][2], 16711935);
PlayerTextDrawSetShadow(playerid, HandyAnrufen[playerid][2], 0);
PlayerTextDrawBackgroundColor(playerid, HandyAnrufen[playerid][2], 255);
PlayerTextDrawFont(playerid, HandyAnrufen[playerid][2], 1);
PlayerTextDrawSetProportional(playerid, HandyAnrufen[playerid][2], 1);

HandyAuflegen[playerid][2] = CreatePlayerTextDraw(playerid, 598.999938, 326.474060, "U");
PlayerTextDrawLetterSize(playerid, HandyAuflegen[playerid][2], 0.988332, -0.785185);
PlayerTextDrawAlignment(playerid, HandyAuflegen[playerid][2], 1);
PlayerTextDrawColor(playerid, HandyAuflegen[playerid][2], -16776961);
PlayerTextDrawSetShadow(playerid, HandyAuflegen[playerid][2], 0);
PlayerTextDrawBackgroundColor(playerid, HandyAuflegen[playerid][2], 255);
PlayerTextDrawFont(playerid, HandyAuflegen[playerid][2], 1);
PlayerTextDrawSetProportional(playerid, HandyAuflegen[playerid][2], 1);

HandyHome[playerid][1] = CreatePlayerTextDraw(playerid, 567.393188, 313.044281, "LD_SPAC:white");
PlayerTextDrawTextSize(playerid, HandyHome[playerid][1], 23.000000, 18.000000);
PlayerTextDrawAlignment(playerid, HandyHome[playerid][1], 1);
PlayerTextDrawColor(playerid, HandyHome[playerid][1], 255);
PlayerTextDrawSetShadow(playerid, HandyHome[playerid][1], 0);
PlayerTextDrawBackgroundColor(playerid, HandyHome[playerid][1], 255);
PlayerTextDrawFont(playerid, HandyHome[playerid][1], 4);
PlayerTextDrawSetProportional(playerid, HandyHome[playerid][1], 0);

HandyHome[playerid][0] = CreatePlayerTextDraw(playerid, 568.892822, 314.703552, "LD_SPAC:white");
PlayerTextDrawTextSize(playerid, HandyHome[playerid][0], 20.179912, 15.239958);
PlayerTextDrawAlignment(playerid, HandyHome[playerid][0], 1);
PlayerTextDrawColor(playerid, HandyHome[playerid][0], -1);
PlayerTextDrawSetShadow(playerid, HandyHome[playerid][0], 0);
PlayerTextDrawBackgroundColor(playerid, HandyHome[playerid][0], 255);
PlayerTextDrawFont(playerid, HandyHome[playerid][0], 4);
PlayerTextDrawSetProportional(playerid, HandyHome[playerid][0], 0);
PlayerTextDrawSetSelectable(playerid, HandyHome[playerid][0], true);

HandyHome[playerid][2] = CreatePlayerTextDraw(playerid, 573.666748, 318.022247, "hud:radar_propertyG");
PlayerTextDrawTextSize(playerid, HandyHome[playerid][2], 10.000000, 9.000000);
PlayerTextDrawAlignment(playerid, HandyHome[playerid][2], 1);
PlayerTextDrawColor(playerid, HandyHome[playerid][2], -1);
PlayerTextDrawSetShadow(playerid, HandyHome[playerid][2], 0);
PlayerTextDrawBackgroundColor(playerid, HandyHome[playerid][2], 255);
PlayerTextDrawFont(playerid, HandyHome[playerid][2], 4);
PlayerTextDrawSetProportional(playerid, HandyHome[playerid][2], 0);

HandyTasten[playerid][0] = CreatePlayerTextDraw(playerid, 565.985168, 413.744580, "LD_SPAC:white");
PlayerTextDrawTextSize(playerid, HandyTasten[playerid][0], 27.340099, 18.000000);
PlayerTextDrawAlignment(playerid, HandyTasten[playerid][0], 1);
PlayerTextDrawColor(playerid, HandyTasten[playerid][0], 0x565656FF);
PlayerTextDrawSetShadow(playerid, HandyTasten[playerid][0], 0);
PlayerTextDrawBackgroundColor(playerid, HandyTasten[playerid][0], 255);
PlayerTextDrawFont(playerid, HandyTasten[playerid][0], 4);
PlayerTextDrawSetProportional(playerid, HandyTasten[playerid][0], 0);

HandyTasten[playerid][10] = CreatePlayerTextDraw(playerid, 567.518371, 415.259521, "LD_SPAC:white");
PlayerTextDrawTextSize(playerid, HandyTasten[playerid][10], 24.000068, 15.000000);
PlayerTextDrawAlignment(playerid, HandyTasten[playerid][10], 1);
PlayerTextDrawColor(playerid, HandyTasten[playerid][10], -1);
PlayerTextDrawSetShadow(playerid, HandyTasten[playerid][10], 0);
PlayerTextDrawBackgroundColor(playerid, HandyTasten[playerid][10], 255);
PlayerTextDrawFont(playerid, HandyTasten[playerid][10], 4);
PlayerTextDrawSetProportional(playerid, HandyTasten[playerid][10], 0);
PlayerTextDrawSetSelectable(playerid, HandyTasten[playerid][10], true);

HandyTasten[playerid][20] = CreatePlayerTextDraw(playerid, 575.857299, 415.659271, "0");
PlayerTextDrawLetterSize(playerid, HandyTasten[playerid][20], 0.284664, 1.471408);
PlayerTextDrawTextSize(playerid, HandyTasten[playerid][20], 5.000000, 0.000000);
PlayerTextDrawAlignment(playerid, HandyTasten[playerid][20], 1);
PlayerTextDrawColor(playerid, HandyTasten[playerid][20], 0x565656FF);
PlayerTextDrawSetShadow(playerid, HandyTasten[playerid][20], 0);
PlayerTextDrawBackgroundColor(playerid, HandyTasten[playerid][20], 255);
PlayerTextDrawFont(playerid, HandyTasten[playerid][20], 1);
PlayerTextDrawSetProportional(playerid, HandyTasten[playerid][20], 1);

HandyTasten[playerid][1] = CreatePlayerTextDraw(playerid, 532.393371, 337.948120, "LD_SPAC:white");
PlayerTextDrawTextSize(playerid, HandyTasten[playerid][1], 27.340099, 18.000000);
PlayerTextDrawAlignment(playerid, HandyTasten[playerid][1], 1);
PlayerTextDrawColor(playerid, HandyTasten[playerid][1], 0x565656FF);
PlayerTextDrawSetShadow(playerid, HandyTasten[playerid][1], 0);
PlayerTextDrawBackgroundColor(playerid, HandyTasten[playerid][1], 255);
PlayerTextDrawFont(playerid, HandyTasten[playerid][1], 4);
PlayerTextDrawSetProportional(playerid, HandyTasten[playerid][1], 0);

HandyTasten[playerid][11] = CreatePlayerTextDraw(playerid, 534.126525, 339.518707, "LD_SPAC:white");
PlayerTextDrawTextSize(playerid, HandyTasten[playerid][11], 24.000068, 15.000000);
PlayerTextDrawAlignment(playerid, HandyTasten[playerid][11], 1);
PlayerTextDrawColor(playerid, HandyTasten[playerid][11], -1);
PlayerTextDrawSetShadow(playerid, HandyTasten[playerid][11], 0);
PlayerTextDrawBackgroundColor(playerid, HandyTasten[playerid][11], 255);
PlayerTextDrawFont(playerid, HandyTasten[playerid][11], 4);
PlayerTextDrawSetProportional(playerid, HandyTasten[playerid][11], 0);
PlayerTextDrawSetSelectable(playerid, HandyTasten[playerid][11], true);

HandyTasten[playerid][21] = CreatePlayerTextDraw(playerid, 542.298645, 340.063018, "1");
PlayerTextDrawLetterSize(playerid, HandyTasten[playerid][21], 0.284664, 1.471408);
PlayerTextDrawTextSize(playerid, HandyTasten[playerid][21], 4.000000, 0.000000);
PlayerTextDrawAlignment(playerid, HandyTasten[playerid][21], 1);
PlayerTextDrawColor(playerid, HandyTasten[playerid][21], 0x565656FF);
PlayerTextDrawSetShadow(playerid, HandyTasten[playerid][21], 0);
PlayerTextDrawBackgroundColor(playerid, HandyTasten[playerid][21], 255);
PlayerTextDrawFont(playerid, HandyTasten[playerid][21], 1);
PlayerTextDrawSetProportional(playerid, HandyTasten[playerid][21], 1);

HandyTasten[playerid][2] = CreatePlayerTextDraw(playerid, 565.985168, 338.048126, "LD_SPAC:white");
PlayerTextDrawTextSize(playerid, HandyTasten[playerid][2], 27.340099, 18.000000);
PlayerTextDrawAlignment(playerid, HandyTasten[playerid][2], 1);
PlayerTextDrawColor(playerid, HandyTasten[playerid][2], 0x565656FF);
PlayerTextDrawSetShadow(playerid, HandyTasten[playerid][2], 0);
PlayerTextDrawBackgroundColor(playerid, HandyTasten[playerid][2], 255);
PlayerTextDrawFont(playerid, HandyTasten[playerid][2], 4);
PlayerTextDrawSetProportional(playerid, HandyTasten[playerid][2], 0);

HandyTasten[playerid][12] = CreatePlayerTextDraw(playerid, 567.518371, 339.518707, "LD_SPAC:white");
PlayerTextDrawTextSize(playerid, HandyTasten[playerid][12], 24.000068, 15.000000);
PlayerTextDrawAlignment(playerid, HandyTasten[playerid][12], 1);
PlayerTextDrawColor(playerid, HandyTasten[playerid][12], -1);
PlayerTextDrawSetShadow(playerid, HandyTasten[playerid][12], 0);
PlayerTextDrawBackgroundColor(playerid, HandyTasten[playerid][12], 255);
PlayerTextDrawFont(playerid, HandyTasten[playerid][12], 4);
PlayerTextDrawSetProportional(playerid, HandyTasten[playerid][12], 0);
PlayerTextDrawSetSelectable(playerid, HandyTasten[playerid][12], true);

HandyTasten[playerid][22] = CreatePlayerTextDraw(playerid, 575.857299, 340.263031, "2");
PlayerTextDrawLetterSize(playerid, HandyTasten[playerid][22], 0.284664, 1.471408);
PlayerTextDrawTextSize(playerid, HandyTasten[playerid][22], 4.000000, 0.000000);
PlayerTextDrawAlignment(playerid, HandyTasten[playerid][22], 1);
PlayerTextDrawColor(playerid, HandyTasten[playerid][22], 0x565656FF);
PlayerTextDrawSetShadow(playerid, HandyTasten[playerid][22], 0);
PlayerTextDrawBackgroundColor(playerid, HandyTasten[playerid][22], 255);
PlayerTextDrawFont(playerid, HandyTasten[playerid][22], 1);
PlayerTextDrawSetProportional(playerid, HandyTasten[playerid][22], 1);

HandyTasten[playerid][3] = CreatePlayerTextDraw(playerid, 598.977111, 338.048126, "LD_SPAC:white");
PlayerTextDrawTextSize(playerid, HandyTasten[playerid][3], 27.340099, 18.000000);
PlayerTextDrawAlignment(playerid, HandyTasten[playerid][3], 1);
PlayerTextDrawColor(playerid, HandyTasten[playerid][3], 0x565656FF);
PlayerTextDrawSetShadow(playerid, HandyTasten[playerid][3], 0);
PlayerTextDrawBackgroundColor(playerid, HandyTasten[playerid][3], 255);
PlayerTextDrawFont(playerid, HandyTasten[playerid][3], 4);
PlayerTextDrawSetProportional(playerid, HandyTasten[playerid][3], 0);

HandyTasten[playerid][13] = CreatePlayerTextDraw(playerid, 600.610290, 339.518707, "LD_SPAC:white");
PlayerTextDrawTextSize(playerid, HandyTasten[playerid][13], 24.000068, 15.000000);
PlayerTextDrawAlignment(playerid, HandyTasten[playerid][13], 1);
PlayerTextDrawColor(playerid, HandyTasten[playerid][13], -1);
PlayerTextDrawSetShadow(playerid, HandyTasten[playerid][13], 0);
PlayerTextDrawBackgroundColor(playerid, HandyTasten[playerid][13], 255);
PlayerTextDrawFont(playerid, HandyTasten[playerid][13], 4);
PlayerTextDrawSetProportional(playerid, HandyTasten[playerid][13], 0);
PlayerTextDrawSetSelectable(playerid, HandyTasten[playerid][13], true);

HandyTasten[playerid][23] = CreatePlayerTextDraw(playerid, 608.682434, 340.063018, "3");
PlayerTextDrawLetterSize(playerid, HandyTasten[playerid][23], 0.284664, 1.471408);
PlayerTextDrawTextSize(playerid, HandyTasten[playerid][23], 4.000000, 0.000000);
PlayerTextDrawAlignment(playerid, HandyTasten[playerid][23], 1);
PlayerTextDrawColor(playerid, HandyTasten[playerid][23], 0x565656FF);
PlayerTextDrawSetShadow(playerid, HandyTasten[playerid][23], 0);
PlayerTextDrawBackgroundColor(playerid, HandyTasten[playerid][23], 255);
PlayerTextDrawFont(playerid, HandyTasten[playerid][23], 1);
PlayerTextDrawSetProportional(playerid, HandyTasten[playerid][23], 1);

HandyTasten[playerid][4] = CreatePlayerTextDraw(playerid, 532.910827, 365.011169, "LD_SPAC:white");
PlayerTextDrawTextSize(playerid, HandyTasten[playerid][4], 27.340099, 18.000000);
PlayerTextDrawAlignment(playerid, HandyTasten[playerid][4], 1);
PlayerTextDrawColor(playerid, HandyTasten[playerid][4], 0x565656FF);
PlayerTextDrawSetShadow(playerid, HandyTasten[playerid][4], 0);
PlayerTextDrawBackgroundColor(playerid, HandyTasten[playerid][4], 255);
PlayerTextDrawFont(playerid, HandyTasten[playerid][4], 4);
PlayerTextDrawSetProportional(playerid, HandyTasten[playerid][4], 0);

HandyTasten[playerid][14] = CreatePlayerTextDraw(playerid, 534.543579, 366.511383, "LD_SPAC:white");
PlayerTextDrawTextSize(playerid, HandyTasten[playerid][14], 24.000068, 15.000000);
PlayerTextDrawAlignment(playerid, HandyTasten[playerid][14], 1);
PlayerTextDrawColor(playerid, HandyTasten[playerid][14], -1);
PlayerTextDrawSetShadow(playerid, HandyTasten[playerid][14], 0);
PlayerTextDrawBackgroundColor(playerid, HandyTasten[playerid][14], 255);
PlayerTextDrawFont(playerid, HandyTasten[playerid][14], 4);
PlayerTextDrawSetProportional(playerid, HandyTasten[playerid][14], 0);
PlayerTextDrawSetSelectable(playerid, HandyTasten[playerid][14], true);

HandyTasten[playerid][24] = CreatePlayerTextDraw(playerid, 543.682617, 366.596374, "4");
PlayerTextDrawLetterSize(playerid, HandyTasten[playerid][24], 0.284664, 1.471408);
PlayerTextDrawTextSize(playerid, HandyTasten[playerid][24], 4.000000, 0.000000);
PlayerTextDrawAlignment(playerid, HandyTasten[playerid][24], 1);
PlayerTextDrawColor(playerid, HandyTasten[playerid][24], 0x565656FF);
PlayerTextDrawSetShadow(playerid, HandyTasten[playerid][24], 0);
PlayerTextDrawBackgroundColor(playerid, HandyTasten[playerid][24], 255);
PlayerTextDrawFont(playerid, HandyTasten[playerid][24], 1);
PlayerTextDrawSetProportional(playerid, HandyTasten[playerid][24], 1);

HandyTasten[playerid][5] = CreatePlayerTextDraw(playerid, 565.743957, 365.029449, "LD_SPAC:white");
PlayerTextDrawTextSize(playerid, HandyTasten[playerid][5], 27.340099, 18.000000);
PlayerTextDrawAlignment(playerid, HandyTasten[playerid][5], 1);
PlayerTextDrawColor(playerid, HandyTasten[playerid][5], 0x565656FF);
PlayerTextDrawSetShadow(playerid, HandyTasten[playerid][5], 0);
PlayerTextDrawBackgroundColor(playerid, HandyTasten[playerid][5], 255);
PlayerTextDrawFont(playerid, HandyTasten[playerid][5], 4);
PlayerTextDrawSetProportional(playerid, HandyTasten[playerid][5], 0);

HandyTasten[playerid][15] = CreatePlayerTextDraw(playerid, 567.635498, 366.511383, "LD_SPAC:white");
PlayerTextDrawTextSize(playerid, HandyTasten[playerid][15], 24.000068, 15.000000);
PlayerTextDrawAlignment(playerid, HandyTasten[playerid][15], 1);
PlayerTextDrawColor(playerid, HandyTasten[playerid][15], -1);
PlayerTextDrawSetShadow(playerid, HandyTasten[playerid][15], 0);
PlayerTextDrawBackgroundColor(playerid, HandyTasten[playerid][15], 255);
PlayerTextDrawFont(playerid, HandyTasten[playerid][15], 4);
PlayerTextDrawSetProportional(playerid, HandyTasten[playerid][15], 0);
PlayerTextDrawSetSelectable(playerid, HandyTasten[playerid][15], true);

HandyTasten[playerid][25] = CreatePlayerTextDraw(playerid, 576.008117, 366.496368, "5");
PlayerTextDrawLetterSize(playerid, HandyTasten[playerid][25], 0.284664, 1.471408);
PlayerTextDrawTextSize(playerid, HandyTasten[playerid][25], 4.000000, 0.000000);
PlayerTextDrawAlignment(playerid, HandyTasten[playerid][25], 1);
PlayerTextDrawColor(playerid, HandyTasten[playerid][25], 0x565656FF);
PlayerTextDrawSetShadow(playerid, HandyTasten[playerid][25], 0);
PlayerTextDrawBackgroundColor(playerid, HandyTasten[playerid][25], 255);
PlayerTextDrawFont(playerid, HandyTasten[playerid][25], 1);
PlayerTextDrawSetProportional(playerid, HandyTasten[playerid][25], 1);

HandyTasten[playerid][6] = CreatePlayerTextDraw(playerid, 599.002441, 364.744232, "LD_SPAC:white");
PlayerTextDrawTextSize(playerid, HandyTasten[playerid][6], 27.340099, 18.150003);
PlayerTextDrawAlignment(playerid, HandyTasten[playerid][6], 1);
PlayerTextDrawColor(playerid, HandyTasten[playerid][6], 0x565656FF);
PlayerTextDrawSetShadow(playerid, HandyTasten[playerid][6], 0);
PlayerTextDrawBackgroundColor(playerid, HandyTasten[playerid][6], 255);
PlayerTextDrawFont(playerid, HandyTasten[playerid][6], 4);
PlayerTextDrawSetProportional(playerid, HandyTasten[playerid][6], 0);

HandyTasten[playerid][16] = CreatePlayerTextDraw(playerid, 600.827392, 366.511383, "LD_SPAC:white");
PlayerTextDrawTextSize(playerid, HandyTasten[playerid][16], 24.000068, 15.000000);
PlayerTextDrawAlignment(playerid, HandyTasten[playerid][16], 1);
PlayerTextDrawColor(playerid, HandyTasten[playerid][16], -1);
PlayerTextDrawSetShadow(playerid, HandyTasten[playerid][16], 0);
PlayerTextDrawBackgroundColor(playerid, HandyTasten[playerid][16], 255);
PlayerTextDrawFont(playerid, HandyTasten[playerid][16], 4);
PlayerTextDrawSetProportional(playerid, HandyTasten[playerid][16], 0);
PlayerTextDrawSetSelectable(playerid, HandyTasten[playerid][16], true);

HandyTasten[playerid][26] = CreatePlayerTextDraw(playerid, 608.900085, 366.496368, "6");
PlayerTextDrawLetterSize(playerid, HandyTasten[playerid][26], 0.284664, 1.471408);
PlayerTextDrawTextSize(playerid, HandyTasten[playerid][26], 4.000000, 0.000000);
PlayerTextDrawAlignment(playerid, HandyTasten[playerid][26], 1);
PlayerTextDrawColor(playerid, HandyTasten[playerid][26], 0x565656FF);
PlayerTextDrawSetShadow(playerid, HandyTasten[playerid][26], 0);
PlayerTextDrawBackgroundColor(playerid, HandyTasten[playerid][26], 255);
PlayerTextDrawFont(playerid, HandyTasten[playerid][26], 1);
PlayerTextDrawSetProportional(playerid, HandyTasten[playerid][26], 1);

HandyTasten[playerid][7] = CreatePlayerTextDraw(playerid, 532.335876, 390.462860, "LD_SPAC:white");
PlayerTextDrawTextSize(playerid, HandyTasten[playerid][7], 27.340099, 18.150003);
PlayerTextDrawAlignment(playerid, HandyTasten[playerid][7], 1);
PlayerTextDrawColor(playerid, HandyTasten[playerid][7], 0x565656FF);
PlayerTextDrawSetShadow(playerid, HandyTasten[playerid][7], 0);
PlayerTextDrawBackgroundColor(playerid, HandyTasten[playerid][7], 255);
PlayerTextDrawFont(playerid, HandyTasten[playerid][7], 4);
PlayerTextDrawSetProportional(playerid, HandyTasten[playerid][7], 0);

HandyTasten[playerid][17] = CreatePlayerTextDraw(playerid, 534.059997, 392.100341, "LD_SPAC:white");
PlayerTextDrawTextSize(playerid, HandyTasten[playerid][17], 24.000068, 15.000000);
PlayerTextDrawAlignment(playerid, HandyTasten[playerid][17], 1);
PlayerTextDrawColor(playerid, HandyTasten[playerid][17], -1);
PlayerTextDrawSetShadow(playerid, HandyTasten[playerid][17], 0);
PlayerTextDrawBackgroundColor(playerid, HandyTasten[playerid][17], 255);
PlayerTextDrawFont(playerid, HandyTasten[playerid][17], 4);
PlayerTextDrawSetProportional(playerid, HandyTasten[playerid][17], 0);
PlayerTextDrawSetSelectable(playerid, HandyTasten[playerid][17], true);

HandyTasten[playerid][27] = CreatePlayerTextDraw(playerid, 543.733520, 392.314941, "7");
PlayerTextDrawLetterSize(playerid, HandyTasten[playerid][27], 0.284664, 1.471408);
PlayerTextDrawTextSize(playerid, HandyTasten[playerid][27], 4.000000, 0.000000);
PlayerTextDrawAlignment(playerid, HandyTasten[playerid][27], 1);
PlayerTextDrawColor(playerid, HandyTasten[playerid][27], 0x565656FF);
PlayerTextDrawSetShadow(playerid, HandyTasten[playerid][27], 0);
PlayerTextDrawBackgroundColor(playerid, HandyTasten[playerid][27], 255);
PlayerTextDrawFont(playerid, HandyTasten[playerid][27], 1);
PlayerTextDrawSetProportional(playerid, HandyTasten[playerid][27], 1);

HandyTasten[playerid][8] = CreatePlayerTextDraw(playerid, 566.235900, 390.062805, "LD_SPAC:white");
PlayerTextDrawTextSize(playerid, HandyTasten[playerid][8], 27.340099, 18.150003);
PlayerTextDrawAlignment(playerid, HandyTasten[playerid][8], 1);
PlayerTextDrawColor(playerid, HandyTasten[playerid][8], 0x565656FF);
PlayerTextDrawSetShadow(playerid, HandyTasten[playerid][8], 0);
PlayerTextDrawBackgroundColor(playerid, HandyTasten[playerid][8], 255);
PlayerTextDrawFont(playerid, HandyTasten[playerid][8], 4);
PlayerTextDrawSetProportional(playerid, HandyTasten[playerid][8], 0);

HandyTasten[playerid][18] = CreatePlayerTextDraw(playerid, 567.727050, 391.859497, "LD_SPAC:white");
PlayerTextDrawTextSize(playerid, HandyTasten[playerid][18], 23.990068, 15.000000);
PlayerTextDrawAlignment(playerid, HandyTasten[playerid][18], 1);
PlayerTextDrawColor(playerid, HandyTasten[playerid][18], -1);
PlayerTextDrawSetShadow(playerid, HandyTasten[playerid][18], 0);
PlayerTextDrawBackgroundColor(playerid, HandyTasten[playerid][18], 255);
PlayerTextDrawFont(playerid, HandyTasten[playerid][18], 4);
PlayerTextDrawSetProportional(playerid, HandyTasten[playerid][18], 0);
PlayerTextDrawSetSelectable(playerid, HandyTasten[playerid][18], true);

HandyTasten[playerid][28] = CreatePlayerTextDraw(playerid, 577.099792, 392.503784, "8");
PlayerTextDrawLetterSize(playerid, HandyTasten[playerid][28], 0.284664, 1.471408);
PlayerTextDrawTextSize(playerid, HandyTasten[playerid][28], 4.000000, 0.000000);
PlayerTextDrawAlignment(playerid, HandyTasten[playerid][28], 1);
PlayerTextDrawColor(playerid, HandyTasten[playerid][28], 0x565656FF);
PlayerTextDrawSetShadow(playerid, HandyTasten[playerid][28], 0);
PlayerTextDrawBackgroundColor(playerid, HandyTasten[playerid][28], 255);
PlayerTextDrawFont(playerid, HandyTasten[playerid][28], 1);
PlayerTextDrawSetProportional(playerid, HandyTasten[playerid][28], 1);

HandyTasten[playerid][9] = CreatePlayerTextDraw(playerid, 599.235656, 390.162841, "LD_SPAC:white");
PlayerTextDrawTextSize(playerid, HandyTasten[playerid][9], 27.340099, 18.150003);
PlayerTextDrawAlignment(playerid, HandyTasten[playerid][9], 1);
PlayerTextDrawColor(playerid, HandyTasten[playerid][9], 0x565656FF);
PlayerTextDrawSetShadow(playerid, HandyTasten[playerid][9], 0);
PlayerTextDrawBackgroundColor(playerid, HandyTasten[playerid][9], 255);
PlayerTextDrawFont(playerid, HandyTasten[playerid][9], 4);
PlayerTextDrawSetProportional(playerid, HandyTasten[playerid][9], 0);

HandyTasten[playerid][19] = CreatePlayerTextDraw(playerid, 600.693664, 391.944732, "LD_SPAC:white");
PlayerTextDrawTextSize(playerid, HandyTasten[playerid][19], 24.000068, 15.000000);
PlayerTextDrawAlignment(playerid, HandyTasten[playerid][19], 1);
PlayerTextDrawColor(playerid, HandyTasten[playerid][19], -1);
PlayerTextDrawSetShadow(playerid, HandyTasten[playerid][19], 0);
PlayerTextDrawBackgroundColor(playerid, HandyTasten[playerid][19], 255);
PlayerTextDrawFont(playerid, HandyTasten[playerid][19], 4);
PlayerTextDrawSetProportional(playerid, HandyTasten[playerid][19], 0);
PlayerTextDrawSetSelectable(playerid, HandyTasten[playerid][19], true);

HandyTasten[playerid][29] = CreatePlayerTextDraw(playerid, 609.366699, 392.644622, "9");
PlayerTextDrawLetterSize(playerid, HandyTasten[playerid][29], 0.284664, 1.471408);
PlayerTextDrawTextSize(playerid, HandyTasten[playerid][29], 4.000000, 0.000000);
PlayerTextDrawAlignment(playerid, HandyTasten[playerid][29], 1);
PlayerTextDrawColor(playerid, HandyTasten[playerid][29], 0x565656FF);
PlayerTextDrawSetShadow(playerid, HandyTasten[playerid][29], 0);
PlayerTextDrawBackgroundColor(playerid, HandyTasten[playerid][29], 255);
PlayerTextDrawFont(playerid, HandyTasten[playerid][29], 1);
PlayerTextDrawSetProportional(playerid, HandyTasten[playerid][29], 1);

HandyTelefonbuch[playerid][0] = CreatePlayerTextDraw(playerid, 541.932800, 215.166488, "LD_SPAC:white");
PlayerTextDrawTextSize(playerid, HandyTelefonbuch[playerid][0], 29.000000, 34.000000);
PlayerTextDrawAlignment(playerid, HandyTelefonbuch[playerid][0], 1);
PlayerTextDrawColor(playerid, HandyTelefonbuch[playerid][0], -1);
PlayerTextDrawSetShadow(playerid, HandyTelefonbuch[playerid][0], 0);
PlayerTextDrawBackgroundColor(playerid, HandyTelefonbuch[playerid][0], 255);
PlayerTextDrawFont(playerid, HandyTelefonbuch[playerid][0], 4);
PlayerTextDrawSetProportional(playerid, HandyTelefonbuch[playerid][0], 0);
PlayerTextDrawSetSelectable(playerid, HandyTelefonbuch[playerid][0], true);

HandyCalender[playerid][0] = CreatePlayerTextDraw(playerid, 586.233032, 215.481338, "LD_SPAC:white");
PlayerTextDrawTextSize(playerid, HandyCalender[playerid][0], 29.000000, 34.000000);
PlayerTextDrawAlignment(playerid, HandyCalender[playerid][0], 1);
PlayerTextDrawColor(playerid, HandyCalender[playerid][0], -1);
PlayerTextDrawSetShadow(playerid, HandyCalender[playerid][0], 0);
PlayerTextDrawBackgroundColor(playerid, HandyCalender[playerid][0], 255);
PlayerTextDrawFont(playerid, HandyCalender[playerid][0], 4);
PlayerTextDrawSetProportional(playerid, HandyCalender[playerid][0], 0);
PlayerTextDrawSetSelectable(playerid, HandyCalender[playerid][0], true);

HandyMusik[playerid][0] = CreatePlayerTextDraw(playerid, 542.565734, 261.837036, "LD_SPAC:white");
PlayerTextDrawTextSize(playerid, HandyMusik[playerid][0], 29.000000, 34.000000);
PlayerTextDrawAlignment(playerid, HandyMusik[playerid][0], 1);
PlayerTextDrawColor(playerid, HandyMusik[playerid][0], -1);
PlayerTextDrawSetShadow(playerid, HandyMusik[playerid][0], 0);
PlayerTextDrawBackgroundColor(playerid, HandyMusik[playerid][0], 255);
PlayerTextDrawFont(playerid, HandyMusik[playerid][0], 4);
PlayerTextDrawSetProportional(playerid, HandyMusik[playerid][0], 0);
PlayerTextDrawSetSelectable(playerid, HandyMusik[playerid][0], true);

HandyEinstellungen[playerid][0] = CreatePlayerTextDraw(playerid, 586.665893, 261.651947, "LD_SPAC:white");
PlayerTextDrawTextSize(playerid, HandyEinstellungen[playerid][0], 29.000000, 34.000000);
PlayerTextDrawAlignment(playerid, HandyEinstellungen[playerid][0], 1);
PlayerTextDrawColor(playerid, HandyEinstellungen[playerid][0], -1);
PlayerTextDrawSetShadow(playerid, HandyEinstellungen[playerid][0], 0);
PlayerTextDrawBackgroundColor(playerid, HandyEinstellungen[playerid][0], 255);
PlayerTextDrawFont(playerid, HandyEinstellungen[playerid][0], 4);
PlayerTextDrawSetProportional(playerid, HandyEinstellungen[playerid][0], 0);
PlayerTextDrawSetSelectable(playerid, HandyEinstellungen[playerid][0], true);

HandyTelefonbuch[playerid][1] = CreatePlayerTextDraw(playerid, 539.366149, 248.903701, "Phonebook");
PlayerTextDrawLetterSize(playerid, HandyTelefonbuch[playerid][1], 0.192665, 1.106371);
PlayerTextDrawAlignment(playerid, HandyTelefonbuch[playerid][1], 1);
PlayerTextDrawColor(playerid, HandyTelefonbuch[playerid][1], -16776961);
PlayerTextDrawSetShadow(playerid, HandyTelefonbuch[playerid][1], 0);
PlayerTextDrawBackgroundColor(playerid, HandyTelefonbuch[playerid][1], 255);
PlayerTextDrawFont(playerid, HandyTelefonbuch[playerid][1], 1);
PlayerTextDrawSetProportional(playerid, HandyTelefonbuch[playerid][1], 1);

HandyCalender[playerid][1] = CreatePlayerTextDraw(playerid, 586.797058, 248.918487, "Calendar");
PlayerTextDrawLetterSize(playerid, HandyCalender[playerid][1], 0.192665, 1.106371);
PlayerTextDrawAlignment(playerid, HandyCalender[playerid][1], 1);
PlayerTextDrawColor(playerid, HandyCalender[playerid][1], -16776961);
PlayerTextDrawSetShadow(playerid, HandyCalender[playerid][1], 0);
PlayerTextDrawBackgroundColor(playerid, HandyCalender[playerid][1], 255);
PlayerTextDrawFont(playerid, HandyCalender[playerid][1], 1);
PlayerTextDrawSetProportional(playerid, HandyCalender[playerid][1], 1);

HandyMusik[playerid][1] = CreatePlayerTextDraw(playerid, 544.2, 293.903839, "  Music");
PlayerTextDrawLetterSize(playerid, HandyMusik[playerid][1], 0.192665, 1.106371);
PlayerTextDrawAlignment(playerid, HandyMusik[playerid][1], 1);
PlayerTextDrawColor(playerid, HandyMusik[playerid][1], -16776961);
PlayerTextDrawSetShadow(playerid, HandyMusik[playerid][1], 0);
PlayerTextDrawBackgroundColor(playerid, HandyMusik[playerid][1], 255);
PlayerTextDrawFont(playerid, HandyMusik[playerid][1], 1);
PlayerTextDrawSetProportional(playerid, HandyMusik[playerid][1], 1);

HandyEinstellungen[playerid][1] = CreatePlayerTextDraw(playerid, 588.962646, 294.463073, "Settings");
PlayerTextDrawLetterSize(playerid, HandyEinstellungen[playerid][1], 0.192665, 1.106371);
PlayerTextDrawAlignment(playerid, HandyEinstellungen[playerid][1], 1);
PlayerTextDrawColor(playerid, HandyEinstellungen[playerid][1], -16776961);
PlayerTextDrawSetShadow(playerid, HandyEinstellungen[playerid][1], 0);
PlayerTextDrawBackgroundColor(playerid, HandyEinstellungen[playerid][1], 255);
PlayerTextDrawFont(playerid, HandyEinstellungen[playerid][1], 1);
PlayerTextDrawSetProportional(playerid, HandyEinstellungen[playerid][1], 1);

HandyTelefonbuch[playerid][2] = CreatePlayerTextDraw(playerid, 546.000061, 220.955520, "LD_SPAC:white");
PlayerTextDrawTextSize(playerid, HandyTelefonbuch[playerid][2], 20.000000, 21.000000);
PlayerTextDrawAlignment(playerid, HandyTelefonbuch[playerid][2], 1);
PlayerTextDrawColor(playerid, HandyTelefonbuch[playerid][2], 255);
PlayerTextDrawSetShadow(playerid, HandyTelefonbuch[playerid][2], 0);
PlayerTextDrawBackgroundColor(playerid, HandyTelefonbuch[playerid][2], 255);
PlayerTextDrawFont(playerid, HandyTelefonbuch[playerid][2], 4);
PlayerTextDrawSetProportional(playerid, HandyTelefonbuch[playerid][2], 0);

HandyTelefonbuch[playerid][3] = CreatePlayerTextDraw(playerid, 546.933044, 229.699813, "LD_BEAT:chit");
PlayerTextDrawTextSize(playerid, HandyTelefonbuch[playerid][3], 17.000000, 14.000000);
PlayerTextDrawAlignment(playerid, HandyTelefonbuch[playerid][3], 1);
PlayerTextDrawColor(playerid, HandyTelefonbuch[playerid][3], -1);
PlayerTextDrawSetShadow(playerid, HandyTelefonbuch[playerid][3], 0);
PlayerTextDrawBackgroundColor(playerid, HandyTelefonbuch[playerid][3], 255);
PlayerTextDrawFont(playerid, HandyTelefonbuch[playerid][3], 4);
PlayerTextDrawSetProportional(playerid, HandyTelefonbuch[playerid][3], 0);

HandyTelefonbuch[playerid][4] = CreatePlayerTextDraw(playerid, 551.399414, 223.914230, "LD_BEAT:chit");
PlayerTextDrawTextSize(playerid, HandyTelefonbuch[playerid][4], 8.0, 10.000000);
PlayerTextDrawAlignment(playerid, HandyTelefonbuch[playerid][4], 1);
PlayerTextDrawColor(playerid, HandyTelefonbuch[playerid][4], -1);
PlayerTextDrawSetShadow(playerid, HandyTelefonbuch[playerid][4], 0);
PlayerTextDrawBackgroundColor(playerid, HandyTelefonbuch[playerid][4], 255);
PlayerTextDrawFont(playerid, HandyTelefonbuch[playerid][4], 4);
PlayerTextDrawSetProportional(playerid, HandyTelefonbuch[playerid][4], 0);

HandyTelefonbuch[playerid][5] = CreatePlayerTextDraw(playerid, 549.333190, 236.903762, "LD_SPAC:white");
PlayerTextDrawTextSize(playerid, HandyTelefonbuch[playerid][5], 13.390008, 5.249959);
PlayerTextDrawAlignment(playerid, HandyTelefonbuch[playerid][5], 1);
PlayerTextDrawColor(playerid, HandyTelefonbuch[playerid][5], 255);
PlayerTextDrawSetShadow(playerid, HandyTelefonbuch[playerid][5], 0);
PlayerTextDrawBackgroundColor(playerid, HandyTelefonbuch[playerid][5], 255);
PlayerTextDrawFont(playerid, HandyTelefonbuch[playerid][5], 4);
PlayerTextDrawSetProportional(playerid, HandyTelefonbuch[playerid][5], 0);

HandyCalender[playerid][2] = CreatePlayerTextDraw(playerid, 588.732421, 219.581588, "LD_SPAC:white");
PlayerTextDrawTextSize(playerid, HandyCalender[playerid][2], 23.769971, 25.000000);
PlayerTextDrawAlignment(playerid, HandyCalender[playerid][2], 1);
PlayerTextDrawColor(playerid, HandyCalender[playerid][2], 255);
PlayerTextDrawSetShadow(playerid, HandyCalender[playerid][2], 0);
PlayerTextDrawBackgroundColor(playerid, HandyCalender[playerid][2], 255);
PlayerTextDrawFont(playerid, HandyCalender[playerid][2], 4);
PlayerTextDrawSetProportional(playerid, HandyCalender[playerid][2], 0);

HandyCalender[playerid][3] = CreatePlayerTextDraw(playerid, 589.932128, 220.981674, "LD_SPAC:white");
PlayerTextDrawTextSize(playerid, HandyCalender[playerid][3], 21.689924, 22.399940);
PlayerTextDrawAlignment(playerid, HandyCalender[playerid][3], 1);
PlayerTextDrawColor(playerid, HandyCalender[playerid][3], -1);
PlayerTextDrawSetShadow(playerid, HandyCalender[playerid][3], 0);
PlayerTextDrawBackgroundColor(playerid, HandyCalender[playerid][3], 255);
PlayerTextDrawFont(playerid, HandyCalender[playerid][3], 4);
PlayerTextDrawSetProportional(playerid, HandyCalender[playerid][3], 0);

HandyCalender[playerid][4] = CreatePlayerTextDraw(playerid, 600.333251, 224.429656, " ");
PlayerTextDrawLetterSize(playerid, HandyCalender[playerid][4], 0.289999, 1.525333);
PlayerTextDrawAlignment(playerid, HandyCalender[playerid][4], 2);
PlayerTextDrawColor(playerid, HandyCalender[playerid][4], 255);
PlayerTextDrawSetShadow(playerid, HandyCalender[playerid][4], 0);
PlayerTextDrawBackgroundColor(playerid, HandyCalender[playerid][4], 255);
PlayerTextDrawFont(playerid, HandyCalender[playerid][4], 1);
PlayerTextDrawSetProportional(playerid, HandyCalender[playerid][4], 1);

HandyMusik[playerid][2] = CreatePlayerTextDraw(playerid, 552.133850, 268.685363, "LD_SPAC:white");
PlayerTextDrawTextSize(playerid, HandyMusik[playerid][2], 9.220005, 3.109999);
PlayerTextDrawAlignment(playerid, HandyMusik[playerid][2], 1);
PlayerTextDrawColor(playerid, HandyMusik[playerid][2], 255);
PlayerTextDrawSetShadow(playerid, HandyMusik[playerid][2], 0);
PlayerTextDrawBackgroundColor(playerid, HandyMusik[playerid][2], 255);
PlayerTextDrawFont(playerid, HandyMusik[playerid][2], 4);
PlayerTextDrawSetProportional(playerid, HandyMusik[playerid][2], 0);

HandyMusik[playerid][3] = CreatePlayerTextDraw(playerid, 553.866577, 270.655883, "LD_SPAC:white");
PlayerTextDrawTextSize(playerid, HandyMusik[playerid][3], -1.659999, 12.000000);
PlayerTextDrawAlignment(playerid, HandyMusik[playerid][3], 1);
PlayerTextDrawColor(playerid, HandyMusik[playerid][3], 255);
PlayerTextDrawSetShadow(playerid, HandyMusik[playerid][3], 0);
PlayerTextDrawBackgroundColor(playerid, HandyMusik[playerid][3], 255);
PlayerTextDrawFont(playerid, HandyMusik[playerid][3], 4);
PlayerTextDrawSetProportional(playerid, HandyMusik[playerid][3], 0);

HandyMusik[playerid][4] = CreatePlayerTextDraw(playerid, 561.566467, 271.170715, "LD_SPAC:white");
PlayerTextDrawTextSize(playerid, HandyMusik[playerid][4], -1.889999, 12.000000);
PlayerTextDrawAlignment(playerid, HandyMusik[playerid][4], 1);
PlayerTextDrawColor(playerid, HandyMusik[playerid][4], 255);
PlayerTextDrawSetShadow(playerid, HandyMusik[playerid][4], 0);
PlayerTextDrawBackgroundColor(playerid, HandyMusik[playerid][4], 255);
PlayerTextDrawFont(playerid, HandyMusik[playerid][4], 4);
PlayerTextDrawSetProportional(playerid, HandyMusik[playerid][4], 0);

HandyMusik[playerid][5] = CreatePlayerTextDraw(playerid, 547.300598, 278.878295, "LD_BEAT:chit");
PlayerTextDrawTextSize(playerid, HandyMusik[playerid][5], 8.000000, 10.000000);
PlayerTextDrawAlignment(playerid, HandyMusik[playerid][5], 1);
PlayerTextDrawColor(playerid, HandyMusik[playerid][5], 255);
PlayerTextDrawSetShadow(playerid, HandyMusik[playerid][5], 0);
PlayerTextDrawBackgroundColor(playerid, HandyMusik[playerid][5], 255);
PlayerTextDrawFont(playerid, HandyMusik[playerid][5], 4);
PlayerTextDrawSetProportional(playerid, HandyMusik[playerid][5], 0);

HandyMusik[playerid][6] = CreatePlayerTextDraw(playerid, 554.831970, 279.052246, "LD_BEAT:chit");
PlayerTextDrawTextSize(playerid, HandyMusik[playerid][6], 8.000000, 10.000000);
PlayerTextDrawAlignment(playerid, HandyMusik[playerid][6], 1);
PlayerTextDrawColor(playerid, HandyMusik[playerid][6], 255);
PlayerTextDrawSetShadow(playerid, HandyMusik[playerid][6], 0);
PlayerTextDrawBackgroundColor(playerid, HandyMusik[playerid][6], 255);
PlayerTextDrawFont(playerid, HandyMusik[playerid][6], 4);
PlayerTextDrawSetProportional(playerid, HandyMusik[playerid][6], 0);

HandyEinstellungen[playerid][2] = CreatePlayerTextDraw(playerid, 581.666625, 256.214874, "");
PlayerTextDrawTextSize(playerid, HandyEinstellungen[playerid][2], 39.000000, 45.000000);
PlayerTextDrawAlignment(playerid, HandyEinstellungen[playerid][2], 1);
PlayerTextDrawColor(playerid, HandyEinstellungen[playerid][2], 255);
PlayerTextDrawBackgroundColor(playerid, HandyEinstellungen[playerid][2], 0);
PlayerTextDrawSetShadow(playerid, HandyEinstellungen[playerid][2], 0);
PlayerTextDrawFont(playerid, HandyEinstellungen[playerid][2], 5);
PlayerTextDrawSetProportional(playerid, HandyEinstellungen[playerid][2], 0);
PlayerTextDrawSetPreviewModel(playerid, HandyEinstellungen[playerid][2], 19627);
PlayerTextDrawSetPreviewRot(playerid, HandyEinstellungen[playerid][2], 90.000000, 0.000000, -45.000000, 1.000000);

HandyCalender_Monday[playerid] = CreatePlayerTextDraw(playerid, 534.000122, 214.318588, "LD_SPAC:white");
PlayerTextDrawTextSize(playerid, HandyCalender_Monday[playerid], 91.000000, 10.389871);
PlayerTextDrawAlignment(playerid, HandyCalender_Monday[playerid], 1);
PlayerTextDrawColor(playerid, HandyCalender_Monday[playerid], -1);
PlayerTextDrawSetShadow(playerid, HandyCalender_Monday[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, HandyCalender_Monday[playerid], 255);
PlayerTextDrawFont(playerid, HandyCalender_Monday[playerid], 4);
PlayerTextDrawSetProportional(playerid, HandyCalender_Monday[playerid], 0);
PlayerTextDrawSetSelectable(playerid, HandyCalender_Monday[playerid], true);

HandyCalender_Tuesday[playerid] = CreatePlayerTextDraw(playerid, 534.000122, 226.819351, "LD_SPAC:white");
PlayerTextDrawTextSize(playerid, HandyCalender_Tuesday[playerid], 91.000000, 10.389871);
PlayerTextDrawAlignment(playerid, HandyCalender_Tuesday[playerid], 1);
PlayerTextDrawColor(playerid, HandyCalender_Tuesday[playerid], -1);
PlayerTextDrawSetShadow(playerid, HandyCalender_Tuesday[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, HandyCalender_Tuesday[playerid], 255);
PlayerTextDrawFont(playerid, HandyCalender_Tuesday[playerid], 4);
PlayerTextDrawSetProportional(playerid, HandyCalender_Tuesday[playerid], 0);
PlayerTextDrawSetSelectable(playerid, HandyCalender_Tuesday[playerid], true);

HandyCalender_Wednesday[playerid] = CreatePlayerTextDraw(playerid, 534.000122, 239.620132, "LD_SPAC:white");
PlayerTextDrawTextSize(playerid, HandyCalender_Wednesday[playerid], 91.000000, 10.389871);
PlayerTextDrawAlignment(playerid, HandyCalender_Wednesday[playerid], 1);
PlayerTextDrawColor(playerid, HandyCalender_Wednesday[playerid], -1);
PlayerTextDrawSetShadow(playerid, HandyCalender_Wednesday[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, HandyCalender_Wednesday[playerid], 255);
PlayerTextDrawFont(playerid, HandyCalender_Wednesday[playerid], 4);
PlayerTextDrawSetProportional(playerid, HandyCalender_Wednesday[playerid], 0);
PlayerTextDrawSetSelectable(playerid, HandyCalender_Wednesday[playerid], true);

HandyCalender_Thursday[playerid] = CreatePlayerTextDraw(playerid, 534.000122, 251.920883, "LD_SPAC:white");
PlayerTextDrawTextSize(playerid, HandyCalender_Thursday[playerid], 91.000000, 10.389871);
PlayerTextDrawAlignment(playerid, HandyCalender_Thursday[playerid], 1);
PlayerTextDrawColor(playerid, HandyCalender_Thursday[playerid], -1);
PlayerTextDrawSetShadow(playerid, HandyCalender_Thursday[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, HandyCalender_Thursday[playerid], 255);
PlayerTextDrawFont(playerid, HandyCalender_Thursday[playerid], 4);
PlayerTextDrawSetProportional(playerid, HandyCalender_Thursday[playerid], 0);
PlayerTextDrawSetSelectable(playerid, HandyCalender_Thursday[playerid], true);

HandyCalender_Friday[playerid] = CreatePlayerTextDraw(playerid, 534.000122, 264.821655, "LD_SPAC:white");
PlayerTextDrawTextSize(playerid, HandyCalender_Friday[playerid], 91.000000, 10.389871);
PlayerTextDrawAlignment(playerid, HandyCalender_Friday[playerid], 1);
PlayerTextDrawColor(playerid, HandyCalender_Friday[playerid], -1);
PlayerTextDrawSetShadow(playerid, HandyCalender_Friday[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, HandyCalender_Friday[playerid], 255);
PlayerTextDrawFont(playerid, HandyCalender_Friday[playerid], 4);
PlayerTextDrawSetProportional(playerid, HandyCalender_Friday[playerid], 0);
PlayerTextDrawSetSelectable(playerid, HandyCalender_Friday[playerid], true);

HandyCalender_Saturday[playerid] = CreatePlayerTextDraw(playerid, 534.000122, 277.437225, "LD_SPAC:white");
PlayerTextDrawTextSize(playerid, HandyCalender_Saturday[playerid], 91.000000, 10.389871);
PlayerTextDrawAlignment(playerid, HandyCalender_Saturday[playerid], 1);
PlayerTextDrawColor(playerid, HandyCalender_Saturday[playerid], -1);
PlayerTextDrawSetShadow(playerid, HandyCalender_Saturday[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, HandyCalender_Saturday[playerid], 255);
PlayerTextDrawFont(playerid, HandyCalender_Saturday[playerid], 4);
PlayerTextDrawSetProportional(playerid, HandyCalender_Saturday[playerid], 0);
PlayerTextDrawSetSelectable(playerid, HandyCalender_Saturday[playerid], true);

HandyCalender_Sunday[playerid] = CreatePlayerTextDraw(playerid, 534.000122, 289.837982, "LD_SPAC:white");
PlayerTextDrawTextSize(playerid, HandyCalender_Sunday[playerid], 91.000000, 10.389871);
PlayerTextDrawAlignment(playerid, HandyCalender_Sunday[playerid], 1);
PlayerTextDrawColor(playerid, HandyCalender_Sunday[playerid], -1);
PlayerTextDrawSetShadow(playerid, HandyCalender_Sunday[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, HandyCalender_Sunday[playerid], 255);
PlayerTextDrawFont(playerid, HandyCalender_Sunday[playerid], 4);
PlayerTextDrawSetProportional(playerid, HandyCalender_Sunday[playerid], 0);
PlayerTextDrawSetSelectable(playerid, HandyCalender_Sunday[playerid], true);

HandyCalender_Monday_[playerid] = CreatePlayerTextDraw(playerid, 536.666992, 213.285278, "~r~~h~x ~l~Monday");
PlayerTextDrawLetterSize(playerid, HandyCalender_Monday_[playerid], 0.216999, 1.181037);
PlayerTextDrawAlignment(playerid, HandyCalender_Monday_[playerid], 1);
PlayerTextDrawColor(playerid, HandyCalender_Monday_[playerid], 255);
PlayerTextDrawSetShadow(playerid, HandyCalender_Monday_[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, HandyCalender_Monday_[playerid], 255);
PlayerTextDrawFont(playerid, HandyCalender_Monday_[playerid], 1);
PlayerTextDrawSetProportional(playerid, HandyCalender_Monday_[playerid], 1);

HandyCalender_Tuesday_[playerid] = CreatePlayerTextDraw(playerid, 536.666992, 225.486022, "~r~~h~x ~l~Tuesday");
PlayerTextDrawLetterSize(playerid, HandyCalender_Tuesday_[playerid], 0.216999, 1.181037);
PlayerTextDrawAlignment(playerid, HandyCalender_Tuesday_[playerid], 1);
PlayerTextDrawColor(playerid, HandyCalender_Tuesday_[playerid], 255);
PlayerTextDrawSetShadow(playerid, HandyCalender_Tuesday_[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, HandyCalender_Tuesday_[playerid], 255);
PlayerTextDrawFont(playerid, HandyCalender_Tuesday_[playerid], 1);
PlayerTextDrawSetProportional(playerid, HandyCalender_Tuesday_[playerid], 1);

HandyCalender_Wednesday_[playerid] = CreatePlayerTextDraw(playerid, 536.666992, 237.786773, "~r~~h~x ~l~Wednesday");
PlayerTextDrawLetterSize(playerid,HandyCalender_Wednesday_[playerid], 0.216999, 1.181037);
PlayerTextDrawAlignment(playerid, HandyCalender_Wednesday_[playerid], 1);
PlayerTextDrawColor(playerid, HandyCalender_Wednesday_[playerid], 255);
PlayerTextDrawSetShadow(playerid, HandyCalender_Wednesday_[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, HandyCalender_Wednesday_[playerid], 255);
PlayerTextDrawFont(playerid, HandyCalender_Wednesday_[playerid], 1);
PlayerTextDrawSetProportional(playerid, HandyCalender_Wednesday_[playerid], 1);

HandyCalender_Thursday_[playerid] = CreatePlayerTextDraw(playerid, 536.666992, 250.487548, "~r~~h~x ~l~Thursday");
PlayerTextDrawLetterSize(playerid, HandyCalender_Thursday_[playerid], 0.216999, 1.181037);
PlayerTextDrawAlignment(playerid, HandyCalender_Thursday_[playerid], 1);
PlayerTextDrawColor(playerid, HandyCalender_Thursday_[playerid], 255);
PlayerTextDrawSetShadow(playerid, HandyCalender_Thursday_[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, HandyCalender_Thursday_[playerid], 255);
PlayerTextDrawFont(playerid, HandyCalender_Thursday_[playerid], 1);
PlayerTextDrawSetProportional(playerid, HandyCalender_Thursday_[playerid], 1);

HandyCalender_Friday_[playerid] = CreatePlayerTextDraw(playerid, 536.666992, 263.688354, "~r~~h~x ~l~Friday");
PlayerTextDrawLetterSize(playerid, HandyCalender_Friday_[playerid], 0.216999, 1.181037);
PlayerTextDrawAlignment(playerid, HandyCalender_Friday_[playerid], 1);
PlayerTextDrawColor(playerid, HandyCalender_Friday_[playerid], 255);
PlayerTextDrawSetShadow(playerid, HandyCalender_Friday_[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, HandyCalender_Friday_[playerid], 255);
PlayerTextDrawFont(playerid, HandyCalender_Friday_[playerid], 1);
PlayerTextDrawSetProportional(playerid, HandyCalender_Friday_[playerid], 1);

HandyCalender_Saturday_[playerid] = CreatePlayerTextDraw(playerid, 536.666992, 275.989105, "~r~~h~x ~l~Saturaday");
PlayerTextDrawLetterSize(playerid, HandyCalender_Saturday_[playerid], 0.216999, 1.181037);
PlayerTextDrawAlignment(playerid, HandyCalender_Saturday_[playerid], 1);
PlayerTextDrawColor(playerid, HandyCalender_Saturday_[playerid], 255);
PlayerTextDrawSetShadow(playerid, HandyCalender_Saturday_[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, HandyCalender_Saturday_[playerid], 255);
PlayerTextDrawFont(playerid, HandyCalender_Saturday_[playerid], 1);
PlayerTextDrawSetProportional(playerid, HandyCalender_Saturday_[playerid], 1);

HandyCalender_Sunday_[playerid] = CreatePlayerTextDraw(playerid, 536.666992, 288.289855, "~r~~h~x ~l~Sunday");
PlayerTextDrawLetterSize(playerid, HandyCalender_Sunday_[playerid], 0.216999, 1.181037);
PlayerTextDrawAlignment(playerid, HandyCalender_Sunday_[playerid], 1);
PlayerTextDrawColor(playerid, HandyCalender_Sunday_[playerid], 255);
PlayerTextDrawSetShadow(playerid, HandyCalender_Sunday_[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, HandyCalender_Sunday_[playerid], 255);
PlayerTextDrawFont(playerid, HandyCalender_Sunday_[playerid], 1);
PlayerTextDrawSetProportional(playerid, HandyCalender_Sunday_[playerid], 1);

Handy_Telefonbuch_AlleK[playerid][0] = CreatePlayerTextDraw(playerid, 541.932800, 215.166488, "LD_SPAC:white");
PlayerTextDrawTextSize(playerid, Handy_Telefonbuch_AlleK[playerid][0], 29.000068, 34.000000);
PlayerTextDrawAlignment(playerid, Handy_Telefonbuch_AlleK[playerid][0], 1);
PlayerTextDrawColor(playerid, Handy_Telefonbuch_AlleK[playerid][0], -1);
PlayerTextDrawSetShadow(playerid, Handy_Telefonbuch_AlleK[playerid][0], 0);
PlayerTextDrawBackgroundColor(playerid, Handy_Telefonbuch_AlleK[playerid][0], 255);
PlayerTextDrawFont(playerid, Handy_Telefonbuch_AlleK[playerid][0], 4);
PlayerTextDrawSetProportional(playerid, Handy_Telefonbuch_AlleK[playerid][0], 0);
PlayerTextDrawSetSelectable(playerid, Handy_Telefonbuch_AlleK[playerid][0], true);

Handy_Telefonbuch_AlleK[playerid][1] = CreatePlayerTextDraw(playerid, 546.000061, 220.955520, "LD_SPAC:white");
PlayerTextDrawTextSize(playerid, Handy_Telefonbuch_AlleK[playerid][1], 20.000068, 21.000000);
PlayerTextDrawAlignment(playerid, Handy_Telefonbuch_AlleK[playerid][1], 1);
PlayerTextDrawColor(playerid, Handy_Telefonbuch_AlleK[playerid][1], 255);
PlayerTextDrawSetShadow(playerid, Handy_Telefonbuch_AlleK[playerid][1], 0);
PlayerTextDrawBackgroundColor(playerid, Handy_Telefonbuch_AlleK[playerid][1], 255);
PlayerTextDrawFont(playerid, Handy_Telefonbuch_AlleK[playerid][1], 4);
PlayerTextDrawSetProportional(playerid, Handy_Telefonbuch_AlleK[playerid][1], 0);

Handy_Telefonbuch_AlleK[playerid][2] = CreatePlayerTextDraw(playerid, 551.399414, 223.914230, "LD_BEAT:chit");
PlayerTextDrawTextSize(playerid, Handy_Telefonbuch_AlleK[playerid][2], 8.000000, 10.000000);
PlayerTextDrawAlignment(playerid, Handy_Telefonbuch_AlleK[playerid][2], 1);
PlayerTextDrawColor(playerid, Handy_Telefonbuch_AlleK[playerid][2], -1);
PlayerTextDrawSetShadow(playerid, Handy_Telefonbuch_AlleK[playerid][2], 0);
PlayerTextDrawBackgroundColor(playerid, Handy_Telefonbuch_AlleK[playerid][2], 255);
PlayerTextDrawFont(playerid, Handy_Telefonbuch_AlleK[playerid][2], 4);
PlayerTextDrawSetProportional(playerid, Handy_Telefonbuch_AlleK[playerid][2], 0);

Handy_Telefonbuch_AlleK[playerid][3] = CreatePlayerTextDraw(playerid, 546.900390, 229.803237, "LD_BEAT:chit");
PlayerTextDrawTextSize(playerid, Handy_Telefonbuch_AlleK[playerid][3], 17.000000, 14.000000);
PlayerTextDrawAlignment(playerid, Handy_Telefonbuch_AlleK[playerid][3], 1);
PlayerTextDrawColor(playerid, Handy_Telefonbuch_AlleK[playerid][3], -1);
PlayerTextDrawSetShadow(playerid, Handy_Telefonbuch_AlleK[playerid][3], 0);
PlayerTextDrawBackgroundColor(playerid, Handy_Telefonbuch_AlleK[playerid][3], 255);
PlayerTextDrawFont(playerid, Handy_Telefonbuch_AlleK[playerid][3], 4);
PlayerTextDrawSetProportional(playerid, Handy_Telefonbuch_AlleK[playerid][3], 0);

Handy_Telefonbuch_AlleK[playerid][4] = CreatePlayerTextDraw(playerid, 548.466552, 236.868545, "LD_SPAC:white");
PlayerTextDrawTextSize(playerid, Handy_Telefonbuch_AlleK[playerid][4], 13.390007, 5.249958);
PlayerTextDrawAlignment(playerid, Handy_Telefonbuch_AlleK[playerid][4], 1);
PlayerTextDrawColor(playerid, Handy_Telefonbuch_AlleK[playerid][4], 255);
PlayerTextDrawSetShadow(playerid, Handy_Telefonbuch_AlleK[playerid][4], 0);
PlayerTextDrawBackgroundColor(playerid, Handy_Telefonbuch_AlleK[playerid][4], 255);
PlayerTextDrawFont(playerid, Handy_Telefonbuch_AlleK[playerid][4], 4);
PlayerTextDrawSetProportional(playerid, Handy_Telefonbuch_AlleK[playerid][4], 0);

Handy_Telefonbuch_Freunde[playerid][0] = CreatePlayerTextDraw(playerid, 586.233032, 215.481338, "LD_SPAC:white");
PlayerTextDrawTextSize(playerid, Handy_Telefonbuch_Freunde[playerid][0], 29.000068, 34.000000);
PlayerTextDrawAlignment(playerid, Handy_Telefonbuch_Freunde[playerid][0], 1);
PlayerTextDrawColor(playerid, Handy_Telefonbuch_Freunde[playerid][0], -1);
PlayerTextDrawSetShadow(playerid, Handy_Telefonbuch_Freunde[playerid][0], 0);
PlayerTextDrawBackgroundColor(playerid, Handy_Telefonbuch_Freunde[playerid][0], 255);
PlayerTextDrawFont(playerid, Handy_Telefonbuch_Freunde[playerid][0], 4);
PlayerTextDrawSetProportional(playerid, Handy_Telefonbuch_Freunde[playerid][0], 0);
PlayerTextDrawSetSelectable(playerid, Handy_Telefonbuch_Freunde[playerid][0], true);

Handy_Telefonbuch_Freunde[playerid][1] = CreatePlayerTextDraw(playerid, 590.596740, 220.955520, "LD_SPAC:white");
PlayerTextDrawTextSize(playerid, Handy_Telefonbuch_Freunde[playerid][1], 20.000068, 21.000000);
PlayerTextDrawAlignment(playerid, Handy_Telefonbuch_Freunde[playerid][1], 1);
PlayerTextDrawColor(playerid, Handy_Telefonbuch_Freunde[playerid][1], 255);
PlayerTextDrawSetShadow(playerid, Handy_Telefonbuch_Freunde[playerid][1], 0);
PlayerTextDrawBackgroundColor(playerid, Handy_Telefonbuch_Freunde[playerid][1], 255);
PlayerTextDrawFont(playerid, Handy_Telefonbuch_Freunde[playerid][1], 4);
PlayerTextDrawSetProportional(playerid, Handy_Telefonbuch_Freunde[playerid][1], 0);

Handy_Telefonbuch_Freunde[playerid][2] = CreatePlayerTextDraw(playerid, 593.097717, 223.914230, "LD_BEAT:chit");
PlayerTextDrawTextSize(playerid, Handy_Telefonbuch_Freunde[playerid][2], 8.000000, 10.000000);
PlayerTextDrawAlignment(playerid, Handy_Telefonbuch_Freunde[playerid][2], 1);
PlayerTextDrawColor(playerid, Handy_Telefonbuch_Freunde[playerid][2], 16777215);
PlayerTextDrawSetShadow(playerid, Handy_Telefonbuch_Freunde[playerid][2], 0);
PlayerTextDrawBackgroundColor(playerid, Handy_Telefonbuch_Freunde[playerid][2], 255);
PlayerTextDrawFont(playerid, Handy_Telefonbuch_Freunde[playerid][2], 4);
PlayerTextDrawSetProportional(playerid, Handy_Telefonbuch_Freunde[playerid][2], 0);

Handy_Telefonbuch_Freunde[playerid][3] = CreatePlayerTextDraw(playerid, 588.598693, 229.803237, "LD_BEAT:chit");
PlayerTextDrawTextSize(playerid, Handy_Telefonbuch_Freunde[playerid][3], 17.000000, 14.000000);
PlayerTextDrawAlignment(playerid, Handy_Telefonbuch_Freunde[playerid][3], 1);
PlayerTextDrawColor(playerid, Handy_Telefonbuch_Freunde[playerid][3], 16777215);
PlayerTextDrawSetShadow(playerid, Handy_Telefonbuch_Freunde[playerid][3], 0);
PlayerTextDrawBackgroundColor(playerid, Handy_Telefonbuch_Freunde[playerid][3], 255);
PlayerTextDrawFont(playerid, Handy_Telefonbuch_Freunde[playerid][3], 4);
PlayerTextDrawSetProportional(playerid, Handy_Telefonbuch_Freunde[playerid][3], 0);

Handy_Telefonbuch_Freunde[playerid][4] = CreatePlayerTextDraw(playerid, 600.530761, 223.958663, "LD_BEAT:chit");
PlayerTextDrawTextSize(playerid, Handy_Telefonbuch_Freunde[playerid][4], 8.000000, 10.000000);
PlayerTextDrawAlignment(playerid, Handy_Telefonbuch_Freunde[playerid][4], 1);
PlayerTextDrawColor(playerid, Handy_Telefonbuch_Freunde[playerid][4], -1);
PlayerTextDrawSetShadow(playerid, Handy_Telefonbuch_Freunde[playerid][4], 0);
PlayerTextDrawBackgroundColor(playerid, Handy_Telefonbuch_Freunde[playerid][4], 255);
PlayerTextDrawFont(playerid, Handy_Telefonbuch_Freunde[playerid][4], 4);
PlayerTextDrawSetProportional(playerid, Handy_Telefonbuch_Freunde[playerid][4], 0);

Handy_Telefonbuch_Freunde[playerid][5] = CreatePlayerTextDraw(playerid, 596.098388, 229.803237, "LD_BEAT:chit");
PlayerTextDrawTextSize(playerid, Handy_Telefonbuch_Freunde[playerid][5], 17.000000, 14.000000);
PlayerTextDrawAlignment(playerid, Handy_Telefonbuch_Freunde[playerid][5], 1);
PlayerTextDrawColor(playerid, Handy_Telefonbuch_Freunde[playerid][5], -1);
PlayerTextDrawSetShadow(playerid, Handy_Telefonbuch_Freunde[playerid][5], 0);
PlayerTextDrawBackgroundColor(playerid, Handy_Telefonbuch_Freunde[playerid][5], 255);
PlayerTextDrawFont(playerid, Handy_Telefonbuch_Freunde[playerid][5], 4);
PlayerTextDrawSetProportional(playerid, Handy_Telefonbuch_Freunde[playerid][5], 0);

Handy_Telefonbuch_Freunde[playerid][6] = CreatePlayerTextDraw(playerid, 590.464843, 236.868545, "LD_SPAC:white");
PlayerTextDrawTextSize(playerid, Handy_Telefonbuch_Freunde[playerid][6], 20.070013, 5.249958);
PlayerTextDrawAlignment(playerid, Handy_Telefonbuch_Freunde[playerid][6], 1);
PlayerTextDrawColor(playerid, Handy_Telefonbuch_Freunde[playerid][6], 255);
PlayerTextDrawSetShadow(playerid, Handy_Telefonbuch_Freunde[playerid][6], 0);
PlayerTextDrawBackgroundColor(playerid, Handy_Telefonbuch_Freunde[playerid][6], 255);
PlayerTextDrawFont(playerid, Handy_Telefonbuch_Freunde[playerid][6], 4);
PlayerTextDrawSetProportional(playerid, Handy_Telefonbuch_Freunde[playerid][6], 0);

Handy_Telefonbuch_publicService[playerid][0] = CreatePlayerTextDraw(playerid, 542.565734, 260.837036, "LD_SPAC:white");
PlayerTextDrawTextSize(playerid, Handy_Telefonbuch_publicService[playerid][0], 29.000000, 34.000000);
PlayerTextDrawAlignment(playerid, Handy_Telefonbuch_publicService[playerid][0], 1);
PlayerTextDrawColor(playerid, Handy_Telefonbuch_publicService[playerid][0], -1);
PlayerTextDrawSetShadow(playerid, Handy_Telefonbuch_publicService[playerid][0], 0);
PlayerTextDrawBackgroundColor(playerid, Handy_Telefonbuch_publicService[playerid][0], 255);
PlayerTextDrawFont(playerid, Handy_Telefonbuch_publicService[playerid][0], 4);
PlayerTextDrawSetProportional(playerid, Handy_Telefonbuch_publicService[playerid][0], 0);
PlayerTextDrawSetSelectable(playerid, Handy_Telefonbuch_publicService[playerid][0], true);

Handy_Telefonbuch_publicService[playerid][1] = CreatePlayerTextDraw(playerid, 548.999450, 270.618316, "hud:radar_hostpital");
PlayerTextDrawTextSize(playerid, Handy_Telefonbuch_publicService[playerid][1], 15.000000, 16.500000);
PlayerTextDrawAlignment(playerid, Handy_Telefonbuch_publicService[playerid][1], 1);
PlayerTextDrawColor(playerid, Handy_Telefonbuch_publicService[playerid][1], -1);
PlayerTextDrawSetShadow(playerid, Handy_Telefonbuch_publicService[playerid][1], 0);
PlayerTextDrawBackgroundColor(playerid, Handy_Telefonbuch_publicService[playerid][1], 255);
PlayerTextDrawFont(playerid, Handy_Telefonbuch_publicService[playerid][1], 4);
PlayerTextDrawSetProportional(playerid, Handy_Telefonbuch_publicService[playerid][1], 0);

Handy_Telefonbuch_Suchen[playerid][0] = CreatePlayerTextDraw(playerid, 586.665893, 261.651947, "LD_SPAC:white");
PlayerTextDrawTextSize(playerid, Handy_Telefonbuch_Suchen[playerid][0], 29.000000, 34.000000);
PlayerTextDrawAlignment(playerid, Handy_Telefonbuch_Suchen[playerid][0], 1);
PlayerTextDrawColor(playerid, Handy_Telefonbuch_Suchen[playerid][0], -1);
PlayerTextDrawSetShadow(playerid, Handy_Telefonbuch_Suchen[playerid][0], 0);
PlayerTextDrawBackgroundColor(playerid, Handy_Telefonbuch_Suchen[playerid][0], 255);
PlayerTextDrawFont(playerid, Handy_Telefonbuch_Suchen[playerid][0], 4);
PlayerTextDrawSetProportional(playerid, Handy_Telefonbuch_Suchen[playerid][0], 0);
PlayerTextDrawSetSelectable(playerid, Handy_Telefonbuch_Suchen[playerid][0], true);

Handy_Telefonbuch_Suchen[playerid][1] = CreatePlayerTextDraw(playerid, 594.333190, 277.940856, "/");
PlayerTextDrawLetterSize(playerid, Handy_Telefonbuch_Suchen[playerid][1], 0.400000, 1.600000);
PlayerTextDrawAlignment(playerid, Handy_Telefonbuch_Suchen[playerid][1], 1);
PlayerTextDrawColor(playerid, Handy_Telefonbuch_Suchen[playerid][1], 255);
PlayerTextDrawSetShadow(playerid, Handy_Telefonbuch_Suchen[playerid][1], 0);
PlayerTextDrawBackgroundColor(playerid, Handy_Telefonbuch_Suchen[playerid][1], 255);
PlayerTextDrawFont(playerid, Handy_Telefonbuch_Suchen[playerid][1], 1);
PlayerTextDrawSetProportional(playerid, Handy_Telefonbuch_Suchen[playerid][1], 1);

Handy_Telefonbuch_Suchen[playerid][2] = CreatePlayerTextDraw(playerid, 590.999938, 262.437133, "LD_BEAT:chit");
PlayerTextDrawTextSize(playerid, Handy_Telefonbuch_Suchen[playerid][2], 19.000000, 23.000000);
PlayerTextDrawAlignment(playerid, Handy_Telefonbuch_Suchen[playerid][2], 1);
PlayerTextDrawColor(playerid, Handy_Telefonbuch_Suchen[playerid][2], 255);
PlayerTextDrawSetShadow(playerid, Handy_Telefonbuch_Suchen[playerid][2], 0);
PlayerTextDrawBackgroundColor(playerid, Handy_Telefonbuch_Suchen[playerid][2], 255);
PlayerTextDrawFont(playerid, Handy_Telefonbuch_Suchen[playerid][2], 4);
PlayerTextDrawSetProportional(playerid, Handy_Telefonbuch_Suchen[playerid][2], 0);

Handy_Telefonbuch_Suchen[playerid][3] = CreatePlayerTextDraw(playerid, 592.599548, 264.237243, "LD_BEAT:chit");
PlayerTextDrawTextSize(playerid, Handy_Telefonbuch_Suchen[playerid][3], 16.000000, 19.000000);
PlayerTextDrawAlignment(playerid, Handy_Telefonbuch_Suchen[playerid][3], 1);
PlayerTextDrawColor(playerid, Handy_Telefonbuch_Suchen[playerid][3], -1);
PlayerTextDrawSetShadow(playerid, Handy_Telefonbuch_Suchen[playerid][3], 0);
PlayerTextDrawBackgroundColor(playerid, Handy_Telefonbuch_Suchen[playerid][3], 255);
PlayerTextDrawFont(playerid, Handy_Telefonbuch_Suchen[playerid][3], 4);
PlayerTextDrawSetProportional(playerid, Handy_Telefonbuch_Suchen[playerid][3], 0);


HandyAddFriendContact[playerid] = CreatePlayerTextDraw(playerid, 601.796875, 267.155426, "Friend");
PlayerTextDrawLetterSize(playerid, HandyAddFriendContact[playerid], 0.249666, 1.442370);
PlayerTextDrawTextSize(playerid, HandyAddFriendContact[playerid], 616.000000, 0.000000);
PlayerTextDrawAlignment(playerid, HandyAddFriendContact[playerid], 2);
PlayerTextDrawColor(playerid, HandyAddFriendContact[playerid], 255);
PlayerTextDrawBoxColor(playerid, HandyAddFriendContact[playerid], -1);
PlayerTextDrawSetShadow(playerid, HandyAddFriendContact[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, HandyAddFriendContact[playerid], 255);
PlayerTextDrawFont(playerid, HandyAddFriendContact[playerid], 1);

HandyAddFriendContact_[playerid] = CreatePlayerTextDraw(playerid, 580.897155, 266.999938, "LD_SPAC:white");
PlayerTextDrawTextSize(playerid, HandyAddFriendContact_[playerid], 41.829917, 15.000000);
PlayerTextDrawAlignment(playerid, HandyAddFriendContact_[playerid], 1);
PlayerTextDrawColor(playerid, HandyAddFriendContact_[playerid], -1);
PlayerTextDrawUseBox(playerid, HandyAddFriendContact_[playerid], 1);
PlayerTextDrawBoxColor(playerid, HandyAddFriendContact_[playerid], -1);
PlayerTextDrawSetShadow(playerid, HandyAddFriendContact_[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, HandyAddFriendContact_[playerid], 255);
PlayerTextDrawFont(playerid, HandyAddFriendContact_[playerid], 4);
PlayerTextDrawSetProportional(playerid, HandyAddFriendContact_[playerid], 1);
PlayerTextDrawSetSelectable(playerid, HandyAddFriendContact_[playerid], true);

HandyCallContact[playerid] = CreatePlayerTextDraw(playerid, 556.198730, 267.155426, "Call");
PlayerTextDrawLetterSize(playerid, HandyCallContact[playerid], 0.249666, 1.442370);
PlayerTextDrawTextSize(playerid, HandyCallContact[playerid], 565.000000, 0.000000);
PlayerTextDrawAlignment(playerid, HandyCallContact[playerid], 2);
PlayerTextDrawColor(playerid, HandyCallContact[playerid], 255);
PlayerTextDrawBoxColor(playerid, HandyCallContact[playerid], -1);
PlayerTextDrawSetShadow(playerid, HandyCallContact[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, HandyCallContact[playerid], 255);
PlayerTextDrawFont(playerid,HandyCallContact[playerid], 1);

HandyCallContact_[playerid] = CreatePlayerTextDraw(playerid, 535.999938, 266.999938, "LD_SPAC:white");
PlayerTextDrawTextSize(playerid, HandyCallContact_[playerid], 41.829917, 15.000000);
PlayerTextDrawAlignment(playerid, HandyCallContact_[playerid], 1);
PlayerTextDrawColor(playerid, HandyCallContact_[playerid], -1);
PlayerTextDrawUseBox(playerid, HandyCallContact_[playerid], 1);
PlayerTextDrawBoxColor(playerid, HandyCallContact_[playerid], -1);
PlayerTextDrawSetShadow(playerid, HandyCallContact_[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, HandyCallContact_[playerid], 255);
PlayerTextDrawFont(playerid,HandyCallContact_[playerid], 4);
PlayerTextDrawSetSelectable(playerid,HandyCallContact_[playerid], true);

HandyCHProfile[playerid] = CreatePlayerTextDraw(playerid, 542.666687, 267.155426, "Customize Profile");
PlayerTextDrawLetterSize(playerid, HandyCHProfile[playerid], 0.249666, 1.442370);
PlayerTextDrawTextSize(playerid, HandyCHProfile[playerid], 1500.00000, 800.000000);
PlayerTextDrawAlignment(playerid, HandyCHProfile[playerid], 1);
PlayerTextDrawColor(playerid, HandyCHProfile[playerid], 255);
PlayerTextDrawBoxColor(playerid, HandyCHProfile[playerid], -1);
PlayerTextDrawSetShadow(playerid, HandyCHProfile[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, HandyCHProfile[playerid], 255);
PlayerTextDrawFont(playerid,HandyCHProfile[playerid], 1);

HandyCHProfile_[playerid] = CreatePlayerTextDraw(playerid, 535.999938, 266.999938, "LD_SPAC:white");
PlayerTextDrawTextSize(playerid, HandyCHProfile_[playerid], 87.000000, 15.000000);
PlayerTextDrawAlignment(playerid, HandyCHProfile_[playerid], 1);
PlayerTextDrawColor(playerid, HandyCHProfile_[playerid], -1);
PlayerTextDrawUseBox(playerid, HandyCHProfile_[playerid], 1);
PlayerTextDrawBoxColor(playerid, HandyCHProfile_[playerid], -1);
PlayerTextDrawSetShadow(playerid, HandyCHProfile_[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, HandyCHProfile_[playerid], 255);
PlayerTextDrawFont(playerid,HandyCHProfile_[playerid], 4);
PlayerTextDrawSetSelectable(playerid, HandyCHProfile_[playerid], true);

HandyInfo_Nummer[playerid] = CreatePlayerTextDraw(playerid, 578.666809, 282.066680, "Number: 000000");
PlayerTextDrawLetterSize(playerid, HandyInfo_Nummer[playerid], 0.268332, 1.338665);
PlayerTextDrawAlignment(playerid, HandyInfo_Nummer[playerid], 2);
PlayerTextDrawColor(playerid, HandyInfo_Nummer[playerid], 255);
PlayerTextDrawSetShadow(playerid, HandyInfo_Nummer[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, HandyInfo_Nummer[playerid], 255);
PlayerTextDrawFont(playerid, HandyInfo_Nummer[playerid], 1);
PlayerTextDrawSetProportional(playerid, HandyInfo_Nummer[playerid], 1);

HandyInfo_Status[playerid] = CreatePlayerTextDraw(playerid, 578.666809, 293.066680, "Online");
PlayerTextDrawLetterSize(playerid, HandyInfo_Status[playerid], 0.268332, 1.338665);
PlayerTextDrawAlignment(playerid, HandyInfo_Status[playerid], 2);
PlayerTextDrawColor(playerid, HandyInfo_Status[playerid], 255);
PlayerTextDrawSetShadow(playerid, HandyInfo_Status[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, HandyInfo_Status[playerid], 255);
PlayerTextDrawFont(playerid, HandyInfo_Status[playerid], 1);
PlayerTextDrawSetProportional(playerid, HandyInfo_Status[playerid], 1);

HandyKontaktProfilFarbe[playerid] = CreatePlayerTextDraw(playerid, 536.168579, 216.792572, "LD_SPAC:white");
PlayerTextDrawTextSize(playerid, HandyKontaktProfilFarbe[playerid], 40.680053, 44.000000);
PlayerTextDrawAlignment(playerid, HandyKontaktProfilFarbe[playerid], 1);
PlayerTextDrawColor(playerid, HandyKontaktProfilFarbe[playerid], 255);
PlayerTextDrawSetShadow(playerid, HandyKontaktProfilFarbe[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, HandyKontaktProfilFarbe[playerid], 255);
PlayerTextDrawFont(playerid, HandyKontaktProfilFarbe[playerid], 4);
PlayerTextDrawSetProportional(playerid, HandyKontaktProfilFarbe[playerid], 0);

HandyKontaktProfilBild[playerid] = CreatePlayerTextDraw(playerid, 539.568847, 220.377700, "LD_SPAC:white");
PlayerTextDrawTextSize(playerid, HandyKontaktProfilBild[playerid], 33.860031, 37.220142);
PlayerTextDrawAlignment(playerid, HandyKontaktProfilBild[playerid], 1);
PlayerTextDrawColor(playerid, HandyKontaktProfilBild[playerid], -1);
PlayerTextDrawSetShadow(playerid, HandyKontaktProfilBild[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, HandyKontaktProfilBild[playerid], 255);
PlayerTextDrawFont(playerid, HandyKontaktProfilBild[playerid], 4);
PlayerTextDrawSetProportional(playerid, HandyKontaktProfilBild[playerid], 0);

HandyTonEinstellungen[playerid][0] = CreatePlayerTextDraw(playerid, 586.233032, 215.481338, "LD_SPAC:white");
PlayerTextDrawTextSize(playerid, HandyTonEinstellungen[playerid][0], 29.000000, 34.000000);
PlayerTextDrawAlignment(playerid, HandyTonEinstellungen[playerid][0], 1);
PlayerTextDrawColor(playerid, HandyTonEinstellungen[playerid][0], -1);
PlayerTextDrawSetShadow(playerid, HandyTonEinstellungen[playerid][0], 0);
PlayerTextDrawBackgroundColor(playerid, HandyTonEinstellungen[playerid][0], 255);
PlayerTextDrawFont(playerid, HandyTonEinstellungen[playerid][0], 4);
PlayerTextDrawSetProportional(playerid, HandyTonEinstellungen[playerid][0], 0);
PlayerTextDrawSetSelectable(playerid, HandyTonEinstellungen[playerid][0], true);

HandyTonEinstellungen[playerid][1] = CreatePlayerTextDraw(playerid, 590.765930, 226.312301, "LD_SPAC:white");
PlayerTextDrawTextSize(playerid, HandyTonEinstellungen[playerid][1], 12.000000, 11.000000);
PlayerTextDrawAlignment(playerid, HandyTonEinstellungen[playerid][1], 1);
PlayerTextDrawColor(playerid, HandyTonEinstellungen[playerid][1], 255);
PlayerTextDrawSetShadow(playerid, HandyTonEinstellungen[playerid][1], 0);
PlayerTextDrawBackgroundColor(playerid, HandyTonEinstellungen[playerid][1], 255);
PlayerTextDrawFont(playerid, HandyTonEinstellungen[playerid][1], 4);
PlayerTextDrawSetProportional(playerid, HandyTonEinstellungen[playerid][1], 0);

HandyTonEinstellungen[playerid][2] = CreatePlayerTextDraw(playerid, 589.399719, 221.111160, "");
PlayerTextDrawTextSize(playerid, HandyTonEinstellungen[playerid][2], 21.000000, 22.000000);
PlayerTextDrawAlignment(playerid, HandyTonEinstellungen[playerid][2], 1);
PlayerTextDrawColor(playerid, HandyTonEinstellungen[playerid][2], 255);
PlayerTextDrawSetShadow(playerid, HandyTonEinstellungen[playerid][2], 0);
PlayerTextDrawBackgroundColor(playerid, HandyTonEinstellungen[playerid][2], 875836416);
PlayerTextDrawFont(playerid, HandyTonEinstellungen[playerid][2], 5);
PlayerTextDrawSetProportional(playerid, HandyTonEinstellungen[playerid][2], 0);
PlayerTextDrawSetPreviewModel(playerid, HandyTonEinstellungen[playerid][2], 19362);
PlayerTextDrawSetPreviewRot(playerid, HandyTonEinstellungen[playerid][2], 0.000000, 0.000000, 30.000000, 1.000000);

HandyTonEinstellungen[playerid][3] = CreatePlayerTextDraw(playerid, 605.083862, 221.666580, ")");
PlayerTextDrawLetterSize(playerid, HandyTonEinstellungen[playerid][3], 0.480666, 1.891260);
PlayerTextDrawTextSize(playerid, HandyTonEinstellungen[playerid][3], 5.000000, 0.000000);
PlayerTextDrawAlignment(playerid, HandyTonEinstellungen[playerid][3], 1);
PlayerTextDrawColor(playerid, HandyTonEinstellungen[playerid][3], 255);
PlayerTextDrawSetShadow(playerid, HandyTonEinstellungen[playerid][3], 0);
PlayerTextDrawBackgroundColor(playerid, HandyTonEinstellungen[playerid][3], 255);
PlayerTextDrawFont(playerid, HandyTonEinstellungen[playerid][3], 1);
PlayerTextDrawSetProportional(playerid, HandyTonEinstellungen[playerid][3], 1);

HandyKlingelton[playerid] = CreatePlayerTextDraw(playerid, 533.333312, 211.540725, "Ringtone:");
PlayerTextDrawLetterSize(playerid, HandyKlingelton[playerid], 0.300000, 1.200000);
PlayerTextDrawAlignment(playerid, HandyKlingelton[playerid], 1);
PlayerTextDrawColor(playerid, HandyKlingelton[playerid], 255);
PlayerTextDrawSetShadow(playerid, HandyKlingelton[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, HandyKlingelton[playerid], 255);
PlayerTextDrawFont(playerid, HandyKlingelton[playerid], 1);
PlayerTextDrawSetProportional(playerid, HandyKlingelton[playerid], 1);

HandyKlingelton1[playerid] = CreatePlayerTextDraw(playerid, 536.333190, 219.392639, "LD_BEAT:chit");
PlayerTextDrawTextSize(playerid, HandyKlingelton1[playerid], 27.000000, 30.000000);
PlayerTextDrawAlignment(playerid, HandyKlingelton1[playerid], 1);
PlayerTextDrawColor(playerid, HandyKlingelton1[playerid], 255);
PlayerTextDrawSetShadow(playerid, HandyKlingelton1[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, HandyKlingelton1[playerid], 255);
PlayerTextDrawFont(playerid, HandyKlingelton1[playerid], 4);
PlayerTextDrawSetProportional(playerid, HandyKlingelton1[playerid], 0);
PlayerTextDrawSetSelectable(playerid, HandyKlingelton1[playerid], true);

HandyKlingelton2[playerid] = CreatePlayerTextDraw(playerid, 567.000000, 219.392639, "LD_BEAT:chit");
PlayerTextDrawTextSize(playerid, HandyKlingelton2[playerid], 27.000000, 30.000000);
PlayerTextDrawAlignment(playerid, HandyKlingelton2[playerid], 1);
PlayerTextDrawColor(playerid, HandyKlingelton2[playerid], 255);
PlayerTextDrawSetShadow(playerid, HandyKlingelton2[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, HandyKlingelton2[playerid], 255);
PlayerTextDrawFont(playerid, HandyKlingelton2[playerid], 4);
PlayerTextDrawSetProportional(playerid, HandyKlingelton2[playerid], 0);
PlayerTextDrawSetSelectable(playerid, HandyKlingelton2[playerid], true);

HandyKlingelton3[playerid] = CreatePlayerTextDraw(playerid, 597.333312, 219.392639, "LD_BEAT:chit");
PlayerTextDrawTextSize(playerid, HandyKlingelton3[playerid], 27.000000, 30.000000);
PlayerTextDrawAlignment(playerid, HandyKlingelton3[playerid], 1);
PlayerTextDrawColor(playerid, HandyKlingelton3[playerid], 255);
PlayerTextDrawSetShadow(playerid, HandyKlingelton3[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, HandyKlingelton3[playerid], 255);
PlayerTextDrawFont(playerid, HandyKlingelton3[playerid], 4);
PlayerTextDrawSetProportional(playerid, HandyKlingelton3[playerid], 0);
PlayerTextDrawSetSelectable(playerid, HandyKlingelton3[playerid], true);

HandyKlingelton1_[playerid] = CreatePlayerTextDraw(playerid, 546.000000, 227.014816, "1");
PlayerTextDrawLetterSize(playerid, HandyKlingelton1_[playerid], 0.400000, 1.600000);
PlayerTextDrawTextSize(playerid, HandyKlingelton1_[playerid], 558.000000, 0.000000);
PlayerTextDrawAlignment(playerid, HandyKlingelton1_[playerid], 1);
PlayerTextDrawColor(playerid, HandyKlingelton1_[playerid], -1);
PlayerTextDrawSetShadow(playerid, HandyKlingelton1_[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, HandyKlingelton1_[playerid], 0);
PlayerTextDrawFont(playerid, HandyKlingelton1_[playerid], 1);
PlayerTextDrawSetProportional(playerid, HandyKlingelton1_[playerid], 0);
PlayerTextDrawSetSelectable(playerid, HandyKlingelton1_[playerid], true);

HandyKlingelton2_[playerid] = CreatePlayerTextDraw(playerid, 576.333435, 227.014816, "2");
PlayerTextDrawLetterSize(playerid, HandyKlingelton2_[playerid], 0.400000, 1.600000);
PlayerTextDrawTextSize(playerid, HandyKlingelton2_[playerid], 24.000000, 25.000000);
PlayerTextDrawAlignment(playerid, HandyKlingelton2_[playerid], 1);
PlayerTextDrawColor(playerid, HandyKlingelton2_[playerid], -1);
PlayerTextDrawSetShadow(playerid, HandyKlingelton2_[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, HandyKlingelton2_[playerid], 1);
PlayerTextDrawFont(playerid, HandyKlingelton2_[playerid], 1);
PlayerTextDrawSetProportional(playerid, HandyKlingelton2_[playerid], 0);
PlayerTextDrawSetSelectable(playerid, HandyKlingelton2_[playerid], true);

HandyKlingelton3_[playerid] = CreatePlayerTextDraw(playerid, 606.333312, 227.014816, "3");
PlayerTextDrawLetterSize(playerid, HandyKlingelton3_[playerid], 0.400000, 1.600000);
PlayerTextDrawTextSize(playerid, HandyKlingelton3_[playerid], 24.000000, 25.000000);
PlayerTextDrawAlignment(playerid, HandyKlingelton3_[playerid], 1);
PlayerTextDrawColor(playerid, HandyKlingelton3_[playerid], -1);
PlayerTextDrawSetShadow(playerid, HandyKlingelton3_[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, HandyKlingelton3_[playerid], 1);
PlayerTextDrawFont(playerid, HandyKlingelton3_[playerid], 1);
PlayerTextDrawSetProportional(playerid, HandyKlingelton3_[playerid], 0);
PlayerTextDrawSetSelectable(playerid, HandyKlingelton3_[playerid], true);

HandyNachrichtenton[playerid] = CreatePlayerTextDraw(playerid, 534.333312, 245.003778, "Message_Sound:");
PlayerTextDrawLetterSize(playerid, HandyNachrichtenton[playerid], 0.300000, 1.200000);
PlayerTextDrawTextSize(playerid, HandyNachrichtenton[playerid], -2.000000, 0.000000);
PlayerTextDrawAlignment(playerid, HandyNachrichtenton[playerid], 1);
PlayerTextDrawColor(playerid, HandyNachrichtenton[playerid], 255);
PlayerTextDrawSetShadow(playerid, HandyNachrichtenton[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, HandyNachrichtenton[playerid], 255);
PlayerTextDrawFont(playerid, HandyNachrichtenton[playerid], 1);
PlayerTextDrawSetProportional(playerid, HandyNachrichtenton[playerid], 1);

HandyNachrichtenton1[playerid] = CreatePlayerTextDraw(playerid, 537.333435, 254.103790, "LD_BEAT:chit");
PlayerTextDrawTextSize(playerid, HandyNachrichtenton1[playerid], 27.000000, 30.000000);
PlayerTextDrawAlignment(playerid, HandyNachrichtenton1[playerid], 1);
PlayerTextDrawColor(playerid, HandyNachrichtenton1[playerid], 255);
PlayerTextDrawSetShadow(playerid, HandyNachrichtenton1[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, HandyNachrichtenton1[playerid], 255);
PlayerTextDrawFont(playerid, HandyNachrichtenton1[playerid], 4);
PlayerTextDrawSetProportional(playerid, HandyNachrichtenton1[playerid], 0);
PlayerTextDrawSetSelectable(playerid, HandyNachrichtenton1[playerid], true);

HandyNachrichtenton2[playerid] = CreatePlayerTextDraw(playerid, 567.000000, 254.103790, "LD_BEAT:chit");
PlayerTextDrawTextSize(playerid, HandyNachrichtenton2[playerid], 27.000000, 30.000000);
PlayerTextDrawAlignment(playerid, HandyNachrichtenton2[playerid], 1);
PlayerTextDrawColor(playerid, HandyNachrichtenton2[playerid], 255);
PlayerTextDrawSetShadow(playerid, HandyNachrichtenton2[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, HandyNachrichtenton1[playerid], 255);
PlayerTextDrawFont(playerid, HandyNachrichtenton2[playerid], 4);
PlayerTextDrawSetProportional(playerid, HandyNachrichtenton2[playerid], 0);
PlayerTextDrawSetSelectable(playerid, HandyNachrichtenton2[playerid], true);

HandyNachrichtenton3[playerid] = CreatePlayerTextDraw(playerid, 597.333312, 254.103790, "LD_BEAT:chit");
PlayerTextDrawTextSize(playerid, HandyNachrichtenton3[playerid], 27.000000, 30.000000);
PlayerTextDrawAlignment(playerid, HandyNachrichtenton3[playerid], 1);
PlayerTextDrawColor(playerid, HandyNachrichtenton3[playerid], 255);
PlayerTextDrawSetShadow(playerid, HandyNachrichtenton3[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, HandyNachrichtenton3[playerid], 255);
PlayerTextDrawFont(playerid, HandyNachrichtenton3[playerid], 4);
PlayerTextDrawSetProportional(playerid, HandyNachrichtenton3[playerid], 0);
PlayerTextDrawSetSelectable(playerid, HandyNachrichtenton3[playerid], true);

HandyNachrichtenton1_[playerid] = CreatePlayerTextDraw(playerid, 546.666442, 260.822387, "1");
PlayerTextDrawLetterSize(playerid, HandyNachrichtenton1_[playerid], 0.400000, 1.600000);
PlayerTextDrawTextSize(playerid, HandyNachrichtenton1_[playerid], 24.000000, 25.000000);
PlayerTextDrawAlignment(playerid, HandyNachrichtenton1_[playerid], 1);
PlayerTextDrawColor(playerid, HandyNachrichtenton1_[playerid], -1);
PlayerTextDrawSetShadow(playerid, HandyNachrichtenton1_[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, HandyNachrichtenton1_[playerid], 1);
PlayerTextDrawFont(playerid, HandyNachrichtenton1_[playerid], 1);
PlayerTextDrawSetProportional(playerid, HandyNachrichtenton1_[playerid], 0);
PlayerTextDrawSetSelectable(playerid, HandyNachrichtenton1_[playerid], true);

HandyNachrichtenton2_[playerid] = CreatePlayerTextDraw(playerid, 576.333435, 260.822387, "2");
PlayerTextDrawLetterSize(playerid, HandyNachrichtenton2_[playerid], 0.400000, 1.600000);
PlayerTextDrawTextSize(playerid, HandyNachrichtenton2_[playerid], 24.000000, 25.000000);
PlayerTextDrawAlignment(playerid, HandyNachrichtenton2_[playerid], 1);
PlayerTextDrawColor(playerid, HandyNachrichtenton2_[playerid], -1);
PlayerTextDrawSetShadow(playerid, HandyNachrichtenton2_[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, HandyNachrichtenton2_[playerid], 1);
PlayerTextDrawFont(playerid, HandyNachrichtenton2_[playerid], 1);
PlayerTextDrawSetProportional(playerid, HandyNachrichtenton2_[playerid], 0);
PlayerTextDrawSetSelectable(playerid, HandyNachrichtenton2_[playerid], true);

HandyNachrichtenton3_[playerid] = CreatePlayerTextDraw(playerid, 606.333312, 260.822387, "3");
PlayerTextDrawLetterSize(playerid, HandyNachrichtenton3_[playerid], 0.400000, 1.600000);
PlayerTextDrawTextSize(playerid, HandyNachrichtenton3_[playerid], 24.000000, 25.000000);
PlayerTextDrawAlignment(playerid, HandyNachrichtenton3_[playerid], 1);
PlayerTextDrawColor(playerid, HandyNachrichtenton3_[playerid], -1);
PlayerTextDrawSetShadow(playerid, HandyNachrichtenton3_[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, HandyNachrichtenton3_[playerid], 1);
PlayerTextDrawFont(playerid, HandyNachrichtenton3_[playerid], 1);
PlayerTextDrawSetProportional(playerid, HandyNachrichtenton3_[playerid], 0);
PlayerTextDrawSetSelectable(playerid, HandyNachrichtenton3_[playerid], true);

HandyMute[playerid][0] = CreatePlayerTextDraw(playerid, 565.450256, 282.813201, "LD_SPAC:white");
PlayerTextDrawTextSize(playerid, HandyMute[playerid][0], 42.000000, 22.000000);
PlayerTextDrawAlignment(playerid, HandyMute[playerid][0], 1);
PlayerTextDrawColor(playerid, HandyMute[playerid][0], -1);
PlayerTextDrawSetShadow(playerid, HandyMute[playerid][0], 0);
PlayerTextDrawBackgroundColor(playerid, HandyMute[playerid][0], 255);
PlayerTextDrawFont(playerid, HandyMute[playerid][0], 4);
PlayerTextDrawSetProportional(playerid, HandyMute[playerid][0], 0);
PlayerTextDrawSetSelectable(playerid, HandyMute[playerid][0], true);

HandyMute[playerid][1] = CreatePlayerTextDraw(playerid, 569.233459, 288.276062, "LD_SPAC:white");
PlayerTextDrawTextSize(playerid, HandyMute[playerid][1], 12.000000, 11.000000);
PlayerTextDrawAlignment(playerid, HandyMute[playerid][1], 1);
PlayerTextDrawColor(playerid, HandyMute[playerid][1], 255);
PlayerTextDrawSetShadow(playerid, HandyMute[playerid][1], 0);
PlayerTextDrawBackgroundColor(playerid, HandyMute[playerid][1], 255);
PlayerTextDrawFont(playerid, HandyMute[playerid][1], 4);
PlayerTextDrawSetProportional(playerid, HandyMute[playerid][1], 0);

HandyMute[playerid][2] = CreatePlayerTextDraw(playerid, 587.750549, 283.474029, "Wika");
PlayerTextDrawLetterSize(playerid, HandyMute[playerid][2], 0.480666, 1.891260);
PlayerTextDrawTextSize(playerid, HandyMute[playerid][2], 5.000000, 0.000000);
PlayerTextDrawAlignment(playerid, HandyMute[playerid][2], 1);
PlayerTextDrawColor(playerid, HandyMute[playerid][2], 255);
PlayerTextDrawSetShadow(playerid, HandyMute[playerid][2], 0);
PlayerTextDrawBackgroundColor(playerid, HandyMute[playerid][2], 255);
PlayerTextDrawFont(playerid, HandyMute[playerid][2], 1);
PlayerTextDrawSetProportional(playerid, HandyMute[playerid][2], 1);

HandyMute[playerid][3] = CreatePlayerTextDraw(playerid, 569.265991, 282.859436, "");
PlayerTextDrawTextSize(playerid, HandyMute[playerid][3], 21.000000, 22.000000);
PlayerTextDrawAlignment(playerid, HandyMute[playerid][3], 1);
PlayerTextDrawColor(playerid, HandyMute[playerid][3], 255);
PlayerTextDrawSetShadow(playerid, HandyMute[playerid][3], 0);
PlayerTextDrawBackgroundColor(playerid, HandyMute[playerid][3], 875836416);
PlayerTextDrawFont(playerid, HandyMute[playerid][3], 5);
PlayerTextDrawSetProportional(playerid, HandyMute[playerid][3], 0);
PlayerTextDrawSetPreviewModel(playerid, HandyMute[playerid][3], 19362);
PlayerTextDrawSetPreviewRot(playerid, HandyMute[playerid][3], 0.000000, 0.000000, 30.000000, 1.000000);

HandyMute[playerid][4] = CreatePlayerTextDraw(playerid, 535.666564, 288.311187, "Mute:");
PlayerTextDrawLetterSize(playerid, HandyMute[playerid][4], 0.300000, 1.200000);
PlayerTextDrawAlignment(playerid, HandyMute[playerid][4], 1);
PlayerTextDrawColor(playerid, HandyMute[playerid][4], 255);
PlayerTextDrawSetShadow(playerid, HandyMute[playerid][4], 0);
PlayerTextDrawBackgroundColor(playerid, HandyMute[playerid][4], 255);
PlayerTextDrawFont(playerid, HandyMute[playerid][4], 1);
PlayerTextDrawSetProportional(playerid, HandyMute[playerid][4], 1);

HandyAnrufMenu[playerid][2] = CreatePlayerTextDraw(playerid, 536.566589, 225.840530, "LD_SPAC:white");
PlayerTextDrawTextSize(playerid, HandyAnrufMenu[playerid][2], 84.979995, 27.090002);
PlayerTextDrawAlignment(playerid, HandyAnrufMenu[playerid][2], 1);
PlayerTextDrawColor(playerid, HandyAnrufMenu[playerid][2], -1);
PlayerTextDrawSetShadow(playerid, HandyAnrufMenu[playerid][2], 0);
PlayerTextDrawBackgroundColor(playerid, HandyAnrufMenu[playerid][2], 255);
PlayerTextDrawFont(playerid, HandyAnrufMenu[playerid][2], 4);
PlayerTextDrawSetProportional(playerid, HandyAnrufMenu[playerid][2], 0);

HandyAnrufMenu[playerid][0] = CreatePlayerTextDraw(playerid, 578.999938, 231.929626, "94247");
PlayerTextDrawLetterSize(playerid, HandyAnrufMenu[playerid][0], 0.400000, 1.600000);
PlayerTextDrawAlignment(playerid, HandyAnrufMenu[playerid][0], 2);
PlayerTextDrawColor(playerid, HandyAnrufMenu[playerid][0], 255);
PlayerTextDrawSetShadow(playerid, HandyAnrufMenu[playerid][0], 0);
PlayerTextDrawBackgroundColor(playerid, HandyAnrufMenu[playerid][0], 255);
PlayerTextDrawFont(playerid, HandyAnrufMenu[playerid][0], 1);
PlayerTextDrawSetProportional(playerid, HandyAnrufMenu[playerid][0], 1);

HandyAnrufMenu[playerid][1] = CreatePlayerTextDraw(playerid, 538.400756, 256.129882, "Taxi_Service_bla~n~bla_bla");
PlayerTextDrawLetterSize(playerid, HandyAnrufMenu[playerid][1], 0.299999, 1.440000);
PlayerTextDrawAlignment(playerid, HandyAnrufMenu[playerid][1], 1);
PlayerTextDrawColor(playerid, HandyAnrufMenu[playerid][1], 255);
PlayerTextDrawSetShadow(playerid, HandyAnrufMenu[playerid][1], 0);
PlayerTextDrawBackgroundColor(playerid, HandyAnrufMenu[playerid][1], 255);
PlayerTextDrawFont(playerid, HandyAnrufMenu[playerid][1], 1);
PlayerTextDrawSetProportional(playerid, HandyAnrufMenu[playerid][1], 1);

HandyAnrufMenu[playerid][3] = CreatePlayerTextDraw(playerid, 535.666809, 287.325897, "LD_SPAC:white");
PlayerTextDrawTextSize(playerid, HandyAnrufMenu[playerid][3], 52.149806, 12.000000);
PlayerTextDrawAlignment(playerid, HandyAnrufMenu[playerid][3], 1);
PlayerTextDrawColor(playerid, HandyAnrufMenu[playerid][3], -1);
PlayerTextDrawSetShadow(playerid, HandyAnrufMenu[playerid][3], 0);
PlayerTextDrawBackgroundColor(playerid, HandyAnrufMenu[playerid][3], 255);
PlayerTextDrawFont(playerid, HandyAnrufMenu[playerid][3], 4);
PlayerTextDrawSetProportional(playerid, HandyAnrufMenu[playerid][3], 0);
PlayerTextDrawSetSelectable(playerid, HandyAnrufMenu[playerid][3], true);

HandyAnrufMenu[playerid][4] = CreatePlayerTextDraw(playerid, 538.000244, 287.896331, "public_Service");
PlayerTextDrawLetterSize(playerid, HandyAnrufMenu[playerid][4], 0.220333, 1.081481);
PlayerTextDrawAlignment(playerid, HandyAnrufMenu[playerid][4], 1);
PlayerTextDrawColor(playerid, HandyAnrufMenu[playerid][4], 255);
PlayerTextDrawSetShadow(playerid, HandyAnrufMenu[playerid][4], 0);
PlayerTextDrawBackgroundColor(playerid, HandyAnrufMenu[playerid][4], 255);
PlayerTextDrawFont(playerid, HandyAnrufMenu[playerid][4], 1);
PlayerTextDrawSetProportional(playerid, HandyAnrufMenu[playerid][4], 1);

HandyAnrufMenu[playerid][5] = CreatePlayerTextDraw(playerid, 592.333435, 287.325897, "LD_SPAC:white");
PlayerTextDrawTextSize(playerid, HandyAnrufMenu[playerid][5], 30.000000, 12.000000);
PlayerTextDrawAlignment(playerid, HandyAnrufMenu[playerid][5], 1);
PlayerTextDrawColor(playerid, HandyAnrufMenu[playerid][5], -1);
PlayerTextDrawSetShadow(playerid, HandyAnrufMenu[playerid][5], 0);
PlayerTextDrawBackgroundColor(playerid, HandyAnrufMenu[playerid][5], 255);
PlayerTextDrawFont(playerid, HandyAnrufMenu[playerid][5], 4);
PlayerTextDrawSetProportional(playerid, HandyAnrufMenu[playerid][5], 0);
PlayerTextDrawSetSelectable(playerid, HandyAnrufMenu[playerid][5], true);

HandyAnrufMenu[playerid][6] = CreatePlayerTextDraw(playerid, 593.901062, 287.896331, "Friends");
PlayerTextDrawLetterSize(playerid, HandyAnrufMenu[playerid][6], 0.220333, 1.081481);
PlayerTextDrawAlignment(playerid, HandyAnrufMenu[playerid][6], 1);
PlayerTextDrawColor(playerid, HandyAnrufMenu[playerid][6], 255);
PlayerTextDrawSetShadow(playerid, HandyAnrufMenu[playerid][6], 0);
PlayerTextDrawBackgroundColor(playerid, HandyAnrufMenu[playerid][6], 255);
PlayerTextDrawFont(playerid, HandyAnrufMenu[playerid][6], 1);
PlayerTextDrawSetProportional(playerid, HandyAnrufMenu[playerid][6], 1);

HandyAngerufen[playerid][0] = CreatePlayerTextDraw(playerid, 531.666564, 211.744415, "LD_SPAC:white");
PlayerTextDrawTextSize(playerid, HandyAngerufen[playerid][0], 94.761016, 93.230690);
PlayerTextDrawAlignment(playerid, HandyAngerufen[playerid][0], 1);
PlayerTextDrawColor(playerid, HandyAngerufen[playerid][0], -1061109505);
PlayerTextDrawSetShadow(playerid, HandyAngerufen[playerid][0], 0);
PlayerTextDrawBackgroundColor(playerid, HandyAngerufen[playerid][0], 255);
PlayerTextDrawFont(playerid, HandyAngerufen[playerid][0], 4);
PlayerTextDrawSetProportional(playerid, HandyAngerufen[playerid][0], 0);

HandyAngerufen[playerid][1] = CreatePlayerTextDraw(playerid, 555.666259, 215.148208, "LD_SPAC:white");
PlayerTextDrawTextSize(playerid, HandyAngerufen[playerid][1], 47.000000, 51.000000);
PlayerTextDrawAlignment(playerid, HandyAngerufen[playerid][1], 1);
PlayerTextDrawColor(playerid, HandyAngerufen[playerid][1], 255);
PlayerTextDrawSetShadow(playerid, HandyAngerufen[playerid][1], 0);
PlayerTextDrawBackgroundColor(playerid, HandyAngerufen[playerid][1], 255);
PlayerTextDrawFont(playerid, HandyAngerufen[playerid][1], 4);
PlayerTextDrawSetProportional(playerid, HandyAngerufen[playerid][1], 0);

HandyAngerufen[playerid][2] = CreatePlayerTextDraw(playerid, 559.865234, 220.348526, "LD_SPAC:white");
PlayerTextDrawTextSize(playerid, HandyAngerufen[playerid][2], 38.000000, 40.000000);
PlayerTextDrawAlignment(playerid, HandyAngerufen[playerid][2], 1);
PlayerTextDrawColor(playerid, HandyAngerufen[playerid][2], -1);
PlayerTextDrawSetShadow(playerid, HandyAngerufen[playerid][2], 0);
PlayerTextDrawBackgroundColor(playerid, HandyAngerufen[playerid][2], 255);
PlayerTextDrawFont(playerid, HandyAngerufen[playerid][2], 4);
PlayerTextDrawSetProportional(playerid, HandyAngerufen[playerid][2], 0);

HandyAngerufen[playerid][3] = CreatePlayerTextDraw(playerid, 580.666748, 270.473876, "PLAYERNAME~n~is_calling_you");
PlayerTextDrawLetterSize(playerid, HandyAngerufen[playerid][3], 0.240000, 1.550222);
PlayerTextDrawAlignment(playerid, HandyAngerufen[playerid][3], 2);
PlayerTextDrawColor(playerid, HandyAngerufen[playerid][3], 255);
PlayerTextDrawSetShadow(playerid, HandyAngerufen[playerid][3], 0);
PlayerTextDrawBackgroundColor(playerid, HandyAngerufen[playerid][3], 255);
PlayerTextDrawFont(playerid, HandyAngerufen[playerid][3], 1);
PlayerTextDrawSetProportional(playerid, HandyAngerufen[playerid][3], 1);

HandyMusikApp[playerid][0] = CreatePlayerTextDraw(playerid, 531.966369, 276.181488, "LD_BEAT:chit");
PlayerTextDrawTextSize(playerid, HandyMusikApp[playerid][0], 24.429998, 28.939998);
PlayerTextDrawAlignment(playerid, HandyMusikApp[playerid][0], 1);
PlayerTextDrawColor(playerid, HandyMusikApp[playerid][0], -1);
PlayerTextDrawBackgroundColor(playerid, HandyMusikApp[playerid][0], 255);
PlayerTextDrawFont(playerid, HandyMusikApp[playerid][0], 4);
PlayerTextDrawSetSelectable(playerid, HandyMusikApp[playerid][0], true);

HandyMusikApp[playerid][1] = CreatePlayerTextDraw(playerid, 555.365417, 276.181488, "LD_BEAT:chit");
PlayerTextDrawTextSize(playerid, HandyMusikApp[playerid][1], 24.429998, 28.939998);
PlayerTextDrawAlignment(playerid, HandyMusikApp[playerid][1], 1);
PlayerTextDrawColor(playerid, HandyMusikApp[playerid][1], -1);
PlayerTextDrawBackgroundColor(playerid, HandyMusikApp[playerid][1], 255);
PlayerTextDrawFont(playerid, HandyMusikApp[playerid][1], 4);
PlayerTextDrawSetSelectable(playerid, HandyMusikApp[playerid][1], true);

HandyMusikApp[playerid][2] = CreatePlayerTextDraw(playerid, 579.664428, 276.181488, "LD_BEAT:chit");
PlayerTextDrawTextSize(playerid, HandyMusikApp[playerid][2], 24.429998, 28.939998);
PlayerTextDrawAlignment(playerid, HandyMusikApp[playerid][2], 1);
PlayerTextDrawColor(playerid, HandyMusikApp[playerid][2], -1);
PlayerTextDrawBackgroundColor(playerid, HandyMusikApp[playerid][2], 255);
PlayerTextDrawFont(playerid, HandyMusikApp[playerid][2], 4);
PlayerTextDrawSetSelectable(playerid, HandyMusikApp[playerid][2], true);

HandyMusikApp[playerid][3] = CreatePlayerTextDraw(playerid, 601.863525, 276.181488, "LD_BEAT:chit");
PlayerTextDrawTextSize(playerid, HandyMusikApp[playerid][3], 24.429998, 28.939998);
PlayerTextDrawAlignment(playerid, HandyMusikApp[playerid][3], 1);
PlayerTextDrawColor(playerid, HandyMusikApp[playerid][3], -1);
PlayerTextDrawBackgroundColor(playerid, HandyMusikApp[playerid][3], 255);
PlayerTextDrawFont(playerid, HandyMusikApp[playerid][3], 4);
PlayerTextDrawSetSelectable(playerid, HandyMusikApp[playerid][3], true);

HandyMusikApp[playerid][4] = CreatePlayerTextDraw(playerid, 579.366638, 266.466613, "Interpret");
PlayerTextDrawLetterSize(playerid, HandyMusikApp[playerid][4], 0.16, 0.6);
PlayerTextDrawTextSize(playerid, HandyMusikApp[playerid][4], 0.000000, -18.000000);
PlayerTextDrawAlignment(playerid, HandyMusikApp[playerid][4], 2);
PlayerTextDrawColor(playerid, HandyMusikApp[playerid][4], -1);
PlayerTextDrawSetShadow(playerid, HandyMusikApp[playerid][4], 0);
PlayerTextDrawBackgroundColor(playerid, HandyMusikApp[playerid][4], 255);
PlayerTextDrawFont(playerid, HandyMusikApp[playerid][4], 1);
PlayerTextDrawSetProportional(playerid, HandyMusikApp[playerid][4], 1);

HandyMusikApp[playerid][5] = CreatePlayerTextDraw(playerid, 579.366638, 257.466979, "Liedtitel");
PlayerTextDrawLetterSize(playerid, HandyMusikApp[playerid][5], 0.19, 0.7);
PlayerTextDrawTextSize(playerid, HandyMusikApp[playerid][5], 0.000000, -18.000000);
PlayerTextDrawAlignment(playerid, HandyMusikApp[playerid][5], 2);
PlayerTextDrawColor(playerid, HandyMusikApp[playerid][5], -1);
PlayerTextDrawSetShadow(playerid, HandyMusikApp[playerid][5], 0);
PlayerTextDrawBackgroundColor(playerid, HandyMusikApp[playerid][5], 255);
PlayerTextDrawFont(playerid, HandyMusikApp[playerid][5], 1);
PlayerTextDrawSetProportional(playerid, HandyMusikApp[playerid][5], 1);

HandyMusikApp[playerid][6] = CreatePlayerTextDraw(playerid, 537.700866, 215.262969, "LD_SPAC:white");
PlayerTextDrawTextSize(playerid, HandyMusikApp[playerid][6], 42.000000, 41.000000);
PlayerTextDrawAlignment(playerid, HandyMusikApp[playerid][6], 1);
PlayerTextDrawColor(playerid, HandyMusikApp[playerid][6], -1);
PlayerTextDrawBackgroundColor(playerid, HandyMusikApp[playerid][6], 255);
PlayerTextDrawFont(playerid, HandyMusikApp[playerid][6], 4);
PlayerTextDrawSetProportional(playerid, HandyMusikApp[playerid][6], 0);

HandyMusikApp[playerid][7] = CreatePlayerTextDraw(playerid, 590.631042, 220.167022, "LD_BEAT:chit");
PlayerTextDrawTextSize(playerid, HandyMusikApp[playerid][7], 28.000000, 32.000000);
PlayerTextDrawAlignment(playerid, HandyMusikApp[playerid][7], 1);
PlayerTextDrawColor(playerid, HandyMusikApp[playerid][7], -1);
PlayerTextDrawBackgroundColor(playerid, HandyMusikApp[playerid][7], 255);
PlayerTextDrawFont(playerid, HandyMusikApp[playerid][7], 4);
PlayerTextDrawSetSelectable(playerid, HandyMusikApp[playerid][7], true);

HandyMusikApp[playerid][8] = CreatePlayerTextDraw(playerid, 597.963989, 229.292907, "LD_BEAT:right");
PlayerTextDrawTextSize(playerid, HandyMusikApp[playerid][8], 15.000000, 15.000000);
PlayerTextDrawAlignment(playerid, HandyMusikApp[playerid][8], 1);
PlayerTextDrawColor(playerid, HandyMusikApp[playerid][8], 673720575);
PlayerTextDrawBackgroundColor(playerid, HandyMusikApp[playerid][8], 255);
PlayerTextDrawFont(playerid, HandyMusikApp[playerid][8], 4);

HandyMusikApp[playerid][9] = CreatePlayerTextDraw(playerid, 542.533630, 284.940582, "~<~");
PlayerTextDrawLetterSize(playerid, HandyMusikApp[playerid][9], 0.332000, 1.143703);
PlayerTextDrawAlignment(playerid, HandyMusikApp[playerid][9], 1);
PlayerTextDrawColor(playerid, HandyMusikApp[playerid][9], 255);
PlayerTextDrawSetShadow(playerid, HandyMusikApp[playerid][9], 0);
PlayerTextDrawBackgroundColor(playerid, HandyMusikApp[playerid][9], 255);
PlayerTextDrawFont(playerid, HandyMusikApp[playerid][9], 1);
PlayerTextDrawSetProportional(playerid, HandyMusikApp[playerid][9], 1);

HandyMusikApp[playerid][10] = CreatePlayerTextDraw(playerid, 536.533264, 284.940582, "~<~");
PlayerTextDrawLetterSize(playerid, HandyMusikApp[playerid][10], 0.332000, 1.143703);
PlayerTextDrawAlignment(playerid, HandyMusikApp[playerid][10], 1);
PlayerTextDrawColor(playerid, HandyMusikApp[playerid][10], 255);
PlayerTextDrawSetShadow(playerid, HandyMusikApp[playerid][10], 0);
PlayerTextDrawBackgroundColor(playerid, HandyMusikApp[playerid][10], 255);
PlayerTextDrawFont(playerid, HandyMusikApp[playerid][10], 1);
PlayerTextDrawSetProportional(playerid, HandyMusikApp[playerid][10], 1);

HandyMusikApp[playerid][11] = CreatePlayerTextDraw(playerid, 607.935485, 284.940582, "~>~");
PlayerTextDrawLetterSize(playerid, HandyMusikApp[playerid][11], 0.332000, 1.143703);
PlayerTextDrawAlignment(playerid, HandyMusikApp[playerid][11], 1);
PlayerTextDrawColor(playerid, HandyMusikApp[playerid][11], 255);
PlayerTextDrawSetShadow(playerid, HandyMusikApp[playerid][11], 0);
PlayerTextDrawBackgroundColor(playerid, HandyMusikApp[playerid][11], 255);
PlayerTextDrawFont(playerid, HandyMusikApp[playerid][11], 1);
PlayerTextDrawSetProportional(playerid, HandyMusikApp[playerid][11], 1);

HandyMusikApp[playerid][12] = CreatePlayerTextDraw(playerid, 613.735412, 284.525756, "~>~");
PlayerTextDrawLetterSize(playerid, HandyMusikApp[playerid][12], 0.332000, 1.143703);
PlayerTextDrawAlignment(playerid, HandyMusikApp[playerid][12], 1);
PlayerTextDrawColor(playerid, HandyMusikApp[playerid][12], 255);
PlayerTextDrawSetShadow(playerid, HandyMusikApp[playerid][12], 0);
PlayerTextDrawBackgroundColor(playerid, HandyMusikApp[playerid][12], 255);
PlayerTextDrawFont(playerid, HandyMusikApp[playerid][12], 1);
PlayerTextDrawSetProportional(playerid, HandyMusikApp[playerid][12], 1);

HandyMusikApp[playerid][13] = CreatePlayerTextDraw(playerid, 588.534301, 284.940582, "~>~");
PlayerTextDrawLetterSize(playerid, HandyMusikApp[playerid][13], 0.332000, 1.143703);
PlayerTextDrawAlignment(playerid, HandyMusikApp[playerid][13], 1);
PlayerTextDrawColor(playerid, HandyMusikApp[playerid][13], 255);
PlayerTextDrawSetShadow(playerid, HandyMusikApp[playerid][13], 0);
PlayerTextDrawBackgroundColor(playerid, HandyMusikApp[playerid][13], 255);
PlayerTextDrawFont(playerid, HandyMusikApp[playerid][13], 1);
PlayerTextDrawSetProportional(playerid, HandyMusikApp[playerid][13], 1);

HandyMusikApp[playerid][14] = CreatePlayerTextDraw(playerid, 563.132751, 283.740509, "II");
PlayerTextDrawLetterSize(playerid, HandyMusikApp[playerid][14], 0.369999, 1.463703);
PlayerTextDrawAlignment(playerid, HandyMusikApp[playerid][14], 1);
PlayerTextDrawColor(playerid, HandyMusikApp[playerid][14], 673720575);
PlayerTextDrawSetShadow(playerid, HandyMusikApp[playerid][14], 0);
PlayerTextDrawBackgroundColor(playerid, HandyMusikApp[playerid][14], 255);
PlayerTextDrawFont(playerid, HandyMusikApp[playerid][14], 1);
PlayerTextDrawSetProportional(playerid, HandyMusikApp[playerid][14], 1);

HandyMusikApp[playerid][15] = CreatePlayerTextDraw(playerid, 598.799499, 220.810501, "x");
PlayerTextDrawLetterSize(playerid, HandyMusikApp[playerid][15], 0.589998, 2.753778);
PlayerTextDrawAlignment(playerid, HandyMusikApp[playerid][15], 1);
PlayerTextDrawColor(playerid, HandyMusikApp[playerid][15], -16776961);
PlayerTextDrawSetShadow(playerid, HandyMusikApp[playerid][15], 0);
PlayerTextDrawBackgroundColor(playerid, HandyMusikApp[playerid][8], 255);
PlayerTextDrawFont(playerid, HandyMusikApp[playerid][15], 1);
return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	    if(!strcmp(cmdtext, "/phone"))
        {
          if(GetPVarInt(playerid, "Handypause") ==1)
		  {
	         SelectTextDraw(playerid, 0x000000AB);
	         DeletePVar(playerid, "Handypause");
	         HandyZeitUpdate(playerid);
	         PlayerTextDrawSetString(playerid, HandyOrt[playerid], GetPlayerLocation(playerid));
		  }
		  if(HandyShowing[playerid] == 0)
		  {
	         SelectTextDraw(playerid, 0x000000AB);
	         HandyShowing[playerid] = 1;
	         PlayerTextDrawShow(playerid,Handy[playerid]);

	         PlayerTextDrawShow(playerid,HandyPlatzhalter[playerid]);
	         PlayerTextDrawShow(playerid,HandyBildschirm[playerid]);
	         PlayerTextDrawShow(playerid,HandyAnrufen[playerid][0]);
	         PlayerTextDrawShow(playerid,HandyAnrufen[playerid][1]);
	         PlayerTextDrawShow(playerid,HandyAnrufen[playerid][2]);
	         PlayerTextDrawShow(playerid,HandyAuflegen[playerid][0]);
	         PlayerTextDrawShow(playerid,HandyAuflegen[playerid][1]);
	         PlayerTextDrawShow(playerid,HandyAuflegen[playerid][2]);
	         PlayerTextDrawShow(playerid,HandyHome[playerid][0]);
	         PlayerTextDrawShow(playerid,HandyHome[playerid][1]);
	         PlayerTextDrawShow(playerid,HandyHome[playerid][2]);
	         PlayerTextDrawShow(playerid,HandyTasten[playerid][0]);
	         PlayerTextDrawShow(playerid,HandyTasten[playerid][1]);
	         PlayerTextDrawShow(playerid,HandyTasten[playerid][2]);
	         PlayerTextDrawShow(playerid,HandyTasten[playerid][3]);
	         PlayerTextDrawShow(playerid,HandyTasten[playerid][4]);
	         PlayerTextDrawShow(playerid,HandyTasten[playerid][5]);
	         PlayerTextDrawShow(playerid,HandyTasten[playerid][6]);
	         PlayerTextDrawShow(playerid,HandyTasten[playerid][7]);
	         PlayerTextDrawShow(playerid,HandyTasten[playerid][8]);
	         PlayerTextDrawShow(playerid,HandyTasten[playerid][9]);
	         PlayerTextDrawShow(playerid,HandyTasten[playerid][10]);
	         PlayerTextDrawShow(playerid,HandyTasten[playerid][11]);
	         PlayerTextDrawShow(playerid,HandyTasten[playerid][12]);
	         PlayerTextDrawShow(playerid,HandyTasten[playerid][13]);
	         PlayerTextDrawShow(playerid,HandyTasten[playerid][14]);
	         PlayerTextDrawShow(playerid,HandyTasten[playerid][15]);
	         PlayerTextDrawShow(playerid,HandyTasten[playerid][16]);
	         PlayerTextDrawShow(playerid,HandyTasten[playerid][17]);
	         PlayerTextDrawShow(playerid,HandyTasten[playerid][18]);
	         PlayerTextDrawShow(playerid,HandyTasten[playerid][19]);
	         PlayerTextDrawShow(playerid,HandyTasten[playerid][20]);
	         PlayerTextDrawShow(playerid,HandyTasten[playerid][21]);
	         PlayerTextDrawShow(playerid,HandyTasten[playerid][22]);
	         PlayerTextDrawShow(playerid,HandyTasten[playerid][23]);
	         PlayerTextDrawShow(playerid,HandyTasten[playerid][24]);
	         PlayerTextDrawShow(playerid,HandyTasten[playerid][25]);
	         PlayerTextDrawShow(playerid,HandyTasten[playerid][26]);
	         PlayerTextDrawShow(playerid,HandyTasten[playerid][27]);
	         PlayerTextDrawShow(playerid,HandyTasten[playerid][28]);
	         PlayerTextDrawShow(playerid,HandyTasten[playerid][29]);
	         PlayerTextDrawShow(playerid,HandyZeit[playerid]);
	         PlayerTextDrawShow(playerid,HandyOrt[playerid]);
	         PlayerTextDrawShow(playerid,HandyTelefonbuch[playerid][0]);
	         PlayerTextDrawShow(playerid,HandyTelefonbuch[playerid][1]);
	         PlayerTextDrawShow(playerid,HandyTelefonbuch[playerid][2]);
	         PlayerTextDrawShow(playerid,HandyTelefonbuch[playerid][3]);
	         PlayerTextDrawShow(playerid,HandyTelefonbuch[playerid][4]);
	         PlayerTextDrawShow(playerid,HandyTelefonbuch[playerid][5]);
	         PlayerTextDrawShow(playerid,HandyCalender[playerid][0]);
	         PlayerTextDrawShow(playerid,HandyCalender[playerid][1]);
	         PlayerTextDrawShow(playerid,HandyCalender[playerid][2]);
	         PlayerTextDrawShow(playerid,HandyCalender[playerid][3]);
	         PlayerTextDrawShow(playerid,HandyCalender[playerid][4]);
	         PlayerTextDrawShow(playerid,HandyMusik[playerid][0]);
	         PlayerTextDrawShow(playerid,HandyMusik[playerid][1]);
	         PlayerTextDrawShow(playerid,HandyMusik[playerid][2]);
	         PlayerTextDrawShow(playerid,HandyMusik[playerid][3]);
	         PlayerTextDrawShow(playerid,HandyMusik[playerid][4]);
	         PlayerTextDrawShow(playerid,HandyMusik[playerid][5]);
	         PlayerTextDrawShow(playerid,HandyMusik[playerid][6]);
	         PlayerTextDrawShow(playerid,HandyEinstellungen[playerid][0]);
	         PlayerTextDrawShow(playerid,HandyEinstellungen[playerid][1]);
	         PlayerTextDrawShow(playerid,HandyEinstellungen[playerid][2]);
	         HandyZeitUpdate(playerid);
	         PlayerTextDrawSetString(playerid, HandyOrt[playerid], GetPlayerLocation(playerid));
	         PlayerTextDrawSetString(playerid, HandyCalender[playerid][4], WochentagKurz());
		  }
		}
		return 0;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	    if((newkeys == KEY_YES) && (GetPlayerState(playerid)!= 2) || ((newkeys & KEY_FIRE) && (newkeys & KEY_YES) && (GetPlayerState(playerid) == 2)))
        {
          return OnPlayerCommandText(playerid, "/phone");
		}
		return 1;
}

public OnPlayerClickPlayerTextDraw(playerid, PlayerText:playertextid)
{
     if(playertextid == HandyAuflegen[playerid][0])
     {
	   if(HandyShowing[playerid] == 1)
	   {
	         CancelSelectTextDraw(playerid);
	         HandyShowing[playerid] = 0;
	         PlayerTextDrawHide(playerid, Handy[playerid]);
	         PlayerTextDrawHide(playerid, HandyPlatzhalter[playerid]);
	         PlayerTextDrawHide(playerid, HandyBildschirm[playerid]);
	         PlayerTextDrawHide(playerid, HandyAnrufen[playerid][0]);
	         PlayerTextDrawHide(playerid, HandyAnrufen[playerid][1]);
	         PlayerTextDrawHide(playerid, HandyAnrufen[playerid][2]);
	         PlayerTextDrawHide(playerid, HandyAuflegen[playerid][0]);
	         PlayerTextDrawHide(playerid, HandyAuflegen[playerid][1]);
	         PlayerTextDrawHide(playerid, HandyAuflegen[playerid][2]);
	         PlayerTextDrawHide(playerid, HandyHome[playerid][0]);
	         PlayerTextDrawHide(playerid, HandyHome[playerid][1]);
	         PlayerTextDrawHide(playerid, HandyHome[playerid][2]);
	         PlayerTextDrawHide(playerid, HandyZeit[playerid]);
	         PlayerTextDrawHide(playerid, HandyOrt[playerid]);
	         PlayerTextDrawHide(playerid, HandyTasten[playerid][0]);
	         PlayerTextDrawHide(playerid, HandyTasten[playerid][1]);
	         PlayerTextDrawHide(playerid, HandyTasten[playerid][2]);
	         PlayerTextDrawHide(playerid, HandyTasten[playerid][3]);
	         PlayerTextDrawHide(playerid, HandyTasten[playerid][4]);
	         PlayerTextDrawHide(playerid, HandyTasten[playerid][5]);
	         PlayerTextDrawHide(playerid, HandyTasten[playerid][6]);
	         PlayerTextDrawHide(playerid, HandyTasten[playerid][7]);
	         PlayerTextDrawHide(playerid, HandyTasten[playerid][8]);
	         PlayerTextDrawHide(playerid, HandyTasten[playerid][9]);
	         PlayerTextDrawHide(playerid, HandyTasten[playerid][10]);
	         PlayerTextDrawHide(playerid, HandyTasten[playerid][11]);
	         PlayerTextDrawHide(playerid, HandyTasten[playerid][12]);
	         PlayerTextDrawHide(playerid, HandyTasten[playerid][13]);
	         PlayerTextDrawHide(playerid, HandyTasten[playerid][14]);
	         PlayerTextDrawHide(playerid, HandyTasten[playerid][15]);
	         PlayerTextDrawHide(playerid, HandyTasten[playerid][16]);
	         PlayerTextDrawHide(playerid, HandyTasten[playerid][17]);
	         PlayerTextDrawHide(playerid, HandyTasten[playerid][18]);
	         PlayerTextDrawHide(playerid, HandyTasten[playerid][19]);
	         PlayerTextDrawHide(playerid, HandyTasten[playerid][20]);
	         PlayerTextDrawHide(playerid, HandyTasten[playerid][21]);
	         PlayerTextDrawHide(playerid, HandyTasten[playerid][22]);
	         PlayerTextDrawHide(playerid, HandyTasten[playerid][23]);
	         PlayerTextDrawHide(playerid, HandyTasten[playerid][24]);
	         PlayerTextDrawHide(playerid, HandyTasten[playerid][25]);
	         PlayerTextDrawHide(playerid, HandyTasten[playerid][26]);
	         PlayerTextDrawHide(playerid, HandyTasten[playerid][27]);
	         PlayerTextDrawHide(playerid, HandyTasten[playerid][28]);
	         PlayerTextDrawHide(playerid, HandyTasten[playerid][29]);
	         PlayerTextDrawHide(playerid, HandyTelefonbuch[playerid][0]);
	         PlayerTextDrawHide(playerid, HandyTelefonbuch[playerid][1]);
	         PlayerTextDrawHide(playerid, HandyTelefonbuch[playerid][2]);
	         PlayerTextDrawHide(playerid, HandyTelefonbuch[playerid][3]);
	         PlayerTextDrawHide(playerid, HandyTelefonbuch[playerid][4]);
	         PlayerTextDrawHide(playerid, HandyTelefonbuch[playerid][5]);
	         PlayerTextDrawHide(playerid, HandyCalender[playerid][0]);
	         PlayerTextDrawHide(playerid, HandyCalender[playerid][1]);
	         PlayerTextDrawHide(playerid, HandyCalender[playerid][2]);
	         PlayerTextDrawHide(playerid, HandyCalender[playerid][3]);
	         PlayerTextDrawHide(playerid, HandyCalender[playerid][4]);
	         PlayerTextDrawHide(playerid, HandyMusik[playerid][0]);
	         PlayerTextDrawHide(playerid, HandyMusik[playerid][1]);
	         PlayerTextDrawHide(playerid, HandyMusik[playerid][2]);
	         PlayerTextDrawHide(playerid, HandyMusik[playerid][3]);
	         PlayerTextDrawHide(playerid, HandyMusik[playerid][4]);
	         PlayerTextDrawHide(playerid, HandyMusik[playerid][5]);
	         PlayerTextDrawHide(playerid, HandyMusik[playerid][6]);
	         PlayerTextDrawHide(playerid, HandyEinstellungen[playerid][0]);
	         PlayerTextDrawHide(playerid, HandyEinstellungen[playerid][1]);
	         PlayerTextDrawHide(playerid, HandyEinstellungen[playerid][2]);
	         PlayerTextDrawHide(playerid, HandyZruck[playerid]);
	         PlayerTextDrawHide(playerid, HandyTelefonbuchZruck[playerid]);
	         PlayerTextDrawHide(playerid, HandyCalender_Monday[playerid]);
	         PlayerTextDrawHide(playerid, HandyCalender_Tuesday[playerid]);
	         PlayerTextDrawHide(playerid, HandyCalender_Wednesday[playerid]);
	         PlayerTextDrawHide(playerid, HandyCalender_Thursday[playerid]);
	         PlayerTextDrawHide(playerid, HandyCalender_Friday[playerid]);
     	     PlayerTextDrawHide(playerid, HandyCalender_Saturday[playerid]);
     	     PlayerTextDrawHide(playerid, HandyCalender_Sunday[playerid]);
     	     PlayerTextDrawHide(playerid, HandyCalender_Monday_[playerid]);
     	     PlayerTextDrawHide(playerid, HandyCalender_Tuesday_[playerid]);
     	     PlayerTextDrawHide(playerid, HandyCalender_Wednesday_[playerid]);
     	     PlayerTextDrawHide(playerid, HandyCalender_Thursday_[playerid]);
     	     PlayerTextDrawHide(playerid, HandyCalender_Friday_[playerid]);
     	     PlayerTextDrawHide(playerid, HandyCalender_Saturday_[playerid]);
     	     PlayerTextDrawHide(playerid, HandyCalender_Sunday_[playerid]);
	         PlayerTextDrawHide(playerid, Handy_Telefonbuch_AlleK[playerid][0]);
	         PlayerTextDrawHide(playerid, Handy_Telefonbuch_AlleK[playerid][1]);
	         PlayerTextDrawHide(playerid, Handy_Telefonbuch_AlleK[playerid][2]);
	         PlayerTextDrawHide(playerid, Handy_Telefonbuch_AlleK[playerid][3]);
	         PlayerTextDrawHide(playerid, Handy_Telefonbuch_AlleK[playerid][4]);
	         PlayerTextDrawHide(playerid, Handy_Telefonbuch_Freunde[playerid][0]);
	         PlayerTextDrawHide(playerid, Handy_Telefonbuch_Freunde[playerid][1]);
	         PlayerTextDrawHide(playerid, Handy_Telefonbuch_Freunde[playerid][2]);
	         PlayerTextDrawHide(playerid, Handy_Telefonbuch_Freunde[playerid][3]);
	         PlayerTextDrawHide(playerid, Handy_Telefonbuch_Freunde[playerid][4]);
	         PlayerTextDrawHide(playerid, Handy_Telefonbuch_Freunde[playerid][5]);
	         PlayerTextDrawHide(playerid, Handy_Telefonbuch_Freunde[playerid][6]);
	   }
	   if(HandyShowing[playerid] == 2)
	   {
	         if(GetPVarInt(HandyCaller[playerid], "HandyAnrufState") == 2 && GetPVarInt(HandyCalling[playerid], "HandyAnrufState") == 2)
	         {
                 PlayerTextDrawSetSelectable(HandyCaller[playerid], HandyAuflegen[playerid][0], 0);
                 PlayerTextDrawShow(HandyCaller[playerid], HandyAuflegen[playerid][0]);
                 PlayerTextDrawSetSelectable(HandyCalling[playerid], HandyAuflegen[playerid][0], 0);
                 PlayerTextDrawShow(HandyCalling[playerid], HandyAuflegen[playerid][0]);
                 return SetTimerEx("EndCallBecauseError", 100, false, "%i, %i", playerid, 5);
	         }
	         PlayerTextDrawHide(playerid,HandyAngerufen[playerid][0]);
	         PlayerTextDrawHide(playerid,HandyAngerufen[playerid][1]);
	         PlayerTextDrawHide(playerid,HandyAngerufen[playerid][2]);
	         PlayerTextDrawHide(playerid,HandyAngerufen[playerid][3]);
	         DeletePVar(playerid, "Handypause");
	         HandyShowing[playerid] = 1;

	         PlayerTextDrawShow(playerid,Handy[playerid]);
	         PlayerTextDrawShow(playerid,HandyTasten[playerid][10]);
	         PlayerTextDrawShow(playerid,HandyTasten[playerid][11]);
	         PlayerTextDrawShow(playerid,HandyTasten[playerid][12]);
	         PlayerTextDrawShow(playerid,HandyTasten[playerid][13]);
	         PlayerTextDrawShow(playerid,HandyTasten[playerid][14]);
	         PlayerTextDrawShow(playerid,HandyTasten[playerid][15]);
	         PlayerTextDrawShow(playerid,HandyTasten[playerid][16]);
	         PlayerTextDrawShow(playerid,HandyTasten[playerid][17]);
	         PlayerTextDrawShow(playerid,HandyTasten[playerid][18]);
	         PlayerTextDrawShow(playerid,HandyTasten[playerid][19]);

	         PlayerTextDrawShow(playerid,HandyPlatzhalter[playerid]);
	         PlayerTextDrawShow(playerid,HandyBildschirm[playerid]);
	         PlayerTextDrawShow(playerid,HandyAnrufen[playerid][0]);
	         PlayerTextDrawShow(playerid,HandyAnrufen[playerid][1]);
	         PlayerTextDrawShow(playerid,HandyAnrufen[playerid][2]);
	         PlayerTextDrawShow(playerid,HandyAuflegen[playerid][0]);
	         PlayerTextDrawShow(playerid,HandyAuflegen[playerid][1]);
	         PlayerTextDrawShow(playerid,HandyAuflegen[playerid][2]);
	         PlayerTextDrawShow(playerid,HandyHome[playerid][0]);
	         PlayerTextDrawShow(playerid,HandyHome[playerid][1]);
	         PlayerTextDrawShow(playerid,HandyHome[playerid][2]);
	         PlayerTextDrawShow(playerid,HandyTasten[playerid][0]);
	         PlayerTextDrawShow(playerid,HandyTasten[playerid][1]);
	         PlayerTextDrawShow(playerid,HandyTasten[playerid][2]);
	         PlayerTextDrawShow(playerid,HandyTasten[playerid][3]);
	         PlayerTextDrawShow(playerid,HandyTasten[playerid][4]);
	         PlayerTextDrawShow(playerid,HandyTasten[playerid][5]);
	         PlayerTextDrawShow(playerid,HandyTasten[playerid][6]);
	         PlayerTextDrawShow(playerid,HandyTasten[playerid][7]);
	         PlayerTextDrawShow(playerid,HandyTasten[playerid][8]);
	         PlayerTextDrawShow(playerid,HandyTasten[playerid][9]);
	         PlayerTextDrawShow(playerid,HandyTasten[playerid][20]);
	         PlayerTextDrawShow(playerid,HandyTasten[playerid][21]);
	         PlayerTextDrawShow(playerid,HandyTasten[playerid][22]);
	         PlayerTextDrawShow(playerid,HandyTasten[playerid][23]);
	         PlayerTextDrawShow(playerid,HandyTasten[playerid][24]);
	         PlayerTextDrawShow(playerid,HandyTasten[playerid][25]);
	         PlayerTextDrawShow(playerid,HandyTasten[playerid][26]);
	         PlayerTextDrawShow(playerid,HandyTasten[playerid][27]);
	         PlayerTextDrawShow(playerid,HandyTasten[playerid][28]);
	         PlayerTextDrawShow(playerid,HandyTasten[playerid][29]);
	         PlayerTextDrawShow(playerid,HandyZeit[playerid]);
	         PlayerTextDrawShow(playerid,HandyOrt[playerid]);
	         PlayerTextDrawShow(playerid,HandyTelefonbuch[playerid][0]);
	         PlayerTextDrawShow(playerid,HandyTelefonbuch[playerid][1]);
	         PlayerTextDrawShow(playerid,HandyTelefonbuch[playerid][2]);
	         PlayerTextDrawShow(playerid,HandyTelefonbuch[playerid][3]);
	         PlayerTextDrawShow(playerid,HandyTelefonbuch[playerid][4]);
	         PlayerTextDrawShow(playerid,HandyTelefonbuch[playerid][5]);
	         PlayerTextDrawShow(playerid,HandyCalender[playerid][0]);
	         PlayerTextDrawShow(playerid,HandyCalender[playerid][1]);
	         PlayerTextDrawShow(playerid,HandyCalender[playerid][2]);
	         PlayerTextDrawShow(playerid,HandyCalender[playerid][3]);
	         PlayerTextDrawShow(playerid,HandyCalender[playerid][4]);
	         PlayerTextDrawShow(playerid,HandyMusik[playerid][0]);
	         PlayerTextDrawShow(playerid,HandyMusik[playerid][1]);
	         PlayerTextDrawShow(playerid,HandyMusik[playerid][2]);
	         PlayerTextDrawShow(playerid,HandyMusik[playerid][3]);
	         PlayerTextDrawShow(playerid,HandyMusik[playerid][4]);
	         PlayerTextDrawShow(playerid,HandyMusik[playerid][5]);
	         PlayerTextDrawShow(playerid,HandyMusik[playerid][6]);
	         PlayerTextDrawShow(playerid,HandyEinstellungen[playerid][0]);
	         PlayerTextDrawShow(playerid,HandyEinstellungen[playerid][1]);
	         PlayerTextDrawShow(playerid,HandyEinstellungen[playerid][2]);
	         HandyZeitUpdate(playerid);
	         PlayerTextDrawSetString(playerid, HandyOrt[playerid], GetPlayerLocation(playerid));
	         PlayerTextDrawSetString(playerid, HandyCalender[playerid][4], WochentagKurz());
	         if(GetPVarInt(HandyCaller[playerid], "HandyAnrufState") == 1)
	         {
                 SetTimerEx("EndCallBecauseError", 1000, false, "%i, %i", playerid, 4);
                 PlayerTextDrawSetSelectable(HandyCalling[playerid], HandyAuflegen[playerid][0], 0);
                 PlayerTextDrawShow(HandyCalling[playerid], HandyAuflegen[playerid][0]);
	         }
	         /*PlayerTextDrawHide(HandyCaller[playerid], HandyAngerufen[playerid][0]);
	         PlayerTextDrawHide(HandyCaller[playerid], HandyAngerufen[playerid][1]);
	         PlayerTextDrawHide(HandyCaller[playerid], HandyAngerufen[playerid][2]);
	         PlayerTextDrawHide(HandyCaller[playerid], HandyAngerufen[playerid][3]);
	         PlayerTextDrawShow(HandyCaller[playerid], HandyCallContact[playerid]);
	         PlayerTextDrawShow(HandyCaller[playerid], HandyCallContact_[playerid]);
	         PlayerTextDrawShow(HandyCaller[playerid], HandyAddFriendContact[playerid]);
	         PlayerTextDrawShow(HandyCaller[playerid], HandyAddFriendContact_[playerid]);
	         PlayerTextDrawShow(HandyCaller[playerid], HandyKontaktProfilFarbe[playerid]);
	         PlayerTextDrawShow(HandyCaller[playerid], HandyKontaktProfilBild[playerid]);
	         PlayerTextDrawShow(HandyCaller[playerid], HandyInfo_Nummer[playerid]);
	         PlayerTextDrawShow(HandyCaller[playerid], HandyInfo_Status[playerid]);*/
	   }
	 }
     if(playertextid == HandyAnrufen[playerid][0])
     {
	   /*if(HandyShowing[playerid] == 2)*/if(GetPVarInt(HandyCaller[playerid], "HandyAnrufState") == 1 && GetPVarInt(HandyCalling[playerid], "HandyAnrufState") == 1)//hier
	   {
			 new string[50];
     	     format(string, sizeof string, "connected to:~n~%s", GetSname(HandyCaller[playerid]));
     	     PlayerTextDrawSetString(HandyCalling[playerid], HandyAngerufen[playerid][3], string);
     	     format(string, sizeof string, "connected to:~n~%s", GetSname(HandyCalling[playerid]));
     	     PlayerTextDrawSetString(HandyCaller[playerid], HandyAngerufen[playerid][3], string);
     	     SetPVarInt(HandyCalling[playerid], "HandyAnrufState", 2);
     	     SetPVarInt(HandyCaller[playerid], "HandyAnrufState", 2);

     	     format(string, sizeof string, "Angerufene playerid: %i", HandyCalling[HandyCaller[playerid]]);
     	     SendClientMessage(HandyCaller[playerid], Hellrot, string);
     	     format(string, sizeof string, "Anrufer: %i", HandyCaller[HandyCaller[playerid]]);
     	     SendClientMessage(HandyCaller[playerid], Hellgrün, string);


     	     format(string, sizeof string, "Angerufene playerid: %i", HandyCalling[HandyCalling[playerid]]);
     	     SendClientMessage(HandyCalling[playerid], Hellblau, string);
     	     format(string, sizeof string, "Anrufer: %i", HandyCaller[HandyCalling[playerid]]);
     	     SendClientMessage(HandyCalling[playerid], Weis, string);


     	     KillTimer(WaitForCallingTimer);
	   }
	   if(HandyShowing[playerid] == 1 && GetPVarInt(playerid, "HandyAnrufState") == 0)
	   {
	         PlayerTextDrawShow(playerid, HandyAnrufMenu[playerid][0]);
	         PlayerTextDrawShow(playerid, HandyAnrufMenu[playerid][1]);
     	     PlayerTextDrawShow(playerid, HandyAnrufMenu[playerid][2]);
     	     PlayerTextDrawShow(playerid, HandyAnrufMenu[playerid][3]);
     	     PlayerTextDrawShow(playerid, HandyAnrufMenu[playerid][4]);
     	     PlayerTextDrawShow(playerid, HandyAnrufMenu[playerid][5]);
     	     PlayerTextDrawShow(playerid, HandyAnrufMenu[playerid][6]);
     	     PlayerTextDrawHide(playerid, HandyTelefonbuch[playerid][0]);
     	     PlayerTextDrawHide(playerid, HandyTelefonbuch[playerid][1]);
     	     PlayerTextDrawHide(playerid, HandyTelefonbuch[playerid][2]);
     	     PlayerTextDrawHide(playerid, HandyTelefonbuch[playerid][3]);
     	     PlayerTextDrawHide(playerid, HandyTelefonbuch[playerid][4]);
     	     PlayerTextDrawHide(playerid, HandyTelefonbuch[playerid][5]);
     	     PlayerTextDrawHide(playerid, HandyCalender[playerid][0]);
     	     PlayerTextDrawHide(playerid, HandyCalender[playerid][1]);
     	     PlayerTextDrawHide(playerid, HandyCalender[playerid][2]);
     	     PlayerTextDrawHide(playerid, HandyCalender[playerid][3]);
     	     PlayerTextDrawHide(playerid, HandyCalender[playerid][4]);
     	     PlayerTextDrawHide(playerid, HandyMusik[playerid][0]);
     	     PlayerTextDrawHide(playerid, HandyMusik[playerid][1]);
	         PlayerTextDrawHide(playerid, HandyMusik[playerid][2]);
	         PlayerTextDrawHide(playerid, HandyMusik[playerid][3]);
     	     PlayerTextDrawHide(playerid, HandyMusik[playerid][4]);
     	     PlayerTextDrawHide(playerid, HandyMusik[playerid][5]);
     	     PlayerTextDrawHide(playerid, HandyMusik[playerid][6]);
     	     PlayerTextDrawHide(playerid, HandyEinstellungen[playerid][0]);
     	     PlayerTextDrawHide(playerid, HandyEinstellungen[playerid][1]);
     	     PlayerTextDrawHide(playerid, HandyEinstellungen[playerid][2]);
     	     PlayerTextDrawHide(playerid, HandyAuflegen[playerid][0]);
     	     PlayerTextDrawShow(playerid, HandyAnrufenZruck[playerid]);
	   }
	 }
     if(playertextid == HandyAnrufenZruck[playerid])
     {
	    PlayerTextDrawHide(playerid, HandyAnrufMenu[playerid][0]);
	    PlayerTextDrawHide(playerid, HandyAnrufMenu[playerid][1]);
	    PlayerTextDrawHide(playerid, HandyAnrufMenu[playerid][2]);
	    PlayerTextDrawHide(playerid, HandyAnrufMenu[playerid][3]);
	    PlayerTextDrawHide(playerid, HandyAnrufMenu[playerid][4]);
	    PlayerTextDrawHide(playerid, HandyAnrufMenu[playerid][5]);
	    PlayerTextDrawHide(playerid, HandyAnrufMenu[playerid][6]);
	    PlayerTextDrawHide(playerid, HandyAnrufenZruck[playerid]);
	    PlayerTextDrawShow(playerid, HandyTelefonbuch[playerid][0]);
	    PlayerTextDrawShow(playerid, HandyTelefonbuch[playerid][1]);
	    PlayerTextDrawShow(playerid, HandyTelefonbuch[playerid][2]);
	    PlayerTextDrawShow(playerid, HandyTelefonbuch[playerid][3]);
	    PlayerTextDrawShow(playerid, HandyTelefonbuch[playerid][4]);
	    PlayerTextDrawShow(playerid, HandyTelefonbuch[playerid][5]);
	    PlayerTextDrawShow(playerid, HandyCalender[playerid][0]);
	    PlayerTextDrawShow(playerid, HandyCalender[playerid][1]);
	    PlayerTextDrawShow(playerid, HandyCalender[playerid][2]);
	    PlayerTextDrawShow(playerid, HandyCalender[playerid][3]);
	    PlayerTextDrawShow(playerid, HandyCalender[playerid][4]);
	    PlayerTextDrawShow(playerid, HandyMusik[playerid][0]);
	    PlayerTextDrawShow(playerid, HandyMusik[playerid][1]);
	    PlayerTextDrawShow(playerid, HandyMusik[playerid][2]);
	    PlayerTextDrawShow(playerid, HandyMusik[playerid][3]);
	    PlayerTextDrawShow(playerid, HandyMusik[playerid][4]);
	    PlayerTextDrawShow(playerid, HandyMusik[playerid][5]);
	    PlayerTextDrawShow(playerid, HandyMusik[playerid][6]);
	    PlayerTextDrawShow(playerid, HandyEinstellungen[playerid][0]);
	    PlayerTextDrawShow(playerid, HandyEinstellungen[playerid][1]);
	    PlayerTextDrawShow(playerid, HandyEinstellungen[playerid][2]);
	    PlayerTextDrawShow(playerid, HandyAuflegen[playerid][0]);
	 }
     if(playertextid == HandyHome[playerid][0])
     {
	    CancelSelectTextDraw(playerid);
	    SetPVarInt(playerid, "Handypause", 1);
	    SendInfoText(playerid, "Press ~k~~CONVERSATION_YES~ to use your phone again");
	 }
     if(playertextid == HandyZruck[playerid])
     {
	    PlayerTextDrawShow(playerid, HandyZeit[playerid]);
	    PlayerTextDrawShow(playerid, HandyAuflegen[playerid][0]);
	    PlayerTextDrawShow(playerid, HandyAuflegen[playerid][1]);
	    PlayerTextDrawShow(playerid, HandyAuflegen[playerid][2]);
	    PlayerTextDrawShow(playerid, HandyOrt[playerid]);
	    PlayerTextDrawSetString(playerid, HandyTelefonbuch[playerid][1], "Phonebook");
	    PlayerTextDrawSetString(playerid, HandyCalender[playerid][1], "Calender");
	    PlayerTextDrawSetString(playerid, HandyMusik[playerid][1], "  Music");
	    PlayerTextDrawSetString(playerid, HandyEinstellungen[playerid][1], "Settings");
	    PlayerTextDrawShow(playerid, HandyTelefonbuch[playerid][0]);
	    PlayerTextDrawShow(playerid, HandyTelefonbuch[playerid][1]);
	    PlayerTextDrawShow(playerid, HandyTelefonbuch[playerid][2]);
	    PlayerTextDrawShow(playerid, HandyTelefonbuch[playerid][3]);
	    PlayerTextDrawShow(playerid, HandyTelefonbuch[playerid][4]);
	    PlayerTextDrawShow(playerid, HandyTelefonbuch[playerid][5]);
	    PlayerTextDrawShow(playerid, HandyCalender[playerid][0]);
	    PlayerTextDrawShow(playerid, HandyCalender[playerid][1]);
	    PlayerTextDrawShow(playerid, HandyCalender[playerid][2]);
	    PlayerTextDrawShow(playerid, HandyCalender[playerid][3]);
	    PlayerTextDrawShow(playerid, HandyCalender[playerid][4]);
	    PlayerTextDrawShow(playerid, HandyMusik[playerid][0]);
	    PlayerTextDrawShow(playerid, HandyMusik[playerid][1]);
	    PlayerTextDrawShow(playerid, HandyMusik[playerid][2]);
	    PlayerTextDrawShow(playerid, HandyMusik[playerid][3]);
	    PlayerTextDrawShow(playerid, HandyMusik[playerid][4]);
	    PlayerTextDrawShow(playerid, HandyMusik[playerid][5]);
	    PlayerTextDrawShow(playerid, HandyMusik[playerid][6]);
	    PlayerTextDrawShow(playerid, HandyEinstellungen[playerid][0]);
	    PlayerTextDrawShow(playerid, HandyEinstellungen[playerid][1]);
	    PlayerTextDrawShow(playerid, HandyEinstellungen[playerid][2]);
	    PlayerTextDrawShow(playerid, HandyAuflegen[playerid][0]);
	    PlayerTextDrawHide(playerid, HandyZruck[playerid]);
	    PlayerTextDrawHide(playerid, HandyCalender_Monday[playerid]);
	    PlayerTextDrawHide(playerid, HandyCalender_Tuesday[playerid]);
	    PlayerTextDrawHide(playerid, HandyCalender_Wednesday[playerid]);
	    PlayerTextDrawHide(playerid, HandyCalender_Thursday[playerid]);
	    PlayerTextDrawHide(playerid, HandyCalender_Friday[playerid]);
	    PlayerTextDrawHide(playerid, HandyCalender_Saturday[playerid]);
	    PlayerTextDrawHide(playerid, HandyCalender_Sunday[playerid]);
	    PlayerTextDrawHide(playerid, HandyCalender_Monday_[playerid]);
	    PlayerTextDrawHide(playerid, HandyCalender_Tuesday_[playerid]);
	    PlayerTextDrawHide(playerid, HandyCalender_Wednesday_[playerid]);
	    PlayerTextDrawHide(playerid, HandyCalender_Thursday_[playerid]);
	    PlayerTextDrawHide(playerid, HandyCalender_Friday_[playerid]);
	    PlayerTextDrawHide(playerid, HandyCalender_Saturday_[playerid]);
	    PlayerTextDrawHide(playerid, HandyCalender_Sunday_[playerid]);
	    PlayerTextDrawHide(playerid, Handy_Telefonbuch_AlleK[playerid][0]);
	    PlayerTextDrawHide(playerid, Handy_Telefonbuch_AlleK[playerid][1]);
	    PlayerTextDrawHide(playerid, Handy_Telefonbuch_AlleK[playerid][2]);
	    PlayerTextDrawHide(playerid, Handy_Telefonbuch_AlleK[playerid][3]);
	    PlayerTextDrawHide(playerid, Handy_Telefonbuch_AlleK[playerid][4]);
	    PlayerTextDrawHide(playerid, Handy_Telefonbuch_Freunde[playerid][0]);
	    PlayerTextDrawHide(playerid, Handy_Telefonbuch_Freunde[playerid][1]);
	    PlayerTextDrawHide(playerid, Handy_Telefonbuch_Freunde[playerid][2]);
	    PlayerTextDrawHide(playerid, Handy_Telefonbuch_Freunde[playerid][3]);
	    PlayerTextDrawHide(playerid, Handy_Telefonbuch_Freunde[playerid][4]);
	    PlayerTextDrawHide(playerid, Handy_Telefonbuch_Freunde[playerid][5]);
	    PlayerTextDrawHide(playerid, Handy_Telefonbuch_Freunde[playerid][6]);
	    PlayerTextDrawHide(playerid, Handy_Telefonbuch_publicService[playerid][0]);
	    PlayerTextDrawHide(playerid, Handy_Telefonbuch_publicService[playerid][1]);
	    PlayerTextDrawHide(playerid, Handy_Telefonbuch_Suchen[playerid][0]);
	    PlayerTextDrawHide(playerid, Handy_Telefonbuch_Suchen[playerid][1]);
	    PlayerTextDrawHide(playerid, Handy_Telefonbuch_Suchen[playerid][2]);
	    PlayerTextDrawHide(playerid, Handy_Telefonbuch_Suchen[playerid][3]);
	    PlayerTextDrawHide(playerid, HandyTonEinstellungen[playerid][0]);
	    PlayerTextDrawHide(playerid, HandyTonEinstellungen[playerid][1]);
	    PlayerTextDrawHide(playerid, HandyTonEinstellungen[playerid][2]);
	    PlayerTextDrawHide(playerid, HandyTonEinstellungen[playerid][3]);
	    PlayerTextDrawHide(playerid, HandyMusikApp[playerid][0]);
	    PlayerTextDrawHide(playerid, HandyMusikApp[playerid][1]);
	    PlayerTextDrawHide(playerid, HandyMusikApp[playerid][2]);
	    PlayerTextDrawHide(playerid, HandyMusikApp[playerid][3]);
	    PlayerTextDrawHide(playerid, HandyMusikApp[playerid][4]);
	    PlayerTextDrawHide(playerid, HandyMusikApp[playerid][5]);
	    PlayerTextDrawHide(playerid, HandyMusikApp[playerid][6]);
	    PlayerTextDrawHide(playerid, HandyMusikApp[playerid][7]);
	    PlayerTextDrawHide(playerid, HandyMusikApp[playerid][8]);
	    PlayerTextDrawHide(playerid, HandyMusikApp[playerid][9]);
	    PlayerTextDrawHide(playerid, HandyMusikApp[playerid][10]);
	    PlayerTextDrawHide(playerid, HandyMusikApp[playerid][11]);
	    PlayerTextDrawHide(playerid, HandyMusikApp[playerid][12]);
	    PlayerTextDrawHide(playerid, HandyMusikApp[playerid][13]);
	    PlayerTextDrawHide(playerid, HandyMusikApp[playerid][14]);
	    PlayerTextDrawHide(playerid, HandyMusikApp[playerid][15]);
	    /*PlayerTextDrawHide(playerid, HandyNachrichtenton[playerid]);
	    PlayerTextDrawHide(playerid, HandyNachrichtenton1[playerid]);
	    PlayerTextDrawHide(playerid, HandyNachrichtenton2[playerid]);
	    PlayerTextDrawHide(playerid, HandyNachrichtenton3[playerid]);
	    PlayerTextDrawHide(playerid, HandyNachrichtenton1_[playerid]);
	    PlayerTextDrawHide(playerid, HandyNachrichtenton2_[playerid]);
	    PlayerTextDrawHide(playerid, HandyNachrichtenton3_[playerid]);
	    PlayerTextDrawHide(playerid, HandyKlingelton[playerid]);
	    PlayerTextDrawHide(playerid, HandyKlingelton1[playerid]);
	    PlayerTextDrawHide(playerid, HandyKlingelton2[playerid]);
	    PlayerTextDrawHide(playerid, HandyKlingelton3[playerid]);
	    PlayerTextDrawHide(playerid, HandyKlingelton1_[playerid]);
	    PlayerTextDrawHide(playerid, HandyKlingelton2_[playerid]);
	    PlayerTextDrawHide(playerid, HandyKlingelton3_[playerid]);
	    PlayerTextDrawHide(playerid, HandyMute[playerid][0]);
	    PlayerTextDrawHide(playerid, HandyMute[playerid][1]);
	    PlayerTextDrawHide(playerid, HandyMute[playerid][2]);
	    PlayerTextDrawHide(playerid, HandyMute[playerid][3]);
	    PlayerTextDrawHide(playerid, HandyMute[playerid][4]);*/
	    HandyZeitUpdate(playerid);
	    PlayerTextDrawSetString(playerid, HandyOrt[playerid], GetPlayerLocation(playerid));
	 }
     if(playertextid == HandyTelefonbuch[playerid][0])
     {
	    PlayerTextDrawSetString(playerid,HandyTelefonbuch[playerid][1], "All Players");
	    PlayerTextDrawSetString(playerid,HandyCalender[playerid][1], " Friends");
	    PlayerTextDrawSetString(playerid,HandyMusik[playerid][1], "Services");
	    PlayerTextDrawSetString(playerid,HandyEinstellungen[playerid][1], " Search");
	    PlayerTextDrawHide(playerid, HandyTelefonbuch[playerid][0]);
	    //PlayerTextDrawHide(playerid,HandyTelefonbuch[playerid][1]);
	    PlayerTextDrawHide(playerid, HandyTelefonbuch[playerid][2]);
	    PlayerTextDrawHide(playerid, HandyTelefonbuch[playerid][3]);
	    PlayerTextDrawHide(playerid, HandyTelefonbuch[playerid][4]);
	    PlayerTextDrawHide(playerid, HandyTelefonbuch[playerid][5]);
	    PlayerTextDrawHide(playerid, HandyCalender[playerid][0]);
	    //PlayerTextDrawHide(playerid,HandyCalender[playerid][1]);
	    PlayerTextDrawHide(playerid, HandyCalender[playerid][2]);
	    PlayerTextDrawHide(playerid, HandyCalender[playerid][3]);
	    PlayerTextDrawHide(playerid, HandyCalender[playerid][4]);
	    PlayerTextDrawHide(playerid, HandyMusik[playerid][0]);
	    //PlayerTextDrawHide(playerid, HandyMusik[playerid][1]);
	    PlayerTextDrawHide(playerid, HandyMusik[playerid][2]);
	    PlayerTextDrawHide(playerid, HandyMusik[playerid][3]);
	    PlayerTextDrawHide(playerid, HandyMusik[playerid][4]);
	    PlayerTextDrawHide(playerid, HandyMusik[playerid][5]);
	    PlayerTextDrawHide(playerid, HandyMusik[playerid][6]);
	    PlayerTextDrawHide(playerid, HandyEinstellungen[playerid][0]);
	    //PlayerTextDrawHide(playerid, HandyEinstellungen[playerid][1]);
	    PlayerTextDrawHide(playerid, HandyEinstellungen[playerid][2]);
	    PlayerTextDrawHide(playerid, HandyOrt[playerid]);
	    PlayerTextDrawHide(playerid, HandyZeit[playerid]);
	    PlayerTextDrawHide(playerid, HandyAuflegen[playerid][0]);
	    PlayerTextDrawShow(playerid, HandyZruck[playerid]);
	    PlayerTextDrawShow(playerid, Handy_Telefonbuch_AlleK[playerid][0]);
	    PlayerTextDrawShow(playerid, Handy_Telefonbuch_AlleK[playerid][1]);
	    PlayerTextDrawShow(playerid, Handy_Telefonbuch_AlleK[playerid][2]);
	    PlayerTextDrawShow(playerid, Handy_Telefonbuch_AlleK[playerid][3]);
	    PlayerTextDrawShow(playerid, Handy_Telefonbuch_AlleK[playerid][4]);
	    PlayerTextDrawShow(playerid, Handy_Telefonbuch_Freunde[playerid][0]);
	    PlayerTextDrawShow(playerid, Handy_Telefonbuch_Freunde[playerid][1]);
	    PlayerTextDrawShow(playerid, Handy_Telefonbuch_Freunde[playerid][2]);
	    PlayerTextDrawShow(playerid, Handy_Telefonbuch_Freunde[playerid][3]);
	    PlayerTextDrawShow(playerid, Handy_Telefonbuch_Freunde[playerid][4]);
	    PlayerTextDrawShow(playerid, Handy_Telefonbuch_Freunde[playerid][5]);
	    PlayerTextDrawShow(playerid, Handy_Telefonbuch_Freunde[playerid][6]);
	    PlayerTextDrawShow(playerid, Handy_Telefonbuch_publicService[playerid][0]);
	    PlayerTextDrawShow(playerid, Handy_Telefonbuch_publicService[playerid][1]);
	    PlayerTextDrawShow(playerid, Handy_Telefonbuch_Suchen[playerid][0]);
	    PlayerTextDrawShow(playerid, Handy_Telefonbuch_Suchen[playerid][1]);
	    PlayerTextDrawShow(playerid, Handy_Telefonbuch_Suchen[playerid][2]);
	    PlayerTextDrawShow(playerid, Handy_Telefonbuch_Suchen[playerid][3]);
	 }
     if(playertextid == HandyCalender[playerid][0])
     {
	    PlayerTextDrawHide(playerid,HandyTelefonbuch[playerid][0]);
	    PlayerTextDrawHide(playerid,HandyTelefonbuch[playerid][1]);
	    PlayerTextDrawHide(playerid,HandyTelefonbuch[playerid][2]);
	    PlayerTextDrawHide(playerid,HandyTelefonbuch[playerid][3]);
	    PlayerTextDrawHide(playerid,HandyTelefonbuch[playerid][4]);
	    PlayerTextDrawHide(playerid,HandyTelefonbuch[playerid][5]);
	    PlayerTextDrawHide(playerid,HandyCalender[playerid][0]);
	    PlayerTextDrawHide(playerid,HandyCalender[playerid][1]);
	    PlayerTextDrawHide(playerid,HandyCalender[playerid][2]);
	    PlayerTextDrawHide(playerid,HandyCalender[playerid][3]);
	    PlayerTextDrawHide(playerid,HandyCalender[playerid][4]);
	    PlayerTextDrawHide(playerid,HandyMusik[playerid][0]);
	    PlayerTextDrawHide(playerid,HandyMusik[playerid][1]);
	    PlayerTextDrawHide(playerid,HandyMusik[playerid][2]);
	    PlayerTextDrawHide(playerid,HandyMusik[playerid][3]);
	    PlayerTextDrawHide(playerid,HandyMusik[playerid][4]);
	    PlayerTextDrawHide(playerid,HandyMusik[playerid][5]);
	    PlayerTextDrawHide(playerid,HandyMusik[playerid][6]);
	    PlayerTextDrawHide(playerid,HandyEinstellungen[playerid][0]);
	    PlayerTextDrawHide(playerid,HandyEinstellungen[playerid][1]);
	    PlayerTextDrawHide(playerid,HandyEinstellungen[playerid][2]);
	    PlayerTextDrawHide(playerid,HandyAuflegen[playerid][0]);
	    PlayerTextDrawShow(playerid, HandyZruck[playerid]);
	    PlayerTextDrawShow(playerid, HandyCalender_Monday[playerid]);
	    PlayerTextDrawShow(playerid, HandyCalender_Tuesday[playerid]);
	    PlayerTextDrawShow(playerid, HandyCalender_Wednesday[playerid]);
	    PlayerTextDrawShow(playerid, HandyCalender_Thursday[playerid]);
	    PlayerTextDrawShow(playerid, HandyCalender_Friday[playerid]);
	    PlayerTextDrawShow(playerid, HandyCalender_Saturday[playerid]);
	    PlayerTextDrawShow(playerid, HandyCalender_Sunday[playerid]);
	    PlayerTextDrawShow(playerid, HandyCalender_Monday_[playerid]);
	    PlayerTextDrawShow(playerid, HandyCalender_Tuesday_[playerid]);
	    PlayerTextDrawShow(playerid, HandyCalender_Wednesday_[playerid]);
	    PlayerTextDrawShow(playerid, HandyCalender_Thursday_[playerid]);
	    PlayerTextDrawShow(playerid, HandyCalender_Friday_[playerid]);
	    PlayerTextDrawShow(playerid, HandyCalender_Saturday_[playerid]);
	    PlayerTextDrawShow(playerid, HandyCalender_Sunday_[playerid]);
	    PlayerTextDrawSetString(playerid, HandyZeit[playerid], GetDatum());
	    PlayerTextDrawSetString(playerid, HandyOrt[playerid], GetWochentag());
		format(Spieler, sizeof Spieler, "/Spieler/%s.txt", GetSname(playerid));
        if (strlen(dini_Get(Spieler, "KalenderMontag")))
        {
		    PlayerTextDrawSetString(playerid,HandyCalender_Monday_[playerid], "~g~~h~o ~l~Monday");
	    }
        if (strlen(dini_Get(Spieler, "KalenderDienstag")))
        {
		    PlayerTextDrawSetString(playerid,HandyCalender_Tuesday_[playerid], "~g~~h~o ~l~Tuesday");
	    }
        if (strlen(dini_Get(Spieler, "KalenderMittwoch")))
        {
		    PlayerTextDrawSetString(playerid,HandyCalender_Wednesday_[playerid], "~g~~h~o ~l~Wednesday");
	    }
        if (strlen(dini_Get(Spieler, "KalenderDonnerstag")))
        {
		    PlayerTextDrawSetString(playerid,HandyCalender_Thursday_[playerid], "~g~~h~o ~l~Thursday");
	    }
        if (strlen(dini_Get(Spieler, "KalenderFreitag")))
        {
		    PlayerTextDrawSetString(playerid,HandyCalender_Friday_[playerid], "~g~~h~o ~l~Friday");
	    }
        if (strlen(dini_Get(Spieler, "KalenderSamstag")))
        {
		    PlayerTextDrawSetString(playerid,HandyCalender_Saturday_[playerid], "~g~~h~o ~l~Saturday");
	    }
        if (strlen(dini_Get(Spieler, "KalenderSonntag")))
        {
		    PlayerTextDrawSetString(playerid,HandyCalender_Sunday_[playerid], "~g~~h~o ~l~Sunday");
	    }
	 }
     if(playertextid == HandyMusik[playerid][0])
     {
	    PlayerTextDrawHide(playerid,HandyTelefonbuch[playerid][0]);
	    PlayerTextDrawHide(playerid,HandyTelefonbuch[playerid][1]);
	    PlayerTextDrawHide(playerid,HandyTelefonbuch[playerid][2]);
	    PlayerTextDrawHide(playerid,HandyTelefonbuch[playerid][3]);
	    PlayerTextDrawHide(playerid,HandyTelefonbuch[playerid][4]);
	    PlayerTextDrawHide(playerid,HandyTelefonbuch[playerid][5]);
	    PlayerTextDrawHide(playerid,HandyCalender[playerid][0]);
	    PlayerTextDrawHide(playerid,HandyCalender[playerid][1]);
	    PlayerTextDrawHide(playerid,HandyCalender[playerid][2]);
	    PlayerTextDrawHide(playerid,HandyCalender[playerid][3]);
	    PlayerTextDrawHide(playerid,HandyCalender[playerid][4]);
	    PlayerTextDrawHide(playerid,HandyMusik[playerid][0]);
	    PlayerTextDrawHide(playerid,HandyMusik[playerid][1]);
	    PlayerTextDrawHide(playerid,HandyMusik[playerid][2]);
	    PlayerTextDrawHide(playerid,HandyMusik[playerid][3]);
	    PlayerTextDrawHide(playerid,HandyMusik[playerid][4]);
	    PlayerTextDrawHide(playerid,HandyMusik[playerid][5]);
	    PlayerTextDrawHide(playerid,HandyMusik[playerid][6]);
	    PlayerTextDrawHide(playerid,HandyEinstellungen[playerid][0]);
	    PlayerTextDrawHide(playerid,HandyEinstellungen[playerid][1]);
	    PlayerTextDrawHide(playerid,HandyEinstellungen[playerid][2]);
	    PlayerTextDrawHide(playerid,HandyOrt[playerid]);
	    PlayerTextDrawHide(playerid,HandyZeit[playerid]);
	    PlayerTextDrawHide(playerid,HandyAuflegen[playerid][0]);
	    PlayerTextDrawShow(playerid, HandyZruck[playerid]);
	    PlayerTextDrawShow(playerid, HandyMusikApp[playerid][0]);
	    PlayerTextDrawShow(playerid, HandyMusikApp[playerid][1]);
	    PlayerTextDrawShow(playerid, HandyMusikApp[playerid][2]);
	    PlayerTextDrawShow(playerid, HandyMusikApp[playerid][3]);
	    PlayerTextDrawShow(playerid, HandyMusikApp[playerid][4]);
	    PlayerTextDrawShow(playerid, HandyMusikApp[playerid][5]);
	    PlayerTextDrawShow(playerid, HandyMusikApp[playerid][6]);
	    PlayerTextDrawShow(playerid, HandyMusikApp[playerid][7]);
	    PlayerTextDrawShow(playerid, HandyMusikApp[playerid][8]);
	    PlayerTextDrawShow(playerid, HandyMusikApp[playerid][9]);
	    PlayerTextDrawShow(playerid, HandyMusikApp[playerid][10]);
	    PlayerTextDrawShow(playerid, HandyMusikApp[playerid][11]);
	    PlayerTextDrawShow(playerid, HandyMusikApp[playerid][12]);
	    PlayerTextDrawShow(playerid, HandyMusikApp[playerid][13]);
	    PlayerTextDrawShow(playerid, HandyMusikApp[playerid][14]);
	    PlayerTextDrawShow(playerid, HandyMusikApp[playerid][15]);
		format(Spieler, sizeof Spieler, "/Spieler/%s.txt", GetSname(playerid));
        if (!strcmp(dini_Get(Spieler, "HandyliedReplay"), "Aus"))
        {
		  PlayerTextDrawSetString(playerid,HandyMusikApp[playerid][15], " ");
	    }
        else
        {
		  PlayerTextDrawSetString(playerid,HandyMusikApp[playerid][15], "x");
	    }
        if (!strcmp(dini_Get(Spieler, "Handylied"), "1"))
        {
		  PlayerTextDrawSetString(playerid, HandyMusikApp[playerid][5], "Boulevard_of_broken_Dreams");
		  PlayerTextDrawSetString(playerid, HandyMusikApp[playerid][4], "BigSmoke_feat_Flying_Kitty");
	    }
        else if (!strcmp(dini_Get(Spieler, "Handylied"), "2"))
        {
		  PlayerTextDrawSetString(playerid, HandyMusikApp[playerid][5], "What_is_cheese");
		  PlayerTextDrawSetString(playerid, HandyMusikApp[playerid][4], "BigSmoke_feat_Flying_Kitty");
	    }
        else if (!strcmp(dini_Get(Spieler, "Handylied"), "3"))
        {
		  PlayerTextDrawSetString(playerid, HandyMusikApp[playerid][5], "Lets_go_Bowling");
		  PlayerTextDrawSetString(playerid, HandyMusikApp[playerid][4], "Niko_and_Roman_feat_Flying_Kitty");
	    }
        else if (!strcmp(dini_Get(Spieler, "Handylied"), "4"))
        {
		  PlayerTextDrawSetString(playerid, HandyMusikApp[playerid][5], "Hey_now,_you're_a_CJ");
		  PlayerTextDrawSetString(playerid, HandyMusikApp[playerid][4], "BigSmoke_feat_Flying_Kitty");
	    }
        else if (!strcmp(dini_Get(Spieler, "Handylied"), "5"))
        {
		  PlayerTextDrawSetString(playerid, HandyMusikApp[playerid][5], "Never_gonna_follow_that_train");
		  PlayerTextDrawSetString(playerid, HandyMusikApp[playerid][4], "BigSmoke_feat_Flying_Kitty");
	    }
        else if (!strcmp(dini_Get(Spieler, "Handylied"), "6"))
        {
		  PlayerTextDrawSetString(playerid, HandyMusikApp[playerid][5], "I'm_in_love_with_the_train");
		  PlayerTextDrawSetString(playerid, HandyMusikApp[playerid][4], "BigSmoke_feat_Flying_Kitty");
	    }
        else if (!strcmp(dini_Get(Spieler, "Handylied"), "7"))
        {
		  PlayerTextDrawSetString(playerid, HandyMusikApp[playerid][5], "Just_another_order");
		  PlayerTextDrawSetString(playerid, HandyMusikApp[playerid][4], "BigSmoke_feat_Flying_Kitty");
	    }
        else if (!strcmp(dini_Get(Spieler, "Handylied"), "8"))
        {
		  PlayerTextDrawSetString(playerid, HandyMusikApp[playerid][5], "You_can_always_go_around");
		  PlayerTextDrawSetString(playerid, HandyMusikApp[playerid][4], "Swiss001");
	    }
	 }
     if(playertextid == HandyEinstellungen[playerid][0])
     {
	    PlayerTextDrawHide(playerid,HandyTelefonbuch[playerid][0]);
	    PlayerTextDrawHide(playerid,HandyTelefonbuch[playerid][1]);
	    PlayerTextDrawHide(playerid,HandyTelefonbuch[playerid][2]);
	    PlayerTextDrawHide(playerid,HandyTelefonbuch[playerid][3]);
	    PlayerTextDrawHide(playerid,HandyTelefonbuch[playerid][4]);
	    PlayerTextDrawHide(playerid,HandyTelefonbuch[playerid][5]);
	    PlayerTextDrawHide(playerid,HandyCalender[playerid][0]);
	    PlayerTextDrawHide(playerid,HandyCalender[playerid][1]);
	    PlayerTextDrawHide(playerid,HandyCalender[playerid][2]);
	    PlayerTextDrawHide(playerid,HandyCalender[playerid][3]);
	    PlayerTextDrawHide(playerid,HandyCalender[playerid][4]);
	    PlayerTextDrawHide(playerid,HandyMusik[playerid][0]);
	    PlayerTextDrawHide(playerid,HandyMusik[playerid][1]);
	    PlayerTextDrawHide(playerid,HandyMusik[playerid][2]);
	    PlayerTextDrawHide(playerid,HandyMusik[playerid][3]);
	    PlayerTextDrawHide(playerid,HandyMusik[playerid][4]);
	    PlayerTextDrawHide(playerid,HandyMusik[playerid][5]);
	    PlayerTextDrawHide(playerid,HandyMusik[playerid][6]);
	    PlayerTextDrawHide(playerid,HandyEinstellungen[playerid][0]);
	    PlayerTextDrawHide(playerid,HandyEinstellungen[playerid][1]);
	    PlayerTextDrawHide(playerid,HandyEinstellungen[playerid][2]);
	    PlayerTextDrawHide(playerid,HandyOrt[playerid]);
	    PlayerTextDrawHide(playerid,HandyZeit[playerid]);
	    PlayerTextDrawHide(playerid,HandyAuflegen[playerid][0]);
	    PlayerTextDrawShow(playerid, HandyZruck[playerid]);
	    PlayerTextDrawShow(playerid,HandyTonEinstellungen[playerid][0]);
	    PlayerTextDrawShow(playerid,HandyTonEinstellungen[playerid][1]);
	    PlayerTextDrawShow(playerid,HandyTonEinstellungen[playerid][2]);
	    PlayerTextDrawShow(playerid,HandyTonEinstellungen[playerid][3]);
	 }
     if(playertextid == HandyTonEinstellungen[playerid][0])
     {
	    PlayerTextDrawHide(playerid, HandyTonEinstellungen[playerid][0]);
	    PlayerTextDrawHide(playerid, HandyTonEinstellungen[playerid][1]);
	    PlayerTextDrawHide(playerid, HandyTonEinstellungen[playerid][2]);
	    PlayerTextDrawHide(playerid, HandyTonEinstellungen[playerid][3]);
	    PlayerTextDrawHide(playerid, HandyZruck[playerid]);
	    PlayerTextDrawShow(playerid, HandyEinstellungenZruck[playerid]);
	    PlayerTextDrawShow(playerid, HandyNachrichtenton[playerid]);
	    PlayerTextDrawShow(playerid, HandyMute[playerid][0]);
	    PlayerTextDrawShow(playerid, HandyMute[playerid][1]);
	    PlayerTextDrawShow(playerid, HandyMute[playerid][2]);
	    PlayerTextDrawShow(playerid, HandyMute[playerid][3]);
	    PlayerTextDrawShow(playerid, HandyMute[playerid][4]);
	    PlayerTextDrawShow(playerid, HandyNachrichtenton1_[playerid]);
	    PlayerTextDrawShow(playerid, HandyNachrichtenton2_[playerid]);
	    PlayerTextDrawShow(playerid, HandyNachrichtenton3_[playerid]);
	    PlayerTextDrawShow(playerid, HandyKlingelton[playerid]);
	    PlayerTextDrawShow(playerid, HandyKlingelton1_[playerid]);
	    PlayerTextDrawShow(playerid, HandyKlingelton2_[playerid]);
	    PlayerTextDrawShow(playerid, HandyKlingelton3_[playerid]);
        PlayerTextDrawColor(playerid, HandyKlingelton1[playerid], 255);
        PlayerTextDrawColor(playerid, HandyKlingelton2[playerid], 255);
        PlayerTextDrawColor(playerid, HandyKlingelton3[playerid], 255);
        PlayerTextDrawColor(playerid, HandyNachrichtenton1[playerid], 255);
        PlayerTextDrawColor(playerid, HandyNachrichtenton2[playerid], 255);
        PlayerTextDrawColor(playerid, HandyNachrichtenton3[playerid], 255);
	    

	    {format(Spieler, sizeof Spieler, "/Spieler/%s.txt", GetSname(playerid));
        if (!strcmp(dini_Get(Spieler, "HandyTon"), "Aus"))
        {
		  PlayerTextDrawSetString(playerid,PlayerText:HandyMute[playerid][2], "x");
	    }
	    else if (!strcmp(dini_Get(Spieler, "HandyTon"), "Ein"))
	    {
		  PlayerTextDrawSetString(playerid,PlayerText:HandyMute[playerid][2], ")))");
	    }}
	    {format(Spieler, sizeof Spieler, "/Spieler/%s.txt", GetSname(playerid));
		if(dini_Int(Spieler, "Klingelton") == 20600)
	    {
          PlayerTextDrawColor(playerid, HandyKlingelton1[playerid], Hellgrün);
	    }
	    if(dini_Int(Spieler, "Klingelton") == 20804)
	    {
          PlayerTextDrawColor(playerid, HandyKlingelton2[playerid], Hellgrün);
	    }
	    if(dini_Int(Spieler, "Klingelton") == 23000)
	    {
          PlayerTextDrawColor(playerid, HandyKlingelton3[playerid], Hellgrün);
	    }
	    if(dini_Int(Spieler, "Nachrichtenton") == 1058)
	    {
          PlayerTextDrawColor(playerid, HandyNachrichtenton1[playerid], Hellgrün);
	    }
	    if(dini_Int(Spieler, "Nachrichtenton") == 45400)
	    {
          PlayerTextDrawColor(playerid, HandyNachrichtenton2[playerid], Hellgrün);
	    }
	    if(dini_Int(Spieler, "Nachrichtenton") == 39602)
	    {
          PlayerTextDrawColor(playerid, HandyNachrichtenton3[playerid], Hellgrün);
	    }}
	    PlayerTextDrawShow(playerid, HandyNachrichtenton1[playerid]);
	    PlayerTextDrawShow(playerid, HandyNachrichtenton2[playerid]);
	    PlayerTextDrawShow(playerid, HandyNachrichtenton3[playerid]);
	    PlayerTextDrawShow(playerid, HandyKlingelton1[playerid]);
	    PlayerTextDrawShow(playerid, HandyKlingelton2[playerid]);
	    PlayerTextDrawShow(playerid, HandyKlingelton3[playerid]);
	 }
     if(playertextid == HandyEinstellungenZruck[playerid])
     {
	    PlayerTextDrawShow(playerid, HandyZruck[playerid]);
	    PlayerTextDrawShow(playerid, HandyTonEinstellungen[playerid][0]);
	    PlayerTextDrawShow(playerid, HandyTonEinstellungen[playerid][1]);
	    PlayerTextDrawShow(playerid, HandyTonEinstellungen[playerid][2]);
	    PlayerTextDrawShow(playerid, HandyTonEinstellungen[playerid][3]);
	    PlayerTextDrawShow(playerid, HandyZruck[playerid]);
	    PlayerTextDrawHide(playerid, HandyEinstellungenZruck[playerid]);
		PlayerTextDrawHide(playerid, HandyNachrichtenton[playerid]);
	    PlayerTextDrawHide(playerid, HandyNachrichtenton1[playerid]);
	    PlayerTextDrawHide(playerid, HandyNachrichtenton2[playerid]);
	    PlayerTextDrawHide(playerid, HandyNachrichtenton3[playerid]);
	    PlayerTextDrawHide(playerid, HandyNachrichtenton1_[playerid]);
	    PlayerTextDrawHide(playerid, HandyNachrichtenton2_[playerid]);
	    PlayerTextDrawHide(playerid, HandyNachrichtenton3_[playerid]);
	    PlayerTextDrawHide(playerid, HandyKlingelton[playerid]);
	    PlayerTextDrawHide(playerid, HandyKlingelton1[playerid]);
	    PlayerTextDrawHide(playerid, HandyKlingelton2[playerid]);
	    PlayerTextDrawHide(playerid, HandyKlingelton3[playerid]);
	    PlayerTextDrawHide(playerid, HandyKlingelton1_[playerid]);
	    PlayerTextDrawHide(playerid, HandyKlingelton2_[playerid]);
	    PlayerTextDrawHide(playerid, HandyKlingelton3_[playerid]);
	    PlayerTextDrawHide(playerid, HandyMute[playerid][0]);
	    PlayerTextDrawHide(playerid, HandyMute[playerid][1]);
	    PlayerTextDrawHide(playerid, HandyMute[playerid][2]);
	    PlayerTextDrawHide(playerid, HandyMute[playerid][3]);
	    PlayerTextDrawHide(playerid, HandyMute[playerid][4]);
	 }
     for(new i = 0, j = GetPlayerPoolSize(); i <= j; i++)
     if(playertextid == Handy_Telefonbuch_AlleK[playerid][0])
     {
		SetPVarInt(playerid, "HandyKontakteSkroll", 0);
		SetPVarInt(playerid, "HandyKontakte", 1);
	    PlayerTextDrawHide(playerid,Handy_Telefonbuch_AlleK[playerid][0]);
	    PlayerTextDrawHide(playerid,Handy_Telefonbuch_AlleK[playerid][1]);
	    PlayerTextDrawHide(playerid,Handy_Telefonbuch_AlleK[playerid][2]);
	    PlayerTextDrawHide(playerid,Handy_Telefonbuch_AlleK[playerid][3]);
	    PlayerTextDrawHide(playerid,Handy_Telefonbuch_AlleK[playerid][4]);
	    PlayerTextDrawHide(playerid,Handy_Telefonbuch_Freunde[playerid][0]);
	    PlayerTextDrawHide(playerid,Handy_Telefonbuch_Freunde[playerid][1]);
	    PlayerTextDrawHide(playerid,Handy_Telefonbuch_Freunde[playerid][2]);
	    PlayerTextDrawHide(playerid,Handy_Telefonbuch_Freunde[playerid][3]);
	    PlayerTextDrawHide(playerid,Handy_Telefonbuch_Freunde[playerid][4]);
	    PlayerTextDrawHide(playerid,Handy_Telefonbuch_Freunde[playerid][5]);
	    PlayerTextDrawHide(playerid,Handy_Telefonbuch_Freunde[playerid][6]);
	    PlayerTextDrawHide(playerid,Handy_Telefonbuch_publicService[playerid][0]);
	    PlayerTextDrawHide(playerid, Handy_Telefonbuch_publicService[playerid][1]);
	    PlayerTextDrawHide(playerid, Handy_Telefonbuch_Suchen[playerid][0]);
	    PlayerTextDrawHide(playerid, Handy_Telefonbuch_Suchen[playerid][1]);
	    PlayerTextDrawHide(playerid, Handy_Telefonbuch_Suchen[playerid][2]);
	    PlayerTextDrawHide(playerid, Handy_Telefonbuch_Suchen[playerid][3]);
	    PlayerTextDrawHide(playerid,HandyTelefonbuch[playerid][1]);
	    PlayerTextDrawHide(playerid,HandyCalender[playerid][1]);
	    PlayerTextDrawHide(playerid, HandyMusik[playerid][1]);
	    PlayerTextDrawHide(playerid, HandyEinstellungen[playerid][1]);
	    PlayerTextDrawShow(playerid, HandyTelefonbuchZruck[playerid]);
	    PlayerTextDrawHide(playerid, HandyZruck[playerid]);
	    PlayerTextDrawShow(playerid, HandyCalender_Monday[playerid]);
	    PlayerTextDrawShow(playerid, HandyCalender_Tuesday[playerid]);
	    PlayerTextDrawShow(playerid, HandyCalender_Wednesday[playerid]);
	    PlayerTextDrawShow(playerid, HandyCalender_Thursday[playerid]);
	    PlayerTextDrawShow(playerid, HandyCalender_Friday[playerid]);
	    PlayerTextDrawShow(playerid, HandyCalender_Saturday[playerid]);
	    PlayerTextDrawShow(playerid, HandyCalender_Sunday[playerid]);
	    PlayerTextDrawShow(playerid, HandyCalender_Monday_[playerid]);
	    PlayerTextDrawSetString(playerid, HandyCalender_Monday_[playerid], "           Up");
	    PlayerTextDrawShow(playerid, HandyCalender_Tuesday_[playerid]);
	    PlayerTextDrawSetString(playerid, HandyCalender_Tuesday_[playerid], GetSname(5*GetPVarInt(playerid, "HandyKontakteSkroll")));
	    PlayerTextDrawShow(playerid, HandyCalender_Wednesday_[playerid]);
	    PlayerTextDrawSetString(playerid, HandyCalender_Wednesday_[playerid], GetSname(1+5*GetPVarInt(playerid, "HandyKontakteSkroll")));
	    PlayerTextDrawShow(playerid, HandyCalender_Thursday_[playerid]);
	    PlayerTextDrawSetString(playerid, HandyCalender_Thursday_[playerid], GetSname(2+5*GetPVarInt(playerid, "HandyKontakteSkroll")));
	    PlayerTextDrawShow(playerid, HandyCalender_Friday_[playerid]);
	    PlayerTextDrawSetString(playerid, HandyCalender_Friday_[playerid], GetSname(3+5*GetPVarInt(playerid, "HandyKontakteSkroll")));
	    PlayerTextDrawShow(playerid, HandyCalender_Saturday_[playerid]);
	    PlayerTextDrawSetString(playerid, HandyCalender_Saturday_[playerid], GetSname(4+5*GetPVarInt(playerid, "HandyKontakteSkroll")));
	    PlayerTextDrawShow(playerid, HandyCalender_Sunday_[playerid]);
	    PlayerTextDrawSetString(playerid, HandyCalender_Sunday_[playerid], "          Down");
	    new string[21];
	    format(string, sizeof string, "%i/%i", GetPVarInt(playerid, "HandyKontakteSkroll")+1, i/5+1);
	    PlayerTextDrawSetString(playerid, HandyOrt[playerid], string);
	    PlayerTextDrawShow(playerid, HandyOrt[playerid]);
	    format(string, sizeof string, "Online: %i players", i+1);
	    PlayerTextDrawSetString(playerid, HandyZeit[playerid], string);
	    PlayerTextDrawShow(playerid, HandyZeit[playerid]);
	 }
     if(playertextid == HandyTelefonbuchZruck[playerid])
     {
	    if(GetPVarInt(playerid, "HandyKontakte") == 2)
		{
           HandyShowing[HandyCalling[playerid]] = -1;//hier
           HandyShowing[HandyCaller[playerid]] = 1;
	       DeletePVar(HandyCaller[playerid], "HandyAnrufState");
	       DeletePVar(HandyCalling[playerid], "HandyAnrufState");
           HandyCaller[playerid] = -1;
           HandyCalling[playerid] = -1;
	       PlayerTextDrawHide(playerid,HandyCHProfile[playerid]);
	       PlayerTextDrawHide(playerid,HandyCHProfile_[playerid]);
	       PlayerTextDrawHide(playerid,HandyCallContact[playerid]);
	       PlayerTextDrawHide(playerid,HandyCallContact_[playerid]);
	       PlayerTextDrawHide(playerid,HandyAddFriendContact[playerid]);
	       PlayerTextDrawHide(playerid,HandyAddFriendContact_[playerid]);
	       PlayerTextDrawHide(playerid, HandyKontaktProfilFarbe[playerid]);
	       PlayerTextDrawHide(playerid, HandyKontaktProfilBild[playerid]);
	       PlayerTextDrawShow(playerid, HandyCalender_Monday[playerid]);
	       PlayerTextDrawShow(playerid, HandyCalender_Tuesday[playerid]);
	       PlayerTextDrawShow(playerid, HandyCalender_Wednesday[playerid]);
	       PlayerTextDrawShow(playerid, HandyCalender_Thursday[playerid]);
	       PlayerTextDrawShow(playerid, HandyCalender_Friday[playerid]);
	       PlayerTextDrawShow(playerid, HandyCalender_Saturday[playerid]);
	       PlayerTextDrawShow(playerid, HandyCalender_Sunday[playerid]);
	       PlayerTextDrawShow(playerid, HandyCalender_Monday_[playerid]);
	       PlayerTextDrawSetString(playerid, HandyCalender_Monday_[playerid], "           Up");
	       PlayerTextDrawShow(playerid, HandyCalender_Tuesday_[playerid]);
	       PlayerTextDrawSetString(playerid, HandyCalender_Tuesday_[playerid], GetSname(5*GetPVarInt(playerid, "HandyKontakteSkroll")));
	       PlayerTextDrawShow(playerid, HandyCalender_Wednesday_[playerid]);
	       PlayerTextDrawSetString(playerid, HandyCalender_Wednesday_[playerid], GetSname(1+5*GetPVarInt(playerid, "HandyKontakteSkroll")));
	       PlayerTextDrawShow(playerid, HandyCalender_Thursday_[playerid]);
	       PlayerTextDrawSetString(playerid, HandyCalender_Thursday_[playerid], GetSname(2+5*GetPVarInt(playerid, "HandyKontakteSkroll")));
	       PlayerTextDrawShow(playerid, HandyCalender_Friday_[playerid]);
	       PlayerTextDrawSetString(playerid, HandyCalender_Friday_[playerid], GetSname(3+5*GetPVarInt(playerid, "HandyKontakteSkroll")));
	       PlayerTextDrawShow(playerid, HandyCalender_Saturday_[playerid]);
	       PlayerTextDrawSetString(playerid, HandyCalender_Saturday_[playerid], GetSname(4+5*GetPVarInt(playerid, "HandyKontakteSkroll")));
	       PlayerTextDrawShow(playerid, HandyCalender_Sunday_[playerid]);
	       PlayerTextDrawSetString(playerid, HandyCalender_Sunday_[playerid], "          Down");
	       for(new i = 0, j = GetPlayerPoolSize(); i <= j; i++){
	       new string[21];
	       format(string, sizeof string, "%i/%i", GetPVarInt(playerid, "HandyKontakteSkroll")+1, i/5+1);
	       PlayerTextDrawSetString(playerid, HandyOrt[playerid], string);
	       PlayerTextDrawShow(playerid, HandyOrt[playerid]);
	       format(string, sizeof string, "Online: %i players", i+1);
	       PlayerTextDrawSetString(playerid, HandyZeit[playerid], string);
	       PlayerTextDrawShow(playerid, HandyZeit[playerid]);
	       PlayerTextDrawHide(playerid, HandyInfo_Nummer[playerid]);
	       PlayerTextDrawHide(playerid, HandyInfo_Status[playerid]);
	       SetPVarInt(playerid, "HandyKontakte", 1);}
	    }
	    if(GetPVarInt(playerid, "HandyFreundesliste") == 2)
		{
	       PlayerTextDrawHide(playerid,HandyCHProfile[playerid]);
	       PlayerTextDrawHide(playerid,HandyCHProfile_[playerid]);
	       PlayerTextDrawHide(playerid,HandyCallContact[playerid]);
	       PlayerTextDrawHide(playerid,HandyCallContact_[playerid]);
	       PlayerTextDrawHide(playerid,HandyAddFriendContact[playerid]);
	       PlayerTextDrawHide(playerid,HandyAddFriendContact_[playerid]);
	       PlayerTextDrawHide(playerid, HandyKontaktProfilFarbe[playerid]);
	       PlayerTextDrawHide(playerid, HandyKontaktProfilBild[playerid]);
	       PlayerTextDrawShow(playerid, HandyCalender_Monday[playerid]);
	       PlayerTextDrawShow(playerid, HandyCalender_Tuesday[playerid]);
	       PlayerTextDrawShow(playerid, HandyCalender_Wednesday[playerid]);
	       PlayerTextDrawShow(playerid, HandyCalender_Thursday[playerid]);
	       PlayerTextDrawShow(playerid, HandyCalender_Friday[playerid]);
	       PlayerTextDrawShow(playerid, HandyCalender_Saturday[playerid]);
	       PlayerTextDrawShow(playerid, HandyCalender_Sunday[playerid]);
	       PlayerTextDrawShow(playerid, HandyCalender_Monday_[playerid]);
	       PlayerTextDrawHide(playerid, HandyInfo_Nummer[playerid]);
	       PlayerTextDrawHide(playerid, HandyInfo_Status[playerid]);
	       PlayerTextDrawSetString(playerid, HandyCalender_Monday_[playerid], "           Up");
	       PlayerTextDrawShow(playerid, HandyCalender_Tuesday_[playerid]);
	       PlayerTextDrawShow(playerid, HandyCalender_Wednesday_[playerid]);
	       PlayerTextDrawShow(playerid, HandyCalender_Thursday_[playerid]);
	       PlayerTextDrawShow(playerid, HandyCalender_Friday_[playerid]);
	       PlayerTextDrawShow(playerid, HandyCalender_Sunday_[playerid]);
	       PlayerTextDrawShow(playerid, HandyCalender_Saturday_[playerid]);
	       PlayerTextDrawSetString(playerid, HandyCalender_Sunday_[playerid], "          Down");
	       new string[50];
	       format(string, sizeof string, "%i/%i", GetPVarInt(playerid, "HandyFreundeSkroll")+1, GetPVarInt(playerid, "HandyFreundeSkroll")+5);
	       PlayerTextDrawSetString(playerid, HandyOrt[playerid], string);
           format(Spieler, sizeof Spieler, "/Spieler/%s.txt", GetSname(playerid));
           format(string, sizeof string, "Freund_%i", 1+5*GetPVarInt(playerid, "HandyFreundeSkroll"));
	       PlayerTextDrawSetString(playerid, HandyCalender_Tuesday_[playerid], dini_Get(Spieler, string));
           format(string, sizeof string, "Freund_%i", 2+5*GetPVarInt(playerid, "HandyFreundeSkroll"));
	       PlayerTextDrawSetString(playerid, HandyCalender_Wednesday_[playerid], dini_Get(Spieler, string));
           format(string, sizeof string, "Freund_%i", 3+5*GetPVarInt(playerid, "HandyFreundeSkroll"));
	       PlayerTextDrawSetString(playerid, HandyCalender_Thursday_[playerid], dini_Get(Spieler, string));
           format(string, sizeof string, "Freund_%i", 4+5*GetPVarInt(playerid, "HandyFreundeSkroll"));
	       PlayerTextDrawSetString(playerid, HandyCalender_Friday_[playerid], dini_Get(Spieler, string));
           format(string, sizeof string, "Freund_%i", 5+5*GetPVarInt(playerid, "HandyFreundeSkroll"));
	       PlayerTextDrawSetString(playerid, HandyCalender_Saturday_[playerid], dini_Get(Spieler, string));
	       SetPVarInt(playerid, "HandyFreundesliste", 1);
	    }
	    else
	    {
	       PlayerTextDrawHide(playerid, HandyCHProfile[playerid]);
	       PlayerTextDrawHide(playerid, HandyCHProfile_[playerid]);
	       PlayerTextDrawHide(playerid, HandyCallContact[playerid]);
	       PlayerTextDrawHide(playerid, HandyCallContact_[playerid]);
	       PlayerTextDrawHide(playerid, HandyAddFriendContact[playerid]);
	       PlayerTextDrawHide(playerid, HandyAddFriendContact_[playerid]);
	       PlayerTextDrawHide(playerid, HandyKontaktProfilFarbe[playerid]);
	       PlayerTextDrawHide(playerid, HandyKontaktProfilBild[playerid]);
	       PlayerTextDrawHide(playerid, HandyCalender_Monday[playerid]);
	       PlayerTextDrawHide(playerid, HandyCalender_Tuesday[playerid]);
	       PlayerTextDrawHide(playerid, HandyCalender_Wednesday[playerid]);
	       PlayerTextDrawHide(playerid, HandyCalender_Thursday[playerid]);
	       PlayerTextDrawHide(playerid, HandyCalender_Friday[playerid]);
	       PlayerTextDrawHide(playerid, HandyCalender_Saturday[playerid]);
	       PlayerTextDrawHide(playerid, HandyCalender_Sunday[playerid]);
	       PlayerTextDrawHide(playerid, HandyCalender_Monday_[playerid]);
	       PlayerTextDrawSetString(playerid, HandyCalender_Monday_[playerid], "~r~~h~x ~l~Monday");
	       PlayerTextDrawHide(playerid,HandyCalender_Tuesday_[playerid]);
	       PlayerTextDrawSetString(playerid, HandyCalender_Tuesday_[playerid], "~r~~h~x ~l~Tuesday");
	       PlayerTextDrawHide(playerid,HandyCalender_Wednesday_[playerid]);
	       PlayerTextDrawSetString(playerid, HandyCalender_Wednesday_[playerid], "~r~~h~x ~l~Wednesday");
	       PlayerTextDrawHide(playerid,HandyCalender_Thursday_[playerid]);
	       PlayerTextDrawSetString(playerid, HandyCalender_Thursday_[playerid], "~r~~h~x ~l~Thursday");
	       PlayerTextDrawHide(playerid,HandyCalender_Friday_[playerid]);
	       PlayerTextDrawSetString(playerid, HandyCalender_Friday_[playerid], "~r~~h~x ~l~Friday");
	       PlayerTextDrawHide(playerid,HandyCalender_Saturday_[playerid]);
	       PlayerTextDrawSetString(playerid, HandyCalender_Saturday_[playerid], "~r~~h~x ~l~Saturday");
	       PlayerTextDrawHide(playerid,HandyCalender_Sunday_[playerid]);
	       PlayerTextDrawSetString(playerid, HandyCalender_Sunday_[playerid], "~r~~h~x ~l~Sunday");
	       PlayerTextDrawHide(playerid, HandyTelefonbuch[playerid][0]);
	       PlayerTextDrawHide(playerid, HandyInfo_Nummer[playerid]);
	       PlayerTextDrawHide(playerid, HandyInfo_Status[playerid]);
	       PlayerTextDrawHide(playerid, HandyTelefonbuch[playerid][2]);
	       PlayerTextDrawHide(playerid, HandyTelefonbuch[playerid][3]);
	       PlayerTextDrawHide(playerid, HandyTelefonbuch[playerid][4]);
	       PlayerTextDrawHide(playerid, HandyTelefonbuch[playerid][5]);
	       PlayerTextDrawHide(playerid, HandyCalender[playerid][0]);
	       PlayerTextDrawShow(playerid, HandyCalender[playerid][1]);
	       PlayerTextDrawShow(playerid, HandyTelefonbuch[playerid][1]);
	       PlayerTextDrawShow(playerid, HandyMusik[playerid][1]);
	       PlayerTextDrawShow(playerid, HandyEinstellungen[playerid][1]);
	       PlayerTextDrawHide(playerid, HandyCalender[playerid][2]);
	       PlayerTextDrawHide(playerid, HandyCalender[playerid][3]);
	       PlayerTextDrawHide(playerid, HandyCalender[playerid][4]);
	       PlayerTextDrawHide(playerid, HandyMusik[playerid][0]);
	       PlayerTextDrawHide(playerid, HandyMusik[playerid][2]);
	       PlayerTextDrawHide(playerid, HandyMusik[playerid][3]);
	       PlayerTextDrawHide(playerid, HandyMusik[playerid][4]);
	       PlayerTextDrawHide(playerid, HandyMusik[playerid][5]);
	       PlayerTextDrawHide(playerid, HandyMusik[playerid][6]);
	       PlayerTextDrawHide(playerid, HandyEinstellungen[playerid][0]);
	       PlayerTextDrawHide(playerid, HandyEinstellungen[playerid][2]);
	       PlayerTextDrawHide(playerid, HandyOrt[playerid]);
	       PlayerTextDrawHide(playerid, HandyZeit[playerid]);
	       PlayerTextDrawShow(playerid, HandyZruck[playerid]);
	       PlayerTextDrawHide(playerid, HandyTelefonbuchZruck[playerid]);
	       PlayerTextDrawShow(playerid, Handy_Telefonbuch_AlleK[playerid][0]);
	       PlayerTextDrawShow(playerid, Handy_Telefonbuch_AlleK[playerid][1]);
	       PlayerTextDrawShow(playerid, Handy_Telefonbuch_AlleK[playerid][2]);
	       PlayerTextDrawShow(playerid, Handy_Telefonbuch_AlleK[playerid][3]);
	       PlayerTextDrawShow(playerid, Handy_Telefonbuch_AlleK[playerid][4]);
	       PlayerTextDrawShow(playerid, Handy_Telefonbuch_Freunde[playerid][0]);
	       PlayerTextDrawShow(playerid, Handy_Telefonbuch_Freunde[playerid][1]);
	       PlayerTextDrawShow(playerid, Handy_Telefonbuch_Freunde[playerid][2]);
	       PlayerTextDrawShow(playerid, Handy_Telefonbuch_Freunde[playerid][3]);
	       PlayerTextDrawShow(playerid, Handy_Telefonbuch_Freunde[playerid][4]);
	       PlayerTextDrawShow(playerid, Handy_Telefonbuch_Freunde[playerid][5]);
	       PlayerTextDrawShow(playerid, Handy_Telefonbuch_Freunde[playerid][6]);
	       PlayerTextDrawShow(playerid, Handy_Telefonbuch_publicService[playerid][0]);
	       PlayerTextDrawShow(playerid, Handy_Telefonbuch_publicService[playerid][1]);
	       PlayerTextDrawShow(playerid, Handy_Telefonbuch_Suchen[playerid][0]);
	       PlayerTextDrawShow(playerid, Handy_Telefonbuch_Suchen[playerid][1]);
	       PlayerTextDrawShow(playerid, Handy_Telefonbuch_Suchen[playerid][2]);
	       PlayerTextDrawShow(playerid, Handy_Telefonbuch_Suchen[playerid][3]);
		   DeletePVar(playerid, "HandyKontakte");
		   DeletePVar(playerid, "HandyKontakteSkroll");
		   DeletePVar(playerid, "HandyServicesSkroll");
		   DeletePVar(playerid, "HandyPublicService");
		   DeletePVar(playerid, "HandyFreundeSkroll");
		   DeletePVar(playerid, "HandyFreundesliste");
	    }
	 }
     if(playertextid == HandyCalender_Monday[playerid])
     {
	   if(GetPVarInt(playerid, "HandyKontakte") == 1)
	   {
	     if(GetPVarInt(playerid, "HandyKontakteSkroll") <= 0) return 1;
		 SetPVarInt(playerid, "HandyKontakteSkroll", (GetPVarInt(playerid, "HandyKontakteSkroll")-1));
	     PlayerTextDrawSetString(playerid, HandyCalender_Tuesday_[playerid], GetSname(5*GetPVarInt(playerid, "HandyKontakteSkroll")));
	     PlayerTextDrawSetString(playerid, HandyCalender_Wednesday_[playerid], GetSname(1+5*GetPVarInt(playerid, "HandyKontakteSkroll")));
	     PlayerTextDrawSetString(playerid, HandyCalender_Thursday_[playerid], GetSname(2+5*GetPVarInt(playerid, "HandyKontakteSkroll")));
	     PlayerTextDrawSetString(playerid, HandyCalender_Friday_[playerid], GetSname(3+5*GetPVarInt(playerid, "HandyKontakteSkroll")));
	     PlayerTextDrawSetString(playerid, HandyCalender_Saturday_[playerid], GetSname(4+5*GetPVarInt(playerid, "HandyKontakteSkroll")));
         for(new i = 0, j = GetPlayerPoolSize(); i <= j; i++){
	     new string[7];
	     format(string, sizeof string, "%i/%i", GetPVarInt(playerid, "HandyKontakteSkroll")+1, i/5+1);
	     PlayerTextDrawSetString(playerid, HandyOrt[playerid], string);
		 PlayerTextDrawShow(playerid, HandyOrt[playerid]);}
	   }
	   if(GetPVarInt(playerid, "HandyPublicService") == 1)
	   {
	     if(GetPVarInt(playerid, "HandyServicesSkroll") <= 0) return 1;
		 SetPVarInt(playerid, "HandyServicesSkroll", (GetPVarInt(playerid, "HandyServicesSkroll")-1));
	     new string[7];
	     format(string, sizeof string, "%i/3", GetPVarInt(playerid, "HandyServicesSkroll")+1);
	     PlayerTextDrawSetString(playerid, HandyOrt[playerid], string);

		 if(GetPVarInt(playerid, "HandyServicesSkroll") == 0)
		 {
	       PlayerTextDrawSetString(playerid, HandyCalender_Monday_[playerid], "           Up");
	       PlayerTextDrawSetString(playerid, HandyCalender_Tuesday_[playerid], "Police");
	       PlayerTextDrawSetString(playerid, HandyCalender_Wednesday_[playerid], "Ambulance");
	       PlayerTextDrawSetString(playerid, HandyCalender_Thursday_[playerid], "Firefighters");
	       PlayerTextDrawSetString(playerid, HandyCalender_Friday_[playerid], "Mechanic_1");
	       PlayerTextDrawSetString(playerid, HandyCalender_Saturday_[playerid], "Mechanic_2");
	       PlayerTextDrawSetString(playerid, HandyCalender_Sunday_[playerid], "          Down");
		 }
		 if(GetPVarInt(playerid, "HandyServicesSkroll") == 1)
		 {
	       PlayerTextDrawSetString(playerid, HandyCalender_Monday_[playerid], "           Up");
	       PlayerTextDrawSetString(playerid, HandyCalender_Tuesday_[playerid], "Electitian");
	       PlayerTextDrawSetString(playerid, HandyCalender_Wednesday_[playerid], "Taxi_1");
	       PlayerTextDrawSetString(playerid, HandyCalender_Thursday_[playerid], "Taxi_2");
	       PlayerTextDrawSetString(playerid, HandyCalender_Friday_[playerid], "Pizza");
	       PlayerTextDrawSetString(playerid, HandyCalender_Saturday_[playerid], "Restaurant");
	       PlayerTextDrawSetString(playerid, HandyCalender_Sunday_[playerid], "          Down");
		 }
		 if(GetPVarInt(playerid, "HandyServicesSkroll") == 2)
		 {
	       PlayerTextDrawSetString(playerid, HandyCalender_Monday_[playerid], "           Up");
	       PlayerTextDrawSetString(playerid, HandyCalender_Tuesday_[playerid], "wtf");
	       PlayerTextDrawSetString(playerid, HandyCalender_Wednesday_[playerid], "ok");
	       PlayerTextDrawSetString(playerid, HandyCalender_Thursday_[playerid], "lol");
	       PlayerTextDrawSetString(playerid, HandyCalender_Friday_[playerid], "haha");
	       PlayerTextDrawSetString(playerid, HandyCalender_Saturday_[playerid], "noob");
	       PlayerTextDrawSetString(playerid, HandyCalender_Sunday_[playerid], "          Down");
		 }
	   }
	   if(GetPVarInt(playerid, "HandyFreundesliste") == 1)
	   {
	     if(GetPVarInt(playerid, "HandyFreundeSkroll") <= 0) return 1;
		 SetPVarInt(playerid, "HandyFreundeSkroll", (GetPVarInt(playerid, "HandyFreundeSkroll")-1));
	     new string[70];
	     format(string, sizeof string, "%i/%i", GetPVarInt(playerid, "HandyFreundeSkroll")+1, GetPVarInt(playerid, "HandyFreundeSkroll")+5);
	     PlayerTextDrawSetString(playerid, HandyOrt[playerid], string);
         format(Spieler, sizeof Spieler, "/Spieler/%s.txt", GetSname(playerid));
         format(string, sizeof string, "Freund_%i", 1+5*GetPVarInt(playerid, "HandyFreundeSkroll"));
	     PlayerTextDrawSetString(playerid, HandyCalender_Tuesday_[playerid], dini_Get(Spieler, string));
         format(string, sizeof string, "Freund_%i", 2+5*GetPVarInt(playerid, "HandyFreundeSkroll"));
	     PlayerTextDrawSetString(playerid, HandyCalender_Wednesday_[playerid], dini_Get(Spieler, string));
         format(string, sizeof string, "Freund_%i", 3+5*GetPVarInt(playerid, "HandyFreundeSkroll"));
	     PlayerTextDrawSetString(playerid, HandyCalender_Thursday_[playerid], dini_Get(Spieler, string));
         format(string, sizeof string, "Freund_%i", 4+5*GetPVarInt(playerid, "HandyFreundeSkroll"));
	     PlayerTextDrawSetString(playerid, HandyCalender_Friday_[playerid], dini_Get(Spieler, string));
         format(string, sizeof string, "Freund_%i", 5+5*GetPVarInt(playerid, "HandyFreundeSkroll"));
	     PlayerTextDrawSetString(playerid, HandyCalender_Saturday_[playerid], dini_Get(Spieler, string));
	   }
	   else
	   {
	    
	   }
		
	 }
     if(playertextid == HandyCalender_Sunday[playerid])
	 {
	   if(GetPVarInt(playerid, "HandyKontakte") == 1)
	   {
		 SetPVarInt(playerid, "HandyKontakteSkroll", (GetPVarInt(playerid, "HandyKontakteSkroll")+1));
	     PlayerTextDrawSetString(playerid, HandyCalender_Tuesday_[playerid], GetSname(5*GetPVarInt(playerid, "HandyKontakteSkroll")));
	     PlayerTextDrawSetString(playerid, HandyCalender_Wednesday_[playerid], GetSname(1+5*GetPVarInt(playerid, "HandyKontakteSkroll")));
	     PlayerTextDrawSetString(playerid, HandyCalender_Thursday_[playerid], GetSname(2+5*GetPVarInt(playerid, "HandyKontakteSkroll")));
	     PlayerTextDrawSetString(playerid, HandyCalender_Friday_[playerid], GetSname(3+5*GetPVarInt(playerid, "HandyKontakteSkroll")));
	     PlayerTextDrawSetString(playerid, HandyCalender_Saturday_[playerid], GetSname(4+5*GetPVarInt(playerid, "HandyKontakteSkroll")));
         for(new i = 0, j = GetPlayerPoolSize(); i <= j; i++){
	     new string[7];
	     format(string, sizeof string, "%i/%i", GetPVarInt(playerid, "HandyKontakteSkroll")+1, i/5+1);
	     PlayerTextDrawSetString(playerid, HandyOrt[playerid], string);
	     PlayerTextDrawShow(playerid, HandyOrt[playerid]);}
	   }
	   if(GetPVarInt(playerid, "HandyPublicService") == 1)
	   {
		 SetPVarInt(playerid, "HandyServicesSkroll", (GetPVarInt(playerid, "HandyServicesSkroll")+1));
	     new string[7];
	     format(string, sizeof string, "%i/3", GetPVarInt(playerid, "HandyServicesSkroll")+1);
	     PlayerTextDrawSetString(playerid, HandyOrt[playerid], string);
		 if(GetPVarInt(playerid, "HandyServicesSkroll") == 1)
		 {
	       PlayerTextDrawSetString(playerid, HandyCalender_Monday_[playerid], "           Up");
	       PlayerTextDrawSetString(playerid, HandyCalender_Tuesday_[playerid], "Electitian");
	       PlayerTextDrawSetString(playerid, HandyCalender_Wednesday_[playerid], "Taxi_1");
	       PlayerTextDrawSetString(playerid, HandyCalender_Thursday_[playerid], "Taxi_2");
	       PlayerTextDrawSetString(playerid, HandyCalender_Friday_[playerid], "Pizza");
	       PlayerTextDrawSetString(playerid, HandyCalender_Saturday_[playerid], "Restaurant");
	       PlayerTextDrawSetString(playerid, HandyCalender_Sunday_[playerid], "          Down");
		 }
		 if(GetPVarInt(playerid, "HandyServicesSkroll") == 2)
		 {
	       PlayerTextDrawSetString(playerid, HandyCalender_Monday_[playerid], "           Up");
	       PlayerTextDrawSetString(playerid, HandyCalender_Tuesday_[playerid], "wtf");
	       PlayerTextDrawSetString(playerid, HandyCalender_Wednesday_[playerid], "ok");
	       PlayerTextDrawSetString(playerid, HandyCalender_Thursday_[playerid], "lol");
	       PlayerTextDrawSetString(playerid, HandyCalender_Friday_[playerid], "haha");
	       PlayerTextDrawSetString(playerid, HandyCalender_Saturday_[playerid], "noob");
	       PlayerTextDrawSetString(playerid, HandyCalender_Sunday_[playerid], "          Down");
		 }
		 else if(GetPVarInt(playerid, "HandyServicesSkroll") > 2)
		 {
	       PlayerTextDrawSetString(playerid, HandyCalender_Monday_[playerid], "           Up");
	       PlayerTextDrawSetString(playerid, HandyCalender_Tuesday_[playerid], " ");
	       PlayerTextDrawSetString(playerid, HandyCalender_Wednesday_[playerid], " ");
	       PlayerTextDrawSetString(playerid, HandyCalender_Thursday_[playerid], " ");
	       PlayerTextDrawSetString(playerid, HandyCalender_Friday_[playerid], " ");
	       PlayerTextDrawSetString(playerid, HandyCalender_Saturday_[playerid], " ");
	       PlayerTextDrawSetString(playerid, HandyCalender_Sunday_[playerid], "          Down");
		 }
	   }
	   if(GetPVarInt(playerid, "HandyFreundesliste") == 1)
	   {
		 SetPVarInt(playerid, "HandyFreundeSkroll", (GetPVarInt(playerid, "HandyFreundeSkroll")+1));
	     new string[70];
	     format(string, sizeof string, "%i/%i", GetPVarInt(playerid, "HandyFreundeSkroll")+1, GetPVarInt(playerid, "HandyFreundeSkroll")+5);
	     PlayerTextDrawSetString(playerid, HandyOrt[playerid], string);
         format(Spieler, sizeof Spieler, "/Spieler/%s.txt", GetSname(playerid));
         format(string, sizeof string, "Freund_%i", 1+5*GetPVarInt(playerid, "HandyFreundeSkroll"));
	     PlayerTextDrawSetString(playerid, HandyCalender_Tuesday_[playerid], dini_Get(Spieler, string));
         format(string, sizeof string, "Freund_%i", 2+5*GetPVarInt(playerid, "HandyFreundeSkroll"));
	     PlayerTextDrawSetString(playerid, HandyCalender_Wednesday_[playerid], dini_Get(Spieler, string));
         format(string, sizeof string, "Freund_%i", 3+5*GetPVarInt(playerid, "HandyFreundeSkroll"));
	     PlayerTextDrawSetString(playerid, HandyCalender_Thursday_[playerid], dini_Get(Spieler, string));
         format(string, sizeof string, "Freund_%i", 4+5*GetPVarInt(playerid, "HandyFreundeSkroll"));
	     PlayerTextDrawSetString(playerid, HandyCalender_Friday_[playerid], dini_Get(Spieler, string));
         format(string, sizeof string, "Freund_%i", 5+5*GetPVarInt(playerid, "HandyFreundeSkroll"));
	     PlayerTextDrawSetString(playerid, HandyCalender_Saturday_[playerid], dini_Get(Spieler, string));
	   }
	   else
	   {

	   }
	 }
     if(playertextid == HandyCalender_Tuesday[playerid])
	 {
	   if(GetPVarInt(playerid, "HandyKontakte") == 1)
	    {
	       GetPlayerHandyName(playerid,1);
	       return 1;
	    }
	   if(GetPVarInt(playerid, "HandyPublicService") == 1)
	    {
	       //publicservice_1
	       SendClientMessage(playerid, Weis, "Service no.1");
	       return 1;
	    }
	   if(GetPVarInt(playerid, "HandyFreundesliste") == 1)
	    {
	       OpenFreundHandy(playerid, 1);
	       return 1;
	    }
	   else
	    {
	       SendClientMessage(playerid, Weis, "Kalender?");
	    }
	 }
     if(playertextid == HandyCalender_Wednesday[playerid])
	 {
	   if(GetPVarInt(playerid, "HandyKontakte") == 1)
	    {
	       GetPlayerHandyName(playerid,2);
	       return 1;
	    }
	   if(GetPVarInt(playerid, "HandyPublicService") == 1)
	    {
	       //publicservice_2
	       SendClientMessage(playerid, Weis, "Service no.2");
	       return 1;
	    }
	   if(GetPVarInt(playerid, "HandyFreundesliste") == 1)
	    {
	       OpenFreundHandy(playerid, 2);
	       return 1;
	    }
	   else
	    {
	       SendClientMessage(playerid, Weis, "Kalender?");
	    }
	 }
     if(playertextid == HandyCalender_Thursday[playerid])
	 {
	   if(GetPVarInt(playerid, "HandyKontakte") == 1)
	    {
	       GetPlayerHandyName(playerid,3);
	       return 1;
	    }
	   if(GetPVarInt(playerid, "HandyPublicService") == 1)
	    {
	       //publicservice_3
	       SendClientMessage(playerid, Weis, "Service no.3");
	       return 1;
	    }
	   if(GetPVarInt(playerid, "HandyFreundesliste") == 1)
	    {
	       OpenFreundHandy(playerid, 3);
	       return 1;
	    }
	   else
	    {
	       SendClientMessage(playerid, Weis, "Kalender?");
	    }
	 }
     if(playertextid == HandyCalender_Friday[playerid])
	 {
	   if(GetPVarInt(playerid, "HandyKontakte") == 1)
	    {
	       GetPlayerHandyName(playerid,4);
	       return 1;
	    }
	   if(GetPVarInt(playerid, "HandyPublicService") == 1)
	    {
	       //publicservice_4
	       SendClientMessage(playerid, Weis, "Service no.4");
	       return 1;
	    }
	   if(GetPVarInt(playerid, "HandyFreundesliste") == 1)
	    {
	       OpenFreundHandy(playerid, 4);
	       return 1;
	    }
	   else
	    {
	       SendClientMessage(playerid, Weis, "Kalender?");
	    }
	 }
     if(playertextid == HandyCalender_Saturday[playerid])
	 {
	   if(GetPVarInt(playerid, "HandyKontakte") == 1)
	    {
	       GetPlayerHandyName(playerid,5);
	       return 1;
	    }
	   if(GetPVarInt(playerid, "HandyPublicService") == 1)
	    {
	       //publicservice_5
	       SendClientMessage(playerid, Weis, "Service no.5");
	       return 1;
	    }
	   if(GetPVarInt(playerid, "HandyFreundesliste") == 1)
	    {
	       OpenFreundHandy(playerid, 5);
	       return 1;
	    }
	   else
	    {
	       SendClientMessage(playerid, Weis, "Kalender?");
	    }
	 }
     if(playertextid == Handy_Telefonbuch_publicService[playerid][0])
     {
		SetPVarInt(playerid, "HandyServicesSkroll", 1);
		SetPVarInt(playerid, "HandyPublicService", 1);
	    PlayerTextDrawHide(playerid, HandyTelefonbuch[playerid][0]);
	    PlayerTextDrawHide(playerid, HandyTelefonbuch[playerid][0]);
	    PlayerTextDrawHide(playerid, HandyTelefonbuch[playerid][1]);
	    PlayerTextDrawHide(playerid, HandyTelefonbuch[playerid][2]);
	    PlayerTextDrawHide(playerid, HandyTelefonbuch[playerid][3]);
	    PlayerTextDrawHide(playerid, HandyTelefonbuch[playerid][4]);
	    PlayerTextDrawHide(playerid, HandyTelefonbuch[playerid][5]);
	    PlayerTextDrawHide(playerid, HandyCalender[playerid][0]);
	    PlayerTextDrawHide(playerid, HandyCalender[playerid][1]);
	    PlayerTextDrawHide(playerid, HandyCalender[playerid][2]);
	    PlayerTextDrawHide(playerid, HandyCalender[playerid][3]);
	    PlayerTextDrawHide(playerid, HandyCalender[playerid][4]);
	    PlayerTextDrawHide(playerid, HandyMusik[playerid][0]);
	    PlayerTextDrawHide(playerid, HandyMusik[playerid][1]);
	    PlayerTextDrawHide(playerid, HandyMusik[playerid][2]);
	    PlayerTextDrawHide(playerid, HandyMusik[playerid][3]);
	    PlayerTextDrawHide(playerid, HandyMusik[playerid][4]);
	    PlayerTextDrawHide(playerid, HandyMusik[playerid][5]);
	    PlayerTextDrawHide(playerid, HandyMusik[playerid][6]);
	    PlayerTextDrawHide(playerid, HandyEinstellungen[playerid][0]);
	    PlayerTextDrawHide(playerid, HandyEinstellungen[playerid][1]);
	    PlayerTextDrawHide(playerid, HandyEinstellungen[playerid][2]);
	    PlayerTextDrawHide(playerid, HandyOrt[playerid]);
	    PlayerTextDrawHide(playerid, HandyZeit[playerid]);
	    PlayerTextDrawHide(playerid, HandyZruck[playerid]);
	    PlayerTextDrawShow(playerid, HandyTelefonbuchZruck[playerid]);
	    PlayerTextDrawHide(playerid, HandyAuflegen[playerid][0]);
	    PlayerTextDrawHide(playerid, Handy_Telefonbuch_AlleK[playerid][0]);
	    PlayerTextDrawHide(playerid, Handy_Telefonbuch_AlleK[playerid][1]);
	    PlayerTextDrawHide(playerid, Handy_Telefonbuch_AlleK[playerid][2]);
	    PlayerTextDrawHide(playerid, Handy_Telefonbuch_AlleK[playerid][3]);
	    PlayerTextDrawHide(playerid, Handy_Telefonbuch_AlleK[playerid][4]);
	    PlayerTextDrawHide(playerid, Handy_Telefonbuch_Freunde[playerid][0]);
	    PlayerTextDrawHide(playerid, Handy_Telefonbuch_Freunde[playerid][1]);
	    PlayerTextDrawHide(playerid, Handy_Telefonbuch_Freunde[playerid][2]);
	    PlayerTextDrawHide(playerid, Handy_Telefonbuch_Freunde[playerid][3]);
	    PlayerTextDrawHide(playerid, Handy_Telefonbuch_Freunde[playerid][4]);
	    PlayerTextDrawHide(playerid, Handy_Telefonbuch_Freunde[playerid][5]);
	    PlayerTextDrawHide(playerid, Handy_Telefonbuch_Freunde[playerid][6]);
	    PlayerTextDrawHide(playerid, Handy_Telefonbuch_publicService[playerid][0]);
	    PlayerTextDrawHide(playerid, Handy_Telefonbuch_publicService[playerid][1]);
	    PlayerTextDrawHide(playerid, Handy_Telefonbuch_Suchen[playerid][0]);
	    PlayerTextDrawHide(playerid, Handy_Telefonbuch_Suchen[playerid][1]);
	    PlayerTextDrawHide(playerid, Handy_Telefonbuch_Suchen[playerid][2]);
	    PlayerTextDrawHide(playerid, Handy_Telefonbuch_Suchen[playerid][3]);
	    PlayerTextDrawHide(playerid,Handy_Telefonbuch_AlleK[playerid][0]);
	    PlayerTextDrawHide(playerid,Handy_Telefonbuch_AlleK[playerid][1]);
	    PlayerTextDrawHide(playerid,Handy_Telefonbuch_AlleK[playerid][2]);
	    PlayerTextDrawHide(playerid,Handy_Telefonbuch_AlleK[playerid][3]);
	    PlayerTextDrawHide(playerid,Handy_Telefonbuch_AlleK[playerid][4]);
	    PlayerTextDrawHide(playerid,Handy_Telefonbuch_Freunde[playerid][0]);
	    PlayerTextDrawHide(playerid,Handy_Telefonbuch_Freunde[playerid][1]);
	    PlayerTextDrawHide(playerid,Handy_Telefonbuch_Freunde[playerid][2]);
	    PlayerTextDrawHide(playerid,Handy_Telefonbuch_Freunde[playerid][3]);
	    PlayerTextDrawHide(playerid,Handy_Telefonbuch_Freunde[playerid][4]);
	    PlayerTextDrawHide(playerid,Handy_Telefonbuch_Freunde[playerid][5]);
	    PlayerTextDrawHide(playerid,Handy_Telefonbuch_Freunde[playerid][6]);
	    PlayerTextDrawHide(playerid,Handy_Telefonbuch_publicService[playerid][0]);
	    PlayerTextDrawHide(playerid, Handy_Telefonbuch_publicService[playerid][1]);
	    PlayerTextDrawHide(playerid, Handy_Telefonbuch_Suchen[playerid][0]);
	    PlayerTextDrawHide(playerid, Handy_Telefonbuch_Suchen[playerid][1]);
	    PlayerTextDrawHide(playerid, Handy_Telefonbuch_Suchen[playerid][2]);
	    PlayerTextDrawHide(playerid, Handy_Telefonbuch_Suchen[playerid][3]);
	    PlayerTextDrawHide(playerid,HandyTelefonbuch[playerid][1]);
	    PlayerTextDrawHide(playerid,HandyCalender[playerid][1]);
	    PlayerTextDrawHide(playerid, HandyMusik[playerid][1]);
	    PlayerTextDrawHide(playerid, HandyEinstellungen[playerid][1]);
	    PlayerTextDrawShow(playerid, HandyTelefonbuchZruck[playerid]);
	    PlayerTextDrawHide(playerid, HandyZruck[playerid]);
	    PlayerTextDrawShow(playerid, HandyCalender_Monday[playerid]);
	    PlayerTextDrawShow(playerid, HandyCalender_Tuesday[playerid]);
	    PlayerTextDrawShow(playerid, HandyCalender_Wednesday[playerid]);
	    PlayerTextDrawShow(playerid, HandyCalender_Thursday[playerid]);
	    PlayerTextDrawShow(playerid, HandyCalender_Friday[playerid]);
	    PlayerTextDrawShow(playerid, HandyCalender_Saturday[playerid]);
	    PlayerTextDrawShow(playerid, HandyCalender_Sunday[playerid]);
	    PlayerTextDrawShow(playerid, HandyCalender_Monday_[playerid]);
	    PlayerTextDrawShow(playerid, HandyCalender_Tuesday_[playerid]);
	    PlayerTextDrawShow(playerid, HandyCalender_Wednesday_[playerid]);
	    PlayerTextDrawShow(playerid, HandyCalender_Thursday_[playerid]);
	    PlayerTextDrawShow(playerid, HandyCalender_Friday_[playerid]);
	    PlayerTextDrawShow(playerid, HandyCalender_Saturday_[playerid]);
	    PlayerTextDrawShow(playerid, HandyCalender_Sunday_[playerid]);
	    PlayerTextDrawShow(playerid, HandyOrt[playerid]);
	    OnPlayerClickPlayerTextDraw(playerid, HandyCalender_Monday[playerid]);
	 }
     if(playertextid == Handy_Telefonbuch_Freunde[playerid][0])
     {
		SetPVarInt(playerid, "HandyFreundeSkroll", 1);
		SetPVarInt(playerid, "HandyFreundesliste", 1);
	    PlayerTextDrawHide(playerid, HandyTelefonbuch[playerid][0]);
	    PlayerTextDrawHide(playerid, HandyTelefonbuch[playerid][0]);
	    PlayerTextDrawHide(playerid, HandyTelefonbuch[playerid][1]);
	    PlayerTextDrawHide(playerid, HandyTelefonbuch[playerid][2]);
	    PlayerTextDrawHide(playerid, HandyTelefonbuch[playerid][3]);
	    PlayerTextDrawHide(playerid, HandyTelefonbuch[playerid][4]);
	    PlayerTextDrawHide(playerid, HandyTelefonbuch[playerid][5]);
	    PlayerTextDrawHide(playerid, HandyCalender[playerid][0]);
	    PlayerTextDrawHide(playerid, HandyCalender[playerid][1]);
	    PlayerTextDrawHide(playerid, HandyCalender[playerid][2]);
	    PlayerTextDrawHide(playerid, HandyCalender[playerid][3]);
	    PlayerTextDrawHide(playerid, HandyCalender[playerid][4]);
	    PlayerTextDrawHide(playerid, HandyMusik[playerid][0]);
	    PlayerTextDrawHide(playerid, HandyMusik[playerid][1]);
	    PlayerTextDrawHide(playerid, HandyMusik[playerid][2]);
	    PlayerTextDrawHide(playerid, HandyMusik[playerid][3]);
	    PlayerTextDrawHide(playerid, HandyMusik[playerid][4]);
	    PlayerTextDrawHide(playerid, HandyMusik[playerid][5]);
	    PlayerTextDrawHide(playerid, HandyMusik[playerid][6]);
	    PlayerTextDrawHide(playerid, HandyEinstellungen[playerid][0]);
	    PlayerTextDrawHide(playerid, HandyEinstellungen[playerid][1]);
	    PlayerTextDrawHide(playerid, HandyEinstellungen[playerid][2]);
	    PlayerTextDrawHide(playerid, HandyOrt[playerid]);
	    PlayerTextDrawHide(playerid, HandyZeit[playerid]);
	    PlayerTextDrawHide(playerid, HandyZruck[playerid]);
	    PlayerTextDrawShow(playerid, HandyTelefonbuchZruck[playerid]);
	    PlayerTextDrawHide(playerid, HandyAuflegen[playerid][0]);
	    PlayerTextDrawHide(playerid, Handy_Telefonbuch_AlleK[playerid][0]);
	    PlayerTextDrawHide(playerid, Handy_Telefonbuch_AlleK[playerid][1]);
	    PlayerTextDrawHide(playerid, Handy_Telefonbuch_AlleK[playerid][2]);
	    PlayerTextDrawHide(playerid, Handy_Telefonbuch_AlleK[playerid][3]);
	    PlayerTextDrawHide(playerid, Handy_Telefonbuch_AlleK[playerid][4]);
	    PlayerTextDrawHide(playerid, Handy_Telefonbuch_Freunde[playerid][0]);
	    PlayerTextDrawHide(playerid, Handy_Telefonbuch_Freunde[playerid][1]);
	    PlayerTextDrawHide(playerid, Handy_Telefonbuch_Freunde[playerid][2]);
	    PlayerTextDrawHide(playerid, Handy_Telefonbuch_Freunde[playerid][3]);
	    PlayerTextDrawHide(playerid, Handy_Telefonbuch_Freunde[playerid][4]);
	    PlayerTextDrawHide(playerid, Handy_Telefonbuch_Freunde[playerid][5]);
	    PlayerTextDrawHide(playerid, Handy_Telefonbuch_Freunde[playerid][6]);
	    PlayerTextDrawHide(playerid, Handy_Telefonbuch_publicService[playerid][0]);
	    PlayerTextDrawHide(playerid, Handy_Telefonbuch_publicService[playerid][1]);
	    PlayerTextDrawHide(playerid, Handy_Telefonbuch_Suchen[playerid][0]);
	    PlayerTextDrawHide(playerid, Handy_Telefonbuch_Suchen[playerid][1]);
	    PlayerTextDrawHide(playerid, Handy_Telefonbuch_Suchen[playerid][2]);
	    PlayerTextDrawHide(playerid, Handy_Telefonbuch_Suchen[playerid][3]);
	    PlayerTextDrawHide(playerid,Handy_Telefonbuch_AlleK[playerid][0]);
	    PlayerTextDrawHide(playerid,Handy_Telefonbuch_AlleK[playerid][1]);
	    PlayerTextDrawHide(playerid,Handy_Telefonbuch_AlleK[playerid][2]);
	    PlayerTextDrawHide(playerid,Handy_Telefonbuch_AlleK[playerid][3]);
	    PlayerTextDrawHide(playerid,Handy_Telefonbuch_AlleK[playerid][4]);
	    PlayerTextDrawHide(playerid,Handy_Telefonbuch_Freunde[playerid][0]);
	    PlayerTextDrawHide(playerid,Handy_Telefonbuch_Freunde[playerid][1]);
	    PlayerTextDrawHide(playerid,Handy_Telefonbuch_Freunde[playerid][2]);
	    PlayerTextDrawHide(playerid,Handy_Telefonbuch_Freunde[playerid][3]);
	    PlayerTextDrawHide(playerid,Handy_Telefonbuch_Freunde[playerid][4]);
	    PlayerTextDrawHide(playerid,Handy_Telefonbuch_Freunde[playerid][5]);
	    PlayerTextDrawHide(playerid,Handy_Telefonbuch_Freunde[playerid][6]);
	    PlayerTextDrawHide(playerid,Handy_Telefonbuch_publicService[playerid][0]);
	    PlayerTextDrawHide(playerid, Handy_Telefonbuch_publicService[playerid][1]);
	    PlayerTextDrawHide(playerid, Handy_Telefonbuch_Suchen[playerid][0]);
	    PlayerTextDrawHide(playerid, Handy_Telefonbuch_Suchen[playerid][1]);
	    PlayerTextDrawHide(playerid, Handy_Telefonbuch_Suchen[playerid][2]);
	    PlayerTextDrawHide(playerid, Handy_Telefonbuch_Suchen[playerid][3]);
	    PlayerTextDrawHide(playerid,HandyTelefonbuch[playerid][1]);
	    PlayerTextDrawHide(playerid,HandyCalender[playerid][1]);
	    PlayerTextDrawHide(playerid, HandyMusik[playerid][1]);
	    PlayerTextDrawHide(playerid, HandyEinstellungen[playerid][1]);
	    PlayerTextDrawShow(playerid, HandyTelefonbuchZruck[playerid]);
	    PlayerTextDrawHide(playerid, HandyZruck[playerid]);
	    PlayerTextDrawShow(playerid, HandyCalender_Monday[playerid]);
	    PlayerTextDrawShow(playerid, HandyCalender_Tuesday[playerid]);
	    PlayerTextDrawShow(playerid, HandyCalender_Wednesday[playerid]);
	    PlayerTextDrawShow(playerid, HandyCalender_Thursday[playerid]);
	    PlayerTextDrawShow(playerid, HandyCalender_Friday[playerid]);
	    PlayerTextDrawShow(playerid, HandyCalender_Saturday[playerid]);
	    PlayerTextDrawShow(playerid, HandyCalender_Sunday[playerid]);
	    PlayerTextDrawShow(playerid, HandyCalender_Monday_[playerid]);
	    PlayerTextDrawShow(playerid, HandyCalender_Tuesday_[playerid]);
	    PlayerTextDrawShow(playerid, HandyCalender_Wednesday_[playerid]);
	    PlayerTextDrawShow(playerid, HandyCalender_Thursday_[playerid]);
	    PlayerTextDrawShow(playerid, HandyCalender_Friday_[playerid]);
	    PlayerTextDrawShow(playerid, HandyCalender_Saturday_[playerid]);
	    PlayerTextDrawShow(playerid, HandyCalender_Sunday_[playerid]);
	    PlayerTextDrawShow(playerid, HandyOrt[playerid]);
	    OnPlayerClickPlayerTextDraw(playerid, HandyCalender_Monday[playerid]);
	    PlayerTextDrawSetString(playerid, HandyCalender_Monday_[playerid], "           Up");
	    PlayerTextDrawSetString(playerid, HandyCalender_Sunday_[playerid], "          Down");
	 }
     if(playertextid == HandyCallContact_[playerid])
     {
	    /*PlayerTextDrawSetString(playerid, HandyTelefonbuch[playerid][1], "Phonebook");
	    PlayerTextDrawSetString(playerid, HandyCalender[playerid][1], "Calender");
	    PlayerTextDrawSetString(playerid, HandyMusik[playerid][1], "Music");
	    PlayerTextDrawSetString(playerid, HandyEinstellungen[playerid][1], "Settings");
	    PlayerTextDrawHide(playerid, HandyTelefonbuch[playerid][0]);
	    PlayerTextDrawHide(playerid, HandyTelefonbuch[playerid][1]);
	    PlayerTextDrawHide(playerid, HandyTelefonbuch[playerid][2]);
	    PlayerTextDrawHide(playerid, HandyTelefonbuch[playerid][3]);
	    PlayerTextDrawHide(playerid, HandyTelefonbuch[playerid][4]);
	    PlayerTextDrawHide(playerid, HandyTelefonbuch[playerid][5]);
	    PlayerTextDrawHide(playerid, HandyCalender[playerid][0]);
	    PlayerTextDrawHide(playerid, HandyCalender[playerid][1]);
	    PlayerTextDrawHide(playerid, HandyCalender[playerid][2]);
	    PlayerTextDrawHide(playerid, HandyCalender[playerid][3]);
	    PlayerTextDrawHide(playerid, HandyCalender[playerid][4]);
	    PlayerTextDrawHide(playerid, HandyMusik[playerid][0]);
	    PlayerTextDrawHide(playerid, HandyMusik[playerid][1]);
	    PlayerTextDrawHide(playerid, HandyMusik[playerid][2]);
	    PlayerTextDrawHide(playerid, HandyMusik[playerid][3]);
	    PlayerTextDrawHide(playerid, HandyMusik[playerid][4]);
	    PlayerTextDrawHide(playerid, HandyMusik[playerid][5]);
	    PlayerTextDrawHide(playerid, HandyMusik[playerid][6]);
	    PlayerTextDrawHide(playerid, HandyEinstellungen[playerid][0]);
	    PlayerTextDrawHide(playerid, HandyEinstellungen[playerid][1]);
	    PlayerTextDrawHide(playerid, HandyEinstellungen[playerid][2]);
	    PlayerTextDrawHide(playerid, HandyZruck[playerid]);
	    PlayerTextDrawHide(playerid, HandyCalender_Monday[playerid]);
	    PlayerTextDrawHide(playerid, HandyCalender_Tuesday[playerid]);
	    PlayerTextDrawHide(playerid, HandyCalender_Wednesday[playerid]);
	    PlayerTextDrawHide(playerid, HandyCalender_Thursday[playerid]);
	    PlayerTextDrawHide(playerid, HandyCalender_Friday[playerid]);
	    PlayerTextDrawHide(playerid, HandyCalender_Saturday[playerid]);
	    PlayerTextDrawHide(playerid, HandyCalender_Sunday[playerid]);
	    PlayerTextDrawHide(playerid, HandyCalender_Monday_[playerid]);
	    PlayerTextDrawHide(playerid, HandyCalender_Tuesday_[playerid]);
	    PlayerTextDrawHide(playerid, HandyCalender_Wednesday_[playerid]);
	    PlayerTextDrawHide(playerid, HandyCalender_Thursday_[playerid]);
	    PlayerTextDrawHide(playerid, HandyCalender_Friday_[playerid]);
	    PlayerTextDrawHide(playerid, HandyCalender_Saturday_[playerid]);
	    PlayerTextDrawHide(playerid, HandyCalender_Sunday_[playerid]);
	    PlayerTextDrawHide(HandyCalling[playerid], Handy_Telefonbuch_AlleK[playerid][0]);
	    PlayerTextDrawHide(HandyCalling[playerid], Handy_Telefonbuch_AlleK[playerid][1]);
	    PlayerTextDrawHide(HandyCalling[playerid], Handy_Telefonbuch_AlleK[playerid][2]);
	    PlayerTextDrawHide(HandyCalling[playerid], Handy_Telefonbuch_AlleK[playerid][3]);
	    PlayerTextDrawHide(HandyCalling[playerid], Handy_Telefonbuch_AlleK[playerid][4]);
	    PlayerTextDrawHide(HandyCalling[playerid], Handy_Telefonbuch_Freunde[playerid][0]);
	    PlayerTextDrawHide(HandyCalling[playerid], Handy_Telefonbuch_Freunde[playerid][1]);
	    PlayerTextDrawHide(HandyCalling[playerid], Handy_Telefonbuch_Freunde[playerid][2]);
	    PlayerTextDrawHide(HandyCalling[playerid], Handy_Telefonbuch_Freunde[playerid][3]);
	    PlayerTextDrawHide(HandyCalling[playerid], Handy_Telefonbuch_Freunde[playerid][4]);
	    PlayerTextDrawHide(HandyCalling[playerid], Handy_Telefonbuch_Freunde[playerid][5]);
	    PlayerTextDrawHide(HandyCalling[playerid], Handy_Telefonbuch_Freunde[playerid][6]);
	    PlayerTextDrawHide(HandyCalling[playerid], Handy_Telefonbuch_MeiNummer[playerid][0]);
	    PlayerTextDrawHide(HandyCalling[playerid], Handy_Telefonbuch_MeiNummer[playerid][1]);
	    PlayerTextDrawHide(HandyCalling[playerid], Handy_Telefonbuch_Suchen[playerid][0]);
	    PlayerTextDrawHide(HandyCalling[playerid], Handy_Telefonbuch_Suchen[playerid][1]);
	    PlayerTextDrawHide(HandyCalling[playerid], Handy_Telefonbuch_Suchen[playerid][2]);
	    PlayerTextDrawHide(HandyCalling[playerid], Handy_Telefonbuch_Suchen[playerid][3]);
	    PlayerTextDrawHide(HandyCalling[playerid], HandyTonEinstellungen[playerid][0]);
	    PlayerTextDrawHide(HandyCalling[playerid], HandyTonEinstellungen[playerid][1]);
	    PlayerTextDrawHide(HandyCalling[playerid], HandyTonEinstellungen[playerid][2]);
	    PlayerTextDrawHide(HandyCalling[playerid], HandyTonEinstellungen[playerid][3]);
	    PlayerTextDrawHide(HandyCalling[playerid], HandyNachrichtenton[playerid]);
	    PlayerTextDrawHide(HandyCalling[playerid], HandyNachrichtenton1[playerid]);
	    PlayerTextDrawHide(HandyCalling[playerid], HandyNachrichtenton2[playerid]);
	    PlayerTextDrawHide(HandyCalling[playerid], HandyNachrichtenton3[playerid]);
	    PlayerTextDrawHide(HandyCalling[playerid], HandyNachrichtenton1_[playerid]);
	    PlayerTextDrawHide(HandyCalling[playerid], HandyNachrichtenton2_[playerid]);
	    PlayerTextDrawHide(HandyCalling[playerid], HandyNachrichtenton3_[playerid]);
	    PlayerTextDrawHide(HandyCalling[playerid], HandyKlingelton[playerid]);
	    PlayerTextDrawHide(HandyCalling[playerid], HandyKlingelton1[playerid]);
	    PlayerTextDrawHide(HandyCalling[playerid], HandyKlingelton2[playerid]);
	    PlayerTextDrawHide(HandyCalling[playerid], HandyKlingelton3[playerid]);
	    PlayerTextDrawHide(HandyCalling[playerid], HandyKlingelton1_[playerid]);
	    PlayerTextDrawHide(HandyCalling[playerid], HandyKlingelton2_[playerid]);
	    PlayerTextDrawHide(HandyCalling[playerid], HandyKlingelton3_[playerid]);
	    PlayerTextDrawHide(HandyCalling[playerid], HandyMute[playerid][0]);
	    PlayerTextDrawHide(HandyCalling[playerid], HandyMute[playerid][1]);
	    PlayerTextDrawHide(HandyCalling[playerid], HandyMute[playerid][2]);
	    PlayerTextDrawHide(HandyCalling[playerid], HandyMute[playerid][3]);
	    PlayerTextDrawHide(HandyCalling[playerid], HandyMute[playerid][4]);*/

	    new string[50];
	    format(string, sizeof string, "calling~n~%s...", GetSname(HandyCalling[playerid]));
	    PlayerTextDrawSetString(playerid, HandyAngerufen[playerid][3], string);
	    PlayerTextDrawHide(playerid, HandyZeit[playerid]);
	    PlayerTextDrawHide(playerid, HandyOrt[playerid]);
	    PlayerTextDrawShow(playerid, HandyAngerufen[playerid][0]);
	    PlayerTextDrawShow(playerid, HandyAngerufen[playerid][1]);
	    PlayerTextDrawShow(playerid, HandyAngerufen[playerid][2]);
	    PlayerTextDrawShow(playerid, HandyAngerufen[playerid][3]);
	    PlayerTextDrawShow(playerid, HandyAuflegen[playerid][0]);
	    PlayerTextDrawHide(playerid, HandyTelefonbuchZruck[playerid]);
	    PlayerTextDrawHide(playerid, HandyCallContact[playerid]);
	    PlayerTextDrawHide(playerid, HandyCallContact_[playerid]);
	    PlayerTextDrawHide(playerid, HandyAddFriendContact[playerid]);
	    PlayerTextDrawHide(playerid, HandyAddFriendContact_[playerid]);
	    PlayerTextDrawHide(playerid, HandyKontaktProfilFarbe[playerid]);
	    PlayerTextDrawHide(playerid, HandyKontaktProfilBild[playerid]);
	    PlayerTextDrawHide(playerid, HandyInfo_Nummer[playerid]);
	    PlayerTextDrawHide(playerid, HandyInfo_Status[playerid]);
		format(Spieler, sizeof Spieler, "/Spieler/%s.txt", GetSname(HandyCalling[playerid]));
		if (!strcmp(dini_Get(Spieler, "HandyTon"), "Aus"))
		{
	         SetTimerEx("EndCallBecauseError", 4500, false, "%i, %i", playerid, 1);
	         PlayerTextDrawSetSelectable(HandyCaller[playerid], HandyAuflegen[playerid][0], 0);
	         PlayerTextDrawShow(HandyCaller[playerid], HandyAuflegen[playerid][0]);
	         return 1;
		}
		if (GetPVarInt(HandyCalling[playerid], "HandyAnrufState") == 2 || GetPVarInt(HandyCalling[playerid], "HandyAnrufState") == 1/* && HandyCaller[playerid] != playerid*/)
		{
	         SetTimerEx("EndCallBecauseError", 4500, false, "%i, %i", playerid, 2);
	         PlayerTextDrawSetSelectable(HandyCaller[playerid], HandyAuflegen[playerid][0], 0);
	         PlayerTextDrawShow(HandyCaller[playerid], HandyAuflegen[playerid][0]);
	         return 1;
		}
		WaitForCallingTimer = SetTimerEx("WaitForCalling", 20000, false, "%i", playerid);
		
        SetPVarInt(HandyCaller[playerid], "HandyAnrufState", 1);
        SetPVarInt(HandyCalling[playerid], "HandyAnrufState", 1);
	    PlayerTextDrawShow(HandyCalling[playerid],Handy[playerid]);
	    PlayerTextDrawShow(HandyCalling[playerid],HandyBildschirm[playerid]);
	    PlayerTextDrawShow(HandyCalling[playerid],HandyPlatzhalter[playerid]);
	    PlayerTextDrawShow(HandyCalling[playerid],HandyAnrufen[playerid][0]);
	    PlayerTextDrawShow(HandyCalling[playerid],HandyAnrufen[playerid][1]);
	    PlayerTextDrawShow(HandyCalling[playerid],HandyAnrufen[playerid][2]);
	    PlayerTextDrawShow(HandyCalling[playerid],HandyAuflegen[playerid][0]);
	    PlayerTextDrawShow(HandyCalling[playerid],HandyAuflegen[playerid][1]);
	    PlayerTextDrawShow(HandyCalling[playerid],HandyAuflegen[playerid][2]);
	    PlayerTextDrawShow(HandyCalling[playerid],HandyTasten[playerid][0]);
	    PlayerTextDrawShow(HandyCalling[playerid],HandyTasten[playerid][1]);
	    PlayerTextDrawShow(HandyCalling[playerid],HandyTasten[playerid][2]);
	    PlayerTextDrawShow(HandyCalling[playerid],HandyTasten[playerid][3]);
	    PlayerTextDrawShow(HandyCalling[playerid],HandyTasten[playerid][4]);
	    PlayerTextDrawShow(HandyCalling[playerid],HandyTasten[playerid][5]);
	    PlayerTextDrawShow(HandyCalling[playerid],HandyTasten[playerid][6]);
	    PlayerTextDrawShow(HandyCalling[playerid],HandyTasten[playerid][7]);
	    PlayerTextDrawShow(HandyCalling[playerid],HandyTasten[playerid][8]);
	    PlayerTextDrawShow(HandyCalling[playerid],HandyTasten[playerid][9]);
	    PlayerTextDrawShow(HandyCalling[playerid],HandyTasten[playerid][10]);
	    PlayerTextDrawShow(HandyCalling[playerid],HandyTasten[playerid][11]);
	    PlayerTextDrawShow(HandyCalling[playerid],HandyTasten[playerid][12]);
	    PlayerTextDrawShow(HandyCalling[playerid],HandyTasten[playerid][13]);
	    PlayerTextDrawShow(HandyCalling[playerid],HandyTasten[playerid][14]);
	    PlayerTextDrawShow(HandyCalling[playerid],HandyTasten[playerid][15]);
	    PlayerTextDrawShow(HandyCalling[playerid],HandyTasten[playerid][16]);
	    PlayerTextDrawShow(HandyCalling[playerid],HandyTasten[playerid][17]);
	    PlayerTextDrawShow(HandyCalling[playerid],HandyTasten[playerid][18]);
	    PlayerTextDrawShow(HandyCalling[playerid],HandyTasten[playerid][19]);
	    PlayerTextDrawShow(HandyCalling[playerid],HandyTasten[playerid][20]);
	    PlayerTextDrawShow(HandyCalling[playerid],HandyTasten[playerid][21]);
	    PlayerTextDrawShow(HandyCalling[playerid],HandyTasten[playerid][22]);
	    PlayerTextDrawShow(HandyCalling[playerid],HandyTasten[playerid][23]);
	    PlayerTextDrawShow(HandyCalling[playerid],HandyTasten[playerid][24]);
	    PlayerTextDrawShow(HandyCalling[playerid],HandyTasten[playerid][25]);
	    PlayerTextDrawShow(HandyCalling[playerid],HandyTasten[playerid][26]);
	    PlayerTextDrawShow(HandyCalling[playerid],HandyTasten[playerid][27]);
	    PlayerTextDrawShow(HandyCalling[playerid],HandyTasten[playerid][28]);
	    PlayerTextDrawShow(HandyCalling[playerid],HandyTasten[playerid][29]);
	    PlayerTextDrawShow(HandyCalling[playerid],HandyHome[playerid][0]);
	    PlayerTextDrawShow(HandyCalling[playerid],HandyHome[playerid][1]);
	    PlayerTextDrawShow(HandyCalling[playerid],HandyHome[playerid][2]);
	    PlayerTextDrawShow(HandyCalling[playerid],HandyAngerufen[playerid][0]);
	    PlayerTextDrawShow(HandyCalling[playerid],HandyAngerufen[playerid][1]);
	    PlayerTextDrawShow(HandyCalling[playerid],HandyAngerufen[playerid][2]);
	    PlayerTextDrawShow(HandyCalling[playerid],HandyAngerufen[playerid][3]);
	    HandyCaller[HandyCalling[playerid]] = playerid;
	    format(string, sizeof string, "%s~n~is calling you!", GetSname(playerid));
	    PlayerTextDrawSetString(HandyCalling[playerid], HandyAngerufen[playerid][3], string);
		PlayerPlaySound(HandyCalling[playerid], dini_Int(Spieler, "Klingelton"), 0, 0, 0);
	    SelectTextDraw(HandyCalling[playerid], 0x000000AB);
	    HandyShowing[HandyCalling[playerid]] = 2;
	    HandyShowing[HandyCaller[playerid]] = 2;
	 }
     if(playertextid == HandyKlingelton1[playerid])
     {
		PlayerPlaySound(playerid, 20600, 0.0, 0.0, 0.0);
        format(Spieler,sizeof(Spieler),"/Spieler/%s.txt",GetSname(playerid));
        dini_IntSet(Spieler,"Klingelton", 20600);
        PlayerTextDrawColor(playerid, HandyKlingelton1[playerid], Hellgrün);
        PlayerTextDrawColor(playerid, HandyKlingelton2[playerid], 255);
        PlayerTextDrawColor(playerid, HandyKlingelton3[playerid], 255);
        PlayerTextDrawShow(playerid, HandyKlingelton1[playerid]);
        PlayerTextDrawShow(playerid, HandyKlingelton2[playerid]);
        PlayerTextDrawShow(playerid, HandyKlingelton3[playerid]);
	    return 1;
     }
     if(playertextid == HandyKlingelton2[playerid])
     {
        PlayerPlaySound(playerid, 20804, 0.0, 0.0, 0.0);
        format(Spieler,sizeof(Spieler),"/Spieler/%s.txt",GetSname(playerid));
        dini_IntSet(Spieler,"Klingelton", 20804);
        PlayerTextDrawColor(playerid, HandyKlingelton2[playerid], Hellgrün);
        PlayerTextDrawColor(playerid, HandyKlingelton1[playerid], 255);
        PlayerTextDrawColor(playerid, HandyKlingelton3[playerid], 255);
        PlayerTextDrawShow(playerid, HandyKlingelton1[playerid]);
        PlayerTextDrawShow(playerid, HandyKlingelton2[playerid]);
        PlayerTextDrawShow(playerid, HandyKlingelton3[playerid]);
        return 1;
     }
     if(playertextid == HandyKlingelton3[playerid])
     {
        PlayerPlaySound(playerid, 23000, 0.0, 0.0, 0.0);
        format(Spieler,sizeof(Spieler),"/Spieler/%s.txt",GetSname(playerid));
        dini_IntSet(Spieler,"Klingelton", 23000);
        PlayerTextDrawColor(playerid, HandyKlingelton3[playerid], Hellgrün);
        PlayerTextDrawColor(playerid, HandyKlingelton2[playerid], 255);
        PlayerTextDrawColor(playerid, HandyKlingelton1[playerid], 255);
        PlayerTextDrawShow(playerid, HandyKlingelton1[playerid]);
        PlayerTextDrawShow(playerid, HandyKlingelton2[playerid]);
        PlayerTextDrawShow(playerid, HandyKlingelton3[playerid]);
        return 1;
     }
     if(playertextid == HandyNachrichtenton1[playerid])
     {
        PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
        format(Spieler,sizeof(Spieler),"/Spieler/%s.txt",GetSname(playerid));
        dini_IntSet(Spieler,"Nachrichtenton", 1058);
        PlayerTextDrawColor(playerid, HandyNachrichtenton1[playerid], Hellgrün);
        PlayerTextDrawColor(playerid, HandyNachrichtenton2[playerid], 255);
        PlayerTextDrawColor(playerid, HandyNachrichtenton3[playerid], 255);
        PlayerTextDrawShow(playerid, HandyNachrichtenton1[playerid]);
        PlayerTextDrawShow(playerid, HandyNachrichtenton2[playerid]);
        PlayerTextDrawShow(playerid, HandyNachrichtenton3[playerid]);
	    return 1;
     }
     if(playertextid == HandyNachrichtenton2[playerid])
     {
        PlayerPlaySound(playerid, 45400, 0.0, 0.0, 0.0);
        format(Spieler,sizeof(Spieler),"/Spieler/%s.txt",GetSname(playerid));
        dini_IntSet(Spieler,"Nachrichtenton", 45400);
        PlayerTextDrawColor(playerid, HandyNachrichtenton2[playerid], Hellgrün);
        PlayerTextDrawColor(playerid, HandyNachrichtenton1[playerid], 255);
        PlayerTextDrawColor(playerid, HandyNachrichtenton3[playerid], 255);
        PlayerTextDrawShow(playerid, HandyNachrichtenton2[playerid]);
        PlayerTextDrawShow(playerid, HandyNachrichtenton1[playerid]);
        PlayerTextDrawShow(playerid, HandyNachrichtenton3[playerid]);
        return 1;
     }
     if(playertextid == HandyNachrichtenton3[playerid])
     {
        PlayerPlaySound(playerid, 39602, 0.0, 0.0, 0.0);
        format(Spieler,sizeof(Spieler),"/Spieler/%s.txt",GetSname(playerid));
        dini_IntSet(Spieler,"Nachrichtenton", 39602);
        PlayerTextDrawColor(playerid, HandyNachrichtenton3[playerid], Hellgrün);
        PlayerTextDrawColor(playerid, HandyNachrichtenton1[playerid], 255);
        PlayerTextDrawColor(playerid, HandyNachrichtenton2[playerid], 255);
        PlayerTextDrawShow(playerid, HandyNachrichtenton1[playerid]);
        PlayerTextDrawShow(playerid, HandyNachrichtenton2[playerid]);
        PlayerTextDrawShow(playerid, HandyNachrichtenton3[playerid]);
        return 1;
     }
     if(playertextid == HandyMute[playerid][0])
     {
		format(Spieler, sizeof Spieler, "/Spieler/%s.txt", GetSname(playerid));
        if (!strcmp(dini_Get(Spieler, "HandyTon"), "Aus"))
        {
		  PlayerTextDrawSetString(playerid,PlayerText:HandyMute[playerid][2], ")))");
		  dini_Set(Spieler,"HandyTon","Ein");
	    }
	    else if (!strcmp(dini_Get(Spieler, "HandyTon"), "Ein"))
	    {
		  PlayerTextDrawSetString(playerid,PlayerText:HandyMute[playerid][2], "x");
		  dini_Set(Spieler,"HandyTon","Aus");
	    }
        return 1;
     }
     if(playertextid == HandyMusikApp[playerid][7])
     {
		format(Spieler, sizeof Spieler, "/Spieler/%s.txt", GetSname(playerid));
        if (!strcmp(dini_Get(Spieler, "HandyliedReplay"), "Aus"))
        {
		  PlayerTextDrawSetString(playerid, HandyMusikApp[playerid][15], "x");
		  dini_Set(Spieler,"HandyliedReplay","Ein");
	    }
	    else if (!strcmp(dini_Get(Spieler, "HandyliedReplay"), "Ein"))
	    {
		  PlayerTextDrawSetString(playerid, HandyMusikApp[playerid][15], "");
		  dini_Set(Spieler,"HandyliedReplay","Aus");
	    }
        return 1;
     }
     if(playertextid == HandyMusikApp[playerid][0])
     {
		format(Spieler, sizeof Spieler, "/Spieler/%s.txt", GetSname(playerid));
        if (!strcmp(dini_Get(Spieler, "Handylied"), "1"))
        {
		  dini_Set(Spieler,"Handylied","8");
		  PlayerTextDrawSetString(playerid, HandyMusikApp[playerid][5], "You_can_always_go_around");
		  PlayerTextDrawSetString(playerid, HandyMusikApp[playerid][4], "Swiss001");
	    }
        else if (!strcmp(dini_Get(Spieler, "Handylied"), "2"))
        {
		  dini_Set(Spieler,"Handylied","1");
		  PlayerTextDrawSetString(playerid, HandyMusikApp[playerid][5], "Boulevard_of_broken_Dreams");
		  PlayerTextDrawSetString(playerid, HandyMusikApp[playerid][4], "BigSmoke_feat_Flying_Kitty");
	    }
        else if (!strcmp(dini_Get(Spieler, "Handylied"), "3"))
        {
		  dini_Set(Spieler,"Handylied","2");
		  PlayerTextDrawSetString(playerid, HandyMusikApp[playerid][5], "What_is_cheese");
		  PlayerTextDrawSetString(playerid, HandyMusikApp[playerid][4], "BigSmoke_feat_Flying_Kitty");
	    }
        else if (!strcmp(dini_Get(Spieler, "Handylied"), "4"))
        {
		  dini_Set(Spieler,"Handylied","3");
		  PlayerTextDrawSetString(playerid, HandyMusikApp[playerid][5], "Lets_go_Bowling");
		  PlayerTextDrawSetString(playerid, HandyMusikApp[playerid][4], "Niko_and_Roman_feat_Flying_Kitty");
	    }
        else if (!strcmp(dini_Get(Spieler, "Handylied"), "5"))
        {
		  dini_Set(Spieler,"Handylied","4");
		  PlayerTextDrawSetString(playerid, HandyMusikApp[playerid][5], "Hey_now,_you're_a_CJ");
		  PlayerTextDrawSetString(playerid, HandyMusikApp[playerid][4], "BigSmoke_feat_Flying_Kitty");
	    }
        else if (!strcmp(dini_Get(Spieler, "Handylied"), "6"))
        {
		  dini_Set(Spieler,"Handylied","5");
		  PlayerTextDrawSetString(playerid, HandyMusikApp[playerid][5], "Never_gonna_follow_that_train");
		  PlayerTextDrawSetString(playerid, HandyMusikApp[playerid][4], "BigSmoke_feat_Flying_Kitty");
	    }
        else if (!strcmp(dini_Get(Spieler, "Handylied"), "7"))
        {
		  dini_Set(Spieler,"Handylied","6");
		  PlayerTextDrawSetString(playerid, HandyMusikApp[playerid][5], "I'm_in_love_with_the_train");
		  PlayerTextDrawSetString(playerid, HandyMusikApp[playerid][4], "BigSmoke_feat_Flying_Kitty");
	    }
        else if (!strcmp(dini_Get(Spieler, "Handylied"), "8"))
        {
		  dini_Set(Spieler,"Handylied","7");
		  PlayerTextDrawSetString(playerid, HandyMusikApp[playerid][5], "Just_another_order");
		  PlayerTextDrawSetString(playerid, HandyMusikApp[playerid][4], "BigSmoke_feat_Flying_Kitty");
	    }
        return 1;
     }
     if(playertextid == HandyMusikApp[playerid][1])
     {
		StopAudioStreamForPlayer(playerid);
		KillTimer(Handyliedtimer);
        return 1;
     }
     if(playertextid == HandyMusikApp[playerid][2])
     {
		KillTimer(Handyliedtimer);
		format(Spieler, sizeof Spieler, "/Spieler/%s.txt", GetSname(playerid));
        if (!strcmp(dini_Get(Spieler, "Handylied"), "2"))
        {
		  StopAudioStreamForPlayer(playerid);
		  PlayAudioStreamForPlayer(playerid, "https://www.dropbox.com/s/abxfdn3nnwwpibh/What_is_Cheese.mp3?dl=1");
		  Handyliedtimer = SetTimerEx("Handyliedplayer", 113000, false, "%i", playerid);//bei 2 minuten müssen 7000 ms abgezogen werden
		  return 1;
	    }
        else if (!strcmp(dini_Get(Spieler, "Handylied"), "3"))
        {
		  StopAudioStreamForPlayer(playerid);
		  PlayAudioStreamForPlayer(playerid, "https://www.dropbox.com/s/8oglex2upqgt5hh/Lets_Go_Bowling.mp3?dl=1");//2min 45s ohne buffer
		  //Handyliedtimer = SetTimerEx("Handyliedplayer", 165000 /*155375*/, false, "%i", playerid);//2625 +7000 ms müssen abgezogen werden
		  return 1;
	    }
        else if (!strcmp(dini_Get(Spieler, "Handylied"), "4"))
        {
		  StopAudioStreamForPlayer(playerid);
		  PlayAudioStreamForPlayer(playerid, "https://www.dropbox.com/s/mks5et7tdcdhre6/Hey_Now__You%27re_a_CJ.mp3?dl=1");
		  Handyliedtimer = SetTimerEx("Handyliedplayer", 1000, false, "%i", playerid);
		  return 1;
	    }
        else if (!strcmp(dini_Get(Spieler, "Handylied"), "5"))
        {
		  StopAudioStreamForPlayer(playerid);
		  PlayAudioStreamForPlayer(playerid, "https://www.dropbox.com/s/l5y3jdcdjsznuw0/0Never_Gonna_Follow_That_Train.mp3?dl=1");
		  Handyliedtimer = SetTimerEx("Handyliedplayer", 1000, false, "%i", playerid);
		  return 1;
	    }
        else if (!strcmp(dini_Get(Spieler, "Handylied"), "6"))
        {
		  StopAudioStreamForPlayer(playerid);
		  PlayAudioStreamForPlayer(playerid, "https://www.dropbox.com/s/6gt9k4ifpenp6ov/I%27m_In_Love_With_The_Damn_Train.mp3?dl=1");
		  Handyliedtimer = SetTimerEx("Handyliedplayer", 1000, false, "%i", playerid);
		  return 1;
	    }
        else if (!strcmp(dini_Get(Spieler, "Handylied"), "7"))
        {
		  StopAudioStreamForPlayer(playerid);
		  PlayAudioStreamForPlayer(playerid, "https://www.dropbox.com/s/hv6evsn8pjduovx/Just_Another_Order.mp3?dl=1");
		  Handyliedtimer = SetTimerEx("Handyliedplayer", 1000, false, "%i", playerid);
		  return 1;
	    }
        else if (!strcmp(dini_Get(Spieler, "Handylied"), "8"))
        {
		  StopAudioStreamForPlayer(playerid);
		  PlayAudioStreamForPlayer(playerid, "https://www.dropbox.com/s/nkw6xc7mc3nyyus/The_Missile_Knows_Where_it_is_%28Remix%29.mp3?dl=1");
		  Handyliedtimer = SetTimerEx("Handyliedplayer", 1000, false, "%i", playerid);
		  return 1;
	    }
        else if (!strcmp(dini_Get(Spieler, "Handylied"), "1"))
        {
		  StopAudioStreamForPlayer(playerid);
		  PlayAudioStreamForPlayer(playerid, "https://www.dropbox.com/s/k6o74t28jroeq0y/Boulevard_of_Smoke_n_Cheese.mp3?dl=1");
		  Handyliedtimer = SetTimerEx("Handyliedplayer", 1000, false, "%i", playerid);
		  return 1;
	    }
        return 1;
     }
     if(playertextid == HandyMusikApp[playerid][3])
     {
		format(Spieler, sizeof Spieler, "/Spieler/%s.txt", GetSname(playerid));
        if (!strcmp(dini_Get(Spieler, "Handylied"), "1"))
        {
		  dini_Set(Spieler,"Handylied","2");
		  PlayerTextDrawSetString(playerid, HandyMusikApp[playerid][5], "What_is_cheese");
		  PlayerTextDrawSetString(playerid, HandyMusikApp[playerid][4], "BigSmoke_feat_Flying_Kitty");
	    }
        else if (!strcmp(dini_Get(Spieler, "Handylied"), "2"))
        {
		  dini_Set(Spieler,"Handylied","3");
		  PlayerTextDrawSetString(playerid, HandyMusikApp[playerid][5], "Lets_go_Bowling");
		  PlayerTextDrawSetString(playerid, HandyMusikApp[playerid][4], "Niko_and_Roman_feat_Flying_Kitty");
	    }
        else if (!strcmp(dini_Get(Spieler, "Handylied"), "3"))
        {
		  dini_Set(Spieler,"Handylied","4");
		  PlayerTextDrawSetString(playerid, HandyMusikApp[playerid][5], "Hey_now,_you're_a_CJ");
		  PlayerTextDrawSetString(playerid, HandyMusikApp[playerid][4], "BigSmoke_feat_Flying_Kitty");
	    }
        else if (!strcmp(dini_Get(Spieler, "Handylied"), "4"))
        {
		  dini_Set(Spieler,"Handylied","5");
		  PlayerTextDrawSetString(playerid, HandyMusikApp[playerid][5], "Never_gonna_follow_that_train");
		  PlayerTextDrawSetString(playerid, HandyMusikApp[playerid][4], "BigSmoke_feat_Flying_Kitty");
	    }
        else if (!strcmp(dini_Get(Spieler, "Handylied"), "5"))
        {
		  dini_Set(Spieler,"Handylied","6");
		  PlayerTextDrawSetString(playerid, HandyMusikApp[playerid][5], "I'm_in_love_with_the_train");
		  PlayerTextDrawSetString(playerid, HandyMusikApp[playerid][4], "BigSmoke_feat_Flying_Kitty");
	    }
        else if (!strcmp(dini_Get(Spieler, "Handylied"), "6"))
        {
		  dini_Set(Spieler,"Handylied","7");
		  PlayerTextDrawSetString(playerid, HandyMusikApp[playerid][5], "Just_another_order");
		  PlayerTextDrawSetString(playerid, HandyMusikApp[playerid][4], "BigSmoke_feat_Flying_Kitty");
	    }
        else if (!strcmp(dini_Get(Spieler, "Handylied"), "7"))
        {
		  dini_Set(Spieler,"Handylied","8");
		  PlayerTextDrawSetString(playerid, HandyMusikApp[playerid][5], "You_can_always_go_around");
		  PlayerTextDrawSetString(playerid, HandyMusikApp[playerid][4], "Swiss001");
	    }
        else if (!strcmp(dini_Get(Spieler, "Handylied"), "8"))
        {
		  dini_Set(Spieler,"Handylied","1");
		  PlayerTextDrawSetString(playerid, HandyMusikApp[playerid][5], "Boulevard_of_broken_Dreams");
		  PlayerTextDrawSetString(playerid, HandyMusikApp[playerid][4], "BigSmoke_feat_Flying_Kitty");
	    }
        return 1;
     }
	 return 0;
}

forward Handyliedplayer(playerid);
public Handyliedplayer(playerid)
{
	    SendClientMessage(playerid, Weis, "Nächstes Lied!");
	    StopAudioStreamForPlayer(playerid);
		format(Spieler, sizeof Spieler, "/Spieler/%s.txt", GetSname(playerid));
	    if (!strcmp(dini_Get(Spieler, "HandyliedReplay"), "Aus"))
		{
		     OnPlayerClickPlayerTextDraw(playerid, HandyMusikApp[playerid][3]);
	         OnPlayerClickPlayerTextDraw(playerid, HandyMusikApp[playerid][2]);
	         return 0;
		}
	    OnPlayerClickPlayerTextDraw(playerid, HandyMusikApp[playerid][2]);
	    return 0;
}

stock OpenFreundHandy(playerid, tastenid) //tastenid 1-5
{
   new string[50];
   format(string, sizeof string, "Freund_%i", tastenid+5*GetPVarInt(playerid, "HandyFreundeSkroll"));
   format(Spieler, sizeof Spieler, "/Spieler/%s.txt", GetSname(playerid));
   format(string, sizeof string, "%s", dini_Get(Spieler, string));
   SendClientMessage(playerid, Weis, string);
   format(Spieler, sizeof Spieler, "/Spieler/%s.txt", string);
   SetPVarInt(playerid, "HandyFreundesliste", 2);
	    PlayerTextDrawHide(playerid,HandyCalender_Monday[playerid]);
	    PlayerTextDrawHide(playerid,HandyCalender_Tuesday[playerid]);
	    PlayerTextDrawHide(playerid,HandyCalender_Wednesday[playerid]);
	    PlayerTextDrawHide(playerid,HandyCalender_Thursday[playerid]);
	    PlayerTextDrawHide(playerid,HandyCalender_Friday[playerid]);
	    PlayerTextDrawHide(playerid,HandyCalender_Saturday[playerid]);
	    PlayerTextDrawHide(playerid,HandyCalender_Sunday[playerid]);
	    PlayerTextDrawHide(playerid,HandyCalender_Monday_[playerid]);
	    PlayerTextDrawHide(playerid,HandyCalender_Tuesday_[playerid]);
	    PlayerTextDrawHide(playerid,HandyCalender_Wednesday_[playerid]);
	    PlayerTextDrawHide(playerid,HandyCalender_Thursday_[playerid]);
	    PlayerTextDrawHide(playerid,HandyCalender_Friday_[playerid]);
	    PlayerTextDrawHide(playerid,HandyCalender_Saturday_[playerid]);
	    PlayerTextDrawHide(playerid,HandyCalender_Sunday_[playerid]);
	    format(string, sizeof string, "Number: %s", dini_Get(Spieler, "Telefonnummer"));
	    PlayerTextDrawSetString(playerid, HandyInfo_Nummer[playerid], string);
	    PlayerTextDrawShow(playerid, HandyInfo_Nummer[playerid]);
	    PlayerTextDrawShow(playerid, HandyKontaktProfilFarbe[playerid]);
	    PlayerTextDrawShow(playerid, HandyKontaktProfilBild[playerid]);
	    format(string, sizeof string, "%s", dini_Get(Spieler, "SpielerName"));
	    PlayerTextDrawSetString(playerid, HandyOrt[playerid], string);
	    PlayerTextDrawShow(playerid, HandyOrt[playerid]);
	    PlayerTextDrawHide(playerid, HandyZeit[playerid]);
	    //SetPVarInt(playerid, "HandyKontakte", 2);
		{
	 	   if(strcmp("Online",dini_Get(Spieler,"SpielerStatus"),true))
		   {
	          format(string, sizeof string, "~r~Online: %s", dini_Get(Spieler, "SpielerStatus"));
	          PlayerTextDrawSetString(playerid, HandyInfo_Status[playerid], string);
	          PlayerTextDrawShow(playerid, HandyInfo_Status[playerid]);
		   }
		   else
		   {
	          format(string, sizeof string, "~g~Online");
	          PlayerTextDrawSetString(playerid, HandyInfo_Status[playerid], string);
	          PlayerTextDrawShow(playerid, HandyInfo_Status[playerid]);
		   }
	       PlayerTextDrawShow(playerid,HandyCallContact[playerid]);
	       PlayerTextDrawShow(playerid,HandyAddFriendContact[playerid]);
	       PlayerTextDrawShow(playerid,HandyCallContact_[playerid]);
	       PlayerTextDrawShow(playerid,HandyAddFriendContact_[playerid]);//hier
		}


}

stock GetPlayerHandyName(playerid, playerslot)
{
	    new string[30];
		playerslot = playerslot + 5*GetPVarInt(playerid, "HandyKontakteSkroll")-1;
		HandyCalling[playerid] = playerslot;
		HandyCaller[playerid] = playerid;
		HandyCalling[HandyCalling[playerid]] = HandyCalling[playerid];
		HandyCaller[HandyCalling[playerid]] = HandyCaller[playerid];
		//if (GetPVarInt(HandyCaller[playerid], "HandyAnrufState") == 0)
		{
		   format(string, sizeof string, "Anrufer: %s", GetSname(HandyCaller[playerid]));
		   SendClientMessage(HandyCalling[playerid], Weis, string);
		   format(string, sizeof string, "Angerufene: %s", GetSname(HandyCalling[playerid]));
		   SendClientMessage(HandyCaller[playerid], Weis, string);
		}
		if(IsPlayerConnected(playerslot)){
	    format(string, sizeof string, "%i", playerslot);
	    SendClientMessage(playerid, Weis, string);
	    PlayerTextDrawHide(playerid,HandyCalender_Monday[playerid]);
	    PlayerTextDrawHide(playerid,HandyCalender_Tuesday[playerid]);
	    PlayerTextDrawHide(playerid,HandyCalender_Wednesday[playerid]);
	    PlayerTextDrawHide(playerid,HandyCalender_Thursday[playerid]);
	    PlayerTextDrawHide(playerid,HandyCalender_Friday[playerid]);
	    PlayerTextDrawHide(playerid,HandyCalender_Saturday[playerid]);
	    PlayerTextDrawHide(playerid,HandyCalender_Sunday[playerid]);
	    PlayerTextDrawHide(playerid,HandyCalender_Monday_[playerid]);
	    PlayerTextDrawHide(playerid,HandyCalender_Tuesday_[playerid]);
	    PlayerTextDrawHide(playerid,HandyCalender_Wednesday_[playerid]);
	    PlayerTextDrawHide(playerid,HandyCalender_Thursday_[playerid]);
	    PlayerTextDrawHide(playerid,HandyCalender_Friday_[playerid]);
	    PlayerTextDrawHide(playerid,HandyCalender_Saturday_[playerid]);
	    PlayerTextDrawHide(playerid,HandyCalender_Sunday_[playerid]);
		format(Spieler, sizeof Spieler, "/Spieler/%s.txt", GetSname(playerslot));
	    format(string, sizeof string, "Number: %s", dini_Get(Spieler, "Telefonnummer"));
	    PlayerTextDrawSetString(playerid, HandyInfo_Nummer[playerid], string);
	    PlayerTextDrawShow(playerid, HandyInfo_Nummer[playerid]);
	    PlayerTextDrawShow(playerid, HandyKontaktProfilFarbe[playerid]);
	    PlayerTextDrawShow(playerid, HandyKontaktProfilBild[playerid]);
	    format(string, sizeof string, "%s", dini_Get(Spieler, "SpielerName"));
	    PlayerTextDrawSetString(playerid, HandyOrt[playerid], string);
	    PlayerTextDrawShow(playerid, HandyOrt[playerid]);
	    PlayerTextDrawHide(playerid, HandyZeit[playerid]);
	    SetPVarInt(playerid, "HandyKontakte", 2);
		if(strcmp("Online",dini_Get(Spieler,"SpielerStatus"),true))
		{
	      format(string, sizeof string, "~r~Online: %s", dini_Get(Spieler, "SpielerStatus"));
	      PlayerTextDrawSetString(playerid, HandyInfo_Status[playerid], string);
	      PlayerTextDrawShow(playerid, HandyInfo_Status[playerid]);
		}
		else
		{
	      format(string, sizeof string, "~g~Online");
	      PlayerTextDrawSetString(playerid, HandyInfo_Status[playerid], string);
	      PlayerTextDrawShow(playerid, HandyInfo_Status[playerid]);
		}
		{
	    if(playerid == playerslot)
	    {
	      PlayerTextDrawShow(playerid,HandyCHProfile[playerid]);
	      PlayerTextDrawShow(playerid,HandyCHProfile_[playerid]);
	    }
	    else
	    {
	      PlayerTextDrawShow(playerid,HandyCallContact[playerid]);
	      PlayerTextDrawShow(playerid,HandyAddFriendContact[playerid]);
	      PlayerTextDrawShow(playerid,HandyCallContact_[playerid]);
	      PlayerTextDrawShow(playerid,HandyAddFriendContact_[playerid]);
	    }}
		}
	    return 1;
}

forward EndCallBecauseError(playerid, reason);
public EndCallBecauseError(playerid, reason)
{
    new string[35];
    if(reason == 1)
	{
	   format(string, sizeof string, "~r~%s's~n~phone is muted", GetSname(HandyCalling[playerid]));
	}
    if(reason == 2)
	{
	   format(string, sizeof string, "~r~%s~n~is already in a call", GetSname(HandyCalling[playerid]));
	}
    if(reason == 3)
	{
	   format(string, sizeof string, "~r~%s~n~didn't pick up", GetSname(HandyCalling[playerid]));
       PlayerTextDrawSetString(playerid, HandyAngerufen[playerid][3], string);
       SetTimerEx("HideUnansweredCallTexdDraws", 2500, false, "%i", HandyCalling[playerid]);
       KillTimer(WaitForCallingTimer);
       return 1;
	}
    if(reason == 4)
	{
	   format(string, sizeof string, "~r~%s~n~rejected the call", GetSname(HandyCalling[playerid]));
       PlayerTextDrawSetString(HandyCaller[playerid], HandyAngerufen[playerid][3], string);
       SetTimerEx("HideRejectedCallTexdDraws", 2500, false, "%i", playerid);
       KillTimer(WaitForCallingTimer);
       return 0;
	}
    if(reason == 5)
	{
	   if(playerid == HandyCaller[playerid])
	   {
	      format(string, sizeof string, "~r~%s~n~ended the call", GetSname(HandyCaller[playerid]));
	   }
	   else if(playerid == HandyCalling[playerid])
	   {
	      format(string, sizeof string, "~r~%s~n~ended the call", GetSname(HandyCalling[playerid]));
	   }
       PlayerTextDrawSetString(HandyCalling[playerid], HandyAngerufen[playerid][3], string);
       PlayerTextDrawSetString(HandyCaller[playerid], HandyAngerufen[playerid][3], string);
       SetTimerEx("HideUnansweredCallTexdDraws", 2500, false, "%i", HandyCalling[playerid]);
       SetTimerEx("HideRejectedCallTexdDraws", 2500, false, "%i", HandyCaller[playerid]);
       return 1;
	}
    PlayerTextDrawSetString(playerid, HandyAngerufen[playerid][3], string);
    SetTimerEx("HideRejectedCallTexdDraws", 2500, false, "%i", playerid);
    KillTimer(WaitForCallingTimer);
    return 1;
}

public OnPlayerText(playerid, text[])
{
	 new string[200];
	 if (GetPVarInt(HandyCaller[playerid], "HandyAnrufState") == 2 && GetPVarInt(HandyCalling[playerid], "HandyAnrufState") == 2 && playerid == HandyCaller[playerid])
	 {
		format(string, sizeof string, "Phone: %s", text);
		SendClientMessage(HandyCalling[playerid], Gelb, string);
		format(string, sizeof string, "Phone: %s", text);
		SendClientMessage(HandyCaller[playerid], Hellblau, string);
		return 0;
	 }
	 if (GetPVarInt(HandyCaller[playerid], "HandyAnrufState") == 2 && GetPVarInt(HandyCalling[playerid], "HandyAnrufState") == 2 && playerid == HandyCalling[playerid])
	 {
		format(string, sizeof string, "Phone: %s", text);
		SendClientMessage(HandyCaller[playerid], Gelb, string);
		format(string, sizeof string, "Phone: %s", text);
		SendClientMessage(HandyCalling[playerid], Hellblau, string);
		return 0;
	 }
	 return 1;
}

forward WaitForCalling(playerid);
public WaitForCalling(playerid)
{
    if(GetPVarInt(HandyCaller[playerid], "HandyAnrufState") == 1 && GetPVarInt(HandyCalling[playerid], "HandyAnrufState") != 2)
    {
	   EndCallBecauseError(playerid, 3);
    }
}

forward HideUnansweredCallTexdDraws(playerid);
public HideUnansweredCallTexdDraws(playerid)
{
    PlayerTextDrawSetSelectable(HandyCalling[playerid], HandyAuflegen[playerid][0], 1);
    PlayerTextDrawHide(playerid, HandyAngerufen[playerid][0]);
    PlayerTextDrawHide(playerid, HandyAngerufen[playerid][1]);
    PlayerTextDrawHide(playerid, HandyAngerufen[playerid][2]);
    PlayerTextDrawHide(playerid, HandyAngerufen[playerid][3]);
	PlayerTextDrawHide(HandyCalling[playerid],Handy[playerid]);
	PlayerTextDrawHide(HandyCalling[playerid],HandyBildschirm[playerid]);
	PlayerTextDrawHide(HandyCalling[playerid],HandyPlatzhalter[playerid]);
	PlayerTextDrawHide(HandyCalling[playerid],HandyAnrufen[playerid][0]);
	PlayerTextDrawHide(HandyCalling[playerid],HandyAnrufen[playerid][1]);
	PlayerTextDrawHide(HandyCalling[playerid],HandyAnrufen[playerid][2]);
	PlayerTextDrawHide(HandyCalling[playerid],HandyAuflegen[playerid][0]);
	PlayerTextDrawHide(HandyCalling[playerid],HandyAuflegen[playerid][1]);
	PlayerTextDrawHide(HandyCalling[playerid],HandyAuflegen[playerid][2]);
	PlayerTextDrawHide(HandyCalling[playerid],HandyHome[playerid][0]);
	PlayerTextDrawHide(HandyCalling[playerid],HandyHome[playerid][1]);
	PlayerTextDrawHide(HandyCalling[playerid],HandyHome[playerid][2]);
	PlayerTextDrawHide(HandyCalling[playerid],HandyTasten[playerid][0]);
	PlayerTextDrawHide(HandyCalling[playerid],HandyTasten[playerid][1]);
	PlayerTextDrawHide(HandyCalling[playerid],HandyTasten[playerid][2]);
	PlayerTextDrawHide(HandyCalling[playerid],HandyTasten[playerid][3]);
	PlayerTextDrawHide(HandyCalling[playerid],HandyTasten[playerid][4]);
	PlayerTextDrawHide(HandyCalling[playerid],HandyTasten[playerid][5]);
	PlayerTextDrawHide(HandyCalling[playerid],HandyTasten[playerid][6]);
	PlayerTextDrawHide(HandyCalling[playerid],HandyTasten[playerid][7]);
	PlayerTextDrawHide(HandyCalling[playerid],HandyTasten[playerid][8]);
	PlayerTextDrawHide(HandyCalling[playerid],HandyTasten[playerid][9]);
	PlayerTextDrawHide(HandyCalling[playerid],HandyTasten[playerid][10]);
	PlayerTextDrawHide(HandyCalling[playerid],HandyTasten[playerid][11]);
	PlayerTextDrawHide(HandyCalling[playerid],HandyTasten[playerid][12]);
	PlayerTextDrawHide(HandyCalling[playerid],HandyTasten[playerid][13]);
	PlayerTextDrawHide(HandyCalling[playerid],HandyTasten[playerid][14]);
	PlayerTextDrawHide(HandyCalling[playerid],HandyTasten[playerid][15]);
	PlayerTextDrawHide(HandyCalling[playerid],HandyTasten[playerid][16]);
	PlayerTextDrawHide(HandyCalling[playerid],HandyTasten[playerid][17]);
	PlayerTextDrawHide(HandyCalling[playerid],HandyTasten[playerid][18]);
	PlayerTextDrawHide(HandyCalling[playerid],HandyTasten[playerid][19]);
	PlayerTextDrawHide(HandyCalling[playerid],HandyTasten[playerid][20]);
	PlayerTextDrawHide(HandyCalling[playerid],HandyTasten[playerid][21]);
	PlayerTextDrawHide(HandyCalling[playerid],HandyTasten[playerid][22]);
	PlayerTextDrawHide(HandyCalling[playerid],HandyTasten[playerid][23]);
	PlayerTextDrawHide(HandyCalling[playerid],HandyTasten[playerid][24]);
	PlayerTextDrawHide(HandyCalling[playerid],HandyTasten[playerid][25]);
	PlayerTextDrawHide(HandyCalling[playerid],HandyTasten[playerid][26]);
	PlayerTextDrawHide(HandyCalling[playerid],HandyTasten[playerid][27]);
	PlayerTextDrawHide(HandyCalling[playerid],HandyTasten[playerid][28]);
	PlayerTextDrawHide(HandyCalling[playerid],HandyTasten[playerid][29]);
	PlayerTextDrawHide(HandyCalling[playerid],HandyAngerufen[playerid][0]);
	PlayerTextDrawHide(HandyCalling[playerid],HandyAngerufen[playerid][1]);
	PlayerTextDrawHide(HandyCalling[playerid],HandyAngerufen[playerid][2]);
	PlayerTextDrawHide(HandyCalling[playerid],HandyAngerufen[playerid][3]);
	CancelSelectTextDraw(HandyCalling[playerid]);
    HandyShowing[HandyCalling[playerid]] = 0;
    HandyShowing[HandyCaller[playerid]] = 1;
	DeletePVar(HandyCaller[playerid], "HandyAnrufState");
	DeletePVar(HandyCalling[playerid], "HandyAnrufState");
    HandyCaller[playerid] = -1;
    HandyCalling[playerid] = -1;
}

forward HideRejectedCallTexdDraws(playerid);
public HideRejectedCallTexdDraws(playerid)
{
    PlayerTextDrawHide(playerid, HandyAngerufen[playerid][0]);
    PlayerTextDrawHide(playerid, HandyAngerufen[playerid][1]);
    PlayerTextDrawHide(playerid, HandyAngerufen[playerid][2]);
    PlayerTextDrawHide(playerid, HandyAngerufen[playerid][3]);
    PlayerTextDrawHide(playerid, HandyAuflegen[playerid][0]);
	SelectTextDraw(playerid, 0x000000AB);
	DeletePVar(playerid, "Handypause");
	HandyShowing[playerid] = 1;
	PlayerTextDrawShow(playerid,HandyZeit[playerid]);
	PlayerTextDrawShow(playerid,HandyOrt[playerid]);
	PlayerTextDrawShow(playerid,HandyTelefonbuch[playerid][0]);
	PlayerTextDrawShow(playerid,HandyTelefonbuch[playerid][1]);
	PlayerTextDrawShow(playerid,HandyTelefonbuch[playerid][2]);
	PlayerTextDrawShow(playerid,HandyTelefonbuch[playerid][3]);
	PlayerTextDrawShow(playerid,HandyTelefonbuch[playerid][4]);
	PlayerTextDrawShow(playerid,HandyTelefonbuch[playerid][5]);
	PlayerTextDrawShow(playerid,HandyCalender[playerid][0]);
	PlayerTextDrawShow(playerid,HandyCalender[playerid][1]);
	PlayerTextDrawShow(playerid,HandyCalender[playerid][2]);
	PlayerTextDrawShow(playerid,HandyCalender[playerid][3]);
	PlayerTextDrawShow(playerid,HandyCalender[playerid][4]);
	PlayerTextDrawShow(playerid,HandyMusik[playerid][0]);
	PlayerTextDrawShow(playerid,HandyMusik[playerid][1]);
	PlayerTextDrawShow(playerid,HandyMusik[playerid][2]);
	PlayerTextDrawShow(playerid,HandyMusik[playerid][3]);
	PlayerTextDrawShow(playerid,HandyMusik[playerid][4]);
	PlayerTextDrawShow(playerid,HandyMusik[playerid][5]);
	PlayerTextDrawShow(playerid,HandyMusik[playerid][6]);
	PlayerTextDrawShow(playerid,HandyEinstellungen[playerid][0]);
	PlayerTextDrawShow(playerid,HandyEinstellungen[playerid][1]);
	PlayerTextDrawShow(playerid,HandyEinstellungen[playerid][2]);
	HandyZeitUpdate(playerid);
	PlayerTextDrawSetString(playerid, HandyOrt[playerid], GetPlayerLocation(playerid));
	PlayerTextDrawSetString(playerid, HandyCalender[playerid][4], WochentagKurz());
	DeletePVar(HandyCaller[playerid], "HandyAnrufState");
	DeletePVar(HandyCalling[playerid], "HandyAnrufState");
    PlayerTextDrawSetSelectable(HandyCaller[playerid], HandyAuflegen[playerid][0], 1);
    PlayerTextDrawShow(HandyCaller[playerid], HandyAuflegen[playerid][0]);
    HandyShowing[HandyCaller[playerid]] = 1;
	DeletePVar(HandyCaller[playerid], "HandyAnrufState");
	DeletePVar(HandyCalling[playerid], "HandyAnrufState");
    HandyCaller[playerid] = -1;
    HandyCalling[playerid] = -1;
}

forward HandyZeitUpdate(playerid);
public HandyZeitUpdate(playerid)
{
    new hour, minute, second, string[32];
    gettime(hour, minute, second);
    format(string, sizeof(string), "%02d:%02d", hour, minute);
    PlayerTextDrawSetString(playerid, HandyZeit[playerid], string);
}
