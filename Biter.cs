using Godot;
using System;
using System.ComponentModel;

public partial class Biter : CharacterBody2D
{
	[Export] public int Speed { get; set; } = 5;

	public override void _Process(double delta)
	{
		var animation = GetNode<AnimatedSprite2D>("AnimatedSprite2D");
		animation.Animation = "stand";
		animation.Play();
		animation.FlipH = Velocity.X < 0;
	}

	public void GetInput()
	{
		Vector2 inputDirection = Input.GetVector("leftBiter", "rightBiter", "upBiter", "downBiter");
		Velocity = inputDirection * Speed;
	}

	public override void _PhysicsProcess(double delta)
	{
		GetInput();
		var collision = MoveAndCollide(Velocity, false, (float)delta, false);
		if (collision != null)
		{
			if (((Node)collision.GetCollider()).Name.ToString().Contains("Crawler"))
				((Crawler)collision.GetCollider()).BiterCollide();
		}
	}
}
