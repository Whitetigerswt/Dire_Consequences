/*   
    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
    
    ==================
    ==              ==
    == Description  ==
    ==              ==
    ==================
    
    Started coding on April 9th 2010 by Whitetiger
    
    Well, if you are from sa-mp and you were DMing, then im sure you know what a/d scripts are, but this is for people who haven't yet expirenced an a/d mode.
    A/D stands for Attacking & Defend simple name, simple concept, one team is the Attackers, one is Defenders, when a round begins, players are shown a gun menu
    from this gun menu they will pick a few of the weapons listed in it, once picked they will be spawned in liberty city. Attackers use /car to spawn a vehicle.
    At this point, the Attackers go to the checkpoint and try and take over it, if Attackers stand in the checkpoint for [x] amount of seconds, they will win the round.
    Defenders try and defend the checkpoint obviously.. If either team is eliminated then the round will be over, regardless of the checkpoint. i'm not sure exactly how this will play out in IV:MP but i have faith it will work
    it is a very simple concept and it is very easy to play.
    
    
    moving onto TDMs, TDMs are really self explanitory, there is really nothing to explain, 2 teams, everyone has 1 life Just like Pyrokid's "Last team standing"..

    Good luck playing, and remember to report all bugs back to me. 
    
    
    =================
    ==             ==
    ==  Changelog  ==
    ==             ==
    =================
    
     v2.3  -
		* Converted script to the latest nightly builds for IV:MP.
		* Improved makeKeyIfDoesntExist function so it does not require re-opening of the files.
		* Made the script init all the config/base/tdm/tele information instead of simply reading the file everywhere throughout the script for the same information.
		* Added multi-colored messages to a lot of the sendPlayerMessage's and (ToAll)
		* Added model ID info to /car
		* Fixed a problem with lobbyhp when a player spawns
    
     v2.2  -
		* Fixed a linux problem with CaSe SeNsAtIvE files
		* Fixed the unknown function GetScriptName error.
		* Fixed some irc commands error message showing USAGE: /[command] when it should've been ![command]
		* Fixed a /vcolor script error if not given enough params
		* Fixed a problem of being frozen after being removed from the round
		* Added /vote for players to vote bases/tdms if there is not an admin online.
		* Added /config roundhp
		* Added /config lobbyhp
    
     v2.1b -
         * Made it so unpausing the round sets a timer and gives people a warning when the round unpauses.
         * Fixed a script error if /say was put with no params.
         * Fixed /vclear not working after the last update
         * Fixed round timer counting down when the round was paused.
       
     v2.0  -
         * Converted to 0.1
         * Config file and IRC module not found will not shutdown the server - but rather, unload this script.
         * IRC module will not load in 0.1, therfore, do not enable it until the module is updated.
         * /car improvements based on the new vehicle functions given.
         * Added an error message to /config vused if no parameters where given.
         * Added /config pingkick and an automatic ping kicking system.
         * Added /config weather.
         * Added time improvements and the spamming of time is no longer needed, so its removed.
         * Removed some old debug code.
         * togglePlayerFrozen fixes throughout the script.
         * PlayerToPoint switch to getDistanceBetweenPoints3D
         * Fixed a /resetguns and /disarm conflict if you where an admin.
         * Fixed a division by zero in /stats kill death ratio if you had 0 kills or 0 deaths & added duel ratio.
         * Fixed a /removewep parameter bug
         * Fixed the round weapons *SOMETIMES* not giving you weapons.
         * Fixed checkpoint not working.
         * Fixed many many many minor bugs.
    
     v1.3b -
		 * Added /config autokick - which will autokick the player if they did not login
         * Added /b(/a) create [optional:description] & /b(/a) description
		 * Added Kills/Deaths stat - really feel stupid not adding this sooner, it was always in the back of my mind but it never made it in.
         * Blip for Checkpoint added
         * Server will now shutdown if the config file is not found or IRC is enabled and the IRC module wasn't detected.
         * /delacc Added
         * Freezing is now fixed
         * Fixed /config website not working correctly
         * Fixed shotgun not working in /getgun
         
    
     v1.2b -
	     * Beta testing begun.
	     * Converted to Beta 1.
    
     v1.1b -
         * Added TDMs
         * Fixed major CP & base starting inconsistencies
         * Added most ingame commands to IRC commands
         * Initial release.
    
     v1.0b -
         * Added Duel
         * Added Bases
         * Added admin system
         * Countless commands
      
      --more to come.
      
      
    ==================
    ==              ==
    ==    Issues    ==
    ==              ==
    ==================
    
      Issues that cannot be fixed with the current IV:MP limitations:
       - Sometimes you can't see the CP in an interior
       - Hiding player map blips that are not on your team. (this will be a cmd once possible)
       - Sometimes you cannot see players in an interior.
       - You can hurt your teammates (I want this toggle on/off via cmd, but cannot yet do it)
       - Virtual Worlds, nuff said.
       - getFPS() does not work. - i've made a minFPS command but please be aware, that it does not work.
       - unloadScript() function does not work.
      
      
      Issues that can be fixed with the current IV:MP
       - None known.
      
    =================
    ==             ==
    ==  To-Do-List ==
    ==             ==
    =================
    
    - more IRC commands.
    - GUI for gun menu
    - load all the cfg settings and bases/tdms all configurable settings, on script init, so they don't need to constantly check files (increase speed)
    - duel location needs to be in config file
    - Refs. Only by /ref or /switch or something.
    - /shuffle.
    - MORE client sided functions. there are many things that need to be used from client side.
    - FixGaps() function.
    - /dm.
    - /vote -1 random
    - load player files when players connect.
    - speedmeter with vehicle velocity
    - respawnPlayer function, use for /sync
    - make autologin use seriel instead of IP, and a custom ban system as well
    - new camera pos functions, intro, and a spinning base camera.
    - toggleplayer hud and radar  when CP time gets low for defenders, also toggle chat from client script.
    - getCurrentStreetName and getCurrentAreaName to show where the CP is when base is loading and camera is moving.
    - mess with blipCreate event, see if we can disable blips yet
    - use the key press event to make an auto sync
    - don't forget to re-add the not enough players check for startbase and starttdm.
    - top shooter  
    - CLASS SELECTION WITH CAMERA ANGLES!
    
*/

const MAX_BASES = 100;								// The Maximum number of bases the script will detect.
const MAX_TELE = 50;								// The Maximum number of TDMs the script will detect.
const MAX_TDM = 100;                                // The Maximum number of Teles the script will detect.
const MAX_PLAYERS = 32;                             // The Maximum ammount of players that will be on the server at one time - make this match the max players in your settings file.

const COLOR_GREEN = 0x33AA33AA;
const COLOR_RED = 0xAA3333AA;
const COLOR_YELLOW = 0xFBFB00FF;
const COLOR_BLUE = 0x375FFFFF;
const COLOR_WHITE = 0xFFFFFFAA;

// multi-colored colors -

const COLOR_LIGHTBLUE2 = "[00FFFFFF]";
const COLOR_BLUE2 = "[0000FFFF]";
const COLOR_GREEN2 = "[00FF00FF]";
const COLOR_ORANGE2 = "[FF7B00FF]";
const COLOR_RED2 = "[FF0000FF]";
const COLOR_BLACK2 = "[000000FF]";
const COLOR_WHITE2 = "[FFFFFFFF]";
const COLOR_YELLOW2 = "[FBFB00FF]";


const SCRIPT_VERSION = "2.3";                       //The 'Offical' script version, Change if you feel necessary.
const SCRIPT_NAME = "Dire Consequences";            //What I've named the script, changed if needed.
const IRC = 0;                                      //Change to 1 if you have the module loaded, 0 if you do not
const DATA_SYSTEM = 1;                              // 1 = INI, 2 = MySQL NOTE: MySQL Does not work, has not been implemented yet
const LogFunctions = 0;                             //Useful to enable if there is a script error and it is crashing the server.



 //DO NOT EDIT <<<<<
local iBot = null;
local strEchoChannel = null;
local ircServer = null;
local ircPort = null;
local botName = null;

local sql = null;
local sql_hostname = null;
local sql_username = null;
local sql_database = null;
local sql_password = null;
 //Continue editing.
if(IRC == 1) {
    iBot = 0;
    strEchoChannel = "#theclan.aad";                   //enter your channel for your IRC here.
    ircServer = "irc.gtanet.com";                      //enter your IRC server here
    ircPort = 6667;                                    //irc server port
    botName = "IVMP_A_D";                              //botname
}

if(DATA_SYSTEM == 2) {
	sql_hostname = "127.0.0.1";
	sql_username = "root";
	sql_database = "consequences";
	sql_password = "";
	sql = mysql_connect(sql_hostname, sql_username, sql_password, sql_database);
}	

	
	

local Attackers				=		0;                                   // how many Attackers there are
local Defenders				=		0;                                   // ^^^ but for Defenders
local IsBaseStarted			=		0;									 // if a base is started this will = 1 else 0
local IsTDMStarted			=		0;									 // is a tdm started?
local cpobjectid			=		-1;                                  // The CP object so it can be deleted later.
local CPBlip				=		-1;                                  // The CP Blip so it can be deleted later.
local AttackersInRound		=		0;									 // the number of Attackers in a round.
local DefendersInRound		=		0;							         // The number of Defenders in a round
local AutoModeTimeLeft		=		30;				                     // The time till the random base starts
local pInfo					=		{};                                  // Most of the misc player variables are help in this array.
local Duel					=		{}                                   // All of the duel variables are held here.
local Server				=		{};                                  // Some random server variables are held here.
local Timers				=		{};		                             // Records all the timer variables.
local Bases					=		{};                                  // The base information.
local TDMs					=		{};                                  // The TDM information.
local Tele                  =       {};                                  // The tele information.

local WeaponNames = [ "Fist", "Baseball bat", "Pool cue", "Knife", "Grenade", "Molotov", "Rocket launcher missle", "Pistol/9mm", "", "Deagle", "Shotgun", "Beretta", "Micro Uzi", "MP5", "AK47", "M4", "Sniper Rifle", "M40A1", "RPG", "Flamethrower", "Minigun" ];
local WeaponSlots = [ -1, 0, 0, 0, 1, 1, -1, 2, -1, 2, 3, 3, 4, 4, 5, 5, 6, 7, -1, -1]; //e.g: WeaponSlots[10] would return 2

local vehicleNames = [
      "Admiral", "Airtug", "Ambulance", "Banshee", "Benson", "Biff", "Blista Compact", "Bobcat", "Boxville", "Buccaneer",
      "Burrito", "Burrito", "Bus", "Cabby", "Cavalcade", "Chavos", "Cognoscenti", "Comet", "Coquette",
      "DF8", "Dilettante", "Dukes", "E109", "Emperor", "Emperor", "Esperanto", "Faction", "FBI", "Feltzer",
      "Feroci", "Feroci", "Firetruck", "Flatbed", "Fortune", "Forklift", "Futo", "FXT", "Habanero", "Hakumai",
      "Huntley", "Infernus", "Ingot", "Intruder", "Landstalker", "Lokus", "Manana", "Marbella", "Merit", "Minivan",
      "Moonbeam", "MrTasty", "Mule", "Noose", "Nstockade", "Oracle", "Packer", "Patriot", "Perennial", "Perennial",
      "Peyote", "Phantom", "Pinnacle", "PMP600", "Police", "Police", "Polpatriot", "Pony", "Premier", "Pres", "Primo",
      "Pstockade", "Rancher", "Rebla", "Ripley", "Romero", "Rom", "Ruiner", "Sabre", "Sabre", "SabreGT", "Schafter",
      "Sentinel", "Solair", "Speedo", "Stalion", "Steed", "Stockade", "Stratum", "Stretch", "Sultan", "SultanRS",
      "SuperGT", "Taxi", "Taxi", "Trash", "Turismo", "Uranus", "Vigero", "Vigero", "Vincent", "Virgo", "Voodoo",
      "Washington", "Willard", "Yankee", "Bobber", "Faggio", "Hellfury", "NRG900", "PCJ600", "Sanchez", "Zombieb",
      "Annihilator", "Maverick", "Polmav", "Tourmav", "Dinghy", "Jetmax", "Marquis", "Predator", "Reefer", "Squalo",
      "Tuga", "Tropic", "Cablecar", "Subway"
   ];    

function onScriptInit() {
    if(LogFunctions == 1) log("onScriptInit");
    if(DATA_SYSTEM == 1) 
		dofile("scripts/easyini.nut");
	else
		dofile("scripts/mysql.nut"); 
		
    print("______________________________________________________________________________\n\n");
    print(SCRIPT_NAME + " A/D mode by Whitetiger");
    print("Version: " + SCRIPT_VERSION + "\n\n");
    print("______________________________________________________________________________\n\n");
    
    local ticks = getTickCount();
    
    CreateKeys();
    LoadConfig();
    LoadBases();
    LoadTDMs();

	print(SCRIPT_NAME + " v" + SCRIPT_VERSION + " Loaded");
	if(isIRCModuleLoaded() == 0 && IRC == 1) {
		print("IRC Module not detected");
		print("If you do not want IRC installed, change const IRC = 1; to const IRC = 0;");
		unloadScript(getScriptName());
	}
	if(!fexist("AAD/config.ini")) {
		print("Config file not found, Please redownload this script and place ALL the files into your server directory.");
		unloadScript(getScriptName()); 
	}
	print("Took " + (getTickCount() - ticks) + " ms to load");
	
	return 1;

}
addEvent("scriptInit", onScriptInit);

function setDefaultTime() {
	if(LogFunctions == 1) log("setDefaultTime");
	
	setTime(Server[0].Time, Server[1].Time);	
	return 1;
}	

function FriendlyReminder() {
	if(LogFunctions == 1) log("FriendlyReminder");
	sendMessageToAll("Your playing " + SCRIPT_NAME + " A/D, v" + SCRIPT_VERSION, COLOR_GREEN);
	sendMessageToAll("Brought to you by [" + Server[0].Clantag + "] clan, " + Server[0].Website, COLOR_GREEN);
	sendMessageToAll("-> /commands, /help, /credits <-", COLOR_GREEN);
	return 1;
}

function PingKick() {
	if(Server[0].MaxPing == 0) Timers[0].PingKick.kill();
	for(local i=0; i < Server[0].HighestID+1; ++i) {
		if(isPlayerConnected(i)) {
			if(getPlayerPing(i) > Server[0].MaxPing) {
				if(pInfo[i].PingWarn == 1) {
					sendPlayerMessage(i, COLOR_WHITE2 + "Your " + COLOR_RED2 + "ping" + COLOR_WHITE2 + " is to high, you will be kicked :(", COLOR_YELLOW, true);
					kickPlayer(i, true);
				}	
				sendPlayerMessage(i, COLOR_RED2 + "You" + COLOR_WHITE2 + "have a higher ping then is allowed, you may be kicked soon.", COLOR_YELLOW, true);
				pInfo[i].PingWarn = 1;
			} else pInfo[i].PingWarn = 0;
		}
	}
}				
				
				

if(IRC == 1) {
    function ircOnConnect(iBotid) {
        if(LogFunctions == 1) log("ircOnConnect, Bot: " + iBotid);
	    ircJoinChannel(iBotid, strEchoChannel);	
	    return true;
    }
    function ircOnUsersay(botid, receiver, user, host, message) {
		if(LogFunctions == 1) log("ircOnUsersay " + user + ": " + message);
		local cmdcheck = message.slice(0, 1);
        if(cmdcheck == "!") return ircOnCommand(botid, user, host, message);
        if(Server[0].Nochat == 1) return 1; //ircSay(iBot, strEchoChannel, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "the ingame chat is currently disabled.");
	    sendMessageToAll("Player " + user + " said from IRC: " + message, COLOR_YELLOW, true);
	    return true;
    }
    function ircOnCommand(botid, user, host, command) {
        if(LogFunctions == 1) log("ircOnCommand " + user + " " + command);
        local cmd = split(command.tolower(), " ");
        if(cmd[0] == "!commands" || cmd[0] == "!cmds") {
			//reg commands, available to everyone..
			ircSay(iBot, strEchoChannel, "!scores");  
			ircSay(iBot, strEchoChannel, "!stats [playerid/name]");
			if(!isPlayerIRCVoice(botid, strEchoChannel, user)) return 1;
			//voice commands, available to +'s and up
			ircSay(iBot, strEchoChannel, "!balance");
			ircSay(iBot, strEchoChannel, "!swap");
			if(!isPlayerIRCHop(botid, strEchoChannel, user)) return 1;
			//half op commands, available to %'s and up
			ircSay(iBot, strEchoChannel, "!startbase [baseid]");
			ircSay(iBot, strEchoChannel, "!starttdm [tdmid]");
			ircSay(iBot, strEchoChannel, "!restartbase");
			ircSay(iBot, strEchoChannel, "!end");
			ircSay(iBot, strEchoChannel, "!aka [playerid/name]");
			ircSay(iBot, strEchoChannel, "!setteam [playerid/name]");
			ircSay(iBot, strEchoChannel, "!allvs [name]");
			if(!isPlayerIRCOp(botid, strEchoChannel, user)) return 1;
			//op commands available to @'s and up
			ircSay(iBot, strEchoChannel, "!remove [playerid/name]");
			ircSay(iBot, strEchoChannel, "!mute [playerid/name]");
			ircSay(iBot, strEchoChannel, "!unmute [playerid/name]");
			ircSay(iBot, strEchoChannel, "!add [playerid/name]");
			ircSay(iBot, strEchoChannel, "!kick [playerid/name]");
			if(!isPlayerIRCSop(botid, strEchoChannel, user)) return 1;
			//sop commands available to &'s and ~'s only
			ircSay(iBot, strEchoChannel, "!ban [playerid/name]");
			ircSay(iBot, strEchoChannel, "!setlevel [playerid/name] [level]");
			ircSay(iBot, strEchoChannel, "!banacc [name]");
			ircSay(iBot, strEchoChannel, "!setserverpass [password]");
			return 1;
		}				
        if(cmd[0] == "!startbase") {
			if(!isPlayerIRCHop(botid, strEchoChannel, user)) return ircSay(iBot, strEchoChannel, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "Your not an HOP.");
			if(isRoundStarted() == 1) return ircSay(iBot, strEchoChannel, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "A base is already started");
			if(cmd.len() < 2) return ircSay(iBot, strEchoChannel, COLOR_RED2 + "Usage: " + COLOR_WHITE2 + " !startbase [baseid]");
			if(!isNumeric(cmd[1])) return ircSay(iBot, strEchoChannel, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "Invalid base ID.");
			local baseid = cmd[1].tointeger();
			if(baseid == -1) { StartRandomBase(); return sendMessageToAll2(user + " Has started a random Base from IRC", COLOR_YELLOW, true); }
			if(!fexist("AAD/bases/" + baseid + ".ini")) return ircSay(iBot, strEchoChannel, "ERORR: Base ID does not exist");
			sendMessageToAll(user + " Has started base " + baseid + " From IRC", COLOR_YELLOW, true);
			StartBase(baseid);
			Server[0].baseid = baseid;
			return 1;
		}
		if(cmd[0] == "!starttdm") {
			if(!isPlayerIRCHop(botid, strEchoChannel, user)) return ircSay(iBot, strEchoChannel, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "You are not an admin", COLOR_RED, true);
			if(isRoundStarted() == 1) return ircSay(iBot, strEchoChannel, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "A base is already started", COLOR_RED, true);
			if(cmd.len() < 2) return ircSay(iBot, strEchoChannel, COLOR_RED2 + "Usage: " + COLOR_WHITE2 + " !starttdm [tdmid]", COLOR_RED, true);
			if(!isNumeric(cmd[1])) return ircSay(iBot, strEchoChannel, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "Invalid tdm ID.", COLOR_RED, true);
			local tdmid = cmd[1].tointeger();
			if(tdmid == -1) { StartRandomTDM(); return sendMessageToAll2(user + " Has started a random TDM from IRC", COLOR_YELLOW, true); }
			if(!fexist("AAD/tdm/" + tdmid + ".ini")) return ircSay(iBot, strEchoChannel, "ERORR: TDM ID does not exist", COLOR_RED, true);
			sendMessageToAll2(user + " Has started TDM " + tdmid + " from IRC", COLOR_YELLOW, true);
			StartTDM(tdmid);
			Server[0].baseid = tdmid;
			return 1;
		}	
		if(cmd[0] == "!end") {
		    if(!isPlayerIRCHop(botid, strEchoChannel, user)) return ircSay(iBot, strEchoChannel, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "You are not an admin");
			if(!isRoundStarted()) return ircSay(iBot, strEchoChannel, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "A base is not started.");
			sendMessageToAll(user + " Has ended the round from IRC", COLOR_YELLOW, true);
			return endBase();
		}
		if(cmd[0] == "!aka") {
			if(!isPlayerIRCHop(botid, strEchoChannel, user)) return ircSay(iBot, strEchoChannel, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "your not an admin!");
			if(cmd.len() <= 1) return ircSay(iBot, strEchoChannel, COLOR_RED2 + "Usage: " + COLOR_WHITE2 + " !aka [playerid/name]");
			local targetid = getPlayerIDFromNameOrID(cmd[1]);
			if(!isPlayerConnected(targetid)) return ircSay(iBot, strEchoChannel, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "This player is not connected.");
			local ip = getPlayerIp(targetid);
			local aka = EasyINI("AAD/aka.txt");
			if(aka.getKey("AKA", ip) != null) {
				ircSay(iBot, strEchoChannel, getPlayerName(targetid) + " (" + ip + ")");
				ircSay(iBot, strEchoChannel, aka.getKey("AKA", ip));
			}
			else {
				ircSay(iBot, strEchoChannel, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "To prevent crashing of the server, you cannot use this command on this specific player.");
				ircSay(iBot, strEchoChannel, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "The reason behind this is most likely because this player had once connected to this server with []'s in there name");
				ircSay(iBot, strEchoChannel, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "I know right, what a shitty error, but without going into much detail, this would crash the server.");
				ircSay(iBot, strEchoChannel, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "If you most know this players AKA, you can check it in the aka file scripts/AAD/aka.txt");
				return 1;
				//there are possible fixes for this issue, i might attempt one in a later version, or, hopefully even better is the EasyINI include will get patched for a fix for this
			}	
		}
		if(cmd[0] == "!restartbase") {
			if(!isPlayerIRCHop(botid, strEchoChannel, user)) return ircSay(iBot, strEchoChannel, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "Your not an admin!", COLOR_RED, true);
			if(IsBaseStarted == 0 && IsTDMStarted == 0) return ircSay(iBot, strEchoChannel, "A round isn't started!", COLOR_RED, true);
			local tmp = Server[0].baseid;
			if(IsBaseStarted == 1) {
			    endBase();
				StartBase(tmp);
				sendMessageToAll(user + " Has restarted base " + tmp + " from IRC", COLOR_YELLOW, true);
			}	
			else if(IsTDMStarted == 1) {
			    endBase();
			    StartTDM(tmp);
				sendMessageToAll(user + " Has restarted TDM " + tmp + " from IRC", COLOR_YELLOW, true);
			}	
			return 1;
		}	
		if(cmd[0] == "!scores" || cmd[0] == "!score") {
			ircSay(iBot, strEchoChannel, "Attacker Wins: " + Server[0].tmpattwins, COLOR_YELLOW, true);
			ircSay(iBot, strEchoChannel, "Defender Wins: " + Server[0].tmpdefwins, COLOR_YELLOW, true);
			return 1;
		}    
		if(cmd[0] == "!stats") {
			local targetid = -1;
			if(cmd.len() >= 2) targetid = getPlayerIDFromNameOrID(cmd[1]);
			if(!isPlayerConnected(targetid)) return ircSay(iBot, strEchoChannel, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "Invalid player!", COLOR_RED, true);
			local ini = EasyINI("AAD/Users/" + getPlayerName(targetid) + ".ini");
			local ip = ini.getKey("Login", "IP");
			local lvl = ini.getKey("Login", "level").tointeger();
			local skin = ini.getKey("Skin", "Skin");
			if(skin == null) skin = "None";
			else if(skin != null) skin.tointeger();
			local roundwins = ini.getKey("Stats", "RoundWins").tointeger();
            local roundlosses = ini.getKey("Stats", "RoundLosses").tointeger();
			local duelwins = ini.getKey("Stats", "DuelWins").tointeger();
			local duellosses = ini.getKey("Stats", "DuelLosses").tointeger();
			ircSay(iBot, strEchoChannel, "Account name: " + getPlayerName(targetid), COLOR_GREEN);
			if(isPlayerIRCHop(botid, strEchoChannel, user)) ircSay(iBot, strEchoChannel, "IP: " + ip, COLOR_GREEN)
			ircSay(iBot, strEchoChannel, "Admin level: " + lvl, COLOR_GREEN);
			ircSay(iBot, strEchoChannel, "Favorite skin: " + skin, COLOR_GREEN);
			ircSay(iBot, strEchoChannel, "Round wins: " + roundwins + ", Round Losses: " + roundlosses, COLOR_GREEN);
			ircSay(iBot, strEchoChannel, "Duel wins: " + duelwins + ", Duel losses: " + duellosses, COLOR_GREEN);			
			return 1;
		}	
		if(cmd[0] == "!balance") {
			if(!isPlayerIRCVoice(botid, strEchoChannel, user)) return ircSay(iBot, strEchoChannel, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "Your not an admin!", COLOR_RED, true);
			if(isRoundStarted() == 1) return ircSay(iBot, strEchoChannel, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "You cannot edit the teams when a base is started!", COLOR_RED, true);
			balanceTeams();
			return sendMessageToAll(user + " has balanced the teams from IRC", COLOR_YELLOW, true);
		}
		/*if(cmd[0] == "!say") {
			if(cmd.len() < 2) return ircSay(iBot, strEchoChannel, COLOR_RED2 + "Usage: " + COLOR_WHITE2 + " !say [text]");
			local text = command.slice(cmd[0].len() + 1, command.len());
			if(isPlayerIRCOwner(botid, strEchoChannel, user))  sendMessageToAll2("***[Owner] " + user + ": " + text, COLOR_BLUE);
			else if(isPlayerIRCSop(botid, strEchoChannel, user)) sendMessageToAll2("***[Head Admin] " + user + ": " + text, COLOR_BLUE);
			else if(isPlayerIRCOp(botid, strEchoChannel, user)) sendMessageToAll2("***[Admin] " + user + ": " + text, COLOR_BLUE);
			else if(isPlayerIRCHop(botid, strEchoChannel, user)) sendMessageToAll2("***[Moderator] " + user + ": " + text, COLOR_BLUE);
			//ok, so they must be voice or no admin level,
			else sendMessageToAll2("***[Guest] " + user + ": " + text, COLOR_BLUE);	
			return 1;
		}*/
		//commented because i edited !saying. it is now called in the other text function from irc.
		//so you do not have to type !say to talk to the server, everything you type apart from commands will be sent to the server.
		if(cmd[0] == "!mute") {
			if(cmd.len() >= 2) {
				if(!isPlayerIRCOp(botid, strEchoChannel, user)) return ircSay(iBot, strEchoChannel, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "Your not an admin");
				local targetid = getPlayerIDFromNameOrID(cmd[1]);
				if(!isPlayerConnected(targetid)) return ircSay(iBot, strEchoChannel, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "This player is not connected.");
				if(pInfo[targetid].Mute == 1) return ircSay(iBot, strEchoChannel, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "This player is already muted, use !unmute");
				pInfo[targetid].Mute = 1;
				return sendMessageToAll2(user + " Has muted " + getPlayerName(targetid) + " from IRC", COLOR_YELLOW, true);
			}
			return ircSay(iBot, strEchoChannel, COLOR_RED2 + "Usage: " + COLOR_WHITE2 + " !mute [playerid/name]");
		}
		if(cmd[0] == "!unmute") {
		    if(cmd.len() >= 2) {
				if(!isPlayerIRCOp(botid, strEchoChannel, user)) return ircSay(iBot, strEchoChannel, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "Your not an admin");
				local targetid = getPlayerIDFromNameOrID(cmd[1]);
				if(!isPlayerConnected(targetid)) return ircSay(iBot, strEchoChannel, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "This player is not connected.", COLOR_RED, true);
				if(pInfo[targetid].Mute == 0) return ircSay(iBot, strEchoChannel, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "This player is already unmuted, use !mute", COLOR_RED, true);
				pInfo[targetid].Mute = 0;
				return sendMessageToAll2(user + " Has unmuted " + getPlayerName(targetid) + " from IRC", COLOR_YELLOW, true);
			}
			return ircSay(iBot, strEchoChannel, COLOR_RED2 + "Usage: " + COLOR_WHITE2 + " !unmute [playerid/name]", COLOR_RED, true);
        }
        if(cmd[0] == "!setlevel") {
			if(cmd.len() >= 3) {
				local targetid = cmd[1].tostring();
				if(!isNumeric(targetid)) return ircSay(iBot, strEchoChannel, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "Invalid player id.");
				targetid = cmd[1].tointeger();
				if(isPlayerConnected(targetid) && isPlayerIRCSop(botid, strEchoChannel, user)) {
					local ini = EasyINI("AAD/Users/" + getPlayerName(targetid) + ".ini");
					local level = cmd[2].tostring();
					if(!isNumeric(level)) return ircSay(iBot, strEchoChannel, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "Invalid level");
					if(level.tointeger() != 0 && level.tointeger() != 1 && level.tointeger() != 2) return ircSay(iBot, strEchoChannel, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "Invalid level");
					ini.setKey("Login", "level", level);
					ini.saveData();
					local tmp = ini.getKey("Login", "level");
					pInfo[targetid].Admin = tmp.tointeger();
					sendMessageToAll2(user + " has set " + getPlayerName(targetid) + "'s Admin level to " + pInfo[targetid].Admin + "from IRC.", COLOR_YELLOW, true);
					return 1;
				}
				return ircSay(iBot, strEchoChannel, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "The player is not connected, or you are not an admin.");	
	        }
	        return ircSay(iBot, strEchoChannel, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "!setlevel [playerid] [level]");
	    }
	    if(cmd[0] == "!add") {
			if(cmd.len() < 2) return ircSay(iBot, strEchoChannel, COLOR_RED2 + "Usage: " + COLOR_WHITE2 + " /add [playerid/name]");
			if(!isPlayerIRCOp(botid, strEchoChannel, user)) return ircSay(iBot, strEchoChannel, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "You are not an admin");
			if(!isRoundStarted()) return ircSay(iBot, strEchoChannel, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "A base is not started.");
			local targetid = getPlayerIDFromNameOrID(cmd[1].tostring());
			targetid.tointeger();
			if(!isPlayerConnected(targetid)) return ircSay(iBot, strEchoChannel, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "This player is not online!");
			if(isPlayerInRound(playerid)) return ircSay(iBot, strEchoChannel, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "This player is already in a round!");
			if(pInfo[targetid].team == 1) { //Attackers
			    setPlayerCoordinates(targetid,  Bases[Server[0].baseid].AttackerX,
				Bases[Server[0].baseid].AttackerY,
				Bases[Server[0].baseid].AttackerZ);
				AttackersInRound++;
				pInfo[targetid].IsAttackingInRound = 1;
				sendMessageToAll2(user + " Added " + getPlayerName(targetid) + " as a Attacker. from IRC", COLOR_YELLOW, true);
		    }
		    else if(pInfo[targetid].team == 2) { //Defenders
			    setPlayerCoordinates(targetid,  Bases[Server[0].baseid].DefenderX,
				Bases[Server[0].baseid].DefenderY,
                Bases[Server[0].baseid].DefenderZ);
			    DefendersInRound++;
                pInfo[targetid].IsDefendingInRound = 1;
                sendMessageToAll2(user + " Added " + getPlayerName(targetid) + " as a Defender. from IRC", COLOR_YELLOW, true);
			}
		}
		if(cmd[0] == "!swap") {
			if(!isPlayerIRCVoice(botid, strEchoChannel, user)) return ircSay(iBot, strEchoChannel, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "Your not an admin");
			if(isRoundStarted() == 1) return ircSay(iBot, strEchoChannel, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "You cannot use this command when a base is started!");
			swapTeams();
			return sendMessageToAll2(user + " Has swapped the teams from IRC", COLOR_YELLOW, true);
		}
		if(cmd[0] == "!setserverpass" || cmd[0] == "!setserverpassword" || cmd[0] == "!setpass" || cmd[0] == "!setpassword") {
			if(!isPlayerIRCSop(botid, strEchoChannel, user)) return ircSay(iBot, strEchoChannel, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "You must be admin level 2 to use this command.");
			if(cmd.len() >= 2) {
				setServerPassword(cmd[1]);
				return ircSay(iBot, strEchoChannel, "You've set the server password to, " + cmd[1]);
			} else { 
				return ircSay(iBot, strEchoChannel, COLOR_RED2 + "Usage: " + COLOR_WHITE2 + " !setserverpass [password]");
			}  
			return 1;
		}	              
		if(cmd[0] == "!remove") {
			if(!isRoundStarted()) return ircSay(iBot, strEchoChannel, "A base is not started!", COLOR_RED, true);
			if(cmd.len() != 1 && cmd.len() != 2) return ircSay(iBot, strEchoChannel, COLOR_RED2 + "Usage: " + COLOR_WHITE2 + " /remove [id]");
			if(isPlayerIRCOp(botid, strEchoChannel, user) && cmd.len() >= 2) {
				local targetid = getPlayerIDFromNameOrID(cmd[1]);
				if(!isPlayerConnected(targetid)) return ircSay(iBot, strEchoChannel, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "This player is not connected.", COLOR_RED, true);
				removePlayerFromRound(targetid);
				return 1;
			}
			else return ircSay(iBot, strEchoChannel, "Your not an admin or you didn't enter a player.");                     
			return 1;
		}
		if(cmd[0] == "!ban") {
			if(!isPlayerIRCSop(botid, strEchoChannel, user)) return ircSay(iBot, strEchoChannel, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "You need to be & to use this command");
			if(cmd.len() == 1) return ircSay(iBot, strEchoChannel, COLOR_RED2 + "Usage: " + COLOR_WHITE2 + " /ban [playerid/name] [reason]");
			local targetid = getPlayerIDFromNameOrID(cmd[1]);
			if(cmd.len() == 2) {
				if(isPlayerConnected(targetid)) {
					sendMessageToAll2(user + " Has banned " + getPlayerName(targetid), COLOR_YELLOW, true);
					Banned(targetid);
					if(pInfo[targetid].LoggedIn == 1) {
						local ini = EasyINI("AAD/Users/" + getPlayerName(targetid) + ".ini");
						ini.setKey("Login", "Banned", 1);
						ini.saveData();
					}
					banPlayer(targetid, 0);
					return 1;
				}
				ircSay(iBot, strEchoChannel, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "This player isn't connected.");
				return 1;           
			}
			if(cmd.len() >= 3) {
				if(isPlayerConnected(targetid)) {
					sendMessageToAll2(user + " Has banned " + getPlayerName(targetid) + " Reason: " + command.slice(cmd[0].len()+cmd[1].len()+2, command.len()), COLOR_YELLOW, true);
					Banned(targetid);
					banPlayer(targetid, 0);
					if(pInfo[targetid].LoggedIn == 1) {
						local ini = EasyINI("AAD/Users/" + getPlayerName(targetid) + ".ini");
						ini.setKey("Login", "Banned", 1);
						ini.saveData();
					}
					return 1;
				}
				ircSay(iBot, strEchoChannel, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "This player isn't connected.");
				return 1; 
			}
			return 1;
		}
		if(cmd[0] == "!setteam") {
			if(!isPlayerIRCHop(botid, strEchoChannel user)) return ircSay(iBot, strEchoChannel, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "Your not an admin");
			if(isRoundStarted() == 1) return ircSay(iBot, strEchoChannel, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "You cannot set teams during a round");
			if(cmd.len() >= 3) {
				ircSay(iBot, strEchoChannel, COLOR_RED2 + "Usage: " + COLOR_WHITE2 + " !setteam [playerid] [teamid]"); 
				ircSay(iBot, strEchoChannel, "Attackers = 1");
				return ircSay(iBot, strEchoChannel, "Defenders = 2");
			}	
            local targetid = tmp;
            local teamid = cmd[2].tointeger();
            if(teamid != 1 && teamid != 2) {
                ircSay(iBot, strEchoChannel, COLOR_RED2 + "Usage: " + COLOR_WHITE2 + " !setteam [playerid] [teamid]"); 
                ircSay(iBot, strEchoChannel, "Attackers = 1");
                return ircSay(iBot, strEchoChannel, "Defenders = 2");
            }
            setTeam(tmp, teamid);

            if(teamid == 1) sendMessageToAll2(user + " Has set " + getPlayerName(tmp) + " to the team " + Server[0].AttackersName + " (Attackers) From IRC");
            if(teamid == 2) sendMessageToAll2(user + " Has set " + getPlayerName(tmp) + " to the team " + Server[0].DefendersName + " (Defenders) From IRC");
            return 1;
		}            
		if(cmd[0] == "!kick") {
			if(!isPlayerIRCOp(botid, strEchoChannel, user)) return ircSay(iBot, strEchoChannel, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "Your not an Admin");
			if(cmd.len() <= 1) return ircSay(iBot, strEchoChannel, COLOR_RED2 + "Usage: " + COLOR_WHITE2 + " /kick [playerid/name] [reason]");
			local targetid = getPlayerIDFromNameOrID(cmd[1]);
			if(cmd.len() == 2) {
				if(isPlayerConnected(targetid)) {
					sendMessageToAll2(user + " Has kicked " + getPlayerName(targetid), COLOR_YELLOW, true);
					kickPlayer(targetid, true);
					return 1;
				}
				ircSay(iBot, strEchoChannel, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "This player isn't connected.", COLOR_RED, true);
				return 1;           
			}
			if(cmd.len() >= 3) {
				if(isPlayerConnected(targetid)) {
					sendMessageToAll2(user + " Has kicked " + getPlayerName(targetid) + " Reason: " + command.slice(cmd[0].len()+cmd[1].len()+2, command.len()), COLOR_YELLOW, true);
					kickPlayer(targetid, true);
					return 1;
				}
				ircSay(iBot, strEchoChannel, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "This player isn't connected.", COLOR_RED, true);
				return 1; 
			}
			return 1;
		}
		if(cmd[0] == "!banacc") {
			if(!isPlayerIRCSop(botid, strEchoChannel, user)) return ircSay(iBot, strEchoChannel, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "You need to be IRC level & to use this command.");
			if(cmd.len() >= 2) {
				local targetacc = cmd[1];
				for(local i=0; i <= Server[0].HighestID+1; ++i) if(isPlayerConnected(i)) {
					local name = getPlayerName(i);
					if(name.tolower() == targetacc.tolower()) return ircSay(iBot, strEchoChannel, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "This player is connected, use /ban");
				}
				if(!fexist("AAD/Users/" + targetacc + ".ini")) return ircSay(iBot, strEchoChannel, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "This player is not registered");   
				local ini = EasyINI("AAD/Users/" + targetacc + ".ini");
				ini.setKey("Login", "Banned", 1);
				ini.saveData();
				return ircSay(iBot, strEchoChannel, "Successfully banned " + targetacc);
			}
			return ircSay(iBot, strEchoChannel, COLOR_RED2 + "Usage: " + COLOR_WHITE2 + " !banacc [playername]");
		}
		if(cmd[0] == "!allvs") {
			if(!isPlayerIRCHop(botid, strEchoChannel, user)) return ircSay(iBot, strEchoChannel, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "Your not an admin!");
			if(isRoundStarted() == 1) return ircSay(iBot, strEchoChannel, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "You cannot use this command if a round is started");
			if(cmd.len() < 2) return ircSay(iBot, strEchoChannel, COLOR_RED2 + "Usage: " + COLOR_WHITE2 + " !allvs [name]");
			for(local i=0; i <= Server[0].HighestID+1; ++i) if(isPlayerConnected(i)) {
				if(pInfo[i].team == 1) Attackers--;
				else if(pInfo[i].team == 2) Defenders--;
				if(getPlayerName(i).tolower().find(cmd[1].tolower()) != null) setTeam(i, 1);
				else setTeam(i, 2);
			}
			return sendMessageToAll2(user + " has set the teams to all vs " + cmd[1], COLOR_YELLOW, true);
		}	
		return 1;      		
	}     			       	    	
}    



