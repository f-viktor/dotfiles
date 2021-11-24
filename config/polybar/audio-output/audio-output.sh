HEADPHONE= 
SPEAKER=
# pactl list sinks | grep "Description"  <-index numbmer for headphone output
HEADPHONE_CARD_NAME="WH-1000XM3"



function move_sinks_to_new_default {
    DEFAULT_SINK=$1
    pactl list sink-inputs short | awk '{print $1}' | while read SINK
    do
        pactl move-sink-input $SINK $DEFAULT_SINK
    done
}

function set_default_playback_device_next {
    inc=${1:-1}
    num_devices=$(pactl list sinks short| wc -l)
    sink_arr=($(pactl list sinks short | awk '{print $1}'))
    default_sink_index=$(( $(pactl list sinks short | grep -no 'RUNNING' | grep -o '^[0-9]\+') - 1 ))
    default_sink_index=$(( ($default_sink_index + $num_devices + $inc) % $num_devices ))
    default_sink=${sink_arr[$default_sink_index]}
    pactl set-default-sink $default_sink
    move_sinks_to_new_default $default_sink
}


if pactl list sinks | grep "RUNNING" -A 10| grep -q "$HEADPHONE_CARD_NAME"; then
	if [[ $1 = "--toggle" ]]; then
		echo $SPEAKER
		set_default_playback_device_next
	else
		echo %{F\#ffb000}$HEADPHONE%{F-} 
	fi
else
	if [[ $1 = "--toggle" ]]; then
		echo %{F\#ffb000}$HEADPHONE%{F-} 
		set_default_playback_device_next
	else
		echo $SPEAKER
	fi
fi
