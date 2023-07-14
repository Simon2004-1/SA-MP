#define FILTERSCRIPT
#define MINIGAMEDIALOG 27


#include <a_samp>
#include 0SimonsInclude
#include <streamer>
#include gl_common

#define WAITFORAUPLAYERS 1
#define RESETAUPLAYERS 2
#define AUGAME 3
#define AUMEETING 4
#define AUVOTE 5

#define AmongUsMeetingCooldownTime 90-1
#define AmongUsKillCooldownTime 60-1

new AmongUsGameState;
new AmongUsPlayer[6];
new AmongUsImposter[2];
new AmongUsMeetingCoolDown;
new AmongUsImposterCoolDown;
new AmongUsMeetingTime;
new AmongUsVotingTime;
new AmongusObject[MAX_PLAYERS];

new Text:AmongUsTablet[6];
new Text:AmongUsBildschirm;
new Text:AmongUsHomeButton;
new Text:AmongUsMessage1[4];
new Text:AmongUsMessage2[4];
new Text:AmongUsMessage3[4];
new Text:AmongUsMessage4[4];
new Text:AmongUsMessage5[4];
new Text:AmongUsVotePlayer[18];


new AmongUsMessage2Text[256+1];
new AmongUsMessage3Text[256+1];
new AmongUsMessage4Text[256+1];
new AmongUsMessage5Text[256+1];
new AmongUsMessage2Name[51];
new AmongUsMessage3Name[51];
new AmongUsMessage4Name[51];
new AmongUsMessage5Name[51];


new spacedoorcockpit;
new spacedoorcomputers;
new spacedoorstorage[4];
new spacedoorirgendwas[4];
new spacedoorcenter[2];
new spacedoormeeting[2];

new bool:door[19];

new sprayer[8];
new bool:sprayers;

new bool:generator;
new bool:ringstate;
new genring[3];
new rotdelay;

new button[4];

