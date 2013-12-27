/*
Simple Command - PureMVC
 */
package com.octadecimal.voyage.controller 
{
	import com.greensock.TweenLite;
	import com.greensock.easing.*;
	import com.octadecimal.voyage.model.CameraProxy;
	import com.octadecimal.voyage.model.vo.PositionVO;
	import com.octadecimal.voyage.Voyage;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	import org.puremvc.as3.patterns.observer.Notification;
    
	/**
	 * SimpleCommand
	 */
	public class MoveCameraCommand extends SimpleCommand 
	{
		private var _cameraPosition:PositionVO;
		
		override public function execute(note:INotification):void 
		{
			// Get target position
			var target:PositionVO = note.getBody() as PositionVO;
			
			// Get camera proxy
			var camera:CameraProxy = facade.retrieveProxy(CameraProxy.NAME) as CameraProxy;
			
			// Get camera position
			_cameraPosition = camera.getData() as PositionVO;
			
			// Tween camera position
			TweenLite.to(_cameraPosition, .75, { 
				worldX: 	target.localX, 
				worldY: 	target.localY, 
				worldZ:		target.localZ, 
				onUpdate: 	onCameraUpdate, 
				onComplete:	onCameraMoveComplete, 
				ease: 		Strong.easeInOut
			});
		}
		
		private function onCameraUpdate():void
		{
			sendNotification(Voyage.CAMERA_UPDATE, _cameraPosition);
		}
		
		private function onCameraMoveComplete():void
		{
			sendNotification(Voyage.CAMERA_MOVE_COMPLETE, _cameraPosition);
			
			_cameraPosition = null;
		}
	}
}