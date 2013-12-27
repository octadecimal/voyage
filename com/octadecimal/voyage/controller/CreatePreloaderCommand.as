/*
Simple Command - PureMVC
 */
package com.octadecimal.voyage.controller 
{
	import com.octadecimal.voyage.model.PreloaderProxy;
	import com.octadecimal.voyage.view.components.PreloaderView;
	import com.octadecimal.voyage.view.PreloaderMediator;
	import com.octadecimal.voyage.Voyage;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	import org.puremvc.as3.patterns.observer.Notification;
    
	/**
	 * SimpleCommand
	 */
	public class CreatePreloaderCommand extends SimpleCommand 
	{	
		override public function execute(note:INotification):void 
		{
			Voyage.debug(this, "Creating preloader...");
			
			// Create proxy
			facade.registerProxy(new PreloaderProxy());
			
			// Create mediator
			facade.registerMediator(new PreloaderMediator(new PreloaderView()));
			
			Voyage.debug(this, "Created preloader.");
		}
		
	}
}