function onPlayerText(playerid, text) {
    //if(LogFunctions == 1) log("onPlayerText " + getPlayerName(playerid) + ": " + text);
    //This is not needed in onPlayerText because the text shows in the console unless onPlayerText returns 0.
    if(pInfo[playerid].Mute == 1) { sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "Your muted.", COLOR_RED, true); return 0; }
    local tmp = text.slice(0, 1);
    if(tmp == "!") {
        local name = getPlayerName(playerid);
        for(local i=0; i <= Server[0].HighestID+1; ++i) if(isPlayerConnected(i)) if(pInfo[playerid].team == pInfo[i].team) sendPlayerMessage(i, "[Team chat] " + name + ": " + text.slice(1, text.len()), getTeamColor(pInfo[playerid].team), true);
        return 0;
    }
    else if(tmp == "@") {
        local name = getPlayerName(playerid);
        if(!isPlayerConnected(playerid) || !IsPlayerAdmin(playerid)) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "You're not an admin, you cannot speak in the admin chat!", COLOR_RED, true);
        for(local i=0; i <= Server[0].HighestID+1; ++i) if(isPlayerConnected(i)) if(IsPlayerAdmin(playerid) && IsPlayerAdmin(i)) sendPlayerMessage(i, "[Admin Chat] " + name + ": " + text.slice(1, text.len()), COLOR_BLUE);  
        return 0;
    }
    if(tmp == "#") {
        local clantag = getPlayerClanTag(playerid);
        local name = getPlayerName(playerid);
        for(local i=0; i <= Server[0].HighestID+1; ++i) if(isPlayerConnected(i)) {
            local othername = getPlayerName(i).tolower();
            if(name.find(clantag.tolower()) != null && othername.find(clantag.tolower()) != null) sendPlayerMessage(i, "[Clan chat] " + name + ": " + text.slice(1, text.len()), COLOR_GREEN);
        }    
        return 0;
    }
    if(Server[0].Nochat == 1) {
		sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "chat is currently disabled.", COLOR_RED, true);
		return 0;
	}	
    //allow them to type in the team/admin/clan chat while global chat is muted.          
    if(IRC == 1) ircSay(iBot, strEchoChannel, "* " + getPlayerName(playerid) + ": " + text);
    return 1;
}
addEvent("playerText", onPlayerText);

function onPlayerConnect(playerid) {
    if(LogFunctions == 1) log("onPlayerConnect " + getPlayerName(playerid));
    
    
    
    createPlayerVariables(playerid);
    
    for(local i=0; i <= getHighestNameBanID(); ++i) {
        if(!fexist("AAD/namebans/" + i + ".ini")) continue;
		local tmp = EasyINI("AAD/namebans/" + i + ".ini");
		if(fexist("AAD/namebans/" + i + ".ini")) {
		    //if(tmp.getKey("Stuff", "Name") == null) break;
			local playername = tmp.getKey("Stuff", "Name");
			local name = getPlayerName(playerid);
			if(name.tolower().find(playername.tolower()) != null) {
				sendPlayerMessage(playerid, "You're" + COLOR_GREEN2 + " banned from this server, a head administrator has banned you're name.", COLOR_WHITE, true);
				Banned(playerid);
				banPlayer(playerid, 0);
			}
		}
	}
	
	calculateHighestServerID();
    local ipz = getPlayerIp(playerid);
    local name = getPlayerName(playerid);
    local aka = EasyINI("AAD/aka.txt");
    makeKeyIfDoesntExist(aka, "AKA", ipz);
    local currentaka = aka.getKey("AKA", ipz);
    if(currentaka.tolower().find(name.tolower()) != null) { /* nothing */ }
    else if(currentaka != null) aka.setKey("AKA", ipz, currentaka + "," + getPlayerName(playerid));
    else if(currentaka == null) aka.setKey("AKA", ipz, getPlayerName(playerid));
    aka.saveData();      	 
    if(Server[0].Clanwar == 1) {
        if(name.tolower().find("[" + Server[0].Clantag + "]") == null && name.tolower().find("[" + Server[0].ClanwarTags + "]") == null && name.tolower().find("[" + Server[1].ClanwarTags + "]") == null ) {
            sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "Clanwar is going on, you've been automaticly, kicked.", COLOR_RED, true);
            sendPlayerMessage(playerid, "The only people allowed on this server are members of the following " + COLOR_RED2 + "clans.", COLOR_YELLOW, true);

            sendPlayerMessage(playerid, "[" + Server[0].Clantag + "]," + COLOR_RED2 + " [" + Server[0].ClanwarTags + "]," + COLOR_GREEN2 + " [" + Server[1].ClanwarTags + "]", COLOR_YELLOW, true);
            kickPlayer(playerid, true);
        }
    }  
	
    
    for(local i=0; i <= Server[0].HighestID+1; ++i) {
        if(isPlayerConnected(i)) {
            if(IsPlayerAdmin(i)) sendPlayerMessage(i, COLOR_WHITE2 + getPlayerName(playerid) + " (" + COLOR_RED2 + playerid + COLOR_WHITE2 + ") has joined the server. (IP: " + COLOR_RED2 + getPlayerIp(playerid) + COLOR_WHITE2 + ")", COLOR_WHITE, true); 
            else sendPlayerMessage(i, COLOR_WHITE2 + getPlayerName(playerid) + " (" + COLOR_RED2 + playerid + COLOR_WHITE2 + ") has joined the server.", COLOR_WHITE, true);
        }    
    }
    
    if(IRC == 1) ircSay(iBot, strEchoChannel, "* " + getPlayerName(playerid) + " has joined the server."); 
    if(Server[0].Autokick == 1) timer(KickIfNotLogged, 30000, 1, playerid);
    if(!pfexist("AAD/Users/" + getPlayerName(playerid) + ".ini") && pInfo[playerid].LoggedIn != 1) return sendPlayerMessage(playerid, "Please " + COLOR_RED2 + "/register" + COLOR_YELLOW2 + " your account for extra features!", COLOR_YELLOW, true);
    local ini = EasyINI("AAD/Users/" + getPlayerName(playerid) + ".ini");   
    if(pfexist("AAD/Users/" + getPlayerName(playerid) + ".ini")) {
        local banned = ini.getKey("Login", "Banned");
        if(banned == "1") {
            Banned(playerid);
            banPlayer(playerid, 0);
            return 1;
        }    
        local ip = getPlayerIp(playerid);   
        local ipinfile = ini.getKey("Login", "IP");
        if(ipinfile == ip && Server[0].Autologin == 1) loginPlayer(playerid);
        else if(pfexist("AAD/Users/" + getPlayerName(playerid) + ".ini") && pInfo[playerid].LoggedIn != 1) {
			sendPlayerMessage(playerid, COLOR_RED2 + "/Login" + COLOR_YELLOW2 + " to your account, or you may be kicked!", COLOR_YELLOW, true);
		}	
    }
    return 1;
}
addEvent("playerConnect", onPlayerConnect);

function onPlayerDisconnect(playerid, reason) {
    if(LogFunctions == 1) log("onPlayerDisconnect " + getPlayerName(playerid));
    calculateHighestServerID();
    if(IRC == 1) ircSay(iBot, strEchoChannel, "* " + getPlayerName(playerid) + " has left the server.");
    if(pInfo[playerid].team == 1) Attackers--;
    if(pInfo[playerid].team == 2) Defenders--;
    if(pInfo[playerid].IsAttackingInRound == 1) AttackersInRound--;
    if(pInfo[playerid].IsDefendingInRound == 1) DefendersInRound--;
    if(isRoundStarted() == 1) endBaseWithWinner();   
    delete pInfo[playerid];
    delete Duel[playerid];
    if(reason == 0) sendMessageToAll(getPlayerName(playerid) + " (" + COLOR_RED2 + playerid + COLOR_WHITE2 + ") has left the server. (" + COLOR_RED2 + " Leaving" + COLOR_WHITE2 + ")", COLOR_WHITE, true);
    else if(reason == 1) sendMessageToAll(getPlayerName(playerid) + " (" + playerid + ") has left the server. (" + COLOR_RED2 + " Crashed" + COLOR_WHITE2 + ")", COLOR_WHITE, true);    
    return 1;
}
addEvent("playerDisconnect", onPlayerDisconnect);

local reportthosebugs = 0;
function onScriptError(errorstring)
{
	//function log is not needed as the error will display in the console anyway.
	if(reportthosebugs == 0) sendMessageToAll(COLOR_WHITE2 + "A Script " + COLOR_RED2 + "ERROR " + COLOR_WHITE2 + "has occured, Check the console for details", COLOR_RED, true);
	reportthosebugs = 1;
	timer(RemindOfError, 5000, 1);
	//sendMessageToAll(errorstring, COLOR_BLUE);  
    return 1;
}
addEvent("scriptError", onScriptError);

function RemindOfError() {
	reportthosebugs = 0;
}	

function onPlayerSpawn(playerid) {
    if(LogFunctions == 1) log("onPlayerSpawn " + getPlayerName(playerid));
    putPlayerAtMainSpawn(playerid); 
	setPlayerArmour(playerid, 100);
    if(pInfo[playerid].Jailed == 1) { 
		setPlayerCoordinates(targetid, -0.329196, -0.224473, 9942.47);
		togglePlayerFrozen(targetid, true);
	}
    
    togglePlayerPhysics(playerid, bool(Server[0].Ragdoll));
    if(Server[0].Clanwar == 0) autoAsignPlayer(playerid);
    else if(Server[0].Clanwar == 1) {
        local name = getPlayerName(playerid);

        if(name.tolower().find(Server[0].AttackersName.tolower()) != null) {
            pInfo[playerid].team <- 1; //Attackers
            Attackers++;
            sendMessageToAll(getPlayerName(playerid) + " Has spawned as a '" + Attackersname + "' (Attacker)", COLOR_YELLOW, true);
            //setPlayerColor(playerid, ini.getKey("Config", "AttackerColor"));
            local skin = ini.getKey("Skins", "AttackersSkin").tointeger();
            setPlayerModel(playerid, skin);   
        }
        else if(name.tolower().find(Server[0].DefendersName.tolower()) != null) {
            pInfo[playerid].team <- 2; //Defenders
            Defenders++;
            sendMessageToAll(getPlayerName(playerid) + " Has spawned as a '" + Defendersname + "' (Defender)", COLOR_YELLOW, true);
            //setPlayerColor(playerid, ini.getKey("Config", "DefenderColor"));
            local skin = ini.getKey("Skins", "DefendersSkin").tointeger();
            setPlayerModel(playerid, skin);  
        }
        else { return onPlayerSpawn(playerid) /* messed up error occured, lets try again */ }
    }
	local hp, ar = 0;
	if(Server[0].LobbyHP > 200) {
		hp = 200;
		ar = Server[0].LobbyHP - 200;
	}
	else hp = Server[0].LobbyHP;
	
	setPlayerArmour(playerid, ar);
	setPlayerHealth(playerid, hp);	
    
    if(pInfo[playerid].LoggedIn == 0) return 1;
    useProperSkin(playerid);
    if(Server[0].CustomSpawns == 0) return 1;
    else {
        local ini = EasyINI("AAD/Users/" + getPlayerName(playerid) + ".ini");
        local spawn = ini.getKey("Spawn", "Spawn");
        if(spawn.tointeger() == 1 || spawn.tointeger() == 2) { //deathspot
            if(ini.getKey("Spawn", "X") == null) return 1;
		    setPlayerCoordinates(playerid, ini.getKey("Spawn", "X").tofloat(),
		    ini.getKey("Spawn", "Y").tofloat(),
            ini.getKey("Spawn", "Z").tofloat());
        }
    }
    givePlayerSpawnWeps(playerid); 
    return 1;
}   
addEvent("playerSpawn", onPlayerSpawn);

function onScriptExit() {
    if(LogFunctions == 1) log("onScriptExit");
    if(Server[0].Clanwar == 1) {
        local ini = EasyINI("AAD/config.ini");
        local Attackersname = ini.getKey("Config", "Attackerstmp");
        local Defendersname = ini.getKey("Config", "Defenderstmp");
        ini.setKey("Config", "Attackers", Attackersname);
        ini.setKey("Config", "Defenders", Defendersname);
        ini.deleteKey("Config", "Attackerstmp");
        ini.deleteKey("Config", "Defenderstmp");
        ini.saveData();
    }
    log("<<<< " + SCRIPT_NAME + " v" + SCRIPT_VERSION + " shutting down >>>>");
    return 1;
}
addEvent("scriptExit", onScriptExit);         

