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
}
