#include <sourcemod>
 
public Plugin myinfo =
{
	name = "Execute on Join",
	author = "Gnome / Gnomesenpai",
	description = "Able to execute commands on player join",
	version = "2.0",
	url = "https://moevsmachine.tf"
};


public OnPluginStart()
{
    RegConsoleCmd("joinclass", OnJoinClass, "Joinclass hook");         
}

Action OnJoinClass(int client, int args)
{
    if (IsFakeClient(client))
    {
        return Plugin_Continue;
    }

    ServerCommand("sm_reloadccc");
    return Plugin_Continue;
}