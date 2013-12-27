/*
Simple Command - PureMVC
 */
package com.octadecimal.voyage.controller 
{
	import com.octadecimal.voyage.model.SectionProxy;
	import com.octadecimal.voyage.model.sections.*;
	import com.octadecimal.voyage.model.SiteProxy;
	import com.octadecimal.voyage.model.vo.SectionVO;
	import com.octadecimal.voyage.view.*;
	import com.octadecimal.voyage.view.components.*;
	import com.octadecimal.voyage.view.sections.*;
	import com.octadecimal.voyage.Voyage;
	import flash.display.Sprite;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	import org.puremvc.as3.patterns.observer.Notification;
    
	/**
	 * SimpleCommand
	 */
	public class CreateSiteCommand extends SimpleCommand 
	{	
		override public function execute(note:INotification):void 
		{
			Voyage.debug(this, "Creating site...");
			
			// Create proxy
			var proxy:SiteProxy = new SiteProxy();
			facade.registerProxy(proxy);
			
			// Create mediator
			facade.registerMediator(new SiteMediator(/*new Sprite()*/));
			
			// Register sections
			proxy.registerSection("home", "home", SectionHomeProxy, SectionHomeMediator);
			proxy.registerSection("work", "my work", SectionWorkProxy, SectionWorkMediator);
			proxy.registerSection("resume", "resume", SectionProxy, SectionMediator);
			proxy.registerSection("about", "about me", SectionAboutProxy, SectionAboutMediator);
			proxy.registerSection("contact", "contact", SectionProxy, SectionMediator);
			
			// Add resource
			sendNotification(Voyage.CREATE_RESOURCE, proxy);
			
			Voyage.debug(this, "Created site.");
		}
		
	}
}