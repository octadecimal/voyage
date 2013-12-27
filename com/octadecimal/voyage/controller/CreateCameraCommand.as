/*
Simple Command - PureMVC
 */
package com.octadecimal.voyage.controller 
{
	import com.octadecimal.voyage.model.CameraProxy;
	import com.octadecimal.voyage.model.vo.PositionVO;
	import com.octadecimal.voyage.view.CameraMediator;
	import com.octadecimal.voyage.Voyage;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	import org.puremvc.as3.patterns.observer.Notification;
    
	/**
	 * SimpleCommand
	 */
	public class CreateCameraCommand extends SimpleCommand 
	{	
		override public function execute(note:INotification):void 
		{
			Voyage.debug(this, "Creating camera...");
			
			// Create proxy
			facade.registerProxy(new CameraProxy(new PositionVO(0, -600)));
			
			// Create mediator
			facade.registerMediator(new CameraMediator());
			
			Voyage.debug(this, "Created camera.");
		}
		
	}
}