local unpausetimer = null;
function onPlayerCommand(playerid, command) {
    //function log is below /register, /login, /pm, and /changepass for obvious reasons.
	if(command == null) return onScriptError(getPlayerName(playerid) + " command was null");
    if(pInfo[playerid].Mute == 1) { sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "Your muted, no commands either.", COLOR_RED, true); return 0; }
    local cmd = split(command.tolower(), " ");           
    if(cmd[0] == "/register") {
		if(cmd.len() >= 2) {
			if(pfexist("AAD/Users/" + getPlayerName(playerid) + ".ini")) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "You're already registered", COLOR_RED, true);
			local ini = EasyINI("AAD/Users/" + getPlayerName(playerid) + ".ini");
			local encryptedpass = md5(cmd[1].tolower());
			ini.setKey("Login", "password", encryptedpass);
			pInfo[playerid].Admin = 0;
			ini.setKey("Login", "level", pInfo[playerid].Admin);
			ini.setKey("Login", "Banned", 0);
			ini.setKey("Spawn", "Spawn", 0);
			ini.setKey("Stats", "DuelWins", 0);
			ini.setKey("Stats", "DuelLosses", 0);
			ini.setKey("Stats", "RoundWins", 0);
			ini.setKey("Stats", "RoundLosses", 0);
			ini.setKey("Stats", "Kills", 0);
			ini.setKey("Stats", "Deaths", 0);
			ini.setKey("VColor", "1", 0);
			ini.setKey("VColor", "2", 0);
			ini.setKey("VColor", "3", 0);
			ini.setKey("VColor", "4", 0);
			ini.saveData();
			for(local i=0; i <= WeaponNames.len(); ++i) {
				if(!isValidWep(i)) continue;
			    local key = i.tostring();
			    makeKeyIfDoesntExist(ini, "WeaponInfo", key);
			}
			sendPlayerMessage(playerid, "You successfully registered!", COLOR_YELLOW, true);
			loginPlayer(playerid);
			return 1;
		}		
		sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "/register [password]", COLOR_RED, true);
		return 1;
	}
	if(cmd[0] == "/login") {
		if(cmd.len() >= 2) {
		    if(pInfo[playerid].LoggedIn == 1) return sendPlayerMessage(playerid, "You're already logged in, noob!", COLOR_RED, true);
		    local ini = EasyINI("AAD/Users/" + getPlayerName(playerid) + ".ini");
		    local encryptedpass = md5(cmd[1].tolower());
			if(encryptedpass == ini.getKey("Login", "password")) { loginPlayer(playerid);
			} else {
			    sendPlayerMessage(playerid, "Incorrect Password.", COLOR_RED, true);
			    return 1;
		    }
		    return 1;
		}    
		sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "/login [password]", COLOR_RED, true);
	    return 1;	
	}
	if(cmd[0] == "/pm") {
        if(cmd.len() >= 2) {
			local playertopm = getPlayerIDFromNameOrID(cmd[1]);
			if(playertopm == -1 || playertopm == playerid || !isNumeric(playertopm)) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "Invalid player", COLOR_RED, true);
			if(isPlayerConnected(playertopm)) {
			    local pm = command.slice(cmd[0].len() + cmd[1].len() + 2, command.len());
			    sendPlayerMessage(playertopm, "PM From " + getPlayerName(playerid) + ": " + COLOR_WHITE2 + pm, COLOR_YELLOW, true); 
			    sendPlayerMessage(playerid, "PM to " + getPlayerName(playertopm) + ": " + COLOR_WHITE2 pm, COLOR_YELLOW, true);
			    return 1;
			}
			return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "Invalid player");
		}
		return sendPlayerMessage(playerid, COLOR_RED2 + "Usage: " + COLOR_WHITE2 + " /pm [id/name] [message]", COLOR_RED, true);
	}
	if(cmd[0] == "/changepass" || cmd[0] == "/changepassword") {
	    if(pInfo[playerid].LoggedIn == 0) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "Your not logged in.", COLOR_RED, true);
		if(cmd.len() >= 2) {
			local password = md5(cmd[1].tolower());
			local ini = EasyINI("AAD/Users/" + getPlayerName(playerid) + ".ini");
			ini.setKey("Login", "password", password);
			ini.saveData();
			return sendPlayerMessage(playerid, "Your password has been changed.", COLOR_GREEN);
		}
		return sendPlayerMessage(playerid, COLOR_RED2 + "Usage: " + COLOR_WHITE2 + " /changepass [newpass]", COLOR_RED, true);
	}	
	if(LogFunctions == 1) log("onPlayerCommand " + getPlayerName(playerid) + " " + command);  		    	
	for(local p=0; p <= Server[0].HighestID+1; ++p) {
        if(isPlayerConnected(p) && IsPlayerAdmin(p)) {
			if(!IsPlayerAdmin(playerid)) sendPlayerMessage(p, getPlayerName(playerid) + " has used the command " + command, COLOR_BLUE);
        }
    } 
    if(pInfo[playerid].LoggedIn != 1) return sendPlayerMessage(playerid, "Login please.", COLOR_RED, true);
	if(cmd[0] == "/duel") {
		//This started off as a duel script, this was the first code blocks i created, if it is a bit sloppier then the rest, you know why.
		
	    if(cmd.len() == 1) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "/duel [invite/accept]", COLOR_RED, true);
	    if(cmd[1] == "invite") {
	        if(isPlayerInRound(playerid)) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "You cannot start a duel while in a base!", COLOR_RED, true);
	        if(cmd.len() == 2) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "No player ID given", COLOR_RED, true);
	        if(Duel[playerid].inviter == 1) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "You already invited someone!", COLOR_RED, true);
	        if(Duel[playerid].inDuel == 1) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "Finish your own duel!", COLOR_RED, true);
	        local tmp = getPlayerIDFromNameOrID(cmd[2]);
	        if(tmp == playerid) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "You cannot invite yourself!", COLOR_RED, true);
	        if(!isPlayerConnected(tmp)) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "Invalid player id", COLOR_RED, true);
	        if(Duel[tmp].invitee == 1) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "This player has already been invited", COLOR_RED, true);
	        if(cmd.len() == 3) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "Pick your weapons.", COLOR_RED, true);
	        if(cmd.len() == 4) Duel[playerid].wep1 <- cmd[3];
	        if(cmd.len() == 5) { Duel[playerid].wep1 <- cmd[3]; Duel[playerid].wep2 <- cmd[4]; }
	        if(cmd.len() == 6) { Duel[playerid].wep1 <- cmd[3]; Duel[playerid].wep2 <- cmd[4]; Duel[playerid].wep3 <- cmd[5]; }
	        if(cmd.len() == 7) { Duel[playerid].wep1 <- cmd[3]; Duel[playerid].wep2 <- cmd[4]; Duel[playerid].wep3 <- cmd[5]; Duel[playerid].wep4 <- cmd[6]; }
	        if(cmd.len() == 8) { Duel[playerid].wep1 <- cmd[3]; Duel[playerid].wep2 <- cmd[4]; Duel[playerid].wep3 <- cmd[5]; Duel[playerid].wep4 <- cmd[6]; Duel[playerid].wep5 <- cmd[7]; }
	        local tmp6, tmp2, tmp3, tmp4, tmp5;
	        if(isNumeric(Duel[playerid].wep1)) tmp6 = Duel[playerid].wep1.tointeger();
	        if(!isNumeric(Duel[playerid].wep1)) tmp6 = getWeaponIDFromName(Duel[playerid].wep1).tointeger();
	        if(isNumeric(Duel[playerid].wep2)) tmp2 = Duel[playerid].wep2.tointeger();
	        if(!isNumeric(Duel[playerid].wep2)) tmp2 = getWeaponIDFromName(Duel[playerid].wep2).tointeger();
	        if(isNumeric(Duel[playerid].wep3)) tmp3 = Duel[playerid].wep3.tointeger();
	        if(!isNumeric(Duel[playerid].wep3)) tmp3 = getWeaponIDFromName(Duel[playerid].wep3).tointeger();
	        if(isNumeric(Duel[playerid].wep4)) tmp4 = Duel[playerid].wep4.tointeger();
	        if(!isNumeric(Duel[playerid].wep4)) tmp4 = getWeaponIDFromName(Duel[playerid].wep4).tointeger();
	        if(isNumeric(Duel[playerid].wep5)) tmp5 = Duel[playerid].wep5.tointeger();
	        if(!isNumeric(Duel[playerid].wep5)) tmp5 = getWeaponIDFromName(Duel[playerid].wep5).tointeger();
	        Duel[playerid].wep1 = tmp6;
	        Duel[playerid].wep2 = tmp2;
	        Duel[playerid].wep3 = tmp3;
	        Duel[playerid].wep4 = tmp4;
	        Duel[playerid].wep5 = tmp5;
	        if(!isValidWep(tmp6) || !isValidWep(tmp2) || !isValidWep(tmp3) || !isValidWep(tmp4) || !isValidWep(tmp5)) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "Invalid Weapon(s)", COLOR_RED, true); 
	        sendPlayerMessage(playerid, "Invited " + getPlayerName(tmp) + " To a duel", COLOR_GREEN);
	        Duel[playerid].duelinvited = 1; // invited a player
	        sendPlayerMessage(tmp, "You've been invited to a duel by " + getPlayerName(playerid) + " Type /duel accept to accept.", COLOR_RED, true);  
	        if(cmd.len() == 8) { sendPlayerMessage(tmp, "(Weapons: " + WeaponNames[tmp6] + ", " + WeaponNames[tmp2] + ", " + WeaponNames[tmp3] + ", " + WeaponNames[tmp4] + ", " + WeaponNames[tmp5] + ")", COLOR_YELLOW, true); sendPlayerMessage(playerid, "(Weapons: " + WeaponNames[tmp6] + ", " + WeaponNames[tmp2] + ", " + WeaponNames[tmp3] + ", " + WeaponNames[tmp4] + ", " + WeaponNames[tmp5] + ")", COLOR_YELLOW, true); }
	        if(cmd.len() == 7) { sendPlayerMessage(tmp, "(Weapons: " + WeaponNames[tmp6] + ", " + WeaponNames[tmp2] + ", " + WeaponNames[tmp3] + ", " + WeaponNames[tmp4] + ")", COLOR_YELLOW, true); sendPlayerMessage(playerid, "(Weapons: " + WeaponNames[tmp6] + ", " + WeaponNames[tmp2] + ", " + WeaponNames[tmp3] + ", " + WeaponNames[tmp4] + ")", COLOR_YELLOW, true); }
	        if(cmd.len() == 6) { sendPlayerMessage(tmp, "(Weapons: " + WeaponNames[tmp6] + ", " + WeaponNames[tmp2] + ", " + WeaponNames[tmp3] + ")", COLOR_YELLOW, true); sendPlayerMessage(playerid, "(Weapons: " + WeaponNames[tmp6] + ", " + WeaponNames[tmp2] + ", " + WeaponNames[tmp3] + ")", COLOR_YELLOW, true); }
	        if(cmd.len() == 5) { sendPlayerMessage(tmp, "(Weapons: " + WeaponNames[tmp6] + ", " + WeaponNames[tmp2] + ")", COLOR_YELLOW, true); sendPlayerMessage(playerid, "(Weapons: " + WeaponNames[tmp6] + ", " + WeaponNames[tmp2] + ")", COLOR_YELLOW, true); }
	        if(cmd.len() == 4) { sendPlayerMessage(tmp, "(Weapon: " + WeaponNames[tmp6] + ")", COLOR_YELLOW, true); sendPlayerMessage(playerid, "(Weapon: " + WeaponNames[tmp6] + ")", COLOR_YELLOW, true); }
	        Duel[tmp].invitee <- 1;
	        Duel[tmp].invitedby <- playerid;
	        Duel[playerid].invitedby <- tmp;
	        return 1;
	    }	        
	    if(cmd[1] == "accept") {
	        if(Duel[playerid].invitee == 0) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "You have not been invited to a duel.", COLOR_RED, true);
	        if(Duel[playerid].inDuel == 1) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "You are already in a duel", COLOR_RED, true);
	        if(Duel[playerid].invitee == 1) {
	            sendPlayerMessage(playerid, "Duel accepted.", COLOR_YELLOW, true);
	            local inviter = Duel[playerid].invitedby;
	            sendMessageToAll("A duel between " + getPlayerName(playerid) + " And " + getPlayerName(inviter) + " has begun!", COLOR_GREEN);
                setPlayerCoordinates(playerid, 2528.242188, 116.889923, 5.837966);
	            setPlayerCoordinates(inviter, 2571.886719, 168.665863, 5.837985);
	            setPlayerHealth(playerid, 200);
	            setPlayerHealth(inviter, 200);
	            setPlayerArmour(playerid, 200);
	            setPlayerArmour(inviter, 200);
	            local tmp = Duel[inviter].wep1;
	            local tmp2 = Duel[inviter].wep2;
	            local tmp3 = Duel[inviter].wep3;
	            local tmp4 = Duel[inviter].wep4;
	            local tmp5 = Duel[inviter].wep5;
	            givePlayerWeapon(playerid, tmp, 9999)
	            givePlayerWeapon(playerid, tmp2, 9999)
	            givePlayerWeapon(playerid, tmp3, 9999)
	            givePlayerWeapon(playerid, tmp4, 9999)
	            givePlayerWeapon(playerid, tmp5, 9999)
	            givePlayerWeapon(inviter, tmp, 9999)
	            givePlayerWeapon(inviter, tmp2, 9999)
	            givePlayerWeapon(inviter, tmp3, 9999)
	            givePlayerWeapon(inviter, tmp4, 9999)
	            givePlayerWeapon(inviter, tmp5, 9999)
	            Duel[playerid].inDuel = 1;
	            Duel[inviter].inDuel = 1;
	            return 1;
	        }
	    }
	    return 1;
	}
	if(cmd[0] == "/a") {
	    if(!IsPlayerAdmin(playerid)) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "You are not an admin", COLOR_RED, true);
	    if(cmd.len() < 2) return sendPlayerMessage(playerid, COLOR_RED2 + "Usage: " + COLOR_WHITE2 + " /a [create/Attackers/Defenders/edit/gotodef/gotoatt/description]", COLOR_RED, true);
	    if(cmd[1] == "create") {
	        local tmp = getHighestTDMID();
            tmp++;
	        local ini = EasyINI("AAD/tdm/" + tmp + ".ini");
	        if(cmd.len() > 3) {
				local description = command.slice(cmd[0].len() + cmd[1].len() + 2, command.len());
				TDMs[tmp].Description = description.tostring();
				ini.setKey("Description", "Description", description);
			}
			TDMs[tmp].Creator = getPlayerName(playerid).tostring(); 
	        ini.setKey("Creator", "Creator", getPlayerName(playerid));
	        ini.setKey("Stats", "AttackerWins", 0);
	        ini.setKey("Stats", "DefenderWins", 0);
	        ini.setKey("Stats", "Timesplayed", 0);
	        ini.saveData();
	        sendPlayerMessage(playerid, "You created a TDM and the ID is: '" + tmp + "'", COLOR_YELLOW, true);
	        pInfo[playerid].roundidcreated = tmp;
	        pInfo[playerid].lastmodecreated = "tdm";
	        sendPlayerMessage(playerid, "Use /a [Attackers/Defenders] to add locations", COLOR_BLUE);
	    }
	    if(cmd[1] == "attackers") {
	        if(pInfo[playerid].roundidcreated != -1 && pInfo[playerid].lastmodecreated == "tdm") {
	            local ini = EasyINI("AAD/tdm/" + pInfo[playerid].roundidcreated + ".ini");
	            local pos = getPlayerCoordinates(playerid);
	            
	            TDMs[pInfo[playerid].roundidcreated].AttackerX = pos[0].tofloat();
	            TDMs[pInfo[playerid].roundidcreated].AttackerY = pos[1].tofloat();
	            TDMs[pInfo[playerid].roundidcreated].AttackerZ = pos[2].tofloat();
	            
                ini.setKey("Attackers", "x", pos[0].tostring());
                ini.setKey("Attackers", "y", pos[1].tostring());
                ini.setKey("Attackers", "z", pos[2].tostring());
                ini.saveData();
                
                sendPlayerMessage(playerid, "Attackers position saved.", COLOR_YELLOW, true);
            } else {
                sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "You have not created a tdm recently, therfore, you cannot edit spawns.", COLOR_YELLOW, true);
            }    
        }
        if(cmd[1] == "defenders") {        
	        if(pInfo[playerid].roundidcreated != -1 && pInfo[playerid].lastmodecreated == "tdm") {
	            local ini = EasyINI("AAD/tdm/" + pInfo[playerid].roundidcreated + ".ini");
	            local pos = getPlayerCoordinates(playerid);
	            
	            TDMs[pInfo[playerid].roundidcreated].DefenderX = pos[0].tofloat();
	            TDMs[pInfo[playerid].roundidcreated].DefenderY = pos[1].tofloat();
	            TDMs[pInfo[playerid].roundidcreated].DefenderZ = pos[2].tofloat();
	            
                ini.setKey("Defenders", "x", pos[0].tostring());
                ini.setKey("Defenders", "y", pos[1].tostring());
                ini.setKey("Defenders", "z", pos[2].tostring());
                ini.saveData();
                sendPlayerMessage(playerid, "Defenders position saved.", COLOR_YELLOW, true);
           } else {
                sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "You have not created a tdm recently, therfore, you cannot edit spawns.", COLOR_YELLOW, true);
           } 
        }
        if(cmd[1] == "edit") {
            if(cmd.len() >= 3) {
                if(!isNumeric(cmd[2])) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "Invalid tdm", COLOR_RED, true);
                local tdmid = cmd[2].tointeger();
                if(!fexist("AAD/tdm/" + tdmid + ".ini")) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "tdm does not exist!");
				pInfo[playerid].roundidcreated = tdmid;
				pInfo[playerid].lastmodecreated = "tdm";
				sendPlayerMessage(playerid, "Your now editing tdm " + tdmid, COLOR_GREEN);
				return sendPlayerMessage(playerid, "/a [Attackers/Defenders] to create spawn points.", COLOR_BLUE);
			}
			return sendPlayerMessage(playerid, COLOR_RED2 + "Usage: " + COLOR_WHITE2 + " /a edit [tdmid]", COLOR_RED, true);
		}
		if(cmd[1] == "gotoatt") {
			if(cmd.len() >= 3) {
                if(!isNumeric(cmd[2])) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "Invalid TDM", COLOR_RED, true);
                local tdmid = cmd[2].tointeger();
                if(!fexist("AAD/tdm/" + tdmid + ".ini")) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "TDM does not exist!");
                setPlayerCoordinates(playerid, TDMs[tdmid].AttackerX, TDMs[tdmid].AttackerY, TDMs[tdmid].AttackerZ);
            }
            else return sendPlayerMessage(playerid, COLOR_RED2 + "Usage: " + COLOR_WHITE2 + " /a gotoatt [tdmid]", COLOR_RED, true);
        }
        if(cmd[1] == "gotodef") {
			if(cmd.len() >= 3) {
                if(!isNumeric(cmd[2])) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "Invalid TDM", COLOR_RED, true);
                local tdmid = cmd[2].tointeger();
                if(!fexist("AAD/tdm/" + tdmid + ".ini")) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "TDM does not exist!");
                setPlayerCoordinates(playerid, TDMs[tdmid].DefenderX, TDMs[tdmid].DefenderY, TDMs[tdmid].DefenderZ);
            }
            else return sendPlayerMessage(playerid, COLOR_RED2 + "Usage: " + COLOR_WHITE2 + " /a gotodef [tdmid]", COLOR_RED, true);
        }
        if(cmd[1] == "description") {
			if(cmd.len() >= 3) {
				//if(!isNumeric(cmd[2])) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "Invalid TDM", COLOR_RED, true);
                local tdmid = pInfo[playerid].roundidcreated;
                if(!fexist("AAD/tdm/" + baseid + ".ini")) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "TDM does not exist - use /a edit to edit a TDM!");
                local ini = EasyINI("AAD/tdm/" + tdmid + ".ini");
                local description = command.slice(cmd[0].len() + cmd[1].len() + 2, command.len());
                ini.setKey("Description", "Description", description);
                ini.saveData();
                TDMs[tdmid] = description;
                sendPlayerMessage(playerid, "You've set TDM id: " + tdmid + " description too: " + description);
            }
            else return sendPlayerMessage(playerid, COLOR_RED2 + "Usage: " + COLOR_WHITE2 + " /a description [Description of TDM]", COLOR_RED, true);
        }    
        return 1;       
	}
    if(cmd[0] == "/b") {
	    if(!IsPlayerAdmin(playerid)) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "You are not an admin", COLOR_RED, true);
	    if(cmd.len() < 2) return sendPlayerMessage(playerid, COLOR_RED2 + "Usage: " + COLOR_WHITE2 + " /b [create/Attackers/Defenders/cp/edit/gotoatt/gotodef/gotocp/description]", COLOR_RED, true);
	    if(cmd[1] == "create") {
	        local tmp = getHighestTDMID();
            tmp++;
	        local ini = EasyINI("AAD/tdm/" + tmp + ".ini");
			if(cmd.len() > 3) {
				local description = command.slice(cmd[0].len() + cmd[1].len() + 2, command.len());
				Bases[tmp].Description = description;
				ini.setKey("Description", "Description", description);
			}	
	        ini.setKey("Creator", "Creator", getPlayerName(playerid).tostring());
	        ini.setKey("Stats", "AttackerWins", 0);
	        ini.setKey("Stats", "DefenderWins", 0);
	        ini.setKey("Stats", "Timesplayed", 0);
	        ini.saveData();
	        sendPlayerMessage(playerid, "You created a Base and the ID is: '" + tmp + "'", COLOR_YELLOW, true);
	        pInfo[playerid].roundidcreated = tmp;
	        pInfo[playerid].lastmodecreated = "base";
	        sendPlayerMessage(playerid, "Use /b [Attackers/Defenders/cp] to add locations", COLOR_BLUE);
	    }
	    if(cmd[1] == "attackers") {
	        if(pInfo[playerid].roundidcreated != -1 && pInfo[playerid].lastmodecreated == "base") {
				local tmp = pInfo[playerid].roundidcreated;
	            local ini = EasyINI("AAD/bases/" + tmp + ".ini");
	            local pos = getPlayerCoordinates(playerid);
                ini.setKey("Attackers", "x", pos[0].tostring());
                ini.setKey("Attackers", "y", pos[1].tostring());
                ini.setKey("Attackers", "z", pos[2].tostring());
                ini.saveData();
                
                Bases[tmp].AttackerX = pos[0].tofloat();
                Bases[tmp].AttackerY = pos[1].tofloat();
                Bases[tmp].AttackerZ = pos[2].tofloat();
                
                sendPlayerMessage(playerid, "Attackers position saved.", COLOR_YELLOW, true);
            } else {
                sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "You have not created a base recently, therfore, you cannot edit spawns.", COLOR_YELLOW, true);
            }    
        }
        if(cmd[1] == "defenders") {        
	        if(pInfo[playerid].roundidcreated != -1 && pInfo[playerid].lastmodecreated == "base") {
	        
	            local tmp = pInfo[playerid].roundidcreated;
	            local ini = EasyINI("AAD/bases/" + tmp + ".ini");
	            local pos = getPlayerCoordinates(playerid);
	            
                ini.setKey("Defenders", "x", pos[0].tostring());
                ini.setKey("Defenders", "y", pos[1].tostring());
                ini.setKey("Defenders", "z", pos[2].tostring());
                ini.saveData();
                
                Bases[tmp].DefenderX = pos[0].tofloat();
                Bases[tmp].DefenderY = pos[1].tofloat();
                Bases[tmp].DefenderZ = pos[2].tofloat();
                
                sendPlayerMessage(playerid, "Defenders position saved.", COLOR_YELLOW, true);
           } else {
                sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "You have not created a base recently, therfore, you cannot edit spawns.", COLOR_YELLOW, true);
           } 
        }
        if(cmd[1] == "cp") {
             if(pInfo[playerid].roundidcreated != -1 && pInfo[playerid].lastmodecreated == "base") {
	            local tmp = pInfo[playerid].roundidcreated;
	            local ini = EasyINI("AAD/bases/" + tmp + ".ini");
                local pos = getPlayerCoordinates(playerid);
                ini.setKey("Checkpoint", "x", pos[0].tostring());
                ini.setKey("Checkpoint", "y", pos[1].tostring());
                ini.setKey("Checkpoint", "z", pos[2].tostring());
                ini.saveData();
                
                Bases[tmp].CheckpointX = pos[0].tofloat();
                Bases[tmp].CheckpointY = pos[1].tofloat();
                Bases[tmp].CheckpointZ = pos[2].tofloat();
                
                sendPlayerMessage(playerid, "Checkpoint position saved.", COLOR_YELLOW, true);
            } else {
                sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "You have not created a base recently, therfore, you cannot edit spawns.", COLOR_RED, true);
            } 
        }
        if(cmd[1] == "edit") {
            if(cmd.len() >= 3) {
                if(!isNumeric(cmd[2])) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "Invalid base", COLOR_RED, true);
                local baseid = cmd[2].tointeger();
                if(!fexist("AAD/bases/" + baseid + ".ini")) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "Base does not exist!");
				pInfo[playerid].roundidcreated = baseid;
				pInfo[playerid].lastmodecreated = "base";
				sendPlayerMessage(playerid, "Your not editing base " + baseid, COLOR_GREEN);
				return sendPlayerMessage(playerid, "/b [Attackers/Defenders/cp] to create spawn points.");
			}
			return sendPlayerMessage(playerid, COLOR_RED2 + "Usage: " + COLOR_WHITE2 + " /b edit [baseid]", COLOR_RED, true);
		}
		if(cmd[1] == "gotoatt") {
			if(cmd.len() >= 3) {
                if(!isNumeric(cmd[2])) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "Invalid base", COLOR_RED, true);
                local baseid = cmd[2].tointeger();
                if(!fexist("AAD/bases/" + baseid + ".ini")) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "Base does not exist!");
                setPlayerCoordinates(playerid, Bases[baseid].AttackerX, Bases[baseid].AttackerY, Bases[baseid].AttackerZ);
            }
            else return sendPlayerMessage(playerid, COLOR_RED2 + "Usage: " + COLOR_WHITE2 + " /b gotoatt [baseid]", COLOR_RED, true);
        }
        if(cmd[1] == "gotodef") {
			if(cmd.len() >= 3) {
                if(!isNumeric(cmd[2])) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "Invalid base", COLOR_RED, true);
                local baseid = cmd[2].tointeger();
                if(!fexist("AAD/bases/" + baseid + ".ini")) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "Base does not exist!");
                setPlayerCoordinates(playerid, Bases[baseid].DefenderX, Bases[baseid].DefenderY, Bases[baseid].DefenderZ);
            }
            else return sendPlayerMessage(playerid, COLOR_RED2 + "Usage: " + COLOR_WHITE2 + " /b gotodef [baseid]", COLOR_RED, true);
        }
        if(cmd[1] == "gotocp") {
			if(cmd.len() >= 3) {
                if(!isNumeric(cmd[2])) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "Invalid base", COLOR_RED, true);
                local baseid = cmd[2].tointeger();
                if(!fexist("AAD/bases/" + baseid + ".ini")) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "Base does not exist!");
                setPlayerCoordinates(playerid, Bases[baseid].CheckpointX, Bases[baseid].CheckpointY, Bases[baseid].CheckpointZ);
            }
            else return sendPlayerMessage(playerid, COLOR_RED2 + "Usage: " + COLOR_WHITE2 + " /b gotocp [baseid]", COLOR_RED, true);
        }
        if(cmd[1] == "description") {
			if(cmd.len() >= 3) {
				//if(!isNumeric(cmd[2])) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "Invalid base", COLOR_RED, true);
                local baseid = pInfo[playerid].roundidcreated;
                if(!fexist("AAD/bases/" + baseid + ".ini")) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "Base does not exist - use /b edit to edit a base!");
                local ini = EasyINI("AAD/bases/" + baseid + ".ini");
                local description = command.slice(cmd[0].len() + cmd[1].len() + 2, command.len());
                ini.setKey("Description", "Description", description);
                ini.saveData();
                
                Bases[baseid].Description = description
                sendPlayerMessage(playerid, "You've set base id: " + baseid + " description too: " + description);
            }
            else return sendPlayerMessage(playerid, COLOR_RED2 + "Usage: " + COLOR_WHITE2 + " /b description [description of base]", COLOR_RED, true);
        }                   
        return 1;       
	}
	if(cmd[0] == "/force") {
		if(!IsPlayerAdmin(playerid)) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "Your not an admin!", COLOR_RED, true);
		if(cmd.len() < 2) return sendPlayerMessage(playerid, COLOR_RED2 + "Usage: " + COLOR_WHITE2 + " /force [playerid/name]", COLOR_RED, true);
		local targetid = getPlayerIDFromNameOrID(cmd[1]);
		if(!isPlayerConnected(targetid)) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "This player is not connected", COLOR_RED, true); 
		if(isPlayerInRound(targetid) == 1) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "You cannot use this to players who are in a round", COLOR_RED, true);
		sendMessageToAll2(getPlayerName(playerid) + " has forced " + getPlayerName(targetid) + " into auto asign", COLOR_YELLOW, true);
		return autoAsignPlayer(targetid);	
	}	
	if(cmd[0] == "/aka") {
	    if(!IsPlayerAdmin(playerid)) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "your not an admin!", COLOR_RED, true);
	    if(cmd.len() <= 1) return sendPlayerMessage(playerid, COLOR_RED2 + "Usage: " + COLOR_WHITE2 + " /aka [playerid/name]", COLOR_RED, true);
	    local targetid = getPlayerIDFromNameOrID(cmd[1]);
	    if(!isPlayerConnected(targetid)) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "This player is not connected.", COLOR_RED, true);
	    local ip = getPlayerIp(targetid).tostring();
	    local aka = EasyINI("AAD/aka.txt");
	    if(aka.getKey("AKA", ip) == null) {
			sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "To prevent crashing of the server, you cannot use this command on this specific player.", COLOR_RED, true);
			sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "The reason behind this is most likely because this player had once connected to this server with []'s in there name", COLOR_RED, true);
			sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "I know right, what a shitty error, but without going into much detail, this would crash the server.", COLOR_RED, true);
			sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "If you most know this players AKA, you can check it in the aka file scripts/AAD/aka.txt", COLOR_RED, true);
			return 1;
		}	
	    sendPlayerMessage(playerid, getPlayerName(targetid) + " (" + ip + ")", COLOR_BLUE);
	    return sendPlayerMessage(playerid, "AKA: " + aka.getKey("AKA", ip), COLOR_BLUE);
	}
	if(cmd[0] == "/vote") {
		if(cmd.len() < 3) return sendPlayerMessage(playerid, COLOR_RED2 + "Usage: " + COLOR_WHITE2 + " /vote [base/tdm] [baseid/tdmid]", COLOR_RED, true);
		if(cmd[1] == "base") {
			if(!fexist("AAD/bases/" + cmd[2] + ".ini")) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "This base does not exist", COLOR_RED, true);
			if(IsBaseStarted == 1) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "A round is already started.", COLOR_RED, true);
			pInfo[playerid].Voted = cmd[2].tointeger();
			pInfo[playerid].VotedMode = "base";
			sendMessageToAll(getPlayerName(playerid) + " has voted for Base #" + cmd[2], COLOR_YELLOW, true);
			Timers[0].VoteTimer = timer(VoteTimer, 30000, 1);
		}
		else if(cmd[1] == "tdm") {
			if(!fexist("AAD/tdm/" + cmd[2] + ".ini")) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "This tdm does not exist", COLOR_RED, true);
			if(IsBaseStarted == 1) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "A round is already started.", COLOR_RED, true);
			pInfo[playerid].Voted = cmd[2].tointeger();
			pInfo[playerid].VotedMode = "tdm";
			sendMessageToAll(getPlayerName(playerid) + " has voted for TDM #" + cmd[2], COLOR_YELLOW, true);
			Timers[0].VoteTimer = timer(VoteTimer, 30000, 1);
		}	
		return 1;
	}
	if(cmd[0] == "/votestop") {
		if(!IsPlayerAdmin(playerid)) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "Your not an admin!", COLOR_RED, true);
		for(local i=0; i < Server[0].HighestID+1; ++i) {
			if(isPlayerConnected(i)) {
				pInfo[i].Voted = -1;
			}
		}
		if(Timers[0].VoteTimer.isActive()) Timers[0].VoteTimer.kill();
		sendMessageToAll("Admin " + getPlayerName(playerid) + " has stopped the vote!", COLOR_YELLOW, true);
		
		return 1;
	}		
	if(cmd[0] == "/resetscores") {
		if(!IsPlayerAdmin(playerid)) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "Your not an admin!", COLOR_RED, true);
		Server[0].tmpattwins = 0;
		Server[0].tmpdefwins = 0;
		if(Server[0].tmpattwins == 0 && Server[0].tmpdefwins == 0) return sendMessageToAll(getPlayerName(playerid) + " has reset the /scores", COLOR_YELLOW, true);
		else return sendPlayerMessage(playerid, "An unknown ERROR has occured... please retype the cmd", COLOR_RED, true);
	}	
	if(cmd[0] == "/commands" || cmd[0] == "/cmds" || cmd[0] == "/cmd") {
		sendPlayerMessage(playerid, "--- Player commands ---", COLOR_GREEN);
		sendPlayerMessage(playerid, "/register, /login, /changepass, /pm, /duel, /commands, /help, /afk, /back", COLOR_YELLOW, true);
		sendPlayerMessage(playerid, "/resetguns, /scores, /wlist, /stats, /gotopos, /killmsg, /rules, /car, /vcolor", COLOR_YELLOW, true);
		sendPlayerMessage(playerid, "/admins, /getgun, /removewep, /report, /gunlist, /c, /switch, /teams, /remove", COLOR_YELLOW, true);
		sendPlayerMessage(playerid, "/readd, /skin, /goto, /gethere, /t, /credits, /kill, /spawn", COLOR_YELLOW, true);
		if(IsPlayerAdmin(playerid)) sendPlayerMessage(playerid, "/admincmds for admin commands.", COLOR_GREEN);
		return 1;
	}
	if(cmd[0] == "/admincmds" || cmd[0] == "/admincmd" || cmd[0] == "/admincommands") {
		if(!IsPlayerAdmin(playerid)) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "Your not an admin!", COLOR_RED, true);
		if(pInfo[playerid].Admin >= 1) {
			sendPlayerMessage(playerid, "--- Admin commands ---", COLOR_GREEN);
			sendPlayerMessage(playerid, "/a, /b, /force, /aka, /resetscores, /admincmds, /automode, /unmute", COLOR_YELLOW, true);
			sendPlayerMessage(playerid, "/startbase, /starttdm, /slap, /disarm, /restartround, /setgravity", COLOR_YELLOW, true);
			sendPlayerMessage(playerid, "/mainspawn, /balance, /allvs, /say, /pause, /unpause, /mute, /eject", COLOR_YELLOW, true);
			sendPlayerMessage(playerid, "/jail, /unjail, /giveveh, /vclear, /lockteams,  /end, /movecp", COLOR_YELLOW, true);
			sendPlayerMessage(playerid, "/swap, /remove, /kick, /setteam, /settime, /announce, /add", COLOR_YELLOW, true);
		}
		if(pInfo[playerid].Admin >= 2) {
			sendPlayerMessage(playerid, "/nochat, /setserverpass, /ban, /banacc, /config, /setlevel, /delacc", COLOR_YELLOW, true);
		}
		return 1;
	}
	if(cmd[0] == "/help") {
		sendPlayerMessage(playerid, "Welcome to " + SCRIPT_NAME + " v" + SCRIPT_VERSION + " Hosted by " + Server[0].Website, COLOR_YELLOW, true);
		sendPlayerMessage(playerid, "/commands for command list", COLOR_YELLOW, true);
		return 1;
	}
	if(cmd[0] == "/automode") {
		if(!IsPlayerAdmin(playerid)) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "Your not an admin!", COLOR_RED, true);
		if(cmd.len() < 2) return sendPlayerMessage(playerid, COLOR_RED2 + "Usage: " + COLOR_WHITE2 + " /automode [base/tdm/off]", COLOR_RED, true);
		if(cmd[1] != "base" && cmd[1] != "tdm" && cmd[1] != "off") return sendPlayerMessage(playerid, COLOR_RED2 + "Usage: " + COLOR_WHITE2 + " /automode [base/tdm/off]", COLOR_RED, true);
		local ini = EasyINI("AAD/config.ini");
		if(cmd[1] == "base") {
			if(Server[0].Automode != -1) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "Automode is already enabled.");
			Server[0].Automode = "base";
			ini.setKey("Config", "Automode", "base");
			ini.saveData();
			Timers[0].AutomodeTimer = timer(StartRandRound, 1000, -1);		
			sendMessageToAll(getPlayerName(playerid) + " has turned on automode for bases! a random base will begin in 30 seconds!", COLOR_YELLOW, true);
			return 1;
		}
		else if(cmd[1] == "tdm") {
			if(Server[0].Automode != -1) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "Automode is already enabled.");
			Server[0].Automode = "tdm";
			Timers[0].AutomodeTimer = timer(StartRandRound, 1000, -1);
			ini.setKey("Config", "Automode", "tdm");
			ini.saveData();
			sendMessageToAll(getPlayerName(playerid) + " has turned on automode for tdms! a random tdm will begin in 30 seconds!", COLOR_YELLOW, true);
			return 1;
		}
		else if(cmd[1] == "off") {
			if(Server[0].Automode == -1) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "Automode is already off.", COLOR_RED, true);
			Server[0].Automode = -1;
			ini.setKey("Config", "Automode", -1);
			ini.saveData();
			AutoModeTimeLeft = 30;
			if(Timers[0].AutomodeTimer != null) Timers[0].AutomodeTimer.kill();
			sendMessageToAll(getPlayerName(playerid) + " has disabled automode.", COLOR_YELLOW, true);
			return 1;
		}	
		return sendPlayerMessage(playerid, "An unknown ERROR has occured, please retype this command", COLOR_RED, true);
	}
	if(cmd[0] == "/afk") {
		if(pInfo[playerid].AFK != 0) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "Your already AFK.", COLOR_RED, true);
		sendMessageToAll(getPlayerName(playerid) + " is now AFK", COLOR_YELLOW, true)
		setPlayerName(playerid, "AFK_" + getPlayerName(playerid));
		pInfo[playerid].team = 0;
		pInfo[playerid].AFK = 1;
		togglePlayerFrozen(playerid, true);
		return 1;
	}
	if(cmd[0] == "/back") {
		if(pInfo[playerid].AFK != 1) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "Your not AFK.", COLOR_RED, true);
		else sendMessageToAll(getPlayerName(playerid) + " is back from being AFK", COLOR_YELLOW, true);
		setPlayerName(playerid, pInfo[playerid].OriginalName);
		pInfo[playerid].AFK = 0;
		autoAsignPlayer(playerid);
		togglePlayerFrozen(playerid, false);
		return 1;
	}	
	if(cmd[0] == "/announce") {
		if(!IsPlayerAdmin(playerid)) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "Your not an admin", COLOR_RED, true);
		if(cmd.len() < 2) return sendPlayerMessage(playerid, COLOR_RED2 + "Usage: " + COLOR_WHITE2 + " /announce [text]", COLOR_RED, true);
		local text = command.slice(cmd[0].len() + 1, command.len());
		displayTextForAll(0.5, 0.5, text, 3000);
		return 1;
	}	
	if(cmd[0] == "/startbase") {
	    if(!IsPlayerAdmin(playerid)) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "You are not an admin", COLOR_RED, true);
	    if(isRoundStarted() == 1) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "A base/tdm is already started", COLOR_RED, true);
	    if(cmd.len() != 2) return sendPlayerMessage(playerid, COLOR_RED2 + "Usage: " + COLOR_WHITE2 + " /startbase [baseid]", COLOR_RED, true);
	    if(!isNumeric(cmd[1])) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "Invalid base ID.", COLOR_RED, true);
	    local baseid = cmd[1].tointeger();
	    if(baseid == -1) { sendMessageToAll2(getPlayerName(playerid) + " Has started base " + baseid, COLOR_YELLOW, true); return StartRandomBase(); Server[0].baseid = baseid; }
	    if(!fexist("AAD/bases/" + baseid + ".ini")) return sendPlayerMessage(playerid, "ERORR: Base ID does not exist", COLOR_RED, true);
	    sendMessageToAll2(getPlayerName(playerid) + " Has started base " + COLOR_RED2 + " " + baseid, COLOR_YELLOW, true);
	    StartBase(baseid);
	    Server[0].baseid = baseid;
	    return 1;
    }
    if(cmd[0] == "/starttdm") {
	    if(!IsPlayerAdmin(playerid)) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "You are not an admin", COLOR_RED, true);
	    if(isRoundStarted() == 1) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "A base is already started", COLOR_RED, true);
	    if(cmd.len() != 2) return sendPlayerMessage(playerid, COLOR_RED2 + "Usage: " + COLOR_WHITE2 + " /starttdm [tdmid]", COLOR_RED, true);
	    if(!isNumeric(cmd[1])) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "Invalid tdm ID.", COLOR_RED, true);
	    local tdmid = cmd[1].tointeger();
	    if(tdmid == -1) { sendMessageToAll(getPlayerName(playerid) + " Has started TDM " + tdmid, COLOR_YELLOW, true); return StartRandomTDM(); }
	    if(!fexist("AAD/tdm/" + tdmid + ".ini")) return sendPlayerMessage(playerid, "ERORR: TDM ID does not exist", COLOR_RED, true);
	    sendMessageToAll(getPlayerName(playerid) + " Has started TDM " + COLOR_RED2 + " " + tdmid, COLOR_YELLOW, true);
	    StartTDM(tdmid);
	    Server[0].baseid = tdmid;
	    return 1;
    }
    if(cmd[0] == "/slap") {
		if(!IsPlayerAdmin(playerid)) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "Your not an admin!", COLOR_RED, true);
		if(cmd.len() < 2) return sendPlayerMessage(playerid, COLOR_RED2 + "Usage: " + COLOR_WHITE2 + " /slap [playerid/name]", COLOR_RED, true);
		local targetid = getPlayerIDFromNameOrID(cmd[1]);
		if(!isPlayerConnected(targetid)) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "Invalid player!", COLOR_RED, true);
		if(isPlayerInRound(targetid)) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "You cannot use this to players who are in rounds!", COLOR_RED, true);
		local pos = getPlayerCoordinates(targetid);
		sendMessageToAll(getPlayerName(playerid) + " has bitch slapped " + getPlayerName(targetid), COLOR_YELLOW, true);
		return setPlayerCoordinates(targetid, pos[0], pos[1], pos[2]+15);
	}
	if(cmd[0] == "/disarm" || cmd[0] == "/resetguns" || cmd[0] == "/resetgun") {
		if(!IsPlayerAdmin(playerid) || cmd.len() < 2) {
			resetPlayerGuns(playerid);
			sendPlayerMessage(playerid, "WEP INFO: Your weapons have been removed", COLOR_BLUE);
			return 1;
		}
		local targetid = getPlayerIDFromNameOrID(cmd[1]);
		if(!isPlayerConnected(targetid)) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "This player is not connected!", COLOR_RED, true);
		resetPlayerGuns(playerid);
		sendPlayerMessage(playerid, "Reset " + getPlayerName(targetid) + "'s guns", COLOR_YELLOW, true);
		return 1;
	}	
    if(cmd[0] == "/restartround" || cmd[0] == "/restartbase" || cmd[0] == "/restarttdm") {
        if(!IsPlayerAdmin(playerid)) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "Your not an admin!", COLOR_RED, true);
        if(IsBaseStarted == 0) return sendPlayerMessage(playerid, "A base isn't started!", COLOR_RED, true);
        local tmp = Server[0].baseid;
        local tmp2 = null;
        if(IsTDMStarted == 1) tmp2 = "tdm";
        else if(IsBaseStarted == 1)tmp2 = "base";
        endBase();
        if(tmp2 == "base") StartBase(tmp);
        else if(tmp2 == "tdm") StartTDM(tmp);
        sendMessageToAll(getPlayerName(playerid) + " Has restarted base " + tmp, COLOR_YELLOW, true);
        return 1;
    }
    if(cmd[0] == "/scores" || cmd[0] == "/score") {
        sendMessageToAll("Attacker Wins: " + Server[0].tmpattwins, COLOR_YELLOW, true);
        sendMessageToAll("Defender Wins: " + Server[0].tmpdefwins, COLOR_YELLOW, true);
        return 1;
    }
    if(cmd[0] == "/wlist" || cmd[0] == "/wlists" || cmd[0] == "/wsets" || cmd[0] == "/gunmenu") {
		showGunMenu(playerid);
		return 1;
	}	
    if(cmd[0] == "/stats") {
        local targetid;
        if(cmd.len() >= 2) targetid = getPlayerIDFromNameOrID(cmd[1]);
        if(cmd.len() <= 2) targetid = playerid;
        if(!isPlayerConnected(targetid)) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "Invalid player!", COLOR_RED, true);
        local ini = EasyINI("AAD/Users/" + getPlayerName(targetid) + ".ini");
        local ip = ini.getKey("Login", "IP");
        local lvl = ini.getKey("Login", "level").tointeger();
        local skin = ini.getKey("Skin", "Skin");
        if(skin == null) skin = "None";
		else if(skin != null) skin.tointeger();
        local roundwins = ini.getKey("Stats", "RoundWins").tointeger();
        local roundlosses = ini.getKey("Stats", "RoundLosses").tointeger();
        local duelwins = ini.getKey("Stats", "DuelWins").tointeger();
        local duellosses = ini.getKey("Stats", "DuelLosses").tointeger();
        local kills = ini.getKey("Stats", "Kills").tointeger();
        local deaths = ini.getKey("Stats", "Deaths").tointeger();
        sendPlayerMessage(playerid, "Account name: " + getPlayerName(targetid), COLOR_GREEN);
		if(IsPlayerAdmin(playerid)) sendPlayerMessage(playerid, "IP: " + ip, COLOR_GREEN)
		sendPlayerMessage(playerid, "Admin level: " + lvl, COLOR_GREEN);
		sendPlayerMessage(playerid, "Favorite skin: " + skin, COLOR_GREEN);
		if(kills != 0 && deaths != 0) sendPlayerMessage(playerid, "Kills: " + kills + " Deaths: " + deaths + " K/D: " + kills / deaths, COLOR_GREEN);
		sendPlayerMessage(playerid, "Round wins: " + roundwins + ", Round Losses: " + roundlosses, COLOR_GREEN);
		if(duelwins != 0 && duellosses != 0) sendPlayerMessage(playerid, "Duel wins: " + duelwins + ", Duel losses: " + duellosses + " Ratio: " + duelwins / duellosses, COLOR_GREEN); 			
		return 1;
	}
	if(cmd[0] == "/gotopos" || cmd[0] == "/gotocoords" || cmd[0] == "/gotocoordinates") {
		if(cmd.len() < 4) return sendPlayerMessage(playerid, COLOR_RED2 + "Usage: " + COLOR_WHITE2 + " /gotopos [x], [y], [z]", COLOR_RED, true);
		if(isRoundStarted() == 1) return sendPlayerMessage(playerid, "You cannot use this command during a round!", COLOR_RED, true);
		if(!IsPlayerAdmin(playerid)) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "Your not an admin!", COLOR_RED, true);
		if(!isFloat(cmd[1]) || !isFloat(cmd[2]) || !isFloat(cmd[3])) return sendPlayerMessage(playerid, COLOR_RED2 + "Usage: " + COLOR_WHITE2 + " /gotopos [x], [y], [z]", COLOR_RED, true);
		else return setPlayerCoordinates(playerid, cmd[1].tofloat(), cmd[2].tofloat(), cmd[3].tofloat());
	}
	if(cmd[0] == "/nochat" || cmd[0] == "/disallowchat" || cmd[0] == "/allowchat" || cmd[0] == "/chat") {
		if(pInfo[playerid].Admin != 2) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "You must be level 2 or higher to use this command!", COLOR_RED, true);
		if(Server[0].Nochat == 0) { Server[0].Nochat = 1; sendMessageToAll2(getPlayerName(playerid) + " has disabled the global chat!", COLOR_YELLOW, true); }
		else if(Server[0].Nochat == 1) { Server[0].Nochat = 0; sendMessageToAll2(getPlayerName(playerid) + " has enabled the global chat!", COLOR_YELLOW, true); }
		return 1;
	}		  
    if(cmd[0] == "/setgravity") {
        if(!IsPlayerAdmin(playerid)) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "You are not an admin", COLOR_RED, true);
        if(cmd.len() >= 2) {
			if(!isNumeric(cmd[1])) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "Invalid gravity!", COLOR_RED, true);
			for(local i=0; i <= Server[0].HighestID+1; ++i) if(isPlayerConnected(i)) {
				setPlayerGravity(i, cmd[1].tofloat());
			}
			return sendMessageToAll(getPlayerName(playerid) + " Has set everyones gravity to " + cmd[1], COLOR_YELLOW, true);
		}	
		return sendPlayerMessage(playerid, COLOR_RED2 + "Usage: " + COLOR_WHITE2 + " /setgravity [Gravity]", COLOR_RED, true);
	}			  
    if(cmd[0] == "/mainspawn") {
        if(!IsPlayerAdmin) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "You are not an admin", COLOR_RED, true);
        local ini = EasyINI("AAD/config.ini");
        local pos = getPlayerCoordinates(playerid);
        ini.setKey("Mainspawn", "x", pos[0].tostring());
        ini.setKey("Mainspawn", "y", pos[1].tostring());
        ini.setKey("Mainspawn", "z", pos[2].tostring());
        ini.saveData();
        
        Server[0].Lobby = pos[0].tofloat();
        Server[1].Lobby = pos[1].tofloat();
        Server[2].Lobby = pos[2].tofloat();
        
        sendPlayerMessage(playerid, "Mainspawn saved.", COLOR_GREEN);
        return 1;
    }
    if(cmd[0] == "/killmsg") {
		if(cmd.len() <= 1) return sendPlayerMessage(playerid, COLOR_RED2 + "Usage: " + COLOR_WHITE2 + " /killmsg [msg]", COLOR_RED, true);
		local killmsg = command.slice(cmd[0].len() + 1, command.len());
		local ini = EasyINI("AAD/Users/" + getPlayerName(playerid) + ".ini");
		ini.setKey("Killmsg", "Killmsg", killmsg);
		ini.saveData();
		if(ini.getKey("Killmsg", "Killmsg") == killmsg) return sendPlayerMessage(playerid, "Your killmsg was set to '" + killmsg + "'", COLOR_GREEN);
		else return onScriptError(getPlayerName(playerid) + " killmsg in file not found");
	}	
    if(cmd[0] == "/balance") {
        if(!IsPlayerAdmin(playerid)) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "Your not an admin!", COLOR_RED, true);
        if(isRoundStarted() == 1) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "You cannot edit the teams when a base is started!", COLOR_RED, true);
        balanceTeams();
        return sendMessageToAll(getPlayerName(playerid) + " has balanced the teams!", COLOR_YELLOW, true);
    }
    if(cmd[0] == "/allvs") {
		if(!IsPlayerAdmin(playerid) == 1) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "Your not an admin!", COLOR_RED, true);
		if(isRoundStarted() == 1) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "You cannot use this command if a round is started", COLOR_RED, true);
		if(cmd.len() < 2) return sendPlayerMessage(playerid, COLOR_RED2 + "Usage: " + COLOR_WHITE2 + " /allvs [name]", COLOR_RED, true);
	    for(local i=0; i <= Server[0].HighestID+1; ++i) if(isPlayerConnected(i)) {
	        if(pInfo[i].team == 1) Attackers--;
	        else if(pInfo[i].team == 2) Defenders--;
			if(getPlayerName(i).tolower().find(cmd[1].tolower()) != null) setTeam(i, 1);
			else setTeam(i, 2);
		}
		return sendMessageToAll(getPlayerName(playerid) + " has set the teams to all vs " + cmd[1], COLOR_YELLOW, true);
    }				
    if(cmd[0] == "/rules") {
        sendPlayerMessage(playerid, Server[0].Rules, COLOR_YELLOW, true);
        sendPlayerMessage(playerid, Server[1].Rules, COLOR_YELLOW, true);
        sendPlayerMessage(playerid, Server[2].Rules, COLOR_YELLOW, true);
        sendPlayerMessage(playerid, Server[3].Rules, COLOR_YELLOW, true);
        sendPlayerMessage(playerid, Server[4].Rules, COLOR_YELLOW, true);
        return sendPlayerMessage(playerid, "If you do NOT follow these rules above you will be punished.", COLOR_GREEN);
    }    
    if(cmd[0] == "/say") {
        if(!IsPlayerAdmin(playerid)) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "You most be an admin to use this command!", COLOR_RED, true);
        if(cmd.len() < 2) return sendPlayerMessage(playerid, COLOR_RED2 + "Usage: " + COLOR_WHITE2 + " /say [text]", COLOR_RED, true);
        local text = command.slice(cmd[0].len() + 1, command.len());
        if(pInfo[playerid].Admin == 1) sendMessageToAll("***[Moderator] " + getPlayerName(playerid) + ": " + text, COLOR_BLUE);
        else if(pInfo[playerid].Admin == 2) sendMessageToAll("***[Administrator] " + getPlayerName(playerid) + ": " + text, COLOR_BLUE);  
        return 1;
    }
    if(cmd[0] == "/pause") {
        if(!IsPlayerAdmin(playerid)) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "Your must be admin to use this command!", COLOR_RED, true);
        if(!isRoundStarted()) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "A base is not started!", COLOR_RED, true);
        for(local i=0; i <= Server[0].HighestID+1; ++i) if(isPlayerConnected(i)) if(isPlayerInRound(i)) togglePlayerFrozen(i, true);
        Server[0].Paused = 1;
        if(Timers[0].RoundTimer.isActive()) Timers[0].RoundTimer.kill();
        if(Timers[0].CPTimer.isActive()) Timers[0].CPTimer.kill();
        return sendMessageToAll(getPlayerName(playerid) + " has paused the round", COLOR_YELLOW, true);
    }
    if(cmd[0] == "/unpause") {
        if(!IsPlayerAdmin(playerid)) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "Your must be admin to use this command!", COLOR_RED, true);
        if(!isRoundStarted()) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "A base is not started!", COLOR_RED, true);
        if(Server[0].Paused == 0) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "The round is not paused!", COLOR_RED, true);
        //for(local i=0; i <= Server[0].HighestID+1; ++i) if(isPlayerConnected(i)) if(isPlayerInRound(i)) togglePlayerFrozen(i, false);
        sendMessageToAll(getPlayerName(playerid) + " has unpaused the round!", COLOR_YELLOW, true);
        Timers[0].RoundTimer = timer(RoundTimerFunc, 1000, Server[0].RoundTime+1);
        Timers[0].CPTimer = timer(CPCheck, 1000, -1);
        Timers[0].UnpauseTimer = timer(UnpauseRound, 1000, 5);
        return 1;
    }              
    if(cmd[0] == "/mute") {
		if(!IsPlayerAdmin(playerid)) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "Your must be admin to use this command!", COLOR_RED, true);
        if(cmd.len() >= 2) {
            local targetid = getPlayerIDFromNameOrID(cmd[1]);
            if(!isPlayerConnected(targetid)) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "This player is not connected.", COLOR_RED, true);
            if(pInfo[targetid].Mute == 1) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "This player is already muted, use /unmute", COLOR_RED, true);
            pInfo[targetid].Mute = 1;
            return sendMessageToAll(getPlayerName(playerid) + " Has muted " + getPlayerName(targetid), COLOR_YELLOW, true);
        }
        return sendPlayerMessage(playerid, COLOR_RED2 + "Usage: " + COLOR_WHITE2 + " /mute [playerid/name]", COLOR_RED, true);
    }
    if(cmd[0] == "/unmute") {
		if(!IsPlayerAdmin(playerid)) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "Your must be admin to use this command!", COLOR_RED, true);
        if(cmd.len() >= 2) {
            local targetid = getPlayerIDFromNameOrID(cmd[1]);
            if(!isPlayerConnected(targetid)) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "This player is not connected.", COLOR_RED, true);
            if(pInfo[targetid].Mute == 0) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "This player is already unmuted, use /mute", COLOR_RED, true);
            pInfo[targetid].Mute = 0;
            return sendMessageToAll(getPlayerName(playerid) + " Has unmuted " + getPlayerName(targetid), COLOR_YELLOW, true);
        }
        return sendPlayerMessage(playerid, COLOR_RED2 + "Usage: " + COLOR_WHITE2 + " /unmute [playerid/name]", COLOR_RED, true);
    }
    if(cmd[0] == "/jail") {
		if(!IsPlayerAdmin(playerid)) return sendPlayerMEssage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "Your not an admin!", COLOR_RED, true);
		if(cmd.len() < 2) return sendPlayerMessage(playerid, COLOR_RED2 + "Usage: " + COLOR_WHITE2 + " /jail [playerid] [optional:reason]", COLOR_RED, true);
		local targetid = getPlayerIDFromNameOrID(cmd[1]);
		if(!isPlayerConnected(targetid)) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "Invalid player!", COLOR_RED, true);
		setPlayerCoordinates(targetid, -0.329196, -0.224473, 9942.47);
		togglePlayerFrozen(targetid, true);
		if(cmd.len() == 2) {
			pInfo[targetid].Jailed = 1;
			pInfo[targetid].Mute = 1;
			pInfo[targetid].team = 0;
			sendMessageToAll(getPlayerName(playerid) + " has jailed " + getPlayerName(targetid) + " Reason: None", COLOR_RED, true);
			return 1;
		}
		else if(cmd.len() >= 3) {
			local reason = command.slice(cmd[0].len() + cmd[1].len() + 2, command.len());
			pInfo[targetid].Jailed = 1;
			pInfo[targetid].Mute = 1;
			pInfo[targetid].team = 0;
			sendMessageToAll(getPlayerName(playerid) + " has jailed " + getPlayerName(targetid) + " Reason: " + reason, COLOR_RED, true);
			return 1;
		}
	}	
	if(cmd[0] == "/unjail") {
		if(!IsPlayerAdmin(playerid)) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "Your not an admin!", COLOR_RED, true);
		if(cmd.len() < 2) return sendPlayerMessage(playerid, COLOR_RED2 + "Usage: " + COLOR_WHITE2 + " /unjail [playerid] [optional:reason]", COLOR_RED, true);
		local targetid = getPlayerIDFromNameOrID(cmd[1]);
		if(!isPlayerConnected(targetid)) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "Invalid player!", COLOR_RED, true);
		if(pInfo[targetid].Jailed != 1) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "This player is not jailed", COLOR_RED, true);
		if(cmd.len() == 2) {
			pInfo[targetid].Jailed = 0;
			pInfo[targetid].Mute = 0;
			autoAsignPlayer(targetid);
			sendMessageToAll(getPlayerName(playerid) + " has unjailed " + getPlayerName(targetid) + " Reason: None", COLOR_RED, true);
		}
		else if(cmd.len() >= 3) {
			local reason = command.slice(cmd[0].len() + cmd[1].len() + 2, command.len());
			pInfo[targetid].Jailed = 0;
			pInfo[targetid].Mute = 0;
			autoAsignPlayer(targetid);
			sendMessageToAll(getPlayerName(playerid) + " has unjailed " + getPlayerName(targetid) + " Reason: " + reason, COLOR_RED, true);
		}
		setPlayerCoordinates(targetid, Server[0].Lobby, Server[1].Lobby, Server[2].Lobby);
		togglePlayerFrozen(targetid, false);
	}			
    /*if(cmd[0] == "/akill") {
        if(cmd.len() >= 2) {
            local targetid = getPlayerIDFromNameOrID(cmd[1]);
            if(!isPlayerConnected(targetid)) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "Invalid player!", COLOR_RED, true);
            if(isPlayerInRound(targetid) == 1) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "You cannot kill a player when they are in a round, cheater.", COLOR_RED, true);
            setPlayerHealth(targetid, -1);
            return sendMessageToAll(getPlayerName(playerid) + " has killed " + getPlayerName(targetid), COLOR_YELLOW, true);
        }
        return sendPlayerMessage(playerid, COLOR_RED2 + "Usage: " + COLOR_WHITE2 + " /akill [playerid/name]", COLOR_RED, true);
    }*/
    //i decided this command should be removed just because, well... how can it not be abused? uncomment if your interested..
                                       
    if(cmd[0] == "/v" || cmd[0] == "/vehicle" || cmd[0] == "/car")
    {
        if(cmd.len() < 2) return sendPlayerMessage(playerid, COLOR_RED2 + "Usage: " + COLOR_WHITE2 + " /car [ID/Name] [optional:vehicle variation]", COLOR_RED, true);
        if(isPlayerInRound(playerid) && pInfo[playerid].IsDefendingInRound == 1) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "you cannot use this command at this time", COLOR_RED, true);
        local ini, x, y, z;
        if(!fexist("AAD/bases/" + Server[0].baseid + ".ini") && IsBaseStarted == 1 && isPlayerInRound(playerid) == 1) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "you cannot use this command at this time", COLOR_RED, true);
        if(IsBaseStarted == 1 && isPlayerInRound(playerid) && pInfo[playerid].IsAttackingInRound == 1) {
			x = Bases[Server[0].baseid].AttackerX;
			y = Bases[Server[0].baseid].AttackerY;
			z = Bases[Server[0].baseid].AttackerZ;
		}	
		local ini = EasyINI("vehconfig.ini");
		local pos = getPlayerCoordinates(playerid);
        if(Server[0].baseid != "Lobby") if(isPlayerInRound(playerid) && IsBaseStarted == 1 && pInfo[playerid].IsAttackingInRound == 1 && getDistanceBetweenPoints3D(pos[0], pos[1], pos[2], x, y, z) > Server[0].MaxRadius) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "You are out of radius of your spawn to use this command!", COLOR_RED, true);
        if(IsTDMStarted == 1) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "you cannot use this command at this time", COLOR_RED, true); 
        if(isPlayerInAnyVehicle(playerid)) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "Your already in a vehicle!", COLOR_RED, true);
        local id = cmd[1].tostring();
        local pos = getPlayerCoordinates(playerid);
        local rot = getPlayerHeading(playerid);
        local vehid;
        vehid = pInfo[playerid].lastcarspawned.tointeger();
        if(isNumeric(id)) {
            local mid = id.tointeger();
            local tmp = Server[mid].Vehicles;
            if(tmp.tointeger() != 1) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "This vehicle is disabled", COLOR_RED, true);
            if(AnyoneInVehicle(vehid) == 0) deleteVehicle(vehid);
            ini = EasyINI("AAD/Users/" + getPlayerName(playerid) + ".ini");
            local vehcreated = createVehicle(mid, pos[0] + 1, pos[1] + 1, pos[2] + 1, 0, ini.getKey("VColor", "1").tointeger(), ini.getKey("VColor", "2").tointeger(), ini.getKey("VColor", "3").tointeger(), ini.getKey("VColor", "4").tointeger());
            pInfo[playerid].lastcarspawned = vehcreated;
            if(cmd.len() > 2 && isNumeric(cmd[2])) setVehicleVariation(vehcreated, cmd[2].tointeger());
            setVehicleRotation(vehcreated, 0.0, 0.0, rot);
            warpPlayerIntoVehicle(playerid, vehcreated);
            setVehicleComponent(vehcreated, 0, true);
            setVehicleHealth(vehcreated, 1000);
			soundVehicleHorn(vehcreated, 3000);
            sendPlayerMessage(playerid, "Vehicle " + COLOR_WHITE2 + vehicleNames[mid] + COLOR_YELLOW2 + " spawned." + COLOR_GREEN2 + " [Model ID: " + mid + "]", COLOR_YELLOW, true);
         }
         if(!isNumeric(id)) {
            if(getVehicleIDFromName(id) != -1) {
                local vid = getVehicleIDFromName(id).tointeger();
                local tmp = Server[vid].Vehicles;
                if(tmp != 1) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "This vehicle is disabled", COLOR_RED, true);
                if(AnyoneInVehicle(vehid) == 0) deleteVehicle(vehid);
                ini = EasyINI("AAD/Users/" + getPlayerName(playerid) + ".ini");
                local vehcreated = createVehicle(vid, pos[0] + 1, pos[1] + 1, pos[2] + 1, 0, ini.getKey("VColor", "1").tointeger(), ini.getKey("VColor", "2").tointeger(), ini.getKey("VColor", "3").tointeger(), ini.getKey("VColor", "4").tointeger());
                pInfo[playerid].lastcarspawned = vehcreated;
                if(cmd.len() > 2 && isNumeric(cmd[2])) setVehicleVariation(vehcreated, cmd[2].tointeger());
                setVehicleRotation(vehcreated, 0.0, 0.0, rot);
                warpPlayerIntoVehicle(playerid, vehcreated);
                setVehicleComponent(vehcreated, 0, true);
                setVehicleHealth(vehcreated, 1000);
                soundVehicleHorn(vehcreated, 3000);
                sendPlayerMessage(playerid, "Vehicle " + COLOR_WHITE2 + vehicleNames[vid] + COLOR_YELLOW2 + " spawned." + COLOR_GREEN2 + " [Model ID: " + vid + "]", COLOR_YELLOW, true);
            } else {
                sendPlayerMessage(playerid, "Invalid vehicle!", COLOR_RED, true);
            }        
        }
        return 1;                
    }
    if(cmd[0] == "/vcolor") {
		if(cmd.len() <= 4) return sendPlayerMessage(playerid, COLOR_RED2 + "Usage: " + COLOR_WHITE2 + " /vcolor [color1=Body] [color2=Rims] [color3=Special parts] [color4=Special parts]", COLOR_RED, true);
		if(!isValidVehicleColor(cmd[1]) || !isValidVehicleColor(cmd[2]) || !isValidVehicleColor(cmd[3]) || !isValidVehicleColor(cmd[4])) { sendPlayerMessage(playerid, COLOR_RED2 + "Usage: " + COLOR_WHITE2 + " /vcolor [color1=Body] [color2=Rims] [color3=Special parts] [color4=Special parts]", COLOR_RED, true); return sendPlayerMessage(playerid, "For a list of colors, see http://wiki.iv-multiplayer.com/wiki/index.php/Vehicle_colors", COLOR_GREEN); }
		local ini = EasyINI("AAD/Users/" + getPlayerName(playerid) + ".ini");
		ini.setKey("VColor", "1", cmd[1]);
		ini.setKey("VColor", "2", cmd[2]);
		ini.setKey("VColor", "3", cmd[3]);
		ini.setKey("VColor", "4", cmd[4]);
		ini.saveData();
		if(isPlayerInAnyVehicle(playerid)) {
			local vid = getPlayerVehicleId(playerid);
			if(getPlayerState(playerid) == 6) { // player in a vehicle as a driver
				setVehicleColor(vid, cmd[1], cmd[2], cmd[3], cmd[4]);
			}
		}		
		sendPlayerMessage(playerid, "Colors saved.", COLOR_BLUE);
		return 1;
	}	
    if(cmd[0] == "/giveveh" || cmd[0] == "/givecar" || cmd[0] == "/givevehicle") {
		if(!IsPlayerAdmin(playerid)) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "Your not an admin!", COLOR_RED, true);
		if(cmd.len() < 3) return sendPlayerMessage(playerid, COLOR_RED2 + "Usage: " + COLOR_WHITE2 + " /giveveh [playerid/name] [ID/Name]", COLOR_RED, true);
		local targetid = getPlayerIDFromNameOrID(cmd[1]);
		if(!isPlayerConnected(targetid)) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "This player is not connected", COLOR_RED, true);     
        local id = cmd[2].tostring();
        local pos = getPlayerCoordinates(targetid);
        if(getVehicleIDFromName(id) != -1) {
            local vid = getVehicleIDFromName(id).tointeger();
            local tmp = Server[i].Vehicles;
            if(tmp.tointeger() != 1) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "This vehicle is disabled", COLOR_RED, true);
            local vehcreated = createVehicle(vid, pos[0] + 1, pos[1] + 1, pos[2] + 1, 0, 1, 1, 1, 1);
            local rot = getPlayerHeading(targetid)
            setVehicleRotation(vehcreated, 0.0, 0.0, rot);
            warpPlayerIntoVehicle(targetid, vehcreated);
            setVehicleComponent(vehcreated, 0, true);
            setVehicleHealth(vehcreated, 1000);
            soundVehicleHorn(vehcreated, 3000);
            sendPlayerMessage(playerid, "Vehicle " + vehicleNames[vid] + " spawned. for " + getPlayerName(targetid), COLOR_YELLOW, true);
			sendPlayerMessage(targetid, getPlayerName(playerid) + " has given you vehicle " + vehicleNames[vid], COLOR_YELLOW, true);
        } else {
            sendPlayerMessage(playerid, "Invalid vehicle!", COLOR_RED, true);
        }
        local vehid;
        vehid = pInfo[playerid].lastcarspawned.tointeger();
        deleteVehicle(vehid);
        return 1;                
    }
    if(cmd[0] == "/admins") {
        local adminsonline = 0;
        for(local i=0; i <= Server[0].HighestID+1; ++i) if(isPlayerConnected(i)) if(IsPlayerAdmin(i)) adminsonline++;       
        if(Server[0].HideAdmins == 1 && adminsonline != 0) {
            sendPlayerMessage(playerid, "______________Online Admins______________", COLOR_GREEN);
            for(local i=0; i <= Server[0].HighestID+1; ++i) if(isPlayerConnected(i)) if(IsPlayerAdmin(i)) {
                sendPlayerMessage(playerid, getPlayerName(i) + " [" + pInfo[i].Admin + "]", COLOR_GREEN);
            }    
            return sendPlayerMessage(playerid, "_______________________________________", COLOR_GREEN);
        }
        else if(adminsonline == 0 || tmp == 0) {
            
			sendPlayerMessage(playerid, "______________Online Admins_____________", COLOR_GREEN);
			sendPlayerMessage(playerid, "No admins online.", COLOR_GREEN);
			return sendPlayerMessage(playerid, "_______________________________________", COLOR_GREEN);
		}
		else return 1;	
    }          
    if(cmd[0] == "/getgun" || cmd[0] == "/gun") {
		if(cmd.len() < 2) return sendPlayerMessage(playerid, COLOR_RED2 + "Usage: " + COLOR_WHITE2 + " /getgun [wep]", COLOR_RED, true);
        local tempz = Server[0].Getgun;
        if(tempz.tointeger() != 1) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "Lobby weapons are disabled.", COLOR_RED, true);
        if(isPlayerInRound(playerid) == 0) {
            if(cmd.len() <= 2) {
                local wep = cmd[1].tostring()
                if(isNumeric(wep)) wep = cmd[1].tointeger();
                else if(!isNumeric(wep)) wep = getWeaponIDFromName(cmd[1]);
                if(!isValidWep(wep)) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "Invalid weapon!", COLOR_RED, true);
                local tmp = Server[wep.tointeger()].Weapons.tointeger();
                if(tmp == 0) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "This weapon is disabled", COLOR_RED, true);
                local ini2 = EasyINI("AAD/Users/" + getPlayerName(playerid) + ".ini");
                for(local i=0; i <= WeaponNames.len(); ++i) {
					if(isValidWep(i)) {
						local temp = ini2.getKey("WeaponInfo", i.tostring()); // will return true/false if they have the wep
						if(!isNumeric(temp)) continue;
						//if they have the weapon, lets check its slot
						if(temp == 1 && WeaponSlots[wep] == WeaponSlots[i]) { //if they have the weapon, and the weapon they are trying to get are in the same slot
							ini2.setKey("WeaponInfo", i.tostring(), 0); //disable there previous weapon.
							ini2.saveData();
						}
					}
				}			
                givePlayerWeapon(playerid, wep, 9999);
                sendPlayerMessage(playerid, "WEP INFO: You've been given a " + WeaponNames[wep], COLOR_BLUE);
                ini2.setKey("WeaponInfo", wep, 1);
                ini2.saveData();
                return 1;
            }
            return sendPlayerMessage(playerid, COLOR_RED2 + "Usage: " + COLOR_WHITE2 + " /getgun [weapon]", COLOR_RED, true);
        }
        return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "You cannot use this command while in a round!", COLOR_RED, true);
    }
    if(cmd[0] == "/removewep" || cmd[0] == "/removegun") {
        if(cmd.len() >= 2) {
			if(!IsPlayerAdmin(playerid)) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "You most be an admin to use this command", COLOR_RED, true);
            local wep = cmd[1].tostring();
            local ini = EasyINI("AAD/Users/" + getPlayerName(playerid) + ".ini");
            local tmp;
            if(isNumeric(wep)) tmp = wep.tointeger();
            else if(!isNumeric(wep)) tmp = getWeaponIDFromName(wep).tointeger();
            ini.setKey("WeaponInfo", tmp, 0);
            removePlayerWeapons(playerid);
            if(!isPlayerInRound(playerid)) givePlayerSpawnWeps(playerid);
            return 1;
        }
        return sendPlayerMessage(playerid, COLOR_RED2 + "Usage: " + COLOR_WHITE2 + " /removewep [wepid/name]", COLOR_RED, true);
    }                             
    if(cmd[0] == "/vclear") {
        if(IsPlayerAdmin) clearVehicles();
        else if(!IsPlayerAdmin) { return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "Your not an admin!", COLOR_RED, true); }
        sendPlayerMessage(playerid, "Vehicles cleared.", COLOR_RED, true);
        sendMessageToAll(getPlayerName(playerid) + " has cleared all vehicles", COLOR_YELLOW, true);
        return 1;
    }
    if(cmd[0] == "/lockteam" || cmd[0] == "/lockteams") {
		if(!IsPlayerAdmin(playerid)) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "Your not an admin", COLOR_RED, true);
		if(cmd.len() < 2) return sendPlayerMessage(playerid, COLOR_RED2 + "Usage: " + COLOR_WHITE2 + " /lockteam [teamid]", COLOR_RED, true);
		if(!isNumeric(cmd[1])) return sendPlayerMessage(playerid, COLOR_RED2 + "Usage: " + COLOR_WHITE2 + " /lockteam [teamid]", COLOR_RED, true);
		local lockstatus = getTeamLockStatus(cmd[1].tointeger());
		if(lockstatus == 1 && cmd[1].tointeger() == 1) { Server[0].AttackersLock = 0; return sendPlayerMessage(playerid, "You've unlocked the Attacking team.", COLOR_GREEN); }
		else if(lockstatus == 0 && cmd[1].tointeger() == 1) { Server[0].AttackersLock = 1; return sendPlayerMessage(playerid, "You've locked the Attacking team.", COLOR_GREEN); }
		else if(lockstatus == 1 && cmd[1].tointeger() == 2) { Server[0].DefendersLock = 0; return sendPlayerMessage(playerid, "You've unlocked the Defending team.", COLOR_GREEN); }
		else if(lockstatus == 0 && cmd[1].tointeger() == 2) { Server[0].DefendersLock = 1; return sendPlayerMessage(playerid, "You've locked the Defending team.", COLOR_GREEN); }
		else return sendPlayerMessage(playerid, COLOR_RED2 + "Usage: " + COLOR_WHITE2 + " /lockteam [teamid]", COLOR_RED, true);
	}	
	if(cmd[0] == "/setlevel") {
		if(pInfo[playerid].Admin != 2) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "You need to be a level 2 Admin to use this command!", COLOR_RED, true);
	    if(cmd.len() >= 3) {
	        local targetid = cmd[1].tostring();
	        if(!isNumeric(targetid)) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "Invalid player id.", COLOR_RED, true);
	        targetid = cmd[1].tointeger();
	        if(isPlayerConnected(targetid) && pInfo[playerid].Admin == 2) {
	            local ini = EasyINI("AAD/Users/" + getPlayerName(targetid) + ".ini");
	            local level = cmd[2].tostring();
	            if(!isNumeric(level)) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "Invalid level", COLOR_RED, true);
	            if(level.tointeger() != 0 && level.tointeger() != 1 && level.tointeger() != 2) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "Invalid level", COLOR_RED, true);
	            ini.setKey("Login", "level", level);
	            ini.saveData();
	            local tmp = ini.getKey("Login", "level");
	            pInfo[targetid].Admin = tmp.tointeger();
	            sendMessageToAll(getPlayerName(playerid) + " has set " + getPlayerName(targetid) + "'s Admin level to " + pInfo[targetid].Admin + ".", COLOR_YELLOW, true);
	            return 1;
	        }
	        sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "The player is not connected, or you are not an admin.", COLOR_RED, true);
	        return 1;
	    }
	    sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "/setlevel [playerid] [level]", COLOR_RED, true);
	    return 1;
	}
	if(cmd[0] == "/end") {
	    if(!IsPlayerAdmin) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "You are not an admin", COLOR_RED, true);
	    if(!isRoundStarted()) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "A base is not started.", COLOR_RED, true);
	    sendMessageToAll(getPlayerName(playerid) + " Has ended the round.", COLOR_YELLOW, true);
	    endBase();
        return 1;
    }
    if(cmd[0] == "/movecp") {
		if(!IsPlayerAdmin(playerid)) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "Your not an admin!", COLOR_RED, true);
		if(!IsBaseStarted) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "A base is not in progress!", COLOR_RED, true);
		if(!isPlayerInRound(playerid)) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "You cannot move the CP while not in the round!", COLOR_RED, true);
		if(pInfo[playerid].IsAttackingInRound == 1) return sendPlayerMessage(playerid, "Stop trying to cheat.", COLOR_RED, true);
		local ini = EasyINI("AAD/bases/" + Server[0].baseid + ".ini");
		local pos = getPlayerCoordinates(playerid);
		ini.setKey("Checkpoint", "x", pos[0]);
		ini.setKey("Checkpoint", "y", pos[1]);
		ini.setKey("Checkpoint", "z", pos[2]);
		ini.saveData();
		Bases[Server[0].baseid].CheckpointX = pos[0].tofloat();
		Bases[Server[0].baseid].CheckpointY = pos[1].tofloat();
		Bases[Server[0].baseid].CheckpointZ = pos[2].tofloat();
		deleteObject(cpobjectid);
		deleteBlip(CPBlip);
		CPBlip = createBlip(65, Bases[Server[0].baseid].CheckpointX, Bases[Server[0].baseid].CheckpointY, Bases[Server[0].baseid].CheckpointZ);
		toggleBlipRoute(CPBlip, true);
		cpobjectid = createObject(0x673F486C, Bases[Server[0].baseid].CheckpointX, Bases[Server[0].baseid].CheckpointY, Bases[Server[0].baseid].CheckpointZ, 0.0, 0.0, 0.0);
		return 1;
	}	
    if(cmd[0] == "/report") {
        if(cmd.len() >= 3) {
            local targetid = getPlayerIDFromNameOrID(cmd[1]);
            if(!isPlayerConnected(targetid)) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "This player is not connected.", COLOR_RED, true);
            local reason = command.slice(cmd[0].len() + cmd[1].len() + 2, command.len());
            for(local i=0; i <= Server[0].HighestID+1; ++i) if(isPlayerConnected(i)) if(IsPlayerAdmin(i) == 1) sendPlayerMessage(i, "[REPORT]: " + getPlayerName(playerid) + " has reported " + getPlayerName(targetid) + " for " + reason, COLOR_BLUE);
            if(IRC == 1) ircSay(iBot, strEchoChannel, "[REPORT]: " + getPlayerName(playerid) + " has reported " + getPlayerName(targetid) + " for " + reason);
            return sendPlayerMessage(playerid, "Report sent to all online admins.", COLOR_GREEN);
        }
        return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "/report [playerid/name] [reason]");
    }
    if(cmd[0] == "/gunlist") {
		if(Server[0].Getgun != 1) return sendPlayerMessage(playerid, "/getgun is disabled.", COLOR_RED, true);
		local weps = " ";
		for(local i=0; i <= WeaponNames.len(); ++i) {
			if(Server[i].Weapons == "1" && isValidWep(i)) weps += WeaponNames[i] + ", ";
		}
		sendPlayerMessage(playerid, weps, COLOR_YELLOW, true);
		return sendPlayerMessage(playerid, "End of list.", COLOR_RED, true);
	}
	if(cmd[0] == "/c") {
		if(cmd.len() <= 1) return sendPlayerMessage(playerid, COLOR_RED2 + "Usage: " + COLOR_WHITE2 + " /c [setlist id], /wlist for setlists", COLOR_RED, true);
		if(!isNumeric(cmd[1]) && cmd[1] != "set") return sendPlayerMessage(playerid, COLOR_RED2 + "Usage: " + COLOR_WHITE2 + " /c [setlist id], /wlist for setlists", COLOR_RED, true);
		if(cmd[1] == "set") {
			if(cmd.len() <= 2) return sendPlayerMessage(playerid, COLOR_RED2 + "Usage: " + COLOR_WHITE2 + " /c set [setlist]", COLOR_RED, true);
			if(!isNumeric(cmd[2])) return sendPlayerMessage(playerid, COLOR_RED2 + "Usage: " + COLOR_WHITE2 + " /c set [setlist]", COLOR_RED, true);
			local tmpz = EasyINI("AAD/Users/" + getPlayerName(playerid) + ".ini");
			tmpz.setKey("Config", "DefaultSetlist", cmd[2]);
			tmpz.saveData();
			return sendPlayerMessage(playerid, "You've saved your default setlist to: " + tmpz.getKey("Config", "DefaultSetlist"), COLOR_GREEN);
		}
		if(cmd[1].tointeger() > 5 && cmd[1].tointeger() <= 0) return sendPlayerMessage(playerid, COLOR_RED2 + "Usage: " + COLOR_WHITE2 + " /c [setlist id], /wlist for setlists", COLOR_RED, true);
		if(pInfo[playerid].CanPickWeps != 1 || !isPlayerInRound(playerid) || !isRoundStarted()) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "You can only pick your weapons 30 seconds after a round starts", COLOR_RED, true);

		local setlistid = cmd[1];
		GiveWeps(playerid, setlistid.tointeger());
		return 1;
	}	   
    if(cmd[0] == "/switch") {
        if(cmd.len() < 2) {
			sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "/switch [1-2]", COLOR_RED, true); 
			sendPlayerMessage(playerid, "1 = Attackers", COLOR_RED, true); 
			return sendPlayerMessage(playerid, "2 = Defenders", COLOR_RED, true);
		}
		if(pInfo[playerid].team == 1 && !isPlayerInRound(playerid)) Attackers--;
		if(pInfo[playerid].team == 2 && !isPlayerInRound(playerid)) Defenders--;
		if(cmd[1] == "1" && Server[0].AttackersLock == 1) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "This team is locked", COLOR_RED, true);
		if(cmd[1] == "2" && Server[0].DefendersLock == 1) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "This team is locked", COLOR_RED, true);
        if(cmd[1] == "1") {
			if(isPlayerInRound(playerid)) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "you can not switch teams during a base", COLOR_RED, true);
            pInfo[playerid].team = 1;
            sendMessageToAll(getPlayerName(playerid) + " Has switched to team: Attackers", COLOR_GREEN);
            Attackers++;
            return 1;
        }
        if(cmd[1] == "2") {
            if(isPlayerInRound(playerid)) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "you can not switch teams during a base", COLOR_RED, true);
            pInfo[playerid].team = 2;
            sendMessageToAll(getPlayerName(playerid) + " Has switched to team: Defenders", COLOR_GREEN);
            Defenders++;
            return 1;
        }
		return 1;  
    }
    if(cmd[0] == "/add") {
        if(cmd.len() != 2) return sendPlayerMessage(playerid, COLOR_RED2 + "Usage: " + COLOR_WHITE2 + " /add [playerid/name]", COLOR_RED, true);
        if(!IsPlayerAdmin) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "You are not an admin", COLOR_RED, true);
	    if(!isRoundStarted()) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "A base is not started.", COLOR_RED, true);
	    local targetid = getPlayerIDFromNameOrID(cmd[1].tostring());
	    targetid.tointeger();
	    if(!isPlayerConnected(targetid)) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "This player is not online!", COLOR_RED, true);
	    if(isPlayerInRound(playerid)) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "This player is already in a round!", COLOR_RED, true);
	    if(pInfo[targetid].team == 1) { //Attackers
	        addPlayerToRound(targetid);
            sendMessageToAll(getPlayerName(playerid) + " Added " + getPlayerName(targetid) + " as a Attacker.", COLOR_YELLOW, true);
        }
        else if(pInfo[targetid].team == 2) { //Defenders
           addPlayerToRound(targetid);
           sendMessageToAll(getPlayerName(playerid) + " Added " + getPlayerName(targetid) + " as a Defender.", COLOR_YELLOW, true);
        }
    }
    if(cmd[0] == "/swap") {
        if(!IsPlayerAdmin(playerid)) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "Your not an admin", COLOR_RED, true);
        if(isRoundStarted() == 1) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "You cannot use this command when a base is started!", COLOR_RED, true);
        swapTeams();
        return sendMessageToAll(getPlayerName(playerid) + " Has swapped the teams", COLOR_YELLOW, true);
    }
    if(cmd[0] == "/checkteams" || cmd[0] == "/teams" || cmd[0] == "/team") {
		calculatePlayersOnTeams();
        sendMessageToAll("Attackers: " + Attackers, COLOR_YELLOW, true);
        sendMessageToAll("Defenders: " + Defenders, COLOR_YELLOW, true);
        sendMessageToAll("Attackers in round: " + AttackersInRound, COLOR_GREEN);
        return sendMessageToAll("Defenders in round: " + DefendersInRound, COLOR_GREEN);
    }
    if(cmd[0] == "/setserverpass" || cmd[0] == "/setserverpassword" || cmd[0] == "/setpass") {
        if(pInfo[playerid].Admin != 2) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "You must be admin level 2 to use this command.", COLOR_RED, true);
        if(cmd.len() >= 2) {
            setServerPassword(cmd[1]);
            return sendPlayerMessage(playerid, "You've set the server password to, " + cmd[1], COLOR_GREEN);
        } else { 
			sendPlayerMessage(playerid, COLOR_RED2 + "Usage: " + COLOR_WHITE2 + " /setserverpass [password]", COLOR_RED, true);
			local tmp = getServerPassword();
			if(tmp == null) return 1;
            return sendPlayerMessage(playerid, "Current server password is " + tmp, COLOR_GREEN);
        }  
        return 1;
    }               
    if(cmd[0] == "/remove") {
        if(!isRoundStarted()) return sendPlayerMessage(playerid, "A base is not started!", COLOR_RED, true);
        if(cmd.len() != 1 && cmd.len() != 2) return sendPlayerMessage(playerid, COLOR_RED2 + "Usage: " + COLOR_WHITE2 + " /remove [id]", COLOR_RED, true);
        if(cmd.len() == 1) {
            removePlayerFromRound(playerid);
            endBaseWithWinner();
            return 1;
        }
        if(IsPlayerAdmin(playerid) && cmd.len() == 2) {
            local targetid = getPlayerIDFromNameOrID(cmd[1]);
            if(!isPlayerConnected(targetid)) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "This player is not connected.", COLOR_RED, true);
            if(pInfo[targetid].IsDefendingInRound != 1 && pInfo[targetid].IsAttackingInRound != 1) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "This player is not in the round!", COLOR_RED, true);
            removePlayerFromRound(targetid);
            return 1;
        }
        if(!IsPlayerAdmin(playerid)) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "Your not an admin!", COLOR_RED, true);                    
        sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "Your not in the round!", COLOR_RED, true);    
        return 1;
    }
    if(cmd[0] == "/readd") {
		if(!isRoundStarted() || !isPlayerInRound(playerid)) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "A round is not started", COLOR_RED, true);
		if(pInfo[playerid].CanPickWeps == 0) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "You can only use this command 30 seconds after the round starts", COLOR_RED, true);
		removePlayerFromRound(playerid);
		addPlayerToRound(playerid);
		sendMessageToAll(getPlayerName(playerid) + " has readded him/herself to the round!", COLOR_YELLOW, true);
		return 1;
	}			
    if(cmd[0] == "/ban") {
        if(pInfo[playerid].Admin != 2) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "You need to be admin level 2 to use this command.", COLOR_RED, true);
        if(cmd.len() <= 1) return sendPlayerMessage(playerid, COLOR_RED2 + "Usage: " + COLOR_WHITE2 + " /ban [playerid/name] [reason]", COLOR_RED, true);
        local targetid = getPlayerIDFromNameOrID(cmd[1]);
        if(cmd.len() == 2) {
            if(isPlayerConnected(targetid)) {
                sendMessageToAll(getPlayerName(playerid) + " Has banned " + getPlayerName(targetid), COLOR_YELLOW, true);
                Banned(targetid);
                banPlayer(targetid, 0);
                if(pInfo[targetid].LoggedIn == 1) {
                    local ini = EasyINI("AAD/Users/" + getPlayerName(targetid) + ".ini");
                    ini.setKey("Login", "Banned", 1);
                    ini.saveData();
                }
                return 1;
            }
            sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "This player isn't connected.", COLOR_RED, true);
            return 1;           
        }
        if(cmd.len() >= 3) {
            if(isPlayerConnected(targetid)) {
                sendMessageToAll(getPlayerName(playerid) + " Has banned " + getPlayerName(targetid) + " Reason: " + command.slice(cmd[0].len()+cmd[1].len()+2, command.len()), COLOR_YELLOW, true);
                Banned(targetid);
                banPlayer(targetid, 0);
                if(pInfo[targetid].LoggedIn == 1) {
                    local ini = EasyINI("AAD/Users/" + getPlayerName(targetid) + ".ini");
                    ini.setKey("Login", "Banned", 1);
                    ini.saveData();
                }
                return 1;
            }
            sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "This player isn't connected.", COLOR_RED, true);
            return 1; 
        }
        return 1;
    }
    if(cmd[0] == "/skin") {
        if(Server[0].Skins != 1) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "Skins aren't enabled!", COLOR_RED, true);
        if(cmd.len() != 2) return sendPlayerMessage(playerid, COLOR_RED2 + "Usage: " + COLOR_WHITE2 + " /skin [skinid]", COLOR_RED, true);
        if(!isNumeric(cmd[1])) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "Invalid skin", COLOR_RED, true);
        setPlayerModel(playerid, cmd[1].tointeger());
        sendPlayerMessage(playerid, "Skin successfully changed to ID: " + cmd[1], COLOR_YELLOW, true);
        if(pInfo[playerid].LoggedIn == 1) { 
            local ini = EasyINI("AAD/Users/" + getPlayerName(playerid) + ".ini");
            makeKeyIfDoesntExist(ini, "Skin", "Skin");
            ini.setKey("Skin", "Skin", cmd[1]);
            ini.saveData();
        } 
        return 1;   
    }
    if(cmd[0] == "/setteam") {
        if(!IsPlayerAdmin(playerid)) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "Your not an admin", COLOR_RED, true);
        if(isRoundStarted() == 1) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "You cannot set teams during a round", COLOR_RED, true);
        if(cmd.len() >= 3) {
            local tmp = getPlayerIDFromNameOrID(cmd[1]);
            if(tmp == -1 || !isNumeric(cmd[2])) {
                sendPlayerMessage(playerid, COLOR_RED2 + "Usage: " + COLOR_WHITE2 + " /setteam [playerid] [teamid]", COLOR_RED, true); 
                sendPlayerMessage(playerid, "Attackers = 1", COLOR_RED, true);
                return sendPlayerMessage(playerid, "Defenders = 2", COLOR_RED, true);
            }
            local targetid = tmp;
            local teamid = cmd[2].tointeger();
            if(teamid != 1 && teamid != 2) {
                sendPlayerMessage(playerid, COLOR_RED2 + "Usage: " + COLOR_WHITE2 + " /setteam [playerid] [teamid]", COLOR_RED, true); 
                sendPlayerMessage(playerid, "Attackers = 1", COLOR_RED, true);
                return sendPlayerMessage(playerid, "Defenders = 2", COLOR_RED, true);
            }
            setTeam(tmp, teamid);

            local teamname = Server[0].AttackersName;
            local teamname2 = Server[0].DefendersName;
            if(teamid == 1) sendMessageToAll(getPlayerName(playerid) + " Has set " + getPlayerName(tmp) + " to the team " + teamname + " (Attackers)", COLOR_YELLOW, true);
            if(teamid == 2) sendMessageToAll(getPlayerName(playerid) + " Has set " + getPlayerName(tmp) + " to the team " + teamname2 + " (Defenders)", COLOR_YELLOW, true);
            return 1;
        }
        sendPlayerMessage(playerid, COLOR_RED2 + "Usage: " + COLOR_WHITE2 + " /setteam [playerid] [teamid]", COLOR_RED, true); 
        sendPlayerMessage(playerid, "Attackers = 1", COLOR_RED, true);
        return sendPlayerMessage(playerid, "Defenders = 2", COLOR_RED, true);   
    }
         
    if(cmd[0] == "/kick") {
        if(!IsPlayerAdmin(playerid)) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "Your not an Admin", COLOR_RED, true);
        local targetid = getPlayerIDFromNameOrID(cmd[1]);
        if(cmd.len() <= 1) return sendPlayerMessage(playerid, COLOR_RED2 + "Usage: " + COLOR_WHITE2 + " /kick [playerid/name] [reason]", COLOR_RED, true);
        if(!isPlayerConnected(targetid)) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "This player isn't connected.", COLOR_RED, true);
        if(cmd.len() == 2) {
            sendMessageToAll(getPlayerName(playerid) + " Has kicked " + getPlayerName(targetid) + " Reason: None.", COLOR_YELLOW, true);
            kickPlayer(targetid, true);
            return 1;
        }      
        if(cmd.len() >= 3) {
            sendMessageToAll(getPlayerName(playerid) + " Has kicked " + getPlayerName(targetid) + " Reason: " + command.slice(cmd[0].len()+cmd[1].len()+2, command.len()), COLOR_YELLOW, true);
            kickPlayer(targetid, true);
            return 1;
        }
        return 1;
    }
    if(cmd[0] == "/goto") {
        //if(!IsPlayerAdmin(playerid)) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "Your not an Admin", COLOR_RED, true);
        //why do they have to be an admin to use this command? as long as they don't tele to a player who is in a round, i don't see why everyone can't use /goto
        if(isPlayerInRound(playerid)) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "You cannot use this command while in a base.", COLOR_RED, true);
        if(cmd.len() < 2) return sendPlayerMessage(playerid, COLOR_RED2 + "Usage: " + COLOR_WHITE2 + " /goto [playerid/name]", COLOR_RED, true);
        local targetid = getPlayerIDFromNameOrID(cmd[1]);
        if(targetid == playerid) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "Cannot teleport to yourself.", COLOR_RED, true);
        if(!isPlayerConnected(targetid)) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "This player is not connected", COLOR_RED, true);
        if(isPlayerInRound(targetid)) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "You cannot goto a player who is in a round!", COLOR_RED, true);
        GoTo(playerid, targetid); //goto, swap playerid, and targetid and this function becomes gethere
        return 1;
    }
    if(cmd[0] == "/gethere") {
        //if(!IsPlayerAdmin(playerid)) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "Your not an Admin", COLOR_RED, true);
        //why do they have to be an admin to use this command? as long as they don't tele to a player who is in a round, i don't see why everyone can't use /gethere
        if(isPlayerInRound(playerid)) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "You cannot use this command while in a base.", COLOR_RED, true);
        if(cmd.len() < 2) return sendPlayerMessage(playerid, COLOR_RED2 + "Usage: " + COLOR_WHITE2 + " /gethere [playerid/name]", COLOR_RED, true);
        local targetid = getPlayerIDFromNameOrID(cmd[1]);
        if(targetid == playerid) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "Cannot teleport to yourself.", COLOR_RED, true);
        if(!isPlayerConnected(targetid)) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "This player is not connected", COLOR_RED, true);
        if(isPlayerInRound(targetid)) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "You cannot gethere a player who is in a round!", COLOR_RED, true);
        GoTo(targetid, playerid); //gethere, swap playerid, and targetid and this function becomes goto
        return 1;
    }
    if(cmd[0] == "/settime") {
        if(!IsPlayerAdmin(playerid)) return sendPlayerMessage(playerid,  "Your not an Admin", COLOR_RED, true);
        if(cmd.len() == 1) return sendPlayerMessage(playerid, COLOR_RED2 + "Usage: " + COLOR_WHITE2 + " /settime [hour]", COLOR_RED, true);
        if(!isNumeric(cmd[1])) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "Invalid time.", COLOR_RED, true);
        local ini = EasyINI("AAD/config.ini");
        if(cmd.len() == 2) {
            for(local i=0; i <= Server[0].HighestID+1; ++i) {
                if(isPlayerConnected(i)) {
                    setPlayerTime(i, cmd[1].tointeger(), cmd[1].tointeger());
                }
            }
            sendMessageToAll(getPlayerName(playerid) + " has set the default time to, Hour: " + cmd[1].tointeger(), COLOR_YELLOW, true);
            ini.setKey("Time", "Hour", cmd[1]);
            ini.setKey("Time", "Minute", cmd[1]);
            ini.saveData();
            Server[0].Time = cmd[1];
            Server[1].Time = cmd[1];
            setDefaultTime();
            return 1;
        }
        else if(cmd.len() >= 3) {
			if(!isNumeric(cmd[2])) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "Invalid time.", COLOR_RED, true);
			for(local i=0; i <= Server[0].HighestID+1; ++i) {
				if(isPlayerConnected(i)) {
					setPlayerTime(i, cmd[1].tointeger(), cmd[2].tointeger());
                }	
            }
            sendMessageToAll(getPlayerName(playerid) + " has set the default time to, Hour: " + cmd[1].tointeger() + " Minute: " + cmd[2], COLOR_YELLOW, true);
            ini.setKey("Time", "Hour", cmd[1]);
            ini.setKey("Time", "Minute", cmd[2]);
            ini.saveData();
            Server[0].Time = cmd[1];
            Server[1].Time = cmd[2];
            setDefaultTime();
            return 1;
        }
        return 1;
    }
    if(cmd[0] == "/t") {
         if(cmd.len() < 2) return sendPlayerMessage(playerid, COLOR_RED2 + "Usage: " + COLOR_WHITE2 + " /t [teleport id]", COLOR_RED, true);
         if(!isNumeric(cmd[1])) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "Invalid teleport ID.", COLOR_RED, true);
         if(isRoundStarted() == 1) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "You cannot use this command during a round", COLOR_RED, true);
         local tele = cmd[1].tointeger();
         if(!fexist("AAD/teles/" + tele + ".ini")) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "This teleport doesn't exist", COLOR_RED, true);
         local ini = EasyINI("AAD/teles/" + tele + ".ini");
         local vid = -1;
         if(isPlayerInAnyVehicle(playerid)) {
			vid = getPlayerVehicleId(playerid);
		 }	
         setPlayerCoordinates(playerid, Tele[tele].X, Tele[tele].Y, Tele[tele].Z);
         if(vid != -1) {
			setVehicleCoordinates(vid, Tele[tele].X, Tele[tele].Y, Tele[tele].Z);
			warpPlayerIntoVehicle(playerid, vid);
		 }	      
         sendMessageToAll(getPlayerName(playerid) + " has teleported to /t " + tele, COLOR_YELLOW, true);
         return 1;
     }
    if(cmd[0] == "/nick") {
		if(Server[0].Nicks == 0) return sendPlayerMessage(playerid, "Nick changing is not allowed!", COLOR_RED, true);
		if(cmd.len() < 2) return sendPlayerMessage(playerid, COLOR_RED2 + "Usage: " + COLOR_WHITE2 + " /nick [new nick]", COLOR_RED, true);
		setPlayerName(playerid, cmd[1]);
		sendMessageToAll(pInfo[playerid].OriginalName + " has changed his name to " + getPlayerName(playerid), COLOR_YELLOW, true);
		onPlayerConnect(playerid);
		return 1;
	}	
    if(cmd[0] == "/eject") {
		if(!IsPlayerAdmin(playerid)) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "Your not an admin!", COLOR_RED, true);
		if(cmd.len() < 2) return sendPlayerMessage(playerid, COLOR_RED2 + "Usage: " + COLOR_WHITE2 + " /eject [playerid/name]", COLOR_RED, true);
		local targetid = getPlayerIDFromNameOrID(cmd[1]);
		if(!isPlayerConnected(targetid)) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "That player is not connected!", COLOR_RED, true);
		if(!isPlayerInAnyVehicle(targetid)) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "This player is not in a vehicle!", COLOR_RED, true);
		removePlayerFromVehicle(targetid);
		sendPlayerMessage(playerid, "Succesfully, removed " + getPlayerName(targetid) + " from his vehicle.", COLOR_YELLOW, true);
		sendPlayerMessage(targetid, getPlayerName(playerid) + " Has removed you from your vehicle", COLOR_YELLOW, true);
		return 1;
	}
    if(cmd[0] == "/delacc") {
        if(pInfo[playerid].Admin != 2) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "You need to be level 2 admin to use this comand", COLOR_RED, true);
        if(cmd.len() >= 2) {
            local targetacc = cmd[1];
            local file = "AAD/Users/" + targetacc + ".ini";
            if(!pfexist(file)) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "This player is not registered", COLOR_RED, true);
            deleteSection("Login");
            deleteSection("Stats");
            deleteSection("VColor");
            deleteSection("WeaponInfo");
            return sendPlayerMessage(playerid, "You deleted account " + targetacc, COLOR_GREEN);
        }
        return sendPlayerMessage(playerid, COLOR_RED2 + "Usage: " + COLOR_WHITE2 + " /delacc [account name]", COLOR_RED, true);
    }
    if(cmd[0] == "/banacc") {
        if(pInfo[playerid].Admin != 2) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "You need to be level 2 admin to use this command.", COLOR_RED, true);
        if(cmd.len() >= 2) {
            local targetacc = cmd[1];
            for(local i=0; i <= Server[0].HighestID+1; ++i) if(isPlayerConnected(i)) {
                local name = getPlayerName(i);
                if(name.tolower() == targetacc.tolower()) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "This player is connected, use /ban", COLOR_RED, true);
            }
            if(!fexist("AAD/Users/" + targetacc + ".ini")) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "This player is not registered", COLOR_RED, true);   
            local ini = EasyINI("AAD/Users/" + targetacc + ".ini");
            ini.setKey("Login", "Banned", 1);
            ini.saveData();
            return sendPlayerMessage(playerid, "Successfully banned " + targetacc, COLOR_GREEN);
        }
        return sendPlayerMessage(playerid, COLOR_RED2 + "Usage: " + COLOR_WHITE2 + " /banacc [playername]", COLOR_RED, true);
    }                                                         
	if(cmd[0] == "/config") {
        if(pInfo[playerid].Admin != 2) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "You must be an admin level 2 to use this command.", COLOR_RED, true);
        if(cmd.len() <= 1) {
			sendPlayerMessage(playerid, "/config [param]", COLOR_WHITE, true);
			sendPlayerMessage(playerid, "autologin, clantag, autoswap, roundhp, autobalance, cptime, cpsize, pingkick", COLOR_WHITE, true);
			sendPlayerMessage(playerid, "nameban, ragdoll, teamname, vused, lobbyhp, lgunused, lobbyweps, modemin, weather", COLOR_WHITE, true);
			sendPlayerMessage(playerid, "setlist, website, tele, skins, teamskin, customspawns, maxradius, minfps", COLOR_WHITE, true);
			return sendPlayerMessage(playerid, "autoaim, clanwar, hideadmins, rules, vehiclekilling, autokick, nicks", COLOR_WHITE, true);
		}
		if(cmd[1] == "roundhealth" || cmd[1] == "roundhp") {
			if(cmd.len() < 3) return sendPlayerMessage(playerid, COLOR_RED2 + "Usage: " + COLOR_WHITE2 + " /config roundhp [0-400]", COLOR_RED, true);
			if(!isNumeric(cmd[2])) return sendPlayerMessage(playerid, COLOR_RED2 + "Usage: " + COLOR_WHITE2 + " /config roundhp [0-400]", COLOR_RED, true);
			if(cmd[2].tointeger() > 400 || cmd[2].tointeger() < 0) return sendPlayerMessage(playerid, COLOR_RED2 + "Usage: " + COLOR_WHITE2 + " /config roundhp [0-400]", COLOR_RED, true);
			
			local ini = EasyINI("AAD/config.ini");
			makeKeyIfDoesntExist(ini, "Config", "RoundHP");
			
			ini.setKey("Config", "RoundHP", cmd[2].tointeger());
			ini.saveData();
			
			Server[0].RoundHP = cmd[2].tointeger();
			
			sendMessageToAll(getPlayerName(playerid) + " has set the round health to: " + cmd[2], COLOR_GREEN)
			
		}
		if(cmd[1] == "lobbyhealth" || cmd[1] == "roundhp") {
			if(cmd.len() < 3) return sendPlayerMessage(playerid, COLOR_RED2 + "Usage: " + COLOR_WHITE2 + " /config lobbyhp [0-400]");
			if(!isNumeric(cmd[2])) return sendPlayerMessage(playerid, COLOR_RED2 + "Usage: " + COLOR_WHITE2 + " /config lobbyhp [0-400]");
			if(cmd[2].tointeger() > 400 || cmd[2].tointeger() < 0) return sendPlayerMessage(playerid, COLOR_RED2 + "Usage: " + COLOR_WHITE2 + " /config lobbyhp [0-400]");
			
			local ini = EasyINI("AAD/config.ini");
			makeKeyIfDoesntExist(ini, "Config", "LobbyHP");
			
			ini.setKey("Config", "LobbyHP", cmd[2].tointeger());
			ini.saveData();
			
			Server[0].LobbyHP = cmd[2].tointeger();
			
			sendMessageToAll(getPlayerName(playerid) + " has set the lobby health to: " + cmd[2], COLOR_GREEN)
		}	
			
        if(cmd[1] == "autologin") autoLogin(playerid);
        if(cmd[1] == "autokick") {
            if(Server[0].ForceLogin == 1) {
                ini.setKey("Config", "Autokick", 0);
                ini.saveData();
                Server[0].ForceLogin = 0;
                if(ini.getKey("Config", "Autokick").tointeger() == 0) {
					sendPlayerMessage(playerid, "You've disabled auto kicking of players who do not login", COLOR_YELLOW, true);
					sendMessageToAll(getPlayerName(playerid) + " has disabled Auto-kicking players who do not login", COLOR_YELLOW, true);
				}	
                else return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "An unknown error has occured, please re-do this command", COLOR_RED, true);
            }
            else if(Server[0].ForceLogin == 0) {
                ini.setKey("Config", "Autokick", 1);
                ini.saveData();
                Server[0].ForceLogin = 1;
                if(ini.getKey("Config", "Autokick").tointeger() == 1) {
					sendPlayerMessage(playerid, "You've enabled auto kicking of players who do not login", COLOR_YELLOW, true);
					sendMessageToAll(getPlayerName(playerid) + " has enabled Auto-kicking players who do not login", COLOR_YELLOW, true);
				}
                else return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "An unknown error has occured, please re-do this command", COLOR_RED, true);
            }
        }
        if(cmd[1] == "maxradius") {
			if(cmd.len() < 3) return sendPlayerMessage(playerid, COLOR_RED2 + "Usage: " + COLOR_WHITE2 + " /config maxradius [radius]", COLOR_RED, true);
			if(!isNumeric(cmd[2])) return sendPlayerMessage(playerid, COLOR_RED2 + "Usage: " + COLOR_WHITE2 + " /config maxradius [radius]", COLOR_RED, true);
			local ini = EasyINI("AAD/vehconfig.ini");
			ini.setKey("Vehicles", "MaxRadius", cmd[2]);
			ini.saveData();
			
			Server[0].MaxRadius = cmd[2].tointeger();
			sendPlayerMessage(playerid, "Max Attacker car spawn radius is now: " + cmd[2], COLOR_YELLOW, true);
		}
		if(cmd[1] == "minfps") {
			if(cmd.len() < 3) { sendPlayerMessage(playerid, COLOR_RED2 + "Usage: " + COLOR_WHITE2 + " /config minfps [min fps allowed]", COLOR_RED, true); return sendPlayerMessage(playerid, "Set to 0 to disable"); }
			if(!isNumeric(cmd[2])) return sendPlayerMessage(playerid, COLOR_RED2 + "Usage: " + COLOR_WHITE2 + " /config minfps [fps]", COLOR_RED, true);
			
			sendPlayerMessage(playerid, "Minimum FPS does not work as of IV:MP 0.1 because getFPS() doesn't work :( this command is in here for when it does work.", COLOR_RED, true);
			
			if(Timers[0].FpsKick != null) Timers[0].FpsKick.kill();
			if(cmd[2] != "0") Timers[0].FpsKick <- timer(FpsKick, 10000, -1);
			
			local ini = EasyINI("AAD/config.ini");
			ini.setKey("Config", "MinFPS", cmd[2]);
			ini.saveData();
			
			Server[0].MinFPS = cmd[2].tointeger();
			
			sendMessageToAll(getPlayerName(playerid) + " has set the minimum FPS to " + cmd[2], COLOR_YELLOW, true);
			
		}
		if(cmd[1] == "pingkick" || cmd[1] == "maxping") {
			if(cmd.len() < 3) { sendPlayerMessage(playerid, COLOR_RED2 + "Usage: " + COLOR_WHITE2 + " /config pingkick [max ping]", COLOR_RED, true); return sendPlayerMessage(playerid, "Set to 0 to disable"); }
			if(!isNumeric(cmd[2])) return sendPlayerMessage(playerid, COLOR_RED2 + "Usage: " + COLOR_WHITE2 + " /config maxping [ping]", COLOR_RED, true);
			
			if(Timers[0].PingKick.isActive()) Timers[0].PingKick.kill();
			if(cmd[2] != "0") Timers[0].PingKick <- timer(PingKick, 10000, -1);
			
			local ini = EasyINI("AAD/config.ini");
			ini.setKey("Config", "MaxPing", cmd[2]);
			ini.saveData();
			
			Server[0].MaxPing = cmd[2].tointeger();
			
			sendMessageToAll(getPlayerName(playerid) + " has set the max ping to " + cmd[2], COLOR_YELLOW, true);	
		}
		if(cmd[1] == "weather") {
			if(cmd.len() < 3) return sendPlayerMessage(playerid, COLOR_RED2 + "Usage: " + COLOR_WHITE2 + " /color weather [weatherid]", COLOR_RED, true);
			if(!isNumeric(cmd[2])) return sendPlayerMessage(playerid, COLOR_RED2 + "Usage: " + COLOR_WHITE2 + " /color weather [weatherid]", COLOR_RED, true);
			if(cmd[2].tointeger() > 10 || cmd[2].tointeger() < 1) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "Invalid weather ID", COLOR_RED, true);
			local ini = EasyINI("AAD/config.ini");
			ini.setKey("Config", "Weather", cmd[2]);
			ini.saveData();
			
			Server[0].Weather = cmd[2].tointeger();
			
			setWeather(cmd[2].tointeger());
			sendMessageToAll(getPlayerName(playerid) + " has changed the default weather to " + cmd[2], COLOR_YELLOW, true);
			return 1;
		}	
		if(cmd[1] == "nicks") {
			if(Server[0].Nicks == 0) {
				ini.setKey("Config", "Nicks", 1);
				ini.saveData();
				Server[0].Nicks = 1;
				sendPlayerMessage(playerid, "Set nick changing to allowed!", COLOR_YELLOW, true);
				return 1;
			} else if(Server[0].Nicks == 1) {	
				ini.setKey("Config", "Nicks", 0);
				ini.saveData();
				Server[0].Nicks = 0;
				sendPlayerMessage(playerid, "Set nick changing to disallowed!", COLOR_YELLOW, true);
				return 1;
			}
		}		
        if(cmd[1] == "clantag") {
            if(cmd.len() >= 3) {
                local clantag = cmd[2].tostring();
                if(clantag.tolower().find("[") != null || clantag.tolower().find("]") != null) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "DO NOT use []'s", COLOR_RED, true);           
                setClanTag(playerid, clantag);
            }
        }
        if(cmd[1] == "autoswap" || cmd[1] == "autoinvert") {
            if(Server[0].Autoswap == 1) {
                ini.setKey("Config", "Autoswap", 0);
                ini.saveData();
                Server[0].Autoswap = 0;
                if(ini.getKey("Config", "Autoswap").tointeger() == 0) {
					sendPlayerMessage(playerid, "You've disabled auto swap after every round", COLOR_YELLOW, true);
					sendMessageToAll(getPlayerName(playerid) + " has disabled Auto-Swap after every round", COLOR_YELLOW, true);
				}	
                else return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "An unknown error has occured, please re-do this command", COLOR_RED, true);
            }
            else if(Server[0].Autoswap == 0) {
                ini.setKey("Config", "Autoswap", 1);
                ini.saveData();
                Server[0].Autoswap = 1;
                if(ini.getKey("Config", "Autoswap").tointeger() == 1) {
					sendPlayerMessage(playerid, "You've enabled auto swap after every round", COLOR_YELLOW, true);
					sendMessageToAll(getPlayerName(playerid) + " has enabled Auto-Swap after every round", COLOR_YELLOW, true);
				}
                else return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "An unknown error has occured, please re-do this command", COLOR_RED, true);
            }
        }
        if(cmd[1] == "autobalance") {
			local ini = EasyINI("AAD/config.ini");
            if(Server[0].Autobalance == 1) {
                ini.setKey("Config", "Autobalance", 0);
                ini.saveData();
                Server[0].Autobalance = 0;
                if(ini.getKey("Config", "Autobalance").tointeger() == 0) {
					sendPlayerMessage(playerid, "You've disabled auto balance before every round", COLOR_YELLOW, true);
					sendMessageToAll(getPlayerName(playerid) + " has disabled Auto-Balance before every round", COLOR_YELLOW, true);
				}	
                else return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "An unknown error has occured, please re-do this command", COLOR_RED, true);
            }
            else if(Server[0].Autobalance == 0) {
                ini.setKey("Config", "Autobalance", 1);
                ini.saveData();
                Server[0].Autobalance = 1;
                if(ini.getKey("Config", "Autobalance").tointeger() == 1) {
					sendPlayerMessage(playerid, "You've enabled auto balance before every round", COLOR_YELLOW, true);
					sendMessageToAll(getPlayerName(playerid) + " has enabled Auto-Balance before every round", COLOR_YELLOW, true);
				}	
                else return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "An unknown error has occured, please re-do this command", COLOR_RED, true);
            }
        }
        if(cmd[1] == "vehiclekilling") {
			if(cmd.len() < 3) return sendPlayerMessage(playerid, COLOR_RED2 + "Usage: " + COLOR_WHITE2 + " /config vehiclekilling [1-0]", COLOR_RED, true);
			if(!isNumeric(cmd[2])) return sendPlayerMessage(playerid, COLOR_RED2 + "Usage: " + COLOR_WHITE2 + " /config vehiclekilling [1-0]", COLOR_RED, true);
			if(cmd[2].tointeger() < 0 || cmd[2].tointeger() >= 2) return sendPlayerMessage(playerid, COLOR_RED2 + "Usage: " + COLOR_WHITE2 + " /config vehiclekilling [1-0]", COLOR_RED, true);
			local ini = EasyINI("AAD/config.ini");
			ini.setKey("Config", "VehicleKilling", cmd[2]);
			ini.saveData();
			Server[0].VehicleKilling = cmd[2].tointeger();
			if(cmd[2].tointeger() == 0) return sendMessageToAll(getPlayerName(playerid) + " has disallowed Vehicle killing.", COLOR_YELLOW, true);
			else if(cmd[2].tointeger() == 1) return sendMessageToAll(getPlayerName(playerid) + " has allowed Vehicle Killing.", COLOR_YELLOW, true);
			return 1;
		}
        if(cmd[1] == "cptime") {
            if(cmd.len() >= 3) {
                if(!isNumeric(cmd[2])) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "Invalid cptime", COLOR_RED, true);
                if(IsBaseStarted == 1) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "Cannot use cmd will a base is started!", COLOR_RED, true);
				local cptime = cmd[2].tointeger();
				if(cptime >= 0 && cptime <= 60) {
				    local ini = EasyINI("AAD/config.ini");
				    
				    ini.setKey("Checkpoint", "CPTime", cptime);
				    ini.saveData();
				    
				    Server[0].CPTime = cptime;
				    
				    if(ini.getKey("Checkpoint", "CPTime") == null) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "An unknown error has occured, please re-use this cmd", COLOR_RED, true);
				    return sendMessageToAll(getPlayerName(playerid) + " saved the cptime to: " + ini.getKey("Checkpoint", "CPTime"), COLOR_YELLOW, true);
				} else return sendPlayerMessage(playerid, COLOR_RED2 + "Usage: " + COLOR_WHITE2 + " /config cptime [0-60], 0 to turn off", COLOR_RED, true);
			} else return sendPlayerMessage(playerid, COLOR_RED2 + "Usage: " + COLOR_WHITE2 + " /config cptime [0-60], 0 to turn off", COLOR_RED, true);
		}
		if(cmd[1] == "cpsize") {
            if(cmd.len() >= 3) {
                if(!isNumeric(cmd[2])) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "Invalid cpsize", COLOR_RED, true);
                if(IsBaseStarted == 1) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "Cannot use cmd will a base is started!", COLOR_RED, true);
				local cpsize = cmd[2].tointeger();
				if(cpsize >= 0 && cpsize <= 60) {
				    local ini = EasyINI("AAD/config.ini");
				    
				    ini.setKey("Checkpoint", "CPSize", cpsize);
				    ini.saveData();
				    
				    Server[0].CPSize = cpsize;
				    if(ini.getKey("Checkpoint", "CPSize") == null) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "An unknown error has occured, please re-use this cmd", COLOR_RED, true);
				    return sendMessageToAll(getPlayerName(playerid) + "  saved the cpsize to: " + ini.getKey("Checkpoint", "CPSize"), COLOR_RED, true);
				} else return sendPlayerMessage(playerid, COLOR_RED2 + "Usage: " + COLOR_WHITE2 + " /config cpsize [0-60], 0 to turn off", COLOR_RED, true);
			} else return sendPlayerMessage(playerid, COLOR_RED2 + "Usage: " + COLOR_WHITE2 + " /config cpsize [0-60], 0 to turn off", COLOR_RED, true);
		}		           
        if(cmd[1] == "nameban" || cmd[1] == "namebans" || cmd[1] == "banclan") {
            if(cmd.len() >= 3) {
                local tmp = getHighestNameBanID().tointeger();
                tmp++;
				local ini = EasyINI("AAD/namebans/" + tmp + ".ini");
				local nametoban = cmd[2];
				if(nametoban.tolower().find("[") != null || nametoban.tolower().find("]") != null) return sendPlayerMessage(playerid, "Do not use []'s!", COLOR_RED, true);
				ini.setKey("Stuff", "Name", nametoban);
				ini.saveData();
				local nametoban2 = ini.getKey("Stuff", "Name"); //confirm the name is in the ini file
				if(nametoban2 == null) return sendPlayerMessage(playerid, "The name was not saved for some reason, retype the command", COLOR_RED, true);
				sendPlayerMessage(playerid, "You've banned everyone with the name: " + cmd[2], COLOR_GREEN);
				for(local i=0; i <= Server[0].HighestID+1; ++i) if(isPlayerConnected(i)) {
				    local namez = getPlayerName(i);
				    if(namez.tolower().find(nametoban2.tolower()) != null) {
				        sendPlayerMessage(playerid, "Your name is banned from this server, a head administrator has name banned you.", COLOR_GREEN);
						Banned(playerid);
						EasyINI("AAD/Users/" + getPlayerName(playerid) + ".ini").setKey("Login", "Banned", 1); //yes ban the player, don't check if they have an account.
						banPlayer(playerid, 0);
					}
				}
				sendMessageToAll(getPlayerName(playerid) + " has banned all players with the name: " + cmd[2], COLOR_YELLOW, true);
				return 1;		
			}
			return sendPlayerMessage(playerid, COLOR_RED2 + "Usage: " + COLOR_WHITE2 + " /config nameban [name]", COLOR_RED, true);
		}				
        if(cmd[1] == "ragdoll") {
            local ini = EasyINI("AAD/config.ini");
            makeKeyIfDoesntExist(ini, "Config", "Ragdoll", 1);
            
            local ragdoll = ini.getKey("Config", "Ragdoll").tointeger();
            if(ragdoll == 1) {
				for(local i=0; i <= Server[0].HighestID+1; ++i) if(isPlayerConnected(i)) togglePlayerPhysics(i, false);
				ini.setKey("Config", "Ragdoll", 0);
                ini.saveData();
                Server[0].Ragdoll = 0;
                sendMessageToAll(getPlayerName(playerid) + " has disabled (ragdoll/physics)", COLOR_YELLOW, true);
            }
            else if(ragdoll == 0) {
                for(local i=0; i <= Server[0].HighestID+1; ++i) if(isPlayerConnected(i)) togglePlayerPhysics(i, true);
				ini.setKey("Config", "Ragdoll", 1);
                ini.saveData();
                Server[0].Ragdoll = 1;
                sendMessageToAll(getPlayerName(playerid) + " has enabled (ragdoll/physics)", COLOR_YELLOW, true);
            }
            return 1;
        }                          
        if(cmd[1] == "teamname") {
            if(cmd.len() < 4) {
                sendPlayerMessage(playerid, COLOR_RED2 + "Usage: " + COLOR_WHITE2 + " /config teamname [teamid] [new name]", COLOR_RED, true);
                sendPlayerMessage(playerid, "Attackers = 1", COLOR_RED, true);
                sendPlayerMessage(playerid, "Defenders = 2", COLOR_RED, true);
                return 1;
            }
            local teamid = cmd[2].tostring();
            if(!isNumeric(teamid)) {
                sendPlayerMessage(playerid, COLOR_RED2 + "Usage: " + COLOR_WHITE2 + " /config teamname [teamid] [new name]", COLOR_RED, true);
                sendPlayerMessage(playerid, "Attackers = 1", COLOR_RED, true);
                sendPlayerMessage(playerid, "Defenders = 2", COLOR_RED, true);
                return 1;
            }
            if(teamid.tointeger() == 1 || teamid.tointeger() == 2) {
				local cmd2 = split(command, " ");   
                setTeamName(playerid, teamid, cmd2[3]); //allow caps.
                return 1;
            }
            sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "Invalid team!", COLOR_RED, true); 
        }
        if(cmd[1] == "vused") {
            local ini = EasyINI("AAD/vehconfig.ini");
            if(!fexist(file)) {
                for(local i=0; i < vehicleNames.len(); ++i) {
                    makeKeyIfDoesntExist(ini, "Vehicles", "" + i);
                }
            }    
            if(cmd.len() >= 3) {
                local targetvehid = cmd[2];
                if(!isNumeric(targetvehid)) {
                    local tmp = getVehicleIDFromName(targetvehid);
                    targetvehid = tmp.tointeger();
                }
                else if(isNumeric(targetvehid)) { local tmp = targetvehid.tointeger(); targetvehid = tmp; }
                local Currentstate = ini.getKey("Vehicles", targetvehid.tostring());
                local tmp2 = Currentstate; Currentstate = tmp2;
                local tmp3 = targetvehid.tostring(); targetvehid = tmp3;
                if(Currentstate == "1") {
                    ini.setKey("Vehicles", targetvehid, 0);
                    Server[targetvehid].Vehicles = 0;
                    sendPlayerMessage(playerid, "Vehicle " + vehicleNames[targetvehid.tointeger()] + " has been disabled.", COLOR_YELLOW, true);
                }    
                else if(Currentstate == "0") {
                    ini.setKey("Vehicles", targetvehid, 1);
                    Server[targetvehid].Vehicles = 1;
                    sendPlayerMessage(playerid, "Vehicle " + vehicleNames[targetvehid.tointeger()] + " has been enabled.", COLOR_YELLOW, true);
                }
                ini.saveData();    
            } 
            sendPlayerMessage(playerid, COLOR_RED2 + "Usage: " + COLOR_WHITE2 + " /config vused [vehicleid / name]", COLOR_RED, true);
            return 1;  
        }
        if(cmd[1] == "lgunused") {                                
            local ini = EasyINI("AAD/wepconfig.ini");
            if(!fexist(file)) {
                for(local i=0; i <= WeaponNames.len(); ++i) {
					if(!isValidWep(i)) continue;
                    makeKeyIfDoesntExist(ini, "Weapons", "" + i);
                }
            }    
            if(cmd.len() >= 3) {
                local targetwepid = cmd[2];
                disableLobbyWeapon(targetwepid); 
				//sendMessageToAll(getPlayerName(playerid) + " has disabled " + WeaponNames[targetwepid] + " in the lobby", COLOR_YELLOW, true);
            }  
        }
        if(cmd[1] == "lobbyweapons" || cmd[1] == "lobbyweps" || cmd[1] == "lobbywep") {
            local ini = EasyINI("AAD/wepconfig.ini");
            if(!fexist(file)) {
                for(local i=0; i <= WeaponNames.len(); ++i) {
					if(!isValidWep(i)) continue;
                    makeKeyIfDoesntExist(ini, "Weapons", "" + i);
                }
            }
            lobbyWeps(playerid);       
        }
        if(cmd[1] == "setlist" || cmd[1] == "gunmenu" || cmd[1] == "setlists" || cmd[1] == "gunused" || cmd[1] == "weps") {
            local ini = EasyINI("AAD/wepconfig.ini");
            makeKeyIfDoesntExist(ini, section, "0");
			makeKeyIfDoesntExist(ini, section, "1");
			makeKeyIfDoesntExist(ini, section, "2");
			makeKeyIfDoesntExist(ini, section, "3");
			makeKeyIfDoesntExist(ini, section, "4");
			if(cmd.len() <= 3) return sendPlayerMessage(playerid, COLOR_RED2 + "Usage: " + COLOR_WHITE2 + " /config setlist [setlistid] [weps MAX 3]", COLOR_RED, true);
			
			if(!isNumeric(cmd[2])) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "Invalid setlist id", COLOR_RED, true);
			local wepids = command.slice(cmd[0].len() + cmd[1].len() + cmd[2].len() + 3, command.len());
			if(cmd[2].tointeger() <= 0 && cmd[2].tointeger() >= 4) return sendPlayerMessage(playerid, COLOR_RED2 + "Usage: " + COLOR_WHITE2 + " /config setlist [setlistid] [weps MAX 3]", COLOR_RED, true);
			
			local gunids = split(wepids.tolower(), " ");
			if(gunids.len() >= 1) {
				if(!isNumeric(gunids[0])) gunids[0] = getWeaponIDFromName(gunids[0]).tointeger();
				if(isValidWep(gunids[0].tointeger()) == 0) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "Invalid weapons", COLOR_RED, true);
				ini.setKey("Gunmenu", cmd[2], gunids[0]);
			}
			if(gunids.len() >= 2) {
				if(!isNumeric(gunids[1])) gunids[1] = getWeaponIDFromName(gunids[1]).tointeger();
				if(isValidWep(gunids[1].tointeger()) == 0) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "Invalid weapons", COLOR_RED, true);
				ini.setKey("Gunmenu", cmd[2], gunids[0] + " " + gunids[1]);
			}
			if(gunids.len() == 3) {	
				if(!isNumeric(gunids[2])) gunids[2] = getWeaponIDFromName(gunids[2]).tointeger();
				if(isValidWep(gunids[2].tointeger()) == 0) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "Invalid weapons", COLOR_RED, true);
				ini.setKey("Gunmenu", cmd[2], gunids[0] + " " + gunids[1] + " " + gunids[2]);
			}
			ini.saveData();
			Server[cmd[2]].Gunmenu = ini.getKey("Gunmenu", cmd[2]);
			return sendPlayerMessage(playerid, "You've set setlist id " + cmd[2] + " to weapons " + wepids, COLOR_YELLOW, true);
		}		
        if(cmd[1] == "website") {
            local ini = EasyINI("AAD/config.ini");
            makeKeyIfDoesntExist(ini, "Config", "Website");
            if(cmd.len() <= 2) return sendPlayerMessage(playerid, COLOR_RED2 + "Usage: " + COLOR_WHITE2 + " /config website [website]", COLOR_RED, true);
            ini.setKey("Config", "Website", "http://www." + cmd[2]);
            ini.saveData();
            Server[0].Website = "http://www." + cmd[2];
            sendPlayerMessage(playerid, "Saved website as '" + "http://www." + cmd[2] + "'", COLOR_GREEN);
        }
        if(cmd[1] == "tele" || cmd[1] == "teles" || cmd[1] == "teleport" || cmd[1] == "teleports") {
            if(cmd.len() <= 2) return sendPlayerMessage(playerid, COLOR_RED2 + "Usage: " + COLOR_WHITE2 + " /config tele [create/edit]", COLOR_RED, true);
            if(cmd.len() >= 2) {
                if(cmd[2] == "create") {
                    local tmp = getHighestTeleID();
                    tmp++;
					local ini = EasyINI("AAD/teles/" + tmp + ".ini");
					ini.setKey("Creator", "Creator", getPlayerName(playerid).tostring());
					local pos = getPlayerCoordinates(playerid);
					ini.setKey("pos", "X", pos[0]);
					ini.setKey("pos", "Y", pos[1]);
					ini.setKey("pos", "Z", pos[2]);
					ini.saveData();
					
					Tele[tmp].X = pos[0].tofloat();
					Tele[tmp].Y = pos[1].tofloat();
					Tele[tmp].Z = pos[2].tofloat();
					return sendPlayerMessage(playerid, "Your created '/t " + tmp + "'", COLOR_YELLOW, true);
                }
                if(cmd[2] == "edit") {
                    if(cmd.len() == 3) return sendPlayerMessage(playerid, COLOR_RED2 + "Usage: " + COLOR_WHITE2 + " /config tele edit [teleportid]", COLOR_RED, true);
					if(!isNumeric(cmd[3])) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "Invalid teleport ID", COLOR_RED, true);
					local tele = cmd[3].tointeger();
					if(!fexist("AAD/teles/" + tele + ".ini")) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "This teleport ID doesn't exist");
					local ini = EasyINI("AAD/teles/" + tele + ".ini");
					local pos = getPlayerCoordinates(playerid);
					ini.setKey("pos", "X", pos[0]);
					ini.setKey("pos", "Y", pos[1]);
					ini.setKey("pos", "Z", pos[2]);
					ini.saveData();
					
					Tele[tele].X = pos[0].tofloat();
					Tele[tele].Y = pos[1].tofloat();
					Tele[tele].Z = pos[2].tofloat();
					return sendPlayerMessage(playerid, "You've saved teleport id " + tele + " to this location", COLOR_GREEN);
				}
			}
			return 1;		
        }
        if(cmd[1] == "skins" || cmd[1] == "skin") toggleSkinsEnabled(playerid);
        if(cmd[1] == "teamskin") {
            local ini = EasyINI("AAD/config.ini");
            makeKeyIfDoesntExist(ini, "Skins", "AttackersSkin");
            makeKeyIfDoesntExist(ini, "Skins", "DefendersSkin");
            
            if(cmd.len() != 4) return sendPlayerMessage(playerid, COLOR_RED2 + "Usage: " + COLOR_WHITE2 + " /config teamskin [teamid] [skinid]", COLOR_RED, true);
			if(!isNumeric(cmd[2])) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "Invalid team id", COLOR_RED, true);
			if(!isNumeric(cmd[3])) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "Invalid skin", COLO_RED);
			
			local teamid = cmd[2].tointeger();
			if(teamid == 1) { //Attackers
			    ini.setKey("Skins", "AttackersSkin", cmd[3]);
			    ini.saveData();
			    Server[0].AttackersSkin = cmd[3].tointeger();
			    return sendPlayerMessage(playerid, "Changed Attackers skin to: " + cmd[3], COLOR_GREEN);
			}
			else if(teamid == 2) { //Defenders
			    ini.setKey("Skins", "DefendersSkin", cmd[3]);
			    ini.saveData();
			    Server[0].DefendersSkin = cmd[3].tointeger();
			    return sendPlayerMessage(playerid, "Changed Defenders skin to: " + cmd[3], COLOR_GREEN);
			}
			return 1;
		}
		if(cmd[1] == "customspawns" || cmd[1] == "spawns" || cmd[1] == "spawn") {
			if(Server[0].CustomSpawns == 1) {
				ini.setKey(section, key, 0);
				ini.saveData();
				Server[0].CustomSpawns = 0;
				return sendMessageToAll(getPlayerName(playerid) + " Has disabled /spawn", COLOR_YELLOW, true);
			}
			else if(Server[0].CustomSpawns == 0) {
			    ini.setKey(section, key, 1);
				ini.saveData();
				Server[0].CustomSpawns = 1;
				return sendMessageToAll(getPlayerName(playerid) + " Has enabled /spawn", COLOR_YELLOW, true);
			}
		    return 1;
		}
		if(cmd[1] == "autoaim" || cmd[1] == "toggleautoaim") {	    
		    local ini = EasyINI("AAD/config.ini");
		    makeKeyIfDoesntExist(ini, "Config", "Autoaim");
		    if(Server[0].Autoaim == 0) { //if autoaim is disabled...
		        toggleAutoAim(true);
		        ini.setKey("Config", "Autoaim", 1);
		        ini.saveData();
		        Server[0].Autoaim = 1;
		        return sendMessageToAll(getPlayerName(playerid) + " has toggled autoaim on! (players can now use autoaim)", COLOR_YELLOW, true);
		    }
		    else if(Server[0].Autoaim == 1) {
		        toggleAutoAim(false);
		        ini.setKey("Config", "Autoaim", 0);
		        ini.saveData();
		        Server[0].Autoaim = 0;
		        return sendMessageToAll(getPlayerName(playerid) + " has toggled autoaim off! (players cannot use autoaim!", COLOR_YELLOW, true);
		    }
		    return 1;
		}
		if(cmd[1] == "clanwar" || cmd[1] == "clanwars") {

		    local ini = EasyINI("AAD/config.ini");
		    makeKeyIfDoesntExist(ini, "Clanwar", "Clantag1");
		    makeKeyIfDoesntExist(ini, "Clanwar", "Clantag2");
		    if(Server[0].Clanwar == 0) {
		        if(cmd.len() >= 4) {
		            if(cmd[2].tolower().find("[") != null || cmd[2].tolower().find("]") != null || cmd[3].tolower().find("[") != null || cmd[3].tolower().find("]") != null) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "DO NOT use []'s", COLOR_RED, true);
		            ini.setKey("Clanwar", "Clantag1", cmd[2]);
		            ini.setKey("Clanwar", "Clantag2", cmd[3]);
		            local Attackersname = ini.getKey("Config", "Attackers");
		            local Defendersname = ini.getKey("Config", "Defenders");
		            ini.setKey("Config", "Attackerstmp", Attackersname);
		            ini.setKey("Config", "Defenderstmp", Defendersname);
		            ini.setKey("Config", "Attackers", cmd[2]);
		            ini.setKey("Config", "Defenders", cmd[3]);
		            ini.setKey("Clanwar", "Enabled");
		            ini.saveData();
		            sendMessageToAll(getPlayerName(playerid) + " Has enabled clanwar mode. all players that are not found with the clanwar tags will be removed.", COLOR_YELLOW, true);
		            sendMessageToAll("If your an admin, this autokick will ignore you.", COLOR_GREEN);
		            for(local i=0; i <= Server[0].HighestID+1; ++i) if(isPlayerConnected(i)) {
		                if(!IsPlayerAdmin(i)) { //will kick all players that don't have the clanwar tags, besides admins.
		                    local name = getPlayerName(i);
		                    if(name.tolower().find("[" + cmd[2] + "]") == null && name.tolower().find("[" + cmd[3] + "]") == null) {
		                         sendPlayerMessage(i, COLOR_WHITE2 + "You've " + COLOR_YELLOW2 + "been kicked for not being in the clanwar! return to this server later!", COLOR_YELLOW, true);
		                         kickPlayer(i, true);
		                    }    
		                }           
		            }
		            Server[0].Clanwar = 1;       
		            return sendMessageToAll("Auto-kicking completed.", COLOR_YELLOW, true);
		        }
		        return sendPlayerMessage(playerid, COLOR_RED2 + "Usage: " + COLOR_WHITE2 + " /config clanwar [clantag1] [clantag2]", COLOR_RED, true);
		    }
		    else if(Server[0].Clanwar == 1) {
		        ini.deleteKey("Clanwar", "Clantag1");
		        ini.deleteKey("Clanwar", "Clantag2");
		        local Attackersname = ini.getKey("Config", "Attackerstmp");
		        local Defendersname = ini.getKey("Config", "Defenderstmp");
		        ini.setKey("Config", "Attackers", Attackersname);
		        ini.setKey("Config", "Defenders", Defendersname);
		        ini.deleteKey("Config", "Attackerstmp");
		        ini.deleteKey("Config", "Defenderstmp");
		        ini.saveData();
		        sendMessageToAll(getPlayerName(playerid) + " Has disabled clanwar mode.", COLOR_YELLOW, true);
		        Server[0].Clanwar = 0;
		    }
		    return 1;		        
		}
		if(cmd[1] == "hideadmins" || cmd[1] == "admins" || cmd[1] == "admin") {
		    local ini = EasyINI("AAD/config.ini");
		    if(Server[0].HideAdmins == 0) {
		        ini.setKey("Config", key, 1);
		        ini.saveData();
		        Server[0].HideAdmins = 1;
		        return sendPlayerMessage(playerid, "You've enabled showing of admins in the /admins command!", COLOR_GREEN);		        
		    }
		    else if(Server[0].HideAdmins == 1) {
		        ini.setKey(section, key, 0);
		        ini.saveData();
		        Server[0].HideAdmins = 0;
		        return sendPlayerMessage(playerid, "You've disabled showing of admins in the /admins command!", COLOR_GREEN);
		    }
		    return 1;
		}
		if(cmd[1] == "rules" || cmd[1] == "rule") {
		    if(cmd.len() >= 4) {
		        local targetrule;
		        if(isNumeric(cmd[2]) && cmd[2].tointeger() >= 0 && cmd[2].tointeger() <= 4) targetrule = cmd[2].tostring();
		        else return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "Invalid rule!", COLOR_RED, true);
		        local ini = EasyINI("AAD/config.ini");
		        local rule = command.slice(cmd[0].len() + cmd[1].len() + cmd[2].len() + 3, command.len());
                ini.setKey("Rules", targetrule, rule);
                ini.saveData();
                Server[targetrule.tointeger()].Rules = rule;
                return sendPlayerMessage(playerid, "You've saved rule " + targetrule + " to " + rule, COLOR_GREEN);
            }
            else return sendPlayerMessage(playerid, COLOR_RED2 + "Usage: " + COLOR_WHITE2 + " /config rules [ruleid] [new rule]", COLOR_RED, true);
        }
        if(cmd[1] == "modemin" || cmd[1] == "roundtime") {
			if(cmd.len() < 4) return sendPlayerMessage(playerid, COLOR_RED2 + "Usage: " + COLOR_WHITE2 + " /config modemin [minutes] [seconds]", COLOR_RED, true);
			if(!isNumeric(cmd[2]) || !isNumeric(cmd[3])) return sendPlayerMessage(playerid, COLOR_RED2 + "Usage: " + COLOR_WHITE2 + " /config modemin [minutes] [seconds]", COLOR_RED, true);
			if(isRoundStarted() == 1) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "You cannot use this command while a round is started", COLOR_RED, true);
			local minutes = cmd[2].tointeger() * 60 * 1000;
			local seconds = cmd[3].tointeger() * 1000;
			local modemin = minutes+seconds;
			local ini = EasyINI("AAD/config.ini");
			ini.setKey("Config", "Roundtimer", modemin);
			ini.saveData();
			Server[0].ModeTime = modemin;
			if(ini.getKey("Config", "Roundtimer").tointeger() != modemin) /*if the stuff in the file ISNT = to what you typed*/ return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "An unknown error has occured, please retype the command", COLOR_RED, true);
			else return sendPlayerMessage(playerid, "You've changed the round timer to " + cmd[2] + " minutes " + cmd[3] + " seconds", COLOR_GREEN); 
		}	               	            		        	    		                             		                      			    			
        //more cfg cmds    
        return 1;
    }            
                                               
    if(cmd[0] == "/credits") { 
        sendPlayerMessage(playerid, "Dire Consequences A/D + TDM " + SCRIPT_VERSION + " was created by Whitetiger.", COLOR_GREEN);
        sendPlayerMessage(playerid, "Credits: MaVe, Pyrokid, [NB]90N1N3, Boylett, Raekwon, Devastator, Coscos007, Jones, aikinetic, bogeyman_EST & IV:MP team.", COLOR_BLUE);
        return 1;
    }
    if(cmd[0] == "/kill") return setPlayerHealth(playerid, -1);
    if(cmd[0] == "/spawn") {
        if(cmd.len() != 2) return sendPlayerMessage(playerid, COLOR_RED2 + "Usage: " + COLOR_WHITE2 + " /spawn [deathspot/set/reset]", COLOR_RED, true);
        if(Server[0].CustomSpawns == 0) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "Custom spawning is disabled.", COLOR_RED, true);
        local ini = EasyINI("AAD/Users/" + getPlayerName(playerid) + ".ini");
        if(cmd[1] == "deathspot") {
            ini.setKey("Spawn", "Spawn", 1);
            ini.saveData();
            return sendPlayerMessage(playerid, "Spawn saved to Deathspot!", COLOR_GREEN);
        }
        if(cmd[1] == "set") {
            ini.setKey("Spawn", "Spawn", 2);
            local pos = getPlayerCoordinates(playerid);
            ini.setKey("Spawn", "X", pos[0]);
            ini.setKey("Spawn", "Y", pos[1]);
            ini.setKey("Spawn", "Z", pos[2]);
            ini.saveData();
            return sendPlayerMessage(playerid, "Spawn set", COLOR_GREEN);
        }
        if(cmd[1] == "reset") {
            ini.setKey("Spawn", "Spawn", 0);
            ini.saveData();
            return sendPlayerMessage(playerid, "Spawn reset", COLOR_GREEN);
        }    
        return sendPlayerMessage(playerid, COLOR_RED2 + "Usage: " + COLOR_WHITE2 + " /spawn [deathspot/set/reset]", COLOR_RED, true);       
    }   	    
    sendPlayerMessage(playerid, "SERVER: Unknown Command", COLOR_WHITE, true);                       	         			   
    return 0; 
}
addEvent("playerCommand", onPlayerCommand);

