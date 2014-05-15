package objects 
{
	import components.Assets;
	import starling.core.Starling;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.TextureAtlas;
	/**
	 * ...
	 * @author Leonid Trofimchuk
	 */
	public class Explosion extends Sprite
	{
		static public const REMOVE_EXPLOSION:String = "removeExplosion";
		private var art:MovieClip;
		
		public function Explosion() 
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, addedToStage);
		}
		
		private function addedToStage(e:Event = null):void 
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, addedToStage);
			createArt();
		}
		
		private function createArt():void 
		{
			var textureAtlas:TextureAtlas = Assets.getExplosionTextureAtlas();
			art = new MovieClip(textureAtlas.getTextures("Expl"), 40);
			art.scaleX = art.scaleY = 1.3;
			art.x = Math.ceil( -art.width / 2 );
			art.y = Math.ceil( -art.height / 2 );
			art.addEventListener(Event.COMPLETE, artComplete);
			Starling.juggler.add(art);
			this.addChild(art);
		}
		
		private function artComplete(e:Event):void 
		{
			art.removeEventListener(Event.COMPLETE, artComplete);
			if (Starling.juggler.contains(art))
				Starling.juggler.remove(art);
				
			this.removeChild(art);
			onRemove();
		}
		
		private function onRemove(): void
		{
			dispatchEvent(new Event(Explosion.REMOVE_EXPLOSION));
		}
		
	}

}