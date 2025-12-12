package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.text.FlxText;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.FlxState;
import sys.FileSystem;

class SceneSelect extends FlxState
{
	public var scenes:Array<String> = [];
	public var scenesText:FlxTypedGroup<FlxText>;

	public var camFollow:FlxObject;

	public var currentSelected:Int = 0;

	override public function create()
	{
		super.create();

		for (folder in FileSystem.readDirectory('scenes/'))
		{
			if (FileSystem.isDirectory('scenes/$scenes'))
				scenes.push(folder);
		}

		scenesText = new FlxTypedGroup<FlxText>();
		add(scenesText);

		var i = 0;
		for (scene in scenes)
		{
			var sceneText:FlxText = new FlxText(0, i * 48, 0, scene, 16);
			sceneText.ID = i;
			scenesText.add(sceneText);
			i++;
		}

		camFollow = new FlxObject();
		add(camFollow);
		camFollow.x = FlxG.width / 2;
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		for (sceneText in scenesText)
		{
			if (currentSelected == sceneText.ID)
				camFollow.y = sceneText.y;
		}
	}
}
