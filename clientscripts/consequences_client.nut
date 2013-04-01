function CheckFPS(minfps) {
	if(getFPS().tointeger() <= minfps) { // player has lower than allowed FPS
		triggerServerEvent("Kick", getLocalPlayer(), fps);
	}	
}
addEvent("CheckFPS",CheckFPS);

function toggleTheWindow() {
	if(IsChatWindowVisible()) toggleChatWindow(false);
	else toggleChatWindow(true);
}
addEvent("ToggleTheWindow", toggleTheWindow);