class sshd {
	case $operatingsystem {
		'Ubuntu': { 
			$sshservice = 'ssh'
		}
		default: { 
			$sshservice = 'sshd'
		}
	}

	package { "openssh-server":
		ensure => installed,
		alias => sshd
	}
	service { $sshservice:
		ensure => running,
		pattern => "/usr/sbin/sshd",
		require => Package["sshd"],
		alias => sshd,
	}

	file { "/etc/ssh/sshd_config":
		path    => "/etc/ssh/sshd_config",
		owner   => root,
		group   => root,
		mode    => 400,
		content => template("sshd/sshd_config.erb"),
		notify  => Service[sshd],
	}
}
