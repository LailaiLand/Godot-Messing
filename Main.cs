using Godot;
using System;

public partial class Main : Node
{
	private Marker2D _origin;

	[Export]
	public PackedScene SpawnPoop { get; set; }

	public override void _Ready()
	{
	}

	private void OnBiterEat()
	{
		Poop poop = SpawnPoop.Instantiate<Poop>();
		var biterLocation = GetNode<Biter>("Biter").Position;
		poop.Position = biterLocation;
		AddChild(poop);
	}


}

