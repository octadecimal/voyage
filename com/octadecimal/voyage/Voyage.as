package com.octadecimal.voyage 
{
	import flash.display.Stage;
	import com.octadecimal.voyage.model.*;
	import com.octadecimal.voyage.model.vo.*;
	import com.octadecimal.voyage.view.*;
	import com.octadecimal.voyage.controller.*;
	import org.puremvc.as3.interfaces.IFacade;
	import org.puremvc.as3.patterns.facade.Facade;
	import org.puremvc.as3.utilities.loadup.controller.*;
	
	
	public class Voyage extends Facade implements IFacade 
	{
		// Startup
		public static const STARTUP:String = "startup";
		
		// Debugging
		public static const DEBUG:String = "debug";
		public static const DEBUG_MSG:String = "debugMsg";
		
		// Creation
		public static const CREATE_RESOURCE:String = "createResource";
		public static const CREATE_SECTION:String = "createSection";
		public static const CREATE_NAVIGATION:String = "createNavigation";
		
		// Display list
		public static const ADD_TO_STAGE:String = "addToStage";
		public static const ADD_TO_WORLD:String = "addToWorld";
		public static const ADD_TO_GUI:String 	= "addToGUI";
		public static const REMOVE_FROM_STAGE:String = "removeFromStage";
		public static const REMOVE_FROM_WORLD:String = "removeFromWorld";
		public static const REMOVE_FROM_GUI:String = "removeFromGUI";
		
		// Load states
		public static const RESOURCE_LOADED:String = "resourceLoaded";
		public static const RESOURCE_FAILED:String = "resourceFailed";
		
		// Initiates site preload
		public static const SITE_PRELOAD:String = "sitePreload";
		
		// Site is fully preloaded, ready to be built
		public static const SITE_BUILD:String = "siteBuild";
		
		// Site/stage states
		public static const PATH_CHANGED:String = "pathChanged";
		public static const STAGE_RESIZED:String = "stageResized";
		public static const SITE_PRELOADED:String = "sitePreloaded";
		public static const SECTION_CREATED:String = "sectionCreated";
		public static const SECTION_PRELOADED:String = "sectionPreloaded";
		public static const SECTION_READY:String = "sectionReady";
		
		// Camera
		public static const CAMERA_MOVE:String = "moveCamera";
		public static const CAMERA_MOVE_COMPLETE:String = "moveCameraComplete";
		public static const CAMERA_UPDATE:String = "cameraUpdate";
		
		// Global constants
		public static const RESOURCE_PREFIX:String = "LU_";
		public static const CONTENT_WIDTH:Number = 960;
		public static const CONTENT_HEIGHT:Number = 600;
		
		
		/**
		 * Singleton constructor.
		 */
		public static function getInstance():Voyage 
		{
			if (instance == null) instance = new Voyage();
			return instance as Voyage;
		}
		
		/**
		 * Controller registration.
		 */
		override protected function initializeController():void 
		{
			super.initializeController();
			
			registerCommand( STARTUP, 			StartupCommand				);
			registerCommand( DEBUG, 			DebugCommand 				);
			registerCommand( PATH_CHANGED, 		PathChangedCommand 			);
			
			registerCommand( CREATE_RESOURCE,	CreateResourceCommand		);
			registerCommand( CREATE_SECTION,	CreateSectionCommand		);
			registerCommand( CREATE_NAVIGATION, CreateNavigationCommand		);
			
			registerCommand( RESOURCE_LOADED,	LoadupResourceLoadedCommand );
			registerCommand( RESOURCE_FAILED,	LoadupResourceFailedCommand );
			
			registerCommand( CAMERA_MOVE,		MoveCameraCommand			);
		}
		
		/**
		 * Called by the StageView class, effectively beginning the application.
		 */
		public function startup(stage:Stage):void
		{
			debug(this, "Starting...");
			sendNotification(STARTUP, stage);
			debug(this, "Started.");
		}
		
		/**
		 * Utility debug shortcut.
		 */
		public static function debug(origin:Object, msg:String):void {
			Voyage.getInstance().sendNotification(Voyage.DEBUG, new DebugVO(origin, msg));
		}
	}
	
}