function onPlayerDeath(playerid, killerid, killervehicle) {
    if(LogFunctions == 1) log("onPlayerDeath " + getPlayerName(playerid));
    removePlayerWeapons(playerid);
    //sendPlayerMessage(playerid, "DEBUG: " + killervehicle, COLOR_RED, true);
    if(Duel[playerid].inDuel == 1 && playerid != killerid) {
        local killerid2 = Duel[playerid].invitedby;     
        local playername = getPlayerName(playerid);
        local killername = getPlayerName(killerid2);
        sendMessageToAll(killername + " Has killed " + playername + " In a duel", COLOR_GREEN);
		local ini = EasyINI("AAD/config.ini");
        setPlayerCoordinates(killerid2, Server[0].Lobby, Server[1].Lobby, Server[2].Lobby);
        setPlayerHealth(killerid2, 200);
        setPlayerArmour(killerid2, 200);
        removePlayerWeapons(killerid2);  
        local file = EasyINI("AAD/Users/" + killername + ".ini");
        local DuelWins = file.getKey("Stats", "DuelWins").tointeger();
        file.setKey("Stats", "DuelWins", DuelWins+1);
        file.saveData();
        file = EasyINI("AAD/Users/" + getPlayerName(playerid) + ".ini");
        local loss = file.getKey("Stats", "DuelLosses").tointeger();
        file.setKey("Stats", "DuelLosses", loss+1);
        file.saveData();
        Duel[playerid].inDuel = 0;
        Duel[killerid].inDuel = 0;
        Duel[playerid].invitee = 0;
	    Duel[playerid].inviter = -1;
	    Duel[killerid].invitee = 0;
	    Duel[killerid].invitedby = -1;
	    Duel[killerid].inviter = -1;
	    Duel[playerid].invitedby = -1;
	    return 1;
    }
    local pos1 = getPlayerCoordinates(playerid);
    local pos2 = getPlayerCoordinates(killerid);
    if(isPlayerConnected(killerid)) 
    sendMessageToAll(getPlayerName(killerid) + " Has killed " + getPlayerName(playerid) + " with a " + WeaponNames[getPlayerWeapon(killerid)] + " (Distance: " + getDistanceBetweenPoints3D(pos1[0], pos1[1], pos1[2], pos2[0], pos2[1], pos2[2]) + " ft)", COLOR_GREEN);
    /*if(pInfo[playerid].team == 1) {
        Attackers--;
        pInfo[playerid].team = 0;
    }
    if(pInfo[playerid].team) {
        Defenders--;
        pInfo[playerid].team = 0;
    }*/
    if(pInfo[playerid].IsAttackingInRound == 1) AttackersInRound--;
    if(pInfo[playerid].IsDefendingInRound == 1) DefendersInRound--;
    pInfo[playerid].IsDefendingInRound = 0;
    pInfo[playerid].IsAttackingInRound = 0;
    local epic = EasyINI("AAD/config.ini");
    if(isPlayerConnected(killerid)) if(killervehicle != 65535 && isPlayerInRound(killerid) && isPlayerInRound(playerid) && isRoundStarted() && epic.getKey("Config", "VehicleKilling") == 0) {
		sendMessageToAll(getPlayerName(killerid) + " has been removed from the round for vehicle killing.", COLOR_RED, true);
		removePlayerFromRound(killerid);
	}	
    if(isRoundStarted() == 1) endBaseWithWinner(); 
    local ini = EasyINI("AAD/Users/" + getPlayerName(playerid) + ".ini");
    local spawn = ini.getKey("Spawn", "Spawn");
    makeKeyIfDoesntExist(ini, "Stats", "Deaths");
    ini.setKey("Stats", "Deaths", ini.getKey("Stats", "Deaths").tointeger()+1);
    ini.saveData();
    if(spawn.tointeger() == 1) { // deathspot
        local pos = getPlayerCoordinates(playerid);
        ini.setKey("Spawn", "X", pos[0]);
        ini.setKey("Spawn", "Y", pos[1]);
        ini.setKey("Spawn", "Z", pos[2]);
        ini.saveData();
    }
    ini = EasyINI("AAD/Users/" + getPlayerName(killerid) + ".ini");
    if(ini.getKey("Killmsg", "Killmsg") != null) {
		 displayPlayerText(playerid, 0.4, 0.5, ini.getKey("Killmsg", "Killmsg"), 5000);
	}
	if(isPlayerConnected(killerid)) {
		makeKeyIfDoesntExist(ini, "Stats", "Kills");
		ini.setKey("Stats", "Kills", ini.getKey("Stats", "Kills").tointeger()+1);
		ini.saveData();
	}	
		 
    return 1;
}
addEvent("playerDeath", onPlayerDeath);     

