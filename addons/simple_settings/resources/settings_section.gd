extends Resource

const SettingsProperty := preload("uid://ppch63gqqcjx")

@export var section: StringName
@export var properties: Dictionary[StringName, SettingsProperty] = { }
