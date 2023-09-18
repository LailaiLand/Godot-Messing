using Godot;
using System;

public partial class Piesplotion : AnimatedSprite2D
{
	public void OnPiesplotionAnimationFinished()
	{
		Visible = false;
		AddChild(new Tin());
	}
}
