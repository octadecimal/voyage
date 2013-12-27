/*
Simple Command - PureMVC
 */
package com.octadecimal.voyage.controller 
{
	import com.octadecimal.voyage.model.SectionProxy;
	import com.octadecimal.voyage.model.SiteProxy;
	import com.octadecimal.voyage.Voyage;
	import flash.display.Sprite;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	import org.puremvc.as3.patterns.observer.Notification;
    
	/**
	 * SimpleCommand
	 */
	public class CreateSectionCommand extends SimpleCommand 
	{	
		override public function execute(note:INotification):void 
		{
			// Get section id
			var section:String = note.getBody() as String;
			
			// Get site proxy
			var site:SiteProxy = facade.retrieveProxy(SiteProxy.NAME) as SiteProxy;
			
			var proxy:SectionProxy = facade.retrieveProxy(section) as SectionProxy;
			if (!proxy)
			{
				// Debug
				Voyage.debug(this, "Creating section: "+section+"...");
				
				// Get section classes
				var proxyClass:Class = site.getSectionProxy(section);
				var mediatorClass:Class = site.getSectionMediator(section);
				
				// Proxy
				proxy = new proxyClass(section);
				facade.registerProxy(proxy);
				SectionProxy(proxy).path = section;
				
				// Mediator
				var mediator:* = new mediatorClass(section);
				facade.registerMediator(mediator);
			}
			
			// Queue for preload
			sendNotification(Voyage.CREATE_RESOURCE, proxy);
			
			// Save previous section
			site.previousSection = site.activeSection;
			
			// Set new section as active
			site.activeSection = site.path;
			
			// Notify of section creation
			Voyage.debug(this, "Created section: "+section+".");
			sendNotification(Voyage.SECTION_CREATED, section);
		}
		
	}
}