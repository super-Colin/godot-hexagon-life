extends Node








func is_game_hitting_target_fps(delta, targetFps=-1, fallbackFps=60):
	if not targetFps:
		targetFps = Engine.max_fps
		if not targetFps:
			targetFps = DisplayServer.screen_get_refresh_rate()
			if not targetFps:
				targetFps = fallbackFps
	if delta < 1.0/targetFps:
		return false
	return true













#
