package game 
{
	import screens.Welcome;
	import starling.display.Sprite;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author Leonid Trofimchuk
	 */
	public class Game extends Sprite 
	{
		private var screenWelcome:Welcome;
		
		public function Game() 
		{
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			trace("Start Starling");
			
			screenWelcome = new Welcome();
			this.addChild(screenWelcome);
			screenWelcome.initialize();
		}
		
	}

}