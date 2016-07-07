# == Class cirrus_kibana
#
# Includes the kibana class from the lesaux/puppet-kibana4 module.
#
# === Variables
#
# [* cirrus_kibana::kibana_version *]
#   What version of kibana to install.
#
# [* cirrus_kibana::kibana_manage_repo *]
#   We install from blobmirror so this should always be false.
#
# === Hiera variables
#

class cirrus_kibana (
  $kibana_version = $cirrus_kibana::params::kibana_version,
  $kibana_manage_repo = $cirrus_kibana::params::kibana_manage_repo,
) inherits cirrus_kibana::params
{
  include ::cirrus::repo::kibana

  class { '::kibana4':
    version     => $kibana_version,
    manage_repo => $kibana_manage_repo,
    plugins     => {
      'elastic/sense' => {
        ensure          => present, # lint:ignore:ensure_first_param
        plugin_dest_dir => 'sense',
      }
    }
  }
}
