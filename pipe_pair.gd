extends Node2D 

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var top_pipe: Node2D
var bottom_pipe: Node2D
var midpoint_y: float

var x_pos: float

var collided: bool

# Called when the node enters the scene tree for the first time.
func _ready():
   top_pipe = get_node("Top")
   bottom_pipe = get_node("Bottom")
   collided = false

   set_physics_process(true)

   randomize()
   var screen_size: Vector2 = get_viewport().get_visible_rect().size
   var screen_height: float = screen_size.y

   midpoint_y = rand_range(screen_height * 0.3, screen_height * 0.7)

   var root = get_node("../../Node2D")
   var gap = root.gap

   var top_item_height: float = top_pipe.get_node("Sprite").texture.get_height()
   var top_item_scale_y: float = top_pipe.get_scale().y * top_pipe.get_node("Sprite").get_scale().y

   top_pipe.set_position(Vector2(x_pos, midpoint_y - gap - top_item_height * top_item_scale_y))
   bottom_pipe.set_position(Vector2(x_pos, midpoint_y + gap))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
   var root = get_node("../../Node2D")
   var gap = root.gap
   var speed = root.speed

   x_pos -= speed * delta

   var width = top_pipe.get_node("Sprite").texture.get_width() \
         * top_pipe.get_node("Sprite").get_scale().x \
         * top_pipe.get_scale().x

   var screen_rect: Rect2 = get_viewport().get_visible_rect()

   var top_pos: Vector2 = top_pipe.get_position()
   var bottom_pos: Vector2 = bottom_pipe.get_position()

   top_pos.x = x_pos
   bottom_pos.x = x_pos

   if x_pos + width < screen_rect.position.x:
      var screen_size: Vector2 = screen_rect.size
      var screen_height: float = screen_size.y
      
      midpoint_y = rand_range(screen_height * 0.3, screen_height * 0.7)

      var pipe_arr = get_node("../../Node2D").pipe_arr
      var pipe_h_dist = get_node("../../Node2D").pipe_h_dist

      var max_x = 0
      for pipe in pipe_arr:
         max_x = max(max_x, pipe.x_pos)

      x_pos = max_x + pipe_h_dist

      top_pos.x = x_pos
      bottom_pos.x = x_pos

      var top_item_height: float = top_pipe.get_node("Sprite").texture.get_height()
      var top_item_scale_y: float = top_pipe.get_scale().y * top_pipe.get_node("Sprite").get_scale().y

      top_pos.y = midpoint_y - gap - top_item_height * top_item_scale_y
      bottom_pos.y = midpoint_y + gap

   top_pipe.set_position(top_pos)
   bottom_pipe.set_position(bottom_pos)

   var bird: KinematicBody2D = get_node("../Bird")
   if top_pipe.overlaps_body(bird) || bottom_pipe.overlaps_body(bird):
      get_tree().change_scene("res://main.tscn")

