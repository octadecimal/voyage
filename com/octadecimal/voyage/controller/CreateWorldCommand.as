/*
Simple Command - PureMVC
 */
package com.octadecimal.voyage.controller 
{
	import com.octadecimal.voyage.model.WorldProxy;
	import com.octadecimal.voyage.view.WorldMediator;
	import com.octadecimal.voyage.Voyage;
	import flash.display.Sprite;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	import org.puremvc.as3.patterns.observer.Notification;
    
	/**
	 * SimpleCommand
	 */
	public class CreateWorldCommand extends SimpleCommand 
	{	
		override public function execute(note:INotification):void 
		{
			Voyage.debug(this, "Creating world...");
			
			// Create proxy
			var proxy:WorldProxy = new WorldProxy();
			facade.registerProxy(proxy);
			sendNotification(Voyage.CREATE_RESOURCE, proxy);
			
			// Create mediator
			var view:Sprite = new Sprite();
			facade.registerMediator(new WorldMediator(view));
			
			Voyage.debug(this, "Created world.");
		}
		
	}
}