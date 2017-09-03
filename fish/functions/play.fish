# Defined in - @ line 0
function play --description 'alias play mpv --really-quiet $argv &;disown'
	mpv --really-quiet $argv &;disown;
end
