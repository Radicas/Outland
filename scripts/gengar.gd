extends CharacterBody2D

# 移动速度
# @export表示可以将变量用右侧检查器控制
@export var speed: float = 200.0

# 获取角色的 AnimatedSprite2D
# 只会寻找一层字节点，如果要找更深的节点，需要写相对路径
# @onready表示会在_ready之前初始化
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(_delta: float) -> void:
	var input_vector = Vector2.ZERO

	# 输入检测
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")

	# 归一化，防止斜向移动速度加快
	input_vector = input_vector.normalized()

	# 移动角色
	velocity = input_vector * speed
	move_and_slide()

	# 更新动画
	if input_vector != Vector2.ZERO:
		if abs(input_vector.x) > abs(input_vector.y):
			sprite.animation = "right" if input_vector.x > 0 else "left"
		else:
			sprite.animation = "down" if input_vector.y > 0 else "up"
		if not sprite.is_playing():
			sprite.play()
	else:
		sprite.stop()
