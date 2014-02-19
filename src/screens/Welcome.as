package screens 
{
	import com.greensock.TweenLite;
	import components.Assets;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	
	/**
	 * ...
	 * @author Leonid Trofimchuk
	 */
	public class Welcome extends Sprite 
	{
		private var bg:Image;
		private var title:Image;
		private var hero:Image;
		
		private var playBtn:Button;
		private var aboutBtn:Button;
		
		public function Welcome() 
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, addedToStage)
		}
		
		private function addedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedToStage);
			
			trace("Welcome screen init");
			drawScreen();
		}
		
		private function drawScreen():void 
		{
			bg = new Image(Assets.getTexture(Assets.BG_WELCOME));
			this.addChild(bg);
			
			title = new Image(Assets.getTexture(Assets.WELCOME_TITLE));
			title.x = 440;
			title.y = 20;
			this.addChild(title);
			
			hero = new Image(Assets.getTexture(Assets.WELCOME_HERO));
			hero.x = - hero.width;
			hero.y = 100;
			this.addChild(hero);
			
			//bg = new Image(Assets.getTexture(Assets.BG_WELCOME));
			//this.addChild(bg);
			//
			//bg = new Image(Assets.getTexture(Assets.BG_WELCOME));
			//this.addChild(bg);
			
			playBtn = new Button(Assets.getTexture(Assets.WELCOME_PLAY_BTN));
			playBtn.x = 500;
			playBtn.y = 260;
			this.addChild(playBtn);
			//playBtn.
			
			//aboutBtn = new Button(Assets.getTexture(Assets.WELCOME_ABOUT_BTN));
			//aboutBtn.x = 410;
			//aboutBtn.y = 380;
			//this.addChild(aboutBtn);
		}
		
		public function initialize():void
		{
			this.visible = true;
			
			hero.x = - hero.width;
			hero.y = 100;
			
			TweenLite.to(hero, 2, { x: 80 } );
			
			this.addEventListener(Event.ENTER_FRAME, heroAnimation);
		}
		
		private function heroAnimation(e:Event):void 
		{
			var currentDate:Date = new Date();
			hero.y = 100 + (Math.cos(currentDate.getTime() * 0.002) * 25);
			
			playBtn.y = 260 + (Math.cos(currentDate.getTime() * 0.002) * 10);
			//aboutBtn.y = 380 + (Math.cos(currentDate.getTime() * 0.002) * 10);
			
		}
		
		private function onPlayTouch(e:TouchEvent):void 
		{
			disploseWelcome();
		}
		
		private function disploseWelcome():void 
		{
			this.visible = false;
		}
		
	}

}