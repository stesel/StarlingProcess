package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import game.Game;
	import natives.Native;
	import net.hires.debug.Stats;
	import screens.InGame;
	import starling.core.Starling;
	
	/**
	 * ...
	 * @author Leonid Trofimchuk
	 */
	[SWF(width = "800", height = "600", backgroundColor = "#000000", frameRate = "60")]
	public class Main extends Sprite 
	{
		private var stats:Stats;
		private var starling:Starling;
		
		public function Main():void 
		{
			// entry point
			this.graphics.lineStyle(2, 0xff0000);
			this.graphics.drawRect(0, 0, 800, 600);
			stats = new Stats();
			stats.x = 2;
			stats.y = 2;
			addChild(stats);
			
			Native.stage = root.stage;
			
			starling = new Starling(InGame, root.stage);
			starling.antiAliasing = 1;
			starling.start();
			
			this.addEventListener(Event.ADDED_TO_STAGE, addedToStage);
		}
		
		private function addedToStage(e:Event = null):void 
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, addedToStage);
			this.stage.addEventListener(MouseEvent.RIGHT_CLICK, onRightClick);
		}
		
		private function onRightClick(e:MouseEvent):void 
		{
			
		}
		
	}
	
}