function getHighestBaseID() {
	if(LogFunctions == 1) log("getHighestBaseID");
    local count = 0;
	for(local i=0; i < MAX_BASES; ++i) {
	    local tf = file("AAD/bases/" + i + ".ini", "a+");
	    if(!tf.len()) {
		    tf = null;
		    count--;
		    return count;
	    }
	    count++;
	}
	if(count == null) return 0;  
	return count;  
}

function calculateHighestServerID() {
	if(LogFunctions == 1) log("calculateHighestServerID");
	for(local i=0; i < MAX_PLAYERS; ++i) if(isPlayerConnected(i)) { Server[0].HighestID = i; }
}	

function getHighestTDMID() {
	if(LogFunctions == 1) log("getHighestTDMID");
    local count = 0;
	for(local i=0; i < MAX_TDM; ++i) {
	    local tf = file("AAD/tdm/" + i + ".ini", "a+");
	    if(!tf.len()) {
		    tf = null;
		    count--;
		    return count;
	    }
	    count++;
	}
	if(count == null) return 0;  
	return count;  
}

function getHighestNameBanID() {
	if(LogFunctions == 1) log("getHighestNameBanID");
    local count = 0;
	for(local i=0; i < MAX_BASES; ++i) {
	    local tf = file("AAD/namebans/" + i.tostring() + ".ini", "a+");
	    if(!tf.len()) {
		    tf = null;
		    count--;
		    return count;
	    }
	    count++;
	}
	return count;  
}

