/*
Simple Command - PureMVC
 */
package com.octadecimal.voyage.controller 
{
	import com.octadecimal.voyage.view.StageMediator;
	import com.octadecimal.voyage.Voyage;
	import flash.display.Stage;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	import org.puremvc.as3.patterns.observer.Notification;
    
	/**
	 * SimpleCommand
	 */
	public class CreateStageCommand extends SimpleCommand 
	{	
		override public function execute(note:INotification):void 
		{
			Voyage.debug(this, "Creating stage...");
			
			// Get passed stage reference
			var stage:Stage = note.getBody() as Stage;
			
			// Create stage mediator
			var mediator:StageMediator = new StageMediator(stage);
			facade.registerMediator(mediator);
			
			Voyage.debug(this, "Created stage.");
		}
		
	}
}