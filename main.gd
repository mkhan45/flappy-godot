extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var pipe_pair = preload("res://pipes.tscn")

export (float) var pipe_h_dist
export (float) var gap = 200
export (float) var speed = 100

# Called when the node enters the scene tree for the first time.
func _ready():
   var screen_size: Vector2 = get_viewport().get_visible_rect().size
   var screen_width: float = screen_size.x
   var screen_height: float = screen_size.y

   var pipe1 = pipe_pair.instance()
   var pipe2 = pipe_pair.instance()
   var pipe3 = pipe_pair.instance()

   pipe1.x_pos = screen_width
   pipe2.x_pos = screen_width + pipe_h_dist * 2
   pipe3.x_pos = screen_width + pipe_h_dist * 3

   add_child(pipe1)
   add_child(pipe2)
   add_child(pipe3)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass
