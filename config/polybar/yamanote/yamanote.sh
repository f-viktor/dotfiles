TAG=yamanote

# define interfaces
WIFI=wlp3s0
INTERNET=eno1
PASSWORD=If_you_hav3_seen_this_1ts_probably_2_late
CONNAME=hotsp
TAG=山手線

enable_hotspot () {
	nmcli device wifi hotspot ifname $WIFI con-name $CONNAME ssid $TAG password $PASSWORD
#iw dev $WIFI interface add wlan_ap type managed addr 12:34:45:67:78:90
#ip addr add 192.168.99.1/24 dev wlan_ap
#systemctl start hostapd
#sysctl net.ipv4.ip_forward=1 -q
#iptables -t nat -A POSTROUTING -o $INTERNET -j MASQUERADE
#iptables -A FORWARD -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
#iptables -A FORWARD -i wlan_ap -o $INTERNET -j ACCEPT
#sysctl net/ipv4/ip_unprivileged_port_start=80 -q
#sysctl -w net.ipv4.conf.all.route_localnet=1 -q
##systemctl start dnsmasq   #enable this if you dont have other dns providers
}

disable_hotspot() {
	nmcli c down hotsp
#iptables -t nat -F
#iptables -t mangle -F
#iptables -F
#iptables -X
#systemctl stop hostapd
##systemctl stop dnsmasq
#sysctl net.ipv4.ip_forward=0 -q
#sysctl -w net.ipv4.conf.all.route_localnet=0 -q
#sysctl net/ipv4/ip_unprivileged_port_start=1024 -q
#iw dev wlan_ap del
}

# decide whether the hotspot is working based on whether hostapd is running
if nmcli con show --active | grep -q "$CONNAME"; then
	if [[ $1 = "--toggle" ]]; then
		disable_hotspot
	fi
	echo %{F\#ffb000}$TAG%{F-} 
else
	if [[ $1 = "--toggle" ]]; then
		enable_hotspot
	fi
	echo $TAG
fi




