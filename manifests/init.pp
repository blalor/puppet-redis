# Class: redis
#
# This class installs redis.  There's a vestigial config file that does nothing
# beyond the (Ubuntu) defaults except enable binding to all interfaces.
#
# Parameters:
#    None
#
# Actions:
#    None
#
# Requires:
#    None
#
# Sample Usage:
#
#    include redis
class redis {

    package {'redis-server': }

    file {'/etc/redis/redis.conf':
        content => template('redis/redis.conf.erb'),
        mode    => '0444',
        notify  => Service['redis-server'],
    }

    service {'redis-server':
        ensure  => running,
        enable  => true,
        require => [
            Package['redis-server'],
            File['/etc/redis/redis.conf']
        ],
    }
}