function getHighestTeleID() {
	if(LogFunctions == 1) log("getHighestTeleID");
    local count = 0;
	for(local i=0; i < MAX_TELE; ++i) {
	    local tf = file("AAD/teles/" + i + ".ini", "a+");
	    if(!tf.len()) {
		    tf = null;
		    count--;
		    return count;
	    }
	    count++;
	}
	if(count == null) return 0;  
	return count;  
}

local unpausetime = 5;
function UnpauseRound() {
	if(LogFunctions == 1) log("UnpauseRound: " + unpuasetime);
	unpausetime--;
	if(unpausetime == 0) {
		for(local i=0; i <= Server[0].HighestID+1; ++i) if(isPlayerConnected(i)) if(isPlayerInRound(i)) togglePlayerFrozen(i, false);
		Timers[0].UnpauseTimer.kill();
		Timers[0].RoundTimer.kill();
		Timers[0].CPTimer.kill();
		Timers[0].RoundTimer = timer(RoundTimerFunc, 1000, Server[0].RoundTime+1);
        Timers[0].CPTimer = timer(CPCheck, 1000, -1);
        Server[0].Paused = 0;
		unpausetime = 5;
		sendMessageToAll("Round unpaused!", COLOR_YELLOW, true);
		return 1;
	}
	else sendMessageToAll("Round unpausing in " + unpausetime + " second(s)", COLOR_YELLOW, true);
	return 1;
}		

function StartBase(baseid) {
	if(LogFunctions == 1) log("StartBase " + baseid);
	if(Timers[0].VoteTimer != null) if(Timers[0].VoteTimer.isActive()) Timers[0].VoteTimer.kill();
	calculatePlayersOnTeams();
	//if(Attackers <= 0 || Defenders <= 0) return sendMessageToAll2("Base " + baseid + " failed to start: Not enough players", COLOR_WHITE, true);
	
	local tmp = EasyINI("AAD/config.ini");
	Server[0].RoundTime = Server[0].ModeTime / 1000;
	Timers[0].RoundTimer = timer(RoundTimerFunc, 1000, Server[0].RoundTime+1);
	
	sendMessageToAll2("* Base " + baseid + " has been started.", COLOR_YELLOW, true);
    local ini = EasyINI("AAD/bases/" + baseid + ".ini");
	if(Bases[baseid].Description != null) if(Bases[baseid].Description != "0") sendMessageToAll2("(" + Bases[baseid].Description + ")", COLOR_YELLOW, true);
	Bases[baseid].TimesPlayed++;
    ini.setKey("Stats", "Timesplayed", Bases[baseid].TimesPlayed);
    ini.saveData();
    
    setRule("Round ", "Base " + baseid);
    CPBlip = createBlip(65, Bases[baseid].CheckpointX, Bases[baseid].CheckpointY, Bases[baseid].CheckpointZ);
    toggleBlipRoute(CPBlip, true);
	cpobjectid = createObject(0x673F486C, Bases[baseid].CheckpointX, Bases[baseid].CheckpointY, Bases[baseid].CheckpointZ, 0.0, 0.0, 0.0);
	Timers[0].CPTimer = timer(CPCheck, 1000, -1);
	Timers[0].WepTimer = timer(weptimer, 30000, 1);
	local attackingwins = Bases[baseid].AttackerWins;
    local Defendingwins = Bases[baseid].DefenderWins;
    local timesplayed = Bases[baseid].TimesPlayed;
    sendMessageToAll("Attacker wins: " + attackingwins + " Defender wins: " + Defendingwins + " Played: " + timesplayed, COLOR_YELLOW, true);
    
    local roundhp;
    local roundar = 0;
    
    if(Server[0].RoundHP > 200) {
		roundhp = 200;
		roundar = Server[0].RoundHP - 200;
	}
	else roundhp = Server[0].RoundHP;
    
	for(local i=0; i <= Server[0].HighestID+1; ++i) {
	    if(isPlayerConnected(i)) {
			setPlayerArmour(i, roundhp);
			setPlayerHealth(i, roundar);
			removePlayerWeapons(i);
	        if(pInfo[i].team == 1) { //Attackers
                setPlayerCoordinates(i, Bases[baseid].AttackerX, Bases[baseid].AttackerY, Bases[baseid].AttackerZ);
                AttackersInRound++;
                pInfo[i].CanPickWeps = 1;
                pInfo[i].IsAttackingInRound = 1;
                sendPlayerMessage(i, "Your attacking this round!", COLOR_WHITE, true);
                sendPlayerMessage(i, "/c [setlist] for weapons, /wlist for setlists, you will be frozen until you pick weapons.", COLOR_GREEN);
                togglePlayerFrozen(i, true);
                //showGunMenu(i);
            }
            else if(pInfo[i].team == 2) { //Defenders
                setPlayerCoordinates(i, Bases[baseid].DefenderX, Bases[baseid].DefenderY, Bases[baseid].DefenderZ);
                DefendersInRound++;
                pInfo[i].CanPickWeps = 1;
                pInfo[i].IsDefendingInRound = 1;
                sendPlayerMessage(i, "Your Defending this round!", COLOR_WHITE, true);
                sendPlayerMessage(i, "/c [setlist] for weapons, /wlist for setlists, you will be frozen until you pick weapons.", COLOR_GREEN);
                togglePlayerFrozen(i, true);
                //showGunMenu(i);
            }
            local pro = EasyINI("AAD/Users/" + getPlayerName(i) + ".ini");
			if(isNumeric(pro.getKey("Config", "DefaultSetlist"))) { GiveWeps(i, pro.getKey("Config", "DefaultSetlist").tointeger()); pInfo[i].CanPickWeps = 0; }
        }   
    }
    IsBaseStarted = 1;
    Server[0].baseid = baseid;
    Server[0].CPTime = Server[0].defaultCPTime;
    return 1;    
}

function endBaseCuzOfTime() {
	if(LogFunctions == 1) log("endBaseCuzOfTime");
	AttackersInRound = 0;
	endBaseWithWinner();
	displayTextForAll(0.4, 0.5, "~r~ Time ran out ~w~ Defenders win", 5000);
}	

function weptimer() {
	if(LogFunctions == 1) log("weptimer");
	for(local i=0; i <= Server[0].HighestID+1; ++i) if(isPlayerConnected(i) && pInfo[i].CanPickWeps == 1) pInfo[i].CanPickWeps = 0;
}	

function CPCheck() { // called once every second if a base is started.
	if(LogFunctions == 1) log("CPCheck");
	local playersincp = 0; 
	for(local i=0; i <= Server[0].HighestID+1; ++i) if(isPlayerConnected(i) && pInfo[i].team == 1) {
		if(IsTDMStarted == 1) { Timers[0].CPTimer.kill(); }
		else if(IsBaseStarted == 1) {
			local x = Bases[Server[0].baseid].CheckpointX;
			local y = Bases[Server[0].baseid].CheckpointY;
			local z = Bases[Server[0].baseid].CheckpointZ;
			local cpsize = Server[0].CPSize;
			if(cpsize == 0 || cpsize == null) { return Timers[0].CPTimer.kill(); }
			local pos = getPlayerCoordinates(i);
			if(getDistanceBetweenPoints3D(pos[0], pos[1], pos[2], x, y, z) < cpsize && Server[0].Paused != 1) onPlayerEnterCP(i);
			else Server[0].CPTime <- Server[0].defaultCPTime;
			if(pInfo[i].InCP == 1) playersincp++;
			//local ini = EasyINI("AAD/config.ini");
			//else { pInfo[i].InCP = 0; setPlayerWantedLevel(i, 0); }
		}
		else { Timers[0].CPTimer.kill(); }
		//Server[0].CPTime = ini.getKey("Checkpoint", "CPTime").tointeger();
	}
	return 1;
}

local wantedlevel = 0;
function onPlayerEnterCP(playerid) {
	if(LogFunctions == 1) log("OnPlayerEnterCP " + getPlayerName(playerid));
	pInfo[playerid].InCP = 1;
	wantedlevel++;
	setPlayerWantedLevel(playerid, wantedlevel);
	if(wantedlevel == 6) wantedlevel = 0;
	Server[0].CPTime--;
	for(local i=0; i <= Server[0].HighestID+1; ++i) displayPlayerInfoText(i,"~r~Attackers~w~ capturing Checkpoint! " + Server[0].CPTime, 1100);
	if(Server[0].CPTime <= 0) {
		sendMessageToAll("Attackers have captured the Checkpoint", COLOR_YELLOW, true);
		DefendersInRound = 0;
		setPlayerWantedLevel(playerid, 0);
		endBaseWithWinner();
		return 1;
	}
	if(Server[0].CPTime <= 7) {
		for(local i=0; i < Server[0].HighestID+1; ++i) {
			if(isPlayerConnected(i) && pInfo[i].team == 2) {
				sendPlayerMessage(i, "[Team chat] ***WARNING***: You are losing the checkpoint! (" + Server[0].CPTime + " time left)", getTeamColor(pInfo[i].team), true);
			}
		}
	}			
	return 1;	
}	
	
		
function StartTDM(tdmid) {
	if(LogFunctions == 1) log("StartTDM " + tdmid);
	if(Timers[0].VoteTimer != null) if(Timers[0].VoteTimer.isActive()) Timers[0].VoteTimer.kill();
	calculatePlayersOnTeams();	
	//if(Attackers <= 0 || Defenders <= 0) return sendMessageToAll2("TDM " + tdmid + " failed to start: Not enough players", COLOR_WHITE, true);
	local tmp = EasyINI("AAD/config.ini");
	Server[0].RoundTime = Server[0].ModeTime / 1000;
	Timers[0].RoundTimer = timer(RoundTimerFunc, 1000, Server[0].RoundTime+1);
    if(IRC == 1) ircSay(iBot, strEchoChannel, "* TDM " + tdmid + " has been started.");
    //sendMessageToAll("Highest Server ID is, " + Server[0].HighestID, COLOR_YELLOW, true);
    local pwn = Server[0].Autobalance;
    if(pwn == 1) balanceTeams(); 
    local ini = EasyINI("AAD/tdm/" + tdmid + ".ini");
    if(TDMs[tdmid].Description != null) if(TDMs[tdmid].Description != "0") sendMessageToAll2("(" + TDMs[tdmid].Description + ")", COLOR_YELLOW, true);
    TDMs[tdmid].TimesPlayed++;
    ini.setKey("Stats", "Timesplayed", TDMs[tdmid].TimesPlayed);
    ini.saveData();
    setRule("Round", "TDM " + tdmid);
	local roundhp;
    local roundar = 0;
    
    if(Server[0].RoundHP > 200) {
		roundhp = 200;
		roundar = Server[0].RoundHP - 200;
	}
	else roundhp = Server[0].RoundHP;
    
	for(local i=0; i <= Server[0].HighestID+1; ++i) {
	    if(isPlayerConnected(i)) {
			setPlayerArmour(i, roundhp);
			setPlayerHealth(i, roundar);
			removePlayerWeapons(i);
	        if(pInfo[i].team == 1) { //Attackers
	            setPlayerCoordinates(i,  TDMs[tdmid].AttackerX, TDMs[tdmid].AttackerY, TDMs[tdmid].AttackerZ);
                AttackersInRound++;
                pInfo[i].IsAttackingInRound = 1;
                pInfo[i].CanPickWeps = 1;
                sendPlayerMessage(i, "Your attacking this round!", COLOR_WHITE, true);
                //showGunMenu(i);
            }
            else if(pInfo[i].team == 2) { //Defenders
               setPlayerCoordinates(i,  TDMs[tdmid].DefenderX, TDMs[tdmid].DefenderY, TDMs[tdmid].DefenderZ);
               DefendersInRound++;
               pInfo[i].IsDefendingInRound = 1;
               pInfo[i].CanPickWeps = 1;
               sendPlayerMessage(i, "Your Defending this round!", COLOR_WHITE, true);
               //showGunMenu(i);
            }
        }   
    }
    local attackingwins = TDMs[tdmid].AttackerWins;
    local Defendingwins = TDMs[tdmid].DefenderWins;
    local timesplayed = TDMs[tdmid].TimesPlayed;
    sendMessageToAll("Attacker wins: " + attackingwins + " Defender wins: " + Defendingwins + " Played: " + timesplayed, COLOR_YELLOW, true);
    
    IsTDMStarted = 1;
    Server[0].baseid = tdmid;
    return 1;    
}

