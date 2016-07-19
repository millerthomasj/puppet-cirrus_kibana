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
# [* cirrus_kibana::kibana_proxy *}
#   If true use nginx to proxy connections to kibana.
#
# [* cirrus_kibana::kibana_proxy_agent *}
#   The proxy agent to use, can be either apache or nginx.
#
# [* cirrus_kibana::kibana_users *}
#   Users to allow access if proxy agent is apache.
#
# === Hiera variables
#

class cirrus_kibana (
  $kibana_version = $cirrus_kibana::params::kibana_version,
  $kibana_manage_repo = $cirrus_kibana::params::kibana_manage_repo,
  $kibana_proxy = $cirrus_kibana::params::kibana_proxy,
  $kibana_proxy_agent = $cirrus_kibana::params::kibana_proxy_agent,
  $kibana_users = {},
) inherits cirrus_kibana::params
{
  validate_bool($kibana_proxy)

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

  if $kibana_proxy {
    if ! ($kibana_proxy_agent in [ 'apache', 'nginx' ]) {
      fail("\"${kibana_proxy_agent}\" is not a valid kibana_proxy_agent parameter.")
    }

    if $kibana_proxy_agent == 'apache' {
      validate_hash($kibana_users)

      class { '::cirrus_kibana::apache':
        vhostname => $::fqdn,
        users     => $kibana_users,
      }
    } else {
      class { '::cirrus_kibana::nginx':
        vhostname => $::fqdn,
      }
    }
  }
}
