var ModVersion:String = "0.02";

import com.GameInterface.Game.Character;
import com.Utils.Archive;
import com.Utils.Faction;


var m_ClientCharacter:Character = Character.GetClientCharacter();

function onLoad()
{
		m_SigIcon = this.attachMovie("Icon", "m_CheckIcon", this.getNextHighestDepth());
}


function OnModuleActivated(config:Archive)
{
	
	//com.GameInterface.UtilsBase.PrintChatText("Sig Loaded");
	
	if (config.FindEntry("POS_X")) 
	{
		m_SigIcon._x = config.FindEntry("POS_X");
		m_SigIcon._y = config.FindEntry("POS_Y");
	} else {
		m_SigIcon._x = 400;
		m_SigIcon._y = 50;
	}
	
	m_SigIcon.onMousePress = function (buttonID) 
	{
		if (Key.isDown(16)) {
			this.startDrag();
		} else if (buttonID == 2) {
			//Right Click Stuff
		} else {
			//Left Click Stuff
			com.GameInterface.UtilsBase.PrintChatText(PrintSig());
		}
		
	}
	
	m_SigIcon.onRelease = m_SigIcon.onReleaseOutside = function()
	{
		this.stopDrag();
	}
	
}


function PrintSig()
{
	
	var PlayerSig:String = "";
	
	var FirstName:String = m_ClientCharacter.GetFirstName();
	
	var NickName:String = m_ClientCharacter.GetName();
	
	var LastName:String = m_ClientCharacter.GetLastName();
	
	var PlayerFaction:String = Faction.GetName(m_ClientCharacter.GetStat( _global.Enums.Stat.e_PlayerFaction ));
	
	switch(PlayerFaction)
	{
		case "TEMPLAR":
			FactionColor = "#ff0000"
			break;
		case "ILLUMINATI":
			FactionColor = "#0000ff"
			break;
		case "DRAGON":
			FactionColor = "#00ff00"
			break;
	}
	
	PlayerSig = "<a href=\"text://" + FirstName + " [color=" + FactionColor + "]" + NickName + "[/color] " + LastName + "\">Signature</a>";
	
	return PlayerSig;
	
	
	
}

function OnModuleDeactivated()
{
	
	var a:Archive = new Archive();
	a.AddEntry("POS_X", m_SigIcon._x);
	a.AddEntry("POS_Y", m_SigIcon._y);
	//this.removeMovieClip(m_SigIcon);
	return a;
}