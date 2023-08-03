#include <sdkhooks>
#include <sdkhooks>

#pragma newdecls required
#pragma semicolon 1

int	   offs_m_bIsSprinting		 = -1;
int	   offs_m_bGaveSprintPenalty = -1;

ConVar cvEnabled;

public Plugin myinfo =
{
	name		= "[NMRiH] Sprinting Stamina Fix",
	author		= "Dysphie",
	description = "Prevents players from avoiding the initial stamina cost of sprinting by holding down the sprint button",
	version		= "1.0.0",
	url			= "https://github.com/dysphie/nmrih-sprinting-stamina-fix"
};

public void OnPluginStart()
{
	cvEnabled = CreateConVar("sm_stamina_glitch_fix", "1", "Enables or disables the plugin. 0 = off, 1 = on");
	cvEnabled.AddChangeHook(OnToggleCvarChanged);

	offs_m_bIsSprinting = FindSendPropInfo("CNMRiH_Player", "m_bIsSprinting");
	if (offs_m_bIsSprinting == -1)
	{
		SetFailState("Failed to find offset for CNMRiH_Player::m_bIsSprinting");
	}

	// Unnamed boolean property that comes right after offs_m_bIsSprinting
	offs_m_bGaveSprintPenalty = offs_m_bIsSprinting + 1;
}

public void OnConfigsExecuted()
{
	UpdateHooks(cvEnabled.BoolValue);
}

void OnToggleCvarChanged(ConVar convar, const char[] oldValue, const char[] newValue)
{
	bool wasEnabled = StringToInt(oldValue) != 0;
	bool isEnabled	= StringToInt(newValue) != 0;

	if (wasEnabled == isEnabled)
	{
		return;
	}

	UpdateHooks(isEnabled);
}

public void OnClientPutInServer(int client)
{
	if (cvEnabled.BoolValue)
	{
		SDKHook(client, SDKHook_PreThink, OnClientPreThink);
	}
}

void OnClientPreThink(int client)
{
	if (GetEntData(client, offs_m_bIsSprinting, 1) == 0)
	{
		SetEntData(client, offs_m_bGaveSprintPenalty, 0);
	}
}

void UpdateHooks(bool enable)
{
	for (int client = 1; client <= MaxClients; client++)
	{
		if (!IsClientInGame(client))
		{
			continue;
		}

		if (enable)
		{
			SDKHook(client, SDKHook_PreThink, OnClientPreThink);
		}
		else
		{
			SDKUnhook(client, SDKHook_PreThink, OnClientPreThink);
		}
	}
}