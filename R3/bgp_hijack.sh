#!/bin/bash

vtysh -c "config t" \
-c "ip prefix-list leak permit 172.20.0.0/24" \
-c "router bgp 65533" \
-c "neighbor 172.18.0.2 route-map no_export_map out" \
-c "neighbor 172.18.0.3 route-map filter_map out" \
-c "network 172.20.0.0/24" \
-c "quit" \
-c "route-map no_export_map permit 10" \
-c "match ip address prefix-list leak" \
-c "set community no-export" \
-c "quit" \
-c "route-map filter_map deny 10" \
-c "match ip address prefix-list leak" \
-c "end"
