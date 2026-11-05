extends Resource

@export var default_value: Variant

@export_storage var value:
	get:
		return value if value != null else default_value
