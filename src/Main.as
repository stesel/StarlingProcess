package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import game.Game;
	import net.hires.debug.Stats;
	import starling.core.Starling;
	
	/**
	 * ...
	 * @author Leonid Trofimchuk
	 */
	[SWF(width = "800", height = "600", backgroundColor = "#000000", frameRate = "30")]
	
	public class Main extends Sprite 
	{
		private var stats:Stats;
		private var starling:Starling;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			// entry point
			
			stats = new Stats();
			addChild(stats);
			
			starling = new Starling(Game, root.stage);
			starling.antiAliasing = 1;
			starling.start();
			
		}
		
	}
	
}