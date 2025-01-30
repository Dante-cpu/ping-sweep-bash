#!/usr/bin/perl

use strict;
use warnings;
use Net::Ping;

# Get the current IP address and subnet
my $ip = `ip route get 1 | awk '{print \$7;exit}'`;
chomp $ip;
my $subnet = join ".", (split /\./, $ip)[0..2];

print "Scanning subnet $subnet.0/24\n";

my $ping = Net::Ping->new("icmp");

foreach my $i (1..254) {
    my $host = "$subnet.$i";
    if ($ping->ping($host, 1)) {
        print "$host is up\n";
    }
}

$ping->close();
