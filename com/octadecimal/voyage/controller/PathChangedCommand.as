/*
Simple Command - PureMVC
 */
package com.octadecimal.voyage.controller 
{
	import com.octadecimal.voyage.model.PreloaderProxy;
	import com.octadecimal.voyage.model.SiteProxy;
	import com.octadecimal.voyage.Voyage;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	import org.puremvc.as3.patterns.observer.Notification;
    
	/**
	 * SimpleCommand
	 */
	public class PathChangedCommand extends SimpleCommand 
	{	
		override public function execute(note:INotification):void 
		{
			var inputPath:String = note.getBody() as String;
			var site:SiteProxy = facade.retrieveProxy(SiteProxy.NAME) as SiteProxy;
			
			// Parse and save path
			site.path = parsePath(inputPath);
			
			// Queue section and preload if initial path received
			if (!site.loaded) 
			{
				Voyage.debug(this, "Initial section: " + site.path);
				
				// Create section
				sendNotification(Voyage.CREATE_SECTION, site.path);
				
				// Preload
				sendNotification(Voyage.SITE_PRELOAD);
			}
			
			// Load section
			else
			{
				Voyage.debug(this, "Changing section: " + site.path);
				
				// Create section
				sendNotification(Voyage.CREATE_SECTION, site.path);
				
				// Preload
				sendNotification(Voyage.SITE_PRELOAD);
			}
		}
		
		/**
		 * Transforms a raw input path into a section name. Turns "/" into "home" and removes any
		 * first prepending "/", but (currently) leaves any proceeding "/" alone.
		 */
		private function parsePath(input:String):String
		{
			if (input == "/") return "home";
			else if (input.charAt(0) == "/") return input.slice(1, input.length);
			else return input;
		}
	}
}