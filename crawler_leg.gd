extends RigidBody2D

var random_time
var flashes = 10

func _ready():
	random_time = randi_range(3, 6)
	$CrawlerPartDeleteTimer.wait_time = random_time
	$CrawlerPartDeleteTimer.start()


func _on_crawler_part_delete_timer_timeout():
	$CrawlerPartFlashTimer.start()



func _on_crawler_part_flash_timer_timeout():
	visible = !visible
	flashes = flashes -1
	if flashes <= 0:
		queue_free()
