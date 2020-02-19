extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var pipe_pair = preload("res://pipes.tscn")

export (float) var pipe_h_dist
export (float) var gap = 200
export (float) var speed = 100

var pipe_arr: Array

# Called when the node enters the scene tree for the first time.
func _ready():
   var screen_size: Vector2 = get_viewport().get_visible_rect().size
   var screen_width: float = screen_size.x

   for i in range(6):
      var pair = pipe_pair.instance()
      pair.x_pos = screen_width + pipe_h_dist * i
      pipe_arr.push_back(pair)
      add_child(pair)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass
