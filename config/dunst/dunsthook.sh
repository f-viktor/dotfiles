# This script serves as a hook to extend dunst with bash
# it expects to get a low or normal urgency level notification
# and after modification it sends a critical urgency level notif

# dedicated to rice-senpai

# it takes away the option of having low and normal level notifs
# as you are expected to have something like this in your dunstrc

#[spacing_hook_normal]    
#   msg_urgency = normal    
#   script = ~/.config/dunst/dunsthook.sh    
#    
#[hide_normal]     
#   msg_urgency = normal    
#   skip_display = yes    
#    
#[spacing_hook_low]    
#   msg_urgency = low    
#   script = ~/.config/dunst/dunsthook.sh    
#    
#[hide_low]       
#   msg_urgency = low    
#   skip_display = yes 

# get the args from dunst
APPNAME=$1
SUMMARY=$2
BODY=$3
ICON=$4
URGENCY=$5

# modify the entries you wish to #

# if folding messes up sometimes adjust this param
FOLDLENGTH=30

# set up custom folding and spacing
BODY=$(fold -w $FOLDLENGTH -s <<< "$BODY")
BODY=$(sed 's/^/   /g' <<< $BODY)

# also fold the summary just in case
SUMMARY=$(fold -w $FOLDLENGTH -s <<< "$SUMMARY" )
SUMMARY=$(sed 's/^/  /g' <<< $SUMMARY)

echo "1 $1 2 $2 3 $3 4 $4 5 $5 6 $6 7 $7" >> ~/dust
# send the modified notif as a critical alert to avoid looping
notify-send -i "$ICON" -a "$APPNAME" -u critical "$SUMMARY" "$BODY"
