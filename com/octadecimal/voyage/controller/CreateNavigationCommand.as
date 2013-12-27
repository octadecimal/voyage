/*
Simple Command - PureMVC
 */
package com.octadecimal.voyage.controller 
{
	import com.octadecimal.voyage.model.SiteProxy;
	import com.octadecimal.voyage.view.components.LabelView;
	import com.octadecimal.voyage.view.NavigationButtonMediator;
	import com.octadecimal.voyage.view.NavigationMediator;
	import com.octadecimal.voyage.Voyage;
	import flash.display.Sprite;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	import org.puremvc.as3.patterns.observer.Notification;
    
	/**
	 * SimpleCommand
	 */
	public class CreateNavigationCommand extends SimpleCommand 
	{
		private static var BUTTON_SPACING:uint = 20;
		
		override public function execute(note:INotification):void 
		{
			Voyage.debug(this, "Creating navigation...");
			
			// Get site proxy
			var site:SiteProxy = facade.retrieveProxy(SiteProxy.NAME) as SiteProxy;
			
			// Create proxy
			
			// Create mediator
			var view:Sprite = new Sprite();
			var mediator:NavigationMediator = new NavigationMediator(view);
			facade.registerMediator(mediator);
			
			// Navigation buttons
			var name:String, title:String, buttonView:LabelView, lastView:LabelView;
			for (var i:uint = 0, c:uint = site.numSections; i < c; i++)
			{
				// Get section name and title
				name = site.getSectionName(i);
				title = site.getSectionTitleByIndex(i);
				
				// Create view and mediator
				buttonView = new LabelView(title, 18, "Myriad Pro", true, 0xFFFFFF);	
				facade.registerMediator(new NavigationButtonMediator(name, title, buttonView));
				
				// Add button to navigation view
				view.addChild(buttonView);
				
				// Space
				if (lastView) buttonView.x = lastView.x + lastView.width + BUTTON_SPACING;
				
				// Save view for spacing
				lastView = buttonView;
			}
			
			Voyage.debug(this, "Created navigation.");
		}
		
	}
}