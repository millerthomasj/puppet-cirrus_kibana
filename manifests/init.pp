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
# [* cirrus_kibana::kibana_import_dir *}
#   Where json files will be stored for imports.
#
# === Hiera variables
#

class cirrus_kibana (
  $kibana_version     = $cirrus_kibana::params::kibana_version,
  $kibana_manage_repo = $cirrus_kibana::params::kibana_manage_repo,
  $kibana_proxy       = $cirrus_kibana::params::kibana_proxy,
  $kibana_proxy_agent = $cirrus_kibana::params::kibana_proxy_agent,
  $kibana_users       = {},
  $kibana_import_dir  = $cirrus_kibana::params::kibana_import_dir,
  $use_ssl            = false,
  $validate_ssl       = true,
  $ssl_user           = undef,
  $ssl_password       = undef
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
  } -> class { '::cirrus_kibana::config':
    import_dir => $kibana_import_dir
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

  # Setup SSL authentication args for use in any type that hits an api
  if $use_ssl {
    validate_string($ssl_user)
    validate_string($ssl_password)
    $protocol = 'https'
    if $validate_ssl {
      $ssl_args = "-u ${ssl_user}:${ssl_password}"
    } else {
      $ssl_args = "-k -u ${ssl_user}:${ssl_password}"
    }
  } else {
    $protocol = 'http'
    # lint:ignore:empty_string_assignment
    $ssl_args = ''
    # lint:endignore
  }

  if $::elasticsearch_9200_cluster_status == 'green' {
    include ::cirrus_kibana::search
    include ::cirrus_kibana::visualization
    include ::cirrus_kibana::dashboard
  }
}
