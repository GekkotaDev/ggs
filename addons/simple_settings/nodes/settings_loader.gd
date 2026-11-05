@icon("res://addons/at-icons/node/cog.svg")

extends Node

const SettingsLoader := preload("uid://e4g3dgn0ja7p")
const SettingsControl := preload("uid://cdtcqrothyg0c")
const SettingsSection := preload("uid://tkph0ycnr3cu")

static var instance: SettingsLoader

signal property_accessed(property: SettingsControl)

@export var path: StringName
@export var defaults: Array[SettingsSection] = []

var config := ConfigFile.new()


static func get_instance() -> SettingsLoader:
	if not instance:
		instance = SettingsLoader.new()
	return instance


func _init() -> void:
	if path.begins_with("res://"):
		return

	if path.begins_with("user://"):
		return

	path = path.simplify_path()
	path = "user://{path}".format({ path = path })


func _ready() -> void:
	instance = self
	hydrate_settings()


func hydrate_settings():
	if FileAccess.file_exists(path):
		config.load(path)
		return

	for section in defaults:
		for property in section.properties:
			config.set_value(section.section, property, section.properties[property])
	config.save(path)


func save():
	var nodes := get_tree().current_scene.find_children(&"*", &"SettingsControl")
	var properties: Array[SettingsControl] = nodes.filter(
		func(node: Node):
			return node is SettingsControl,
	)

	for property in properties:
		property.save()
