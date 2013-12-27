/*
Macro Command - PureMVC
 */
package com.octadecimal.voyage.controller 
{
	import org.puremvc.as3.patterns.command.MacroCommand;
	
	/**
	 * A MacroCommand
	 */
	public class StartupCommand extends MacroCommand 
	{
		/**
		 * Initialize the MacroCommand by adding its SubCommands.
		 */
		override protected function initializeMacroCommand():void 
		{
			addSubCommand(CreateStageCommand);
			addSubCommand(CreatePreloaderCommand);
			addSubCommand(CreateSiteCommand);
			addSubCommand(CreateWorldCommand);
			addSubCommand(CreateGUICommand);
			addSubCommand(CreateCameraCommand);
		}
		
	}
}