public OnFilterScriptInit()
{
#pragma tabsize 0
	AmongUsGameReset();
	new tmpobjid;
    tmpobjid = CreateDynamicObject(19456, 1954.950805, 1419.248168, 1093.329833, 0.000000, -90.000053, 0.000000, -1, -1, -1, 100.00, 100.00);//Spawn-Platte
    tmpobjid = CreateDynamicObject(19456, 1958.211547, 1419.248168, 1093.339843, 0.000000, -90.000053, 0.000000, -1, -1, -1, 100.00, 100.00);//Spawn-Platte
    tmpobjid = CreateDynamicObject(19456, 1961.152221, 1419.248168, 1093.339843, 0.000000, -90.000053, 0.000000, -1, -1, -1, 100.00, 100.00);//Spawn-Platte
    tmpobjid = CreateDynamicObject(6885, 1996.472167, 1533.736206, 1093.429687, 0.000000, 0.000000, -179.400009, -1, -1, -1, 200.00, 250.00);//Parkplatz(Boden)
    SetDynamicObjectMaterial(tmpobjid, 0, 14789, "ab_sfgymmain", "gun_ceiling2_128", 0xFFFFFFFF);
    SetDynamicObjectMaterial(tmpobjid, 1, 14789, "ab_sfgymmain", "gun_ceiling2_128", 0xFFFFFFFF);
    SetDynamicObjectMaterial(tmpobjid, 2, 14789, "ab_sfgymmain", "gun_ceiling2_128", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 3, 14789, "ab_sfgymmain", "gun_ceiling2_128", 0x00000000);
    tmpobjid = CreateDynamicObject(6885, 2017.654907, 1438.854614, 1093.419921, 0.000000, 0.000000, 270.699981, -1, -1, -1, 200.00, 250.00);//Parkplatz(Boden)
    SetDynamicObjectMaterial(tmpobjid, 0, 14789, "ab_sfgymmain", "gun_ceiling2_128", 0xFFFFFFFF);
    SetDynamicObjectMaterial(tmpobjid, 1, 14789, "ab_sfgymmain", "gun_ceiling2_128", 0xFFFFFFFF);
    SetDynamicObjectMaterial(tmpobjid, 2, 14789, "ab_sfgymmain", "gun_ceiling2_128", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 3, 14789, "ab_sfgymmain", "gun_ceiling2_128", 0x00000000);
    tmpobjid = CreateDynamicObject(6885, 1995.924072, 1396.226806, 1093.429931, 0.000000, 0.000000, 720.699951, -1, -1, -1, 200.00, 250.00);//Parkplatz(Boden)
    SetDynamicObjectMaterial(tmpobjid, 0, 14789, "ab_sfgymmain", "gun_ceiling2_128", 0xFFFFFFFF);
    SetDynamicObjectMaterial(tmpobjid, 1, 14789, "ab_sfgymmain", "gun_ceiling2_128", 0xFFFFFFFF);
    SetDynamicObjectMaterial(tmpobjid, 2, 14789, "ab_sfgymmain", "gun_ceiling2_128", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 3, 14789, "ab_sfgymmain", "gun_ceiling2_128", 0x00000000);
    tmpobjid = CreateDynamicObject(19379, 1883.754760, 1469.286987, 1093.345458, 0.000000, 90.000000, 360.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14789, "ab_sfgymmain", "gun_ceiling2_128", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(19715, 1884.333374, 1469.283325, 1093.509155, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 16640, "a51", "a51_floorpanel1", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(19715, 1884.333374, 1469.283325, 1097.739501, 180.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14789, "ab_sfgymmain", "gun_ceiling2_128", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(18819, 1916.315429, 1469.253417, 1093.251586, 90.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 1, 2917, "a51_crane", "girder2_grey_64HV", 0x00000000);
    tmpobjid = CreateDynamicObject(18819, 1916.315429, 1469.253417, 1097.172607, 90.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 2917, "a51_crane", "girder2_grey_64HV", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 1, 16640, "a51", "a51_floorpanel1", 0x00000000);
    tmpobjid = CreateDynamicObject(18810, 1958.051391, 1469.241088, 1093.118286, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 2917, "a51_crane", "girder2_grey_64HV", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 1, 2917, "a51_crane", "girder2_grey_64HV", 0x00000000);
    tmpobjid = CreateDynamicObject(18810, 1958.051391, 1469.291137, 1097.099975, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 16640, "a51", "a51_floorpanel1", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 1, 16640, "a51", "a51_floorpanel1", 0x00000000);
    tmpobjid = CreateDynamicObject(19379, 1894.235107, 1469.286987, 1093.345458, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14789, "ab_sfgymmain", "gun_ceiling2_128", 0x00000000);
    tmpobjid = CreateDynamicObject(19379, 1904.735595, 1469.286987, 1093.345458, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14789, "ab_sfgymmain", "gun_ceiling2_128", 0x00000000);
    tmpobjid = CreateDynamicObject(19392, 1891.474731, 1469.259277, 1095.130737, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 16640, "a51", "a51_floorpanel1", 0x00000000);
    tmpobjid = CreateDynamicObject(19368, 1891.477783, 1466.059204, 1095.130981, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 16640, "a51", "a51_floorpanel1", 0x00000000);
    tmpobjid = CreateDynamicObject(19368, 1891.477783, 1472.468627, 1095.130981, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 16640, "a51", "a51_floorpanel1", 0x00000000);
    tmpobjid = CreateDynamicObject(19456, 1892.703491, 1469.074096, 1098.038085, 0.000000, 45.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 2917, "a51_crane", "girder2_grey_64HV", 0x00000000);
    tmpobjid = CreateDynamicObject(19456, 1887.123413, 1473.506103, 1095.161987, 0.000000, 0.000000, 65.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 16640, "a51", "a51_floorpanel1", 0x00000000);
    tmpobjid = CreateDynamicObject(19456, 1887.149780, 1465.123046, 1095.161987, 0.000000, 0.000000, -65.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 16640, "a51", "a51_floorpanel1", 0x00000000);
    tmpobjid = CreateDynamicObject(19456, 1883.857788, 1464.642822, 1095.161987, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 16640, "a51", "a51_floorpanel1", 0x00000000);
    tmpobjid = CreateDynamicObject(19456, 1883.857788, 1473.992797, 1095.161987, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 16640, "a51", "a51_floorpanel1", 0x00000000);
    tmpobjid = CreateDynamicObject(19456, 1886.770385, 1472.346313, 1098.127197, 0.000006, -44.999996, 65.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 2917, "a51_crane", "girder2_grey_64HV", 0x00000000);
    tmpobjid = CreateDynamicObject(19456, 1886.633544, 1466.230590, 1098.128051, -0.000012, -44.999992, -65.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 2917, "a51_crane", "girder2_grey_64HV", 0x00000000);
    tmpobjid = CreateDynamicObject(19456, 1890.261840, 1467.673339, 1098.130126, 0.000000, -45.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 2917, "a51_crane", "girder2_grey_64HV", 0x00000000);
    tmpobjid = CreateDynamicObject(19456, 1883.857788, 1472.824584, 1098.105712, 0.000007, -45.000000, 89.999977, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 2917, "a51_crane", "girder2_grey_64HV", 0x00000000);
    tmpobjid = CreateDynamicObject(19456, 1883.857788, 1465.866577, 1098.126708, 0.000000, 45.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 2917, "a51_crane", "girder2_grey_64HV", 0x00000000);
    tmpobjid = CreateDynamicObject(19379, 1915.236328, 1469.286987, 1093.345458, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14789, "ab_sfgymmain", "gun_ceiling2_128", 0x00000000);
    tmpobjid = CreateDynamicObject(19379, 1925.728637, 1469.286987, 1093.345458, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14789, "ab_sfgymmain", "gun_ceiling2_128", 0x00000000);
    tmpobjid = CreateDynamicObject(19379, 1936.179443, 1469.286987, 1093.345458, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14789, "ab_sfgymmain", "gun_ceiling2_128", 0x00000000);
    tmpobjid = CreateDynamicObject(19379, 1915.236328, 1478.916503, 1093.345458, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14789, "ab_sfgymmain", "gun_ceiling2_128", 0x00000000);
    tmpobjid = CreateDynamicObject(19379, 1915.236328, 1488.534179, 1093.345458, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14789, "ab_sfgymmain", "gun_ceiling2_128", 0x00000000);
    tmpobjid = CreateDynamicObject(19379, 1904.735595, 1478.896484, 1093.345458, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14789, "ab_sfgymmain", "gun_ceiling2_128", 0x00000000);
    tmpobjid = CreateDynamicObject(19379, 1904.735595, 1459.656738, 1093.345458, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14789, "ab_sfgymmain", "gun_ceiling2_128", 0x00000000);
    tmpobjid = CreateDynamicObject(19379, 1915.236328, 1459.686279, 1093.345458, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14789, "ab_sfgymmain", "gun_ceiling2_128", 0x00000000);
    tmpobjid = CreateDynamicObject(19379, 1915.236328, 1450.085205, 1093.345458, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14789, "ab_sfgymmain", "gun_ceiling2_128", 0x00000000);
    tmpobjid = CreateDynamicObject(19379, 1925.728637, 1459.667480, 1093.345458, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14789, "ab_sfgymmain", "gun_ceiling2_128", 0x00000000);
    tmpobjid = CreateDynamicObject(19379, 1925.728637, 1478.906127, 1093.345458, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14789, "ab_sfgymmain", "gun_ceiling2_128", 0x00000000);
    tmpobjid = CreateDynamicObject(13646, 1916.297973, 1469.147705, 1093.202514, 0.000000, 360.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 18065, "ab_sfammumain", "plate1", 0xFFFFFFFF);
    SetDynamicObjectMaterial(tmpobjid, 1, 915, "airconext", "cj_plating3", 0x00000000);
    tmpobjid = CreateDynamicObject(13646, 1916.297973, 1469.147705, 1102.343872, 0.000000, 180.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14548, "ab_cargo_int", "cargo_floor2", 0xFFFFFFFF);
    SetDynamicObjectMaterial(tmpobjid, 1, 915, "airconext", "cj_plating3", 0x00000000);
    tmpobjid = CreateDynamicObject(18876, 1916.362670, 1469.076171, 1102.519775, 0.000000, 180.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 5150, "wiresetc_las2", "ganggraf01_LA_m", 0xFFFFFFFF);
    SetDynamicObjectMaterial(tmpobjid, 1, 16640, "a51", "a51_pipeend", 0x00000000);
    tmpobjid = CreateDynamicObject(11729, 1913.234741, 1469.345214, 1092.810791, 0.000000, 0.000000, 91.199989, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 16640, "a51", "a51_metal1", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(19197, 1916.301025, 1469.140625, 1094.459106, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 19527, "cauldron1", "alienliquid1", 0x00000000);
    tmpobjid = CreateDynamicObject(3885, 1916.289184, 1469.234497, 1093.211425, 0.000000, 0.000000, 16.300001, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 16322, "a51_stores", "metpat64chev_128", 0xFFFFFFFF);
    SetDynamicObjectMaterial(tmpobjid, 3, 16640, "a51", "a51_metal1", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 4, 5150, "wiresetc_las2", "ganggraf01_LA_m", 0x00000000);
    tmpobjid = CreateDynamicObject(19478, 1912.978515, 1469.468505, 1094.722534, 0.000000, 0.000000, 2.000015, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 16640, "a51", "a51_cardreader", 0x00000000);
    tmpobjid = CreateDynamicObject(1420, 1917.801391, 1474.427124, 1096.131958, 0.000000, 0.000000, 74.799987, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    SetDynamicObjectMaterial(tmpobjid, 1, 13628, "8stad", "stadroof", 0x00000000);

    tmpobjid = CreateDynamicObject(1420, 1914.813354, 1474.466064, 1096.131958, 0.000000, 0.000000, 106.300018, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    SetDynamicObjectMaterial(tmpobjid, 1, 13628, "8stad", "stadroof", 0x00000000);
    tmpobjid = CreateDynamicObject(1420, 1917.801391, 1474.427124, 1098.123779, 0.000007, 0.000001, 74.799980, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    SetDynamicObjectMaterial(tmpobjid, 1, 13628, "8stad", "stadroof", 0x00000000);
    tmpobjid = CreateDynamicObject(19475, 1912.984008, 1469.342529, 1093.831542, -0.099999, 0.000000, 1.299999, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10140, "frieghter2sfe", "sf_ship_pipes", 0x00000000);
    tmpobjid = CreateDynamicObject(19475, 1912.983520, 1469.337890, 1094.622192, 0.000000, 0.000000, 1.899992, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 11150, "ab_acc_control", "ab_dialsSwitches", 0x00000000);
    tmpobjid = CreateDynamicObject(19475, 1912.984008, 1469.342895, 1094.221801, -0.099999, 0.000000, 1.299999, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10140, "frieghter2sfe", "sf_ship_pipes", 0x00000000);
    tmpobjid = CreateDynamicObject(1317, 1916.274780, 1469.136108, 1093.331298, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 13659, "8bars", "AH_gbarrier", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(7893, 1916.250854, 1465.229980, 1093.500000, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 16640, "a51", "ws_castironwalk", 0xFFFFFFFF);
    SetDynamicObjectMaterial(tmpobjid, 1, 16322, "a51_stores", "metpat64chev_128", 0x00000000);
    tmpobjid = CreateDynamicObject(7893, 1916.250854, 1465.229980, 1094.170654, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 18996, "mattextures", "policeshieldgls", 0xFFFFFFFF);
    SetDynamicObjectMaterial(tmpobjid, 1, 16322, "a51_stores", "metpat64chev_128", 0x00000000);
    tmpobjid = CreateDynamicObject(7893, 1916.250854, 1465.229980, 1094.849853, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 16640, "a51", "ws_castironwalk", 0xFFFFFFFF);
    SetDynamicObjectMaterial(tmpobjid, 1, 16322, "a51_stores", "metpat64chev_128", 0x00000000);
    tmpobjid = CreateDynamicObject(3675, 1907.925537, 1469.271972, 1098.911987, 90.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 16640, "a51", "banding9_64HV", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(3675, 1924.713989, 1469.271972, 1098.911987, 90.000000, 0.000000, 450.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 16640, "a51", "banding9_64HV", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(3675, 1916.312500, 1477.632446, 1098.911987, 90.000000, 0.000000, 540.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 16640, "a51", "banding9_64HV", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(3675, 1916.312500, 1460.752685, 1098.911987, 90.000000, 0.000000, 720.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 16640, "a51", "banding9_64HV", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(2960, 1914.774780, 1474.636352, 1098.402221, 0.000000, 90.000000, 107.000038, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14548, "ab_cargo_int", "cargo_floor2", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(2960, 1917.867675, 1474.607299, 1098.402221, 0.000000, 90.000000, 75.899978, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14548, "ab_cargo_int", "cargo_floor2", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(2960, 1917.867797, 1463.612792, 1098.402221, 0.000000, 90.000000, -72.999954, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14548, "ab_cargo_int", "cargo_floor2", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(2960, 1914.760253, 1463.583862, 1098.402221, 0.000000, 90.000000, -104.099990, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14548, "ab_cargo_int", "cargo_floor2", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(2960, 1921.789550, 1470.714477, 1098.462280, -0.000004, 90.000007, 17.000036, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14548, "ab_cargo_int", "cargo_floor2", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(2960, 1921.818481, 1467.606933, 1098.472290, -0.000009, 90.000007, -14.099998, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14548, "ab_cargo_int", "cargo_floor2", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(2960, 1910.806274, 1467.606811, 1098.452270, -0.000004, 90.000007, -162.999893, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14548, "ab_cargo_int", "cargo_floor2", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(2960, 1910.777343, 1470.714355, 1098.462280, -0.000009, 90.000007, 165.899902, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14548, "ab_cargo_int", "cargo_floor2", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(1420, 1914.813354, 1474.466064, 1098.123779, 0.000007, -0.000001, 106.299995, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    SetDynamicObjectMaterial(tmpobjid, 1, 13628, "8stad", "stadroof", 0x00000000);
    tmpobjid = CreateDynamicObject(1420, 1917.801391, 1474.427124, 1099.885375, 0.000014, 0.000003, 74.799980, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    SetDynamicObjectMaterial(tmpobjid, 1, 13628, "8stad", "stadroof", 0x00000000);
    tmpobjid = CreateDynamicObject(1420, 1914.813354, 1474.466064, 1099.885375, 0.000014, -0.000003, 106.299972, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    SetDynamicObjectMaterial(tmpobjid, 1, 13628, "8stad", "stadroof", 0x00000000);
    tmpobjid = CreateDynamicObject(1420, 1914.813354, 1463.804077, 1096.131958, 0.000000, 0.000000, -105.199981, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    SetDynamicObjectMaterial(tmpobjid, 1, 13628, "8stad", "stadroof", 0x00000000);
    tmpobjid = CreateDynamicObject(1420, 1917.801391, 1463.765136, 1096.131958, 0.000000, 0.000000, -73.699981, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    SetDynamicObjectMaterial(tmpobjid, 1, 13628, "8stad", "stadroof", 0x00000000);
    tmpobjid = CreateDynamicObject(1420, 1914.813354, 1463.804077, 1098.123779, 0.000007, 0.000001, -105.199989, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    SetDynamicObjectMaterial(tmpobjid, 1, 13628, "8stad", "stadroof", 0x00000000);
    tmpobjid = CreateDynamicObject(1420, 1917.801391, 1463.765136, 1098.123779, 0.000007, -0.000001, -73.700012, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    SetDynamicObjectMaterial(tmpobjid, 1, 13628, "8stad", "stadroof", 0x00000000);
    tmpobjid = CreateDynamicObject(1420, 1914.813354, 1463.804077, 1099.885375, 0.000014, 0.000003, -105.199989, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    SetDynamicObjectMaterial(tmpobjid, 1, 13628, "8stad", "stadroof", 0x00000000);
    tmpobjid = CreateDynamicObject(1420, 1917.801391, 1463.765136, 1099.885375, 0.000014, -0.000003, -73.700035, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    SetDynamicObjectMaterial(tmpobjid, 1, 13628, "8stad", "stadroof", 0x00000000);
    tmpobjid = CreateDynamicObject(1420, 1921.649658, 1467.612915, 1096.131958, -0.000009, 0.000004, -15.199987, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    SetDynamicObjectMaterial(tmpobjid, 1, 13628, "8stad", "stadroof", 0x00000000);
    tmpobjid = CreateDynamicObject(1420, 1921.688598, 1470.600952, 1096.131958, -0.000004, 0.000009, 16.300008, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    SetDynamicObjectMaterial(tmpobjid, 1, 13628, "8stad", "stadroof", 0x00000000);
    tmpobjid = CreateDynamicObject(1420, 1921.649658, 1467.612915, 1098.123779, -0.000001, 0.000007, -15.199995, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    SetDynamicObjectMaterial(tmpobjid, 1, 13628, "8stad", "stadroof", 0x00000000);
    tmpobjid = CreateDynamicObject(1420, 1921.688598, 1470.600952, 1098.123779, 0.000001, 0.000007, 16.299978, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    SetDynamicObjectMaterial(tmpobjid, 1, 13628, "8stad", "stadroof", 0x00000000);
    tmpobjid = CreateDynamicObject(1420, 1921.649658, 1467.612915, 1099.885375, 0.000004, 0.000009, -15.199995, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    SetDynamicObjectMaterial(tmpobjid, 1, 13628, "8stad", "stadroof", 0x00000000);
    tmpobjid = CreateDynamicObject(1420, 1921.688598, 1470.600952, 1099.885375, 0.000009, 0.000004, 16.299955, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    SetDynamicObjectMaterial(tmpobjid, 1, 13628, "8stad", "stadroof", 0x00000000);
    tmpobjid = CreateDynamicObject(1420, 1910.886962, 1470.600952, 1096.131958, -0.000004, -0.000009, 164.799819, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    SetDynamicObjectMaterial(tmpobjid, 1, 13628, "8stad", "stadroof", 0x00000000);
    tmpobjid = CreateDynamicObject(1420, 1910.848022, 1467.612915, 1096.131958, -0.000009, -0.000004, -163.699829, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    SetDynamicObjectMaterial(tmpobjid, 1, 13628, "8stad", "stadroof", 0x00000000);
    tmpobjid = CreateDynamicObject(1420, 1910.886962, 1470.600952, 1098.123779, 0.000001, -0.000007, 164.799804, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    SetDynamicObjectMaterial(tmpobjid, 1, 13628, "8stad", "stadroof", 0x00000000);
    tmpobjid = CreateDynamicObject(1420, 1910.848022, 1467.612915, 1098.123779, -0.000001, -0.000007, -163.699859, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    SetDynamicObjectMaterial(tmpobjid, 1, 13628, "8stad", "stadroof", 0x00000000);
    tmpobjid = CreateDynamicObject(1420, 1910.886962, 1470.600952, 1099.885375, 0.000009, -0.000004, 164.799804, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    SetDynamicObjectMaterial(tmpobjid, 1, 13628, "8stad", "stadroof", 0x00000000);
    tmpobjid = CreateDynamicObject(1420, 1910.848022, 1467.612915, 1099.885375, 0.000004, -0.000009, -163.699890, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    SetDynamicObjectMaterial(tmpobjid, 1, 13628, "8stad", "stadroof", 0x00000000);
    tmpobjid = CreateDynamicObject(7893, 1916.250854, 1465.229980, 1095.529907, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 18996, "mattextures", "policeshieldgls", 0xFFFFFFFF);
    SetDynamicObjectMaterial(tmpobjid, 1, 16322, "a51_stores", "metpat64chev_128", 0x00000000);
    tmpobjid = CreateDynamicObject(7893, 1916.250854, 1472.991943, 1093.500000, 0.000000, 0.000000, 179.999893, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 16640, "a51", "ws_castironwalk", 0xFFFFFFFF);
    SetDynamicObjectMaterial(tmpobjid, 1, 16322, "a51_stores", "metpat64chev_128", 0x00000000);
    tmpobjid = CreateDynamicObject(7893, 1916.250854, 1472.991943, 1094.170654, 0.000000, 0.000000, 179.999893, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 18996, "mattextures", "policeshieldgls", 0xFFFFFFFF);
    SetDynamicObjectMaterial(tmpobjid, 1, 16322, "a51_stores", "metpat64chev_128", 0x00000000);
    tmpobjid = CreateDynamicObject(7893, 1916.250854, 1472.991943, 1094.849853, 0.000000, 0.000000, 179.999893, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 16640, "a51", "ws_castironwalk", 0xFFFFFFFF);
    SetDynamicObjectMaterial(tmpobjid, 1, 16322, "a51_stores", "metpat64chev_128", 0x00000000);
    tmpobjid = CreateDynamicObject(7893, 1916.250854, 1472.991943, 1095.529907, 0.000000, 0.000000, 179.999893, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 18996, "mattextures", "policeshieldgls", 0xFFFFFFFF);
    SetDynamicObjectMaterial(tmpobjid, 1, 16322, "a51_stores", "metpat64chev_128", 0x00000000);
    tmpobjid = CreateDynamicObject(2960, 1914.765136, 1463.603149, 1093.812011, 0.000000, 90.000000, -104.099990, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14548, "ab_cargo_int", "cargo_floor2", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(2960, 1917.853149, 1463.660522, 1093.812133, 0.000000, 90.000000, -72.999954, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14548, "ab_cargo_int", "cargo_floor2", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(2960, 1917.865234, 1474.597656, 1093.781860, 0.000000, 90.000000, 75.899978, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14548, "ab_cargo_int", "cargo_floor2", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(2960, 1914.792358, 1474.579223, 1093.812011, 0.000000, 90.000000, 107.000038, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14548, "ab_cargo_int", "cargo_floor2", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(1317, 1916.274780, 1469.136108, 1094.602416, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 13659, "8bars", "AH_gbarrier", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(19197, 1916.301025, 1469.140625, 1094.369018, 0.000000, 180.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 19527, "cauldron1", "alienliquid1", 0x00000000);
    tmpobjid = CreateDynamicObject(19197, 1916.301025, 1469.140625, 1095.738403, 0.000000, 180.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 19527, "cauldron1", "alienliquid1", 0x00000000);
    tmpobjid = CreateDynamicObject(19197, 1916.301025, 1469.140625, 1097.449462, 0.000000, 360.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 19527, "cauldron1", "alienliquid1", 0x00000000);
    tmpobjid = CreateDynamicObject(19197, 1916.301025, 1469.140625, 1098.020019, 0.000000, 540.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 19527, "cauldron1", "alienliquid1", 0x00000000);
    tmpobjid = CreateDynamicObject(19197, 1916.301025, 1469.130615, 1099.911132, 0.000000, 720.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 19527, "cauldron1", "alienliquid1", 0x00000000);
    tmpobjid = CreateDynamicObject(19197, 1916.301025, 1469.140625, 1100.481689, 0.000000, 900.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 19527, "cauldron1", "alienliquid1", 0x00000000);
    tmpobjid = CreateDynamicObject(19197, 1916.301025, 1469.140625, 1099.320556, 0.000014, 900.000000, -0.000014, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 19527, "cauldron1", "alienliquid1", 0x00000000);
    tmpobjid = CreateDynamicObject(19197, 1916.281005, 1469.110595, 1098.750000, 0.000014, 1080.000000, -0.000014, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 19527, "cauldron1", "alienliquid1", 0x00000000);
    tmpobjid = CreateDynamicObject(19197, 1916.301025, 1469.140625, 1096.738769, 0.000014, 900.000000, -0.000014, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 19527, "cauldron1", "alienliquid1", 0x00000000);
    tmpobjid = CreateDynamicObject(19197, 1916.291015, 1469.120605, 1096.178222, 0.000014, 1080.000000, -0.000014, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 19527, "cauldron1", "alienliquid1", 0x00000000);
    tmpobjid = CreateDynamicObject(7586, 1916.304565, 1469.207031, 1087.071411, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    SetDynamicObjectMaterial(tmpobjid, 1, 10101, "2notherbuildsfe", "gz_vicdoor1", 0x00000000);
    tmpobjid = CreateDynamicObject(7586, 1916.304565, 1469.207031, 1108.212280, 0.000000, 180.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    SetDynamicObjectMaterial(tmpobjid, 1, 10101, "2notherbuildsfe", "gz_vicdoor1", 0x00000000);
    tmpobjid = CreateDynamicObject(3807, 1912.515747, 1468.089965, 1096.682861, 0.000000, 0.000000, 15.699995, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 16640, "a51", "a51_panel2", 0x00000000);
    tmpobjid = CreateDynamicObject(3807, 1912.570068, 1470.175537, 1096.682861, 0.000000, 0.000000, -12.900007, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 16640, "a51", "a51_panel2", 0x00000000);
    tmpobjid = CreateDynamicObject(3807, 1920.040405, 1470.175659, 1096.682861, 0.000000, 0.000000, -164.299926, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 16640, "a51", "a51_panel2", 0x00000000);
    tmpobjid = CreateDynamicObject(3807, 1919.986083, 1468.090087, 1096.682861, 0.000000, 0.000000, 167.099899, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 16640, "a51", "a51_panel2", 0x00000000);
    tmpobjid = CreateDynamicObject(3807, 1915.287963, 1472.792358, 1096.682861, -0.000015, -0.000003, -74.299903, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 16640, "a51", "a51_panel2", 0x00000000);
    tmpobjid = CreateDynamicObject(3807, 1917.373535, 1472.738037, 1096.682861, -0.000012, -0.000009, -102.900039, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 16640, "a51", "a51_panel2", 0x00000000);
    tmpobjid = CreateDynamicObject(3807, 1917.373657, 1465.418945, 1096.682861, -0.000015, -0.000003, 105.700035, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 16640, "a51", "a51_panel2", 0x00000000);
    tmpobjid = CreateDynamicObject(3807, 1915.288085, 1465.473266, 1096.682861, -0.000012, -0.000009, 77.099945, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 16640, "a51", "a51_panel2", 0x00000000);
    tmpobjid = CreateDynamicObject(1316, 1916.296630, 1469.161865, 1096.112426, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 16640, "a51", "a51_glass", 0xFF202020);
    tmpobjid = CreateDynamicObject(1316, 1916.296630, 1469.161865, 1097.112426, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 16640, "a51", "a51_glass", 0xFF202020);
    tmpobjid = CreateDynamicObject(1316, 1916.296630, 1469.161865, 1098.112426, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 16640, "a51", "a51_glass", 0xFF202020);
    tmpobjid = CreateDynamicObject(1316, 1916.296630, 1469.161865, 1099.112426, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 16640, "a51", "a51_glass", 0xFF202020);
    tmpobjid = CreateDynamicObject(1316, 1916.296630, 1469.161865, 1100.112426, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 16640, "a51", "a51_glass", 0xFF202020);
    tmpobjid = CreateDynamicObject(1317, 1916.274780, 1469.136108, 1100.932861, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 13659, "8bars", "AH_gbarrier", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(16332, 1914.826416, 1467.479003, 1101.110961, 0.000000, 0.000000, 45.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 5150, "wiresetc_las2", "ganggraf01_LA_m", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 2, 16093, "a51_ext", "ws_controltowerwin1", 0x00000000);
    tmpobjid = CreateDynamicObject(16332, 1917.910888, 1470.563476, 1101.110961, 0.000000, 0.000000, 45.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 5150, "wiresetc_las2", "ganggraf01_LA_m", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 2, 16093, "a51_ext", "ws_controltowerwin1", 0x00000000);
    tmpobjid = CreateDynamicObject(16332, 1917.811523, 1467.548583, 1101.110961, 0.000000, 0.000000, 135.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 5150, "wiresetc_las2", "ganggraf01_LA_m", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 2, 16093, "a51_ext", "ws_controltowerwin1", 0x00000000);
    tmpobjid = CreateDynamicObject(16332, 1914.705688, 1470.654418, 1101.110961, 0.000000, 0.000000, 135.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 5150, "wiresetc_las2", "ganggraf01_LA_m", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 2, 16093, "a51_ext", "ws_controltowerwin1", 0x00000000);
    tmpobjid = CreateDynamicObject(19437, 1878.231079, 1469.239013, 1094.641357, 0.000000, 90.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10226, "sfeship1", "sf_shipcomp", 0x00000000);
    tmpobjid = CreateDynamicObject(13646, 1879.842529, 1469.272705, 1093.131103, 0.000000, 0.000007, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10763, "airport1_sfse", "airportwind03", 0xFFFFFFFF);
    SetDynamicObjectMaterial(tmpobjid, 1, 3979, "civic01_lan", "sl_laglasswall2", 0x00000000);
    tmpobjid = CreateDynamicObject(19437, 1878.951782, 1469.238037, 1093.920654, 90.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 1809, "cj_hi_fi", "CJ_speaker_6", 0x00000000);
    tmpobjid = CreateDynamicObject(19846, 1879.490844, 1469.244262, 1094.345092, -12.500001, 0.000000, -89.999977, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 1560, "7_11_door", "cj_sheetmetal2", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(13646, 1881.162719, 1469.272705, 1092.910888, 0.000000, 0.000007, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10763, "airport1_sfse", "airportwind03", 0xFFFFFFFF);
    SetDynamicObjectMaterial(tmpobjid, 1, 16640, "a51", "metpat64", 0x00000000);
    tmpobjid = CreateDynamicObject(13646, 1880.502075, 1469.272705, 1092.980957, 0.000000, 0.000007, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10763, "airport1_sfse", "airportwind03", 0xFFFFFFFF);
    SetDynamicObjectMaterial(tmpobjid, 1, 16640, "a51", "metpat64", 0x00000000);
    tmpobjid = CreateDynamicObject(19846, 1879.509887, 1469.626708, 1094.001831, -0.000007, 90.000000, -104.099922, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 2028, "cj_games", "CJ_speaker4", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(19846, 1879.509887, 1468.921020, 1094.001708, 0.599991, 90.000000, -75.499992, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 2028, "cj_games", "CJ_speaker4", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(1628, 1879.704589, 1469.350463, 1093.600341, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 2028, "cj_games", "CJ_speaker4", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(1628, 1879.705566, 1469.170288, 1093.600341, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 2028, "cj_games", "CJ_speaker4", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(19437, 1878.903930, 1466.404541, 1094.491088, 0.000000, 90.000000, 126.499977, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 2028, "cj_games", "CJ_speaker4", 0x00000000);
    tmpobjid = CreateDynamicObject(19437, 1878.883544, 1472.119750, 1094.491088, 180.000000, 90.000000, 55.099945, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 2028, "cj_games", "CJ_speaker4", 0x00000000);
    tmpobjid = CreateDynamicObject(19437, 1880.885742, 1474.990478, 1094.641235, 0.000000, 90.000000, 55.099945, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 2028, "cj_games", "CJ_speaker4", 0x00000000);
    tmpobjid = CreateDynamicObject(19437, 1880.979370, 1463.598266, 1094.621215, 0.000000, 90.000000, 306.499969, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 2028, "cj_games", "CJ_speaker4", 0x00000000);
    tmpobjid = CreateDynamicObject(19437, 1879.483764, 1466.832885, 1093.760375, 90.000000, 90.000000, 126.499977, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 1809, "cj_hi_fi", "CJ_speaker_6", 0x00000000);
    tmpobjid = CreateDynamicObject(19437, 1881.565429, 1464.020019, 1093.760375, 90.000000, 90.000000, 126.499977, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 1809, "cj_hi_fi", "CJ_speaker_6", 0x00000000);
    tmpobjid = CreateDynamicObject(19437, 1879.472900, 1471.706787, 1093.760375, 90.000000, 90.000000, 55.099945, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 1809, "cj_hi_fi", "CJ_speaker_6", 0x00000000);
    tmpobjid = CreateDynamicObject(19437, 1881.457153, 1474.553100, 1093.760375, 90.000000, 90.000000, 55.099945, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 1809, "cj_hi_fi", "CJ_speaker_6", 0x00000000);
    tmpobjid = CreateDynamicObject(19456, 1886.589477, 1465.913696, 1093.510498, 0.000000, 90.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14789, "ab_sfgymmain", "gun_ceiling2_128", 0x00000000);
    tmpobjid = CreateDynamicObject(19456, 1883.386474, 1465.913696, 1093.509521, 0.000000, 90.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14789, "ab_sfgymmain", "gun_ceiling2_128", 0x00000000);
    tmpobjid = CreateDynamicObject(19456, 1883.386474, 1472.684204, 1093.509521, 0.000000, 90.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14789, "ab_sfgymmain", "gun_ceiling2_128", 0x00000000);
    tmpobjid = CreateDynamicObject(19456, 1886.588256, 1472.684204, 1093.510498, 0.000000, 90.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14789, "ab_sfgymmain", "gun_ceiling2_128", 0x00000000);
    tmpobjid = CreateDynamicObject(19456, 1886.578247, 1471.022583, 1091.840209, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 16322, "a51_stores", "metpat64chev_128", 0x00000000);
    tmpobjid = CreateDynamicObject(19456, 1886.578247, 1467.580932, 1091.840209, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 16322, "a51_stores", "metpat64chev_128", 0x00000000);
    tmpobjid = CreateDynamicObject(19475, 1879.319213, 1469.247314, 1094.442382, 0.000000, 102.799942, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 16640, "a51", "a51_boffstuff1", 0x00000000);
    tmpobjid = CreateDynamicObject(19475, 1879.709838, 1469.247314, 1094.354248, 0.000000, 102.799942, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 16640, "a51", "a51_boffstuff3", 0x00000000);
    tmpobjid = CreateDynamicObject(2114, 1878.675292, 1468.295288, 1094.701293, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 19941, "goldbar1", "chrome", 0x00000000);
    tmpobjid = CreateDynamicObject(2114, 1878.675292, 1470.227050, 1094.701293, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 19941, "goldbar1", "chrome", 0x00000000);
    tmpobjid = CreateDynamicObject(19475, 1878.686523, 1468.310913, 1094.731201, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0xFF000000);
    tmpobjid = CreateDynamicObject(19475, 1878.686523, 1470.232299, 1094.731201, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0xFF000000);
    tmpobjid = CreateDynamicObject(19135, 1878.676147, 1468.307128, 1094.901000, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 19029, "matglasses", "glassestype16map", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 1, 5150, "wiresetc_las2", "ganggraf01_LA_m", 0x00000000);
    tmpobjid = CreateDynamicObject(19135, 1878.676147, 1470.238647, 1094.901000, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 19029, "matglasses", "glassestype16map", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 1, 5150, "wiresetc_las2", "ganggraf01_LA_m", 0x00000000);
    tmpobjid = CreateDynamicObject(1581, 1878.682983, 1468.330444, 1095.371337, 0.000000, 0.000000, 450.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 9818, "ship_brijsfw", "ship_greenscreen1", 0x90FFFFFF);
    tmpobjid = CreateDynamicObject(1581, 1878.682983, 1470.221679, 1095.371337, 0.000000, 0.000000, 1710.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10226, "sfeship1", "sf_shipcomp", 0x9000FF00);
    tmpobjid = CreateDynamicObject(19483, 1879.244384, 1466.135253, 1094.590454, 0.000000, 270.000000, 396.700012, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 16640, "a51", "a51_boffstuff3", 0x00000000);
    tmpobjid = CreateDynamicObject(19483, 1879.192993, 1472.405517, 1094.590454, 0.000000, 270.000000, 324.600036, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 16640, "a51", "a51_boffstuff1", 0x00000000);
    tmpobjid = CreateDynamicObject(1613, 1878.838378, 1468.236572, 1094.090820, 0.000000, 90.000000, 630.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 2028, "cj_games", "CJ_speaker4", 0x00000000);
    tmpobjid = CreateDynamicObject(1613, 1878.838378, 1470.267456, 1094.090820, 0.000000, 90.000000, 630.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 2028, "cj_games", "CJ_speaker4", 0x00000000);
    tmpobjid = CreateDynamicObject(18633, 1879.479614, 1468.225708, 1094.371093, 180.000000, 0.000000, 450.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 16640, "a51", "a51_metal1", 0x00000000);
    tmpobjid = CreateDynamicObject(18633, 1879.479614, 1470.256835, 1094.371093, 180.000000, 0.000000, 450.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 16640, "a51", "a51_metal1", 0x00000000);
    tmpobjid = CreateDynamicObject(2352, 1879.857421, 1468.220825, 1094.560668, 90.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 16640, "a51", "banding3c_64HV", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 1, 16640, "a51", "banding3c_64HV", 0x00000000);
    tmpobjid = CreateDynamicObject(2352, 1879.857421, 1468.220825, 1094.560668, 90.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 16640, "a51", "banding3c_64HV", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 1, 16640, "a51", "banding3c_64HV", 0x00000000);
    tmpobjid = CreateDynamicObject(2352, 1879.857421, 1470.261962, 1094.560668, 90.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 16640, "a51", "banding3c_64HV", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 1, 16640, "a51", "banding3c_64HV", 0x00000000);
    tmpobjid = CreateDynamicObject(2352, 1879.857421, 1470.261962, 1094.560668, 90.000000, 0.000000, 360.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 16640, "a51", "banding3c_64HV", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 1, 16640, "a51", "banding3c_64HV", 0x00000000);
    tmpobjid = CreateDynamicObject(1562, 1880.310424, 1468.256835, 1094.360717, 0.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 1809, "cj_hi_fi", "CJ_speaker_6", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(1562, 1880.310424, 1470.238525, 1094.360717, 0.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 1809, "cj_hi_fi", "CJ_speaker_6", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(1563, 1880.650756, 1468.257812, 1094.881469, 0.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(1563, 1880.650756, 1470.239501, 1094.881469, 0.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(2114, 1880.560424, 1465.004882, 1094.701293, 0.000007, 0.000007, 89.999946, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 19941, "goldbar1", "chrome", 0x00000000);
    tmpobjid = CreateDynamicObject(19475, 1880.544799, 1465.016113, 1094.731201, 0.000007, 90.000007, 89.999946, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0xFF000000);
    tmpobjid = CreateDynamicObject(19135, 1880.548583, 1465.005737, 1094.901000, 0.000007, 0.000007, 89.999946, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 19029, "matglasses", "glassestype16map", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 1, 5150, "wiresetc_las2", "ganggraf01_LA_m", 0x00000000);
    tmpobjid = CreateDynamicObject(1581, 1880.525268, 1465.012573, 1095.371337, 0.000007, -0.000007, 539.999877, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 9818, "ship_brijsfw", "ship_screen1sfw", 0x9000FF00);
    tmpobjid = CreateDynamicObject(2114, 1880.435180, 1473.588623, 1094.701293, 0.000000, 0.000007, -90.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 19941, "goldbar1", "chrome", 0x00000000);
    tmpobjid = CreateDynamicObject(19475, 1880.450805, 1473.577392, 1094.731201, 0.000000, 90.000007, -90.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0xFF000000);
    tmpobjid = CreateDynamicObject(19135, 1880.447021, 1473.587768, 1094.901000, 0.000000, 0.000007, -90.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 19029, "matglasses", "glassestype16map", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 1, 5150, "wiresetc_las2", "ganggraf01_LA_m", 0x00000000);
    tmpobjid = CreateDynamicObject(1581, 1880.470336, 1473.580932, 1095.371337, 0.000007, 0.000000, -0.000105, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 19894, "laptopsamp1", "laptopscreen2", 0x9000FF00);
    tmpobjid = CreateDynamicObject(19379, 1884.954956, 1469.286987, 1098.185791, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 1809, "cj_hi_fi", "CJ_speaker_6", 0x00000000);
    tmpobjid = CreateDynamicObject(1562, 1881.314941, 1466.178710, 1094.190551, -0.000007, 0.000000, -67.099983, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 1809, "cj_hi_fi", "CJ_speaker_6", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(1563, 1881.627929, 1466.312011, 1094.711303, -0.000007, 0.000000, -67.099983, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(1562, 1881.243286, 1472.498901, 1094.190551, -0.000014, 0.000001, -116.499954, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 1809, "cj_hi_fi", "CJ_speaker_6", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(1563, 1881.548217, 1472.348022, 1094.711303, -0.000014, 0.000001, -116.499954, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(3387, 1885.286132, 1465.205322, 1093.596435, 0.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    SetDynamicObjectMaterial(tmpobjid, 1, 2028, "cj_games", "CJ_speaker4", 0x00000000);
    tmpobjid = CreateDynamicObject(3387, 1883.245727, 1465.205322, 1093.596435, 0.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    SetDynamicObjectMaterial(tmpobjid, 1, 2028, "cj_games", "CJ_speaker4", 0x00000000);
    tmpobjid = CreateDynamicObject(3387, 1883.245605, 1473.401245, 1093.596435, 0.000007, 0.000000, 89.999916, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    SetDynamicObjectMaterial(tmpobjid, 1, 2028, "cj_games", "CJ_speaker4", 0x00000000);
    tmpobjid = CreateDynamicObject(3387, 1885.286010, 1473.401245, 1093.596435, 0.000007, 0.000000, 89.999916, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    SetDynamicObjectMaterial(tmpobjid, 1, 2028, "cj_games", "CJ_speaker4", 0x00000000);
    tmpobjid = CreateDynamicObject(3385, 1883.225219, 1472.927856, 1095.217895, 90.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(3385, 1885.286987, 1472.927856, 1095.217895, 90.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(3385, 1885.286987, 1465.696166, 1095.217895, 90.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(3385, 1883.245971, 1465.696166, 1095.217895, 90.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(19483, 1877.336547, 1467.951416, 1095.610717, 89.999992, 89.999992, -89.999992, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 16640, "a51", "a51_glass", 0x80FFFFFF);
    tmpobjid = CreateDynamicObject(19482, 1878.964721, 1464.792358, 1095.213012, 0.000000, 0.000000, 35.999988, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 16640, "a51", "a51_glass", 0x80FFFFFF);
    tmpobjid = CreateDynamicObject(19482, 1878.999267, 1473.792724, 1095.213012, 0.000000, 0.000000, -36.100013, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 16640, "a51", "a51_glass", 0x80FFFFFF);
    tmpobjid = CreateDynamicObject(19483, 1877.336547, 1469.301513, 1095.610717, 89.999992, 89.999992, -89.999992, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 16640, "a51", "a51_glass", 0x80FFFFFF);
    tmpobjid = CreateDynamicObject(19483, 1877.336547, 1470.651611, 1095.610717, 89.999992, 89.999992, -89.999992, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 16640, "a51", "a51_glass", 0x80FFFFFF);
    tmpobjid = CreateDynamicObject(8877, 1877.323364, 1467.163330, 1092.797363, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 16640, "a51", "a51_strips1", 0xFFFFFFFF);
    SetDynamicObjectMaterial(tmpobjid, 1, 16640, "a51", "a51_strips1", 0x00000000);
    tmpobjid = CreateDynamicObject(8877, 1877.323364, 1471.433959, 1092.797363, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 16640, "a51", "a51_strips1", 0xFFFFFFFF);
    SetDynamicObjectMaterial(tmpobjid, 1, 16640, "a51", "a51_strips1", 0x00000000);
    tmpobjid = CreateDynamicObject(2114, 1877.794433, 1469.296142, 1094.701293, 0.000000, 0.000022, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 19941, "goldbar1", "chrome", 0x00000000);
    tmpobjid = CreateDynamicObject(19475, 1877.805664, 1469.301391, 1094.731201, 0.000000, 90.000022, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0xFF000000);
    tmpobjid = CreateDynamicObject(19135, 1877.795288, 1469.307739, 1094.901000, 0.000000, 0.000022, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 19029, "matglasses", "glassestype16map", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 1, 5150, "wiresetc_las2", "ganggraf01_LA_m", 0x00000000);
    tmpobjid = CreateDynamicObject(19475, 1877.873901, 1469.311889, 1095.342407, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 18064, "ab_sfammuunits", "gun_targetc", 0x9000FF00);
    tmpobjid = CreateDynamicObject(18844, 1774.873901, 1545.311401, 1073.667968, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 3096, "bbpcpx", "blugrad32", 0x00000000);
    tmpobjid = CreateDynamicObject(900, 1799.154296, 1507.824951, 1087.425537, 71.199981, 26.999969, -0.199999, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 12871, "ce_ground01", "sw_rockgrass1", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(900, 1812.613037, 1518.713623, 1083.532348, -103.700012, -19.600023, 45.100017, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 12871, "ce_ground01", "sw_rockgrass1", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(900, 1800.724121, 1507.093627, 1074.701293, 0.000000, -96.999992, 112.800018, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 12871, "ce_ground01", "sw_stonesgrass", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(900, 1803.916137, 1522.718505, 1102.066894, 21.799995, -46.299983, 112.800018, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 12871, "ce_ground01", "sw_stonesgrass", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(900, 1811.598144, 1523.747680, 1094.621582, 34.000011, -54.599975, 112.800018, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(900, 1816.552612, 1557.431518, 1089.523559, -6.299984, -79.199958, -173.699935, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 12871, "ce_ground01", "sw_stonesgrass", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(900, 1775.592651, 1501.072509, 1060.765869, -27.699979, -97.899971, 105.400115, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(900, 1768.428833, 1515.080444, 1108.764282, -16.699979, -44.799953, 105.400115, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(900, 1775.779052, 1517.105468, 1111.052001, 6.300024, -44.799953, 105.400115, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(900, 1814.242553, 1531.186645, 1053.889282, 6.300024, -124.699928, -178.399917, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 12871, "ce_ground01", "sw_stonesgrass", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(18844, 1777.263549, 1546.472290, 1073.667968, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 2567, "ab", "ab_plasicwrapa", 0x00000000);
    tmpobjid = CreateDynamicObject(18844, 1776.333251, 1542.501708, 1073.667968, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 2567, "ab", "ab_plasicwrapa", 0x00000000);
    tmpobjid = CreateDynamicObject(19326, 1838.741821, 1470.091552, 1095.991577, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 19063, "xmasorbs", "sphere", 0x00000000);
    tmpobjid = CreateDynamicObject(19326, 1838.741821, 1447.421264, 1095.991577, 0.000000, 0.000000, 113.900016, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 19063, "xmasorbs", "sphere", 0x00000000);
    tmpobjid = CreateDynamicObject(19326, 1835.971069, 1464.350952, 1093.700073, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 19063, "xmasorbs", "sphere", 0x00000000);
    tmpobjid = CreateDynamicObject(19326, 1835.971069, 1464.350952, 1105.879638, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 19063, "xmasorbs", "sphere", 0x00000000);
    tmpobjid = CreateDynamicObject(19326, 1835.971069, 1482.671875, 1106.840209, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 19063, "xmasorbs", "sphere", 0x00000000);
    tmpobjid = CreateDynamicObject(19326, 1835.971069, 1441.781982, 1106.840209, 0.000000, 0.000000, 124.599998, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 19063, "xmasorbs", "sphere", 0x00000000);
    tmpobjid = CreateDynamicObject(19326, 1857.975952, 1512.323608, 1098.979858, 0.000000, 0.000000, 214.600006, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 19063, "xmasorbs", "sphere", 0x00000000);
    tmpobjid = CreateDynamicObject(19326, 1861.194213, 1514.543945, 1106.679565, 0.000000, 0.000000, 214.600006, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 19063, "xmasorbs", "sphere", 0x00000000);
    tmpobjid = CreateDynamicObject(19326, 1860.346923, 1439.378662, 1098.579833, 0.000000, 0.000000, 304.600006, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 19063, "xmasorbs", "sphere", 0x00000000);
    tmpobjid = CreateDynamicObject(19326, 1853.936279, 1448.671386, 1092.490112, 0.000000, 0.000000, 304.600006, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 19063, "xmasorbs", "sphere", 0x00000000);
    tmpobjid = CreateDynamicObject(19326, 1847.968872, 1463.044433, 1084.329711, 23.299997, 0.000000, -81.299972, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 19063, "xmasorbs", "sphere", 0x00000000);
    tmpobjid = CreateDynamicObject(19326, 1850.149414, 1453.808227, 1082.566284, 23.299997, 0.000000, -81.299972, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 19063, "xmasorbs", "sphere", 0x00000000);
    tmpobjid = CreateDynamicObject(2352, 1879.530395, 1468.950439, 1094.380859, 0.000000, -42.299964, -179.099960, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 16640, "a51", "banding3c_64HV", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 1, 16640, "a51", "banding3c_64HV", 0x00000000);
    tmpobjid = CreateDynamicObject(2352, 1879.566040, 1468.951049, 1094.375610, 0.000000, -42.299964, -179.099960, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 16640, "a51", "banding3c_64HV", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 1, 16640, "a51", "banding3c_64HV", 0x00000000);
    tmpobjid = CreateDynamicObject(19478, 1879.528198, 1469.007202, 1094.392822, 12.099988, 90.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14548, "ab_cargo_int", "cargo_pipes", 0x00000000);
    tmpobjid = CreateDynamicObject(2969, 1880.672485, 1470.227661, 1094.901123, 90.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 5150, "wiresetc_las2", "ganggraf01_LA_m", 0x00000000);
    tmpobjid = CreateDynamicObject(2969, 1880.672485, 1468.256591, 1094.901123, 90.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 5150, "wiresetc_las2", "ganggraf01_LA_m", 0x00000000);
    tmpobjid = CreateDynamicObject(2969, 1881.648193, 1466.308593, 1094.690917, 90.000000, 0.000000, 111.599967, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 5150, "wiresetc_las2", "ganggraf01_LA_m", 0x00000000);
    tmpobjid = CreateDynamicObject(2969, 1881.535644, 1472.333984, 1094.690917, 90.000000, 0.000000, 63.499950, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 5150, "wiresetc_las2", "ganggraf01_LA_m", 0x00000000);
    tmpobjid = CreateDynamicObject(19379, 1946.661132, 1469.286987, 1093.345458, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 16644, "a51_detailstuff", "steel256128", 0x00000000);
    tmpobjid = CreateDynamicObject(19379, 1957.151855, 1469.286987, 1093.345458, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 16644, "a51_detailstuff", "steel256128", 0x00000000);
    tmpobjid = CreateDynamicObject(19379, 1967.643798, 1469.286987, 1093.345458, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 16644, "a51_detailstuff", "steel256128", 0x00000000);
    tmpobjid = CreateDynamicObject(19379, 1978.124145, 1469.286987, 1093.345458, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 16644, "a51_detailstuff", "steel256128", 0x00000000);
    tmpobjid = CreateDynamicObject(19379, 1967.643798, 1459.655883, 1093.345458, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 16644, "a51_detailstuff", "steel256128", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(19379, 1967.643798, 1478.916137, 1093.345458, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 16644, "a51_detailstuff", "steel256128", 0x00000000);
    tmpobjid = CreateDynamicObject(19379, 1957.151855, 1478.896606, 1093.345458, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 16644, "a51_detailstuff", "steel256128", 0x00000000);
    tmpobjid = CreateDynamicObject(19379, 1957.151855, 1459.657104, 1093.345458, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 16644, "a51_detailstuff", "steel256128", 0x00000000);
    tmpobjid = CreateDynamicObject(19379, 1946.661132, 1459.656982, 1093.345458, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 16644, "a51_detailstuff", "steel256128", 0x00000000);
    tmpobjid = CreateDynamicObject(19379, 1946.661132, 1478.907592, 1093.345458, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 16644, "a51_detailstuff", "steel256128", 0x00000000);
    tmpobjid = CreateDynamicObject(19387, 1932.975341, 1469.309204, 1095.171875, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 16640, "a51", "a51_floorpanel1", 0x00000000);
    tmpobjid = CreateDynamicObject(19387, 1941.287719, 1469.309204, 1095.171875, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 16640, "a51", "a51_floorpanel1", 0x00000000);
    tmpobjid = CreateDynamicObject(19447, 1932.975341, 1462.909667, 1095.171875, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 16640, "a51", "a51_floorpanel1", 0x00000000);
    tmpobjid = CreateDynamicObject(19447, 1932.975341, 1475.729980, 1095.171875, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 16640, "a51", "a51_floorpanel1", 0x00000000);
    tmpobjid = CreateDynamicObject(19447, 1941.277221, 1475.729980, 1095.171875, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 16640, "a51", "a51_floorpanel1", 0x00000000);
    tmpobjid = CreateDynamicObject(19447, 1941.277221, 1462.901611, 1095.171875, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 16640, "a51", "a51_floorpanel1", 0x00000000);
    tmpobjid = CreateDynamicObject(19447, 1941.277221, 1469.431762, 1098.672973, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 2917, "a51_crane", "girder2_grey_64HV", 0x00000000);
    tmpobjid = CreateDynamicObject(19447, 1932.986083, 1469.431762, 1098.672973, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 2917, "a51_crane", "girder2_grey_64HV", 0x00000000);
    tmpobjid = CreateDynamicObject(19387, 1979.914428, 1469.309204, 1095.171875, 0.000000, 0.000007, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 16640, "a51", "a51_floorpanel1", 0x00000000);
    tmpobjid = CreateDynamicObject(19447, 1979.903930, 1475.729980, 1095.171875, 0.000000, 0.000007, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 16640, "a51", "a51_floorpanel1", 0x00000000);
    tmpobjid = CreateDynamicObject(19447, 1979.903930, 1462.901611, 1095.171875, 0.000000, 0.000007, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 16640, "a51", "a51_floorpanel1", 0x00000000);
    tmpobjid = CreateDynamicObject(19447, 1979.903930, 1469.431762, 1098.672973, 0.000000, 0.000007, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 2917, "a51_crane", "girder2_grey_64HV", 0x00000000);
    tmpobjid = CreateDynamicObject(2972, 1954.114013, 1475.590332, 1093.431396, 0.000000, 0.000000, 810.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(2972, 1963.323730, 1475.059936, 1093.431396, 0.000000, 0.000000, 900.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(2972, 1963.323730, 1473.479614, 1093.431396, 0.000000, 0.000000, 252.100067, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(2972, 1959.868774, 1462.782104, 1093.431396, 0.000000, 0.000000, 1.300063, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(2972, 1958.330932, 1463.107299, 1093.431396, 0.000000, 0.000000, 13.700062, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(2972, 1959.106323, 1463.007568, 1094.621826, 0.000000, 0.000000, 83.200065, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(2972, 1951.433959, 1465.050048, 1093.410766, 0.000000, 0.000000, 83.200065, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(2972, 1964.714843, 1465.289184, 1093.410766, 0.000000, 0.000000, 173.200073, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(2972, 1968.506347, 1472.258911, 1093.410766, 0.000000, 0.000000, -142.699920, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(2975, 1957.551879, 1476.438842, 1093.431396, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(2975, 1961.612548, 1475.207885, 1093.431396, 0.000000, 0.000000, 84.700019, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(2975, 1965.292846, 1474.394409, 1093.431396, 0.000000, 0.000000, 70.900039, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(2975, 1951.651000, 1475.096557, 1093.431396, 0.000000, 0.000000, -166.199966, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(2975, 1959.010131, 1472.096069, 1093.431396, 0.000000, 0.000000, -166.199966, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(2975, 1962.098632, 1463.802001, 1093.431396, 0.000000, 0.000000, 171.800033, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(2975, 1956.147827, 1463.174560, 1093.431396, 0.000000, 0.000000, -66.999946, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(2975, 1946.460327, 1466.113037, 1093.431396, 0.000000, 0.000000, -33.999942, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(2974, 1956.032714, 1473.050537, 1093.431396, 0.000000, 0.000000, 82.700012, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(2974, 1953.506103, 1462.766479, 1093.431396, 0.000000, 0.000000, 82.700012, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(2974, 1966.954345, 1473.339477, 1093.431396, 0.000000, 0.000000, 134.500015, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(2974, 1966.928344, 1465.086181, 1093.431396, 0.000000, 0.000000, -168.200012, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(2974, 1959.279541, 1466.777709, 1093.431396, 0.000000, 0.000000, -78.200012, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(2973, 1949.443969, 1465.590209, 1093.421386, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(2973, 1949.123779, 1473.612792, 1093.421386, 0.000000, 0.000000, 108.700004, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(2973, 1955.237792, 1465.906127, 1093.421386, 0.000000, 0.000000, 108.700004, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(2973, 1962.384277, 1466.800292, 1093.421386, 0.000000, 0.000000, 103.399971, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(2977, 1958.991210, 1474.429809, 1093.301269, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(2977, 1959.791748, 1476.220947, 1093.301269, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(2977, 1957.461425, 1464.439453, 1093.301269, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(2977, 1953.002075, 1465.769897, 1093.301269, 0.000000, 0.000000, -163.399993, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(2977, 1952.126098, 1473.545776, 1093.301269, 0.000000, 0.000000, -163.399993, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(2977, 1946.436645, 1473.341674, 1093.301269, 0.000000, 0.000000, 88.699996, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(2977, 1970.390625, 1472.798217, 1093.301269, 0.000000, 0.000000, 88.699996, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(19447, 1958.109008, 1467.552124, 1101.746459, 0.000000, -101.099975, 90.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 16640, "a51", "a51_intdoor", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(19447, 1958.109008, 1470.845092, 1101.750976, 0.000000, -101.099975, 270.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 16640, "a51", "a51_intdoor", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(9131, 1954.461425, 1472.926635, 1101.293090, 20.200000, 90.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14548, "ab_cargo_int", "cargo_floor1", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(9131, 1956.712036, 1472.926635, 1101.293090, 20.200000, 90.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14548, "ab_cargo_int", "cargo_floor1", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(9131, 1958.972167, 1472.926635, 1101.293090, 20.200000, 90.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14548, "ab_cargo_int", "cargo_floor1", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(9131, 1961.242919, 1472.926635, 1101.293090, 20.200000, 90.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14548, "ab_cargo_int", "cargo_floor1", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(9131, 1961.783447, 1472.926635, 1101.294067, 20.200000, 90.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14548, "ab_cargo_int", "cargo_floor1", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(9131, 1961.783447, 1465.461914, 1101.293090, 20.199996, 90.000000, -0.000014, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14548, "ab_cargo_int", "cargo_floor1", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(9131, 1959.532836, 1465.461914, 1101.293090, 20.199996, 90.000000, -0.000014, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14548, "ab_cargo_int", "cargo_floor1", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(9131, 1957.272705, 1465.461914, 1101.293090, 20.199996, 90.000000, -0.000014, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14548, "ab_cargo_int", "cargo_floor1", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(9131, 1955.001953, 1465.461914, 1101.293090, 20.199996, 90.000000, -0.000014, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14548, "ab_cargo_int", "cargo_floor1", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(9131, 1954.461425, 1465.461914, 1101.294067, 20.199996, 90.000000, -0.000014, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14548, "ab_cargo_int", "cargo_floor1", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(9131, 1963.254638, 1472.016601, 1101.223999, 0.000000, 90.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14548, "ab_cargo_int", "cargo_floor1", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(9131, 1963.254638, 1469.746704, 1101.223999, 0.000000, 90.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14548, "ab_cargo_int", "cargo_floor1", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(9131, 1963.254638, 1467.486083, 1101.223999, 0.000000, 90.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14548, "ab_cargo_int", "cargo_floor1", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(9131, 1963.254638, 1466.386474, 1101.224975, 0.000000, 90.000000, 270.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14548, "ab_cargo_int", "cargo_floor1", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(9131, 1963.254638, 1468.387207, 1101.955322, 0.000000, 90.000000, 270.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14548, "ab_cargo_int", "cargo_floor1", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(9131, 1963.254638, 1470.646850, 1101.955322, 0.000000, 90.000000, 270.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14548, "ab_cargo_int", "cargo_floor1", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(9131, 1952.941040, 1472.016601, 1101.223999, 0.000014, 90.000000, 89.999954, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14548, "ab_cargo_int", "cargo_floor1", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(9131, 1952.941040, 1469.746704, 1101.223999, 0.000014, 90.000000, 89.999954, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14548, "ab_cargo_int", "cargo_floor1", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(9131, 1952.941040, 1467.486083, 1101.223999, 0.000014, 90.000000, 89.999954, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14548, "ab_cargo_int", "cargo_floor1", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(9131, 1952.941040, 1466.386474, 1101.224975, -0.000014, 90.000000, -89.999954, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14548, "ab_cargo_int", "cargo_floor1", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(9131, 1952.941040, 1468.387207, 1101.955322, -0.000014, 90.000000, -89.999954, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14548, "ab_cargo_int", "cargo_floor1", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(9131, 1952.941040, 1470.646850, 1101.955322, -0.000014, 90.000000, -89.999954, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14548, "ab_cargo_int", "cargo_floor1", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(9131, 1952.941040, 1474.224731, 1100.490478, 0.000014, 125.199958, 89.999954, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14548, "ab_cargo_int", "cargo_floor1", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(9131, 1952.941040, 1475.917358, 1099.035766, 0.000014, 138.199966, 89.999954, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14548, "ab_cargo_int", "cargo_floor1", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(9131, 1952.941040, 1477.225341, 1097.235107, 0.000014, 149.500000, 89.999954, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14548, "ab_cargo_int", "cargo_floor1", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(9131, 1952.941040, 1477.980468, 1095.042114, 0.000014, 172.100219, 89.999954, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14548, "ab_cargo_int", "cargo_floor1", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(9131, 1952.931030, 1477.711059, 1094.181640, -9.999999, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14548, "ab_cargo_int", "cargo_floor1", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(9131, 1963.250488, 1474.224731, 1100.490478, 0.000029, 125.199958, 89.999908, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14548, "ab_cargo_int", "cargo_floor1", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(9131, 1963.250488, 1475.917358, 1099.035766, 0.000029, 138.199966, 89.999908, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14548, "ab_cargo_int", "cargo_floor1", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(9131, 1963.250488, 1477.225341, 1097.235107, 0.000029, 149.500000, 89.999908, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14548, "ab_cargo_int", "cargo_floor1", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(9131, 1963.250488, 1477.980468, 1095.042114, 0.000029, 172.100219, 89.999908, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14548, "ab_cargo_int", "cargo_floor1", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(9131, 1963.240478, 1477.711059, 1094.181640, -9.999999, 0.000014, 0.000001, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14548, "ab_cargo_int", "cargo_floor1", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(9131, 1963.240600, 1464.358154, 1100.490478, 0.000007, 125.199958, -89.999992, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14548, "ab_cargo_int", "cargo_floor1", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(9131, 1963.240600, 1462.665527, 1099.035766, 0.000007, 138.199966, -89.999992, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14548, "ab_cargo_int", "cargo_floor1", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(9131, 1963.240600, 1461.357543, 1097.235107, 0.000007, 149.500000, -89.999992, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14548, "ab_cargo_int", "cargo_floor1", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(9131, 1963.240600, 1460.602416, 1095.042114, 0.000007, 172.100219, -89.999992, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14548, "ab_cargo_int", "cargo_floor1", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(9131, 1963.250610, 1460.871826, 1094.181640, -9.999999, -0.000007, 179.999847, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14548, "ab_cargo_int", "cargo_floor1", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(9131, 1952.931152, 1464.358154, 1100.490478, 0.000022, 125.199958, -90.000038, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14548, "ab_cargo_int", "cargo_floor1", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(9131, 1952.931152, 1462.665527, 1099.035766, 0.000022, 138.199966, -90.000038, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14548, "ab_cargo_int", "cargo_floor1", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(9131, 1952.931152, 1461.357543, 1097.235107, 0.000022, 149.500000, -90.000038, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14548, "ab_cargo_int", "cargo_floor1", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(9131, 1952.931152, 1460.602416, 1095.042114, 0.000022, 172.100219, -90.000038, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14548, "ab_cargo_int", "cargo_floor1", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(9131, 1952.941162, 1460.871826, 1094.181640, -9.999999, 0.000007, 179.999862, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14548, "ab_cargo_int", "cargo_floor1", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(19387, 1916.349365, 1485.074707, 1095.171875, 0.000015, 0.000007, 89.999923, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 16640, "a51", "a51_floorpanel1", 0x00000000);
    tmpobjid = CreateDynamicObject(19447, 1922.748901, 1485.074707, 1095.171875, 0.000015, 0.000007, 89.999923, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 16640, "a51", "a51_floorpanel1", 0x00000000);
    tmpobjid = CreateDynamicObject(19447, 1909.928588, 1485.074707, 1095.171875, 0.000015, 0.000007, 89.999923, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 16640, "a51", "a51_floorpanel1", 0x00000000);
    tmpobjid = CreateDynamicObject(19447, 1916.226806, 1485.085449, 1098.672973, 0.000015, 0.000007, 89.999923, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 2917, "a51_crane", "girder2_grey_64HV", 0x00000000);
    tmpobjid = CreateDynamicObject(19387, 1916.349365, 1453.321899, 1095.171875, 0.000022, 0.000007, 89.999900, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 16640, "a51", "a51_floorpanel1", 0x00000000);
    tmpobjid = CreateDynamicObject(19447, 1922.748901, 1453.321899, 1095.171875, 0.000022, 0.000007, 89.999900, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 16640, "a51", "a51_floorpanel1", 0x00000000);
    tmpobjid = CreateDynamicObject(19447, 1909.928588, 1453.321899, 1095.171875, 0.000022, 0.000007, 89.999900, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 16640, "a51", "a51_floorpanel1", 0x00000000);
    tmpobjid = CreateDynamicObject(19447, 1916.226806, 1453.332641, 1098.672973, 0.000022, 0.000007, 89.999900, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 2917, "a51_crane", "girder2_grey_64HV", 0x00000000);
    tmpobjid = CreateDynamicObject(19602, 1891.322143, 1469.249511, 1096.042602, 0.000000, 90.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 19623, "camera1", "cscamera02", 0x00000000);
    tmpobjid = CreateDynamicObject(19602, 1891.622436, 1469.249511, 1096.042602, 0.000000, 90.000000, 360.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 19623, "camera1", "cscamera02", 0x00000000);
    tmpobjid = CreateDynamicObject(19602, 1933.123779, 1469.249511, 1096.092651, 0.000000, 90.000000, 360.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 19623, "camera1", "cscamera02", 0x00000000);
    tmpobjid = CreateDynamicObject(19602, 1941.434570, 1469.249511, 1096.092651, 0.000000, 90.000000, 360.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 19623, "camera1", "cscamera02", 0x00000000);
    tmpobjid = CreateDynamicObject(19602, 1941.144287, 1469.249511, 1096.092651, 0.000000, 90.000000, 540.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 19623, "camera1", "cscamera02", 0x00000000);
    tmpobjid = CreateDynamicObject(19602, 1932.831054, 1469.249511, 1096.092651, 0.000000, 90.000000, 540.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 19623, "camera1", "cscamera02", 0x00000000);
    tmpobjid = CreateDynamicObject(19602, 1979.762695, 1469.249511, 1096.092651, 0.000000, 90.000000, 540.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 19623, "camera1", "cscamera02", 0x00000000);
    tmpobjid = CreateDynamicObject(19602, 1916.318969, 1453.467407, 1096.092651, 0.000000, 90.000000, 810.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 19623, "camera1", "cscamera02", 0x00000000);
    tmpobjid = CreateDynamicObject(19602, 1916.318969, 1484.918090, 1096.092651, 0.000000, 90.000000, 990.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 19623, "camera1", "cscamera02", 0x00000000);
    tmpobjid = CreateDynamicObject(19566, 1922.748901, 1453.321899, 1093.403076, 0.000007, 45.000000, -90.000022, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 16322, "a51_stores", "metpat64chev_128", 0x00000000);
    tmpobjid = CreateDynamicObject(19387, 1916.349365, 1453.321899, 1095.171875, 0.000022, 0.000007, 89.999870, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 16640, "a51", "a51_floorpanel1", 0x00000000);
    tmpobjid = CreateDynamicObject(19566, 1891.473754, 1470.122314, 1093.403076, -0.000007, 45.000000, -89.999977, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 16322, "a51_stores", "metpat64chev_128", 0x00000000);
    tmpobjid = CreateDynamicObject(19447, 1909.928588, 1453.321899, 1095.171875, 0.000022, 0.000007, 89.999870, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 16640, "a51", "a51_floorpanel1", 0x00000000);
    tmpobjid = CreateDynamicObject(19447, 1916.226806, 1453.332641, 1098.672973, 0.000022, 0.000007, 89.999870, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 2917, "a51_crane", "girder2_grey_64HV", 0x00000000);
    tmpobjid = CreateDynamicObject(19566, 1891.473754, 1468.440795, 1093.403076, 0.000000, 45.000000, 89.999969, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 16322, "a51_stores", "metpat64chev_128", 0x00000000);
    tmpobjid = CreateDynamicObject(19566, 1891.473754, 1468.440673, 1095.905517, 0.000000, 224.999969, -89.999954, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 16322, "a51_stores", "metpat64chev_128", 0x00000000);
    tmpobjid = CreateDynamicObject(19566, 1891.473754, 1470.122192, 1095.905517, 0.000030, -134.999969, 89.999984, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 16322, "a51_stores", "metpat64chev_128", 0x00000000);
    tmpobjid = CreateDynamicObject(19566, 1932.987915, 1470.150634, 1093.364013, -0.000022, 45.000000, -89.999931, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 16322, "a51_stores", "metpat64chev_128", 0x00000000);
    tmpobjid = CreateDynamicObject(19566, 1932.987915, 1468.469116, 1093.392333, 0.000015, 45.000000, 89.999923, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 16322, "a51_stores", "metpat64chev_128", 0x00000000);
    tmpobjid = CreateDynamicObject(19566, 1932.987915, 1468.440673, 1095.965576, -0.000015, 224.999969, -89.999908, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 16322, "a51_stores", "metpat64chev_128", 0x00000000);
    tmpobjid = CreateDynamicObject(19566, 1932.987915, 1470.122192, 1095.965576, 0.000045, -134.999969, 89.999938, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 16322, "a51_stores", "metpat64chev_128", 0x00000000);
    tmpobjid = CreateDynamicObject(19566, 1941.282714, 1470.150634, 1093.364013, -0.000030, 45.000000, -89.999908, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 16322, "a51_stores", "metpat64chev_128", 0x00000000);
    tmpobjid = CreateDynamicObject(19566, 1941.282714, 1468.469116, 1093.392333, 0.000022, 45.000000, 89.999900, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 16322, "a51_stores", "metpat64chev_128", 0x00000000);
    tmpobjid = CreateDynamicObject(19566, 1941.282714, 1468.440673, 1095.965576, -0.000022, 224.999969, -89.999885, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 16322, "a51_stores", "metpat64chev_128", 0x00000000);
    tmpobjid = CreateDynamicObject(19566, 1941.282714, 1470.122192, 1095.965576, 0.000053, -134.999969, 89.999916, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 16322, "a51_stores", "metpat64chev_128", 0x00000000);
    tmpobjid = CreateDynamicObject(19566, 1979.904418, 1470.150634, 1093.364013, -0.000038, 45.000000, -89.999885, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 16322, "a51_stores", "metpat64chev_128", 0x00000000);
    tmpobjid = CreateDynamicObject(19566, 1979.904418, 1468.469116, 1093.392333, 0.000030, 45.000000, 89.999877, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 16322, "a51_stores", "metpat64chev_128", 0x00000000);
    tmpobjid = CreateDynamicObject(19566, 1979.904418, 1468.440673, 1095.965576, -0.000030, 224.999969, -89.999862, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 16322, "a51_stores", "metpat64chev_128", 0x00000000);
    tmpobjid = CreateDynamicObject(19566, 1979.904418, 1470.122192, 1095.965576, 0.000061, -134.999969, 89.999893, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 16322, "a51_stores", "metpat64chev_128", 0x00000000);
    tmpobjid = CreateDynamicObject(19566, 1915.479370, 1453.314697, 1093.364013, -0.000053, 45.000015, 0.000129, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 16322, "a51_stores", "metpat64chev_128", 0x00000000);
    tmpobjid = CreateDynamicObject(19566, 1917.160888, 1453.314697, 1093.392333, 0.000045, 44.999984, 179.999710, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 16322, "a51_stores", "metpat64chev_128", 0x00000000);
    tmpobjid = CreateDynamicObject(19566, 1917.189331, 1453.314697, 1095.965576, -0.000045, 224.999969, 0.000152, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 16322, "a51_stores", "metpat64chev_128", 0x00000000);
    tmpobjid = CreateDynamicObject(19566, 1915.507812, 1453.314697, 1095.965576, 0.000076, -134.999969, 179.999725, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 16322, "a51_stores", "metpat64chev_128", 0x00000000);
    tmpobjid = CreateDynamicObject(19566, 1915.479370, 1485.074829, 1093.364013, -0.000053, 45.000038, 0.000129, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 16322, "a51_stores", "metpat64chev_128", 0x00000000);
    tmpobjid = CreateDynamicObject(19566, 1917.160888, 1485.074829, 1093.392333, 0.000045, 44.999961, 179.999572, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 16322, "a51_stores", "metpat64chev_128", 0x00000000);
    tmpobjid = CreateDynamicObject(19566, 1917.189331, 1485.074829, 1095.965576, -0.000045, 224.999969, 0.000152, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 16322, "a51_stores", "metpat64chev_128", 0x00000000);
    tmpobjid = CreateDynamicObject(19566, 1915.507812, 1485.074829, 1095.965576, 0.000076, -134.999969, 179.999588, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 16322, "a51_stores", "metpat64chev_128", 0x00000000);

    /////////////////////////////////////////////////////////Mein Teil/////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
tmpobjid = CreateDynamicObject(18808, 1916.322509, 1509.238159, 1093.281250, 90.000000, 0.000000, 0.000000, -1, -1, -1, 100.00, 100.00);
SetDynamicObjectMaterial(tmpobjid, 1, 2917, "a51_crane", "girder2_grey_64HV", 0x00000000);
SetDynamicObjectMaterial(tmpobjid, 2, 13077, "cunte_bar1", "alleydoor4", 0x00000000);
SetDynamicObjectMaterial(tmpobjid, 3, 1220, "boxes", "crate128", 0x00000000);
tmpobjid = CreateDynamicObject(18817, 1916.325073, 1541.636596, 1093.290527, 270.000000, 0.000000, 0.000000, -1, -1, -1, 100.00, 100.00);
SetDynamicObjectMaterial(tmpobjid, 0, 16640, "a51", "a51_floorpanel1", 0x00000000);
SetDynamicObjectMaterial(tmpobjid, 1, 2917, "a51_crane", "girder2_grey_64HV", 0x00000000);
tmpobjid = CreateDynamicObject(18810, 1959.762329, 1419.578613, 1093.281250, 90.000000, 90.000000, 0.000000, -1, -1, -1, 100.00, 100.00);
SetDynamicObjectMaterial(tmpobjid, 0, 13077, "cunte_bar1", "alleydoor4", 0x00000000);
SetDynamicObjectMaterial(tmpobjid, 1, 2917, "a51_crane", "girder2_grey_64HV", 0x00000000);
SetDynamicObjectMaterial(tmpobjid, 2, 13077, "cunte_bar1", "alleydoor4", 0x00000000);
SetDynamicObjectMaterial(tmpobjid, 3, 1220, "boxes", "crate128", 0x00000000);
tmpobjid = CreateDynamicObject(18808, 1916.312500, 1509.238159, 1097.163574, 90.000000, 0.000000, 0.000000, -1, -1, -1, 100.00, 100.00);
SetDynamicObjectMaterial(tmpobjid, 0, 13077, "cunte_bar1", "alleydoor4", 0x00000000);
SetDynamicObjectMaterial(tmpobjid, 1, 16640, "a51", "a51_floorpanel1", 0x00000000);
SetDynamicObjectMaterial(tmpobjid, 2, 13077, "cunte_bar1", "alleydoor4", 0x00000000);
SetDynamicObjectMaterial(tmpobjid, 3, 1220, "boxes", "crate128", 0x00000000);
tmpobjid = CreateDynamicObject(18817, 1916.315063, 1541.636596, 1097.149536, 270.000000, 0.000000, 0.000000, -1, -1, -1, 100.00, 100.00);
SetDynamicObjectMaterial(tmpobjid, 1, 16640, "a51", "a51_floorpanel1", 0x00000000);
tmpobjid = CreateDynamicObject(18810, 1959.762329, 1419.600830, 1097.153198, 90.000000, 90.000000, 0.000000, -1, -1, -1, 100.00, 100.00);
SetDynamicObjectMaterial(tmpobjid, 0, 16640, "a51", "ws_metalpanel1", 0x00000000);
SetDynamicObjectMaterial(tmpobjid, 1, 16640, "a51", "a51_floorpanel1", 0x00000000);
SetDynamicObjectMaterial(tmpobjid, 2, 13077, "cunte_bar1", "alleydoor4", 0x00000000);
SetDynamicObjectMaterial(tmpobjid, 3, 1220, "boxes", "crate128", 0x00000000);
tmpobjid = CreateDynamicObject(19376, 1916.368896, 1490.293212, 1093.355834, -179.999771, -90.000007, -90.000045, -1, -1, -1, 100.00, 100.00);
SetDynamicObjectMaterial(tmpobjid, 0, 14789, "ab_sfgymmain", "gun_ceiling2_128", 0x00000000);
SetDynamicObjectMaterial(tmpobjid, 1, 14789, "ab_sfgymmain", "gun_ceiling2_128", 0x00000000);
tmpobjid = CreateDynamicObject(19376, 1916.368896, 1500.767578, 1093.345825, -179.999771, -90.000007, -90.000045, -1, -1, -1, 100.00, 100.00);
SetDynamicObjectMaterial(tmpobjid, 0, 14789, "ab_sfgymmain", "gun_ceiling2_128", 0x00000000);
SetDynamicObjectMaterial(tmpobjid, 1, 14789, "ab_sfgymmain", "gun_ceiling2_128", 0x00000000);
tmpobjid = CreateDynamicObject(19376, 1916.368896, 1511.247924, 1093.345825, -179.999771, -90.000007, -90.000045, -1, -1, -1, 100.00, 100.00);
SetDynamicObjectMaterial(tmpobjid, 0, 14789, "ab_sfgymmain", "gun_ceiling2_128", 0x00000000);
SetDynamicObjectMaterial(tmpobjid, 1, 14789, "ab_sfgymmain", "gun_ceiling2_128", 0x00000000);
tmpobjid = CreateDynamicObject(19376, 1916.368896, 1521.747436, 1093.345825, -179.999771, -90.000007, -90.000045, -1, -1, -1, 100.00, 100.00);
SetDynamicObjectMaterial(tmpobjid, 0, 14789, "ab_sfgymmain", "gun_ceiling2_128", 0x00000000);
SetDynamicObjectMaterial(tmpobjid, 1, 14789, "ab_sfgymmain", "gun_ceiling2_128", 0x00000000);
tmpobjid = CreateDynamicObject(19376, 1916.368896, 1532.226318, 1093.345825, -179.999771, -90.000007, -90.000045, -1, -1, -1, 100.00, 100.00);
SetDynamicObjectMaterial(tmpobjid, 0, 14789, "ab_sfgymmain", "gun_ceiling2_128", 0x00000000);
SetDynamicObjectMaterial(tmpobjid, 1, 14789, "ab_sfgymmain", "gun_ceiling2_128", 0x00000000);
tmpobjid = CreateDynamicObject(19447, 1891.387207, 1549.509765, 1092.939208, 0.000000, 0.000000, 0.000000, -1, -1, -1, 100.00, 100.00);
SetDynamicObjectMaterial(tmpobjid, 0, 16640, "a51", "a51_floorpanel1", 0x00000000);
tmpobjid = CreateDynamicObject(19447, 1891.387207, 1549.509765, 1098.009277, 0.000000, 0.000000, 0.000000, -1, -1, -1, 100.00, 100.00);
SetDynamicObjectMaterial(tmpobjid, 0, 2917, "a51_crane", "girder2_grey_64HV", 0x00000000);
SetDynamicObjectMaterial(tmpobjid, 1, 2917, "a51_crane", "girder2_grey_64HV", 0x00000000);
tmpobjid = CreateDynamicObject(3502, 1958.175048, 1419.575683, 1089.810668, -90.000053, 0.000000, 0.000000, -1, -1, -1, 100.00, 100.00);
SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
SetDynamicObjectMaterial(tmpobjid, 1, 10765, "airportgnd_sfse", "white", 0x00000000);
tmpobjid = CreateDynamicObject(19362, 1891.378173, 1552.388183, 1095.429809, 0.000000, 0.000000, 0.000000, -1, -1, -1, 100.00, 100.00);
SetDynamicObjectMaterial(tmpobjid, 0, 16640, "a51", "a51_floorpanel1", 0x00000000);
tmpobjid = CreateDynamicObject(19447, 1891.335815, 1546.318725, 1095.439575, 0.000000, 0.000000, 0.000000, -1, -1, -1, 100.00, 100.00);
SetDynamicObjectMaterial(tmpobjid, 0, 16640, "a51", "a51_floorpanel1", 0x00000000);
tmpobjid = CreateDynamicObject(18817, 2004.304931, 1541.636596, 1093.290527, 270.000000, 0.000000, 0.000000, -1, -1, -1, 100.00, 100.00);
SetDynamicObjectMaterial(tmpobjid, 0, 16640, "a51", "a51_floorpanel1", 0x00000000);
SetDynamicObjectMaterial(tmpobjid, 1, 2917, "a51_crane", "girder2_grey_64HV", 0x00000000);
tmpobjid = CreateDynamicObject(18817, 2004.315063, 1541.636596, 1097.149536, 270.000000, 0.000000, 0.000000, -1, -1, -1, 100.00, 100.00);
SetDynamicObjectMaterial(tmpobjid, 1, 16640, "a51", "a51_floorpanel1", 0x00000000);
tmpobjid = CreateDynamicObject(18808, 2004.301635, 1509.238159, 1093.281250, 90.000000, 0.000000, 0.000000, -1, -1, -1, 100.00, 100.00);
SetDynamicObjectMaterial(tmpobjid, 1, 2917, "a51_crane", "girder2_grey_64HV", 0x00000000);
SetDynamicObjectMaterial(tmpobjid, 2, 13077, "cunte_bar1", "alleydoor4", 0x00000000);
SetDynamicObjectMaterial(tmpobjid, 3, 1220, "boxes", "crate128", 0x00000000);
tmpobjid = CreateDynamicObject(18808, 2004.292968, 1509.238159, 1097.163574, 90.000000, 0.000000, 0.000000, -1, -1, -1, 100.00, 100.00);
SetDynamicObjectMaterial(tmpobjid, 0, 13077, "cunte_bar1", "alleydoor4", 0x00000000);
SetDynamicObjectMaterial(tmpobjid, 1, 16640, "a51", "a51_floorpanel1", 0x00000000);
SetDynamicObjectMaterial(tmpobjid, 2, 13077, "cunte_bar1", "alleydoor4", 0x00000000);
SetDynamicObjectMaterial(tmpobjid, 3, 1220, "boxes", "crate128", 0x00000000);
tmpobjid = CreateDynamicObject(18819, 2004.292968, 1469.269165, 1093.262939, 90.000000, 0.000000, 0.000000, -1, -1, -1, 100.00, 100.00);
SetDynamicObjectMaterial(tmpobjid, 0, 13077, "cunte_bar1", "alleydoor4", 0x00000000);
SetDynamicObjectMaterial(tmpobjid, 1, 2917, "a51_crane", "girder2_grey_64HV", 0x00000000);
SetDynamicObjectMaterial(tmpobjid, 2, 13077, "cunte_bar1", "alleydoor4", 0x00000000);
SetDynamicObjectMaterial(tmpobjid, 3, 1220, "boxes", "crate128", 0x00000000);
tmpobjid = CreateDynamicObject(18819, 2004.292968, 1469.269165, 1097.153442, 90.000000, 0.000000, 0.000000, -1, -1, -1, 100.00, 100.00);
SetDynamicObjectMaterial(tmpobjid, 0, 13077, "cunte_bar1", "alleydoor4", 0x00000000);
SetDynamicObjectMaterial(tmpobjid, 1, 16640, "a51", "a51_floorpanel1", 0x00000000);
SetDynamicObjectMaterial(tmpobjid, 2, 13077, "cunte_bar1", "alleydoor4", 0x00000000);
SetDynamicObjectMaterial(tmpobjid, 3, 1220, "boxes", "crate128", 0x00000000);
tmpobjid = CreateDynamicObject(19392, 1901.225830, 1549.396118, 1095.178833, 0.000037, 360.000000, 179.999786, -1, -1, -1, 100.00, 100.00);
SetDynamicObjectMaterial(tmpobjid, 0, 16640, "a51", "a51_floorpanel1", 0x00000000);
SetDynamicObjectMaterial(tmpobjid, 1, 13077, "cunte_bar1", "alleydoor4", 0x00000000);
tmpobjid = CreateDynamicObject(19368, 1901.235839, 1552.597167, 1095.178833, 0.000037, 360.000000, 179.999786, -1, -1, -1, 100.00, 100.00);
SetDynamicObjectMaterial(tmpobjid, 0, 16640, "a51", "a51_floorpanel1", 0x00000000);
SetDynamicObjectMaterial(tmpobjid, 1, 13077, "cunte_bar1", "alleydoor4", 0x00000000);
tmpobjid = CreateDynamicObject(19368, 1901.235839, 1546.186889, 1095.178833, 0.000037, 360.000000, 179.999786, -1, -1, -1, 100.00, 100.00);
SetDynamicObjectMaterial(tmpobjid, 0, 16640, "a51", "a51_floorpanel1", 0x00000000);
SetDynamicObjectMaterial(tmpobjid, 1, 13077, "cunte_bar1", "alleydoor4", 0x00000000);
tmpobjid = CreateDynamicObject(19456, 1901.251342, 1549.409301, 1098.671630, 0.000045, 360.000000, 179.999786, -1, -1, -1, 100.00, 100.00);
SetDynamicObjectMaterial(tmpobjid, 0, 2917, "a51_crane", "girder2_grey_64HV", 0x00000000);
tmpobjid = CreateDynamicObject(19566, 1901.188110, 1550.152343, 1093.348510, 0.000007, -42.999973, 89.999946, -1, -1, -1, 100.00, 100.00);
SetDynamicObjectMaterial(tmpobjid, 0, 16322, "a51_stores", "metpat64chev_128", 0x00000000);
tmpobjid = CreateDynamicObject(19566, 1901.188110, 1548.801513, 1093.498291, -0.000007, 136.999969, -89.999809, -1, -1, -1, 100.00, 100.00);
SetDynamicObjectMaterial(tmpobjid, 0, 16322, "a51_stores", "metpat64chev_128", 0x00000000);
tmpobjid = CreateDynamicObject(19566, 1901.188110, 1550.186035, 1095.996459, -0.000007, 136.999969, -89.999809, -1, -1, -1, 100.00, 100.00);
SetDynamicObjectMaterial(tmpobjid, 0, 16322, "a51_stores", "metpat64chev_128", 0x00000000);
tmpobjid = CreateDynamicObject(19566, 1901.188110, 1548.751953, 1095.775756, 0.000007, -42.999973, 89.999946, -1, -1, -1, 100.00, 100.00);
SetDynamicObjectMaterial(tmpobjid, 0, 16322, "a51_stores", "metpat64chev_128", 0x00000000);
tmpobjid = CreateDynamicObject(1381, 1958.196289, 1419.598022, 1093.312377, -0.000007, 179.999954, -93.799957, -1, -1, -1, 100.00, 100.00);
SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
SetDynamicObjectMaterial(tmpobjid, 1, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
tmpobjid = CreateDynamicObject(1956, 1958.163330, 1419.534423, 1094.387573, 0.000000, 0.000007, 0.000000, -1, -1, -1, 100.00, 100.00);
SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0xFFF00000);
SetDynamicObjectMaterial(tmpobjid, 1, 10765, "airportgnd_sfse", "white", 0xFFFF0000);
SetDynamicObjectMaterial(tmpobjid, 2, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
SetDynamicObjectMaterial(tmpobjid, 3, -1, "none", "none", 0xFFFFFFFF);
tmpobjid = CreateDynamicObject(19392, 1936.705200, 1549.327148, 1095.178833, 0.000029, 360.000000, 0.600044, -1, -1, -1, 100.00, 100.00);
SetDynamicObjectMaterial(tmpobjid, 0, 16640, "a51", "a51_floorpanel1", 0x00000000);
SetDynamicObjectMaterial(tmpobjid, 1, 13077, "cunte_bar1", "alleydoor4", 0x00000000);
tmpobjid = CreateDynamicObject(19368, 1936.728759, 1546.126098, 1095.178833, 0.000029, 360.000000, 0.600044, -1, -1, -1, 100.00, 100.00);
SetDynamicObjectMaterial(tmpobjid, 0, 16640, "a51", "a51_floorpanel1", 0x00000000);
SetDynamicObjectMaterial(tmpobjid, 1, 13077, "cunte_bar1", "alleydoor4", 0x00000000);
tmpobjid = CreateDynamicObject(19368, 1936.661621, 1552.536132, 1095.178833, 0.000029, 360.000000, 0.600044, -1, -1, -1, 100.00, 100.00);
SetDynamicObjectMaterial(tmpobjid, 0, 16640, "a51", "a51_floorpanel1", 0x00000000);
SetDynamicObjectMaterial(tmpobjid, 1, 13077, "cunte_bar1", "alleydoor4", 0x00000000);
tmpobjid = CreateDynamicObject(19456, 1936.679809, 1549.313598, 1098.671630, 0.000037, 360.000000, 0.600044, -1, -1, -1, 100.00, 100.00);
SetDynamicObjectMaterial(tmpobjid, 0, 2917, "a51_crane", "girder2_grey_64HV", 0x00000000);
tmpobjid = CreateDynamicObject(19566, 1936.750854, 1548.571289, 1093.348510, 0.000000, -42.999980, -89.399841, -1, -1, -1, 100.00, 100.00);
SetDynamicObjectMaterial(tmpobjid, 0, 16322, "a51_stores", "metpat64chev_128", 0x00000000);
tmpobjid = CreateDynamicObject(19566, 1936.736694, 1549.922119, 1093.498291, -0.000000, 136.999969, 90.600219, -1, -1, -1, 100.00, 100.00);
SetDynamicObjectMaterial(tmpobjid, 0, 16322, "a51_stores", "metpat64chev_128", 0x00000000);
tmpobjid = CreateDynamicObject(19566, 1936.751098, 1548.544433, 1095.989135, -0.000000, 136.999969, 90.600219, -1, -1, -1, 100.00, 100.00);
SetDynamicObjectMaterial(tmpobjid, 0, 16322, "a51_stores", "metpat64chev_128", 0x00000000);
tmpobjid = CreateDynamicObject(19566, 1936.736206, 1549.971679, 1095.775756, 0.000000, -42.999980, -89.399841, -1, -1, -1, 100.00, 100.00);
SetDynamicObjectMaterial(tmpobjid, 0, 16322, "a51_stores", "metpat64chev_128", 0x00000000);
tmpobjid = CreateDynamicObject(19392, 1978.348266, 1549.334960, 1095.178833, -0.000030, 360.000000, -179.399856, -1, -1, -1, 100.00, 100.00);
SetDynamicObjectMaterial(tmpobjid, 0, 16640, "a51", "a51_floorpanel1", 0x00000000);
SetDynamicObjectMaterial(tmpobjid, 1, 13077, "cunte_bar1", "alleydoor4", 0x00000000);
tmpobjid = CreateDynamicObject(19368, 1978.324707, 1552.536010, 1095.178833, -0.000030, 360.000000, -179.399856, -1, -1, -1, 100.00, 100.00);
SetDynamicObjectMaterial(tmpobjid, 0, 16640, "a51", "a51_floorpanel1", 0x00000000);
SetDynamicObjectMaterial(tmpobjid, 1, 13077, "cunte_bar1", "alleydoor4", 0x00000000);
tmpobjid = CreateDynamicObject(19368, 1978.391845, 1546.125976, 1095.178833, -0.000030, 360.000000, -179.399856, -1, -1, -1, 100.00, 100.00);
SetDynamicObjectMaterial(tmpobjid, 0, 16640, "a51", "a51_floorpanel1", 0x00000000);
SetDynamicObjectMaterial(tmpobjid, 1, 13077, "cunte_bar1", "alleydoor4", 0x00000000);
tmpobjid = CreateDynamicObject(19456, 1978.373657, 1549.348510, 1098.671630, -0.000030, 360.000000, -179.399856, -1, -1, -1, 100.00, 100.00);
SetDynamicObjectMaterial(tmpobjid, 0, 2917, "a51_crane", "girder2_grey_64HV", 0x00000000);
tmpobjid = CreateDynamicObject(19566, 1978.302612, 1550.090820, 1093.348510, -0.000022, 676.999877, 90.600181, -1, -1, -1, 100.00, 100.00);
SetDynamicObjectMaterial(tmpobjid, 0, 16322, "a51_stores", "metpat64chev_128", 0x00000000);
tmpobjid = CreateDynamicObject(19566, 1978.316772, 1548.739990, 1093.498291, 0.000022, -582.999877, -89.399848, -1, -1, -1, 100.00, 100.00);
SetDynamicObjectMaterial(tmpobjid, 0, 16322, "a51_stores", "metpat64chev_128", 0x00000000);
tmpobjid = CreateDynamicObject(19566, 1978.302368, 1550.117675, 1095.989135, 0.000022, -582.999877, -89.399848, -1, -1, -1, 100.00, 100.00);
SetDynamicObjectMaterial(tmpobjid, 0, 16322, "a51_stores", "metpat64chev_128", 0x00000000);
tmpobjid = CreateDynamicObject(19566, 1978.317260, 1548.690429, 1095.775756, -0.000022, 676.999877, 90.600181, -1, -1, -1, 100.00, 100.00);
SetDynamicObjectMaterial(tmpobjid, 0, 16322, "a51_stores", "metpat64chev_128", 0x00000000);
tmpobjid = CreateDynamicObject(19392, 1988.889282, 1469.383666, 1095.178833, -0.000030, 360.000000, -179.399765, -1, -1, -1, 100.00, 100.00);
SetDynamicObjectMaterial(tmpobjid, 0, 16640, "a51", "a51_floorpanel1", 0x00000000);
SetDynamicObjectMaterial(tmpobjid, 1, 13077, "cunte_bar1", "alleydoor4", 0x00000000);
tmpobjid = CreateDynamicObject(19368, 1988.865722, 1472.584716, 1095.178833, -0.000030, 360.000000, -179.399765, -1, -1, -1, 100.00, 100.00);
SetDynamicObjectMaterial(tmpobjid, 0, 16640, "a51", "a51_floorpanel1", 0x00000000);
SetDynamicObjectMaterial(tmpobjid, 1, 13077, "cunte_bar1", "alleydoor4", 0x00000000);
tmpobjid = CreateDynamicObject(19368, 1988.932861, 1466.174682, 1095.178833, -0.000030, 360.000000, -179.399765, -1, -1, -1, 100.00, 100.00);
SetDynamicObjectMaterial(tmpobjid, 0, 16640, "a51", "a51_floorpanel1", 0x00000000);
SetDynamicObjectMaterial(tmpobjid, 1, 13077, "cunte_bar1", "alleydoor4", 0x00000000);
tmpobjid = CreateDynamicObject(19456, 1988.914672, 1469.397216, 1098.671630, -0.000030, 360.000000, -179.399765, -1, -1, -1, 100.00, 100.00);
SetDynamicObjectMaterial(tmpobjid, 0, 2917, "a51_crane", "girder2_grey_64HV", 0x00000000);
tmpobjid = CreateDynamicObject(19566, 1988.843627, 1470.139526, 1093.348510, -0.000007, 676.999877, 90.600135, -1, -1, -1, 100.00, 100.00);
SetDynamicObjectMaterial(tmpobjid, 0, 16322, "a51_stores", "metpat64chev_128", 0x00000000);
tmpobjid = CreateDynamicObject(19566, 1988.857788, 1468.788696, 1093.498291, 0.000007, -582.999877, -89.399803, -1, -1, -1, 100.00, 100.00);
SetDynamicObjectMaterial(tmpobjid, 0, 16322, "a51_stores", "metpat64chev_128", 0x00000000);
tmpobjid = CreateDynamicObject(19566, 1988.843383, 1470.166381, 1095.989135, 0.000007, -582.999877, -89.399803, -1, -1, -1, 100.00, 100.00);
SetDynamicObjectMaterial(tmpobjid, 0, 16322, "a51_stores", "metpat64chev_128", 0x00000000);
tmpobjid = CreateDynamicObject(19566, 1988.858276, 1468.739135, 1095.775756, -0.000007, 676.999877, 90.600135, -1, -1, -1, 100.00, 100.00);
SetDynamicObjectMaterial(tmpobjid, 0, 16322, "a51_stores", "metpat64chev_128", 0x00000000);
tmpobjid = CreateDynamicObject(18817, 1916.325073, 1427.409545, 1093.290527, 270.000000, 0.000000, 180.000000, -1, -1, -1, 100.00, 100.00);
SetDynamicObjectMaterial(tmpobjid, 0, 16640, "a51", "a51_floorpanel1", 0x00000000);
SetDynamicObjectMaterial(tmpobjid, 1, 2917, "a51_crane", "girder2_grey_64HV", 0x00000000);
tmpobjid = CreateDynamicObject(18817, 1916.315063, 1427.417358, 1097.149536, 270.000000, 0.000000, 180.000000, -1, -1, -1, 100.00, 100.00);
SetDynamicObjectMaterial(tmpobjid, 1, 16640, "a51", "a51_floorpanel1", 0x00000000);
tmpobjid = CreateDynamicObject(18817, 1956.074340, 1541.647460, 1097.149536, 270.000000, 0.000000, 360.000000, -1, -1, -1, 100.00, 100.00);
SetDynamicObjectMaterial(tmpobjid, 1, 16640, "a51", "a51_floorpanel1", 0x00000000);
tmpobjid = CreateDynamicObject(18817, 1956.075073, 1541.655273, 1093.290527, 270.000000, 0.000000, 360.000000, -1, -1, -1, 100.00, 100.00);
SetDynamicObjectMaterial(tmpobjid, 0, 16640, "a51", "a51_floorpanel1", 0x00000000);
SetDynamicObjectMaterial(tmpobjid, 1, 2917, "a51_crane", "girder2_grey_64HV", 0x00000000);
tmpobjid = CreateDynamicObject(18817, 2004.294799, 1427.417358, 1097.149536, 270.000000, 0.000000, 180.000000, -1, -1, -1, 100.00, 100.00);
SetDynamicObjectMaterial(tmpobjid, 1, 16640, "a51", "a51_floorpanel1", 0x00000000);
tmpobjid = CreateDynamicObject(18817, 2004.285278, 1427.409545, 1093.290527, 270.000000, 0.000000, 180.000000, -1, -1, -1, 100.00, 100.00);
SetDynamicObjectMaterial(tmpobjid, 0, 16640, "a51", "a51_floorpanel1", 0x00000000);
SetDynamicObjectMaterial(tmpobjid, 1, 2917, "a51_crane", "girder2_grey_64HV", 0x00000000);
tmpobjid = CreateDynamicObject(19392, 1939.587402, 1419.715209, 1095.178833, 0.000029, 360.000000, 0.600044, -1, -1, -1, 100.00, 100.00);
SetDynamicObjectMaterial(tmpobjid, 0, 16640, "a51", "a51_floorpanel1", 0x00000000);
SetDynamicObjectMaterial(tmpobjid, 1, 13077, "cunte_bar1", "alleydoor4", 0x00000000);
tmpobjid = CreateDynamicObject(19368, 1939.610961, 1416.514160, 1095.178833, 0.000029, 360.000000, 0.600044, -1, -1, -1, 100.00, 100.00);
SetDynamicObjectMaterial(tmpobjid, 0, 16640, "a51", "a51_floorpanel1", 0x00000000);
SetDynamicObjectMaterial(tmpobjid, 1, 13077, "cunte_bar1", "alleydoor4", 0x00000000);
tmpobjid = CreateDynamicObject(19368, 1939.543823, 1422.924194, 1095.178833, 0.000029, 360.000000, 0.600044, -1, -1, -1, 100.00, 100.00);
SetDynamicObjectMaterial(tmpobjid, 0, 16640, "a51", "a51_floorpanel1", 0x00000000);
SetDynamicObjectMaterial(tmpobjid, 1, 13077, "cunte_bar1", "alleydoor4", 0x00000000);
tmpobjid = CreateDynamicObject(19456, 1939.562011, 1419.701660, 1098.671630, 0.000037, 360.000000, 0.600044, -1, -1, -1, 100.00, 100.00);
SetDynamicObjectMaterial(tmpobjid, 0, 2917, "a51_crane", "girder2_grey_64HV", 0x00000000);
tmpobjid = CreateDynamicObject(19566, 1939.633056, 1418.959350, 1093.348510, -0.000007, -42.999980, -89.399818, -1, -1, -1, 100.00, 100.00);
SetDynamicObjectMaterial(tmpobjid, 0, 16322, "a51_stores", "metpat64chev_128", 0x00000000);
tmpobjid = CreateDynamicObject(19566, 1939.618896, 1420.310180, 1093.498291, 0.000007, 136.999969, 90.600196, -1, -1, -1, 100.00, 100.00);
SetDynamicObjectMaterial(tmpobjid, 0, 16322, "a51_stores", "metpat64chev_128", 0x00000000);
tmpobjid = CreateDynamicObject(19566, 1939.633300, 1418.932495, 1095.989135, 0.000007, 136.999969, 90.600196, -1, -1, -1, 100.00, 100.00);
SetDynamicObjectMaterial(tmpobjid, 0, 16322, "a51_stores", "metpat64chev_128", 0x00000000);
tmpobjid = CreateDynamicObject(19566, 1939.618408, 1420.359741, 1095.775756, -0.000007, -42.999980, -89.399818, -1, -1, -1, 100.00, 100.00);
SetDynamicObjectMaterial(tmpobjid, 0, 16322, "a51_stores", "metpat64chev_128", 0x00000000);
tmpobjid = CreateDynamicObject(19858, 1939.611083, 1420.494262, 1096.670776, -0.000007, 0.000022, -89.399818, -1, -1, -1, 100.00, 100.00);
SetDynamicObjectMaterial(tmpobjid, 0, 2669, "cj_chris", "CJ_Grate", 0x00000000);
SetDynamicObjectMaterial(tmpobjid, 1, 2669, "cj_chris", "CJ_Grate", 0x00000000);
tmpobjid = CreateDynamicObject(19392, 1981.230468, 1419.723022, 1095.178833, -0.000029, 360.000000, -179.399810, -1, -1, -1, 100.00, 100.00);
SetDynamicObjectMaterial(tmpobjid, 0, 16640, "a51", "a51_floorpanel1", 0x00000000);
SetDynamicObjectMaterial(tmpobjid, 1, 13077, "cunte_bar1", "alleydoor4", 0x00000000);
tmpobjid = CreateDynamicObject(19368, 1981.206909, 1422.924072, 1095.178833, -0.000029, 360.000000, -179.399810, -1, -1, -1, 100.00, 100.00);
SetDynamicObjectMaterial(tmpobjid, 0, 16640, "a51", "a51_floorpanel1", 0x00000000);
SetDynamicObjectMaterial(tmpobjid, 1, 13077, "cunte_bar1", "alleydoor4", 0x00000000);
tmpobjid = CreateDynamicObject(19368, 1981.274047, 1416.514038, 1095.178833, -0.000029, 360.000000, -179.399810, -1, -1, -1, 100.00, 100.00);
SetDynamicObjectMaterial(tmpobjid, 0, 16640, "a51", "a51_floorpanel1", 0x00000000);
SetDynamicObjectMaterial(tmpobjid, 1, 13077, "cunte_bar1", "alleydoor4", 0x00000000);
tmpobjid = CreateDynamicObject(19456, 1981.255859, 1419.736572, 1098.671630, -0.000029, 360.000000, -179.399810, -1, -1, -1, 100.00, 100.00);
SetDynamicObjectMaterial(tmpobjid, 0, 2917, "a51_crane", "girder2_grey_64HV", 0x00000000);
tmpobjid = CreateDynamicObject(19566, 1981.184814, 1420.478881, 1093.348510, -0.000014, 676.999877, 90.600158, -1, -1, -1, 100.00, 100.00);
SetDynamicObjectMaterial(tmpobjid, 0, 16322, "a51_stores", "metpat64chev_128", 0x00000000);
tmpobjid = CreateDynamicObject(19566, 1981.198974, 1419.128051, 1093.498291, 0.000014, -582.999877, -89.399826, -1, -1, -1, 100.00, 100.00);
SetDynamicObjectMaterial(tmpobjid, 0, 16322, "a51_stores", "metpat64chev_128", 0x00000000);
tmpobjid = CreateDynamicObject(19566, 1981.184570, 1420.505737, 1095.989135, 0.000014, -582.999877, -89.399826, -1, -1, -1, 100.00, 100.00);
SetDynamicObjectMaterial(tmpobjid, 0, 16322, "a51_stores", "metpat64chev_128", 0x00000000);
tmpobjid = CreateDynamicObject(19566, 1981.199462, 1419.078491, 1095.775756, -0.000014, 676.999877, 90.600158, -1, -1, -1, 100.00, 100.00);
SetDynamicObjectMaterial(tmpobjid, 0, 16322, "a51_stores", "metpat64chev_128", 0x00000000);
tmpobjid = CreateDynamicObject(19858, 1981.206787, 1418.943969, 1096.670776, -0.000014, 719.999877, 90.600158, -1, -1, -1, 100.00, 100.00);
SetDynamicObjectMaterial(tmpobjid, 0, 2669, "cj_chris", "CJ_Grate", 0x00000000);
SetDynamicObjectMaterial(tmpobjid, 1, 2669, "cj_chris", "CJ_Grate", 0x00000000);
tmpobjid = CreateDynamicObject(19392, 2004.182861, 1484.182861, 1095.178833, -0.000037, 360.000000, -89.399681, -1, -1, -1, 100.00, 100.00);
SetDynamicObjectMaterial(tmpobjid, 0, 16640, "a51", "a51_floorpanel1", 0x00000000);
SetDynamicObjectMaterial(tmpobjid, 1, 13077, "cunte_bar1", "alleydoor4", 0x00000000);
tmpobjid = CreateDynamicObject(19368, 2000.981811, 1484.159301, 1095.178833, -0.000037, 360.000000, -89.399681, -1, -1, -1, 100.00, 100.00);
SetDynamicObjectMaterial(tmpobjid, 0, 16640, "a51", "a51_floorpanel1", 0x00000000);
SetDynamicObjectMaterial(tmpobjid, 1, 13077, "cunte_bar1", "alleydoor4", 0x00000000);
tmpobjid = CreateDynamicObject(19368, 2007.391845, 1484.226440, 1095.178833, -0.000037, 360.000000, -89.399681, -1, -1, -1, 100.00, 100.00);
SetDynamicObjectMaterial(tmpobjid, 0, 16640, "a51", "a51_floorpanel1", 0x00000000);
SetDynamicObjectMaterial(tmpobjid, 1, 13077, "cunte_bar1", "alleydoor4", 0x00000000);
tmpobjid = CreateDynamicObject(19456, 2004.169311, 1484.208251, 1098.671630, -0.000037, 360.000000, -89.399681, -1, -1, -1, 100.00, 100.00);
SetDynamicObjectMaterial(tmpobjid, 0, 2917, "a51_crane", "girder2_grey_64HV", 0x00000000);
tmpobjid = CreateDynamicObject(19566, 2003.427001, 1484.137207, 1093.348510, 0.000008, 676.999877, -179.399810, -1, -1, -1, 100.00, 100.00);
SetDynamicObjectMaterial(tmpobjid, 0, 16322, "a51_stores", "metpat64chev_128", 0x00000000);
tmpobjid = CreateDynamicObject(19566, 2004.777832, 1484.151367, 1093.498291, -0.000008, -582.999877, 0.600212, -1, -1, -1, 100.00, 100.00);
SetDynamicObjectMaterial(tmpobjid, 0, 16322, "a51_stores", "metpat64chev_128", 0x00000000);
tmpobjid = CreateDynamicObject(19566, 2003.400146, 1484.136962, 1095.989135, -0.000008, -582.999877, 0.600212, -1, -1, -1, 100.00, 100.00);
SetDynamicObjectMaterial(tmpobjid, 0, 16322, "a51_stores", "metpat64chev_128", 0x00000000);
tmpobjid = CreateDynamicObject(19566, 2004.827392, 1484.151855, 1095.775756, 0.000008, 676.999877, -179.399810, -1, -1, -1, 100.00, 100.00);
SetDynamicObjectMaterial(tmpobjid, 0, 16322, "a51_stores", "metpat64chev_128", 0x00000000);
tmpobjid = CreateDynamicObject(19392, 1956.062255, 1534.522338, 1095.178833, -0.000053, 360.000000, -89.399635, -1, -1, -1, 100.00, 100.00);
SetDynamicObjectMaterial(tmpobjid, 0, 16640, "a51", "a51_floorpanel1", 0x00000000);
SetDynamicObjectMaterial(tmpobjid, 1, 13077, "cunte_bar1", "alleydoor4", 0x00000000);
tmpobjid = CreateDynamicObject(19368, 1952.861206, 1534.498779, 1095.178833, -0.000053, 360.000000, -89.399635, -1, -1, -1, 100.00, 100.00);
SetDynamicObjectMaterial(tmpobjid, 0, 16640, "a51", "a51_floorpanel1", 0x00000000);
SetDynamicObjectMaterial(tmpobjid, 1, 13077, "cunte_bar1", "alleydoor4", 0x00000000);
tmpobjid = CreateDynamicObject(19368, 1959.271240, 1534.565917, 1095.178833, -0.000053, 360.000000, -89.399635, -1, -1, -1, 100.00, 100.00);
SetDynamicObjectMaterial(tmpobjid, 0, 16640, "a51", "a51_floorpanel1", 0x00000000);
SetDynamicObjectMaterial(tmpobjid, 1, 13077, "cunte_bar1", "alleydoor4", 0x00000000);
tmpobjid = CreateDynamicObject(19456, 1956.048706, 1534.547729, 1098.671630, -0.000053, 360.000000, -89.399635, -1, -1, -1, 100.00, 100.00);
SetDynamicObjectMaterial(tmpobjid, 0, 2917, "a51_crane", "girder2_grey_64HV", 0x00000000);
tmpobjid = CreateDynamicObject(19566, 1955.306396, 1534.476684, 1093.348510, 0.000008, 676.999877, -179.399719, -1, -1, -1, 100.00, 100.00);
SetDynamicObjectMaterial(tmpobjid, 0, 16322, "a51_stores", "metpat64chev_128", 0x00000000);
tmpobjid = CreateDynamicObject(19566, 1956.657226, 1534.490844, 1093.498291, -0.000008, -582.999877, 0.600212, -1, -1, -1, 100.00, 100.00);
SetDynamicObjectMaterial(tmpobjid, 0, 16322, "a51_stores", "metpat64chev_128", 0x00000000);
tmpobjid = CreateDynamicObject(19566, 1955.279541, 1534.476440, 1095.989135, -0.000008, -582.999877, 0.600212, -1, -1, -1, 100.00, 100.00);
SetDynamicObjectMaterial(tmpobjid, 0, 16322, "a51_stores", "metpat64chev_128", 0x00000000);
tmpobjid = CreateDynamicObject(19566, 1956.706787, 1534.491333, 1095.775756, 0.000008, 676.999877, -179.399719, -1, -1, -1, 100.00, 100.00);
SetDynamicObjectMaterial(tmpobjid, 0, 16322, "a51_stores", "metpat64chev_128", 0x00000000);
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
tmpobjid = CreateDynamicObject(1811, 1959.700317, 1426.744140, 1093.628417, 0.000007, -139.299957, 68.800010, -1, -1, -1, 100.00, 100.00);
tmpobjid = CreateDynamicObject(18846, 1958.637573, 1419.855590, 1097.711425, 16.099996, -5.699998, 0.000000, -1, -1, -1, 100.00, 100.00);
tmpobjid = CreateDynamicObject(2008, 1891.994262, 1547.533691, 1093.429687, 0.000000, 0.000000, 1.499966, -1, -1, -1, 100.00, 100.00);
tmpobjid = CreateDynamicObject(2008, 1894.892700, 1547.609741, 1093.429687, 0.000000, 0.000000, 1.499966, -1, -1, -1, 100.00, 100.00);
tmpobjid = CreateDynamicObject(2008, 1898.451660, 1547.702880, 1093.429687, 0.000000, 0.000000, 1.499966, -1, -1, -1, 100.00, 100.00);
tmpobjid = CreateDynamicObject(2008, 1899.491088, 1551.339599, 1093.429687, 0.000000, 0.000000, -177.600067, -1, -1, -1, 100.00, 100.00);
tmpobjid = CreateDynamicObject(2008, 1896.513671, 1551.304931, 1093.429687, 0.000000, 0.000000, -179.900207, -1, -1, -1, 100.00, 100.00);
tmpobjid = CreateDynamicObject(2008, 1893.402343, 1551.300781, 1093.429687, 0.000000, 0.000000, -179.900207, -1, -1, -1, 100.00, 100.00);
tmpobjid = CreateDynamicObject(1671, 1892.938598, 1546.954345, 1093.860107, 0.000000, 0.000000, -173.499954, -1, -1, -1, 100.00, 100.00);
tmpobjid = CreateDynamicObject(1671, 1895.422241, 1546.976806, 1093.860107, 0.000000, 0.000000, 179.999984, -1, -1, -1, 100.00, 100.00);
tmpobjid = CreateDynamicObject(1671, 1899.272705, 1547.297119, 1093.860107, 0.000000, 0.000000, 179.999984, -1, -1, -1, 100.00, 100.00);
tmpobjid = CreateDynamicObject(1671, 1898.733154, 1551.984863, 1093.860107, 0.000000, 0.000000, -57.500038, -1, -1, -1, 100.00, 100.00);
tmpobjid = CreateDynamicObject(1671, 1895.694702, 1551.787597, 1093.860107, 0.000000, 0.000000, 0.699961, -1, -1, -1, 100.00, 100.00);
tmpobjid = CreateDynamicObject(1671, 1892.699584, 1552.141357, 1093.860107, 0.000000, 0.000000, 0.699961, -1, -1, -1, 100.00, 100.00);
tmpobjid = CreateDynamicObject(2687, 1901.114257, 1548.400268, 1094.858642, 0.000000, 0.000000, -89.900146, -1, -1, -1, 100.00, 100.00);
tmpobjid = CreateDynamicObject(2370, 1957.835083, 1419.192749, 1093.529785, 0.000000, 0.000007, 0.000000, -1, -1, -1, 100.00, 100.00);



tmpobjid = CreateDynamicObject(19559, 1930.559204, 1469.375000, 1094.322265, 0.000000, 0.000000, 0.000000, -1, -1, -1, 500.00, 500.00);
SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0xFF000000);
tmpobjid = CreateDynamicObject(19559, 1929.559204, 1469.375000, 1094.322265, 0.000000, 0.000000, 0.000000, -1, -1, -1, 500.00, 500.00);
SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0xFFFF0000);
tmpobjid = CreateDynamicObject(19559, 1928.559204, 1469.375000, 1094.322265, 0.000000, 0.000000, 0.000000, -1, -1, -1, 500.00, 500.00);
SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0xFF00FF00);
tmpobjid = CreateDynamicObject(19559, 1927.559204, 1469.375000, 1094.322265, 0.000000, 0.000000, 0.000000, -1, -1, -1, 500.00, 500.00);
SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0xFF0000FF);
tmpobjid = CreateDynamicObject(19559, 1926.559204, 1469.375000, 1094.322265, 0.000000, 0.000000, 0.000000, -1, -1, -1, 500.00, 500.00);
SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0xFFFFFFFF);
tmpobjid = CreateDynamicObject(19559, 1925.559204, 1469.375000, 1094.322265, 0.000000, 0.000000, 0.000000, -1, -1, -1, 500.00, 500.00);
SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0xFFFFFF00);//hier amongus rucksack backpack


    
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    sprayer[0] = CreateDynamicObject(18729, 1915.548339, 1469.840698, 1093.946655, 0.000000, 0.000000, 45.000000, -1, -1, -1, 300.00, 300.00);
    sprayer[1] = CreateDynamicObject(18729, 1915.612060, 1468.474243, 1093.946655, 0.000000, 0.000000, 135.000000, -1, -1, -1, 300.00, 300.00);
    sprayer[2] = CreateDynamicObject(18729, 1916.978515, 1468.453002, 1093.946655, 0.000000, 0.000000, 225.000000, -1, -1, -1, 300.00, 300.00);
    sprayer[3] = CreateDynamicObject(18729, 1917.006835, 1469.826538, 1093.946655, 0.000000, 0.000000, 315.000000, -1, -1, -1, 300.00, 300.00);
    sprayer[4] = CreateDynamicObject(18729, 1915.548339, 1469.840698, 1098.796386, 0.000004, 0.000004, 44.999988, -1, -1, -1, 300.00, 300.00);
    sprayer[5] = CreateDynamicObject(18729, 1915.612060, 1468.474243, 1098.796386, 0.000004, -0.000004, 135.000000, -1, -1, -1, 300.00, 300.00);
    sprayer[6] = CreateDynamicObject(18729, 1916.978515, 1468.453002, 1098.796386, -0.000004, -0.000004, -135.000000, -1, -1, -1, 300.00, 300.00);
    sprayer[7] = CreateDynamicObject(18729, 1917.006835, 1469.826538, 1098.796386, -0.000004, 0.000004, -44.999988, -1, -1, -1, 300.00, 300.00);


    spacedoorcockpit = CreateDynamicObject(19858, 1891.475708, 1468.520263, 1094.662475, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(spacedoorcockpit, 0, 2669, "cj_chris", "CJ_Grate", 0xFFFFFFFF);
    
    spacedoorstorage[0] = CreateDynamicObject(19858, 1932.977539, 1468.580810, 1094.662475, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(spacedoorstorage[0], 0, 2669, "cj_chris", "CJ_Grate", 0xFFFFFFFF);
    
    spacedoorstorage[1] = CreateDynamicObject(19858, 1941.288085, 1468.580810, 1094.662475, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(spacedoorstorage[1], 0, 2669, "cj_chris", "CJ_Grate", 0xFFFFFFFF);

    spacedoorstorage[2] = CreateDynamicObject(19858, 1979.896362, 1468.580810, 1094.662475, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(spacedoorstorage[2], 0, 2669, "cj_chris", "CJ_Grate", 0xFFFFFFFF);
    
    spacedoorstorage[3] = CreateDynamicObject(19858, 1988.865600, 1468.604614, 1094.670776, -0.000007, 719.999877, 90.600135, -1, -1, -1, 100.00, 100.00);
    SetDynamicObjectMaterial(spacedoorstorage[3], 0, 2669, "cj_chris", "CJ_Grate", 0xFFFFFFFF);
    
    spacedoorcomputers = CreateDynamicObject(19858, 1901.193969, 1548.617309, 1094.670776, 0.000007, 0.000030, 89.999946, -1, -1, -1, 100.00, 100.00);
    SetDynamicObjectMaterial(spacedoorcomputers, 0, 2669, "cj_chris", "CJ_Grate", 0xFFFFFFFF);
    
    spacedoorirgendwas[0] = CreateDynamicObject(19858, 1936.728881, 1550.106201, 1094.670776, 0.000000, 0.000022, -89.399841, -1, -1, -1, 100.00, 100.00);
    SetDynamicObjectMaterial(spacedoorirgendwas[0], 0, 2669, "cj_chris", "CJ_Grate", 0xFFFFFFFF);

    spacedoorirgendwas[1] = CreateDynamicObject(19858, 1978.324584, 1548.555908, 1094.670776, -0.000022, 719.999877, 90.600181, -1, -1, -1, 100.00, 100.00);
    SetDynamicObjectMaterial(spacedoorirgendwas[1], 0, 2669, "cj_chris", "CJ_Grate", 0xFFFFFFFF);
    
    spacedoorirgendwas[2] = CreateDynamicObject(19858, 1956.841308, 1534.498657, 1094.670776, 0.000008, 719.999877, -179.399719, -1, -1, -1, 100.00, 100.00);
    SetDynamicObjectMaterial(spacedoorirgendwas[2], 0, 2669, "cj_chris", "CJ_Grate", 0xFFFFFFFF);
    
    spacedoorirgendwas[3] = CreateDynamicObject(19858, 2004.961914, 1484.159179, 1094.670776, 0.000008, 719.999877, -179.399810, -1, -1, -1, 100.00, 100.00);
    SetDynamicObjectMaterial(spacedoorirgendwas[3], 0, 2669, "cj_chris", "CJ_Grate", 0xFFFFFFFF);
    
    spacedoormeeting[0] = CreateDynamicObject(19858, 1939.611083, 1420.494262, 1094.670776, -0.000015, 719.999877, -89.399818, -1, -1, -1, 100.00, 100.00);
    SetDynamicObjectMaterial(spacedoormeeting[0], 0, 2669, "cj_chris", "CJ_Grate", 0xFFFFFFFF);
    
    spacedoormeeting[1] = CreateDynamicObject(19858, 1981.206787, 1418.943969, 1094.670776, -0.000007, 0.000022, 90.600158, -1, -1, -1, 100.00, 100.00);
    SetDynamicObjectMaterial(spacedoormeeting[1], 0, 2669, "cj_chris", "CJ_Grate", 0xFFFFFFFF);
    
    spacedoorcenter[0] = CreateDynamicObject(19858, 1915.586181, 1453.308959, 1094.662475, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(spacedoorcenter[0], 0, 2669, "cj_chris", "CJ_Grate", 0xFFFFFFFF);
    
    spacedoorcenter[1] = CreateDynamicObject(19858, 1915.586181, 1485.070922, 1094.662475, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(spacedoorcenter[1], 0, 2669, "cj_chris", "CJ_Grate", 0xFFFFFFFF);

    genring[0] = CreateDynamicObject(3438, 1916.293823, 1469.111206, 1096.619140, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(genring[0], 0, 16640, "a51", "des_tunnellight", 0xFFFFFFFF);
    genring[1] = CreateDynamicObject(3438, 1916.293823, 1469.111206, 1098.619140, 0.000000, 90.000000, 0.00000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(genring[1], 0, 16640, "a51", "des_tunnellight", 0xFFFFFFFF);
    genring[2] = CreateDynamicObject(3438, 1916.293823, 1469.111206, 1100.368896, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(genring[2], 0, 16640, "a51", "des_tunnellight", 0xFFFFFFFF);

    button[0] = CreateDynamicObject(2709, 1885.305419, 1472.980590, 1095.216552, 90.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(button[0] , 0, 10101, "2notherbuildsfe", "ferry_build14", 0xFF00FF00);
    button[1]  = CreateDynamicObject(2709, 1883.245117, 1472.980590, 1095.216552, 90.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(button[1] , 0, 10101, "2notherbuildsfe", "ferry_build14", 0xFF00FF00);
    button[2]  = CreateDynamicObject(2709, 1883.245117, 1465.648925, 1095.216552, 90.000000, 0.000000, 360.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(button[2] , 0, 10101, "2notherbuildsfe", "ferry_build14", 0xFF00FF00);
    button[3]  = CreateDynamicObject(2709, 1885.265625, 1465.648925, 1095.216552, 90.000000, 0.000000, 360.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(button[3] , 0, 10101, "2notherbuildsfe", "ferry_build14", 0xFF00FF00);

    SetTimer("AmongUsTimer", 1000, true);
	return 1;
}

stock AmongUsTimer();
public AmongUsTimer()
{
	for(new playerid=0; playerid < MAX_PLAYERS; playerid++)
	{
	    if(IsPlayerConnected(playerid) && IsPlayerPlayingMinigame(playerid, 1))
	    {
	        if(IsPlayerInRangeOfPoint(playerid,3.0,1891.5776,1469.2914,1094.4314) && door[0] == false && !IsDynamicObjectMoving(spacedoorcockpit))
	        {
				door[0] = true;
				MoveDynamicObject(spacedoorcockpit,1891.475708, 1467.149780, 1094.662475, 2.0);
				SetTimerEx("AmongUsDoorTimer", 2000, false, "%i", 1);
	        }
			if(IsPlayerInRangeOfPoint(playerid,3.0,1932.8406,1469.3179,1094.4314) && door[1] == false && !IsDynamicObjectMoving(spacedoorstorage[0]))
			{
			    door[1] = true;
			    MoveDynamicObject(spacedoorstorage[0],1932.977539, 1467.200317, 1094.662475, 2.0);
				SetTimerEx("AmongUsDoorTimer", 2000, false, "%i", 2);
			}
			if(IsPlayerInRangeOfPoint(playerid,3.0,1941.1128,1469.3054,1094.4314) && door[2] == false && !IsDynamicObjectMoving(spacedoorstorage[1]))
			{
			    door[2] = true;
			    MoveDynamicObject(spacedoorstorage[1],1941.288085, 1467.190185, 1094.662475, 2.0);
				SetTimerEx("AmongUsDoorTimer", 2000, false, "%i", 3);
			}
			if(IsPlayerInRangeOfPoint(playerid,3.0,1901.193969, 1548.617309, 1096.670776) && door[3] == false && !IsDynamicObjectMoving(spacedoorcomputers))
			{
			    door[3] = true;
			    MoveDynamicObject(spacedoorcomputers,1901.193969, 1548.617309+1.4, 1094.670774, 2.0);
				SetTimerEx("AmongUsDoorTimer", 2000, false, "%i", 4);
			}
			if(IsPlayerInRangeOfPoint(playerid,3.0,1936.728881, 1550.106201, 1094.670776) && door[4] == false && !IsDynamicObjectMoving(spacedoorirgendwas[0]))
			{
			    door[4] = true;
			    MoveDynamicObject(spacedoorirgendwas[0],1936.728881, 1550.106201+1.4, 1094.670776, 2.0);
				SetTimerEx("AmongUsDoorTimer", 2000, false, "%i", 5);
			}
			if(IsPlayerInRangeOfPoint(playerid,3.0,1978.324584, 1548.555908, 1094.670776) && door[5] == false && !IsDynamicObjectMoving(spacedoorirgendwas[1]))
			{
			    door[5] = true;
			    MoveDynamicObject(spacedoorirgendwas[1],1978.324584, 1548.555908-1.4, 1094.670776, 2.0);
				SetTimerEx("AmongUsDoorTimer", 2000, false, "%i", 6);
			}
			if(IsPlayerInRangeOfPoint(playerid,3.0,1956.841308, 1534.498657, 1094.670776) && door[12] == false && !IsDynamicObjectMoving(spacedoorirgendwas[2]))
			{
			    door[12] = true;
			    MoveDynamicObject(spacedoorirgendwas[2],1956.841308-1.4, 1534.498657, 1094.670776, 2.0);
				SetTimerEx("AmongUsDoorTimer", 2000, false, "%i", 13);
			}
			if(IsPlayerInRangeOfPoint(playerid,3.0,2004.961914, 1484.159179, 1094.670776) && door[13] == false && !IsDynamicObjectMoving(spacedoorirgendwas[3]))
			{
			    door[13] = true;
			    MoveDynamicObject(spacedoorirgendwas[3],2004.961914-1.4, 1484.159179, 1094.670776, 2.0);
				SetTimerEx("AmongUsDoorTimer", 2000, false, "%i", 14);
			}
			if(IsPlayerInRangeOfPoint(playerid,3.0,1979.896362, 1468.580810, 1094.662475) && door[6] == false && !IsDynamicObjectMoving(spacedoorstorage[2]))
			{
			    door[6] = true;
			    MoveDynamicObject(spacedoorstorage[2],1979.896362, 1468.580810-1.4, 1094.662475, 2.0);
				SetTimerEx("AmongUsDoorTimer", 2000, false, "%i", 7);
			}
			if(IsPlayerInRangeOfPoint(playerid,3.0,1915.586181, 1453.308959, 1094.662475) && door[7] == false && !IsDynamicObjectMoving(spacedoorcenter[0]))
			{
			    door[7] = true;
			    MoveDynamicObject(spacedoorcenter[0],1915.586181+1.4, 1453.308959, 1094.662475, 2.0);
				SetTimerEx("AmongUsDoorTimer", 2000, false, "%i", 18);
			}
			if(IsPlayerInRangeOfPoint(playerid,3.0,1915.586181, 1485.070922, 1094.662475) && door[8] == false && !IsDynamicObjectMoving(spacedoorcenter[1]))
			{
			    door[8] = true;
			    MoveDynamicObject(spacedoorcenter[1],1915.586181-1.4, 1485.070922, 1094.662475, 2.0);
				SetTimerEx("AmongUsDoorTimer", 2000, false, "%i", 9);
			}
			if(IsPlayerInRangeOfPoint(playerid,3.0,1939.611083, 1420.494262, 1094.670776) && door[9] == false && !IsDynamicObjectMoving(spacedoormeeting[0]))
			{
				if(AmongUsGameState < RESETAUPLAYERS) return 0;
			    door[9] = true;
			    MoveDynamicObject(spacedoormeeting[0],1939.611083, 1420.494262+1.4, 1094.670776, 2.0);
				SetTimerEx("AmongUsDoorTimer", 2000, false, "%i", 10);
			}
			if(IsPlayerInRangeOfPoint(playerid,3.0,1981.206787, 1418.943969, 1094.670776) && door[10] == false && !IsDynamicObjectMoving(spacedoormeeting[1]))
			{
				if(AmongUsGameState < RESETAUPLAYERS) return 0;
			    door[10] = true;
			    MoveDynamicObject(spacedoormeeting[1],1981.206787, 1418.943969+1.4, 1094.670776, 2.0);
				SetTimerEx("AmongUsDoorTimer", 2000, false, "%i", 11);
			}
			if(IsPlayerInRangeOfPoint(playerid,3.0,1988.865600, 1468.604614, 1094.670776) && door[11] == false && !IsDynamicObjectMoving(spacedoorstorage[3]))
			{
			    door[11] = true;
			    MoveDynamicObject(spacedoorstorage[3],1988.865600, 1468.604614-1.4, 1094.670776, 2.0);
				SetTimerEx("AmongUsDoorTimer", 2000, false, "%i", 12);
			}

	    }
	}
	if(rotdelay > 0)rotdelay --;
	if(generator == false)
	{
	    if(ringstate == false)
	    {
	        ringstate = true;
	        if(rotdelay == 0)
	        {
				rotdelay = 3;
				MoveDynamicObject(genring[0], 1916.293823, 1469.111206, 1096.619140+0.0001,  0.0001,  0.0, 90.0, 180.0);
				MoveDynamicObject(genring[1], 1916.293823, 1469.111206, 1098.619140+0.0001,  0.0001,  0.0, 90.0, 180.0);
				MoveDynamicObject(genring[2], 1916.293823, 1469.111206, 1100.368896+0.0001,  0.0001,  0.0, 90.0, 180.0);
	        }
	    }
	    else
	    {
	        ringstate = false;
	        if(rotdelay == 0)
	        {
				rotdelay = 3;
				MoveDynamicObject(genring[0], 1916.293823, 1469.111206, 1096.619140-0.0001,  0.0001,  0.0, 90.0, 0.0);
				MoveDynamicObject(genring[1], 1916.293823, 1469.111206, 1098.619140-0.0001,  0.0001,  0.0, 90.0, 0.0);
				MoveDynamicObject(genring[2], 1916.293823, 1469.111206, 1100.368896-0.0001,  0.0001,  0.0, 90.0, 0.0);
  	        }
	    }
	}
	if(AmongUsGameState == WAITFORAUPLAYERS)
	{
	   SendClientMessage(AmongUsPlayer[0], Weis, "Waiting for players...");
	   SendClientMessage(AmongUsPlayer[1], Weis, "Waiting for players...");
	   SendClientMessage(AmongUsPlayer[2], Weis, "Waiting for players...");
	   SendClientMessage(AmongUsPlayer[3], Weis, "Waiting for players...");
	   SendClientMessage(AmongUsPlayer[4], Weis, "Waiting for players...");
	   SendClientMessage(AmongUsPlayer[5], Weis, "Waiting for players...");
	   if(AmongUsPlayer[0] >= 0 && AmongUsPlayer[1] >= 0 && AmongUsPlayer[2] >= 0 && AmongUsPlayer[3] >= 0 && AmongUsPlayer[4] >= 0 && AmongUsPlayer[5] >= 0)
	   {
		   SendClientMessageToAll(Weis, "The minigame will start now!");
		   AmongUsImposter[0] = random(12);
		   if (AmongUsImposter[0] > 5)
		   {
		      AmongUsImposter[0] = AmongUsImposter[0] -6;
		      AmongUsImposter[1] = random(5);
		      if (AmongUsImposter[1] == 0) AmongUsPlayer[0] = AmongUsImposter[1];
		      if (AmongUsImposter[1] == 1) AmongUsPlayer[1] = AmongUsImposter[1];
		      if (AmongUsImposter[1] == 2) AmongUsPlayer[2] = AmongUsImposter[1];
		      if (AmongUsImposter[1] == 3) AmongUsPlayer[3] = AmongUsImposter[1];
		      if (AmongUsImposter[1] == 4) AmongUsPlayer[4] = AmongUsImposter[1];
		      if (AmongUsImposter[1] == 5) AmongUsPlayer[5] = AmongUsImposter[1];
		   }
		   if (AmongUsImposter[0] == 0) AmongUsPlayer[0] = AmongUsImposter[0];
		   if (AmongUsImposter[0] == 1) AmongUsPlayer[1] = AmongUsImposter[0];
		   if (AmongUsImposter[0] == 2) AmongUsPlayer[1] = AmongUsImposter[0];
		   if (AmongUsImposter[0] == 3) AmongUsPlayer[3] = AmongUsImposter[0];
		   if (AmongUsImposter[0] == 4) AmongUsPlayer[4] = AmongUsImposter[0];
		   if (AmongUsImposter[0] == 5) AmongUsPlayer[5] = AmongUsImposter[0];
		   if(AmongUsImposter[0] == AmongUsImposter[1])
		   {
		      if (AmongUsImposter[1] == 5) AmongUsImposter[1] = AmongUsImposter[1]-1;
		      else AmongUsImposter[1] = AmongUsImposter[1]+1;
		      SendClientMessageToAll(Hellgrün, "Gleicher Imposter!");
		   }
		   AmongUsGameState = RESETAUPLAYERS;
	   }
	   SendInfoText(AmongUsImposter[0], "~b~YOU ARE THE IMPOSTER. ~w~~n~Press ~k~~SNEAK_ABOUT~ to kill people, use Vents and do sabotage.");
	   SendInfoText(AmongUsImposter[1], "~b~YOU ARE THE IMPOSTER. ~w~~n~Press ~k~~SNEAK_ABOUT~ to kill people, use Vents and do sabotage.");
	   return 1;
	}
	if(AmongUsGameState == RESETAUPLAYERS)
	{
	   SetPlayerPos(AmongUsPlayer[0], 1955.8754,1417.5018,1094.4299);
	   SetPlayerFacingAngle(AmongUsPlayer[0], 313.6150);
	   SetCameraBehindPlayer(AmongUsPlayer[0]);

	   SetPlayerPos(AmongUsPlayer[1], 1958.7141,1416.2363,1094.4299);
	   SetPlayerFacingAngle(AmongUsPlayer[1], 7.5089);
	   SetCameraBehindPlayer(AmongUsPlayer[1]);

	   SetPlayerPos(AmongUsPlayer[2], 1961.2396,1417.9348,1094.4299);
	   SetPlayerFacingAngle(AmongUsPlayer[2], 58.2694);
	   SetCameraBehindPlayer(AmongUsPlayer[2]);

	   SetPlayerPos(AmongUsPlayer[3], 1961.4630,1421.6072,1094.4299);
	   SetPlayerFacingAngle(AmongUsPlayer[3], 130.0234);
	   SetCameraBehindPlayer(AmongUsPlayer[3]);

	   SetPlayerPos(AmongUsPlayer[4], 1958.2216,1423.1997,1094.4299);
	   SetPlayerFacingAngle(AmongUsPlayer[4], 174.5171);
	   SetCameraBehindPlayer(AmongUsPlayer[4]);

	   SetPlayerPos(AmongUsPlayer[5], 1955.6514,1421.6895,1094.4299);
	   SetPlayerFacingAngle(AmongUsPlayer[5], 231.8576);
	   SetCameraBehindPlayer(AmongUsPlayer[5]);
	   AmongUsGameState = AUGAME;
	   return 1;
	}
	if(AmongUsGameState == AUGAME)
	{
	   new Float:X, Float:Y, Float:Z;
	   {
	      GetPlayerPos(AmongUsPlayer[0], X, Y, Z);
	      if(!IsPlayerInRangeOfPoint(AmongUsImposter[0], 2, X, Y, Z))return 0;
	      if(!IsPlayerInRangeOfPoint(AmongUsImposter[1], 2, X, Y, Z))return 0;
	   }
	   {
	      GetPlayerPos(AmongUsPlayer[1], X, Y, Z);
	      if(!IsPlayerInRangeOfPoint(AmongUsImposter[0], 2, X, Y, Z))return 0;
	      if(!IsPlayerInRangeOfPoint(AmongUsImposter[1], 2, X, Y, Z))return 0;
	   }
	   {
	      GetPlayerPos(AmongUsPlayer[2], X, Y, Z);
	      if(!IsPlayerInRangeOfPoint(AmongUsImposter[0], 2, X, Y, Z))return 0;
	      if(!IsPlayerInRangeOfPoint(AmongUsImposter[1], 2, X, Y, Z))return 0;
	   }
	   {
	      GetPlayerPos(AmongUsPlayer[3], X, Y, Z);
	      if(!IsPlayerInRangeOfPoint(AmongUsImposter[0], 2, X, Y, Z))return 0;
	      if(!IsPlayerInRangeOfPoint(AmongUsImposter[1], 2, X, Y, Z))return 0;
	   }
	   {
	      GetPlayerPos(AmongUsPlayer[4], X, Y, Z);
	      if(!IsPlayerInRangeOfPoint(AmongUsImposter[0], 2, X, Y, Z))return 0;
	      if(!IsPlayerInRangeOfPoint(AmongUsImposter[1], 2, X, Y, Z))return 0;
	   }
	   {
	      GetPlayerPos(AmongUsPlayer[5], X, Y, Z);
	      if(!IsPlayerInRangeOfPoint(AmongUsImposter[0], 2, X, Y, Z))return 0;
	      if(!IsPlayerInRangeOfPoint(AmongUsImposter[1], 2, X, Y, Z))return 0;//hier
	   }
	   
	}
	if(AmongUsGameState == AUMEETING)
	{
	   if(AmongUsMeetingTime <= 0)
	   {
	      AmongUsVotingTime = 31;
	      for(new AmongUsplayerid = 0; AmongUsplayerid < 6; AmongUsplayerid++)
	      {
		      TextDrawHideForPlayer(AmongUsplayerid, AmongUsMessage1[0]);
		      TextDrawHideForPlayer(AmongUsplayerid, AmongUsMessage1[1]);
		      TextDrawHideForPlayer(AmongUsplayerid, AmongUsMessage1[2]);
		      TextDrawHideForPlayer(AmongUsplayerid, AmongUsMessage1[3]);
		      TextDrawHideForPlayer(AmongUsplayerid, AmongUsMessage2[0]);
		      TextDrawHideForPlayer(AmongUsplayerid, AmongUsMessage2[1]);
		      TextDrawHideForPlayer(AmongUsplayerid, AmongUsMessage2[2]);
		      TextDrawHideForPlayer(AmongUsplayerid, AmongUsMessage2[3]);
		      TextDrawHideForPlayer(AmongUsplayerid, AmongUsMessage3[0]);
		      TextDrawHideForPlayer(AmongUsplayerid, AmongUsMessage3[1]);
		      TextDrawHideForPlayer(AmongUsplayerid, AmongUsMessage3[2]);
		      TextDrawHideForPlayer(AmongUsplayerid, AmongUsMessage3[3]);
		      TextDrawHideForPlayer(AmongUsplayerid, AmongUsMessage4[0]);
		      TextDrawHideForPlayer(AmongUsplayerid, AmongUsMessage4[1]);
		      TextDrawHideForPlayer(AmongUsplayerid, AmongUsMessage4[2]);
		      TextDrawHideForPlayer(AmongUsplayerid, AmongUsMessage4[3]);
		      TextDrawHideForPlayer(AmongUsplayerid, AmongUsMessage5[0]);
		      TextDrawHideForPlayer(AmongUsplayerid, AmongUsMessage5[1]);
		      TextDrawHideForPlayer(AmongUsplayerid, AmongUsMessage5[2]);
		      TextDrawHideForPlayer(AmongUsplayerid, AmongUsMessage5[3]);
		      TextDrawShowForPlayer(AmongUsplayerid, AmongUsVotePlayer[0]);
		      TextDrawShowForPlayer(AmongUsplayerid, AmongUsVotePlayer[1]);
		      TextDrawShowForPlayer(AmongUsplayerid, AmongUsVotePlayer[2]);
		      TextDrawShowForPlayer(AmongUsplayerid, AmongUsVotePlayer[3]);
		      TextDrawShowForPlayer(AmongUsplayerid, AmongUsVotePlayer[4]);
		      TextDrawShowForPlayer(AmongUsplayerid, AmongUsVotePlayer[5]);
		      TextDrawShowForPlayer(AmongUsplayerid, AmongUsVotePlayer[6]);
		      TextDrawShowForPlayer(AmongUsplayerid, AmongUsVotePlayer[7]);
		      TextDrawShowForPlayer(AmongUsplayerid, AmongUsVotePlayer[8]);
		      TextDrawShowForPlayer(AmongUsplayerid, AmongUsVotePlayer[9]);
		      TextDrawShowForPlayer(AmongUsplayerid, AmongUsVotePlayer[10]);
		      TextDrawShowForPlayer(AmongUsplayerid, AmongUsVotePlayer[11]);
		      TextDrawShowForPlayer(AmongUsplayerid, AmongUsVotePlayer[12]);
		      TextDrawShowForPlayer(AmongUsplayerid, AmongUsVotePlayer[13]);
		      TextDrawShowForPlayer(AmongUsplayerid, AmongUsVotePlayer[14]);
		      TextDrawShowForPlayer(AmongUsplayerid, AmongUsVotePlayer[15]);
		      TextDrawShowForPlayer(AmongUsplayerid, AmongUsVotePlayer[16]);
		      TextDrawShowForPlayer(AmongUsplayerid, AmongUsVotePlayer[17]);
		      TextDrawSetString(AmongUsVotePlayer[6], GetSname(AmongUsPlayer[0]));
		      TextDrawSetString(AmongUsVotePlayer[8], GetSname(AmongUsPlayer[1]));
		      TextDrawSetString(AmongUsVotePlayer[10], GetSname(AmongUsPlayer[2]));
		      TextDrawSetString(AmongUsVotePlayer[12], GetSname(AmongUsPlayer[3]));
		      TextDrawSetString(AmongUsVotePlayer[14], GetSname(AmongUsPlayer[4]));
		      TextDrawSetString(AmongUsVotePlayer[16], GetSname(AmongUsPlayer[5]));
			  SelectTextDraw(AmongUsplayerid, TextdrawFarbe);
		  }
		  AmongUsGameState = AUVOTE;
	      return 1;
	   }
	   AmongUsMeetingTime = AmongUsMeetingTime -1;
	   new string[25];
	   format(string, sizeof string, "Voting in: %s", SecondsToMinutes(AmongUsMeetingTime));
	   SendInfoText(AmongUsPlayer[0], string);
	   SendInfoText(AmongUsPlayer[1], string);
	   SendInfoText(AmongUsPlayer[2], string);
	   SendInfoText(AmongUsPlayer[3], string);
	   SendInfoText(AmongUsPlayer[4], string);
	   SendInfoText(AmongUsPlayer[5], string);
	   return 1;
	}
	if(AmongUsGameState == AUVOTE)
	{
	   if(AmongUsVotingTime <= 0)
	   {
	      for(new AmongUsplayerid = 0; AmongUsplayerid < 6; AmongUsplayerid++)
	      {
		      TextDrawHideForPlayer(AmongUsplayerid, AmongUsTablet[0]);
		      TextDrawHideForPlayer(AmongUsplayerid, AmongUsTablet[1]);
		      TextDrawHideForPlayer(AmongUsplayerid, AmongUsTablet[2]);
		      TextDrawHideForPlayer(AmongUsplayerid, AmongUsTablet[3]);
		      TextDrawHideForPlayer(AmongUsplayerid, AmongUsTablet[4]);
		      TextDrawHideForPlayer(AmongUsplayerid, AmongUsTablet[5]);
		      TextDrawHideForPlayer(AmongUsplayerid, AmongUsBildschirm);
		      TextDrawHideForPlayer(AmongUsplayerid, AmongUsHomeButton);
		      TextDrawHideForPlayer(AmongUsplayerid, AmongUsMessage1[0]);
		      TextDrawHideForPlayer(AmongUsplayerid, AmongUsMessage1[1]);
		      TextDrawHideForPlayer(AmongUsplayerid, AmongUsMessage1[2]);
		      TextDrawHideForPlayer(AmongUsplayerid, AmongUsMessage1[3]);
		      TextDrawHideForPlayer(AmongUsplayerid, AmongUsMessage2[0]);
		      TextDrawHideForPlayer(AmongUsplayerid, AmongUsMessage2[1]);
		      TextDrawHideForPlayer(AmongUsplayerid, AmongUsMessage2[2]);
		      TextDrawHideForPlayer(AmongUsplayerid, AmongUsMessage2[3]);
		      TextDrawHideForPlayer(AmongUsplayerid, AmongUsMessage3[0]);
		      TextDrawHideForPlayer(AmongUsplayerid, AmongUsMessage3[1]);
		      TextDrawHideForPlayer(AmongUsplayerid, AmongUsMessage3[2]);
		      TextDrawHideForPlayer(AmongUsplayerid, AmongUsMessage3[3]);
		      TextDrawHideForPlayer(AmongUsplayerid, AmongUsMessage4[0]);
		      TextDrawHideForPlayer(AmongUsplayerid, AmongUsMessage4[1]);
		      TextDrawHideForPlayer(AmongUsplayerid, AmongUsMessage4[2]);
		      TextDrawHideForPlayer(AmongUsplayerid, AmongUsMessage4[3]);
		      TextDrawHideForPlayer(AmongUsplayerid, AmongUsMessage5[0]);
		      TextDrawHideForPlayer(AmongUsplayerid, AmongUsMessage5[1]);
		      TextDrawHideForPlayer(AmongUsplayerid, AmongUsMessage5[2]);
		      TextDrawHideForPlayer(AmongUsplayerid, AmongUsMessage5[3]);
		      TextDrawHideForPlayer(AmongUsplayerid, AmongUsVotePlayer[0]);
		      TextDrawHideForPlayer(AmongUsplayerid, AmongUsVotePlayer[1]);
		      TextDrawHideForPlayer(AmongUsplayerid, AmongUsVotePlayer[2]);
		      TextDrawHideForPlayer(AmongUsplayerid, AmongUsVotePlayer[3]);
		      TextDrawHideForPlayer(AmongUsplayerid, AmongUsVotePlayer[4]);
		      TextDrawHideForPlayer(AmongUsplayerid, AmongUsVotePlayer[5]);
		      TextDrawHideForPlayer(AmongUsplayerid, AmongUsVotePlayer[6]);
		      TextDrawHideForPlayer(AmongUsplayerid, AmongUsVotePlayer[7]);
		      TextDrawHideForPlayer(AmongUsplayerid, AmongUsVotePlayer[8]);
		      TextDrawHideForPlayer(AmongUsplayerid, AmongUsVotePlayer[9]);
		      TextDrawHideForPlayer(AmongUsplayerid, AmongUsVotePlayer[10]);
		      TextDrawHideForPlayer(AmongUsplayerid, AmongUsVotePlayer[11]);
		      TextDrawHideForPlayer(AmongUsplayerid, AmongUsVotePlayer[12]);
		      TextDrawHideForPlayer(AmongUsplayerid, AmongUsVotePlayer[13]);
		      TextDrawHideForPlayer(AmongUsplayerid, AmongUsVotePlayer[14]);
		      TextDrawHideForPlayer(AmongUsplayerid, AmongUsVotePlayer[15]);
		      TextDrawHideForPlayer(AmongUsplayerid, AmongUsVotePlayer[16]);
		      TextDrawHideForPlayer(AmongUsplayerid, AmongUsVotePlayer[17]);
		      CancelSelectTextDraw(AmongUsplayerid);
		  }
		  TogglePlayerControllable(AmongUsPlayer[0], 1);
		  TogglePlayerControllable(AmongUsPlayer[1], 1);
		  TogglePlayerControllable(AmongUsPlayer[2], 1);
		  TogglePlayerControllable(AmongUsPlayer[3], 1);
		  TogglePlayerControllable(AmongUsPlayer[4], 1);
		  TogglePlayerControllable(AmongUsPlayer[5], 1);
		  AmongUsMeetingCoolDown = gettime();
		  return AmongUsGameState = AUGAME;
	   }
	   AmongUsVotingTime = AmongUsVotingTime -1;
	   new string[25];
	   format(string, sizeof string, "Remaining Time: %s", SecondsToMinutes(AmongUsVotingTime));
	   SendInfoText(AmongUsPlayer[0], string);
	   SendInfoText(AmongUsPlayer[1], string);
	   SendInfoText(AmongUsPlayer[2], string);
	   SendInfoText(AmongUsPlayer[3], string);
	   SendInfoText(AmongUsPlayer[4], string);
	   SendInfoText(AmongUsPlayer[5], string);
	   return 1;
	}
	return 1;
}

public OnPlayerClickTextDraw(playerid, Text:clickedid)
{
   if(clickedid == AmongUsVotePlayer[0] && playerid == AmongUsPlayer[0])
   {
	  return 0;
   }
   if(clickedid == AmongUsVotePlayer[1] && playerid == AmongUsPlayer[1])
   {
	  return 0;
   }
   if(clickedid == AmongUsVotePlayer[2] && playerid == AmongUsPlayer[2])
   {
	  return 0;
   }
   if(clickedid == AmongUsVotePlayer[3] && playerid == AmongUsPlayer[3])
   {
	  return 0;
   }
   if(clickedid == AmongUsVotePlayer[4] && playerid == AmongUsPlayer[4])
   {
	  return 0;
   }
   if(clickedid == AmongUsVotePlayer[5] && playerid == AmongUsPlayer[5])
   {
	  return 0;
   }//hier
   return 1;
}

public OnFilterScriptExit()
{
	return 1;
}


public OnPlayerConnect(playerid)
{
AmongUsTablet[0] = TextDrawCreate(169.299774, 114.000000, "LD_SPAC:white");
TextDrawTextSize(AmongUsTablet[0], 291.439819, 211.199630);
TextDrawAlignment(AmongUsTablet[0], 1);
TextDrawColor(AmongUsTablet[0], -2139062017);
TextDrawSetShadow(AmongUsTablet[0], 0);
TextDrawBackgroundColor(AmongUsTablet[0], 255);
TextDrawFont(AmongUsTablet[0], 4);
TextDrawSetProportional(AmongUsTablet[0], 0);

AmongUsTablet[1] = TextDrawCreate(154.333328, 107.925941, "LD_BEAT:chit");
TextDrawTextSize(AmongUsTablet[1], 29.399999, 35.459995);
TextDrawAlignment(AmongUsTablet[1], 1);
TextDrawColor(AmongUsTablet[1], -2139062017);
TextDrawSetShadow(AmongUsTablet[1], 0);
TextDrawBackgroundColor(AmongUsTablet[1], 255);
TextDrawFont(AmongUsTablet[1], 4);
TextDrawSetProportional(AmongUsTablet[1], 0);

AmongUsTablet[2] = TextDrawCreate(446.333343, 107.925941, "LD_BEAT:chit");
TextDrawTextSize(AmongUsTablet[2], 29.399999, 35.459995);
TextDrawAlignment(AmongUsTablet[2], 1);
TextDrawColor(AmongUsTablet[2], -2139062017);
TextDrawSetShadow(AmongUsTablet[2], 0);
TextDrawBackgroundColor(AmongUsTablet[2], 255);
TextDrawFont(AmongUsTablet[2], 4);
TextDrawSetProportional(AmongUsTablet[2], 0);

AmongUsTablet[3] = TextDrawCreate(446.333343, 295.925964, "LD_BEAT:chit");
TextDrawTextSize(AmongUsTablet[3], 29.399999, 35.459995);
TextDrawAlignment(AmongUsTablet[3], 1);
TextDrawColor(AmongUsTablet[3], -2139062017);
TextDrawSetShadow(AmongUsTablet[3], 0);
TextDrawBackgroundColor(AmongUsTablet[3], 255);
TextDrawFont(AmongUsTablet[3], 4);
TextDrawSetProportional(AmongUsTablet[3], 0);

AmongUsTablet[4] = TextDrawCreate(154.333343, 295.925964, "LD_BEAT:chit");
TextDrawTextSize(AmongUsTablet[4], 29.399999, 35.459995);
TextDrawAlignment(AmongUsTablet[4], 1);
TextDrawColor(AmongUsTablet[4], -2139062017);
TextDrawSetShadow(AmongUsTablet[4], 0);
TextDrawBackgroundColor(AmongUsTablet[4], 255);
TextDrawFont(AmongUsTablet[4], 4);
TextDrawSetProportional(AmongUsTablet[4], 0);

AmongUsTablet[5] = TextDrawCreate(159.299774, 124.000000, "LD_SPAC:white");
TextDrawTextSize(AmongUsTablet[5], 311.229858, 192.009735);
TextDrawAlignment(AmongUsTablet[5], 1);
TextDrawColor(AmongUsTablet[5], -2139062017);
TextDrawSetShadow(AmongUsTablet[5], 0);
TextDrawBackgroundColor(AmongUsTablet[5], 255);
TextDrawFont(AmongUsTablet[5], 4);
TextDrawSetProportional(AmongUsTablet[5], 0);

AmongUsBildschirm = TextDrawCreate(168.899719, 122.999877, "LD_SPAC:white");
TextDrawTextSize(AmongUsBildschirm, 271.649475, 193.599761);
TextDrawAlignment(AmongUsBildschirm, 1);
TextDrawColor(AmongUsBildschirm, 842150655);
TextDrawSetShadow(AmongUsBildschirm, 0);
TextDrawBackgroundColor(AmongUsBildschirm, 255);
TextDrawFont(AmongUsBildschirm, 4);
TextDrawSetProportional(AmongUsBildschirm, 0);

AmongUsHomeButton = TextDrawCreate(447.200775, 209.133483, "LD_BEAT:square");
TextDrawTextSize(AmongUsHomeButton, 17.199941, 19.999940);
TextDrawAlignment(AmongUsHomeButton, 1);
TextDrawColor(AmongUsHomeButton, -1);
TextDrawSetShadow(AmongUsHomeButton, 0);
TextDrawBackgroundColor(AmongUsHomeButton, 255);
TextDrawFont(AmongUsHomeButton, 4);
TextDrawSetProportional(AmongUsHomeButton, 0);

AmongUsMessage1[2] = TextDrawCreate(172.999984, 127.622230, "LD_SPAC:white");//nachricht 1
TextDrawTextSize(AmongUsMessage1[2], 108.219093, 24.000000);
TextDrawAlignment(AmongUsMessage1[2], 1);
TextDrawColor(AmongUsMessage1[2], -1);
TextDrawSetShadow(AmongUsMessage1[2], 0);
TextDrawBackgroundColor(AmongUsMessage1[2], 255);
TextDrawFont(AmongUsMessage1[2], 4);
TextDrawSetProportional(AmongUsMessage1[2], 0);

AmongUsMessage1[3] = TextDrawCreate(172.999984, 138.422332, "LD_SPAC:white");
TextDrawTextSize(AmongUsMessage1[3], 263.000000, 24.000000);
TextDrawAlignment(AmongUsMessage1[3], 1);
TextDrawColor(AmongUsMessage1[3], -1);
TextDrawSetShadow(AmongUsMessage1[3], 0);
TextDrawBackgroundColor(AmongUsMessage1[3], 255);
TextDrawFont(AmongUsMessage1[3], 4);
TextDrawSetProportional(AmongUsMessage1[3], 0);

AmongUsMessage1[0] = TextDrawCreate(175.133544, 142.414978, "123456789qwertzuiopasdfhjklyxcvbnmqwertzuiopasdfghjklyxcg59");
TextDrawLetterSize(AmongUsMessage1[0], 0.245001, 1.335852);
TextDrawAlignment(AmongUsMessage1[0], 1);
TextDrawColor(AmongUsMessage1[0], 255);
TextDrawSetShadow(AmongUsMessage1[0], 0);
TextDrawBackgroundColor(AmongUsMessage1[0], 255);
TextDrawFont(AmongUsMessage1[0], 1);
TextDrawSetProportional(AmongUsMessage1[0], 1);

AmongUsMessage1[1] = TextDrawCreate(175.533584, 127.529640, "123456789qwertzuiopasdfg");
TextDrawLetterSize(AmongUsMessage1[1], 0.227001, 1.301704);
TextDrawAlignment(AmongUsMessage1[1], 1);
TextDrawColor(AmongUsMessage1[1], 255);
TextDrawSetShadow(AmongUsMessage1[1], 0);
TextDrawBackgroundColor(AmongUsMessage1[1], 255);
TextDrawFont(AmongUsMessage1[1], 1);
TextDrawSetProportional(AmongUsMessage1[1], 1);

AmongUsMessage2[2] = TextDrawCreate(172.999984, 164.822631, "LD_SPAC:white");//nachricht 2
TextDrawTextSize(AmongUsMessage2[2], 108.219093, 24.000000);
TextDrawAlignment(AmongUsMessage2[2], 1);
TextDrawColor(AmongUsMessage2[2], -1);
TextDrawSetShadow(AmongUsMessage2[2], 0);
TextDrawBackgroundColor(AmongUsMessage2[2], 255);
TextDrawFont(AmongUsMessage2[2], 4);
TextDrawSetProportional(AmongUsMessage2[2], 0);

AmongUsMessage2[3] = TextDrawCreate(172.999984, 175.422332, "LD_SPAC:white");
TextDrawTextSize(AmongUsMessage2[3], 263.000000, 24.000000);
TextDrawAlignment(AmongUsMessage2[3], 1);
TextDrawColor(AmongUsMessage2[3], -1);
TextDrawSetShadow(AmongUsMessage2[3], 0);
TextDrawBackgroundColor(AmongUsMessage2[3], 255);
TextDrawFont(AmongUsMessage2[3], 4);
TextDrawSetProportional(AmongUsMessage2[3], 0);

AmongUsMessage2[0] = TextDrawCreate(175.133544, 179.414978, "123456789qwertzuiopasdfhjklyxcvbnmqwertzuiopasdfghjklyxcg59");
TextDrawLetterSize(AmongUsMessage2[0], 0.245001, 1.335852);
TextDrawAlignment(AmongUsMessage2[0], 1);
TextDrawColor(AmongUsMessage2[0], 255);
TextDrawSetShadow(AmongUsMessage2[0], 0);
TextDrawBackgroundColor(AmongUsMessage2[0], 255);
TextDrawFont(AmongUsMessage2[0], 1);
TextDrawSetProportional(AmongUsMessage2[0], 1);

AmongUsMessage2[1] = TextDrawCreate(175.533584, 164.529640, "123456789qwertzuiopasdfg");
TextDrawLetterSize(AmongUsMessage2[1], 0.227001, 1.301704);
TextDrawAlignment(AmongUsMessage2[1], 1);
TextDrawColor(AmongUsMessage2[1], 255);
TextDrawSetShadow(AmongUsMessage2[1], 0);
TextDrawBackgroundColor(AmongUsMessage2[1], 255);
TextDrawFont(AmongUsMessage2[1], 1);
TextDrawSetProportional(AmongUsMessage2[1], 1);

AmongUsMessage3[2] = TextDrawCreate(172.999984, 201.822631, "LD_SPAC:white");//nachricht 3
TextDrawTextSize(AmongUsMessage3[2], 108.219093, 24.000000);
TextDrawAlignment(AmongUsMessage3[2], 1);
TextDrawColor(AmongUsMessage3[2], -1);
TextDrawSetShadow(AmongUsMessage3[2], 0);
TextDrawBackgroundColor(AmongUsMessage3[2], 255);
TextDrawFont(AmongUsMessage3[2], 4);
TextDrawSetProportional(AmongUsMessage3[2], 0);

AmongUsMessage3[3] = TextDrawCreate(172.999984, 212.422332, "LD_SPAC:white");
TextDrawTextSize(AmongUsMessage3[3], 263.000000, 24.000000);
TextDrawAlignment(AmongUsMessage3[3], 1);
TextDrawColor(AmongUsMessage3[3], -1);
TextDrawSetShadow(AmongUsMessage3[3], 0);
TextDrawBackgroundColor(AmongUsMessage3[3], 255);
TextDrawFont(AmongUsMessage3[3], 4);
TextDrawSetProportional(AmongUsMessage3[3], 0);

AmongUsMessage3[0] = TextDrawCreate(175.133544, 216.414978, "Help");
TextDrawLetterSize(AmongUsMessage3[0], 0.245001, 1.335852);
TextDrawAlignment(AmongUsMessage3[0], 1);
TextDrawColor(AmongUsMessage3[0], 255);
TextDrawSetShadow(AmongUsMessage3[0], 0);
TextDrawBackgroundColor(AmongUsMessage3[0], 255);
TextDrawFont(AmongUsMessage3[0], 1);
TextDrawSetProportional(AmongUsMessage3[0], 1);

AmongUsMessage3[1] = TextDrawCreate(175.533584, 201.529640, "123456789qwertzuiopasdfg");
TextDrawLetterSize(AmongUsMessage3[1], 0.227001, 1.301704);
TextDrawAlignment(AmongUsMessage3[1], 1);
TextDrawColor(AmongUsMessage3[1], 255);
TextDrawSetShadow(AmongUsMessage3[1], 0);
TextDrawBackgroundColor(AmongUsMessage3[1], 255);
TextDrawFont(AmongUsMessage3[1], 1);
TextDrawSetProportional(AmongUsMessage3[1], 1);

AmongUsMessage4[2] = TextDrawCreate(172.999984, 238.822631, "LD_SPAC:white");//nachricht 4
TextDrawTextSize(AmongUsMessage4[2], 108.219093, 24.000000);
TextDrawAlignment(AmongUsMessage4[2], 1);
TextDrawColor(AmongUsMessage4[2], -1);
TextDrawSetShadow(AmongUsMessage4[2], 0);
TextDrawBackgroundColor(AmongUsMessage4[2], 255);
TextDrawFont(AmongUsMessage4[2], 4);
TextDrawSetProportional(AmongUsMessage4[2], 0);

AmongUsMessage4[3] = TextDrawCreate(172.999984, 249.422332, "LD_SPAC:white");
TextDrawTextSize(AmongUsMessage4[3], 263.000000, 24.000000);
TextDrawAlignment(AmongUsMessage4[3], 1);
TextDrawColor(AmongUsMessage4[3], -1);
TextDrawSetShadow(AmongUsMessage4[3], 0);
TextDrawBackgroundColor(AmongUsMessage4[3], 255);
TextDrawFont(AmongUsMessage4[3], 4);
TextDrawSetProportional(AmongUsMessage4[3], 0);

AmongUsMessage4[0] = TextDrawCreate(175.133544, 253.414978, "123456789qwertzuiopasdfhjklyxcvbnmqwertzuiopasdfghjklyxcg59");
TextDrawLetterSize(AmongUsMessage4[0], 0.245001, 1.335852);
TextDrawAlignment(AmongUsMessage4[0], 1);
TextDrawColor(AmongUsMessage4[0], 255);
TextDrawSetShadow(AmongUsMessage4[0], 0);
TextDrawBackgroundColor(AmongUsMessage4[0], 255);
TextDrawFont(AmongUsMessage4[0], 1);
TextDrawSetProportional(AmongUsMessage4[0], 1);

AmongUsMessage4[1] = TextDrawCreate(175.533584, 238.529640, "123456789qwertzuiopasdfg");
TextDrawLetterSize(AmongUsMessage4[1], 0.227001, 1.301704);
TextDrawAlignment(AmongUsMessage4[1], 1);
TextDrawColor(AmongUsMessage4[1], 255);
TextDrawSetShadow(AmongUsMessage4[1], 0);
TextDrawBackgroundColor(AmongUsMessage4[1], 255);
TextDrawFont(AmongUsMessage4[1], 1);
TextDrawSetProportional(AmongUsMessage4[1], 1);

AmongUsMessage5[2] = TextDrawCreate(172.999984, 275.822631, "LD_SPAC:white");//nachricht 5
TextDrawTextSize(AmongUsMessage5[2], 108.219093, 24.000000);
TextDrawAlignment(AmongUsMessage5[2], 1);
TextDrawColor(AmongUsMessage5[2], -1);
TextDrawSetShadow(AmongUsMessage5[2], 0);
TextDrawBackgroundColor(AmongUsMessage5[2], 255);
TextDrawFont(AmongUsMessage5[2], 4);
TextDrawSetProportional(AmongUsMessage5[2], 0);

AmongUsMessage5[3] = TextDrawCreate(172.999984, 286.422332, "LD_SPAC:white");
TextDrawTextSize(AmongUsMessage5[3], 263.000000, 24.000000);
TextDrawAlignment(AmongUsMessage5[3], 1);
TextDrawColor(AmongUsMessage5[3], -1);
TextDrawSetShadow(AmongUsMessage5[3], 0);
TextDrawBackgroundColor(AmongUsMessage5[3], 255);
TextDrawFont(AmongUsMessage5[3], 4);
TextDrawSetProportional(AmongUsMessage5[3], 0);

AmongUsMessage5[0] = TextDrawCreate(175.133544, 290.414978, "123456789qwertzuiopasdfhjklyxcvbnmqwertzuiopasdfghjklyxcg59");
TextDrawLetterSize(AmongUsMessage5[0], 0.245001, 1.335852);
TextDrawAlignment(AmongUsMessage5[0], 1);
TextDrawColor(AmongUsMessage5[0], 255);
TextDrawSetShadow(AmongUsMessage5[0], 0);
TextDrawBackgroundColor(AmongUsMessage5[0], 255);
TextDrawFont(AmongUsMessage5[0], 1);
TextDrawSetProportional(AmongUsMessage5[0], 1);

AmongUsMessage5[1] = TextDrawCreate(175.533584, 275.529640, "123456789qwertzuiopasdfg");
TextDrawLetterSize(AmongUsMessage5[1], 0.227001, 1.301704);
TextDrawAlignment(AmongUsMessage5[1], 1);
TextDrawColor(AmongUsMessage5[1], 255);
TextDrawSetShadow(AmongUsMessage5[1], 0);
TextDrawBackgroundColor(AmongUsMessage5[1], 255);
TextDrawFont(AmongUsMessage5[1], 1);
TextDrawSetProportional(AmongUsMessage5[1], 1);

AmongUsVotePlayer[0] = TextDrawCreate(178.999938, 132.185119, "LD_SPAC:white");
TextDrawTextSize(AmongUsVotePlayer[0], 114.000000, 44.000000);
TextDrawAlignment(AmongUsVotePlayer[0], 1);
TextDrawColor(AmongUsVotePlayer[0], 0x000000FF);
TextDrawSetShadow(AmongUsVotePlayer[0], 0);
TextDrawBackgroundColor(AmongUsVotePlayer[0], 255);
TextDrawFont(AmongUsVotePlayer[0], 4);
TextDrawSetSelectable(AmongUsVotePlayer[0], 1);

AmongUsVotePlayer[6] = TextDrawCreate(235.933349, 132.325958, "name");// 235,933349 - 178,999938 = +56,933411
																						   // 132,325958 - 132,185119 = +0,140839
TextDrawLetterSize(AmongUsVotePlayer[6], 0.256999, 1.305480);
TextDrawAlignment(AmongUsVotePlayer[6], 2);
TextDrawColor(AmongUsVotePlayer[6], -1);
TextDrawSetShadow(AmongUsVotePlayer[6], 0);
TextDrawBackgroundColor(AmongUsVotePlayer[6], 255);
TextDrawFont(AmongUsVotePlayer[6], 1);
TextDrawSetProportional(AmongUsVotePlayer[6], 1);

AmongUsVotePlayer[7] = TextDrawCreate(182.600006, 142.200073, ".....");// 182,600006 - 178,999938 = +3,60012
																		// 142,200073 - 132,185119 = +10,014954
TextDrawLetterSize(AmongUsVotePlayer[7], 0.355998, 2.205479);
TextDrawAlignment(AmongUsVotePlayer[7], 1);
TextDrawColor(AmongUsVotePlayer[7], -1);
TextDrawSetShadow(AmongUsVotePlayer[7], 0);
TextDrawBackgroundColor(AmongUsVotePlayer[7], 255);
TextDrawFont(AmongUsVotePlayer[7], 1);
TextDrawSetProportional(AmongUsVotePlayer[7], 1);

AmongUsVotePlayer[1] = TextDrawCreate(314.700103, 132.185119, "LD_SPAC:white");
TextDrawTextSize(AmongUsVotePlayer[1], 114.000000, 44.000000);
TextDrawAlignment(AmongUsVotePlayer[1], 1);
TextDrawColor(AmongUsVotePlayer[1], 0xFF0000FF);
TextDrawSetShadow(AmongUsVotePlayer[1], 0);
TextDrawBackgroundColor(AmongUsVotePlayer[1], 255);
TextDrawFont(AmongUsVotePlayer[1], 4);
TextDrawSetSelectable(AmongUsVotePlayer[1], 1);

AmongUsVotePlayer[8] = TextDrawCreate(312.700130+56.933411, 132.185119+0.140839, "name");//+56,933411  //+0,140839
TextDrawLetterSize(AmongUsVotePlayer[8], 0.256999, 1.305480);
TextDrawAlignment(AmongUsVotePlayer[8], 2);
TextDrawColor(AmongUsVotePlayer[8], 255);
TextDrawSetShadow(AmongUsVotePlayer[8], 0);
TextDrawBackgroundColor(AmongUsVotePlayer[8], 255);
TextDrawFont(AmongUsVotePlayer[8], 1);
TextDrawSetProportional(AmongUsVotePlayer[8], 1);

AmongUsVotePlayer[9] = TextDrawCreate(312.700130+3.60012, 132.185119+10.514954, ".....");//+3,60012 	// +10,014954
TextDrawLetterSize(AmongUsVotePlayer[9], 0.355998, 2.205479);
TextDrawAlignment(AmongUsVotePlayer[9], 1);
TextDrawColor(AmongUsVotePlayer[9], 255);
TextDrawSetShadow(AmongUsVotePlayer[9], 0);
TextDrawBackgroundColor(AmongUsVotePlayer[9], 255);
TextDrawFont(AmongUsVotePlayer[9], 1);
TextDrawSetProportional(AmongUsVotePlayer[9], 1);

AmongUsVotePlayer[2] = TextDrawCreate(178.999938, 194.185119, "LD_SPAC:white");
TextDrawTextSize(AmongUsVotePlayer[2], 114.000000, 44.000000);
TextDrawAlignment(AmongUsVotePlayer[2], 1);
TextDrawColor(AmongUsVotePlayer[2], 0x00FF00FF);
TextDrawSetShadow(AmongUsVotePlayer[2], 0);
TextDrawBackgroundColor(AmongUsVotePlayer[2], 255);
TextDrawFont(AmongUsVotePlayer[2], 4);
TextDrawSetSelectable(AmongUsVotePlayer[2], 1);

AmongUsVotePlayer[10] = TextDrawCreate(178.999938+53.933411, 194.185119+0.140839, "name");//+56,933411  //+0,140839
TextDrawLetterSize(AmongUsVotePlayer[10], 0.256999, 1.305480);
TextDrawAlignment(AmongUsVotePlayer[10], 2);
TextDrawColor(AmongUsVotePlayer[10], 255);
TextDrawSetShadow(AmongUsVotePlayer[10], 0);
TextDrawBackgroundColor(AmongUsVotePlayer[10], 255);
TextDrawFont(AmongUsVotePlayer[10], 1);
TextDrawSetProportional(AmongUsVotePlayer[10], 1);

AmongUsVotePlayer[11] = TextDrawCreate(178.999938+3.60012, 194.185119+10.014954, ".....");//+3,60012 	// +10,014954
TextDrawLetterSize(AmongUsVotePlayer[11], 0.355998, 2.205479);
TextDrawAlignment(AmongUsVotePlayer[11], 1);
TextDrawColor(AmongUsVotePlayer[11], 255);
TextDrawSetShadow(AmongUsVotePlayer[11], 0);
TextDrawBackgroundColor(AmongUsVotePlayer[11], 255);
TextDrawFont(AmongUsVotePlayer[11], 1);
TextDrawSetProportional(AmongUsVotePlayer[11], 1);

AmongUsVotePlayer[3] = TextDrawCreate(314.700103, 194.185119, "LD_SPAC:white");
TextDrawTextSize(AmongUsVotePlayer[3], 114.000000, 44.000000);
TextDrawAlignment(AmongUsVotePlayer[3], 1);
TextDrawColor(AmongUsVotePlayer[3], 0x0000FFFF);
TextDrawSetShadow(AmongUsVotePlayer[3], 0);
TextDrawBackgroundColor(AmongUsVotePlayer[3], 255);
TextDrawFont(AmongUsVotePlayer[3], 4);
TextDrawSetSelectable(AmongUsVotePlayer[3], 1);

AmongUsVotePlayer[12] = TextDrawCreate(314.700103+56.933411, 194.185119+0.140839, "name");//+56,933411  //+0,140839
TextDrawLetterSize(AmongUsVotePlayer[12], 0.256999, 1.305480);
TextDrawAlignment(AmongUsVotePlayer[12], 2);
TextDrawColor(AmongUsVotePlayer[12], 255);
TextDrawSetShadow(AmongUsVotePlayer[12], 0);
TextDrawBackgroundColor(AmongUsVotePlayer[12], 255);
TextDrawFont(AmongUsVotePlayer[12], 1);
TextDrawSetProportional(AmongUsVotePlayer[12], 1);

AmongUsVotePlayer[13] = TextDrawCreate(314.700103+3.60012, 194.185119+10.514954, ".....");//+3,60012 	// +10,014954
TextDrawLetterSize(AmongUsVotePlayer[13], 0.355998, 2.205479);
TextDrawAlignment(AmongUsVotePlayer[13], 1);
TextDrawColor(AmongUsVotePlayer[13], 255);
TextDrawSetShadow(AmongUsVotePlayer[13], 0);
TextDrawBackgroundColor(AmongUsVotePlayer[13], 255);
TextDrawFont(AmongUsVotePlayer[13], 1);
TextDrawSetProportional(AmongUsVotePlayer[13], 1);

AmongUsVotePlayer[4] = TextDrawCreate(178.999938, 256.185119, "LD_SPAC:white");
TextDrawTextSize(AmongUsVotePlayer[4], 114.000000, 44.000000);
TextDrawAlignment(AmongUsVotePlayer[4], 1);
TextDrawColor(AmongUsVotePlayer[4], 0xFFFFFFFF);
TextDrawSetShadow(AmongUsVotePlayer[4], 0);
TextDrawBackgroundColor(AmongUsVotePlayer[4], 255);
TextDrawFont(AmongUsVotePlayer[4], 4);
TextDrawSetSelectable(AmongUsVotePlayer[4], 1);

AmongUsVotePlayer[14] = TextDrawCreate(178.999938+53.933411, 256.185119+0.140839, "name");//+56,933411  //+0,140839
TextDrawLetterSize(AmongUsVotePlayer[14], 0.256999, 1.305480);
TextDrawAlignment(AmongUsVotePlayer[14], 2);
TextDrawColor(AmongUsVotePlayer[14], 255);
TextDrawSetShadow(AmongUsVotePlayer[14], 0);
TextDrawBackgroundColor(AmongUsVotePlayer[14], 255);
TextDrawFont(AmongUsVotePlayer[14], 1);
TextDrawSetProportional(AmongUsVotePlayer[14], 1);

AmongUsVotePlayer[15] = TextDrawCreate(178.999938+3.60012, 256.185119+10.014954, ".....");//+3,60012 	// +10,014954
TextDrawLetterSize(AmongUsVotePlayer[15], 0.355998, 2.205479);
TextDrawAlignment(AmongUsVotePlayer[15], 1);
TextDrawColor(AmongUsVotePlayer[15], 255);
TextDrawSetShadow(AmongUsVotePlayer[15], 0);
TextDrawBackgroundColor(AmongUsVotePlayer[15], 255);
TextDrawFont(AmongUsVotePlayer[15], 1);
TextDrawSetProportional(AmongUsVotePlayer[15], 1);

AmongUsVotePlayer[5] = TextDrawCreate(314.700103, 257.185119, "LD_SPAC:white");
TextDrawTextSize(AmongUsVotePlayer[5], 114.000000, 44.000000);
TextDrawAlignment(AmongUsVotePlayer[5], 1);
TextDrawColor(AmongUsVotePlayer[5], 0xFFFF00FF);
TextDrawSetShadow(AmongUsVotePlayer[5], 0);
TextDrawBackgroundColor(AmongUsVotePlayer[5], 255);
TextDrawFont(AmongUsVotePlayer[5], 4);
TextDrawSetSelectable(AmongUsVotePlayer[5], 1);

AmongUsVotePlayer[16] = TextDrawCreate(314.700103+56.933411, 257.185119+0.140839, "name");//+56,933411  //+0,140839
TextDrawLetterSize(AmongUsVotePlayer[16], 0.256999, 1.305480);
TextDrawAlignment(AmongUsVotePlayer[16], 2);
TextDrawColor(AmongUsVotePlayer[16], 255);
TextDrawSetShadow(AmongUsVotePlayer[16], 0);
TextDrawBackgroundColor(AmongUsVotePlayer[16], 255);
TextDrawFont(AmongUsVotePlayer[16], 1);
TextDrawSetProportional(AmongUsVotePlayer[16], 1);

AmongUsVotePlayer[17] = TextDrawCreate(314.700103+3.60012, 257.185119+10.514954, ".....");//+3,60012 	// +10,014954
TextDrawLetterSize(AmongUsVotePlayer[17], 0.355998, 2.205479);
TextDrawAlignment(AmongUsVotePlayer[17], 1);
TextDrawColor(AmongUsVotePlayer[17], 255);
TextDrawSetShadow(AmongUsVotePlayer[17], 0);
TextDrawBackgroundColor(AmongUsVotePlayer[17], 255);
TextDrawFont(AmongUsVotePlayer[17], 1);
TextDrawSetProportional(AmongUsVotePlayer[17], 1);

return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(newkeys == KEY_WALK && IsPlayerInRangeOfPoint(playerid,3.0, 1912.6364,1469.3225,1094.5245))
	{
	    if(sprayers == false)
	    {
		    sprayers = true;
		    SendClientMessage(playerid, Hellblau,"ShipAI: Cooling systems have been shut down!");
		    for(new s = 0; s < 8; s++)
		    {
		        if(!IsValidDynamicObject(sprayer[s]))
        		continue;
        		new Float:zpos;
        		Streamer_GetFloatData(0,sprayer[s], E_STREAMER_Z, zpos);
				Streamer_SetFloatData(0,sprayer[s], E_STREAMER_Z,zpos+500);
		    }
	    }
	    else
	    {
	        sprayers = false;
	        SendClientMessage(playerid, Hellblau,"ShipAI: Cooling systems have been started up!");
		    for(new s = 0; s < 8; s++)
		    {
		        if(!IsValidDynamicObject(sprayer[s]))
        		continue;
				new Float:zpos;
        		Streamer_GetFloatData(0,sprayer[s], E_STREAMER_Z, zpos);
				Streamer_SetFloatData(0,sprayer[s], E_STREAMER_Z,zpos-500);
		    }
	    }
	}
	if(newkeys == KEY_WALK && IsPlayerInRangeOfPoint(playerid,2.0, 1885.3696,1472.4377,1094.5964))
	{
	    if(!generator)
	    {
	        generator = true;
	        SetDynamicObjectMaterial(button[0] , 0, 10101, "2notherbuildsfe", "ferry_build14", 0xFFFF0000);
	        SendClientMessage(playerid, Hellblau,"ShipAI: Gravity generator has been shut down!");
	    }
	    else
	    {
	        generator = false;
	        SetDynamicObjectMaterial(button[0] , 0, 10101, "2notherbuildsfe", "ferry_build14", 0xFF00FF00);
	        SendClientMessage(playerid, Hellblau,"ShipAI: Gravity generator has been started up!");
	    }
	}
	if(newkeys == KEY_WALK && IsPlayerInRangeOfPoint(playerid,3.0, 1958.0406,1419.5519,1094.4092))
	{
	    new string[70];
	    if(AmongUsGameState <= RESETAUPLAYERS) return 1;
		if((gettime() - AmongUsMeetingCoolDown) > AmongUsMeetingCooldownTime)
		{
		   AmongUsMeetingTime = 301;
		   format(string, sizeof string, "%s has started a meeting", GetSname(playerid));
	       SendClientMessage(AmongUsPlayer[0], Weis, string);
	       SendClientMessage(AmongUsPlayer[1], Weis, string);
	       SendClientMessage(AmongUsPlayer[2], Weis, string);
	       SendClientMessage(AmongUsPlayer[3], Weis, string);
	       SendClientMessage(AmongUsPlayer[4], Weis, string);
	       SendClientMessage(AmongUsPlayer[5], Weis, string);
	       for(new AmongUsplayerid = 0; AmongUsplayerid < 6; AmongUsplayerid++)
	       {
		      TextDrawShowForPlayer(AmongUsplayerid, AmongUsTablet[0]);
		      TextDrawShowForPlayer(AmongUsplayerid, AmongUsTablet[1]);
		      TextDrawShowForPlayer(AmongUsplayerid, AmongUsTablet[2]);
		      TextDrawShowForPlayer(AmongUsplayerid, AmongUsTablet[3]);
		      TextDrawShowForPlayer(AmongUsplayerid, AmongUsTablet[4]);
		      TextDrawShowForPlayer(AmongUsplayerid, AmongUsTablet[5]);
		      TextDrawShowForPlayer(AmongUsplayerid, AmongUsBildschirm);
		      TextDrawShowForPlayer(AmongUsplayerid, AmongUsHomeButton);
		      TextDrawShowForPlayer(AmongUsplayerid, AmongUsMessage1[0]);
		      TextDrawShowForPlayer(AmongUsplayerid, AmongUsMessage1[1]);
		      TextDrawShowForPlayer(AmongUsplayerid, AmongUsMessage1[2]);
		      TextDrawShowForPlayer(AmongUsplayerid, AmongUsMessage1[3]);
		      TextDrawShowForPlayer(AmongUsplayerid, AmongUsMessage2[0]);
		      TextDrawShowForPlayer(AmongUsplayerid, AmongUsMessage2[1]);
		      TextDrawShowForPlayer(AmongUsplayerid, AmongUsMessage2[2]);
		      TextDrawShowForPlayer(AmongUsplayerid, AmongUsMessage2[3]);
		      TextDrawShowForPlayer(AmongUsplayerid, AmongUsMessage3[0]);
		      TextDrawShowForPlayer(AmongUsplayerid, AmongUsMessage3[1]);
		      TextDrawShowForPlayer(AmongUsplayerid, AmongUsMessage3[2]);
		      TextDrawShowForPlayer(AmongUsplayerid, AmongUsMessage3[3]);
		      TextDrawShowForPlayer(AmongUsplayerid, AmongUsMessage4[0]);
		      TextDrawShowForPlayer(AmongUsplayerid, AmongUsMessage4[1]);
		      TextDrawShowForPlayer(AmongUsplayerid, AmongUsMessage4[2]);
		      TextDrawShowForPlayer(AmongUsplayerid, AmongUsMessage4[3]);
		      TextDrawShowForPlayer(AmongUsplayerid, AmongUsMessage5[0]);
		      TextDrawShowForPlayer(AmongUsplayerid, AmongUsMessage5[1]);
		      TextDrawShowForPlayer(AmongUsplayerid, AmongUsMessage5[2]);
		      TextDrawShowForPlayer(AmongUsplayerid, AmongUsMessage5[3]);
		   }
		   AmongUsMessage2Text = "";
		   AmongUsMessage2Name = "";
		   AmongUsMessage3Text = "";
		   AmongUsMessage3Name = "";
		   AmongUsMessage4Text = "";
		   AmongUsMessage4Name = "";
		   AmongUsMessage5Text = "";
		   AmongUsMessage5Name = "";
		   TextDrawSetString(AmongUsMessage1[0], "");
		   TextDrawSetString(AmongUsMessage1[1], "");
		   TextDrawSetString(AmongUsMessage2[0], "");
		   TextDrawSetString(AmongUsMessage2[1], "");
		   TextDrawSetString(AmongUsMessage3[0], "");
		   TextDrawSetString(AmongUsMessage3[1], "");
		   TextDrawSetString(AmongUsMessage4[0], "");
		   TextDrawSetString(AmongUsMessage4[1], "");
		   TextDrawSetString(AmongUsMessage5[0], "");
		   TextDrawSetString(AmongUsMessage5[1], "");

	       //AmongUsPlayer[0] = CreateActor(13, 0,0,0);
	       /*AmongUsPlayer[1] = CreateActor(13, 0,0,0,0);
	       AmongUsPlayer[2] = CreateActor(13, 0,0,0,0);
	       AmongUsPlayer[3] = CreateActor(13, 0,0,0,0);
	       AmongUsPlayer[4] = CreateActor(13, 0,0,0,0);
	       AmongUsPlayer[5] = CreateActor(13, 0,0,0,0);*/

	       SetPlayerPos(AmongUsPlayer[0], 1955.8754,1417.5018,1094.4299);
	       SetPlayerFacingAngle(AmongUsPlayer[0], 313.6150);
	       SetCameraBehindPlayer(AmongUsPlayer[0]);
	       
	       SetPlayerPos(AmongUsPlayer[1], 1958.7141,1416.2363,1094.4299);
	       SetPlayerFacingAngle(AmongUsPlayer[1], 7.5089);
	       SetCameraBehindPlayer(AmongUsPlayer[1]);

	       SetPlayerPos(AmongUsPlayer[2], 1961.2396,1417.9348,1094.4299);
	       SetPlayerFacingAngle(AmongUsPlayer[2], 58.2694);
	       SetCameraBehindPlayer(AmongUsPlayer[2]);

	       SetPlayerPos(AmongUsPlayer[3], 1961.4630,1421.6072,1094.4299);
	       SetPlayerFacingAngle(AmongUsPlayer[3], 130.0234);
	       SetCameraBehindPlayer(AmongUsPlayer[3]);

	       SetPlayerPos(AmongUsPlayer[4], 1958.2216,1423.1997,1094.4299);
	       SetPlayerFacingAngle(AmongUsPlayer[4], 174.5171);
	       SetCameraBehindPlayer(AmongUsPlayer[4]);

	       SetPlayerPos(AmongUsPlayer[5], 1955.6514,1421.6895,1094.4299);
	       SetPlayerFacingAngle(AmongUsPlayer[5], 231.8576);
	       SetCameraBehindPlayer(AmongUsPlayer[5]);

	       TogglePlayerControllable(AmongUsPlayer[0], 0);
	       TogglePlayerControllable(AmongUsPlayer[1], 0);
	       TogglePlayerControllable(AmongUsPlayer[2], 0);
	       TogglePlayerControllable(AmongUsPlayer[3], 0);
	       TogglePlayerControllable(AmongUsPlayer[4], 0);
	       TogglePlayerControllable(AmongUsPlayer[5], 0);
	       AmongUsGameState = AUMEETING;
		}
		else
		{
		   format(string, sizeof string, "You have to wait %i seconds to start a new emergency meeting", AmongUsMeetingCooldownTime - (gettime() - AmongUsMeetingCoolDown) +1);
		   SendClientMessage(playerid, Hellrot, string);
		}
	}
	return 1;
}

forward AmongUsGameReset();
public AmongUsGameReset()
{
    AmongUsMeetingCoolDown = 0;
    AmongUsImposterCoolDown = 0;
	AmongUsGameState = 0;
	AmongUsImposter[0] = -1;
	AmongUsImposter[1] = -1;
	AmongUsPlayer[0] = -1;
	AmongUsPlayer[1] = -1;
	AmongUsPlayer[2] = -1;
	AmongUsPlayer[3] = -1;
	AmongUsPlayer[4] = -1;
	AmongUsPlayer[5] = -1;
	AmongUsMessage2Text = "";
	AmongUsMessage3Text = "";
	AmongUsMessage4Text = "";
	AmongUsMessage5Text = "";
	SendClientMessageToAll(Hellblau, "The minigame 'Between them' just restarted! Make sure to join the game! /minigames");
	return 0;
}

stock IsPlayerPlayingMinigame(playerid, minigameid)
{
   if(minigameid == 1)
   {
      for(new i=0; i < 6; i++){
      if(AmongUsPlayer[i] == playerid) return 1;}
   }
   return 0;
}

public OnPlayerText(playerid, text[])
{
	new message[256+1];
	new	idx;
    if(AmongUsGameState >= WAITFORAUPLAYERS && IsPlayerPlayingMinigame(playerid, 1))
	{
	   message = strrest(text, idx);
	   if(strlen(message) >= 56)
	   {
	      SendClientMessage(playerid, Hellrot, "Not more then 55 letters!");
	      return 0;
	   }
	   if(!strcmp(message, "skip", true))
	   {
	     format(message, sizeof message, "%s sped up the meeting. Write 'skip' to speed it up.", GetSname(playerid));
	     AmongUsMeetingTime = AmongUsMeetingTime - 50;
	   }
	   message[256] = strtrim(message);
	   TextDrawSetString(AmongUsMessage5[0], message);
	   TextDrawSetString(AmongUsMessage5[1], GetSname(playerid));
	   TextDrawSetString(AmongUsMessage4[1], AmongUsMessage5Name);
	   TextDrawSetString(AmongUsMessage3[1], AmongUsMessage4Name);
	   TextDrawSetString(AmongUsMessage2[1], AmongUsMessage3Name);
	   TextDrawSetString(AmongUsMessage1[1], AmongUsMessage2Name);
	   TextDrawSetString(AmongUsMessage4[0], AmongUsMessage5Text);
	   TextDrawSetString(AmongUsMessage3[0], AmongUsMessage4Text);
	   TextDrawSetString(AmongUsMessage2[0], AmongUsMessage3Text);
	   TextDrawSetString(AmongUsMessage1[0], AmongUsMessage2Text);
	   AmongUsMessage2Text = AmongUsMessage3Text;
	   AmongUsMessage2Name = AmongUsMessage3Name;
	   AmongUsMessage3Text = AmongUsMessage4Text;
	   AmongUsMessage3Name = AmongUsMessage4Name;
	   AmongUsMessage4Text = AmongUsMessage5Text;
	   AmongUsMessage4Name = AmongUsMessage5Name;
	   AmongUsMessage5Text = message;
	   AmongUsMessage5Name = GetSname(playerid);
	   return 0;
	}
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	if (strcmp("/minigames", cmdtext, true, 10) == 0)
	{
		new string[150];
		format(string, sizeof(string), "Between them \t%s \nRolling Ball \t%s", (AmongUsGameState <= RESETAUPLAYERS) ? ("{00FF00}Join Now!") : ("{FF0000}Already Started"),
		(/*RollingBallGameState*/ AmongUsGameState != WAITFORAUPLAYERS) ? ("{00FF00}Join Now!") : ("{FF0000}Already Started"));
		ShowPlayerDialog(playerid, MINIGAMEDIALOG, DIALOG_STYLE_TABLIST, "What minigame do you want to play?", string, "Okay", "Exit");
		return 1;
	}
	if (strcmp("/reset", cmdtext, true, 10) == 0)
	{
		AmongUsGameReset();
		return 1;
	}
	return 0;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
   if(dialogid == MINIGAMEDIALOG)
   {
      if(listitem == 0)
      {
	     new string[50];
	     format(string, sizeof string, "Minigame already started! %i", AmongUsGameState);
		 if(AmongUsGameState > WAITFORAUPLAYERS) return SendClientMessage(playerid, Hellrot, string);
		 if(AmongUsPlayer[0] == -1 && AmongUsPlayer[1] != playerid && AmongUsPlayer[2] != playerid && AmongUsPlayer[3] != playerid && AmongUsPlayer[4]
		 != playerid && AmongUsPlayer[5] != playerid)
		 {
		    AmongUsPlayer[0] = playerid;
		    AmongUsPlayer[1] = 1;
		    AmongUsPlayer[2] = 2;
		    AmongUsPlayer[3] = 3;
		    AmongUsPlayer[4] = 4;
		    AmongUsPlayer[5] = 5; //hier
		    AmongusObject[playerid] = SetPlayerAttachedObject(playerid, 0, 19559, 1, 0.000000, -0.051999, 0.000000, 0.000000, 88.600067, 0.000000, 1.000000, 1.000000, 1.000000, 0xFF000000, 0xFF000000);
			SetDynamicObjectMaterial(AmongusObject[playerid], 0, 10101, "2notherbuildsfe", "ferry_build14", 0xFF000000);//hier textur wird nicht angenommen
		    DebugMessage(playerid, "You are Amongus player #1");
		    AmongUsGameState = WAITFORAUPLAYERS;
	        SetPlayerPos(AmongUsPlayer[0], 1955.8754,1417.5018,1096);
	        SetPlayerFacingAngle(AmongUsPlayer[0], 313.6150);
	        SetCameraBehindPlayer(AmongUsPlayer[0]);
		    return 1;
		 }
		 else if(AmongUsPlayer[1] == -1 && AmongUsPlayer[0] != playerid && AmongUsPlayer[2] != playerid && AmongUsPlayer[3] != playerid && AmongUsPlayer[4]
		 != playerid && AmongUsPlayer[5] != playerid)
		 {
		    AmongUsPlayer[1] = playerid;
		    AmongusObject[playerid] = SetPlayerAttachedObject(playerid, 0, 19559, 1, 0.000000, -0.051999, 0.000000, 0.000000, 88.600067, 0.000000, 1.000000, 1.000000, 1.000000, 0xFFFF0000, 0xFFFF0000);
			SetDynamicObjectMaterial(AmongusObject[playerid], 0, 10101, "2notherbuildsfe", "ferry_build14", 0xFFFF0000);
		    DebugMessage(playerid, "You are Amongus player #2");
		    AmongUsGameState = WAITFORAUPLAYERS;
	        SetPlayerPos(AmongUsPlayer[1], 1958.7141,1416.2363,1096);
	        SetPlayerFacingAngle(AmongUsPlayer[1], 7.5089);
	        SetCameraBehindPlayer(AmongUsPlayer[1]);
		    return 1;
		 }
		 else if(AmongUsPlayer[2] == -1 && AmongUsPlayer[1] != playerid && AmongUsPlayer[0] != playerid && AmongUsPlayer[3] != playerid && AmongUsPlayer[4]
		 != playerid && AmongUsPlayer[5] != playerid)
		 {
		    AmongUsPlayer[2] = playerid;
		    AmongusObject[playerid] = SetPlayerAttachedObject(playerid, 0, 19559, 1, 0.000000, -0.051999, 0.000000, 0.000000, 88.600067, 0.000000, 1.000000, 1.000000, 1.000000, 0xFF00FF00, 0xFF00FF00);
		    SetDynamicObjectMaterial(AmongusObject[playerid], 0, 10101, "2notherbuildsfe", "ferry_build14", 0xFF00FF00);
		    DebugMessage(playerid, "You are Amongus player #3");
	        SetPlayerPos(AmongUsPlayer[2], 1961.2396,1417.9348,1096);
	        SetPlayerFacingAngle(AmongUsPlayer[2], 58.2694);
	        SetCameraBehindPlayer(AmongUsPlayer[2]);
		    return 1;
		 }
		 else if(AmongUsPlayer[3] == -1 && AmongUsPlayer[1] != playerid && AmongUsPlayer[2] != playerid && AmongUsPlayer[0] != playerid && AmongUsPlayer[4]
		 != playerid && AmongUsPlayer[5] != playerid)
		 {
		    AmongUsPlayer[3] = playerid;
		    AmongusObject[playerid] = SetPlayerAttachedObject(playerid, 0, 19559, 1, 0.000000, -0.051999, 0.000000, 0.000000, 88.600067, 0.000000, 1.000000, 1.000000, 1.0000000, 0xFF0000FF, 0xFF0000FF);
		    SetDynamicObjectMaterial(AmongusObject[playerid], 0, 10101, "2notherbuildsfe", "ferry_build14", 0xFF0000FF);
		    DebugMessage(playerid, "You are Amongus player #4");
	        SetPlayerPos(AmongUsPlayer[3], 1961.4630,1421.6072,1096);
	        SetPlayerFacingAngle(AmongUsPlayer[3], 130.0234);
	        SetCameraBehindPlayer(AmongUsPlayer[3]);
		    return 1;
		 }
		 else if(AmongUsPlayer[4] == -1 && AmongUsPlayer[1] != playerid && AmongUsPlayer[2] != playerid && AmongUsPlayer[3] != playerid && AmongUsPlayer[0]
		 != playerid && AmongUsPlayer[5] != playerid)
		 {
		    AmongUsPlayer[4] = playerid;
		    AmongusObject[playerid] = SetPlayerAttachedObject(playerid, 0, 19559, 1, 0.000000, -0.051999, 0.000000, 0.000000, 88.600067, 0.000000, 1.000000, 1.000000, 1.000000, 0xFFFFFFFF, 0xFFFFFFFF);
		    SetDynamicObjectMaterial(AmongusObject[playerid], 0, 10101, "2notherbuildsfe", "ferry_build14", 0xFFFFFFFF);
		    DebugMessage(playerid, "You are Amongus player #5");
	        SetPlayerPos(AmongUsPlayer[4], 1958.2216,1423.1997,1096);
	        SetPlayerFacingAngle(AmongUsPlayer[4], 174.5171);
	        SetCameraBehindPlayer(AmongUsPlayer[4]);
		    return 1;
		 }
		 else if(AmongUsPlayer[5] == -1 && AmongUsPlayer[1] != playerid && AmongUsPlayer[2] != playerid && AmongUsPlayer[3] != playerid && AmongUsPlayer[4]
		 != playerid && AmongUsPlayer[0] != playerid)
		 {
		    AmongUsPlayer[5] = playerid;
		    AmongusObject[playerid] = SetPlayerAttachedObject(playerid, 0, 19559, 1, 0.000000, -0.051999, 0.000000, 0.000000, 88.600067, 0.000000, 1.000000, 1.000000, 1.000000, 0xFFFFFF00, 0xFFFFFF00);
		    SetDynamicObjectMaterial(AmongusObject[playerid], 0, 10101, "2notherbuildsfe", "ferry_build14", 0xFFFFFF00);
		    DebugMessage(playerid, "You are Amongus player #6");
	        SetPlayerPos(AmongUsPlayer[5], 1955.6514,1421.6895,1096);
	        SetPlayerFacingAngle(AmongUsPlayer[5], 231.8576);
	        SetCameraBehindPlayer(AmongUsPlayer[5]);
		    return 1;
		 }
		 else
		 {
		    SendWarningText(playerid, "Minigame is full!");
		 }
		 return 1;
	}
      if(listitem == 1)
      {
		 //if(RollingBallGameState == 1) return 1;
		 {
		 }
      }
   }
   return 1;
}

stock AmongUsDoorTimer(doorid);
public AmongUsDoorTimer(doorid)
{
   if (doorid == 1)
   {
	  MoveDynamicObject(spacedoorcockpit,1891.475708, 1468.520263, 1094.662475, 2.0);
	  door[0] = false;
	  return 1;
   }
   else if (doorid == 2)
   {
	  MoveDynamicObject(spacedoorstorage[0],1932.977539, 1468.580810, 1094.662475, 2.0);
	  door[1] = false;
	  return 1;
   }
   else if (doorid == 3)
   {
	  MoveDynamicObject(spacedoorstorage[1],1941.288085, 1468.580810, 1094.662475, 2.0);
	  door[2] = false;
	  return 1;
   }
   else if (doorid == 4)
   {
	  MoveDynamicObject(spacedoorcomputers,1901.193969, 1548.617309, 1094.670776, 2.0);
	  door[3] = false;
	  return 1;
   }
   else if (doorid == 5)
   {
	  MoveDynamicObject(spacedoorirgendwas[0],1936.728881, 1550.106201, 1094.670776, 2.0);
	  door[4] = false;
	  return 1;
   }
   else if (doorid == 6)
   {
	  MoveDynamicObject(spacedoorirgendwas[1],1978.324584, 1548.555908, 1094.670776, 2.0);
	  door[5] = false;
	  return 1;
   }
   else if (doorid == 7)
   {
	  MoveDynamicObject(spacedoorstorage[2],1979.896362, 1468.580810, 1094.662475, 2.0);
	  door[6] = false;
	  return 1;
   }
   else if (doorid == 8)
   {
	  MoveDynamicObject(spacedoorcenter[0],1915.586181, 1453.308959, 1094.662475, 2.0);
	  door[7] = false;
	  return 1;
   }
   else if (doorid == 9)
   {
	  MoveDynamicObject(spacedoorcenter[1],1915.586181, 1485.070922, 1094.662475, 2.0);
	  door[8] = false;
	  return 1;
   }
   else if (doorid == 10)
   {
	  MoveDynamicObject(spacedoormeeting[0],1939.611083, 1420.494262, 1094.670776, 2.0);
	  door[9] = false;
	  return 1;
   }
   else if (doorid == 11)
   {
	  MoveDynamicObject(spacedoormeeting[1],1981.206787, 1418.943969, 1094.670776, 2.0);
	  door[10] = false;
	  return 1;
   }
   else if (doorid == 12)
   {
	  MoveDynamicObject(spacedoorstorage[3],1988.865600, 1468.604614, 1094.670776, 2.0);
	  door[11] = false;
	  return 1;
   }
   else if (doorid == 13)
   {
	  MoveDynamicObject(spacedoorirgendwas[2],1956.841308, 1534.498657, 1094.670776, 2.0);
	  door[12] = false;
	  return 1;
   }
   else if (doorid == 14)
   {
	  MoveDynamicObject(spacedoorirgendwas[3],2004.961914, 1484.159179, 1094.670776, 2.0);
	  door[13] = false;
	  return 1;
   }
   return 1;
}
