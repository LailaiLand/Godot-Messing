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
		AddChild(poop);
	}

}
