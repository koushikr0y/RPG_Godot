extends CharacterBody2D
class_name Player

@export_group("Stats")
@export var max_health: float = 10.0
@export var max_mana: float = 10.0
@export var move_speed: float = 60.0
@export var damage: float = 5.0
@export var crit_chance: float = 0.0
@export var crit_damage: float = 0.0

@onready var health_component: HealthComponent = $HealthComponent
@onready var animated_sprite: AnimatedSprite2D = $AnimSprite
@onready var fsm: FSM = $FSM

var last_direction: String = "down"
var curr_mana: float

#func _ready() -> void:
	#health_component.setup(max_health)

func _process(delta: float) -> void:
	if fsm.curr_state: 
		fsm.curr_state.process_state(delta)
		
func is_moving() -> bool:
	var move_input = ["move_down","move_left","move_right","move_up"]
	for input in move_input:
		if Input.is_action_pressed(input):
			return true
	return false

func update_direction(input_vector: Vector2) -> void:
	if input_vector == Vector2.ZERO:
		return
		
	if(abs(input_vector.x) > abs(input_vector.y)):
		last_direction = "right" if input_vector.x > 0 else "left"
	else:
		last_direction = "down" if input_vector.y > 0 else "up"

func play_direction_anim(anim_name: String) -> void:
	animated_sprite.play("%s_%s" % [anim_name,last_direction])

func setup()->void:
	reset_health()
	reset_mana()

func reset_health()->void:
	health_component.setup(max_health)
	EventBus.on_player_health_updated.emit(max_health,max_health)
	
func reset_mana()->void:
	curr_mana=max_mana
	EventBus.on_player_mana_updated.emit(max_mana,max_mana)
	
func use_mana(value: float)->void:
	curr_mana-=value
	curr_mana=max(curr_mana,0)
	EventBus.on_player_mana_updated.emit(curr_mana,max_mana)
	
	
