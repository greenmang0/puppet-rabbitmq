# Class: rabbitmq
#
# This class installs rabbitmq stable
#
# Notes:
#  This class is Ubuntu specific.  
#
# Actions:
#  - Install RabbitMQ using a RabbitMQ Debian/Ubuntu Repository
#  - Manage the RabbitMQ service  
#
# Sample Usage:
#  include rabbitmq
#
class rabbitmq {

        include rabbitmq::params

	Exec {
	    path => "${rabbitmq::params::path}"
	}

        package { "python-software-properties":
                ensure => installed,
        }

        exec { "rabbitmq-apt-repo":
                command => "apt-add-repository '${rabbitmq::params::repository}'",
                unless => "cat /etc/apt/sources.list | grep rabbitmq",
                require => Package["python-software-properties"],
        }

        exec { "rabbitmq-apt-key":
                command => "wget http://www.rabbitmq.com/rabbitmq-signing-key-public.asc -P /tmp/ && apt-key add /tmp/rabbitmq-signing-key-public.asc",
                unless => "apt-key list | grep -i rabbitmq",
                require => Exec["rabbitmq-apt-repo"],
        }

        exec { "update-apt":
                command => "apt-get update",
                require => Exec["rabbitmq-apt-key"],
        }

        package { $rabbitmq::params::package:
                ensure => installed,
                require => Exec["update-apt"],
        }

	exec { "enable-mgmt-plugin":
		command => "rabbitmq-plugins enable rabbitmq_management",
                require => Package[$rabbitmq::params::package],
	}

        service { "rabbitmq-server":
		restart => "service rabbitmq-server restart",
                enable => true,
                ensure => running,
                require => Exec["enable-mgmt-plugin"],
        }
}

