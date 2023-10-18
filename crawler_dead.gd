extends Node2D

func _ready():
	$DeadCrawlerDeleteTimer.start()



func _on_dead_crawler_delete_timer_timeout():
	queue_free()
