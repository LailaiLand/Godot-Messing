using Godot;
using System;

public partial class Crawler : CharacterBody2D
{
	//private Vector2 _shooterPos;
	//private bool _walk = false;

	//[Export] public float Speed = 0.01F;

	public override void _Ready()
	{
		//_shooterPos = GetTree().Root.GetNode("Main").GetNode<Shooter>("Shooter").GlobalPosition;
		//GD.Print(_shooterPos);
		var animation = GetNode<AnimatedSprite2D>("AnimatedSprite2D");
		animation.Animation = "walk";
		animation.Play();
	}

	//public override void _Process(double delta)
	//{
	//	animation.FlipH = Velocity.X < 0;
	//}

	//public override void _PhysicsProcess(double delta)
	//{
	//	Vector2 crawlPos = Position;
	//	Vector2 targetPos = (crawlPos - _shooterPos).Normalized();

	//	if (_walk)
	//	{
	//		Velocity = targetPos * Speed;
	//		MoveAndSlide();
	//		LookAt(_shooterPos);
	//	}
	//}
	//private void OnDetectionArea2dBodyEntered(Node2D body)
	//{
	//	if (body.IsInGroup("Clown"))
	//	{
	//		GD.Print("PlayerFound");
	//		_walk = true;
	//	}
	//}

	public void BiterCollide()
	{
		QueueFree();
	}
}




