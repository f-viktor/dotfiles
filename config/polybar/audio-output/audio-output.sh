HEADPHONE=
SPEAKER=
# pacmd list-sinks  <-card_name for headphone output
HEADPHONE_CARD_NAME="HDA NVidia"



function move_sinks_to_new_default {
    DEFAULT_SINK=$1
    pacmd list-sink-inputs | grep index: | grep -o '[0-9]\+' | while read SINK
    do
        pacmd move-sink-input $SINK $DEFAULT_SINK
    done
}

function set_default_playback_device_next {
    inc=${1:-1}
    num_devices=$(pacmd list-sinks | grep -c index:)
    sink_arr=($(pacmd list-sinks | grep index: | grep -o '[0-9]\+'))
    default_sink_index=$(( $(pacmd list-sinks | grep index: | grep -no '*' | grep -o '^[0-9]\+') - 1 ))
    default_sink_index=$(( ($default_sink_index + $num_devices + $inc) % $num_devices ))
    default_sink=${sink_arr[$default_sink_index]}
    pacmd set-default-sink $default_sink
    move_sinks_to_new_default $default_sink
}


# decide whether the hotspot is working based on whether hostapd is running
if pacmd list-sinks | grep "\*" -A 40 | grep -q "$HEADPHONE_CARD_NAME"; then
	if [[ $1 = "--toggle" ]]; then
		set_default_playback_device_next
		echo $SPEAKER
	else
		echo %{F\#ffb000}$HEADPHONE%{F-} 
	fi
else
	if [[ $1 = "--toggle" ]]; then
		set_default_playback_device_next
		echo %{F\#ffb000}$HEADPHONE%{F-} 
	else
		echo $SPEAKER
	fi
fi
