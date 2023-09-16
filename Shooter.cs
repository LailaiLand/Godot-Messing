using Godot;
using System;

public partial class Shooter : CharacterBody2D
{
	private AnimationPlayer _animation;


	private bool _isIdle = false;
	private bool _isRun = false;
	private bool _isHit = false;
	private bool _isDance = false;
	private bool _isThrow = false;


	[Export] public int Speed { get; set; } = 200;
	[Export] public int Health { get; set; } = 3;

	[Signal]
	public delegate void FlipEventHandler();
	[Signal]
	public delegate void UnFlipEventHandler();


	public override void _Ready()
	{
		_animation = GetNode<AnimationPlayer>("AnimationPlayer");
		GD.Print("Shooter Loaded");

	}

	public override void _Process(double delta)
	{
		if (_isIdle) _animation.Play("Partial/Idle");
		else if (_isRun) _animation.Play("Simple/Run");
	}

	public void GetInput()
	{
		Vector2 inputDirection = Input.GetVector("leftWalk", "rightWalk", "upWalk", "downWalk");
		Velocity = inputDirection * Speed;
	}

	public override void _PhysicsProcess(double delta)
	{
		GetInput();
		if (Velocity == Vector2.Zero)
		{
			_isRun = false;
			_isIdle = true;
		}
		else
		{
			_isIdle = false;
			_isRun = true;
		}

		if (Velocity.X < 0)
		{
			EmitSignal("Flip");
			GD.Print("Flip Emitted");
		}

		if (Velocity.X > 0)
		{
			EmitSignal("UnFlip");
		}

		MoveAndSlide();
	}

}
