extends Control

var object_scene = preload("res://object/object.tscn")

var score = 0
var timer_length = 5
var x_max: int
var y_max: int


func spawn_object():
	var object = object_scene.instantiate()
	var random_position = Vector2(randi_range(150, x_max - 150), randi_range(150, y_max - 150))
	add_child.call_deferred(object)
	object.global_position = random_position
	object.connect("destroyed", Callable(self, "_object_destroyed"))
	
func _ready() -> void:
	$Timer.wait_time = timer_length
	$Timer.start()
	
	var screensize = get_viewport().get_visible_rect().size 
	x_max = int(screensize[0])
	y_max = int(screensize[1])
	spawn_object()

func _process(_delta: float) -> void:
	$ScoreLabel.text = "Score: " + str(score)
	$TimerLabel.text = "Time left: " + str(int($Timer.time_left))
	
func _on_timer_timeout() -> void:
	get_tree().paused = true
	$Menu.visible = true
	$Menu/FinalScoreLabel.text = "Final score: " + str(score)
	
func _on_try_again_button_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_quit_button_pressed() -> void:
	get_tree().quit()
	
func _object_destroyed():
	score += 1
	spawn_object()
