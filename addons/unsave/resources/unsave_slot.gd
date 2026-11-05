@icon("res://addons/at-icons/node/floppy_disk.svg")

@abstract
class_name UnsaveSlot extends Resource

const UnsaveSlot = preload("./unsave_slot.gd")

@export var version: Vector3i
@export var slot: String

var extension: String
var save_flags := ResourceSaver.FLAG_BUNDLE_RESOURCES + ResourceSaver.FLAG_COMPRESS


func default(key: StringName, builder: Callable):
	set(key, builder.call())
	return self


func save(override: String):
	var path := "user://{slot}.{extension}".format(
		{ slot = override if override else slot, extension = extension }
	)
	ResourceSaver.save(self, path, save_flags)


@abstract
func migrate(slot: UnsaveSlot) -> UnsaveSlot
