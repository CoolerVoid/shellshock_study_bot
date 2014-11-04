#!/usr/bin/perl    
# simple tcp server by Cooler_
 use Socket;

 $server_port="41038";
 print "\nStart TCP Listening server\n";
 socket(SERVER, PF_INET, SOCK_STREAM, getprotobyname('tcp'));
 setsockopt(SERVER, SOL_SOCKET, SO_REUSEADDR, 1);
 $my_addr = sockaddr_in($server_port, INADDR_ANY);
 bind(SERVER, $my_addr) or die "Couldn't bind to port $server_port : $!\n";
 listen(SERVER, SOMAXCONN) or die "Couldn't listen on port $server_port : $!\n";

 while (accept(CLIENT, SERVER)) 
 {
	$other_end        = getpeername(CLIENT) or die "Couldn't identify other end: $!\n";
	($port, $iaddr)   = unpack_sockaddr_in($other_end);
	$actual_ip        = inet_ntoa($iaddr);
	print "IP : $actual_ip\n";
 }

 close(SERVER);                                                                                    