/*function PlayerToPoint(radi, playerid, x, y, z)
{
	if(LogFunctions == 1) log("PlayerToPoint");
    if(isPlayerConnected(playerid))
	{
		local oldposx, oldposy, oldposz;
		local tempposx, tempposy, tempposz;
		local oldpos = getPlayerCoordinates(playerid);
		tempposx = (oldpos[0] -x);
		tempposy = (oldpos[1] -y);
		tempposz = (oldpos[2] -z);
		if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
		{
			return 1;
		}
	}
	return 0;
}*/

function isNumeric(string) {
	if(LogFunctions == 1) log("isNumeric " + string);
	try string.tointeger()
	catch(string) return 0;
	return 1;
}

function isFloat(string) {
	if(LogFunctions == 1) log("isFloat " + string);
	try string.tofloat()
	catch(string) return 0;
	return 1;
}

function fexist(filename)
{
	if(LogFunctions == 1) log("fexist " + filename);
	local tf = file(filename, "a+");
	if(!tf.len())
	{
		tf = null;
		remove(filename);
		return false;
	}
	return true;
}

function pfexist(filename)
{
	if(LogFunctions == 1) log("pfexist " + filename);
	local ini = EasyINI(filename);
	return ini.keyExists("Login", "password");
	/*if(ini.getKey("Login", "password" != null)) return 1;
	else return 0;*/
}

function IsPlayerAdmin(playerid) {
	if(LogFunctions == 1) log("IsPlayerAdmin " + getPlayerName(playerid));
    if(pInfo[playerid].Admin == 1 || pInfo[playerid].Admin == 2) 
		return 1;
    else if(pInfo[playerid].Admin != 1 && pInfo[playerid].Admin != 2) 
		return 0;
    else return 0;
}

function getVehicleIDFromName(vehname) {
	if(LogFunctions == 1) log("getVehicleIDFromName " + vehname);
	for(local i = 0; i < vehicleNames.len(); i += 1) if(vehicleNames[i].tolower()
	.find(vehname.tolower())
	!= null) 
	return i;
	return -1;
}

function getWeaponIDFromName(weapon) {
	if(LogFunctions == 1) log("getWeaponIDFromName " + weapon);
	for(local i = 0; i <= WeaponNames.len(); i += 1) 
		if(isValidWep(i))
			if(WeaponNames[i].tolower().find(weapon.tolower()) != null) return i;
	return -1;
}

function getPlayerIDFromNameOrID(player) //by bogeyman_EST
{
	if(isNumeric(player) && isPlayerConnected(player.tointeger())) return player.tointeger();
	for(local i = 0; i < Server[0].HighestID+1; i += 1)
	{
		if(isPlayerConnected(i) && getPlayerName(i).tolower().find(player.tolower()) != null) return i;
	}
	return -1;
}

/*function getPlayerIDFromNameOrID(player) {
	if(LogFunctions == 1) log("getPlayerIDFromNameOrID " + player);
	if(isNumeric(player) && isPlayerConnected(player.tointeger())) return player.tointeger();
	for(local i=0; i <= Server[0].HighestID+1; ++i) 
	if(isPlayerConnected(i) && getPlayerName(i).tolower().find(player.tolower()) != null) return i;
	else return -1;
}*/

function loginPlayer(playerid) {
	if(LogFunctions == 1) log("loginPlayer " + getPlayerName(playerid));
    local ini = EasyINI("AAD/Users/" + getPlayerName(playerid) + ".ini");
    local tmp = ini.getKey("Login", "level");
    local ip = getPlayerIp(playerid);
    ini.setKey("Login", "IP", ip);
    ini.saveData();
	pInfo[playerid].Admin = tmp.tointeger();
	sendPlayerMessage(playerid, "You successfully logged in! Admin level: " + pInfo[playerid].Admin, COLOR_YELLOW, true);
	pInfo[playerid].LoggedIn = 1;
	if(!isPlayerInRound(playerid)) givePlayerSpawnWeps(playerid);
	useProperSkin(playerid);
	if(pInfo[playerid].Admin == 0) return sendPlayerMessage(playerid, "Welcome back (Normal User)", COLOR_GREEN, true);
	if(pInfo[playerid].Admin == 1) return sendPlayerMessage(playerid, "Welcome back (Moderator)", COLOR_GREEN, true);
	if(pInfo[playerid].Admin == 2) return sendPlayerMessage(playerid, "Welcome back (Administrator)", COLOR_GREEN, true);
}

function putPlayerAtMainSpawn(playerid) {
	if(LogFunctions == 1) log("putPlayerAtMainSpawn " + getPlayerName(playerid));
	local ini = EasyINI("AAD/config.ini");
	setPlayerCoordinates(playerid, ini.getKey("Mainspawn", "x").tofloat(),
	ini.getKey("Mainspawn", "y").tofloat(),
	ini.getKey("Mainspawn", "z").tofloat());
}

function endBase() {
	if(LogFunctions == 1) log("endBase");
	if(Timers[0].CPTimer != null) Timers[0].CPTimer.kill();
	if(Timers[0].WepTimer != null) Timers[0].WepTimer.kill();
	if(Timers[0].RoundTimer != null) Timers[0].RoundTimer.kill();
    IsBaseStarted = 0;
    IsTDMStarted = 0;
    deleteBlip(CPBlip);
    deleteObject(cpobjectid);
    cpobjectid = -1;
    CPBlip = -1;
    AttackersInRound = 0;
	DefendersInRound = 0;  
	Server[0].baseid = "Lobby"; 
	setRule("Round", "Lobby");
    for(local i=0; i <= Server[0].HighestID+1; ++i) {
        if(isPlayerConnected(i)) {
	        pInfo[i].IsAttackingInRound = 0;
	        pInfo[i].IsDefendingInRound = 0;
	        setPlayerWantedLevel(i, 0);
	        removePlayerWeapons(i);  
            putPlayerAtMainSpawn(i);
            togglePlayerFrozen(i, false); 
        }
    }
    local ini = EasyINI("AAD/config.ini");
    if(ini.getKey("Config", "Autoswap") == "1") swapTeams();
    local pwn = ini.getKey("Config", "Autobalance");
    if(pwn == "1") balanceTeams(); 
    if(IRC == 1) ircSay(iBot, strEchoChannel, "* The round has been ended.");
    if(Server[0].Automode == "base" || Server[0].Automode == "tdm") Timers[0].AutomodeTimer = timer(StartRandRound, 1000, 31);
}
function StartRandRound() {
	if(LogFunctions == 1) log("StartRandRound");
	AutoModeTimeLeft--;
	if(IsBaseStarted == 1 || IsTDMStarted == 1) Timers[0].AutomodeTimer.kill();
	if(Server[0].Automode == "base") {
		for(local i=0; i <= Server[0].HighestID+1; ++i) if(isPlayerConnected(i)) displayPlayerInfoText(i,"~r~Automode: Base ~w~ Starting in: ~g~" + AutoModeTimeLeft, 1100);
	}	
	else if(Server[0].Automode == "tdm") {
		for(local i=0; i <= Server[0].HighestID+1; ++i) if(isPlayerConnected(i)) displayPlayerInfoText(i,"~r~Automode: TDM ~w~ Starting in: ~g~" + AutoModeTimeLeft, 1100);
	}
	if(AutoModeTimeLeft <= 0 && Server[0].Automode == "base" && IsBaseStarted == 0 && IsTDMStarted == 0) {
		StartRandomBase();
		AutoModeTimeLeft = 30;
	}
	else if(AutoModeTimeLeft <= 0 && Server[0].Automode == "tdm" && IsBaseStarted == 0 && IsTDMStarted == 0) {
		StartRandomTDM();
		AutoModeTimeLeft = 30;
	}
	return 1;
}

function StartRandomBase() {
	if(LogFunctions == 1) log("StartRandomBase");
	if(IsBaseStarted == 1 || IsTDMStarted == 1) return 0;
	local randbase = random(0, getHighestBaseID());
	if(!fexist("AAD/bases/" + randbase + ".ini")) return StartRandomBase();
	StartBase(randbase);
	return 1;
}

function StartRandomTDM() {
	if(LogFunctions == 1) log("StartRandomTDM");
	if(IsBaseStarted == 1 || IsTDMStarted == 1) return 0;
	local randtdm = random(0, getHighestTDMID());
	if(!fexist("AAD/tdm/" + randtdm + ".ini")) return StartRandRound();
	StartTDM(randtdm);
	return 1;
}	
		
function random(min = 0,max = 0xFFFF)
{
	if(LogFunctions == 1) log("random, min: " + min + " max: " + max); 
	return (rand() % ((max + 1) - min)) + min;
}

function endBaseWithWinner() {
	if(LogFunctions == 1) log("endBaseWithWinner");
	//sendMessageToAll("Checking base players.", COLOR_YELLOW, true);
    local ini;
    if(AttackersInRound == 0 && isRoundStarted() == 1 && DefendersInRound >= 1) {
		Timers[0].CPTimer.kill();
		Timers[0].WepTimer.kill();
		Timers[0].RoundTimer.kill();
        sendMessageToAll("Base Ended.", COLOR_YELLOW, true);
        sendMessageToAll2("Defenders have defeated Attackers.", COLOR_YELLOW, true);
        if(IsBaseStarted == 1) ini = EasyINI("AAD/bases/" + Server[0].baseid + ".ini");
        else if(IsTDMStarted == 1) ini = EasyINI("AAD/tdm/" + Server[0].baseid + ".ini");
        local tmp = ini.getKey("Stats", "DefenderWins");
        local tmp2 = tmp.tointeger(); tmp = ++tmp2;
        Server[0].tmpdefwins++;
        ini.setKey("Stats", "DefenderWins", tmp);
        ini.saveData();     
	    for(local i=0; i <= Server[0].HighestID+1; ++i) if(isPlayerConnected(i)) {
	        ini = EasyINI("AAD/Users/" + getPlayerName(i) + ".ini");
	        setPlayerWantedLevel(i, 0);
		    if(pInfo[i].IsDefendingInRound == 1) {
		        local roundwins = ini.getKey("Stats", "RoundWins").tointeger();
		        ini.setKey("Stats", "RoundWins", roundwins.tointeger()+1);
		        ini.saveData();
		    }
		    else if(pInfo[i].IsAttackingInRound == 1) {
		        local roundloss = ini.getKey("Stats", "RoundLosses");
				ini.setKey("Stats", "RoundLosses", roundloss.tointeger()+1);
		        ini.saveData();
		    } 
			pInfo[i].IsAttackingInRound = 0;
		    pInfo[i].IsDefendingInRound = 0;
		    removePlayerWeapons(i);
		    putPlayerAtMainSpawn(i);
		}
    }
    else if(DefendersInRound == 0 && isRoundStarted() == 1 && AttackersInRound >= 1) {
		Timers[0].CPTimer.kill();
		Timers[0].WepTimer.kill();
		Timers[0].RoundTimer.kill();
        sendMessageToAll("Base Ended.", COLOR_YELLOW, true);
        sendMessageToAll2("Attackers have defeated Defenders.", COLOR_YELLOW, true);
        if(IsBaseStarted == 1) ini = EasyINI("AAD/bases/" + Server[0].baseid + ".ini");
        else if(IsTDMStarted == 1) ini = EasyINI("AAD/tdm/" + Server[0].baseid + ".ini");
        local tmp = ini.getKey("Stats", "AttackerWins");
        local tmp2 = tmp.tointeger(); tmp = ++tmp2;
        Server[0].tmpattwins++;
        ini.setKey("Stats", "AttackerWins", tmp);
        ini.saveData(); 
        for(local i=0; i <= Server[0].HighestID+1; ++i) if(isPlayerConnected(i)) {
	        ini = EasyINI("AAD/Users/" + getPlayerName(i) + ".ini");
		    if(pInfo[i].IsAttackingInRound == 1) {
		        local roundwins = ini.getKey("Stats", "RoundWins");
		        ini.setKey("Stats", "RoundWins", roundwins+1);
		        ini.saveData();
		    }
		    else if(pInfo[i].IsDefendingInRound == 1) {
		        local roundloss = ini.getKey("Stats", "RoundLosses");
				ini.setKey("Stats", "RoundLosses", roundloss+1);
		        ini.saveData();
		    }
			pInfo[i].IsAttackingInRound = 0;
		    pInfo[i].IsDefendingInRound = 0;
		    removePlayerWeapons(i);
		    putPlayerAtMainSpawn(i);
		} 
    }
    else if(DefendersInRound == 0 && isRoundStarted() == 1 && AttackersInRound == 0 && Server[0].RoundTime != 0) {
		//its a tie.
		sendMessageToAll("Base Ended.", COLOR_YELLOW, true);
        for(local i=0; i <= Server[0].HighestID+1; ++i) displayPlayerText(i, 0.4, 0.5, "The ~r~round~w~ is a tie.", COLOR_YELLOW, true);
        endBase();
    }
    else { return 1; }    
    ini = EasyINI("AAD/config.ini");
    if(ini.getKey("Config", "Autoswap").tointeger() == 1) swapTeams();
    Server[0].baseid = "Lobby";
    setRule("Round", "Lobby");
    AttackersInRound = 0;
	DefendersInRound = 0;
    IsBaseStarted = 0;
    IsTDMStarted = 0;
    deleteBlip(CPBlip);
    deleteObject(cpobjectid);
    cpobjectid = -1;
    CPBlip = -1;
    endBase();
    return 1;
}

function makeKeyIfDoesntExist(file, section, key, value = 0) {
	if(LogFunctions == 1) log("makeKeyIfDoesntExist " + key);
    //local ini = EasyINI(file);
    if(!file.keyExists(section, key)) {
        file.setKey(section, key, value);
        file.saveData();
    }
}    

function autoLogin(playerid) { //the playerid of whom is enabling or disabling the auto login feature.
	if(LogFunctions == 1) log("autoLogin " + getPlayerName(playerid));
    local file = "AAD/config.ini";
    local ini = EasyINI(file);
    local key = "Autologin";
    local section = "Config";
    makeKeyIfDoesntExist(file, section, key);
    local Autologin2 = ini.getKey(section, key).tointeger();
    if(Autologin2 == 1) {
        sendPlayerMessage(playerid, "Autologin has been successfully, disabled.", COLOR_GREEN);
        sendMessageToAll(getPlayerName(playerid) + " has disabled auto-login.", COLOR_YELLOW, true);
        ini.setKey(section, key, 0);
        ini.saveData();
        return 1;
    }
    if(Autologin2 == 0) {
        sendPlayerMessage(playerid, "Autologin has been successfully, enabled.", COLOR_GREEN);
        sendMessageToAll(getPlayerName(playerid) + " has enabled auto-login.", COLOR_YELLOW, true);
        ini.setKey(section, key, 1);
        ini.saveData();
        return 1;
    }
    return 1;
}

function setClanTag(playerid, clantag) {
	if(LogFunctions == 1) log("setClanTag " + clantag);
    local file = "AAD/config.ini";
    local key = "Clantag";
    local section = "Config";
    local ini = EasyINI(file);
    makeKeyIfDoesntExist(ini, section, key);
    ini.setKey(section, key, clantag);
    ini.saveData();
    sendPlayerMessage(playerid, "Clan tag has been changed to: " + clantag, COLOR_GREEN);
    sendMessageToAll(getPlayerName(playerid) + " has changed the server's clantag to [" + clantag + "]", COLOR_YELLOW, true); 
}

function addPlayerToRound(targetid) {
	if(LogFunctions == 1) log("addPlayerToRound " + getPlayerName(targetid));
	local ini = EasyINI("AAD/bases/" + Server[0].baseid + ".ini");
	if(pInfo[targetid].team == 1) { //Attackers
	    setPlayerCoordinates(targetid,  ini.getKey("Attackers", "x").tofloat(),
        ini.getKey("Attackers", "y").tofloat(),
        ini.getKey("Attackers", "z").tofloat());
        AttackersInRound++;
        pInfo[targetid].IsAttackingInRound = 1;
        pInfo[targetid].CanPickWeps = 1;
    }
    else if(pInfo[targetid].team == 2) { //Defenders
       setPlayerCoordinates(targetid,  ini.getKey("Defenders", "x").tofloat(),
       ini.getKey("Defenders", "y").tofloat(),
       ini.getKey("Defenders", "z").tofloat());
       DefendersInRound++;
       pInfo[targetid].IsDefendingInRound = 1;
       pInfo[targetid].CanPickWeps = 1;
    }
}

function GiveWeps(playerid, setlistid) {
	if(LogFunctions == 1) log("GiveWeps " + getPlayerName(playerid) + " setlist: " + setlistid);
	setlistid--;
	local ini = EasyINI("AAD/wepconfig.ini");
	//split(command.tolower(), " "); 
	local tmp = ini.getKey("Gunmenu", setlistid.tostring());
	local setlist = split(tmp, " ");
	setlistid++;
	if(setlist.len() == 1) { 
		givePlayerWeapon(playerid, setlist[0].tointeger(), 9999); 
		sendPlayerMessage(playerid, "you've picked weapon set, " + setlistid.tointeger() + " containing " + WeaponNames[setlist[0].tointeger()], COLOR_GREEN); 
		onPlayerText(playerid, "!I've picked Weapon setlist: " + setlistid.tointeger() + " Containing: " + WeaponNames[setlist[0].tointeger()]);
	}
	else if(setlist.len() == 2) { 
		givePlayerWeapon(playerid, setlist[0].tointeger(), 9999); 
		givePlayerWeapon(playerid, setlist[1].tointeger(), 9999); 
		sendPlayerMessage(playerid, "you've picked weapon set, " + setlistid.tointeger() + " containing " + WeaponNames[setlist[0].tointeger()] + " + " + WeaponNames[setlist[1].tointeger()], COLOR_GREEN); 
		onPlayerText(playerid, "!I've picked Weapon setlist: " + setlistid.tointeger() + " Containing " + WeaponNames[setlist[0].tointeger()] + " + " + WeaponNames[setlist[1].tointeger()]);
	}
	else if(setlist.len() == 3) { 
		givePlayerWeapon(playerid, setlist[0].tointeger(), 9999); 
		givePlayerWeapon(playerid, setlist[1].tointeger(), 9999); 
		givePlayerWeapon(playerid, setlist[2].tointeger(), 9999); 
		sendPlayerMessage(playerid, "you've picked weapon set, " + setlistid.tointeger() + " containing " + WeaponNames[setlist[0].tointeger()] + " + " + WeaponNames[setlist[1].tointeger()] + " + " + WeaponNames[setlist[2].tointeger()], COLOR_GREEN); 
		onPlayerText(playerid, "!I've picked Weapon setlist: " + setlistid.tointeger() + " Containing " + WeaponNames[setlist[0].tointeger()] + " + " + WeaponNames[setlist[1].tointeger()] + " + " + WeaponNames[setlist[2].tointeger()]);
	}
	else return 1; // error occured, unknown why.
	pInfo[playerid].CanPickWeps = 0;
	togglePlayerFrozen(playerid, false);
}		

function getTeamLockStatus(teamid) {
	if(LogFunctions == 1) log("getTeamLockStatus " + teamid);
	if(teamid == 1) {
		if(Server[0].AttackersLock == 1) return 1;
		else return 0;
	}
	else if(teamid == 2) {
		if(Server[0].DefendersLock == 1) return 1;
		else return 0;
	}
	else return null;
}		

function setTeamName(playerid, teamid, name) {
	if(LogFunctions == 1) log("setTeamName Teamid: " + teamid + " Name: " + name);
    local file = "AAD/config.ini";
    local section = "Config";
    local ini = EasyINI(file);
    if(teamid.tointeger() == 1) {
        local key = "Attackers";
        ini.setKey(section, key, name);
        ini.saveData();
        if(playerid != null) sendMessageToAll(getPlayerName(playerid) + " changed the 'Attackers' team name to: " + name, COLOR_YELLOW, true);
    } else if(teamid.tointeger() == 2) {
        local key = "Defenders";
        ini.setKey(section, key, name);
        ini.saveData();
        if(playerid != null) sendMessageToAll(getPlayerName(playerid) + " changed the 'Defender' team name to: " + name, COLOR_YELLOW, true);
    }
    return 1;
}

function clearVehicles() {
	if(LogFunctions == 1) log("clearVehicles");
    for(local i=0; i < 500; ++i) deleteVehicle(i);    
    return 1;
 }
 
 function Banned(playerid) {
	if(LogFunctions == 1) log("Banned " + getPlayerName(playerid));
    local ini = EasyINI("AAD/config.ini");
    local website = ini.getKey("Config", "Website");
    sendPlayerMessage(playerid, "Do not return to the server, as you are banned from it.", COLOR_YELLOW, true);
    sendPlayerMessage(playerid, "If you would like to continue playing here you must appeal your ban, it might not be you the admins are intending to ban.", COLOR_YELLOW, true);
    sendPlayerMessage(playerid, "but you have logged into a banned account, and will therfore, be banned.", COLOR_YELLOW, true);
    sendPlayerMessage(playerid, "To appeal your ban goto " + website + " and create a new topic concerning your appeal.", COLOR_YELLOW, true);
    return 1;
 }
 
 function isPlayerInRound(playerid) {
	if(LogFunctions == 1) log("isPlayerInRound " + getPlayerName(playerid));
    if(pInfo[playerid].IsAttackingInRound == 1 || pInfo[playerid].IsDefendingInRound == 1) return 1;
    else if(pInfo[playerid].IsAttackingInRound != 1 && pInfo[playerid].IsDefendingInRound != 1) return 0;
    else return 0;
 }
 
 function GoTo(playerid, targetid) {
	if(LogFunctions == 1) log("GoTo");
    local pos = getPlayerCoordinates(targetid);
    setPlayerCoordinates(playerid, pos[0], pos[1], pos[2]);
    sendPlayerMessage(playerid, "Teleported to " + getPlayerName(targetid), COLOR_YELLOW, true);
    sendPlayerMessage(targetid, getPlayerName(playerid) + " Has teleported to you!", COLOR_YELLOW, true);
    return 1;
 }
 
 function setTeam(playerid, teamid) {
	if(LogFunctions == 1) log("setTeam " + getPlayerName(playerid) + " Target Team: " + teamid);
	calculatePlayersOnTeams();
    pInfo[playerid].team = teamid;
    local ini = EasyINI("AAD/config.ini");
    if(teamid == 1) {
        local team = ini.getKey("Config", "Attackers");
        //sendMessageToAll(getPlayerName(playerid) + " Has switched to the team: " + team + " (Attackers)", COLOR_YELLOW, true);
        Attackers++;
        //setPlayerColor(playerid, ini.getKey("Config", "AttackerColor").tointeger());
    }
    else if(teamid == 2) {
        local team = ini.getKey("Config", "Defenders");
        //sendMessageToAll(getPlayerName(playerid) + " Has switched to the team: " + team + " (Defenders)", COLOR_YELLOW, true);
        Defenders++;
        //setPlayerColor(playerid, ini.getKey("Config", "DefenderColor").tointeger());
    }
    useProperSkin(playerid);
    return 1;
 }
 
 function removePlayerFromRound(playerid) {
	if(LogFunctions == 1) log("removePlayerFromRound " + getPlayerName(playerid));
	if(pInfo[playerid].IsDefendingInRound == 1) DefendersInRound--;
    if(pInfo[playerid].IsAttackingInRound == 1) AttackersInRound--;
    pInfo[playerid].IsDefendingInRound = 0;
    pInfo[playerid].IsAttackingInRound = 0;
    putPlayerAtMainSpawn(playerid);
    togglePlayerFrozen(playerid, false);
    sendMessageToAll(getPlayerName(playerid) + " has been removed from the round!", COLOR_YELLOW, true);
    //endBaseWithWinner();
}       
 
 function lobbyWeps(playerid) {
	if(LogFunctions == 1) log("lobbyWeps " + getPlayerName(playerid));
     local file = "AAD/wepconfig.ini";
     local ini = EasyINI(file);
     local section = "Weapons";
     local key = "Enabled";
     makeKeyIfDoesntExist(file, section, key);
     local tmp = ini.getKey(section key);
     if(tmp.tointeger() == 1) {
         ini.setKey(section, key, 0);
         ini.saveData();
         sendMessageToAll(getPlayerName(playerid) + " Has disabled lobby weapons", COLOR_YELLOW, true);
     }   
     else if(tmp.tointeger() == 0) {
         ini.setKey(section, key, 1);
         ini.saveData();
         sendMessageToAll(getPlayerName(playerid) + " Has enabled lobby weapons", COLOR_YELLOW, true);
     }
     return 1;
}

function swapTeams() {
	if(LogFunctions == 1) log("swapTeams");
    local ini = EasyINI("AAD/config.ini");
    local defname = ini.getKey("Config", "Defenders");
    local attname = ini.getKey("Config", "Attackers");
    setTeamName(null, 1, defname);
    setTeamName(null, 2, attname);
	for(local i=0; i <= Server[0].HighestID+1; ++i) if(isPlayerConnected(i)) {
		if(pInfo[i].team == 1) {
			setTeam(i, 2);
			Attackers--;
		}	
        else if(pInfo[i].team == 2) {
			setTeam(i, 1);
			Defenders--;
		}	
    }
    return 1;
}

function balanceTeams() {
	if(LogFunctions == 1) log("balanceTeams");
    local ini = EasyINI("AAD/config.ini");
    if(IRC == 1) ircSay(iBot, strEchoChannel, "The teams have been balanced."); 
	for(local i=0; i <= Server[0].HighestID+1; ++i) if(isPlayerConnected(i)) {
		if(pInfo[i].team == 1) Attackers--; 
        if(pInfo[i].team == 2) Defenders--;
        pInfo[i].team = 0;
        autoAsignPlayer(i);   
		useProperSkin(i);       
    }          
    return 1;
}

function createPlayerVariables(playerid) {
	Duel[playerid] <- {};
    pInfo[playerid] <- {};
    Duel[playerid].inviter <- 0;                                             //The variable where it tells the server weather this guy has invited someone to a duel or not
    Duel[playerid].invitedby <- 0;                                           //The variable where the inviter to the duel is kept.
    Duel[playerid].inDuel <- 0;                                              //The variable that tells the server if you are in a duel.
    Duel[playerid].invitee <- 0;                                             //invitee is the player that has been invited by the inviter.
    Duel[playerid].duelinvited <- 0;                                         //Have we invited a player?
    Duel[playerid].wep1 <- 0;                                                //wep 1 in the duel
    Duel[playerid].wep2 <- 0;                                                //wep 2 in the duel
    Duel[playerid].wep3 <- 0;                                                //wep 3 in the duel
    Duel[playerid].wep4 <- 0;                                                //wep 4 in the duel
    Duel[playerid].wep5 <- 0;                                                //wep 5 in the duel
    
    pInfo[playerid].team <- 0;                                               //The player's team.
    pInfo[playerid].LoggedIn <- 0;                                           //Is the player logged in
    pInfo[playerid].Mute <- 0;                                               //Is the player muted?
    pInfo[playerid].Admin <- 0;                                              //Admin level of the player
    pInfo[playerid].IsDefendingInRound <- 0;                                 //where they defending && where they in a round?
    pInfo[playerid].IsAttackingInRound <- 0;                                 // ^^ but for Attackers.
    pInfo[playerid].roundidcreated <- -1;                                    //base id last created, saved so players can edit bases.
    pInfo[playerid].lastcarspawned <- -1;                                    //The last car the player spawned.
    pInfo[playerid].lastmodecreated <- -1;                                   //Has the player last created a TDM or a base
    pInfo[playerid].InCP <- 0;                                               //Is the player in the CP & are they Attackers?
    pInfo[playerid].Jailed <- 0;                                             //Is the player jailed?
    pInfo[playerid].AFK <- 0;                                                //Is the player AFK
    pInfo[playerid].CanPickWeps <- 0;                                        //Can the player pick weapons from the wep menu?
    pInfo[playerid].OriginalName <- getPlayerName(playerid);                 //The player's name
    pInfo[playerid].PingWarn <- 0;                                           //has the player been warned about his high ping?
    pInfo[playerid].Voted <- -1;                                             //base/tdm player has voted for?
    pInfo[playerid].VotedMode <- "base";                                     //The mode the player has voted for: "base", "tdm
    return 1;
}    

function disableLobbyWeapon(targetwepid) {
	if(LogFunctions == 1) log("disableLobbyWeapon " + targetwepid);
    local ini = EasyINI("AAD/wepconfig.ini");
    if(!isNumeric(targetwepid)) {
        local tmp = getWeaponIDFromName(targetwepid);
        targetwepid = tmp.tointeger();
    }
    else if(isNumeric(targetwepid)) { local tmp = targetwepid.tointeger(); targetwepid = tmp; }
    local Currentstate = ini.getKey("Weapons", targetwepid.tostring());
    local tmp2 = Currentstate.tointeger(); Currentstate = tmp2;
    local tmp3 = targetwepid.tostring(); targetwepid = tmp3;
    if(Currentstate == 1) {
        ini.setKey("Weapons", targetwepid, 0);
        sendMessageToAll("Weapon " + WeaponNames[targetwepid.tointeger()] + " has been disabled.", COLOR_YELLOW, true);
    }    
    else if(Currentstate == 0) {
        ini.setKey("Weapons", targetwepid, 1);
        sendMessageToAll("Weapon " + WeaponNames[targetwepid.tointeger()] + " has been enabled.", COLOR_YELLOW, true);
    }
    ini.saveData();    
}   
 
function isValidWep(weaponid) {
	if(LogFunctions == 1) log("isValidWep " + weaponid);
	if(weaponid >= 0 && weaponid < 19 && weaponid != 8) return 1;
	else return 0;
}  

function givePlayerSpawnWeps(playerid) {
	if(LogFunctions == 1) log("givePlayerSpawnWeps " + getPlayerName(playerid));
    if(pInfo[playerid].LoggedIn == 1) {
        local userfile = EasyINI("AAD/Users/" + getPlayerName(playerid) + ".ini");
        local ini = EasyINI("AAD/wepconfig.ini");
        local tmp = ini.getKey("Weapons", "Enabled").tointeger();
        if(tmp == 0) return 1;
        for(local i=0; i <= WeaponNames.len(); ++i) {
			if(!isValidWep(i)) continue;
		    makeKeyIfDoesntExist(ini, "WeaponInfo", i.tostring());
            local tmp = userfile.getKey("WeaponInfo", i.tostring());
            if(tmp == "1") givePlayerWeapon(playerid, i, 9999);
        }
    }
    return 1;
}

function autoAsignPlayer(playerid) {
	if(LogFunctions == 1) log("autoAsignPlayer " + getPlayerName(playerid));
    local ini = EasyINI("AAD/config.ini");
    if(pInfo[playerid].team == 1) Attackers--;
    if(pInfo[playerid].team == 2) Defenders--;
    if(getTeamLockStatus(pInfo[playerid].team) == 1) {
		//if they where previously on the locked team, they should stay on it during a respawn or afk.
		if(pInfo[playerid].team == 1) { //Attackers
			sendMessageToAll(getPlayerName(playerid) + " Has spawned as a '" + ini.getKey("Config", "Attackers") + "' (Attacker)", COLOR_YELLOW, true);
			makeKeyIfDoesntExist(ini, "Skins", "DefendersSkin");
			local skin = ini.getKey("Skins", "DefendersSkin").tointeger();
			setPlayerModel(playerid, skin);
		}
		else if(pInfo[playerid].team == 2) {
			makeKeyIfDoesntExist(ini, "Config", "Defenders");
			sendMessageToAll(getPlayerName(playerid) + " Has spawned as a '" + ini.getKey("Config", "Defenders") + "' (Defender)", COLOR_YELLOW, true);
			makeKeyIfDoesntExist(ini, "Skins", "DefendersSkin");
			local skin = ini.getKey("Skins", "DefendersSkin").tointeger();
			setPlayerModel(playerid, skin);	
		}	
	}			
    else if(Server[0].DefendersLock == 1 && Server[0].AttackersLock != 1) {
		pInfo[playerid].team <- 1;
		sendMessageToAll(getPlayerName(playerid) + " Has spawned as a '" + ini.getKey("Config", "Attackers") + "' (Attacker)", COLOR_YELLOW, true);
		makeKeyIfDoesntExist(ini, "Skins", "DefendersSkin");
		local skin = ini.getKey("Skins", "DefendersSkin").tointeger();
		setPlayerModel(playerid, skin);
	}
	else if(Server[0].AttackersLock == 1 && Server[0].DefendersLock != 1) {
		pInfo[playerid].team <- 2;
		makeKeyIfDoesntExist(ini, "Config", "Defenders");
		sendMessageToAll(getPlayerName(playerid) + " Has spawned as a '" + ini.getKey("Config", "Defenders") + "' (Defender)", COLOR_YELLOW, true);
		makeKeyIfDoesntExist(ini, "Skins", "DefendersSkin");
		local skin = ini.getKey("Skins", "DefendersSkin").tointeger();
		setPlayerModel(playerid, skin);
	}	
	else if(Attackers <= Defenders) {
        pInfo[playerid].team <- 1; //Attackers
        local Attackersname = ini.getKey("Config", "Attackers");
        sendMessageToAll(getPlayerName(playerid) + " Has spawned as a '" + Attackersname + "' (Attacker)", COLOR_YELLOW, true);
        makeKeyIfDoesntExist(ini, "Skins", "AttackersSkin");
        local skin = ini.getKey("Skins", "AttackersSkin").tointeger();
        setPlayerModel(playerid, skin);   
    } 
    else if(Attackers > Defenders) {
        pInfo[playerid].team <- 2; //Defenders
        sendMessageToAll(getPlayerName(playerid) + " Has spawned as a '" + ini.getKey("Config", "Defenders") + "' (Defender)", COLOR_YELLOW, true);
        makeKeyIfDoesntExist(ini, "Skins", "DefendersSkin");
        local skin = ini.getKey("Skins", "DefendersSkin").tointeger();
        setPlayerModel(playerid, skin);  
    }	
    else { return autoAsignPlayer(playerid); /*try again*/ }
    setTeam(playerid, pInfo[playerid].team);
    useProperSkin(playerid);
    if(isPlayerInRound(playerid) == 0) givePlayerSpawnWeps(playerid); 
    else if(isPlayerInRound(playerid) == 1) onScriptError(getPlayerName(playerid) + " was asigned to a team while in a base");
    return 1;
}   

