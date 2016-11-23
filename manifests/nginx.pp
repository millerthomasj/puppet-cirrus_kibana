# == Class: kibana4::nginx
#
# Default parameters
#

class cirrus_kibana::nginx(
  $vhostname
)
{
  include ::nginx

  nginx::resource::vhost { $vhostname:
    proxy   => 'http://kibana4',
    require => Class[::nginx::config],
  }

  nginx::resource::upstream { 'kibana4':
    members => [ 'localhost:5601' ],
    require => Class[::nginx::config],
  }
}
