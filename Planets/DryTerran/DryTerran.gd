extends "res://Planets/Planet.gd"


func set_pixels(amount):
	$Land.material.set_shader_param("pixels", amount)
	$Land.rect_size = Vector2(amount, amount)
func set_light(pos):
	$Land.material.set_shader_param("light_origin", pos)
func set_seed(sd):
	var converted_seed = sd%1000/100.0
	$Land.material.set_shader_param("seed", converted_seed)
func set_rotate(r):
	$Land.material.set_shader_param("rotation", r)
func update_time(t):
	$Land.material.set_shader_param("time", t * get_multiplier($Land.material) * 0.02)
func set_custom_time(t):
	$Land.material.set_shader_param("time", t * get_multiplier($Land.material))


func get_colors():
	return _get_colors_from_gradient($Land.material, "colors")

func set_colors(colors):
	_set_colors_from_gradient($Land.material, "colors", colors)

func set_random_colors():
	var colors = []
	var current_color = random_color()
	var analog_color1 = Color.from_hsv(current_color.h + 0.035, current_color.s, current_color.v)
	var analog_color2 = Color.from_hsv(current_color.h - 0.035, current_color.s, current_color.v)
	colors.append(analog_color1.lightened(0.2))
	colors.append(current_color)
	colors.append(analog_color2.darkened(0.2))
	colors.push_back(current_color.darkened(0.6))
	colors.push_back(current_color.darkened(0.7))
	
#	This was the old way assigning colors, can't decide which way looks better 
#	colors.push_back(current_color.lightened(0.5))
#	colors.push_back(current_color.lightened(0.3))
#	colors.push_back(current_color)
#	colors.push_back(current_color.darkened(0.3))
#	colors.push_back(current_color.darkened(0.5))
	set_colors(colors)
