/*
Simple Command - PureMVC
 */
package com.octadecimal.voyage.controller 
{
	import com.octadecimal.voyage.model.vo.DebugVO;
	import com.octadecimal.voyage.Voyage;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	import org.puremvc.as3.patterns.observer.Notification;
    
	/**
	 * SimpleCommand
	 */
	public class DebugCommand extends SimpleCommand 
	{	
		private static const INDENT_LENGTH:uint = 36;
		private static const SEPERATOR:String = " ";
		
		override public function execute(note:INotification):void 
		{
			// Get data
			var vo:DebugVO = note.getBody() as DebugVO;
			var output:String = "";
			
			// Append seperators for uniform output margins
			for (var i:uint = vo.origin.length; i < INDENT_LENGTH; i++)
				output += SEPERATOR;
			
			// Remove "[Object" and "]" 
			var formattedOrigin:String = "";
			formattedOrigin += vo.origin.split("[object ")[1];
			formattedOrigin = formattedOrigin.slice(0, formattedOrigin.length-1);
			output += formattedOrigin;
			
			// Append output message
			output += " > " + vo.msg;
			
			// Trace final output
			trace(output);
			
			// Notify
			facade.sendNotification(Voyage.DEBUG_MSG, output);
		}
	}
}