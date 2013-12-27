/*
Simple Command - PureMVC
 */
package com.octadecimal.voyage.controller 
{
	import com.octadecimal.voyage.model.GUIProxy;
	import com.octadecimal.voyage.view.GUIMediator;
	import com.octadecimal.voyage.Voyage;
	import flash.display.Sprite;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	import org.puremvc.as3.patterns.observer.Notification;
    
	/**
	 * SimpleCommand
	 */
	public class CreateGUICommand extends SimpleCommand 
	{	
		override public function execute(note:INotification):void 
		{
			Voyage.debug(this, "Creating gui...");
			
			// Create proxy
			var proxy:GUIProxy = new GUIProxy();
			facade.registerProxy(proxy);
			sendNotification(Voyage.CREATE_RESOURCE, proxy);
			
			// Create mediator
			facade.registerMediator(new GUIMediator(new Sprite()));
			
			// Create navigation
			sendNotification(Voyage.CREATE_NAVIGATION);
			
			Voyage.debug(this, "Created gui.");
		}
		
	}
}