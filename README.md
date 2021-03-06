# BGP Hijack Lab

This is a virtual BGP environment which can be used to simulate BGP hijack attacks. The lab is made up of three containers running Quagga which serve as eBGP routers and two Debian containers which represent end users. The network layout can be seen in [architecture.png](architecture.png). The lab is configured so that PC1 is sending a UDP packet on port 4445 to PC2 every minute. The goal of this lab is to show how R3, a BGP neighbor of R1 and R2, is able to intercept traffic between R1 and R2 using a BGP hijack attack.

## Prerequisites

* docker
* docker-compose

## Running the lab

To start the lab simply bring docker-compose up in the directory with docker-compose.yml:

```
docker-compose up -d
```

## Using the lab

The containers can be accessed using shell:

```
docker exec -it R1 sh
docker exec -it PC1 sh
```

Both R3 and PC2 are capturing UDP 44445 traffic in /root/:

```
root@PC2:/# tail -f /root/dump_u44445
17:15:01.450320 IP 172.19.0.3.42150 > PC2.44445: UDP, length 7
	0x0000:  4500 0023 5188 4000 3e11 9314 ac13 0003  E..#Q.@.>.......
	0x0010:  ac14 0003 a4a6 ad9d 000f 584e 6361 7466  ..........XNcatf
	0x0020:  6f6f 64                                  ood
```

A shell script has been provided on R3 to hijack the BGP route:
```
root@R3:/# sh /root/bgp_hijack.sh
root@R3:/# tail -f /root/dump_u44445 
17:17:01.488774 IP 172.19.0.3.47626 > 172.20.0.3.44445: UDP, length 7
	0x0000:  4500 0023 5d37 4000 3f11 8665 ac13 0003  E..#]7@.?..e....
	0x0010:  ac14 0003 ba0a ad9d 000f 584e 6361 7466  ..........XNcatf
	0x0020:  6f6f 64                                  ood
```

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details