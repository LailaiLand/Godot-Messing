using Godot;
using System;

public partial class Pie : Area2D
{
	[Export] public int Speed = 700;
	[Export] public PackedScene Splotion { get; set; }

	public override void _PhysicsProcess(double delta)
	{
		Position += Transform.X * Speed * (float)delta;
	}

	public void OnPieBodyEntered(CharacterBody2D body)
	{
		if (body.Name == "Crawler")
		{
			body.QueueFree();
		}

		Piesplotion piesplotion = Splotion.Instantiate<Piesplotion>();
		Owner.Owner.AddChild(piesplotion);
		
	}
}
