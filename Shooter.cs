using Godot;
using System;

public partial class Shooter : CharacterBody2D
{
	private AnimationPlayer _animation;
	private bool _isFlipped = false;
	private bool _isIdle = true;
	private bool _isRun = false;
	private bool _isHit = false;
	private bool _isDance = false;
	private bool _isThrow = false;


	[Export] public int Speed { get; set; } = 5;
	[Export] public int Health { get; set; } = 3;

	[Signal]
	public delegate void HitEventHandler();


	public override void _Ready()
	{
		_animation = GetNode<AnimationPlayer>("AnimationPlayer");
	}

	public override void _Process(double delta)
	{
        if (_isIdle) _animation.GetAnimationLibrary("Partial").GetAnimation("Idle");
		else if (_isRun) _animation.GetAnimationLibrary("Simple").GetAnimation("Run");
		_animation.Play();
	}

	public void GetInput()
	{
        Vector2 inputDirection = Input.GetVector("leftWalk", "rightWalk", "upWalk", "downWalk");
        Velocity = inputDirection * Speed;
    }

    public override void _PhysicsProcess(double delta)
    {
		MoveAndSlide();
    }

}
