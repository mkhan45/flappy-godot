extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var top_pipe: Node2D
var bottom_pipe: Node2D
var midpoint_y: float

export (float) var gap
export (float) var speed

# Called when the node enters the scene tree for the first time.
func _ready():
   top_pipe = get_node("Top")
   bottom_pipe = get_node("Bottom")

   randomize()
   var screen_size: Vector2 = get_viewport().get_visible_rect().size
   var screen_width: float = screen_size.x
   var screen_height: float = screen_size.y

   midpoint_y = rand_range(screen_height * 0.3, screen_height * 0.7)

   var top_item_height: float = top_pipe.get_node("Sprite").texture.get_height()
   var top_item_scale_y: float = top_pipe.get_scale().y
   top_pipe.set_position(Vector2(screen_width, midpoint_y - gap - top_item_height * top_item_scale_y))
   bottom_pipe.set_position(Vector2(screen_width, midpoint_y + gap))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
   var top_pipe_pos = top_pipe.get_position()
   var bottom_pipe_pos = bottom_pipe.get_position()

   # top_pipe.set_position(Vector2(top_pipe_pos.x - speed * delta, midpoint_y - gap / 2 - top_pipe.get_scale().y))
   # bottom_pipe.set_position(Vector2(bottom_pipe_pos.x - speed * delta, midpoint_y + gap / 2))

   top_pipe.set_position(Vector2(top_pipe_pos.x - speed * delta, top_pipe_pos.y))
   bottom_pipe.set_position(Vector2(bottom_pipe_pos.x - speed * delta, bottom_pipe_pos.y))
