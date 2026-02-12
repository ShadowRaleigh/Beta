class_name Player
extends CharacterBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 4.5
const MAX_ROTATION = 90
var sensitivity = 0.12
@onready var head: Node3D = $Head
@onready var hand_sprite = $HandSprite # O nó que mostra o item

#Variavel para inventário
var inventory:Inventory = Inventory.new()

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


# Função que será conectada ao sinal da Hotbar
func _on_hotbar_item_changed(new_item_texture):
	if new_item_texture:
		hand_sprite.texture = new_item_texture
		hand_sprite.visible = true
	else:
		# Se não houver item (caso de null), esconde a mão
		hand_sprite.visible = false


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion :
		head.rotate_x(deg_to_rad(-event.screen_relative.y * sensitivity))
		rotate_y(deg_to_rad(-event.screen_relative.x * sensitivity))
		
		head.rotation.x = clampf(head.rotation.x, deg_to_rad(-MAX_ROTATION), deg_to_rad(MAX_ROTATION))

func _physics_process(delta: float) -> void:
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
