package;

import thx.semver.Version;
import sys.io.File;
import haxe.Json;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.text.FlxText;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.FlxState;
import sys.FileSystem;

class SceneSelect extends FlxState
{
	public var scenes:Array<SceneJSON> = [];
	public var scenesText:FlxTypedGroup<FlxText>;

	public var sceneAPIVer:String = '>=1.0.0 <2.0.0';

	public var camFollow:FlxObject;

	public var currentSelected:Int = 0;

	override public function create()
	{
		super.create();

		for (folder in FileSystem.readDirectory('scenes/'))
		{
			if (FileSystem.isDirectory('scenes/$folder'))
				if (FileSystem.exists('scenes/$folder/scene.json'))
				{
					var sceneJsonFile:SceneJSON = Json.parse(File.getContent('scenes/$folder/scene.json'));
					var apiVer:Version = Version.stringToVersion(sceneJsonFile.api);

					if (apiVer.satisfies(sceneAPIVer))
						scenes.push(sceneJsonFile);
					else
						trace('Unsupported scene: ' + sceneJsonFile.name);
				}
		}

		scenesText = new FlxTypedGroup<FlxText>();
		add(scenesText);

		var i = 0;
		for (scene in scenes)
		{
			var sceneText:FlxText = new FlxText(0, i * 48, 0, scene.name, 16);
			sceneText.ID = i;
			scenesText.add(sceneText);
			i++;
		}

		camFollow = new FlxObject();
		add(camFollow);
		camFollow.x = FlxG.width / 2;

		FlxG.camera.follow(camFollow, LOCKON, 0.5);
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
