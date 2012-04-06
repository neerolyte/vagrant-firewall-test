iptables { "001 allow icmp":
  proto => "icmp",
  icmp  => "any",
  jump  => "ACCEPT",
}
iptables { "another iptables rule":
  proto       => "tcp",
  dport       => "80",
  source      => "192.168.0.0/16",
  destination => "192.168.1.11/32",
  jump        => "ACCEPT",
}

iptables { "DNS":
  proto       => "all",
  dport       => "53",
  jump        => "ACCEPT",
}

iptables { "my iptables rule":
  proto       => "tcp",
  dport       => "80",
  jump        => "DROP",
}

file { "/etc/puppet/iptables/pre.iptables":
  content => "-A INPUT -p tcp -m tcp --dport 22 -j ACCEPT",
  mode    => 0600,
}
file { "/etc/puppet/iptables/post.iptables":
  content => "-A INPUT -j REJECT --reject-with icmp-port-unreachable",
  mode    => 0600,
}