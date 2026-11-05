@tool
extends EditorPlugin


func _enable_plugin() -> void:
	# Add autoloads here.
	add_custom_type(
		&"SettingsControl",
		&"Node",
		preload("res://addons/simple_settings/nodes/settings_control.gd"),
		preload("res://addons/at-icons/node/wrench.svg"),
	)

	add_custom_type(
		&"SettingsLoader",
		&"Node",
		preload("res://addons/simple_settings/nodes/settings_loader.gd"),
		preload("res://addons/at-icons/node/file_cog.svg"),
	)

	add_custom_type(
		&"SettingsProperty",
		&"Resource",
		preload("res://addons/simple_settings/resources/settings_property.gd"),
		preload("res://addons/at-icons/node/cog.svg"),
	)

	add_custom_type(
		&"SettingsSection",
		&"Resource",
		preload("res://addons/simple_settings/resources/settings_section.gd"),
		preload("res://addons/at-icons/node/file_sliders.svg"),
	)


func _disable_plugin() -> void:
	# Remove autoloads here.
	remove_custom_type(&"SettingsControl")
	remove_custom_type(&"SettingsLoader")
	remove_custom_type(&"SettingsProperty")
	remove_custom_type(&"SettingsSection")


func _enter_tree() -> void:
	# Initialization of the plugin goes here.
	pass


func _exit_tree() -> void:
	# Clean-up of the plugin goes here.
	pass