function isRoundStarted() {
	if(LogFunctions == 1) log("isRoundStarted");
    if(IsBaseStarted == 1 || IsTDMStarted == 1) return 1;
    else if(IsBaseStarted != 1 && IsTDMStarted != 1) return 0;
    return 0;
}

function sendMessageToAll2(string, color=COLOR_WHITE, textformatting=true) {
	if(LogFunctions == 1) log("sendMessageToAll2 " + string);
    if(IRC == 1) ircSay(iBot, strEchoChannel, string);
    sendMessageToAll(string, color, textformatting);
    return 1;
}    

function toggleSkinsEnabled(playerid) {
	if(LogFunctions == 1) log("toggleSkinsEnabled " + getPlayerName(playerid));
    local file = "AAD/config.ini";
    local section = "Config";
    local key = "Skins";
    makeKeyIfDoesntExist(file, section, key);
	local ini = EasyINI(file);
    local tmp = ini.getKey(section, key).tointeger();
    if(tmp == 1) {
        ini.setKey("Config", "Skins", 0);
        ini.saveData();
        sendPlayerMessage(playerid, "You've disabled skin changing.", COLOR_YELLOW, true);
    }
    if(tmp == 0) {
        ini.setKey("Config", "Skins", 1);
        ini.saveData();
        sendPlayerMessage(playerid, "You've enabled skin changing.", COLOR_YELLOW, true);
    }
    return 1;
}

function isPlayerIRCOwner(botid, channel, user) {
	if(LogFunctions == 1) log("isPlayerIRCOwner " + user);
	if(ircGetUserChannelMode(botid, channel, user) == "~") return 1;
	else return 0;
}

function isPlayerIRCSop(botid, channel, user) {
	if(LogFunctions == 1) log("isPlayerIRCSop " + user);
    if(ircGetUserChannelMode(botid, channel, user) == "~" ||
    ircGetUserChannelMode(botid, channel, user) == "&") return 1;
    else return 0;
}

function isPlayerIRCOp(botid, channel, user) {
	if(LogFunctions == 1) log("isPlayerIRCOp " + user);
    if(ircGetUserChannelMode(botid, channel, user) == "~" || 
    ircGetUserChannelMode(botid, channel, user) == "&" ||
    ircGetUserChannelMode(botid, channel, user) == "@" ) return 1;
    else return 0;
}

function isPlayerIRCHop(botid, channel, user) {
	if(LogFunctions == 1) log("isPlayerIRCHop " + user);
	if(ircGetUserChannelMode(botid, channel, user) == "~" || 
    ircGetUserChannelMode(botid, channel, user) == "&" ||
    ircGetUserChannelMode(botid, channel, user) == "@" ||
    ircGetUserChannelMode(botid, channel, user) == "%") return 1;
    else return 0;
}
function isPlayerIRCVoice(botid, channel, user) {
	if(LogFunctions == 1) log("isPlayerIRCVoice " + user);
	if(ircGetUserChannelMode(botid, channel, user) == "~" || 
    ircGetUserChannelMode(botid, channel, user) == "&" ||
    ircGetUserChannelMode(botid, channel, user) == "@" ||
    ircGetUserChannelMode(botid, channel, user) == "%" ||
    ircGetUserChannelMode(botid, channel, user) == "+") return 1;
    else return 0;
}   

function useProperSkin(playerid) {
	if(LogFunctions == 1) log("useProperSkin " + getPlayerName(playerid));
    local ini = EasyINI("AAD/config.ini");
    if(pInfo[playerid].LoggedIn == 0) return 1;
    local skins = ini.getKey("Config", "Skins");
    if(skins == null) return 1;
    ini = EasyINI("AAD/Users/" + getPlayerName(playerid) + ".ini");
    local skintouse = ini.getKey("Skin", "Skin");
    // sendMessageToAll(getPlayerName(playerid) + " wants skin " + skintouse, COLOR_YELLOW, true);
    if(skins.tointeger() == 1 && skintouse != null) setPlayerModel(playerid, skintouse.tointeger());
    return 1;
}

function getPlayerClanTag(playerid) {
	if(LogFunctions == 1) log("getPlayerClanTag " + getPlayerName(playerid));
	local name = getPlayerName(playerid).tolower();
    local tmp = name.find("[");
    local tmp2 = name.find("]");
    if(tmp == null || tmp2 == null) return sendPlayerMessage(playerid, "" + COLOR_RED2 + "Error: " + COLOR_WHITE2 + "No clantag detected", COLOR_RED, true);
	local tag = name.slice(tmp, tmp2+1);
    return tag;
}    

function resetPlayerGuns(playerid) {
	if(LogFunctions == 1) log("resetPlayerGuns " + getPlayerName(playerid));
	removePlayerWeapons(playerid);
	if(pInfo[playerid].LoggedIn != 1) return 1;
	local ini = EasyINI("AAD/Users/" + getPlayerName(playerid) + ".ini");
	for(local i=0; i <= WeaponNames.len(); ++i) {
		if(!isValidWep(i)) continue;
		ini.setKey("WeaponInfo", i.tostring(), "0");
		ini.saveData();
	}
	return 1;
}

function isIRCModuleLoaded() 
{
	try 
	{
		ircRegisterMe();
	}	
	catch(e) 
	{ 
		return 0; 
	}
	return 1;
}

function getTeamColor(teamid) {

	if(teamid == 1) return Server[0].AttackerColor;
	else if(teamid == 2) return Server[0].DefenderColor;
	return -1;
}	

function bool(var) {
	if(var > 1) return true;
	else return false
}	
	

function isValidVehicleColor(color) {
	if(LogFunctions == 1) log("isValidVehicleColor " + color);
	if(!isNumeric(color)) return 0;
	if(color.tointeger() >= 0 && color.tointeger() <= 133) return 1;
	else return 0;
}	

function RoundTimerFunc() {
	if(LogFunctions == 1) log("RoundTimer");
	if(Server[0].Paused == 1) return 1;
	local secs = Server[0].RoundTime % 60;
	local mins = Server[0].RoundTime / 60;
	local dontdisplaytimer = 0;
	if(mins == 2 && secs <= 3 && secs >= 0) for(local i=0; i <= Server[0].HighestID+1; i++) {
		displayPlayerText(i, 0.4, 0.5, "2 ~r~ Minute ~y~ Warning", 3000);
		dontdisplaytimer = 1;
	}
	if(mins == 0 && secs <= 30 && secs >= 27) for(local i=0; i <= Server[0].HighestID+1; i++) {
		displayPlayerText(i, 0.4, 0.5, "30 ~r~ second ~y~ Warning", 1100);
		dontdisplaytimer = 1;
	}
	if(mins == 0 && secs <= 10 && secs >= 0) for(local i=0; i <= Server[0].HighestID+1; i++) {
		if(isPlayerConnected(i)) triggerClientEvent(i, "ToggleTheWindow");
	}		
	for(local i=0; i <= Server[0].HighestID+1; ++i) if(isPlayerConnected(i) && dontdisplaytimer == 0) displayPlayerText(i, 0.9, 0.9, "" + mins + ":" + secs, 1100);
	Server[0].RoundTime--;
	if(mins <= 0 && secs <= 0) endBaseCuzOfTime();
	if(!IsBaseStarted) Timers[0].RoundTimer.kill();
	return 1;
}

function AnyoneInVehicle(vehid) {
	if(LogFunctions == 1) log("AnyoneInVehicle " + vehid);
	for(local i=0; i <= Server[0].HighestID+1; ++i) {
		if(isPlayerConnected(i) && isPlayerInVehicle(i, vehid)) return 1;
	}
	return 0;
}

function calculatePlayersOnTeams() {
	Attackers = 0;
	Defenders = 0;
	for(local i=0; i <= Server[0].HighestID+1; ++i) {
		if(isPlayerConnected(i) && pInfo[i].team == 1) Attackers++;
		else if(isPlayerConnected(i) && pInfo[i].team == 2) Defenders++;
	}
}

function CreateKeys() {
	// When creating the keys we're not going to use makeKeyIfDoesntExist because it would re-open the file multiple times that is not needed.
	
	local ini = EasyINI("AAD/config.ini");
	
	makeKeyIfDoesntExist(ini, "Skins", "DefendersSkin");
	makeKeyIfDoesntExist(ini, "Skins", "AttackersSkin");
	makeKeyIfDoesntExist(ini, "Clanwar", "Enabled");
	makeKeyIfDoesntExist(ini, "Mainspawn", "x");
	makeKeyIfDoesntExist(ini, "Mainspawn", "y");
	makeKeyIfDoesntExist(ini, "Mainspawn", "z");
	makeKeyIfDoesntExist(ini, "Config", "Defenders", "Noobs");
	makeKeyIfDoesntExist(ini, "Config", "Attackers", "Pros");
	makeKeyIfDoesntExist(ini, "Config", "Nicks");
	makeKeyIfDoesntExist(ini, "Config", "Autoaim", 0);
	makeKeyIfDoesntExist(ini, "Config", "CustomSpawns", 1);
	makeKeyIfDoesntExist(ini, "Config", "RoundTimer", 10*60*1000);
	makeKeyIfDoesntExist(ini, "Config", "MaxPing", 500);
	makeKeyIfDoesntExist(ini, "Config", "Ragdoll", 1);
	makeKeyIfDoesntExist(ini, "Config", "Autokick", 0);
	makeKeyIfDoesntExist(ini, "Config", "Autobalance", 1);
	makeKeyIfDoesntExist(ini, "Config", "Weather");
	makeKeyIfDoesntExist(ini, "Config", "Autologin", 1);
	makeKeyIfDoesntExist(ini, "Config", "Website", "http://www.google.com");
	makeKeyIfDoesntExist(ini, "Config", "Autoswap", 1);
	makeKeyIfDoesntExist(ini, "Config", "AttackerColor");
	makeKeyIfDoesntExist(ini, "Config", "DefenderColor");
	makeKeyIfDoesntExist(ini, "Config", "Skins", 0);
	makeKeyIfDoesntExist(ini, "Config", "MinFPS", 0);
	makeKeyIfDoesntExist(ini, "Config", "Clantag", "noclan");
	makeKeyIfDoesntExist(ini, "Config", "HideAdmins", 0);
	makeKeyIfDoesntExist(ini, "Config", "RoundHP", 200);
	makeKeyIfDoesntExist(ini, "Config", "LobbyHP", 200);
	makeKeyIfDoesntExist(ini, "Config", "Automode", -1);
	makeKeyIfDoesntExist(ini, "Checkpoint", "CPTime", 20);
	makeKeyIfDoesntExist(ini, "Checkpoint", "CPSize", 2);
	makeKeyIfDoesntExist(ini, "Clanwar", "Clantag1");
    makeKeyIfDoesntExist(ini, "Clanwar", "Clantag2");
    makeKeyIfDoesntExist(ini, "Time", "Hour", 12);
    makeKeyIfDoesntExist(ini, "Time", "Minute", 0);
	
	
	for(local i=0; i < 5; ++i) {
		makeKeyIfDoesntExist(ini, "Rules", "" + i);
	}
	ini.saveData();
	
	ini = EasyINI("AAD/vehconfig.ini");	
	for(local i=0; i < 126; ++i) {
		makeKeyIfDoesntExist(ini, "Vehicles", "" + i, 1);
	}
	ini.saveData();
	
	ini = EasyINI("AAD/wepconfig.ini");	
	
	for(local i=0; i < 20; ++i) {
		makeKeyIfDoesntExist(ini, "Weapons", "" + i, 1);
		if(i < 5) {
			makeKeyIfDoesntExist(ini, "Gunmenu", "" + i);
		}	
	}
	makeKeyIfDoesntExist(ini, "Weapons", "Enabled");
	
	for(local i=0; i <= MAX_BASES; ++i) {
		if(fexist("AAD/bases/" + i + ".ini")) {
			ini = EasyINI("AAD/bases/" + i + ".ini");
			
			makeKeyIfDoesntExist(ini, "Attackers", "x");
			makeKeyIfDoesntExist(ini, "Attackers", "y");
			makeKeyIfDoesntExist(ini, "Attackers", "z");
			
			makeKeyIfDoesntExist(ini, "Defenders", "x");
			makeKeyIfDoesntExist(ini, "Defenders", "y");
			makeKeyIfDoesntExist(ini, "Defenders", "z");
			
			makeKeyIfDoesntExist(ini, "Checkpoint", "x");
			makeKeyIfDoesntExist(ini, "Checkpoint", "y");
			makeKeyIfDoesntExist(ini, "Checkpoint", "z");
			
			makeKeyIfDoesntExist(ini, "Stats", "AttackerWins");
			makeKeyIfDoesntExist(ini, "Stats", "DefenderWins");
			makeKeyIfDoesntExist(ini, "Stats", "TimesPlayed");
			
			makeKeyIfDoesntExist(ini, "Creator", "Creator");
			
			makeKeyIfDoesntExist(ini, "Description", "Description");
		}
	}
	for(local i=0; i <= MAX_TDM; ++i) {
		if(fexist("AAD/tdm/" + i + ".ini")) {
			ini = EasyINI("AAD/tdm/" + i + ".ini");
			
			makeKeyIfDoesntExist(ini, "Attackers", "x");
			makeKeyIfDoesntExist(ini, "Attackers", "y");
			makeKeyIfDoesntExist(ini, "Attackers", "z");
			
			makeKeyIfDoesntExist(ini, "Defenders", "x");
			makeKeyIfDoesntExist(ini, "Defenders", "y");
			makeKeyIfDoesntExist(ini, "Defenders", "z");
			
			makeKeyIfDoesntExist(ini, "Stats", "AttackerWins");
			makeKeyIfDoesntExist(ini, "Stats", "DefenderWins");
			makeKeyIfDoesntExist(ini, "Stats", "TimesPlayed");
			
			makeKeyIfDoesntExist(ini, "Creator", "Creator");
			
			makeKeyIfDoesntExist(ini, "Description", "Description");
		}
	}
}	
	

function LoadConfig() {
	for(local i=0; i < 126; ++i)
		Server[i] <- {};                         // Holds some /config var options and some other Misc things
    Timers[0] <- {};                             // Some timer information.
    
    //CreateKeys();
    
    local ini = EasyINI("AAD/config.ini");
    
    Server[0].baseid                   <-             "Lobby";                                                 // current roundid
    Server[0].Paused                   <-             0;                                                       // is the round paused?
    Server[0].tmpattwins               <-             0;                                                       // The attacker wins found in /scores
    Server[0].tmpdefwins               <-             0;                                                       // The Defender wins found in /scores
    Server[0].HighestID                <-             0;                                                       // The current servers highest ID - used for looping and internal work only.
    Server[0].Nochat                   <-             0;                                                       // The variable where we know if the server is muted.
    Server[0].AttackersLock            <-             0;                                                       // The variable where we know if the attacker team is locked.
    Server[0].DefendersLock            <-             0;                                                       // The variable where we know if the Defender team is locked.
    Server[0].RoundTime                <-             0;                                                       // The time that is left in the round before it ends.
    Server[0].CPTime                   <-             0;                                                       // the cp time in the current base, NOT the cp time in the cfg file
    
    Server[0].DefendersSkin            <-             ini.getKey("Skins", "DefendersSkin").tointeger();        // The defenders default teamskin.
    Server[0].AttackersSkin            <-             ini.getKey("Skins", "AttackersSkin").tointeger();        // The attackers default teamskin.
    Server[0].Clanwar                  <-             ini.getKey("Clanwar", "Enabled").tointeger();            // Variable where the clanwar mode is kept.
    Server[0].Lobby                    <-             ini.getKey("Mainspawn", "x").tofloat();                  // Lobby spawn X
    Server[1].Lobby                    <-             ini.getKey("Mainspawn", "y").tofloat();                  // Lobby spawn Y
    Server[2].Lobby                    <-             ini.getKey("Mainspawn", "z").tofloat();                  // Lobby spawn Z
    Server[0].DefendersName            <-			  ini.getKey("Config", "Defenders").tostring();            // The defender's name.
    Server[0].AttackersName            <-             ini.getKey("Config", "Attackers").tostring();            // The attackers name
    Server[0].Nicks                    <-             ini.getKey("Config", "Nicks").tointeger();               // is /nick enabled?
    Server[0].Autoaim                  <-             ini.getKey("Config", "Autoaim").tointeger();             // is autoaim allowed?
    Server[0].CustomSpawn              <-             ini.getKey("Config", "CustomSpawns").tointeger();        // is the /spawn command allowed?
    Server[0].ModeTime                 <-             ini.getKey("Config", "Roundtimer").tointeger();          // The mode time set with the /config cmd, Not to be confused with Server[0].Roundtime
    Server[0].MaxPing                  <-             ini.getKey("Config", "MaxPing").tointeger();             // Max ping allowed.
    Server[0].Ragdoll                  <-             ini.getKey("Config", "Ragdoll").tointeger();             // is ragdoll enabled?
    Server[0].ForceLogin               <-             ini.getKey("Config", "Autokick").tointeger();            // are players forced to login?
    Server[0].Autobalance              <-             ini.getKey("Config", "Autobalance").tointeger();         // are the teams forced to auto-balance after every round?
    Server[0].Weather                  <-             ini.getKey("Config", "Weather").tointeger();             // what is the default weather?
    Server[0].Autologin                <-             ini.getKey("Config", "Autologin").tointeger();           // if the IP's match, force an auto-login?
    Server[0].Website                  <-             ini.getKey("Config", "Website").tostring();              // The server's website.
    Server[0].Autoswap                 <-             ini.getKey("Config", "Autoswap").tointeger();            // will the teams auto-swap after each round?
    Server[0].AttackerColor            <-             ini.getKey("Config", "AttackerColor").tointeger();       // the attackers team color.
    Server[0].DefenderColor            <-             ini.getKey("Config", "DefenderColor").tointeger();       // The defenders team color.
    Server[0].Automode                 <-             ini.getKey("Config", "Automode").tointeger();            // is a base/tdm going to start 30 seconds after the last one finished?
    Server[0].Skins                    <-             ini.getKey("Config", "Skins").tointeger();               // is the /skin command enabled?
    Server[0].MinFPS                   <-             ini.getKey("Config", "MinFPS").tointeger();              // the minimum Allowed FPS.
    Server[0].Clantag                  <-             ini.getKey("Config", "Clantag").tostring();              // the server's clantag if any.
    Server[0].HideAdmins               <-             ini.getKey("Config", "HideAdmins").tointeger();          // are the admins hidden from /admins?
    Server[0].RoundHP                  <-             ini.getKey("Config", "RoundHP").tointeger();             // the round HP you will spawn with in rounds.
    Server[0].LobbyHP                  <-             ini.getKey("Config", "LobbyHP").tointeger();             // the HP you get when you spawn outside of a round.
    Server[0].ClanwarTags              <-             ini.getKey("Clanwar", "Clantag1").tostring();            // the clanwar mode clan tag number 1
    Server[1].ClanwarTags              <-             ini.getKey("Clanwar", "Clantag2").tostring();            // the clanwar mode clan tag number 2
    Server[0].defaultCPTime            <-             ini.getKey("Checkpoint", "CPTime").tointeger();          // the time to capture the checkpoint.
    Server[0].CPSize                   <-             ini.getKey("Checkpoint", "CPSize").tointeger();          // The distance from the checkpoint you can cap it from.
    Server[0].Time                     <-             ini.getKey("Time", "Hour").tointeger();                  // The hour time.
    Server[1].Time                     <-             ini.getKey("Time", "Minute").tointeger();                // The minute time.
    Server[0].Autokick                 <-             ini.getKey("Config", "Autokick").tointeger();            // Autokick the player if they've not logged in in time.
    Server[0].CustomSpawns             <-             ini.getKey("Config", "CustomSpawns").tointeger();        // Is custom spawns allowed? (/spawn)
   
    for(local i=0; i < 5; ++i) 
		Server[i].Rules                <-             ini.getKey("Rules", "" + i).tostring();                  // The server rule vars.
		
	ini.saveData();
	ini = EasyINI("AAD/vehconfig.ini");	
	for(local i=0; i < 126; ++i) {
		Server[i].Vehicles             <-	          ini.getKey("Vehicles", "" + i).tointeger();              // All the car information, if it is an allowed /car
	}
	ini.saveData();
	
	ini = EasyINI("AAD/wepconfig.ini");	
	
	for(local i=0; i < 20; ++i) {
		Server[i].Weapons              <-              ini.getKey("Weapons", "" + i).tointeger();              // the weapons allowed in /getgun.
		if(i < 5) {
			Server[i].Gunmenu          <-              ini.getKey("Gunmenu", "" + i).tostring();               // the gunmenu information.
		}	
	}
	Server[0].Getgun                   <-              ini.getKey("Weapons", "Enabled").tointeger();           // is /getgun even enabled?
	ini.saveData();
    
    if(Server[0].MaxPing > 0) Timers[0].PingKick <- timer(PingKick, 10000, -1);
    else Timers[0].PingKick <- null;
    if(Server[0].MinFPS > -1) Timers[0].FpsKick <- timer(FpsKick, 10000, -1);
    else Timers[0].FpsKick <- null;
    Timers[0].WepTimer <- null;
    Timers[0].RoundTimer <- null;
    Timers[0].CPTimer <- null;
    Timers[0].UnpuaseTimer <- null;
    Timers[0].AutomodeTimer <- null;
    Timers[0].UnpauseTimer <- null;
    Timers[0].VoteTimer <- null;
    
    if(Server[0].Automode == "base" || Server[0].Automode == "tdm") Timers[0].AutomodeTimer <- timer(StartRandRound, 1000, -1);	
    //setHostname("[" + ini.getKey("Config", "Clantag") + "]" + " || A/D + TDM");
    
    timer(FriendlyReminder, 600000, -1); //10 minutes
    //now lets set it so the default time is kept
    setDefaultTime();
    toggleAutoAim(bool(Server[0].Autoaim)); //server owners allow autoaiming
    setMinuteDuration(9999999*9999999);
    
    setWeather(Server[0].Weather);
    
    if(isIRCModuleLoaded() == 1) { //check if IRC is enabled
        if(strEchoChannel == null) return 1; //another check to see if its enabled
	    iBot = ircConnect(ircServer, ircPort, botName, botName, botName, false, ""); //connect the bot to the server
	    ircJoinChannel(iBot, strEchoChannel); //join our IRC channel
	    ircRegisterMe(); //allow the IRC bot to get callbacks
	}
	if(ini.keyExists("Config", "Attackerstmp") && ini.keyExists("Config", "Defenderstmp")) { //slight bugfix here if the server was closed when clanwar mode was enabled. ignore this on a regular basis
	    local Attackersname = ini.getKey("Config", "Attackerstmp");
	    local Defendersname = ini.getKey("Config", "Defenderstmp");
	    ini.setKey("Config", "Attackers", Attackersname);
	    ini.setKey("Config", "Defenders", Defendersname);
	    ini.deleteKey("Config", "Attackerstmp");
	    ini.deleteKey("Config", "Defenderstmp");
	    ini.saveData();
	    Server[0].DefendersName = Defendersname;
	    Server[0].AttackersName = Attackersname;
	}
}

function LoadBases() {
	local ini;
	for(local i=0; i <= MAX_BASES; ++i) {
		Bases[i] <- {};
		if(fexist("AAD/bases/" + i + ".ini")) {
			
			ini = EasyINI("AAD/bases/" + i + ".ini");
			
			Bases[i].AttackerX        <-       ini.getKey("Attackers", "x").tofloat();
			Bases[i].AttackerY        <-       ini.getKey("Attackers", "y").tofloat();
			Bases[i].AttackerZ        <-       ini.getKey("Attackers", "z").tofloat();
			
			Bases[i].DefenderX        <-       ini.getKey("Defenders", "x").tofloat();
			Bases[i].DefenderY        <-       ini.getKey("Defenders", "y").tofloat();
			Bases[i].DefenderZ        <-       ini.getKey("Defenders", "z").tofloat();
			
			Bases[i].CheckpointX      <-       ini.getKey("Checkpoint", "x").tofloat();
			Bases[i].CheckpointY      <-       ini.getKey("Checkpoint", "y").tofloat();
			Bases[i].CheckpointZ      <-       ini.getKey("Checkpoint", "z").tofloat();
			
			Bases[i].AttackerWins     <-       ini.getKey("Stats", "AttackerWins").tointeger();
			Bases[i].DefenderWins     <-       ini.getKey("Stats", "DefenderWins").tointeger();
			Bases[i].TimesPlayed      <-       ini.getKey("Stats", "TimesPlayed").tointeger();
			
			Bases[i].Creator          <-       ini.getKey("Creator", "Creator").tostring();
			Bases[i].Description      <-       ini.getKey("Description", "Description").tostring();
			
			Bases[i].Exist            <-       1;
		}
		else Bases[i].Exist           <-       0;
	}
}

function LoadTDMs() {
	local ini;
	for(local i=0; i <= MAX_TDM; ++i) {
		TDMs[i] <- {};
		if(fexist("AAD/tdm/" + i + ".ini")) {
			ini = EasyINI("AAD/tdm/" + i + ".ini");
			
			TDMs[i].AttackerX        <-       ini.getKey("Attackers", "x").tofloat();
			TDMs[i].AttackerY        <-       ini.getKey("Attackers", "y").tofloat();
			TDMs[i].AttackerZ        <-       ini.getKey("Attackers", "z").tofloat();
			
			TDMs[i].DefenderX        <-       ini.getKey("Defenders", "x").tofloat();
			TDMs[i].DefenderY        <-       ini.getKey("Defenders", "y").tofloat();
			TDMs[i].DefenderZ        <-       ini.getKey("Defenders", "z").tofloat();
			
			TDMs[i].AttackerWins     <-       ini.getKey("Stats", "AttackerWins").tointeger();
			TDMs[i].DefenderWins     <-       ini.getKey("Stats", "DefenderWins").tointeger();
			TDMs[i].TimesPlayed      <-       ini.getKey("Stats", "TimesPlayed").tointeger();
			
			TDMs[i].Creator          <-       ini.getKey("Creator", "Creator").tostring();
			TDMs[i].Description      <-       ini.getKey("Description", "Description").tostring();
			
			TDMs[i].Exist            <-       1;
		}
		else TDMs[i].Exist           <-       0;
	}
}

function LoadTeles() {
	local ini;
	for(local i=0; i <= MAX_TELES; ++i) {
		Tele[i] <- {};
		if(fexist("AAD/teles/" + i + ".ini")) {
			
			ini = EasyINI("AAD/teles/" + i + ".ini");
			
			Tele[i].X        <-       ini.getKey("pos", "X").tofloat();
			Tele[i].Y        <-       ini.getKey("pos", "Y").tofloat();
			Tele[i].Z        <-       ini.getKey("pos", "Z").tofloat();
			
			Tele[i].Creator  <-       ini.getKey("Creator", "Creator").tostring();
			
			Tele[i].Exist    <-       1;
		}
		else Tele[i].Exist   <-       0;
	}
}
			 
	

function VoteTimer() {
	local tdm2 = array(MAX_TDM, 0);
	local base2 = array(MAX_BASES, 0);
	for(local i=0; i < Server[0].HighestID+1; ++i) {
		if(isPlayerConnected(i)) {
			if(pInfo[i].Voted > -1) { // player is connected, and has voted with /vote on either a base or a TDM.
				if(pInfo[i].VotedMode == "base") {
					base2[pInfo[i].Voted]++;
					pInfo[i].Voted = -1;
				}
				else if(pInfo[i].VotedMode == "tdm") {
					tdm2[pInfo[i].Voted]++;
					pInfo[i].Voted = -1;
				}
			}
		}
	}
	local mostvotedbase;
	local mostvotedtdm;
	for(local i=0; i < MAX_TDM; ++i) {
		if(tdm2[i] > mostvotedtdm) mostvotedtdm = tdm2[i];
	}
	for(local i=0; i < MAX_BASES; ++i) {
		if(base2[i] > mostvotedbase) mostvotedbase = base2[i];
	}
	if(mostvotedbase >= mostvotedtdm) StartBase(mostvotedbase);
	else if(mostvotedtdm > mostvotedbase) StartTDM(mostvotedtdm);
	return 1;
}
	
	
function showGunMenu(playerid) {
	if(LogFunctions == 1) log("showGunMenu " + getPlayerName(playerid));
	local ini = EasyINI("AAD/wepconfig.ini");
	local menu1 = split(ini.getKey("Gunmenu", "0"), " ");
	if(menu1.len() <= 1) sendPlayerMessage(playerid, "ID 1: " +  WeaponNames[menu1[0].tointeger()], COLOR_YELLOW, true);
	else if(menu1.len() == 2) sendPlayerMessage(playerid, "ID 1: " + WeaponNames[menu1[0].tointeger()] + ", " + WeaponNames[menu1[1].tointeger()], COLOR_YELLOW, true);
	else if(menu1.len() >= 3) sendPlayerMessage(playerid, "ID 1: " +  WeaponNames[menu1[0].tointeger()] + ", " + WeaponNames[menu1[1].tointeger()] + ", " + WeaponNames[menu1[2].tointeger()], COLOR_YELLOW, true);
	local menu2 = split(ini.getKey("Gunmenu", "1"), " ");
	if(menu2.len() <= 1) sendPlayerMessage(playerid, "ID 2: " +  WeaponNames[menu2[0].tointeger()], COLOR_YELLOW, true);
	else if(menu2.len() == 2) sendPlayerMessage(playerid, "ID 2: " + WeaponNames[menu2[0].tointeger()] + ", " + WeaponNames[menu2[1].tointeger()], COLOR_YELLOW, true);
	else if(menu2.len() >= 3) sendPlayerMessage(playerid, "ID 2: " +  WeaponNames[menu2[0].tointeger()] + ", " + WeaponNames[menu2[1].tointeger()] + ", " + WeaponNames[menu2[2].tointeger()], COLOR_YELLOW, true);
	local menu3 = split(ini.getKey("Gunmenu", "2"), " ");
	if(menu3.len() <= 1) sendPlayerMessage(playerid, "ID 3: " + WeaponNames[menu3[0].tointeger()], COLOR_YELLOW, true);
	else if(menu3.len() == 2) sendPlayerMessage(playerid, "ID 3: " + WeaponNames[menu3[0].tointeger()] + ", " + WeaponNames[menu3[1].tointeger()], COLOR_YELLOW, true);
	else if(menu3.len() >= 3) sendPlayerMessage(playerid, "ID 3: " + WeaponNames[menu3[0].tointeger()] + ", " + WeaponNames[menu3[1].tointeger()] + ", " + WeaponNames[menu3[2].tointeger()], COLOR_YELLOW, true);
	local menu4 = split(ini.getKey("Gunmenu", "3"), " ");
	if(menu4.len() <= 1) sendPlayerMessage(playerid, "ID 4: " + WeaponNames[menu4[0].tointeger()], COLOR_YELLOW, true);
	else if(menu4.len() == 2) sendPlayerMessage(playerid, "ID 4: " + WeaponNames[menu4[0].tointeger()] + ", " + WeaponNames[menu4[1].tointeger()], COLOR_YELLOW, true);
	else if(menu4.len() >= 3) sendPlayerMessage(playerid, "ID 4: " + WeaponNames[menu4[0].tointeger()] + ", " + WeaponNames[menu4[1].tointeger()] + ", " + WeaponNames[menu4[2].tointeger()], COLOR_YELLOW, true);
	local menu5 = split(ini.getKey("Gunmenu", "4"), " ");
	if(menu5.len() <= 1) sendPlayerMessage(playerid, "ID 5: " + WeaponNames[menu5[0].tointeger()], COLOR_YELLOW, true);
	else if(menu5.len() == 2) sendPlayerMessage(playerid, "ID 5: " + WeaponNames[menu5[0].tointeger()] + ", " + WeaponNames[menu5[1].tointeger()], COLOR_YELLOW, true);
	else if(menu5.len() >= 3) sendPlayerMessage(playerid, "ID 5: " + WeaponNames[menu5[0].tointeger()] + ", " + WeaponNames[menu5[1].tointeger()] + ", " + WeaponNames[menu5[2].tointeger()], COLOR_YELLOW, true);
	return 1;
}				
				
			
function KickIfNotLogged(playerid) {
	if(LogFunctions == 1) log("KickIfNotLogged(" + getPlayerName(playerid) + ")");
	if(pInfo[playerid].LoggedIn == 1 || !isPlayerConnected(playerid)) return 1;
	else {
		sendMessageToAll2("SYSTEM Has kicked " + getPlayerName(playerid) + " Reason: Did not login in time.", COLOR_YELLOW, true);
		kickPlayer(playerid, true);
	}
}

function FpsKick() {
	if(LogFunctions == 1) log("FpsKick");
	local minfps = Server[0].MinFPS;
	if(minfps == 0) { Timers[0].FpsKick.kill(); return 1; }
	for(local i=0; i < Server[0].HighestID+1; ++i) if(isPlayerConnected(i)) triggerClientEvent(i, "onCheckFPS", minfps);
	return 1;
}

function FPSLow(playerid, fps) {
	log("HI!");
	if(LogFunctions == 1) log ("Kick " + getPlayerName(playerid) + " for low fps -> " + fps);
	sendMessageToAll(getPlayerName(playerid) + " has been kicked for having to low FPS (" + fps + " FPS)", COLOR_YELLOW, true);
	kickPlayer(playerid, true);
	
	return 1;
}
addEvent("onFPSLow", FPSLow);

function onKeyPress(playerid, button, state) {
	sendPlayerMessage(playerid, "Pressed button: " + button + ", state: " + state);
	return 1;
}
addEvent("keyPress", onKeyPress);	
		
	
/* Thanks for giving my script a shot, I worked very hard on this script and I appreciate your interest.

	I'd like to take this time and once agian thank everyone who helped me develop this script. 
	
	
	
88888888888 888                        888               888 
    888     888                        888               888 
    888     888                        888               888 
    888     88888b.   8888b.  88888b.  888  888 .d8888b  888 
    888     888 "88b     "88b 888 "88b 888 .88P 88K      888 
    888     888  888 .d888888 888  888 888888K  "Y8888b. Y8P 
    888     888  888 888  888 888  888 888 "88b      X88  "  
    888     888  888 "Y888888 888  888 888  888  88888P' 888 
    
    
    
 /_  __/ /_  ____ _____  / /_______/ /
  / / / __ \/ __ `/ __ \/ //_/ ___/ / 
 / / / / / / /_/ / / / / ,< (__  )_/  
/_/ /_/ /_/\__,_/_/ /_/_/|_/____(_)


Support:

MSN: whitetigerswt@live.com
Xfire: Whitetigerswt
Email: whitetigerswt@yahoo.com (don't really check it)
Site: www.theclangaming.com
IV:MP forum topic for this script
                                                             
*/                       
                                                             
