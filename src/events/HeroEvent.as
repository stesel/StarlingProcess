package events 
{
	import starling.events.Event;
	
	/**
	 * ...
	 * @author Leonid Trofimchuk
	 */
	public class HeroEvent extends Event 
	{
		public static const COLLIDED:String = "HeroEvent.COLLIDED";
		public function HeroEvent(type:String, bubbles:Boolean=false, data:Object=null) 
		{
			super(type, bubbles, data);
		}
		
	}

}