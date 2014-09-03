#!/bin/awk -f
#
# check the sulog for failures..
# copyright 2001 (c) jose nazario
#
# works for Solaris, IRIX and HPUX 10.20
BEGIN {
	print "--- checking sulog"
		openconnections=0
}
{
	if ($3=="end" && $4=="connection") {
		openconnections=openconnections-1
			ip = $5
			if(ips_map[ip] != ""){
				ips_map[ip]=""
			}
	}
	if ($3=="connection" && $4=="accepted") {
		openconnections=openconnections+1
			ip = $6
			if(ips_map[ip] == ""){
				ips_map[ip]=ip
			}
	}
}
END {
	print "---------------------------------------"
	printf("\ttotal number of open connections 's:\t%d\n",openconnections)
		print("still open on: ")
		for(x in ips_map){
			if(ips_map[x] != ""){
				print(ips_map[x])
			}}
	printf("\ttotal number of open connections 's:\t%d\n",openconnections)
}
