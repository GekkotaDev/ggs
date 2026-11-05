@icon("res://addons/at-icons/node/cog.svg")

@tool
extends Node

const SettingsLoader := preload("uid://e4g3dgn0ja7p")

@export_multiline var description: String

@export_group("Config", "config_")
@export var config_section: String:
	set(value):
		config_section = value
		update_configuration_warnings()

@export_group("Controls", "control_")
@export var control_label: Label:
	set(value):
		control_label = value
		update_configuration_warnings()

@export var control_control: Control:
	set(value):
		control_control = value
		update_configuration_warnings()

@export var control_attribute: StringName:
	set(value):
		control_attribute = value
		update_configuration_warnings()

var config_key:
	get:
		control_label.text.to_snake_case()


func _get_configuration_warnings() -> PackedStringArray:
	var warnings: Array[String] = []

	if config_section == null:
		warnings.append("Settings property must child of TabContainer or have valid section")

	if control_label == null:
		warnings.append("Settings property must have label")

	if control_control == null:
		warnings.append("Settings property must not be root")

	if control_control.get(control_attribute) == null:
		warnings.append("Control attribute is not valid")

	return warnings


func _ready() -> void:
	var settings_instance := SettingsLoader.get_instance()

	if control_control == null:
		control_control = get_parent()

	if config_section == null or config_section.is_empty():
		config_section = infer_section(control_control)

	control_control.focus_entered.connect(
		func():
			settings_instance.property_accessed.emit(self),
	)


func infer_section(node: Control):
	if node == null:
		update_configuration_warnings()
		return
	if node.get_parent() is TabContainer:
		return node
	return infer_section(node)


func load():
	var settings_loader := SettingsLoader.get_instance()
	var config := settings_loader.config
	var value = config.get_value(config_section, config_key)

	control_control.set(control_attribute, value)


func save():
	var settings_loader := SettingsLoader.get_instance()
	var config := settings_loader.config
	var value := control_control.get(control_attribute)

	config.set_value(config_section, config_key, value)
