extends Node

enum Faction {
	PEASANTS,
	NOBILITY,
	CLERGY
}

enum Effects {
	REPUTATION,
	LITERACY,
	HEALTHCARE,
	LABOR,
	TAX,
	POLICING
}

enum END_CONDITION {
	NONE,
	WIN,
	BARELY_WIN,
	LOSS_PEASANT,
	LOSS_NOBILITY,
	LOSS_CLERGY,
	LOSS_ALL # You really messed up somehow... Congrats? Impressive? You suck?
}
