/*
Simple Command - PureMVC
 */
package com.octadecimal.voyage.controller 
{
	import com.octadecimal.voyage.model.PreloaderProxy;
	import com.octadecimal.voyage.Voyage;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	import org.puremvc.as3.patterns.observer.Notification;
	import org.puremvc.as3.utilities.loadup.interfaces.ILoadupProxy;
	import org.puremvc.as3.utilities.loadup.model.LoadupMonitorProxy;
	import org.puremvc.as3.utilities.loadup.model.LoadupResourceProxy;
    
	/**
	 * SimpleCommand
	 */
	public class CreateResourceCommand extends SimpleCommand 
	{	
		override public function execute(note:INotification):void 
		{
			// Get proxy from note
			var proxy:ILoadupProxy = note.getBody() as ILoadupProxy;
			
			// Get preloader
			var preloader:PreloaderProxy = facade.retrieveProxy(PreloaderProxy.NAME) as PreloaderProxy;
			
			// Create resourse proxy
			var resource:LoadupResourceProxy = new LoadupResourceProxy(Voyage.RESOURCE_PREFIX + proxy.getProxyName(), proxy);
			
			// Register resource proxy
			facade.registerProxy(resource);
			
			// Add resource
			preloader.addResource(resource);
		}
		
	}
}