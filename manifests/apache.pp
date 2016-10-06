# == Class: kibana4::apache
#
# Default parameters
#

class cirrus_kibana::apache(
  $vhostname,
  $users
)
{
  class { '::apache':
    default_vhost => false,
  }

  if $users.empty() {
    apache::vhost { $vhostname:
      docroot             => '/opt/kibana',
      manage_docroot      => false,
      port                => 80,
      proxy_preserve_host => true,
      proxy_pass          => [
        {
          path => '/',
          url  => 'http://localhost:5601/',
        }
      ],
      require             => File[$user_file],
    }
  } else {
    $user_file = '/opt/kibana/usersdb'

    $htpasswd_defaults = {
      target      => $user_file,
      require     => Package['apache2'],
      notify      => [ Service['apache2'], File[$user_file] ],
    }

    create_resources(htpasswd, $users, $htpasswd_defaults)

    file { $user_file:
      owner => 'root',
      mode  => '0644',
    }

    apache::vhost { $vhostname:
      docroot             => '/opt/kibana',
      manage_docroot      => false,
      port                => 80,
      proxy_preserve_host => true,
      proxy_pass          => [
        {
          path => '/',
          url  => 'http://localhost:5601/',
        }
      ],
      directories         => [
        {
          path                => '/',
          provider            => 'location',
          auth_type           => 'Basic',
          auth_name           => 'Kibana Login',
          auth_basic_provider => 'file',
          auth_user_file      => $user_file,
          auth_require        => 'valid-user',
        }
      ],
      require             => File[$user_file],
    }
  }
}
