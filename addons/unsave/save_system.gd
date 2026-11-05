@icon("res://addons/at-icons/node/floppy_disks.svg")
extends Node

const SaveSlot := preload("./resources/unsave_slot.gd")

@export var base_path: String
@export var extension: String

var locked:
	get:
		return _locked
var current_slot: SaveSlot:
	get:
		return current_slot
	set(value):
		if locked:
			return
		current_slot = value

var _locked := false


func _ready() -> void:
	base_path = base_path.simplify_path()


func drop_slot(slot: String):
	var path := "user://{path}/{slot}.{extension}".format(
		{ path = base_path, slot = slot, extension = extension }
	)
	var current_path := "user://{path}/{slot}.{extension}".format(
		{ path = base_path, slot = current_slot.slot, extension = current_slot.extension }
	)

	if path != current_path:
		DirAccess.remove_absolute(path)


func load_slot(slot: String):
	var path := "user://{path}/{slot}.{extension}".format(
		{ path = base_path, slot = slot, extension = extension }
	)
	var save_slot := ResourceLoader.load(path) as SaveSlot
	save_slot.slot = slot
	save_slot.extension = extension
	return save_slot


func lock_slot(slot: SaveSlot) -> Error:
	if not locked:
		current_slot = slot
		_locked = true
		return OK
	return ERR_LOCKED


func unlock_slot() -> Error:
	if locked:
		current_slot = null
		_locked = false
		return OK
	return ERR_CANT_OPEN


func use_slot(slot: String) -> Error:
	var save_slot: SaveSlot = load_slot(slot)
	if save_slot == null:
		return ERR_DOES_NOT_EXIST

	unlock_slot()
	return lock_slot(save_slot)
