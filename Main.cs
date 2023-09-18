using Godot;
using System;

public partial class Main : Node
{
	private Marker2D _origin;

	[Export]
	public PackedScene SpawnPoop { get; set; }
		[Export]
	public PackedScene Piejectile { get; set; }

	public override void _Ready()
	{
		_origin = GetNode<Origin>("Shooter/AimingMarkers/Origin");
	}

	private void OnBiterEat()
	{
		Poop poop = SpawnPoop.Instantiate<Poop>();
		var biterLocation = GetNode<Biter>("Biter").Position;
		poop.Position = biterLocation;
		//GetNode<Biter>("Biter").ZIndex = 5;
		//GetNode<Crawler>("Crawler").ZIndex = 3;
		//GetNode<Map>("Map").ZIndex = 0;
		//GetNode<Stage>("Stage").ZIndex = 0;
		//poop.ZIndex = 2;
		AddChild(poop);
	}
	private void OnShooterShoot()
	{
		Pie pie = Piejectile.Instantiate<Pie>();      
		AddChild(pie);

		pie.Transform = _origin.GlobalTransform;
	}

}

