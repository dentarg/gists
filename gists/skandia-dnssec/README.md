```
$ dig www.skandia.se                                                                                                                                                     dentarg@p ~

; <<>> DiG 9.9.5 <<>> www.skandia.se
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: SERVFAIL, id: 19379
;; flags: qr rd ra; QUERY: 1, ANSWER: 0, AUTHORITY: 0, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 4096
;; QUESTION SECTION:
;www.skandia.se.			IN	A

;; Query time: 0 msec
;; SERVER: 172.20.20.1#53(172.20.20.1)
;; WHEN: Tue Jan 03 23:15:57 CET 2017
;; MSG SIZE  rcvd: 43
```

```
$ dig +trace www.skandia.se                                                                                                                                              dentarg@p ~

; <<>> DiG 9.9.5 <<>> +trace www.skandia.se
;; global options: +cmd
.			133439	IN	NS	k.root-servers.net.
.			133439	IN	NS	l.root-servers.net.
.			133439	IN	NS	j.root-servers.net.
.			133439	IN	NS	d.root-servers.net.
.			133439	IN	NS	e.root-servers.net.
.			133439	IN	NS	m.root-servers.net.
.			133439	IN	NS	i.root-servers.net.
.			133439	IN	NS	a.root-servers.net.
.			133439	IN	NS	c.root-servers.net.
.			133439	IN	NS	g.root-servers.net.
.			133439	IN	NS	b.root-servers.net.
.			133439	IN	NS	h.root-servers.net.
.			133439	IN	NS	f.root-servers.net.
;; Received 811 bytes from 172.20.20.1#53(172.20.20.1) in 518 ms

se.			172800	IN	NS	i.ns.se.
se.			172800	IN	NS	a.ns.se.
se.			172800	IN	NS	c.ns.se.
se.			172800	IN	NS	f.ns.se.
se.			172800	IN	NS	b.ns.se.
se.			172800	IN	NS	g.ns.se.
se.			172800	IN	NS	j.ns.se.
se.			172800	IN	NS	d.ns.se.
se.			172800	IN	NS	e.ns.se.
se.			86400	IN	DS	59747 5 2 44388B3DE9A22CAFA8A12883F60A0F984472D0DFEF0F63ED59A29BE0 18658B28
se.			86400	IN	RRSIG	DS 8 1 86400 20170116170000 20170103160000 61045 . WPkRJfWpKmeN/A7ICwZN5rmA9RQPviJHEwQx32HCDUGomzl47QoD3b72 suNQb1vMG9+YfeWTMToWFoX2PZkw3MrppFsVKmlbyV7ayDS9ACUvud3P bZAxLzWrR6JNIsmUssTMYBHfg6fOYwqGKPCZ2phAif3f3+RN3F5zBKt7 N9M1vSjHRewxqQaPtPvxmPCXIDAam/yUxhaVtoeGMn1nqBR/8K09+WZI eKacORXI/0d7y2MDc16CbnkTSdXR0/TarAF6oggIavhQEm30Jx7kUNp0 R97iWcQrjT8NFnUAPnLNOLpj4r9vPwPkCxBfQAIfvI8WrSEvin1dGpoS oyh+Rw==
;; Received 865 bytes from 192.228.79.201#53(b.root-servers.net) in 337 ms

skandia.se.		86400	IN	NS	ns2.domainnetwork.se.
skandia.se.		86400	IN	NS	ns.domainnetwork.se.
skandia.se.		7200	IN	NSEC	skandia-brf.se. NS RRSIG NSEC
skandia.se.		7200	IN	RRSIG	NSEC 5 2 7200 20170116033608 20170102081001 53395 se. B/lD2Gqg9FYx7p4LZtDqIhbGKmok+5xPmvX2bBPffl7vnKTFpZdoZ1SN dqk86VXpo9IyEccs/f2XxPEJ407IAMTfX4lO1kkrjvPtBSxQdl4Py90I x+DPXvjW2Nr++zI0CUEJlcvWEWwRP4Ap9IPqfFzS736n29X63/+bJorS OkU=
;; Received 290 bytes from 192.36.133.107#53(b.ns.se) in 145 ms

www.skandia.se.		300	IN	A	194.114.243.54
skandia.se.		86400	IN	NS	ns.domainnetwork.se.
skandia.se.		86400	IN	NS	ns2.domainnetwork.se.
;; Received 108 bytes from 209.112.113.33#53(ns.domainnetwork.se) in 30 ms
```

1 minute later

```
$ dig +trace www.skandia.se

; <<>> DiG 9.8.3-P1 <<>> +trace www.skandia.se
;; global options: +cmd
.			133285	IN	NS	a.root-servers.net.
.			133285	IN	NS	m.root-servers.net.
.			133285	IN	NS	c.root-servers.net.
.			133285	IN	NS	i.root-servers.net.
.			133285	IN	NS	f.root-servers.net.
.			133285	IN	NS	k.root-servers.net.
.			133285	IN	NS	h.root-servers.net.
.			133285	IN	NS	l.root-servers.net.
.			133285	IN	NS	j.root-servers.net.
.			133285	IN	NS	b.root-servers.net.
.			133285	IN	NS	d.root-servers.net.
.			133285	IN	NS	g.root-servers.net.
.			133285	IN	NS	e.root-servers.net.
;; Received 508 bytes from 172.20.20.1#53(172.20.20.1) in 78 ms

se.			172800	IN	NS	j.ns.se.
se.			172800	IN	NS	b.ns.se.
se.			172800	IN	NS	f.ns.se.
se.			172800	IN	NS	e.ns.se.
se.			172800	IN	NS	i.ns.se.
se.			172800	IN	NS	g.ns.se.
se.			172800	IN	NS	a.ns.se.
se.			172800	IN	NS	d.ns.se.
se.			172800	IN	NS	c.ns.se.
;; Received 491 bytes from 192.36.148.17#53(192.36.148.17) in 28 ms

skandia.se.		86400	IN	NS	ns.domainnetwork.se.
skandia.se.		86400	IN	NS	ns2.domainnetwork.se.
;; Received 81 bytes from 81.228.10.57#53(81.228.10.57) in 17 ms

www.skandia.se.		300	IN	A	194.114.243.54
skandia.se.		86400	IN	NS	ns.domainnetwork.se.
skandia.se.		86400	IN	NS	ns2.domainnetwork.se.
;; Received 97 bytes from 209.112.113.33#53(209.112.113.33) in 30 ms
```
