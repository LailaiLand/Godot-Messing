using Godot;
using System;

public partial class Crawler : CharacterBody2D
{
	public override void _Process(double delta)
	{
		var animation = GetNode<AnimatedSprite2D>("AnimatedSprite2D");
		animation.Animation = "walk";
		animation.Play();
		animation.FlipH = Velocity.X < 0;
	}

	public void BiterCollide()
	{
		QueueFree();
	}
}
