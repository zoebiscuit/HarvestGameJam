extends AtlasTexture
class_name WheelOption

@export var name = ""
@export var count := 0

func add_amount(amount: int)-> void:
	count += amount
	return
	
func remove_amount(amount: int)-> void:
	
	if count - amount < 0:
		count = 0
	else: count -= amount
	
	return
