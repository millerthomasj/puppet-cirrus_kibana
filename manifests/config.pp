# == Class: cirrus_kibana::config
#
# Default parameters
#

class cirrus_kibana::config(
  $import_dir,
)
{
  file { $import_dir:
    ensure => directory,
    path   => $import_dir,
    owner  => 'kibana',
    group  => 'kibana',
    mode   => '0755'
  }

  file { "${import_dir}/search":
    ensure  => directory,
    path    => "${import_dir}/search",
    owner   => 'kibana',
    group   => 'kibana',
    mode    => '0755',
    require => File[$import_dir],
  }

  file { "${import_dir}/visualization":
    ensure  => directory,
    path    => "${import_dir}/visualization",
    owner   => 'kibana',
    group   => 'kibana',
    mode    => '0755',
    require => File[$import_dir],
  }

  file { "${import_dir}/dashboard":
    ensure  => directory,
    path    => "${import_dir}/dashboard",
    owner   => 'kibana',
    group   => 'kibana',
    mode    => '0755',
    require => File[$import_dir],
  }

  file { "${import_dir}/config":
    ensure  => directory,
    path    => "${import_dir}/config",
    owner   => 'kibana',
    group   => 'kibana',
    mode    => '0755',
    require => File[$import_dir],
  }

  cirrus_kibana::import { $cirrus_kibana::params::kibana_version: # lint:ignore:only_variable_string
    content => 'kibana-config.json.erb',
    type    => 'config',
    require => [ Es_Instance_Conn_Validator[$::cirrus_elasticsearch::es_name], File["${import_dir}/config"] ],
  }
}
