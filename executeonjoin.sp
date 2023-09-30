#include <sourcemod>
 
public Plugin myinfo =
{
	name = "Execute on Join",
	description = "Able to execute commands on player join",
	author = "Gnome / Gnomesenpai",
	version = "1.2",
	url = "http://tf2.gnome.moe"
};

public OnPluginStart()
{
	RegConsoleCmd("joinclass", OnJoinClass, "Joinclass hook", 0);
	return void:0;
}

public Action:OnJoinClass(client, args)
{
	ServerCommand("sm_reloadccc");
	return Action:0;
}