#include <a_samp>
#include <dini>
#include <0SimonsInclude>
#pragma tabsize 0

new Spieler[64];
new Sname [MAX_PLAYER_NAME];

#define TITEL 13
#define TEXT 14
#define INTERNET 15

new Showing[MAX_PLAYERS];
new PlayerText:Bildschirm[MAX_PLAYERS];
new PlayerText:Ausschaltknopf[MAX_PLAYERS];
new PlayerText:Hintergrund1[MAX_PLAYERS];
new PlayerText:Hintergrund2[MAX_PLAYERS];
new PlayerText:Hintergrund3[MAX_PLAYERS];
new PlayerText:Hintergrund4[MAX_PLAYERS];
new PlayerText:Hintergrund5[MAX_PLAYERS];
new PlayerText:Hintergrund6[MAX_PLAYERS];
new PlayerText:Hintergrund7[MAX_PLAYERS];
new PlayerText:mHintergrund1[MAX_PLAYERS];
new PlayerText:mHintergrund2[MAX_PLAYERS];
new PlayerText:mHintergrund3[MAX_PLAYERS];
new PlayerText:mHintergrund4[MAX_PLAYERS];
new PlayerText:mHintergrund5[MAX_PLAYERS];
new PlayerText:mHintergrund6[MAX_PLAYERS];
new PlayerText:mHintergrund7[MAX_PLAYERS];
new PlayerText:Papierkorb[MAX_PLAYERS];
new PlayerText:Internet[MAX_PLAYERS];
new PlayerText:Hausaufgabe[MAX_PLAYERS];
new PlayerText:Einstellungen[MAX_PLAYERS];
new PlayerText:Email[MAX_PLAYERS];
new PlayerText:SAMP[MAX_PLAYERS];
new PlayerText:Spiele[MAX_PLAYERS];
new PlayerText:Notizen[MAX_PLAYERS];
new PlayerText:KeineDateien[MAX_PLAYERS];
new PlayerText:Schliessen[MAX_PLAYERS];
new PlayerText:PapierHinter[MAX_PLAYERS];
new PlayerText:Hintergrunda[MAX_PLAYERS];
new PlayerText:AddNote[MAX_PLAYERS];
new PlayerText:Websites[MAX_PLAYERS];
new PlayerText:Note[MAX_PLAYERS];
new PlayerText:Web_Hintergrund[MAX_PLAYERS];
new PlayerText:googl[MAX_PLAYERS];
new PlayerText:GooglSearch[MAX_PLAYERS];
new PlayerText:rickrolld[MAX_PLAYERS];
new PlayerText:NothingFound[MAX_PLAYERS];
new PlayerText:NFX[MAX_PLAYERS];
new PlayerText:Titel1[MAX_PLAYERS];
new PlayerText:COFYes[MAX_PLAYERS];
new PlayerText:ComEx1[MAX_PLAYERS];
new PlayerText:ComEx2[MAX_PLAYERS];
new PlayerText:ComEx3[MAX_PLAYERS];
new PlayerText:ComEx4[MAX_PLAYERS];
new PlayerText:ComEx5[MAX_PLAYERS];
new PlayerText:ComEx6[MAX_PLAYERS];
new PlayerText:ComEx7[MAX_PLAYERS];
new PlayerText:ComEx8[MAX_PLAYERS];
new PlayerText:ComEx9[MAX_PLAYERS];
new PlayerText:ComEx10[MAX_PLAYERS];
new PlayerText:ComEx11[MAX_PLAYERS];
new PlayerText:ComEx12[MAX_PLAYERS];
new PlayerText:CKauf_Flieger[MAX_PLAYERS];
new PlayerText:CKauf_FliegerN[MAX_PLAYERS];
new PlayerText:CKauf_FliegerH[MAX_PLAYERS];
new PlayerText:CKauf_Militar[MAX_PLAYERS];
new PlayerText:CKauf_MilitarN[MAX_PLAYERS];
new PlayerText:CKauf_MilitarH[MAX_PLAYERS];
new PlayerText:CKauf_Autos[MAX_PLAYERS];
new PlayerText:CKauf_AutosN[MAX_PLAYERS];
new PlayerText:CKauf_AutosH[MAX_PLAYERS];
new PlayerText:CKauf_Haus[MAX_PLAYERS];
new PlayerText:CKauf_HausN[MAX_PLAYERS];
new PlayerText:CKauf_HausH[MAX_PLAYERS];
new PlayerText:CKauf_Boote[MAX_PLAYERS];
new PlayerText:CKauf_BooteN[MAX_PLAYERS];
new PlayerText:CKauf_BooteH[MAX_PLAYERS];

