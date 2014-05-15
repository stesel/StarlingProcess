package components 
{
	import flash.display.Bitmap;
	import flash.utils.Dictionary;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	/**
	 * ...
	 * @author Leonid Trofimchuk
	 */
	public class Assets 
	{
		
		public static const BG_WELCOME			:String = "BgWelcome";
		public static const WELCOME_HERO		:String = "WelcomeHero";
		public static const WELCOME_TITLE		:String = "WelcomeTitle";
		public static const WELCOME_PLAY_BTN	:String = "WelcomePlayBtn";
		public static const WELCOME_ABOUT_BTN	:String = "WelcomeAboutBtn";
		static public const BULLET_1			:String = "Bullet1";
		
		
		[Embed(source = "../../media/graphics/bgWelcome.jpg")]
		public static const BgWelcome:Class;
		
		[Embed(source = "../../media/graphics/welcome_hero.png")]
		public static const WelcomeHero:Class;
		
		[Embed(source = "../../media/graphics/welcome_title.png")]
		public static const WelcomeTitle:Class;
		
		[Embed(source = "../../media/graphics/welcome_playButton.png")]
		public static const WelcomePlayBtn:Class;
		
		[Embed(source = "../../media/graphics/welcome_aboutButton.png")]
		public static const WelcomeAboutBtn:Class;
		
		[Embed(source = "../../media/graphics/Bullet1.png")]
		public static const Bullet1:Class;
		
		[Embed(source = "../../media/graphics/HeroGraphicSheet.png")]
		public static const AtlasTextureHero:Class;
		
		[Embed(source = "../../media/graphics/HeroGraphicSheet.xml", mimeType = "application/octet-stream")]
		public static const AtlasXMLHero:Class;
		
		[Embed(source = "../../media/graphics/sightGraphicSheet.png")]
		public static const AtlasSightHero:Class;
		
		[Embed(source = "../../media/graphics/sightGraphicSheet.xml", mimeType = "application/octet-stream")]
		public static const AtlasXMLSight:Class;
		
		static private var gameTextures:Dictionary = new Dictionary();
		
		static private var heroTextureAtlas:TextureAtlas;
		static private var sightTextureAtlas:TextureAtlas;
		
		/////Explosion//////
		[Embed(source="../../media/graphics/explosionSheet.png")]
		public static const AtlasTextureExplosion:Class;
		
		[Embed(source="../../media/graphics/explosionSheet.xml", mimeType = "application/octet-stream")]
		public static const AtlasXMLExplosion:Class;
		
		static private var explosionTextureAtlas:TextureAtlas;
		////////////////////
		
		public static function getTexture(name:String):Texture
		{
			if (gameTextures[name] == undefined)
			{
				var bitmap:Bitmap = new Assets[name]();
				gameTextures[name] = Texture.fromBitmap(bitmap);
			}
			return gameTextures[name];
		}
		
		public static function getHeroTextureAtlas():TextureAtlas
		{
			if (heroTextureAtlas == null)
			{
				var texture:Texture = getTexture("AtlasTextureHero");
				var xml:XML = new XML(new AtlasXMLHero());
				heroTextureAtlas = new TextureAtlas(texture, xml);
			}
			return heroTextureAtlas;
		}
		public static function getSightTextureAtlas():TextureAtlas
		{
			if (sightTextureAtlas == null)
			{
				var texture:Texture = getTexture("AtlasSightHero");
				var xml:XML = new XML(new AtlasXMLSight());
				sightTextureAtlas = new TextureAtlas(texture, xml);
			}
			return sightTextureAtlas;
		}
		
		public static function getExplosionTextureAtlas():TextureAtlas
		{
			if (explosionTextureAtlas == null)
			{
				var texture:Texture = getTexture("AtlasTextureExplosion");
				var xml:XML = new XML(new AtlasXMLExplosion());
				explosionTextureAtlas = new TextureAtlas(texture, xml);
			}
			return explosionTextureAtlas;
		}
		
		
	}

}