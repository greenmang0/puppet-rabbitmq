# Class: rabbitmq::params
#
# This class manages RabbitMQ parameters
#
# Parameters:
# - The RabbitMQ Debian/Ubuntu $repository to use
# - The RabbitMQ Debian/Ubuntu $package to use
#
# Sample Usage:
#  include rabbitmq::params
#
class rabbitmq::params {
        $repository = "deb http://www.rabbitmq.com/debian/ testing main"
        $package = "rabbitmq-server"
	$path = "/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin"
}

