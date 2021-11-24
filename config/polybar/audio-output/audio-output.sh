HEADPHONE=%{F\#ffb000}%{F-}
CALLMODE=%{F\#ffb000}%{F-}
SPEAKER=
CURRENT_MODE="_"

# pactl list sinks | grep "Description" <- pick your TWL headphone if you have one
HEADPHONE_CARD_NAME="WH-1000XM3"

#codecs to switch between for good audio vs bad audio+microphone
GOOD_AUDIO="a2dp-sink-ldac"
BAD_PLUS_MIC="headset-head-unit-msbc"

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

function set_potato_hsf {
    bluez_card_name=$(pactl list cards | grep $HEADPHONE_CARD_NAME -B 10 | grep "Name" | awk '{print $2}')
    current_codec=$(pactl list sinks | grep "RUNNING" -A20 | grep "api.bluez5.profile")
    if echo "$current_codec" | grep -q "a2dp"; then
   	pactl set-card-profile $bluez_card_name $BAD_PLUS_MIC
    else
	pactl set-card-profile $bluez_card_name $GOOD_AUDIO
    fi
}

#switch between audio outputs
if [[ $1 = "--toggle" ]]; then
	set_default_playback_device_next
fi

#change codecs of TWL device
if [[ $1 = "--codec" ]]; then
	set_potato_hsf  
fi

#print icon for current device 
if pactl list sinks | grep "RUNNING" -A 10| grep -q "$HEADPHONE_CARD_NAME"; then
    current_codec=$(pactl list sinks | grep "RUNNING" -A20 | grep "api.bluez5.profile")
    if echo "$current_codec" | grep -q "a2dp"; then
	CURRENT_MODE=$HEADPHONE
    else
	CURRENT_MODE=$CALLMODE
    fi
else
	CURRENT_MODE=$SPEAKER
fi

echo $CURRENT_MODE 




