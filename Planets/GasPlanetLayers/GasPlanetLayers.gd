extends "res://Planets/Planet.gd"



func set_pixels(amount):
	$GasLayers.material.set_shader_param("pixels", amount)
	 # times 3 here because in this case ring is 3 times larger than planet
	$Ring.material.set_shader_param("pixels", amount*3.0)
	
	$GasLayers.rect_size = Vector2(amount, amount)
	$Ring.rect_position = Vector2(-amount, -amount)
	$Ring.rect_size = Vector2(amount, amount)*3.0

func set_light(pos):
	$GasLayers.material.set_shader_param("light_origin", pos)
	$Ring.material.set_shader_param("light_origin", pos)

func set_seed(sd):
	var converted_seed = sd%1000/100.0
	$GasLayers.material.set_shader_param("seed", converted_seed)
	$Ring.material.set_shader_param("seed", converted_seed)

func set_rotate(r):
	$GasLayers.material.set_shader_param("rotation", r)
	$Ring.material.set_shader_param("rotation", r+0.7)

func update_time(t):
	$GasLayers.material.set_shader_param("time", t * get_multiplier($GasLayers.material) * 0.004)
	$Ring.material.set_shader_param("time", t * 314.15 * 0.004)

func set_custom_time(t):
	$GasLayers.material.set_shader_param("time", t * get_multiplier($GasLayers.material))
	$Ring.material.set_shader_param("time", t * 314.15 * $Ring.material.get_shader_param("time_speed") * 0.5)

func get_colors():
	return (_get_colors_from_gradient($GasLayers.material, "colorscheme")
	 + _get_colors_from_gradient($Ring.material, "dark_colorscheme"))
	

func set_colors(colors):
	# poolcolorarray doesnt have slice function, convert to generic array first then back to poolcolorarray
	var cols1 = PoolColorArray(Array(colors).slice(0, 2, 1))
	var cols2 = PoolColorArray(Array(colors).slice(3, 5, 1))
	
	_set_colors_from_gradient($GasLayers.material, "colorscheme", cols1)
	_set_colors_from_gradient($Ring.material, "colorscheme", cols1)
	
	_set_colors_from_gradient($GasLayers.material, "dark_colorscheme", cols2)
	_set_colors_from_gradient($Ring.material, "dark_colorscheme", cols2)

func set_random_colors():
	var colors = []
	var current_color = random_color(0.65, 0.5)
	var analog_color1 = Color.from_hsv(current_color.h + 0.05, current_color.s, current_color.v + 0.15)
	var analog_color2 = Color.from_hsv(current_color.h - 0.05, current_color.s, current_color.v - 0.15)
	# Adding the "colorscheme" colors
	colors.push_back(analog_color1.lightened(0.4))
	colors.push_back(analog_color1.lightened(0.15))
	colors.push_back(current_color.lightened(0.15))
	# Adding the "dark_colorscheme" colors
	colors.push_back(current_color)
	colors.push_back(analog_color2.darkened(0.25))
	colors.push_back(analog_color2.darkened(0.65))

#	This was the old way assigning colors, can't decide which way looks better
#	(they both look meh lol)
#	# Adding the "colorscheme" colors
#	colors.push_back(current_color.lightened(0.65))
#	colors.push_back(current_color.lightened(0.45))
#	colors.push_back(current_color.lightened(0.25))
#	# Adding the "dark_colorscheme" colors
#	colors.push_back(current_color)
#	colors.push_back(current_color.darkened(0.65))
#	colors.push_back(current_color.darkened(0.85))
	set_colors(colors)
