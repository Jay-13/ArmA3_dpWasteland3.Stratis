#include "dialog\player_sys.sqf";
if(isNil {player getVariable "cmoney"}) then {player setVariable["cmoney",0,true];};
disableSerialization;

// Check if mutex lock is active.
if(mutexScriptInProgress) exitWith
{
	player globalChat "YOU ARE ALREADY PERFORMING ANOTHER ACTION!";
};

private["_money","_pos","_cash"];
_corpse = nearestobjects [player, ["SoldierWB","SoldierEB","SoldierGB"], 5] select 1;

if (player distance _corpse < 5 && !alive _corpse) then
{
	mutexScriptInProgress = true;
	_currPlayerState = animationState player;
	player playMoveNow "AmovPknlMstpSrasWpstDnon_Gear_AmovPknlMstpSrasWpstDnon";
	sleep 1;

	_ctemp = _corpse getVariable ["cmoney",0];
	_ptemp = player getVariable ["cmoney",0];
	_corpse setVariable["cmoney",0,true];
	player setVariable["cmoney",_ptemp+_ctemp,true];

	mutexScriptInProgress = false;
	player playMoveNow _currPlayerState;
}
else
{
	player globalChat "NO CORPSE TO LOOT!";
	closeDialog 0;
};