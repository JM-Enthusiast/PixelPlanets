extends "res://Planets/Planet.gd"

func set_pixels(amount):
	$Asteroid.material.set_shader_param("pixels", amount)
	$Asteroid.rect_size = Vector2(amount, amount)

func set_light(pos):
	$Asteroid.material.set_shader_param("light_origin", pos)

func set_seed(sd):
	var converted_seed = sd%1000/100.0
	$Asteroid.material.set_shader_param("seed", converted_seed)

func set_rotate(r):
	$Asteroid.material.set_shader_param("rotation", r)

func update_time(_t):
	pass

func set_custom_time(t):
	$Asteroid.material.set_shader_param("rotation", t * PI * 2.0)

var color_vars = ["color1", "color2", "color3"]
func get_colors():
	return _get_colors_from_vars($Asteroid.material, color_vars)

func set_colors(colors):
	_set_colors_from_vars($Asteroid.material, color_vars, colors)

func set_random_colors():
	var current_color = random_color()
	var colors = []
	colors.append(current_color.lightened(0.3))
	colors.append(current_color)
	colors.append(current_color.darkened(0.4))
	set_colors(colors)