public OnPlayerConnect(playerid)
{
Showing[playerid] = 0;
Hintergrund1[playerid] = CreatePlayerTextDraw(playerid, 153.666656, 60.422199, "pc:Hintergrund1");
PlayerTextDrawTextSize(playerid, Hintergrund1[playerid], 300.000000, 291.000000);
PlayerTextDrawAlignment(playerid, Hintergrund1[playerid], 1);
PlayerTextDrawColor(playerid, Hintergrund1[playerid], -1);
PlayerTextDrawSetShadow(playerid, Hintergrund1[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, Hintergrund1[playerid], 255);
PlayerTextDrawFont(playerid, Hintergrund1[playerid], 4);
PlayerTextDrawSetProportional(playerid, Hintergrund1[playerid], 0);

Hintergrund2[playerid] = CreatePlayerTextDraw(playerid, 153.666656, 60.422199, "pc:Hintergrund2");
PlayerTextDrawTextSize(playerid, Hintergrund2[playerid], 300.000000, 291.000000);
PlayerTextDrawAlignment(playerid, Hintergrund2[playerid], 1);
PlayerTextDrawColor(playerid, Hintergrund2[playerid], -1);
PlayerTextDrawSetShadow(playerid, Hintergrund2[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, Hintergrund2[playerid], 255);
PlayerTextDrawFont(playerid, Hintergrund2[playerid], 4);
PlayerTextDrawSetProportional(playerid, Hintergrund2[playerid], 0);

Hintergrund3[playerid] = CreatePlayerTextDraw(playerid, 153.666656, 60.422199, "pc:Hintergrund3");
PlayerTextDrawTextSize(playerid, Hintergrund3[playerid], 300.000000, 291.000000);
PlayerTextDrawAlignment(playerid, Hintergrund3[playerid], 1);
PlayerTextDrawColor(playerid, Hintergrund3[playerid], -1);
PlayerTextDrawSetShadow(playerid, Hintergrund3[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, Hintergrund3[playerid], 255);
PlayerTextDrawFont(playerid, Hintergrund3[playerid], 4);
PlayerTextDrawSetProportional(playerid, Hintergrund3[playerid], 0);

Hintergrund4[playerid] = CreatePlayerTextDraw(playerid, 153.666656, 60.422199, "pc:Hintergrund4");
PlayerTextDrawTextSize(playerid, Hintergrund4[playerid], 300.000000, 291.000000);
PlayerTextDrawAlignment(playerid, Hintergrund4[playerid], 1);
PlayerTextDrawColor(playerid, Hintergrund4[playerid], -1);
PlayerTextDrawSetShadow(playerid, Hintergrund4[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, Hintergrund4[playerid], 255);
PlayerTextDrawFont(playerid, Hintergrund4[playerid], 4);
PlayerTextDrawSetProportional(playerid, Hintergrund4[playerid], 0);

Hintergrund5[playerid] = CreatePlayerTextDraw(playerid, 153.666656, 60.422199, "pc:Hintergrund5");
PlayerTextDrawTextSize(playerid, Hintergrund5[playerid], 300.000000, 291.000000);
PlayerTextDrawAlignment(playerid, Hintergrund5[playerid], 1);
PlayerTextDrawColor(playerid, Hintergrund5[playerid], -1);
PlayerTextDrawSetShadow(playerid, Hintergrund5[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, Hintergrund5[playerid], 255);
PlayerTextDrawFont(playerid, Hintergrund5[playerid], 4);
PlayerTextDrawSetProportional(playerid, Hintergrund5[playerid], 0);

Hintergrund6[playerid] = CreatePlayerTextDraw(playerid, 153.666656, 60.422199, "pc:Hintergrund6");
PlayerTextDrawTextSize(playerid, Hintergrund6[playerid], 300.000000, 291.000000);
PlayerTextDrawAlignment(playerid, Hintergrund6[playerid], 1);
PlayerTextDrawColor(playerid, Hintergrund6[playerid], -1);
PlayerTextDrawSetShadow(playerid, Hintergrund6[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, Hintergrund6[playerid], 255);
PlayerTextDrawFont(playerid, Hintergrund6[playerid], 4);
PlayerTextDrawSetProportional(playerid, Hintergrund6[playerid], 0);

Hintergrund7[playerid] = CreatePlayerTextDraw(playerid, 153.666656, 60.422199, "pc:Hintergrund7");
PlayerTextDrawTextSize(playerid, Hintergrund7[playerid], 300.000000, 291.000000);
PlayerTextDrawAlignment(playerid, Hintergrund7[playerid], 1);
PlayerTextDrawColor(playerid, Hintergrund7[playerid], -1);
PlayerTextDrawSetShadow(playerid, Hintergrund7[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, Hintergrund7[playerid], 255);
PlayerTextDrawFont(playerid, Hintergrund7[playerid], 4);
PlayerTextDrawSetProportional(playerid, Hintergrund7[playerid], 0);

Papierkorb[playerid] = CreatePlayerTextDraw(playerid, 164.333145, 63.740734, "pc:Papierkorb");
PlayerTextDrawTextSize(playerid, Papierkorb[playerid], 26.000000, 27.000000);
PlayerTextDrawAlignment(playerid, Papierkorb[playerid], 1);
PlayerTextDrawColor(playerid, Papierkorb[playerid], -1);
PlayerTextDrawSetShadow(playerid, Papierkorb[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, Papierkorb[playerid], 255);
PlayerTextDrawFont(playerid, Papierkorb[playerid], 4);
PlayerTextDrawSetProportional(playerid, Papierkorb[playerid], 0);
PlayerTextDrawSetSelectable(playerid, Papierkorb[playerid], true);

Internet[playerid] = CreatePlayerTextDraw(playerid, 159.666580, 106.051956, "pc:Internet");
PlayerTextDrawTextSize(playerid, Internet[playerid], 28.000000, 28.000000);
PlayerTextDrawAlignment(playerid, Internet[playerid], 1);
PlayerTextDrawColor(playerid, Internet[playerid], -1);
PlayerTextDrawSetShadow(playerid, Internet[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, Internet[playerid], 255);
PlayerTextDrawFont(playerid, Internet[playerid], 4);
PlayerTextDrawSetProportional(playerid, Internet[playerid], 0);
PlayerTextDrawSetSelectable(playerid, Internet[playerid], true);

Hausaufgabe[playerid] = CreatePlayerTextDraw(playerid, 161.333297, 144.214752, "pc:Hausaufgabe");
PlayerTextDrawTextSize(playerid, Hausaufgabe[playerid], 27.000000, 34.000000);
PlayerTextDrawAlignment(playerid, Hausaufgabe[playerid], 1);
PlayerTextDrawColor(playerid, Hausaufgabe[playerid], -1);
PlayerTextDrawSetShadow(playerid, Hausaufgabe[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, Hausaufgabe[playerid], 255);
PlayerTextDrawFont(playerid, Hausaufgabe[playerid], 4);
PlayerTextDrawSetProportional(playerid, Hausaufgabe[playerid], 0);
PlayerTextDrawSetSelectable(playerid, Hausaufgabe[playerid], true);

Einstellungen[playerid] = CreatePlayerTextDraw(playerid, 162.333389, 180.303680, "pc:Einstellungen");
PlayerTextDrawTextSize(playerid, Einstellungen[playerid], 26.000000, 40.000000);
PlayerTextDrawAlignment(playerid, Einstellungen[playerid], 1);
PlayerTextDrawColor(playerid, Einstellungen[playerid], -1);
PlayerTextDrawSetShadow(playerid, Einstellungen[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, Einstellungen[playerid], 255);
PlayerTextDrawFont(playerid, Einstellungen[playerid], 4);
PlayerTextDrawSetProportional(playerid, Einstellungen[playerid], 0);
PlayerTextDrawSetSelectable(playerid, Einstellungen[playerid], true);

Email[playerid] = CreatePlayerTextDraw(playerid, 163.666595, 230.496154, "pc:Email");
PlayerTextDrawTextSize(playerid, Email[playerid], 21.000000, 32.000000);
PlayerTextDrawAlignment(playerid, Email[playerid], 1);
PlayerTextDrawColor(playerid, Email[playerid], -1);
PlayerTextDrawSetShadow(playerid, Email[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, Email[playerid], 255);
PlayerTextDrawFont(playerid, Email[playerid], 4);
PlayerTextDrawSetProportional(playerid, Email[playerid], 0);
PlayerTextDrawSetSelectable(playerid, Email[playerid], true);

SAMP[playerid] = CreatePlayerTextDraw(playerid, 161.999908, 268.659332, "pc:SAMP");
PlayerTextDrawTextSize(playerid, SAMP[playerid], 27.000000, 31.000000);
PlayerTextDrawAlignment(playerid, SAMP[playerid], 1);
PlayerTextDrawColor(playerid, SAMP[playerid], -1);
PlayerTextDrawSetShadow(playerid, SAMP[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, SAMP[playerid], 255);
PlayerTextDrawFont(playerid, SAMP[playerid], 4);
PlayerTextDrawSetProportional(playerid, SAMP[playerid], 0);
PlayerTextDrawSetSelectable(playerid, SAMP[playerid], true);

Spiele[playerid] = CreatePlayerTextDraw(playerid, 159.333267, 308.066802, "pc:Spiele");
PlayerTextDrawTextSize(playerid, Spiele[playerid], 32.000000, 33.000000);
PlayerTextDrawAlignment(playerid, Spiele[playerid], 1);
PlayerTextDrawColor(playerid, Spiele[playerid], -1);
PlayerTextDrawSetShadow(playerid, Spiele[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, Spiele[playerid], 255);
PlayerTextDrawFont(playerid, Spiele[playerid], 4);
PlayerTextDrawSetProportional(playerid, Spiele[playerid], 0);
PlayerTextDrawSetSelectable(playerid, Spiele[playerid], true);

Notizen[playerid] = CreatePlayerTextDraw(playerid, 201.666564, 64.155525, "pc:Notizen");
PlayerTextDrawTextSize(playerid, Notizen[playerid], 16.000000, 27.000000);
PlayerTextDrawAlignment(playerid, Notizen[playerid], 1);
PlayerTextDrawColor(playerid, Notizen[playerid], -1);
PlayerTextDrawSetShadow(playerid, Notizen[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, Notizen[playerid], 255);
PlayerTextDrawFont(playerid, Notizen[playerid], 4);
PlayerTextDrawSetProportional(playerid, Notizen[playerid], 0);
PlayerTextDrawSetSelectable(playerid, Notizen[playerid], true);

PapierHinter[playerid] = CreatePlayerTextDraw(playerid, 154.666687, 61.251796, "pc:PapierHinter");
PlayerTextDrawTextSize(playerid, PapierHinter[playerid], 299.000000, 287.000000);
PlayerTextDrawAlignment(playerid, PapierHinter[playerid], 1);
PlayerTextDrawColor(playerid, PapierHinter[playerid], -1);
PlayerTextDrawSetShadow(playerid, PapierHinter[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, PapierHinter[playerid], 255);
PlayerTextDrawFont(playerid, PapierHinter[playerid], 4);
PlayerTextDrawSetProportional(playerid, PapierHinter[playerid], 0);


KeineDateien[playerid] = CreatePlayerTextDraw(playerid, 191.666671, 78.259269, "pc:KeineDateien");
PlayerTextDrawTextSize(playerid, KeineDateien[playerid], 72.000000, 13.000000);
PlayerTextDrawAlignment(playerid, KeineDateien[playerid], 1);
PlayerTextDrawColor(playerid, KeineDateien[playerid], -1);
PlayerTextDrawSetShadow(playerid, KeineDateien[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, KeineDateien[playerid], 255);
PlayerTextDrawFont(playerid, KeineDateien[playerid], 4);
PlayerTextDrawSetProportional(playerid, KeineDateien[playerid], 0);

Hintergrunda[playerid] = CreatePlayerTextDraw(playerid, 191.666671, 78.259269, "pc:Hintergrunda");
PlayerTextDrawTextSize(playerid, Hintergrunda[playerid], 72.000000, 13.000000);
PlayerTextDrawAlignment(playerid, Hintergrunda[playerid], 1);
PlayerTextDrawColor(playerid, Hintergrunda[playerid], -1);
PlayerTextDrawSetShadow(playerid, Hintergrunda[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, Hintergrunda[playerid], 255);
PlayerTextDrawFont(playerid, Hintergrunda[playerid], 4);
PlayerTextDrawSetProportional(playerid, Hintergrunda[playerid], 0);

mHintergrund1[playerid] = CreatePlayerTextDraw(playerid, 197.000061, 94.437011, "pc:Hintergrund1");
PlayerTextDrawTextSize(playerid, mHintergrund1[playerid], 62.000000, 54.000000);
PlayerTextDrawAlignment(playerid, mHintergrund1[playerid], 1);
PlayerTextDrawColor(playerid, mHintergrund1[playerid], -1);
PlayerTextDrawSetShadow(playerid, mHintergrund1[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, mHintergrund1[playerid], 255);
PlayerTextDrawFont(playerid, mHintergrund1[playerid], 4);
PlayerTextDrawSetProportional(playerid, mHintergrund1[playerid], 0);
PlayerTextDrawSetSelectable(playerid, mHintergrund1[playerid], true);

mHintergrund2[playerid] = CreatePlayerTextDraw(playerid, 196.666564, 163.296218, "pc:Hintergrund2");
PlayerTextDrawTextSize(playerid, mHintergrund2[playerid], 62.000000, 55.000000);
PlayerTextDrawAlignment(playerid, mHintergrund2[playerid], 1);
PlayerTextDrawColor(playerid, mHintergrund2[playerid], -1);
PlayerTextDrawSetShadow(playerid, mHintergrund2[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, mHintergrund2[playerid], 255);
PlayerTextDrawFont(playerid, mHintergrund2[playerid], 4);
PlayerTextDrawSetProportional(playerid, mHintergrund2[playerid], 0);
PlayerTextDrawSetSelectable(playerid, mHintergrund2[playerid], true);

mHintergrund3[playerid] = CreatePlayerTextDraw(playerid, 348.666717, 92.777786, "pc:Hintergrund3");
PlayerTextDrawTextSize(playerid, mHintergrund3[playerid], 64.000000, 56.000000);
PlayerTextDrawAlignment(playerid, mHintergrund3[playerid], 1);
PlayerTextDrawColor(playerid, mHintergrund3[playerid], -1);
PlayerTextDrawSetShadow(playerid, mHintergrund3[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, mHintergrund3[playerid], 255);
PlayerTextDrawFont(playerid, mHintergrund3[playerid], 4);
PlayerTextDrawSetProportional(playerid, mHintergrund3[playerid], 0);
PlayerTextDrawSetSelectable(playerid, mHintergrund3[playerid], true);

mHintergrund4[playerid] = CreatePlayerTextDraw(playerid, 272.000183, 162.051879, "pc:Hintergrund4");
PlayerTextDrawTextSize(playerid, mHintergrund4[playerid], 63.000000, 58.000000);
PlayerTextDrawAlignment(playerid, mHintergrund4[playerid], 1);
PlayerTextDrawColor(playerid, mHintergrund4[playerid], -1);
PlayerTextDrawSetShadow(playerid, mHintergrund4[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, mHintergrund4[playerid], 255);
PlayerTextDrawFont(playerid, mHintergrund4[playerid], 4);
PlayerTextDrawSetProportional(playerid, mHintergrund4[playerid], 0);
PlayerTextDrawSetSelectable(playerid, mHintergrund4[playerid], true);

mHintergrund5[playerid] = CreatePlayerTextDraw(playerid, 271.333312, 94.437072, "pc:Hintergrund5");
PlayerTextDrawTextSize(playerid, mHintergrund5[playerid], 65.000000, 54.000000);
PlayerTextDrawAlignment(playerid, mHintergrund5[playerid], 1);
PlayerTextDrawColor(playerid, mHintergrund5[playerid], -1);
PlayerTextDrawSetShadow(playerid, mHintergrund5[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, mHintergrund5[playerid], 255);
PlayerTextDrawFont(playerid, mHintergrund5[playerid], 4);
PlayerTextDrawSetProportional(playerid, mHintergrund5[playerid], 0);
PlayerTextDrawSetSelectable(playerid, mHintergrund5[playerid], true);

mHintergrund6[playerid] = CreatePlayerTextDraw(playerid, 348.333404, 160.392578, "pc:Hintergrund6");
PlayerTextDrawTextSize(playerid, mHintergrund6[playerid], 67.000000, 60.000000);
PlayerTextDrawAlignment(playerid, mHintergrund6[playerid], 1);
PlayerTextDrawColor(playerid, mHintergrund6[playerid], -1);
PlayerTextDrawSetShadow(playerid, mHintergrund6[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, mHintergrund6[playerid], 255);
PlayerTextDrawFont(playerid, mHintergrund6[playerid], 4);
PlayerTextDrawSetProportional(playerid, mHintergrund6[playerid], 0);
PlayerTextDrawSetSelectable(playerid, mHintergrund6[playerid], true);

mHintergrund7[playerid] = CreatePlayerTextDraw(playerid, 196.666656, 225.518478, "pc:Hintergrund7");
PlayerTextDrawTextSize(playerid, mHintergrund7[playerid], 61.000000, 59.000000);
PlayerTextDrawAlignment(playerid, mHintergrund7[playerid], 1);
PlayerTextDrawColor(playerid, mHintergrund7[playerid], -1);
PlayerTextDrawSetShadow(playerid, mHintergrund7[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, mHintergrund7[playerid], 255);
PlayerTextDrawFont(playerid, mHintergrund7[playerid], 4);
PlayerTextDrawSetProportional(playerid, mHintergrund7[playerid], 0);
PlayerTextDrawSetSelectable(playerid, mHintergrund7[playerid], true);

AddNote[playerid] = CreatePlayerTextDraw(playerid, 253.666641, 88.629623, "pc:AddNote");
PlayerTextDrawTextSize(playerid, AddNote[playerid], 90.000000, 90.000000);
PlayerTextDrawAlignment(playerid, AddNote[playerid], 1);
PlayerTextDrawColor(playerid, AddNote[playerid], -1);
PlayerTextDrawSetShadow(playerid, AddNote[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, AddNote[playerid], 255);
PlayerTextDrawFont(playerid, AddNote[playerid], 4);
PlayerTextDrawSetProportional(playerid, AddNote[playerid], 0);
PlayerTextDrawSetSelectable(playerid, AddNote[playerid], true);

Note[playerid] = CreatePlayerTextDraw(playerid, 189.333312, 84.066627, "pc:Note");
PlayerTextDrawTextSize(playerid, Note[playerid], 68.000000, 80.000000);
PlayerTextDrawAlignment(playerid, Note[playerid], 1);
PlayerTextDrawColor(playerid, Note[playerid], -1);
PlayerTextDrawSetShadow(playerid, Note[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, Note[playerid], 255);
PlayerTextDrawFont(playerid, Note[playerid], 4);
PlayerTextDrawSetProportional(playerid, Note[playerid], 0);
PlayerTextDrawSetSelectable(playerid, Note[playerid], true);

Websites[playerid] = CreatePlayerTextDraw(playerid, 199.666519, 74.266700, "Websites");
PlayerTextDrawLetterSize(playerid, Websites[playerid], 0.299999, 1.662221);
PlayerTextDrawAlignment(playerid, Websites[playerid], 1);
PlayerTextDrawColor(playerid, Websites[playerid], 255);
PlayerTextDrawSetShadow(playerid, Websites[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, Websites[playerid], 255);
PlayerTextDrawFont(playerid, Websites[playerid], 1);
PlayerTextDrawSetProportional(playerid, Websites[playerid], 1);

Titel1[playerid] = CreatePlayerTextDraw(playerid, 276.666595, 73.851829, "VARIABLE");
PlayerTextDrawLetterSize(playerid, Titel1[playerid], 0.299999, 1.662221);
PlayerTextDrawAlignment(playerid, Titel1[playerid], 1);
PlayerTextDrawColor(playerid, Titel1[playerid], 255);
PlayerTextDrawSetShadow(playerid, Titel1[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, Titel1[playerid], 255);
PlayerTextDrawFont(playerid, Titel1[playerid], 1);
PlayerTextDrawSetProportional(playerid, Titel1[playerid], 1);

Web_Hintergrund[playerid] = CreatePlayerTextDraw(playerid, 155.666687, 68.303718, "LD_SPAC:white");
PlayerTextDrawTextSize(playerid, Web_Hintergrund[playerid], 299.000000, 303.000000);
PlayerTextDrawAlignment(playerid, Web_Hintergrund[playerid], 1);
PlayerTextDrawColor(playerid, Web_Hintergrund[playerid], -1);
PlayerTextDrawSetShadow(playerid, Web_Hintergrund[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, Web_Hintergrund[playerid], 255);
PlayerTextDrawFont(playerid, Web_Hintergrund[playerid], 4);
PlayerTextDrawSetProportional(playerid, Web_Hintergrund[playerid], 0);

rickrolld[playerid] = CreatePlayerTextDraw(playerid, 155.000030, 71.207305, "pc:RICKROLLD");
PlayerTextDrawTextSize(playerid, rickrolld[playerid], 298.000000, 279.000000);
PlayerTextDrawAlignment(playerid, rickrolld[playerid], 1);
PlayerTextDrawColor(playerid, rickrolld[playerid], -1);
PlayerTextDrawSetShadow(playerid, rickrolld[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, rickrolld[playerid], 255);
PlayerTextDrawFont(playerid, rickrolld[playerid], 4);
PlayerTextDrawSetProportional(playerid, rickrolld[playerid], 0);

googl[playerid] = CreatePlayerTextDraw(playerid, 279.000000, 158.888854, "~g~g~y~o~r~og~b~l");
PlayerTextDrawLetterSize(playerid, googl[playerid], 0.632666, 2.591406);
PlayerTextDrawAlignment(playerid, googl[playerid], 1);
PlayerTextDrawColor(playerid, googl[playerid], 255);
PlayerTextDrawSetShadow(playerid, googl[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, googl[playerid], 255);
PlayerTextDrawFont(playerid, googl[playerid], 1);
PlayerTextDrawSetProportional(playerid, googl[playerid], 1);

GooglSearch[playerid] = CreatePlayerTextDraw(playerid, 281.333374, 191.088928, "pc:search");
PlayerTextDrawTextSize(playerid, GooglSearch[playerid], 49.000000, 17.000000);
PlayerTextDrawAlignment(playerid, GooglSearch[playerid], 1);
PlayerTextDrawColor(playerid, GooglSearch[playerid], -1);
PlayerTextDrawSetShadow(playerid, GooglSearch[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, GooglSearch[playerid], 255);
PlayerTextDrawFont(playerid, GooglSearch[playerid], 4);
PlayerTextDrawSetProportional(playerid, GooglSearch[playerid], 0);
PlayerTextDrawSetSelectable(playerid, GooglSearch[playerid], true);

NothingFound[playerid] = CreatePlayerTextDraw(playerid, 249.000030, 244.755477, "We_found_nothing._~n~Please_try_again!");
PlayerTextDrawLetterSize(playerid, NothingFound[playerid], 0.400000, 1.600000);
PlayerTextDrawAlignment(playerid, NothingFound[playerid], 1);
PlayerTextDrawColor(playerid, NothingFound[playerid], 255);
PlayerTextDrawSetShadow(playerid, NothingFound[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, NothingFound[playerid], 255);
PlayerTextDrawFont(playerid, NothingFound[playerid], 1);
PlayerTextDrawSetProportional(playerid, NothingFound[playerid], 1);

NFX[playerid] = CreatePlayerTextDraw(playerid, 293.000030, 280.688903, "LD_CHAT:thumbdn");
PlayerTextDrawTextSize(playerid, NFX[playerid], 23.000000, 19.000000);
PlayerTextDrawAlignment(playerid, NFX[playerid], 1);
PlayerTextDrawColor(playerid, NFX[playerid], -1);
PlayerTextDrawSetShadow(playerid, NFX[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, NFX[playerid], 255);
PlayerTextDrawFont(playerid, NFX[playerid], 4);
PlayerTextDrawSetProportional(playerid, NFX[playerid], 0);

COFYes[playerid] = CreatePlayerTextDraw(playerid, 289.333343, 180.459243, "Yes");
PlayerTextDrawLetterSize(playerid, COFYes[playerid], 0.632664, 2.591406);
PlayerTextDrawAlignment(playerid, COFYes[playerid], 1);
PlayerTextDrawColor(playerid, COFYes[playerid], 255);
PlayerTextDrawSetShadow(playerid, COFYes[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, COFYes[playerid], 255);
PlayerTextDrawFont(playerid, COFYes[playerid], 1);
PlayerTextDrawSetProportional(playerid, COFYes[playerid], 1);

CKauf_AutosN[playerid] = CreatePlayerTextDraw(playerid, 207.333312, 189.585021, "Cars");
PlayerTextDrawLetterSize(playerid, CKauf_AutosN[playerid], 0.400000, 1.600000);
PlayerTextDrawTextSize(playerid, CKauf_AutosN[playerid], 0.000000, 87.000000);
PlayerTextDrawAlignment(playerid, CKauf_AutosN[playerid], 2);
PlayerTextDrawColor(playerid, CKauf_AutosN[playerid], -1);
PlayerTextDrawUseBox(playerid, CKauf_AutosN[playerid], 1);
PlayerTextDrawBoxColor(playerid, CKauf_AutosN[playerid], 255);
PlayerTextDrawSetShadow(playerid, CKauf_AutosN[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, CKauf_AutosN[playerid], 255);
PlayerTextDrawFont(playerid, CKauf_AutosN[playerid], 1);
PlayerTextDrawSetProportional(playerid, CKauf_AutosN[playerid], 1);

CKauf_AutosH[playerid] = CreatePlayerTextDraw(playerid, 163.333389, 94.022270, "");
PlayerTextDrawTextSize(playerid, CKauf_AutosH[playerid], 90.000000, 90.000000);
PlayerTextDrawColor(playerid, CKauf_AutosH[playerid], -1);
PlayerTextDrawBackgroundColor(playerid, CKauf_AutosH[playerid], 255);
PlayerTextDrawFont(playerid, CKauf_AutosH[playerid], 5);
PlayerTextDrawSetPreviewModel(playerid, CKauf_AutosH[playerid], 576);
PlayerTextDrawSetPreviewRot(playerid, CKauf_AutosH[playerid], -27.000000, 0.000000, -27.000000, 0.850000);
PlayerTextDrawSetPreviewVehCol(playerid, CKauf_AutosH[playerid], 226, 1);

CKauf_Autos[playerid] = CreatePlayerTextDraw(playerid, 163.333389, 94.022270, "");
PlayerTextDrawTextSize(playerid, CKauf_Autos[playerid], 90.000000, 90.000000);
PlayerTextDrawAlignment(playerid, CKauf_Autos[playerid], 0);
PlayerTextDrawColor(playerid, CKauf_Autos[playerid], -1);
PlayerTextDrawBackgroundColor(playerid, CKauf_Autos[playerid], 255);
PlayerTextDrawFont(playerid, CKauf_Autos[playerid], 5);
PlayerTextDrawSetSelectable(playerid, CKauf_Autos[playerid], true);
PlayerTextDrawSetPreviewModel(playerid, CKauf_Autos[playerid], 576);
PlayerTextDrawSetPreviewRot(playerid, CKauf_Autos[playerid], -27.000000, 0.000000, -27.000000, 0.850000);
PlayerTextDrawSetPreviewVehCol(playerid, CKauf_Autos[playerid], 226, 1);

CKauf_MilitarH[playerid] = CreatePlayerTextDraw(playerid, 162.333221, 222.200057, "");
PlayerTextDrawTextSize(playerid, CKauf_MilitarH[playerid], 90.000000, 90.000000);
PlayerTextDrawAlignment(playerid, CKauf_MilitarH[playerid], 1);
PlayerTextDrawColor(playerid, CKauf_MilitarH[playerid], -1);
PlayerTextDrawSetShadow(playerid, CKauf_MilitarH[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, CKauf_MilitarH[playerid], 255);
PlayerTextDrawFont(playerid, CKauf_MilitarH[playerid], 5);
PlayerTextDrawSetProportional(playerid, CKauf_MilitarH[playerid], 0);
PlayerTextDrawSetSelectable(playerid, CKauf_MilitarH[playerid], false);
PlayerTextDrawSetPreviewModel(playerid, CKauf_MilitarH[playerid], 432);
PlayerTextDrawSetPreviewRot(playerid, CKauf_MilitarH[playerid], -27.000000, 0.000000, -27.000000, 0.850000);
PlayerTextDrawSetPreviewVehCol(playerid, CKauf_MilitarH[playerid], 0, 0);

CKauf_Militar[playerid] = CreatePlayerTextDraw(playerid, 162.333221, 222.200057, "");
PlayerTextDrawTextSize(playerid, CKauf_Militar[playerid], 90.000000, 90.000000);
PlayerTextDrawAlignment(playerid, CKauf_Militar[playerid], 1);
PlayerTextDrawColor(playerid, CKauf_Militar[playerid], -1);
PlayerTextDrawSetShadow(playerid, CKauf_Militar[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, CKauf_Militar[playerid], 255);
PlayerTextDrawFont(playerid, CKauf_Militar[playerid], 5);
PlayerTextDrawSetProportional(playerid, CKauf_Militar[playerid], 0);
PlayerTextDrawSetSelectable(playerid, CKauf_Militar[playerid], true);
PlayerTextDrawSetPreviewModel(playerid, CKauf_Militar[playerid], 432);
PlayerTextDrawSetPreviewRot(playerid, CKauf_Militar[playerid], -27.000000, 0.000000, -27.000000, 0.850000);
PlayerTextDrawSetPreviewVehCol(playerid, CKauf_Militar[playerid], 0, 0);

CKauf_MilitarN[playerid] = CreatePlayerTextDraw(playerid, 206.666641, 318.177703, "Military");
PlayerTextDrawLetterSize(playerid, CKauf_MilitarN[playerid], 0.400000, 1.600000);
PlayerTextDrawTextSize(playerid, CKauf_MilitarN[playerid], 0.000000, 87.000000);
PlayerTextDrawAlignment(playerid, CKauf_MilitarN[playerid], 2);
PlayerTextDrawColor(playerid, CKauf_MilitarN[playerid], -1);
PlayerTextDrawUseBox(playerid, CKauf_MilitarN[playerid], 1);
PlayerTextDrawBoxColor(playerid, CKauf_MilitarN[playerid], 255);
PlayerTextDrawSetShadow(playerid, CKauf_MilitarN[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, CKauf_MilitarN[playerid], 255);
PlayerTextDrawFont(playerid, CKauf_MilitarN[playerid], 1);
PlayerTextDrawSetProportional(playerid, CKauf_MilitarN[playerid], 1);

CKauf_FliegerH[playerid] = CreatePlayerTextDraw(playerid, 258.333099, 94.022254, "");
PlayerTextDrawTextSize(playerid, CKauf_FliegerH[playerid], 90.000000, 90.000000);
PlayerTextDrawAlignment(playerid, CKauf_FliegerH[playerid], 1);
PlayerTextDrawColor(playerid, CKauf_FliegerH[playerid], -1);
PlayerTextDrawSetShadow(playerid, CKauf_FliegerH[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, CKauf_FliegerH[playerid], 255);
PlayerTextDrawFont(playerid, CKauf_FliegerH[playerid], 5);
PlayerTextDrawSetProportional(playerid, CKauf_FliegerH[playerid], 0);
PlayerTextDrawSetSelectable(playerid, CKauf_FliegerH[playerid], false);
PlayerTextDrawSetPreviewModel(playerid, CKauf_FliegerH[playerid], 476);
PlayerTextDrawSetPreviewRot(playerid, CKauf_FliegerH[playerid], -27.000000, 0.000000, -27.000000, 0.699998);
PlayerTextDrawSetPreviewVehCol(playerid, CKauf_FliegerH[playerid], 1, 6);

CKauf_Flieger[playerid] = CreatePlayerTextDraw(playerid, 258.333099, 94.022254, "");
PlayerTextDrawTextSize(playerid, CKauf_Flieger[playerid], 90.000000, 90.000000);
PlayerTextDrawAlignment(playerid, CKauf_Flieger[playerid], 1);
PlayerTextDrawColor(playerid, CKauf_Flieger[playerid], -1);
PlayerTextDrawSetShadow(playerid, CKauf_Flieger[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, CKauf_Flieger[playerid], 255);
PlayerTextDrawFont(playerid, CKauf_Flieger[playerid], 5);
PlayerTextDrawSetProportional(playerid, CKauf_Flieger[playerid], 0);
PlayerTextDrawSetSelectable(playerid, CKauf_Flieger[playerid], true);
PlayerTextDrawSetPreviewModel(playerid, CKauf_Flieger[playerid], 476);
PlayerTextDrawSetPreviewRot(playerid, CKauf_Flieger[playerid], -27.000000, 0.000000, -27.000000, 0.699998);
PlayerTextDrawSetPreviewVehCol(playerid, CKauf_Flieger[playerid], 1, 6);

CKauf_FliegerN[playerid] = CreatePlayerTextDraw(playerid, 303.666625, 189.999832, "Planes");
PlayerTextDrawLetterSize(playerid, CKauf_FliegerN[playerid], 0.400000, 1.600000);
PlayerTextDrawTextSize(playerid, CKauf_FliegerN[playerid], 0.000000, 87.000000);
PlayerTextDrawAlignment(playerid, CKauf_FliegerN[playerid], 2);
PlayerTextDrawColor(playerid, CKauf_FliegerN[playerid], -1);
PlayerTextDrawUseBox(playerid, CKauf_FliegerN[playerid], 1);
PlayerTextDrawBoxColor(playerid, CKauf_FliegerN[playerid], 255);
PlayerTextDrawSetShadow(playerid, CKauf_FliegerN[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, CKauf_FliegerN[playerid], 255);
PlayerTextDrawFont(playerid, CKauf_FliegerN[playerid], 1);
PlayerTextDrawSetProportional(playerid, CKauf_FliegerN[playerid], 1);

CKauf_HausH[playerid] = CreatePlayerTextDraw(playerid, 354.666381, 94.022239, "");
PlayerTextDrawTextSize(playerid, CKauf_HausH[playerid], 90.000000, 90.000000);
PlayerTextDrawAlignment(playerid, CKauf_HausH[playerid], 1);
PlayerTextDrawColor(playerid, CKauf_HausH[playerid], -1);
PlayerTextDrawSetShadow(playerid, CKauf_HausH[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, CKauf_HausH[playerid], 255);
PlayerTextDrawFont(playerid, CKauf_HausH[playerid], 5);
PlayerTextDrawSetProportional(playerid, CKauf_HausH[playerid], 0);
PlayerTextDrawSetSelectable(playerid, CKauf_HausH[playerid], false);
PlayerTextDrawSetPreviewModel(playerid, CKauf_HausH[playerid], 3310);
PlayerTextDrawSetPreviewRot(playerid, CKauf_HausH[playerid], -27.000000, 0.000000, -27.000000, 0.699998);

CKauf_Haus[playerid] = CreatePlayerTextDraw(playerid, 354.666381, 94.022239, "");
PlayerTextDrawTextSize(playerid, CKauf_Haus[playerid], 90.000000, 90.000000);
PlayerTextDrawAlignment(playerid, CKauf_Haus[playerid], 1);
PlayerTextDrawColor(playerid, CKauf_Haus[playerid], -1);
PlayerTextDrawSetShadow(playerid, CKauf_Haus[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, CKauf_Haus[playerid], 255);
PlayerTextDrawFont(playerid, CKauf_Haus[playerid], 5);
PlayerTextDrawSetProportional(playerid, CKauf_Haus[playerid], 0);
PlayerTextDrawSetSelectable(playerid, CKauf_Haus[playerid], true);
PlayerTextDrawSetPreviewModel(playerid, CKauf_Haus[playerid], 3310);
PlayerTextDrawSetPreviewRot(playerid, CKauf_Haus[playerid], -27.000000, 0.000000, -27.000000, 0.699998);

CKauf_HausN[playerid] = CreatePlayerTextDraw(playerid, 399.666503, 189.585021, "Houses");
PlayerTextDrawLetterSize(playerid, CKauf_HausN[playerid], 0.400000, 1.600000);
PlayerTextDrawTextSize(playerid, CKauf_HausN[playerid], 0.000000, 87.000000);
PlayerTextDrawAlignment(playerid, CKauf_HausN[playerid], 2);
PlayerTextDrawColor(playerid, CKauf_HausN[playerid], -1);
PlayerTextDrawUseBox(playerid, CKauf_HausN[playerid], 1);
PlayerTextDrawBoxColor(playerid, CKauf_HausN[playerid], 255);
PlayerTextDrawSetShadow(playerid, CKauf_HausN[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, CKauf_HausN[playerid], 255);
PlayerTextDrawFont(playerid, CKauf_HausN[playerid], 1);
PlayerTextDrawSetProportional(playerid, CKauf_HausN[playerid], 1);

CKauf_BooteH[playerid] = CreatePlayerTextDraw(playerid, 259.999572, 222.614898, "");
PlayerTextDrawTextSize(playerid, CKauf_BooteH[playerid], 90.000000, 90.000000);
PlayerTextDrawAlignment(playerid, CKauf_BooteH[playerid], 1);
PlayerTextDrawColor(playerid, CKauf_BooteH[playerid], -1);
PlayerTextDrawSetShadow(playerid, CKauf_BooteH[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, CKauf_BooteH[playerid], 255);
PlayerTextDrawFont(playerid, CKauf_BooteH[playerid], 5);
PlayerTextDrawSetProportional(playerid, CKauf_BooteH[playerid], 0);
PlayerTextDrawSetSelectable(playerid, CKauf_BooteH[playerid], false);
PlayerTextDrawSetPreviewModel(playerid, CKauf_BooteH[playerid], 493);
PlayerTextDrawSetPreviewRot(playerid, CKauf_BooteH[playerid], -27.000000, 0.000000, -27.000000, 0.699998);
PlayerTextDrawSetPreviewVehCol(playerid, CKauf_BooteH[playerid], 0, 182);

CKauf_Boote[playerid] = CreatePlayerTextDraw(playerid, 259.999572, 222.614898, "");
PlayerTextDrawTextSize(playerid, CKauf_Boote[playerid], 90.000000, 90.000000);
PlayerTextDrawAlignment(playerid, CKauf_Boote[playerid], 1);
PlayerTextDrawColor(playerid, CKauf_Boote[playerid], -1);
PlayerTextDrawSetShadow(playerid, CKauf_Boote[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, CKauf_Boote[playerid], 255);
PlayerTextDrawFont(playerid, CKauf_Boote[playerid], 5);
PlayerTextDrawSetProportional(playerid, CKauf_Boote[playerid], 0);
PlayerTextDrawSetSelectable(playerid, CKauf_Boote[playerid], true);
PlayerTextDrawSetPreviewModel(playerid, CKauf_Boote[playerid], 493);
PlayerTextDrawSetPreviewRot(playerid, CKauf_Boote[playerid], -27.000000, 0.000000, -27.000000, 0.699998);
PlayerTextDrawSetPreviewVehCol(playerid, CKauf_Boote[playerid], 0, 182);

CKauf_BooteN[playerid] = CreatePlayerTextDraw(playerid, 304.999786, 317.762786, "Boats");
PlayerTextDrawLetterSize(playerid, CKauf_BooteN[playerid], 0.400000, 1.600000);
PlayerTextDrawTextSize(playerid, CKauf_BooteN[playerid], 0.000000, 87.000000);
PlayerTextDrawAlignment(playerid, CKauf_BooteN[playerid], 2);
PlayerTextDrawColor(playerid, CKauf_BooteN[playerid], -1);
PlayerTextDrawUseBox(playerid, CKauf_BooteN[playerid], 1);
PlayerTextDrawBoxColor(playerid, CKauf_BooteN[playerid], 255);
PlayerTextDrawSetShadow(playerid, CKauf_BooteN[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, CKauf_BooteN[playerid], 255);
PlayerTextDrawFont(playerid, CKauf_BooteN[playerid], 1);
PlayerTextDrawSetProportional(playerid, CKauf_BooteN[playerid], 1);

Schliessen[playerid] = CreatePlayerTextDraw(playerid, 439.333648, 61.251838, "pc:Schliessen");
PlayerTextDrawTextSize(playerid, Schliessen[playerid], 14.000000, 7.000000);
PlayerTextDrawAlignment(playerid, Schliessen[playerid], 1);
PlayerTextDrawColor(playerid, Schliessen[playerid], -1);
PlayerTextDrawSetShadow(playerid, Schliessen[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, Schliessen[playerid], 255);
PlayerTextDrawFont(playerid, Schliessen[playerid], 4);
PlayerTextDrawSetProportional(playerid, Schliessen[playerid], 0);
PlayerTextDrawSetSelectable(playerid, Schliessen[playerid], true);

Bildschirm[playerid] = CreatePlayerTextDraw(playerid, -96.999984, -20.466674, "pc:Bildschirm");
PlayerTextDrawTextSize(playerid, Bildschirm[playerid], 804.000000, 485.000000);
PlayerTextDrawAlignment(playerid, Bildschirm[playerid], 1);
PlayerTextDrawColor(playerid, Bildschirm[playerid], -1);
PlayerTextDrawSetShadow(playerid, Bildschirm[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, Bildschirm[playerid], 255);
PlayerTextDrawFont(playerid, Bildschirm[playerid], 4);
PlayerTextDrawSetProportional(playerid, Bildschirm[playerid], 0);

Ausschaltknopf[playerid] = CreatePlayerTextDraw(playerid, 423.000000, 389.785247, "pc:Ausschaltknopf");
PlayerTextDrawTextSize(playerid, Ausschaltknopf[playerid], 36.000000, 45.000000);
PlayerTextDrawAlignment(playerid, Ausschaltknopf[playerid], 1);
PlayerTextDrawColor(playerid, Ausschaltknopf[playerid], -1);
PlayerTextDrawSetShadow(playerid, Ausschaltknopf[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, Ausschaltknopf[playerid], 255);
PlayerTextDrawFont(playerid, Ausschaltknopf[playerid], 4);
PlayerTextDrawSetProportional(playerid, Ausschaltknopf[playerid], 0);
PlayerTextDrawSetSelectable(playerid, Ausschaltknopf[playerid], true);

ComEx1[playerid] = CreatePlayerTextDraw(playerid, 401.666625, 358.259429, "LD_NONE:explm01");
PlayerTextDrawTextSize(playerid, ComEx1[playerid], 64.000000, 69.000000);
PlayerTextDrawAlignment(playerid, ComEx1[playerid], 1);
PlayerTextDrawColor(playerid, ComEx1[playerid], -1);
PlayerTextDrawSetShadow(playerid, ComEx1[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, ComEx1[playerid], 255);
PlayerTextDrawFont(playerid, ComEx1[playerid], 4);
PlayerTextDrawSetProportional(playerid, ComEx1[playerid], 0);

ComEx2[playerid] = CreatePlayerTextDraw(playerid, 401.666625, 358.259429, "LD_NONE:explm02");
PlayerTextDrawTextSize(playerid, ComEx2[playerid], 64.000000, 69.000000);
PlayerTextDrawAlignment(playerid, ComEx2[playerid], 1);
PlayerTextDrawColor(playerid, ComEx2[playerid], -1);
PlayerTextDrawSetShadow(playerid, ComEx2[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, ComEx2[playerid], 255);
PlayerTextDrawFont(playerid, ComEx2[playerid], 4);
PlayerTextDrawSetProportional(playerid, ComEx2[playerid], 0);

ComEx3[playerid] = CreatePlayerTextDraw(playerid, 401.666625, 358.259429, "LD_NONE:explm03");
PlayerTextDrawTextSize(playerid, ComEx3[playerid], 64.000000, 69.000000);
PlayerTextDrawAlignment(playerid, ComEx3[playerid], 1);
PlayerTextDrawColor(playerid, ComEx3[playerid], -1);
PlayerTextDrawSetShadow(playerid, ComEx3[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, ComEx3[playerid], 255);
PlayerTextDrawFont(playerid, ComEx3[playerid], 4);
PlayerTextDrawSetProportional(playerid, ComEx3[playerid], 0);

ComEx4[playerid] = CreatePlayerTextDraw(playerid, 401.666625, 358.259429, "LD_NONE:explm04");
PlayerTextDrawTextSize(playerid, ComEx4[playerid], 64.000000, 69.000000);
PlayerTextDrawAlignment(playerid, ComEx4[playerid], 1);
PlayerTextDrawColor(playerid, ComEx4[playerid], -1);
PlayerTextDrawSetShadow(playerid, ComEx4[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, ComEx4[playerid], 255);
PlayerTextDrawFont(playerid, ComEx4[playerid], 4);
PlayerTextDrawSetProportional(playerid, ComEx4[playerid], 0);

ComEx5[playerid] = CreatePlayerTextDraw(playerid, 401.666625, 358.259429, "LD_NONE:explm05");
PlayerTextDrawTextSize(playerid, ComEx5[playerid], 64.000000, 69.000000);
PlayerTextDrawAlignment(playerid, ComEx5[playerid], 1);
PlayerTextDrawColor(playerid, ComEx5[playerid], -1);
PlayerTextDrawSetShadow(playerid, ComEx5[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, ComEx5[playerid], 255);
PlayerTextDrawFont(playerid, ComEx5[playerid], 4);
PlayerTextDrawSetProportional(playerid, ComEx5[playerid], 0);

ComEx6[playerid] = CreatePlayerTextDraw(playerid, 401.666625, 358.259429, "LD_NONE:explm06");
PlayerTextDrawTextSize(playerid, ComEx6[playerid], 64.000000, 69.000000);
PlayerTextDrawAlignment(playerid, ComEx6[playerid], 1);
PlayerTextDrawColor(playerid, ComEx6[playerid], -1);
PlayerTextDrawSetShadow(playerid, ComEx6[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, ComEx6[playerid], 255);
PlayerTextDrawFont(playerid, ComEx6[playerid], 4);
PlayerTextDrawSetProportional(playerid, ComEx6[playerid], 0);

ComEx7[playerid] = CreatePlayerTextDraw(playerid, 401.666625, 358.259429, "LD_NONE:explm07");
PlayerTextDrawTextSize(playerid, ComEx7[playerid], 64.000000, 69.000000);
PlayerTextDrawAlignment(playerid, ComEx7[playerid], 1);
PlayerTextDrawColor(playerid, ComEx7[playerid], -1);
PlayerTextDrawSetShadow(playerid, ComEx7[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, ComEx7[playerid], 255);
PlayerTextDrawFont(playerid, ComEx7[playerid], 4);
PlayerTextDrawSetProportional(playerid, ComEx7[playerid], 0);

ComEx8[playerid] = CreatePlayerTextDraw(playerid, 401.666625, 358.259429, "LD_NONE:explm08");
PlayerTextDrawTextSize(playerid, ComEx8[playerid], 64.000000, 69.000000);
PlayerTextDrawAlignment(playerid, ComEx8[playerid], 1);
PlayerTextDrawColor(playerid, ComEx8[playerid], -1);
PlayerTextDrawSetShadow(playerid, ComEx8[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, ComEx8[playerid], 255);
PlayerTextDrawFont(playerid, ComEx8[playerid], 4);
PlayerTextDrawSetProportional(playerid, ComEx8[playerid], 0);

ComEx9[playerid] = CreatePlayerTextDraw(playerid, 401.666625, 358.259429, "LD_NONE:explm09");
PlayerTextDrawTextSize(playerid, ComEx9[playerid], 64.000000, 69.000000);
PlayerTextDrawAlignment(playerid, ComEx9[playerid], 1);
PlayerTextDrawColor(playerid, ComEx9[playerid], -1);
PlayerTextDrawSetShadow(playerid, ComEx9[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, ComEx9[playerid], 255);
PlayerTextDrawFont(playerid, ComEx9[playerid], 4);
PlayerTextDrawSetProportional(playerid, ComEx9[playerid], 0);

ComEx10[playerid] = CreatePlayerTextDraw(playerid, 401.666625, 358.259429, "LD_NONE:explm010");
PlayerTextDrawTextSize(playerid, ComEx10[playerid], 64.000000, 69.000000);
PlayerTextDrawAlignment(playerid, ComEx10[playerid], 1);
PlayerTextDrawColor(playerid, ComEx10[playerid], -1);
PlayerTextDrawSetShadow(playerid, ComEx10[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, ComEx10[playerid], 255);
PlayerTextDrawFont(playerid, ComEx10[playerid], 4);
PlayerTextDrawSetProportional(playerid, ComEx10[playerid], 0);

ComEx11[playerid] = CreatePlayerTextDraw(playerid, 401.666625, 358.259429, "LD_NONE:explm011");
PlayerTextDrawTextSize(playerid, ComEx11[playerid], 64.000000, 69.000000);
PlayerTextDrawAlignment(playerid, ComEx11[playerid], 1);
PlayerTextDrawColor(playerid, ComEx11[playerid], -1);
PlayerTextDrawSetShadow(playerid, ComEx11[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, ComEx11[playerid], 255);
PlayerTextDrawFont(playerid, ComEx11[playerid], 4);
PlayerTextDrawSetProportional(playerid, ComEx11[playerid], 0);

ComEx12[playerid] = CreatePlayerTextDraw(playerid, 401.666625, 358.259429, "LD_NONE:explm012");
PlayerTextDrawTextSize(playerid, ComEx12[playerid], 64.000000, 69.000000);
PlayerTextDrawAlignment(playerid, ComEx12[playerid], 1);
PlayerTextDrawColor(playerid, ComEx12[playerid], -1);
PlayerTextDrawSetShadow(playerid, ComEx12[playerid], 0);
PlayerTextDrawBackgroundColor(playerid, ComEx12[playerid], 255);
PlayerTextDrawFont(playerid, ComEx12[playerid], 4);
PlayerTextDrawSetProportional(playerid, ComEx12[playerid], 0);
return 1;
}

stock IsPlayerInRangeOfComputer(playerid, objectid)
{
    new Float:x, Float:y, Float:z;
    GetObjectPos(objectid, x, y, z);
    IsPlayerInRangeOfPoint(playerid, 2, x, y, z);
    return 1;
}

public OnPlayerText(playerid, text[])
{
	if(Showing[playerid] == 1)
	{
        return 1;
    }
    return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
     if (newkeys == KEY_WALK)
		{
             if (IsPlayerInRangeOfComputer(playerid, 2165))
             {
               if(Showing[playerid] == 0)
	           {
	            TogglePlayerControllable(playerid,false);
			    Showing[playerid] = 1;
			    SendClientMessage(playerid, -1, " ");
			    SendClientMessage(playerid, -1, " ");
			    SendClientMessage(playerid, -1, " ");
			    SendClientMessage(playerid, -1, " ");
			    SendClientMessage(playerid, -1, " ");
			    SendClientMessage(playerid, -1, " ");
			    SendClientMessage(playerid, -1, " ");
			    SendClientMessage(playerid, -1, " ");
			    SendClientMessage(playerid, -1, " ");
			    SendClientMessage(playerid, -1, " ");
			    SendClientMessage(playerid, -1, " ");
			    SendClientMessage(playerid, -1, " ");
			    SendClientMessage(playerid, -1, " ");
			    SendClientMessage(playerid, -1, " ");
			    SendClientMessage(playerid, -1, " ");
			    SendClientMessage(playerid, -1, " ");
			    SendClientMessage(playerid, -1, " ");
			    SendClientMessage(playerid, -1, " ");
			    SendClientMessage(playerid, -1, " ");
			    SendClientMessage(playerid, -1, " ");
			    GetPlayerName(playerid,Sname,sizeof(Sname));
                format(Spieler,sizeof(Spieler),"/Spieler/%s.txt",Sname);
                if(!strcmp("Hintergrund1",dini_Get(Spieler,"ComHintergrund"),true))
	            {
	              PlayerTextDrawShow(playerid,PlayerText:Hintergrund1[playerid]);
	            }
	            else if(!strcmp("Hintergrund2",dini_Get(Spieler,"ComHintergrund"),true))
	            {
	              PlayerTextDrawShow(playerid,PlayerText:Hintergrund2[playerid]);
	            }
	            else if(!strcmp("Hintergrund3",dini_Get(Spieler,"ComHintergrund"),true))
	            {
	              PlayerTextDrawShow(playerid,PlayerText:Hintergrund3[playerid]);
	            }
	            else if(!strcmp("Hintergrund4",dini_Get(Spieler,"ComHintergrund"),true))
	            {
	              PlayerTextDrawShow(playerid,PlayerText:Hintergrund4[playerid]);
	            }
	            else if(!strcmp("Hintergrund5",dini_Get(Spieler,"ComHintergrund"),true))
	            {
	              PlayerTextDrawShow(playerid,PlayerText:Hintergrund5[playerid]);
	            }
	            else if(!strcmp("Hintergrund6",dini_Get(Spieler,"ComHintergrund"),true))
	            {
	              PlayerTextDrawShow(playerid,PlayerText:Hintergrund6[playerid]);
	            }
	            else if(!strcmp("Hintergrund7",dini_Get(Spieler,"ComHintergrund"),true))
	            {
	              PlayerTextDrawShow(playerid,PlayerText:Hintergrund7[playerid]);
	            }
	            else
	            {
	              PlayerTextDrawShow(playerid,PlayerText:Hintergrund1[playerid]);
	            }

	              PlayerTextDrawShow(playerid,PlayerText:Bildschirm[playerid]);
	              PlayerTextDrawShow(playerid,PlayerText:Ausschaltknopf[playerid]);
	              PlayerTextDrawShow(playerid,PlayerText:Papierkorb[playerid]);
	              PlayerTextDrawShow(playerid,PlayerText:Internet[playerid]);
	              PlayerTextDrawShow(playerid,PlayerText:Hausaufgabe[playerid]);
	              PlayerTextDrawShow(playerid,PlayerText:Einstellungen[playerid]);
	              PlayerTextDrawShow(playerid,PlayerText:Email[playerid]);
	              PlayerTextDrawShow(playerid,PlayerText:SAMP[playerid]);
	              PlayerTextDrawShow(playerid,PlayerText:Spiele[playerid]);
	              PlayerTextDrawShow(playerid,PlayerText:Notizen[playerid]);
	              SelectTextDraw(playerid,0x000000AB);
                  TogglePlayerControllable(playerid,1);
             }
			
		}
	
	}
	return 1;
}


public OnPlayerClickPlayerTextDraw(playerid, PlayerText:playertextid)
{
new pname[MAX_PLAYER_NAME], string[40 + MAX_PLAYER_NAME];
GetPlayerName(playerid, pname, sizeof(pname));

     if(playertextid == Ausschaltknopf[playerid])
     {
       if(Showing[playerid] == 1)
       {
			Showing[playerid] = 0;
            PlayerTextDrawHide(playerid,PlayerText:Bildschirm[playerid]);
            PlayerTextDrawHide(playerid,PlayerText:Ausschaltknopf[playerid]);
            PlayerTextDrawHide(playerid,PlayerText:Hintergrund1[playerid]);
            PlayerTextDrawHide(playerid,PlayerText:Hintergrund2[playerid]);
            PlayerTextDrawHide(playerid,PlayerText:Hintergrund3[playerid]);
            PlayerTextDrawHide(playerid,PlayerText:Hintergrund4[playerid]);
            PlayerTextDrawHide(playerid,PlayerText:Hintergrund5[playerid]);
            PlayerTextDrawHide(playerid,PlayerText:Hintergrund6[playerid]);
            PlayerTextDrawHide(playerid,PlayerText:Hintergrund7[playerid]);
            PlayerTextDrawHide(playerid,PlayerText:Papierkorb[playerid]);
            PlayerTextDrawHide(playerid,PlayerText:Internet[playerid]);
            PlayerTextDrawHide(playerid,PlayerText:Hausaufgabe[playerid]);
            PlayerTextDrawHide(playerid,PlayerText:Einstellungen[playerid]);
            PlayerTextDrawHide(playerid,PlayerText:Email[playerid]);
            PlayerTextDrawHide(playerid,PlayerText:SAMP[playerid]);
            PlayerTextDrawHide(playerid,PlayerText:Notizen[playerid]);
            PlayerTextDrawHide(playerid,PlayerText:Spiele[playerid]);
            PlayerTextDrawHide(playerid,PlayerText:PapierHinter[playerid]);
            PlayerTextDrawHide(playerid,PlayerText:Schliessen[playerid]);
            PlayerTextDrawHide(playerid,PlayerText:mHintergrund1[playerid]);
            PlayerTextDrawHide(playerid,PlayerText:mHintergrund2[playerid]);
            PlayerTextDrawHide(playerid,PlayerText:mHintergrund3[playerid]);
            PlayerTextDrawHide(playerid,PlayerText:mHintergrund4[playerid]);
            PlayerTextDrawHide(playerid,PlayerText:mHintergrund5[playerid]);
            PlayerTextDrawHide(playerid,PlayerText:mHintergrund6[playerid]);
            PlayerTextDrawHide(playerid,PlayerText:mHintergrund7[playerid]);
            PlayerTextDrawHide(playerid,PlayerText:Hintergrunda[playerid]);
            PlayerTextDrawHide(playerid,PlayerText:Websites[playerid]);
            PlayerTextDrawHide(playerid,PlayerText:AddNote[playerid]);
            PlayerTextDrawHide(playerid,PlayerText:Note[playerid]);
            PlayerTextDrawHide(playerid,PlayerText:KeineDateien[playerid]);
            PlayerTextDrawHide(playerid,PlayerText:NothingFound[playerid]);
            PlayerTextDrawHide(playerid,PlayerText:Web_Hintergrund[playerid]);
            PlayerTextDrawHide(playerid,PlayerText:googl[playerid]);
            PlayerTextDrawHide(playerid,PlayerText:GooglSearch[playerid]);
            PlayerTextDrawHide(playerid,PlayerText:NFX[playerid]);
            PlayerTextDrawHide(playerid,PlayerText:rickrolld[playerid]);
            PlayerTextDrawHide(playerid,PlayerText:COFYes[playerid]);
            PlayerTextDrawHide(playerid,CKauf_Flieger[playerid]);
            PlayerTextDrawHide(playerid,CKauf_FliegerN[playerid]);
            PlayerTextDrawHide(playerid,CKauf_FliegerH[playerid]);
            PlayerTextDrawHide(playerid,CKauf_Militar[playerid]);
            PlayerTextDrawHide(playerid,CKauf_MilitarN[playerid]);
            PlayerTextDrawHide(playerid,CKauf_MilitarH[playerid]);
            PlayerTextDrawHide(playerid,CKauf_Autos[playerid]);
            PlayerTextDrawHide(playerid,CKauf_AutosN[playerid]);
            PlayerTextDrawHide(playerid,CKauf_AutosH[playerid]);
            PlayerTextDrawHide(playerid,CKauf_Boote[playerid]);
            PlayerTextDrawHide(playerid,CKauf_BooteN[playerid]);
            PlayerTextDrawHide(playerid,CKauf_BooteH[playerid]);
            PlayerTextDrawHide(playerid,CKauf_Haus[playerid]);
            PlayerTextDrawHide(playerid,CKauf_HausN[playerid]);
            PlayerTextDrawHide(playerid,CKauf_HausH[playerid]);
            StopAudioStreamForPlayer(playerid);
            CancelSelectTextDraw(playerid);
            TogglePlayerControllable(playerid,true);
       }
     }
     if(playertextid == Hausaufgabe[playerid])
      {
	   format(string, sizeof(string), "%s has been kicked for opening the `homework´ folder", pname);
       SendClientMessageToAll(0xFF0000FF, string);
       format(string, sizeof(string), "=============>> %s hat die Hausaufgaben geöffnet xD", pname);
       print(string);
       SetTimerEx("DelayedKick", 100, false, "i", playerid);
       return 1;
     }
     if(playertextid == Notizen[playerid])
	  {
	  //new note1_[10];
            PlayerTextDrawHide(playerid,PlayerText:Papierkorb[playerid]);
            PlayerTextDrawHide(playerid,PlayerText:Internet[playerid]);
            PlayerTextDrawHide(playerid,PlayerText:Hausaufgabe[playerid]);
            PlayerTextDrawHide(playerid,PlayerText:Einstellungen[playerid]);
            PlayerTextDrawHide(playerid,PlayerText:Email[playerid]);
            PlayerTextDrawHide(playerid,PlayerText:SAMP[playerid]);
            PlayerTextDrawHide(playerid,PlayerText:Notizen[playerid]);
            PlayerTextDrawHide(playerid,PlayerText:Spiele[playerid]);
            PlayerTextDrawShow(playerid,PlayerText:PapierHinter[playerid]);
            PlayerTextDrawShow(playerid,PlayerText:Schliessen[playerid]);
            PlayerTextDrawShow(playerid,PlayerText:Websites[playerid]);
            PlayerTextDrawShow(playerid,PlayerText:AddNote[playerid]);
            PlayerTextDrawShow(playerid,PlayerText:Note[playerid]);
	        /*if(!strcmp("1",dini_Get(Spieler,"CNotiz"),true))
	        {
	        PlayerTextDrawShow(playerid, PlayerText:Notiz1_[playerid]);
	        format(Spieler,sizeof(Spieler),"/Spieler/%s.txt",Sname);
	        dini_Get(Sname, note1_)
	        PlayerTextDrawSetString(playerid,PlayerText: Notiz1_, note1_);
	        }*/
	  }
     if(playertextid == Papierkorb[playerid])
	  {
            PlayerTextDrawHide(playerid,PlayerText:Papierkorb[playerid]);
            PlayerTextDrawHide(playerid,PlayerText:Internet[playerid]);
            PlayerTextDrawHide(playerid,PlayerText:Hausaufgabe[playerid]);
            PlayerTextDrawHide(playerid,PlayerText:Einstellungen[playerid]);
            PlayerTextDrawHide(playerid,PlayerText:Email[playerid]);
            PlayerTextDrawHide(playerid,PlayerText:SAMP[playerid]);
            PlayerTextDrawHide(playerid,PlayerText:Notizen[playerid]);
            PlayerTextDrawHide(playerid,PlayerText:Spiele[playerid]);
            PlayerTextDrawShow(playerid,PlayerText:PapierHinter[playerid]);
            PlayerTextDrawShow(playerid,PlayerText:Schliessen[playerid]);
            PlayerTextDrawShow(playerid,PlayerText:KeineDateien[playerid]);
	  }
     if(playertextid == Schliessen[playerid])
	  {
            PlayerTextDrawHide(playerid,PlayerText:Schliessen[playerid]);
            PlayerTextDrawHide(playerid,PlayerText:PapierHinter[playerid]);
            PlayerTextDrawHide(playerid,PlayerText:KeineDateien[playerid]);
            PlayerTextDrawHide(playerid,PlayerText:mHintergrund1[playerid]);
            PlayerTextDrawHide(playerid,PlayerText:mHintergrund2[playerid]);
            PlayerTextDrawHide(playerid,PlayerText:mHintergrund3[playerid]);
            PlayerTextDrawHide(playerid,PlayerText:mHintergrund4[playerid]);
            PlayerTextDrawHide(playerid,PlayerText:mHintergrund5[playerid]);
            PlayerTextDrawHide(playerid,PlayerText:mHintergrund6[playerid]);
            PlayerTextDrawHide(playerid,PlayerText:mHintergrund7[playerid]);
            PlayerTextDrawShow(playerid,PlayerText:Papierkorb[playerid]);
            PlayerTextDrawShow(playerid,PlayerText:Internet[playerid]);
            PlayerTextDrawShow(playerid,PlayerText:Hausaufgabe[playerid]);
            PlayerTextDrawShow(playerid,PlayerText:Einstellungen[playerid]);
            PlayerTextDrawShow(playerid,PlayerText:Email[playerid]);
            PlayerTextDrawShow(playerid,PlayerText:SAMP[playerid]);
            PlayerTextDrawShow(playerid,PlayerText:Notizen[playerid]);
            PlayerTextDrawShow(playerid,PlayerText:Spiele[playerid]);
            PlayerTextDrawHide(playerid,PlayerText:Hintergrunda[playerid]);
            PlayerTextDrawHide(playerid,PlayerText:Websites[playerid]);
            PlayerTextDrawHide(playerid,PlayerText:AddNote[playerid]);
            PlayerTextDrawHide(playerid,PlayerText:Note[playerid]);
            PlayerTextDrawHide(playerid,PlayerText:Web_Hintergrund[playerid]);
            PlayerTextDrawHide(playerid,PlayerText:googl[playerid]);
            PlayerTextDrawHide(playerid,PlayerText:GooglSearch[playerid]);
            PlayerTextDrawHide(playerid,PlayerText:NothingFound[playerid]);
            PlayerTextDrawHide(playerid,PlayerText:NFX[playerid]);
            PlayerTextDrawHide(playerid,PlayerText:rickrolld[playerid]);
            PlayerTextDrawHide(playerid,PlayerText:COFYes[playerid]);
            PlayerTextDrawHide(playerid,CKauf_Flieger[playerid]);
            PlayerTextDrawHide(playerid,CKauf_FliegerN[playerid]);
            PlayerTextDrawHide(playerid,CKauf_FliegerH[playerid]);
            PlayerTextDrawHide(playerid,CKauf_Militar[playerid]);
            PlayerTextDrawHide(playerid,CKauf_MilitarN[playerid]);
            PlayerTextDrawHide(playerid,CKauf_MilitarH[playerid]);
            PlayerTextDrawHide(playerid,CKauf_Autos[playerid]);
            PlayerTextDrawHide(playerid,CKauf_AutosN[playerid]);
            PlayerTextDrawHide(playerid,CKauf_AutosH[playerid]);
            PlayerTextDrawHide(playerid,CKauf_Boote[playerid]);
            PlayerTextDrawHide(playerid,CKauf_BooteN[playerid]);
            PlayerTextDrawHide(playerid,CKauf_BooteH[playerid]);
            PlayerTextDrawHide(playerid,CKauf_Haus[playerid]);
            PlayerTextDrawHide(playerid,CKauf_HausN[playerid]);
            PlayerTextDrawHide(playerid,CKauf_HausH[playerid]);
            StopAudioStreamForPlayer(playerid);
	  }
     if(playertextid == Spiele[playerid])
	  {
            PlayerTextDrawHide(playerid,PlayerText:Papierkorb[playerid]);
            PlayerTextDrawHide(playerid,PlayerText:Internet[playerid]);
            PlayerTextDrawHide(playerid,PlayerText:Hausaufgabe[playerid]);
            PlayerTextDrawHide(playerid,PlayerText:Einstellungen[playerid]);
            PlayerTextDrawHide(playerid,PlayerText:Email[playerid]);
            PlayerTextDrawHide(playerid,PlayerText:SAMP[playerid]);
            PlayerTextDrawHide(playerid,PlayerText:Notizen[playerid]);
            PlayerTextDrawHide(playerid,PlayerText:Spiele[playerid]);
            PlayerTextDrawShow(playerid,PlayerText:PapierHinter[playerid]);
            PlayerTextDrawShow(playerid,PlayerText:Schliessen[playerid]);
	  }
     if(playertextid == Einstellungen[playerid])
	  {
            PlayerTextDrawShow(playerid,PlayerText:PapierHinter[playerid]);
            PlayerTextDrawShow(playerid,PlayerText:Schliessen[playerid]);
            PlayerTextDrawShow(playerid,PlayerText:Hintergrunda[playerid]);
            PlayerTextDrawShow(playerid,PlayerText:mHintergrund1[playerid]);
            PlayerTextDrawShow(playerid,PlayerText:mHintergrund2[playerid]);
            PlayerTextDrawShow(playerid,PlayerText:mHintergrund3[playerid]);
            PlayerTextDrawShow(playerid,PlayerText:mHintergrund4[playerid]);
            PlayerTextDrawShow(playerid,PlayerText:mHintergrund5[playerid]);
            PlayerTextDrawShow(playerid,PlayerText:mHintergrund6[playerid]);
            PlayerTextDrawShow(playerid,PlayerText:mHintergrund7[playerid]);
	  }
	 if(playertextid == mHintergrund1[playerid])
	  {
            PlayerTextDrawShow(playerid,PlayerText:Hintergrund1[playerid]);
            PlayerTextDrawHide(playerid,PlayerText:Hintergrund2[playerid]);
            PlayerTextDrawHide(playerid,PlayerText:Hintergrund3[playerid]);
            PlayerTextDrawHide(playerid,PlayerText:Hintergrund4[playerid]);
            PlayerTextDrawHide(playerid,PlayerText:Hintergrund5[playerid]);
            PlayerTextDrawHide(playerid,PlayerText:Hintergrund6[playerid]);
            PlayerTextDrawHide(playerid,PlayerText:Hintergrund7[playerid]);
            PlayerTextDrawShow(playerid,PlayerText:Bildschirm[playerid]);
            GetPlayerName(playerid,Sname,sizeof(Sname));
            format(Spieler,sizeof(Spieler),"/Spieler/%s.txt",Sname);
            dini_Set(Spieler,"ComHintergrund","Hintergrund1");
	        return 1;
	  }
	 if(playertextid == mHintergrund2[playerid])
	  {
            PlayerTextDrawShow(playerid,PlayerText:Hintergrund2[playerid]);
            PlayerTextDrawHide(playerid,PlayerText:Hintergrund1[playerid]);
            PlayerTextDrawHide(playerid,PlayerText:Hintergrund3[playerid]);
            PlayerTextDrawHide(playerid,PlayerText:Hintergrund4[playerid]);
            PlayerTextDrawHide(playerid,PlayerText:Hintergrund5[playerid]);
            PlayerTextDrawHide(playerid,PlayerText:Hintergrund6[playerid]);
            PlayerTextDrawHide(playerid,PlayerText:Hintergrund7[playerid]);
            PlayerTextDrawShow(playerid,PlayerText:Bildschirm[playerid]);
            GetPlayerName(playerid,Sname,sizeof(Sname));
            format(Spieler,sizeof(Spieler),"/Spieler/%s.txt",Sname);
            dini_Set(Spieler,"ComHintergrund","Hintergrund2");
	        return 1;
	  }
	 if(playertextid == mHintergrund3[playerid])
	  {
            PlayerTextDrawShow(playerid,PlayerText:Hintergrund3[playerid]);
            PlayerTextDrawHide(playerid,PlayerText:Hintergrund1[playerid]);
            PlayerTextDrawHide(playerid,PlayerText:Hintergrund2[playerid]);
            PlayerTextDrawHide(playerid,PlayerText:Hintergrund4[playerid]);
            PlayerTextDrawHide(playerid,PlayerText:Hintergrund5[playerid]);
            PlayerTextDrawHide(playerid,PlayerText:Hintergrund6[playerid]);
            PlayerTextDrawHide(playerid,PlayerText:Hintergrund7[playerid]);
            PlayerTextDrawShow(playerid,PlayerText:Bildschirm[playerid]);
            GetPlayerName(playerid,Sname,sizeof(Sname));
            format(Spieler,sizeof(Spieler),"/Spieler/%s.txt",Sname);
            dini_Set(Spieler,"ComHintergrund","Hintergrund3");
	        return 1;
	  }
	 if(playertextid == mHintergrund4[playerid])
	  {
            PlayerTextDrawShow(playerid,PlayerText:Hintergrund4[playerid]);
            PlayerTextDrawHide(playerid,PlayerText:Hintergrund1[playerid]);
            PlayerTextDrawHide(playerid,PlayerText:Hintergrund3[playerid]);
            PlayerTextDrawHide(playerid,PlayerText:Hintergrund2[playerid]);
            PlayerTextDrawHide(playerid,PlayerText:Hintergrund5[playerid]);
            PlayerTextDrawHide(playerid,PlayerText:Hintergrund6[playerid]);
            PlayerTextDrawHide(playerid,PlayerText:Hintergrund7[playerid]);
            PlayerTextDrawShow(playerid,PlayerText:Bildschirm[playerid]);
            GetPlayerName(playerid,Sname,sizeof(Sname));
            format(Spieler,sizeof(Spieler),"/Spieler/%s.txt",Sname);
            dini_Set(Spieler,"ComHintergrund","Hintergrund4");
	        return 1;
	  }
	 if(playertextid == mHintergrund5[playerid])
      {
            PlayerTextDrawShow(playerid,PlayerText:Hintergrund5[playerid]);
            PlayerTextDrawHide(playerid,PlayerText:Hintergrund1[playerid]);
            PlayerTextDrawHide(playerid,PlayerText:Hintergrund3[playerid]);
            PlayerTextDrawHide(playerid,PlayerText:Hintergrund4[playerid]);
            PlayerTextDrawHide(playerid,PlayerText:Hintergrund2[playerid]);
            PlayerTextDrawHide(playerid,PlayerText:Hintergrund6[playerid]);
            PlayerTextDrawHide(playerid,PlayerText:Hintergrund7[playerid]);
            PlayerTextDrawShow(playerid,PlayerText:Bildschirm[playerid]);
            GetPlayerName(playerid,Sname,sizeof(Sname));
            format(Spieler,sizeof(Spieler),"/Spieler/%s.txt",Sname);
            dini_Set(Spieler,"ComHintergrund","Hintergrund5");
	        return 1;
	  }
	 if(playertextid == mHintergrund6[playerid])
      {
            PlayerTextDrawShow(playerid,PlayerText:Hintergrund6[playerid]);
            PlayerTextDrawHide(playerid,PlayerText:Hintergrund1[playerid]);
            PlayerTextDrawHide(playerid,PlayerText:Hintergrund3[playerid]);
            PlayerTextDrawHide(playerid,PlayerText:Hintergrund4[playerid]);
            PlayerTextDrawHide(playerid,PlayerText:Hintergrund5[playerid]);
            PlayerTextDrawHide(playerid,PlayerText:Hintergrund2[playerid]);
            PlayerTextDrawHide(playerid,PlayerText:Hintergrund7[playerid]);
            PlayerTextDrawShow(playerid,PlayerText:Bildschirm[playerid]);
            GetPlayerName(playerid,Sname,sizeof(Sname));
            format(Spieler,sizeof(Spieler),"/Spieler/%s.txt",Sname);
            dini_Set(Spieler,"ComHintergrund","Hintergrund6");
	        return 1;
	  }
	 if(playertextid == mHintergrund7[playerid])
      {
            PlayerTextDrawShow(playerid,PlayerText:Hintergrund7[playerid]);
            PlayerTextDrawHide(playerid,PlayerText:Hintergrund1[playerid]);
            PlayerTextDrawHide(playerid,PlayerText:Hintergrund3[playerid]);
            PlayerTextDrawHide(playerid,PlayerText:Hintergrund4[playerid]);
            PlayerTextDrawHide(playerid,PlayerText:Hintergrund5[playerid]);
            PlayerTextDrawHide(playerid,PlayerText:Hintergrund6[playerid]);
            PlayerTextDrawHide(playerid,PlayerText:Hintergrund2[playerid]);
            PlayerTextDrawShow(playerid,PlayerText:Bildschirm[playerid]);
            GetPlayerName(playerid,Sname,sizeof(Sname));
            format(Spieler,sizeof(Spieler),"/Spieler/%s.txt",Sname);
            dini_Set(Spieler,"ComHintergrund","Hintergrund7");
	        return 1;
	  }
	 if(playertextid == Note[playerid])
      {
            PlayerTextDrawHide(playerid,PlayerText:Websites[playerid]);
            PlayerTextDrawHide(playerid,PlayerText:Note[playerid]);
		    return 1;
	  }
	 if(playertextid == AddNote[playerid])
      {
       	 {
	        ShowPlayerDialog(playerid,TITEL,DIALOG_STYLE_INPUT,"Add note","Type here the titel for the note","Next","Exit");
       	 }

	  }
	 if(playertextid == Internet[playerid])
      {
            PlayerTextDrawShow(playerid,PlayerText:Web_Hintergrund[playerid]);
            PlayerTextDrawShow(playerid,PlayerText:PapierHinter[playerid]);
            PlayerTextDrawShow(playerid,PlayerText:googl[playerid]);
            PlayerTextDrawShow(playerid,PlayerText:GooglSearch[playerid]);
            PlayerTextDrawShow(playerid,PlayerText:Schliessen[playerid]);
		    return 1;
	  }
	 if(playertextid == GooglSearch[playerid])
	  {
            ShowPlayerDialog(playerid, INTERNET, DIALOG_STYLE_INPUT, "Googl", "Type a correct internet address", "Search", "Exit");
	  }
return 1;
}

public OnDialogResponse(playerid,dialogid,response,listitem,inputtext[])
{
	 if (dialogid == TITEL)
	 {
		  if (response == 0)
		  {
			   return 1;
		  }
		  if (response == 1)
		  {
			   Titel(playerid,inputtext);

		  }
		  return 1;
	 }
	 if (dialogid == TEXT)
	 {
		  if (response == 0)
		  {
			   return 1;
		  }
		  if (response == 1)
		  {
			   Text(playerid,inputtext);

		  }
		  return 1;
	 }
	 if (dialogid == INTERNET)
	 {
		  if (response == 0)
		  {
               PlayerTextDrawHide(playerid,PlayerText:Web_Hintergrund[playerid]);
               PlayerTextDrawHide(playerid,PlayerText:PapierHinter[playerid]);
			   PlayerTextDrawHide(playerid,PlayerText:googl[playerid]);
               PlayerTextDrawHide(playerid,PlayerText:GooglSearch[playerid]);
               PlayerTextDrawHide(playerid,PlayerText:Schliessen[playerid]);
			   return 1;
		  }
		  if (response == 1)
		  {
			   Websiten(playerid,inputtext);

		  }
		  return 1;
	 }
	 return 1;
}

stock Websiten(playerid,inputtext[])
{
	 if (!strlen(inputtext))
	 {
          PlayerTextDrawShow(playerid,PlayerText:NothingFound[playerid]);
          PlayerTextDrawShow(playerid,PlayerText:NFX[playerid]);
	 }
	 else if(!strcmp(inputtext,"www.wika.pl",true))
	 {
		  SendClientMessage(playerid,0xFF0000FF,"HOW DID YOU GET HERE???");
		  SendClientMessage(playerid,0x00FF00FF,"HOW DID YOU GET HERE???");
		  SendClientMessage(playerid,0x0091FFFF,"HOW DID YOU GET HERE???");
		  SendClientMessage(playerid,0xB00000FF,"HOW DID YOU GET HERE???");
		  SendClientMessage(playerid,0x008900FF,"HOW DID YOU GET HERE???");
		  SendClientMessage(playerid,0x0000FFFF,"HOW DID YOU GET HERE???");
		  SendClientMessage(playerid,0xFF0000FF,"HOW DID YOU GET HERE???");
		  SendClientMessage(playerid,0x00FF00FF,"HOW DID YOU GET HERE???");
		  SendClientMessage(playerid,0x0091FFFF,"HOW DID YOU GET HERE???");
		  SendClientMessage(playerid,0xB00000FF,"HOW DID YOU GET HERE???");
		  SendClientMessage(playerid,0x008900FF,"HOW DID YOU GET HERE???");
		  SendClientMessage(playerid,0x0000FFFF,"HOW DID YOU GET HERE???");
		  SendClientMessage(playerid,0xFF0000FF,"HOW DID YOU GET HERE???");
		  SendClientMessage(playerid,0x00FF00FF,"HOW DID YOU GET HERE???");
		  SendClientMessage(playerid,0x0091FFFF,"HOW DID YOU GET HERE???");
		  SendClientMessage(playerid,0xB00000FF,"HOW DID YOU GET HERE???");
		  SendClientMessage(playerid,0x008900FF,"HOW DID YOU GET HERE???");
		  SendClientMessage(playerid,0x0000FFFF,"HOW DID YOU GET HERE???");
          PlayerTextDrawHide(playerid,PlayerText:NothingFound[playerid]);
          PlayerTextDrawHide(playerid,PlayerText:NFX[playerid]);
          PlayerTextDrawHide(playerid,PlayerText:googl[playerid]);
          PlayerTextDrawHide(playerid,PlayerText:GooglSearch[playerid]);
	 }
	 else if(!strcmp(inputtext,"www.yotube.com",true))
	 {
          PlayerTextDrawHide(playerid,PlayerText:NothingFound[playerid]);
          PlayerTextDrawHide(playerid,PlayerText:NFX[playerid]);
          PlayerTextDrawHide(playerid,PlayerText:googl[playerid]);
          PlayerTextDrawHide(playerid,PlayerText:GooglSearch[playerid]);
          StopAudioStreamForPlayer(playerid);
          PlayAudioStreamForPlayer(playerid, "https://www.dropbox.com/s/c5ciop1zdq8ou5x/rickroll.mp3?dl=1");
          PlayerTextDrawShow(playerid,PlayerText:rickrolld[playerid]);
	 }
	 else if(!strcmp(inputtext,"www.market.com",true))
	 {
          PlayerTextDrawHide(playerid,PlayerText:NothingFound[playerid]);
          PlayerTextDrawHide(playerid,PlayerText:NFX[playerid]);
          PlayerTextDrawHide(playerid,PlayerText:googl[playerid]);
          PlayerTextDrawHide(playerid,PlayerText:GooglSearch[playerid]);
          PlayerTextDrawShow(playerid,CKauf_Boote[playerid]);
          PlayerTextDrawShow(playerid,CKauf_BooteN[playerid]);
          PlayerTextDrawShow(playerid,CKauf_BooteH[playerid]);
          PlayerTextDrawShow(playerid,CKauf_Flieger[playerid]);
          PlayerTextDrawShow(playerid,CKauf_FliegerN[playerid]);
          PlayerTextDrawShow(playerid,CKauf_FliegerH[playerid]);
          PlayerTextDrawShow(playerid,CKauf_Autos[playerid]);
          PlayerTextDrawShow(playerid,CKauf_AutosN[playerid]);
          PlayerTextDrawShow(playerid,CKauf_AutosH[playerid]);
          PlayerTextDrawShow(playerid,CKauf_Haus[playerid]);
          PlayerTextDrawShow(playerid,CKauf_HausH[playerid]);
          PlayerTextDrawShow(playerid,CKauf_HausN[playerid]);
          PlayerTextDrawShow(playerid,CKauf_Militar[playerid]);
          PlayerTextDrawShow(playerid,CKauf_MilitarN[playerid]);
          PlayerTextDrawShow(playerid,CKauf_MilitarH[playerid]);
	 }
	 else if(!strcmp(inputtext,"www.ismycomputeronfire.com",true))
	 {
          PlayerTextDrawHide(playerid,PlayerText:NothingFound[playerid]);
          PlayerTextDrawHide(playerid,PlayerText:NFX[playerid]);
          PlayerTextDrawHide(playerid,PlayerText:googl[playerid]);
          PlayerTextDrawHide(playerid,PlayerText:GooglSearch[playerid]);
          PlayerTextDrawShow(playerid,PlayerText:COFYes[playerid]);
          SetTimer("ComExplosion", 1000, false);
	 }
     else
	 {
          PlayerTextDrawShow(playerid,PlayerText:NothingFound[playerid]);
          PlayerTextDrawShow(playerid,PlayerText:NFX[playerid]);
	 }
	 return 1;
}

forward ComExplosion(playerid);
public ComExplosion(playerid)
{
PlayerTextDrawShow(playerid,PlayerText:ComEx1[playerid]);
SetTimer("ComExplosion1", 100, false);
}

forward ComExplosion1(playerid);
public ComExplosion1(playerid)
{
PlayerTextDrawHide(playerid,PlayerText:ComEx1[playerid]);
PlayerTextDrawShow(playerid,PlayerText:ComEx2[playerid]);
SetTimer("ComExplosion2", 100, false);
}

forward ComExplosion2(playerid);
public ComExplosion2(playerid)
{
PlayerTextDrawHide(playerid,PlayerText:ComEx2[playerid]);
PlayerTextDrawShow(playerid,PlayerText:ComEx3[playerid]);
SetTimer("ComExplosion3", 100, false);
}

forward ComExplosion3(playerid);
public ComExplosion3(playerid)
{
PlayerTextDrawHide(playerid,PlayerText:ComEx3[playerid]);
PlayerTextDrawShow(playerid,PlayerText:ComEx4[playerid]);
SetTimer("ComExplosion4", 100, false);
}

forward ComExplosion4(playerid);
public ComExplosion4(playerid)
{
PlayerTextDrawHide(playerid,PlayerText:ComEx4[playerid]);
PlayerTextDrawShow(playerid,PlayerText:ComEx5[playerid]);
SetTimer("ComExplosion5", 100, false);
}

forward ComExplosion5(playerid);
public ComExplosion5(playerid)
{
PlayerTextDrawHide(playerid,PlayerText:ComEx5[playerid]);
PlayerTextDrawShow(playerid,PlayerText:ComEx6[playerid]);
SetTimer("ComExplosion6", 100, false);
}

forward ComExplosion6(playerid);
public ComExplosion6(playerid)
{
PlayerTextDrawHide(playerid,PlayerText:ComEx6[playerid]);
PlayerTextDrawShow(playerid,PlayerText:ComEx7[playerid]);
SetTimer("ComExplosion7", 100, false);
}

forward ComExplosion7(playerid);
public ComExplosion7(playerid)
{
PlayerTextDrawHide(playerid,PlayerText:ComEx7[playerid]);
PlayerTextDrawShow(playerid,PlayerText:ComEx8[playerid]);
SetTimer("ComExplosion8", 100, false);
}

forward ComExplosion8(playerid);
public ComExplosion8(playerid)
{
PlayerTextDrawHide(playerid,PlayerText:ComEx8[playerid]);
PlayerTextDrawShow(playerid,PlayerText:ComEx9[playerid]);
SetTimer("ComExplosion9", 112, false);
}

forward ComExplosion9(playerid);
public ComExplosion9(playerid)
{
PlayerTextDrawHide(playerid,PlayerText:ComEx9[playerid]);
PlayerTextDrawShow(playerid,PlayerText:ComEx10[playerid]);
SetTimer("ComExplosion10", 125, false);
}

forward ComExplosion10(playerid);
public ComExplosion10(playerid)
{
PlayerTextDrawHide(playerid,PlayerText:ComEx10[playerid]);
PlayerTextDrawShow(playerid,PlayerText:ComEx11[playerid]);
SetTimer("ComExplosion11", 150, false);
}

forward ComExplosion11(playerid);
public ComExplosion11(playerid)
{
PlayerTextDrawHide(playerid,PlayerText:ComEx11[playerid]);
PlayerTextDrawShow(playerid,PlayerText:ComEx12[playerid]);
SetTimer("ComExplosion12", 175, false);
}

forward ComExplosion12(playerid);
public ComExplosion12(playerid)
{
PlayerTextDrawHide(playerid,PlayerText:ComEx12[playerid]);
SetTimer("ComExplosion13", 50, false);
}

forward ComExplosion13(playerid);
public ComExplosion13(playerid)
{
Showing[playerid] = 0;
PlayerTextDrawHide(playerid,PlayerText:Bildschirm[playerid]);
PlayerTextDrawHide(playerid,PlayerText:Ausschaltknopf[playerid]);
PlayerTextDrawHide(playerid,PlayerText:Hintergrund1[playerid]);
PlayerTextDrawHide(playerid,PlayerText:Hintergrund2[playerid]);
PlayerTextDrawHide(playerid,PlayerText:Hintergrund3[playerid]);
PlayerTextDrawHide(playerid,PlayerText:Hintergrund4[playerid]);
PlayerTextDrawHide(playerid,PlayerText:Hintergrund5[playerid]);
PlayerTextDrawHide(playerid,PlayerText:Hintergrund6[playerid]);
PlayerTextDrawHide(playerid,PlayerText:Hintergrund7[playerid]);
PlayerTextDrawHide(playerid,PlayerText:Papierkorb[playerid]);
PlayerTextDrawHide(playerid,PlayerText:Internet[playerid]);
PlayerTextDrawHide(playerid,PlayerText:Hausaufgabe[playerid]);
PlayerTextDrawHide(playerid,PlayerText:Einstellungen[playerid]);
PlayerTextDrawHide(playerid,PlayerText:Email[playerid]);
PlayerTextDrawHide(playerid,PlayerText:SAMP[playerid]);
PlayerTextDrawHide(playerid,PlayerText:Notizen[playerid]);
PlayerTextDrawHide(playerid,PlayerText:Spiele[playerid]);
PlayerTextDrawHide(playerid,PlayerText:PapierHinter[playerid]);
PlayerTextDrawHide(playerid,PlayerText:Schliessen[playerid]);
PlayerTextDrawHide(playerid,PlayerText:mHintergrund1[playerid]);
PlayerTextDrawHide(playerid,PlayerText:mHintergrund2[playerid]);
PlayerTextDrawHide(playerid,PlayerText:mHintergrund3[playerid]);
PlayerTextDrawHide(playerid,PlayerText:mHintergrund4[playerid]);
PlayerTextDrawHide(playerid,PlayerText:mHintergrund5[playerid]);
PlayerTextDrawHide(playerid,PlayerText:mHintergrund6[playerid]);
PlayerTextDrawHide(playerid,PlayerText:mHintergrund7[playerid]);
PlayerTextDrawHide(playerid,PlayerText:Hintergrunda[playerid]);
PlayerTextDrawHide(playerid,PlayerText:Websites[playerid]);
PlayerTextDrawHide(playerid,PlayerText:AddNote[playerid]);
PlayerTextDrawHide(playerid,PlayerText:Note[playerid]);
PlayerTextDrawHide(playerid,PlayerText:KeineDateien[playerid]);
PlayerTextDrawHide(playerid,PlayerText:NothingFound[playerid]);
PlayerTextDrawHide(playerid,PlayerText:Web_Hintergrund[playerid]);
PlayerTextDrawHide(playerid,PlayerText:googl[playerid]);
PlayerTextDrawHide(playerid,PlayerText:GooglSearch[playerid]);
PlayerTextDrawHide(playerid,PlayerText:NFX[playerid]);
PlayerTextDrawHide(playerid,PlayerText:rickrolld[playerid]);
PlayerTextDrawHide(playerid,PlayerText:COFYes[playerid]);
StopAudioStreamForPlayer(playerid);
CancelSelectTextDraw(playerid);
TogglePlayerControllable(playerid,true);
new string[50+ MAX_PLAYER_NAME];
new Spname [MAX_PLAYER_NAME];
GetPlayerName(playerid, Spname, sizeof (Spname));
format(string, sizeof(string), "========>> %s hat einen Computer geschrottet <<======", Spname);
print(string);
format(string, sizeof(string), "%s has burned a computer", Spname);
SendClientMessageToAll(0xFF0000FF, string);
}

stock Titel (playerid,inputtext[])
{
     GetPlayerName(playerid,Sname,sizeof(Sname));
	 format(Spieler,sizeof(Spieler),"/Spieler/%s.txt",Sname);
	 if(!strcmp("1",dini_Get(Spieler,"CNotiz"),true))
	 {dini_Set(Spieler,"N1Titel",inputtext);	 }
	 if(!strcmp("2",dini_Get(Spieler,"CNotiz"),true))
	 {dini_Set(Spieler,"N2Titel",inputtext);	 }
	 if(!strcmp("3",dini_Get(Spieler,"CNotiz"),true))
	 {dini_Set(Spieler,"N3Titel",inputtext);	 }
	 if(!strcmp("4",dini_Get(Spieler,"CNotiz"),true))
	 {dini_Set(Spieler,"N4Titel",inputtext);	 }
	 if(!strcmp("5",dini_Get(Spieler,"CNotiz"),true))
	 {dini_Set(Spieler,"N5Titel",inputtext);	 }
	 if(!strcmp("6",dini_Get(Spieler,"CNotiz"),true))
	 {dini_Set(Spieler,"N6Titel",inputtext);	 }
	 if(!strcmp("7",dini_Get(Spieler,"CNotiz"),true))
	 {dini_Set(Spieler,"N7Titel",inputtext);	 }
	 else
	 {dini_Set(Spieler,"N0Titel",inputtext);	 }
	 ShowPlayerDialog(playerid,TEXT,DIALOG_STYLE_INPUT,"Add note","Type here the text of the note","Okay","Cancel");
	 return 1;
}

stock Text (playerid,inputtext[])
{
     GetPlayerName(playerid,Sname,sizeof(Sname));
	 format(Spieler,sizeof(Spieler),"/Spieler/%s.txt",Sname);
	 if(!strcmp("1",dini_Get(Spieler,"CNotiz"),true))
	 {dini_Set(Spieler,"N1Text",inputtext);
	 dini_Set(Spieler,"CNotiz","2");}
	 if(!strcmp("2",dini_Get(Spieler,"CNotiz"),true))
	 {dini_Set(Spieler,"N2Text",inputtext);
	 dini_Set(Spieler,"CNotiz","3");}
	 if(!strcmp("3",dini_Get(Spieler,"CNotiz"),true))
	 {dini_Set(Spieler,"N3Text",inputtext);
	 dini_Set(Spieler,"CNotiz","4");}
	 if(!strcmp("4",dini_Get(Spieler,"CNotiz"),true))
	 {dini_Set(Spieler,"N4Text",inputtext);
	 dini_Set(Spieler,"CNotiz","5");}
	 if(!strcmp("5",dini_Get(Spieler,"CNotiz"),true))
	 {dini_Set(Spieler,"N5Text",inputtext);
	 dini_Set(Spieler,"CNotiz","6");}
	 if(!strcmp("6",dini_Get(Spieler,"CNotiz"),true))
	 {dini_Set(Spieler,"N6Text",inputtext);
	 dini_Set(Spieler,"CNotiz","7");}
	 if(!strcmp("7",dini_Get(Spieler,"CNotiz"),true))
	 {dini_Set(Spieler,"N7Text",inputtext);
	 dini_Set(Spieler,"CNotiz","Full");}
	 else
	 {dini_Set(Spieler,"N0Titel",inputtext);
	 dini_Set(Spieler,"CNotiz","1");}
	 return 1;
}


forward DelayedKick(playerid);
public DelayedKick(playerid)
{
    Kick(playerid);
    return 1;
}
