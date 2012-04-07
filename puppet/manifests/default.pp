
# Have sshd listen on normal port + two used for testing firewall rules
$sshd_ports = [22,2200,2201]
include sshd


iptables { "DNS UDP": proto => "udp", sport => "53", jump => "ACCEPT", }
iptables { "DNS TCP": proto => "tcp", sport => "53", jump => "ACCEPT", }

iptables { "allow for integration testing":
  proto       => "tcp",
  dport       => "2200",
  jump        => "ACCEPT",
}

#iptables { "Drop by default INPUT": jump => "REJECT" }
#iptables { "Drop by default FORWARD": chain => "FORWARD", jump => "REJECT" }

file { "/etc/puppet":
  ensure => directory,
  owner => root,
  group => root,
  mode => 700,
}
file { "/etc/puppet/iptables":
  ensure => directory,
  owner => root,
  group => root,
  mode => 700,
}

file { "/etc/puppet/iptables/pre.iptables":
  content => "-A INPUT -p tcp -m tcp --dport 22 -j ACCEPT",
  mode    => 0600,
}

file { "/etc/puppet/iptables/post.iptables":
  content => "-A INPUT -j REJECT --reject-with icmp-port-unreachable",
  mode    => 0600,
}
