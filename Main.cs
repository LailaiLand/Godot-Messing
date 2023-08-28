using Godot;
using System;

public partial class Main : Node
{
	[Export]
	public PackedScene SpawnPoop { get; set; }
	private void OnBiterEat()
	{
		Poop poop = SpawnPoop.Instantiate<Poop>();
		var biterLocation = GetNode<Biter>("Biter").Position;
		poop.Position = biterLocation;
		//GetNode<Biter>("Biter").ZIndex = 5;
		//GetNode<Crawler>("Crawler").ZIndex = 3;
		//GetNode<Map>("Map").ZIndex = 0;
		//GetNode<Stage>("Stage").ZIndex = 0;
		//poop.ZIndex = 2;
		AddChild(poop);
	}

}
