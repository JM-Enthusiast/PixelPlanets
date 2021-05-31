extends "res://Planets/Planet.gd"

func set_pixels(amount):
	$PlanetUnder.material.set_shader_param("pixels", amount)
	$Craters.material.set_shader_param("pixels", amount)
	$LavaRivers.material.set_shader_param("pixels", amount)
	
	$PlanetUnder.rect_size = Vector2(amount, amount)
	$Craters.rect_size = Vector2(amount, amount)
	$LavaRivers.rect_size = Vector2(amount, amount)
	
func set_light(pos):
	$PlanetUnder.material.set_shader_param("light_origin", pos)
	$Craters.material.set_shader_param("light_origin", pos)
	$LavaRivers.material.set_shader_param("light_origin", pos)

func set_seed(sd):
	var converted_seed = sd%1000/100.0
	$PlanetUnder.material.set_shader_param("seed", converted_seed)
	$Craters.material.set_shader_param("seed", converted_seed)
	$LavaRivers.material.set_shader_param("seed", converted_seed)

func set_rotate(r):
	$PlanetUnder.material.set_shader_param("rotation", r)
	$Craters.material.set_shader_param("rotation", r)
	$LavaRivers.material.set_shader_param("rotation", r)

func update_time(t):	
	$PlanetUnder.material.set_shader_param("time", t * get_multiplier($PlanetUnder.material) * 0.02)
	$Craters.material.set_shader_param("time", t * get_multiplier($Craters.material) * 0.02)
	$LavaRivers.material.set_shader_param("time", t * get_multiplier($LavaRivers.material) * 0.02)

func set_custom_time(t):
	$PlanetUnder.material.set_shader_param("time", t * get_multiplier($PlanetUnder.material))
	$Craters.material.set_shader_param("time", t * get_multiplier($Craters.material))
	$LavaRivers.material.set_shader_param("time", t * get_multiplier($LavaRivers.material))

var color_vars1 = ["color1","color2","color3"]
var color_vars2 = ["color1","color2"]
var color_vars3 = ["color1","color2","color3"]

func get_colors():
	return (_get_colors_from_vars($PlanetUnder.material, color_vars1)
	+ _get_colors_from_vars($Craters.material, color_vars2)
	+ _get_colors_from_vars($LavaRivers.material, color_vars3)
	)

func set_colors(colors):
	_set_colors_from_vars($PlanetUnder.material, color_vars1, colors.slice(0, 2, 1))
	_set_colors_from_vars($Craters.material, color_vars2, colors.slice(3, 4, 1))
	_set_colors_from_vars($LavaRivers.material, color_vars3, colors.slice(5, 7, 1))

func set_random_colors():
	var colors = []
	var current_color = random_color(0.75, 0.65)
	var analog_color1
	var analog_color2
	# Adding the PlanetUnder colors
	colors.append(current_color.lightened(0.3))
	colors.append(current_color)
	colors.append(current_color.darkened(0.4))
	#Adding the Craters colors
	colors.append(current_color.darkened(0.05))
	colors.append(current_color.darkened(0.45))
	# Adding the LavaRivers colors
	current_color = random_color(0.8, 0.85)
#	current_color = current_color.inverted() # Uncomment for complementary color
	analog_color1 = Color.from_hsv(current_color.h + 0.035, current_color.s, current_color.v)
	analog_color2 = Color.from_hsv(current_color.h - 0.035, current_color.s, current_color.v)
	colors.append(analog_color1.lightened(0.25))
	colors.append(current_color)
	colors.append(analog_color2.darkened(0.3))
	
#	This was the old way assigning colors, can't decide which way looks better
#	colors.append(current_color.lightened(0.3))
#	colors.append(current_color)
#	colors.append(current_color.darkened(0.4))
	set_colors(colors)
