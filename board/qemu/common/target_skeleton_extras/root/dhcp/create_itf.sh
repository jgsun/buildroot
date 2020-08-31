#!/bin/sh
echo 1 > /proc/sys/net/ipv4/ip_forward

ip link add host_s_veth type veth peer name s_veth
ip link add host_c1_veth type veth peer name c1_veth
ip link add host_c2_veth type veth peer name c2_veth
ip link add host_r_veth type veth peer name r_veth

ip netns add s_ns
ip netns add r_ns
ip netns add c1_ns
ip netns add c2_ns

ip link set s_veth netns s_ns
ip link set r_veth netns r_ns
ip link set c1_veth netns c1_ns
ip link set c2_veth netns c2_ns

ip link set host_s_veth up
ip link set host_c1_veth up
ip link set host_c2_veth up
ip link set host_r_veth up

ip netns exec s_ns ip link set s_veth up
ip netns exec r_ns ip link set r_veth up
ip netns exec c1_ns ip link set c1_veth up
ip netns exec c2_ns ip link set c2_veth up

ip link add name br0 type bridge
ip link set br0 up
ip addr add 10.254.239.1/24 dev br0 
ip link set dev host_c1_veth master br0
ip link set dev host_c2_veth master br0
ip link set dev host_r_veth master br0

ip addr add 10.254.236.1/24 dev host_s_veth

ip netns exec s_ns ip addr add 10.254.236.2/24 dev s_veth
ip netns exec s_ns route add -net 10.254.239.0 netmask 255.255.255.0 dev s_veth
ip netns exec s_ns route add -net 10.254.239.0 netmask 255.255.255.0 gw 10.254.239.1 dev s_veth

ip netns exec r_ns ip addr add 10.254.239.2/24 dev r_veth
ip netns exec r_ns route add -net 10.254.236.0 netmask 255.255.255.0 dev r_veth
ip netns exec r_ns route add -net 10.254.236.0 netmask 255.255.255.0 gw 10.254.236.1 dev r_veth

# ip netns exec c1_ns ip addr add 10.254.239.41/24 dev c1_veth
ip netns exec c1_ns route add -net 10.254.236.0 netmask 255.255.255.0 dev c1_veth
ip netns exec c1_ns route add -net 10.254.236.0 netmask 255.255.255.0 gw 10.254.236.1 dev c1_veth

ip netns exec c2_ns route add -net 10.254.236.0 netmask 255.255.255.0 dev c2_veth
ip netns exec c2_ns route add -net 10.254.236.0 netmask 255.255.255.0 gw 10.254.236.1 dev c2_veth

ip netns exec s_ns /root/dhcp/S80dhcp-server start
ip netns exec r_ns /root/dhcp/S80dhcp-relay start
