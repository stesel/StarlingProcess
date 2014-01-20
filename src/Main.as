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
			// entry point
			this.graphics.lineStyle(2, 0xff0000);
			this.graphics.drawRect(0, 0, 800, 600);
			stats = new Stats();
			addChild(stats);
			
			starling = new Starling(Game, root.stage);
			starling.antiAliasing = 1;
			starling.start();
			
		}
		
	}
	
}