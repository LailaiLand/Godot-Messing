using Godot;
using System;
using System.ComponentModel;

public partial class Biter : CharacterBody2D
{
	private AnimatedSprite2D _animation;
	[Export] public int Speed { get; set; } = 5;

	public override void _Ready()
	{
		_animation = GetNode<AnimatedSprite2D>("AnimatedSprite2D");
	}
	public override void _Process(double delta)
	{
		if (_animation.Animation != "bite") _animation.Animation = "stand";
		_animation.Play();
		_animation.FlipH = Velocity.X < 0;
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
		if (collision == null) return;
		if (_animation.Animation != "stand") return;
		if (((Node)collision.GetCollider()).Name.ToString().Contains("Crawler"))
		{
			((Crawler)collision.GetCollider()).BiterCollide();
			_animation.Animation = "bite";
		}
	}
}
