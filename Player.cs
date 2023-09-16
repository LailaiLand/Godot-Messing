using Godot;
using System;

public partial class Player : Node2D
{
	private float _shooterScaleY;
	private float _shooterRotation;

	public override void _Ready()
{
	_shooterScaleY = GetNode<Shooter>("Shooter").Scale.Y;
	_shooterRotation = GetNode<Shooter>("Shooter").RotationDegrees;
}

	private void OnShooterFlip()
	{
		_shooterScaleY = (float)-1;
		_shooterRotation = (float)180;
		GD.Print("Flip Activated");

	}
	private void OnShooterUnFlip()
	{
		_shooterScaleY = (float)1;
		_shooterRotation = (float)0;
	}
}






