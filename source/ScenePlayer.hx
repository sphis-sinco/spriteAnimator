import flixel.FlxState;

class ScenePlayer extends FlxState
{
    public var folder:String = '';

	override public function new(folder:String)
	{
		super();

        this.folder = folder;
	}
}
