class php{

	package {"php5" :
		ensure => installed,
	}

	package {"php5-cli" :
		ensure => installed,
	}

	package {"php5-xdebug" :
		ensure => installed,
	}
	
	package {"php-apc" :
		ensure => installed,
		require => Package["php5"],
		notify => Exec["apc-rfc1867"]
	}
	
	Exec {"apc-rfc1867" :
		command => "echo 'apc.rfc1867 = 1' >> /etc/php5/conf.d/apc.ini"
		unless => "cat /etc/php5/conf.d/apc.ini | grep -e 'apc.rfc1867 \?= \?1'";
		notify => Service["apache2"]
	}

	package {"libapache2-mod-php5" :
		ensure => installed,
		require => Package["php5"]
	}
}