Things that are implemented in this demo:
	Stamina regenerating items 
	Inventory UI and functionality

How to:
	Pick up item with E, itemPickedUp signal for picking up item is sent and item shows up in player's inventory
	Use item with number 1,2,3,4, itemConsumed signal emits to notify player_movement, if condition is satisfied, playerStaminaIncreased is signalled to Inventory HUD

What is missing
	asset for stamina item
	condition handling for when inventory is full
