package objects 
{
	import components.Assets;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	/**
	 * ...
	 * @author Leonid Trofimchuk
	 */
	public class Bullet extends Sprite
	{
		private var image:Image;
		private var owner:Sprite;
		private var speed:Number = 15;
		
		private var speedX:Number;
		private var speedY:Number;
		
		public function Bullet(owner:Sprite) 
		{
			this.owner = owner;
			this.addEventListener(Event.ADDED_TO_STAGE, addedToStage)
			
		}
		
		private function addedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedToStage);
			iniGraphics();
		}
		
		private function iniGraphics():void 
		{
			this.rotation = owner.rotation;
			this.x = owner.x + owner.width / 2 * Math.cos(this.rotation - Math.PI / 2);
			this.y = owner.y + owner.width / 2 * Math.sin(this.rotation - Math.PI / 2);
			
			speedX = speed * Math.cos(this.rotation - Math.PI / 2);
			speedY = speed * Math.sin(this.rotation - Math.PI / 2);
			
			image = new Image( Assets.getTexture(Assets.BULLET_1) );
			image.x = - image.width >> 1;
			image.y = - image.width >> 1;
			this.addChild(image);
			
			stage.addEventListener(Event.ENTER_FRAME, enterFrame);
		}
		
		private function enterFrame(e:Event):void 
		{
			this.x += speedX;
			this.y += speedY;
		}
		
	}

}