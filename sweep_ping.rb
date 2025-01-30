#!/usr/bin/env ruby

require 'socket'
require 'timeout'

# Get the current IP address and subnet
ip = Socket.ip_address_list.detect(&:ipv4_private?).ip_address
subnet = ip.split('.')[0..2].join('.')

puts "Scanning subnet #{subnet}.0/24"

(1..254).each do |i|
  ip_address = "#{subnet}.#{i}"
  begin
    Timeout.timeout(1) do
      socket = TCPSocket.new(ip_address, 80)
      socket.close
      puts "#{ip_address} is up"
    end
  rescue Timeout::Error, Errno::ECONNREFUSED, Errno::EHOSTUNREACH
    # Ignore unreachable or unresponsive hosts
  end
end
