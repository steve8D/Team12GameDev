Things that are implemented in this demo:
	Stamina regenerating items 
	Inventory UI and functionality

How to:
	Pick up item with E, itemPickedUp signal for picking up item is sent and item shows up in player's inventory
	Use item with number 1,2,3,4, itemConsumed signal emits to notify player_movement, if condition is satisfied, playerStaminaIncreased is signalled to Inventory HUD

What to notice: 
	Each item asset has a name in this, this is mandatory for inventory.gd to use its internal dictionary to load the correct art asset in the UI
	Check the mask and layers of the players and items 
	Check where the signals are linked between Items, Inventory HUD, and Player under Node tab

What is missing
	asset for stamina item
	condition handling for when inventory is full
