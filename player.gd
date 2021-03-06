extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export (int) var jump_speed
export (int) var gravity
export (int) var start_vel

var velocity: float

# Called when the node enters the scene tree for the first time.
func _ready():
   set_process(true)
   velocity = start_vel

func _input(event):
   if event is InputEventKey:
      if event.is_action_pressed("jump"):
         if velocity >= 0.0:
            velocity *= 0.5
         velocity -= jump_speed
         if velocity <= 0.0:
            velocity *= 0.5


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
   velocity += gravity * delta
   velocity = move_and_slide(Vector2(0.0, velocity)).y

   var rotation: float = self.get_rotation()
   var target_rotation: float = clamp(velocity / 800, -PI/5, PI/5)

   var delta_rot: float = (target_rotation - rotation) * 0.7

   self.set_rotation(rotation + delta_rot)

   var screen_rect: Rect2 = get_viewport().get_visible_rect()
   var screen_size: Vector2 = screen_rect.size
   if get_position().y > screen_size.y || get_position().y < -250:
      get_tree().change_scene("res://main.tscn")
