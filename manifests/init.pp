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
  $kibana_version        = $cirrus_kibana::params::kibana_version,
  $kibana_manage_repo    = $cirrus_kibana::params::kibana_manage_repo,
  $kibana_proxy          = $cirrus_kibana::params::kibana_proxy,
  $kibana_proxy_agent    = $cirrus_kibana::params::kibana_proxy_agent,
  $kibana_users          = {},
  $kibana_import_dir     = $cirrus_kibana::params::kibana_import_dir,
  $kibana_ssl_cert       = undef,
  $kibana_ssl_key        = undef,
  $ssl_cert_path         = $cirrus_kibana::params::ssl_cert_path,
  $use_ssl               = false,
  $validate_ssl          = true,
  $shield_encryption_key = $cirrus_kibana::params::shield_encryption_key,
) inherits cirrus_kibana::params
{
  validate_bool($kibana_proxy)

  include ::cirrus::repo::kibana

  if $::cirrus_elasticsearch::xpack_install {
    class { '::cirrus_kibana::ssl':
      ssl_cert_path => $ssl_cert_path,
      ssl_cert      => $kibana_ssl_cert,
      ssl_key       => $kibana_ssl_key,
      require       => Class['kibana4'],
    }

    $_config = {
      'elasticsearch.username' => $::cirrus_elasticsearch::xpack::users::kibana_username,
      'elasticsearch.password' => $::cirrus_elasticsearch::xpack::users::kibana_password,
      'shield.encryptionKey'   => $shield_encryption_key,
      'server.ssl.cert'        => "${ssl_cert_path}/${::fqdn}.pem",
      'server.ssl.key'         => "${ssl_cert_path}/keys/${::fqdn}.pem",
    }
    kibana4::plugin { "kibana/shield/${::elasticsearch_9200_version}":
      ensure          => present,
      plugin_dest_dir => 'shield',
      require         => Class['kibana4'],
    }
    kibana4::plugin { 'marvel':
      ensure          => present,
      plugin_dest_dir => 'marvel',
      url             => 'https://download.elasticsearch.org/elasticsearch/marvel/marvel-2.3.3.tar.gz',
      require         => Class['kibana4'],
    }
    kibana4::plugin { "elasticsearch/graph/${::elasticsearch_9200_version}":
      ensure          => present,
      plugin_dest_dir => 'graph',
      require         => Class['kibana4'],
    }
  } else {
    $_config = {}
  }

  class { '::kibana4':
    version     => $kibana_version,
    manage_repo => $kibana_manage_repo,
    config      => $_config,
    require     => Class['elasticsearch'],
  } -> class { '::cirrus_kibana::config':
    import_dir => $kibana_import_dir
  }

  kibana4::plugin { 'elastic/sense':
    ensure          => present,
    plugin_dest_dir => 'sense',
    require         => Class['kibana4'],
  }

  if $kibana_proxy {
    if ! ($kibana_proxy_agent in [ 'apache', 'nginx' ]) {
      fail("\"${kibana_proxy_agent}\" is not a valid kibana_proxy_agent parameter.")
    }

    if $kibana_proxy_agent == 'apache' {
      validate_hash($kibana_users)

      if $::cirrus_elasticsearch::xpack_install {
        class { '::cirrus_kibana::apache':
          vhostname => $::fqdn,
          users     => {},
        }
      } else {
        class { '::cirrus_kibana::apache':
          vhostname => $::fqdn,
          users     => $kibana_users,
        }
      }
    } else {
      class { '::cirrus_kibana::nginx':
        vhostname => $::fqdn,
      }
    }
  }

  if $::cirrus_elasticsearch::xpack_install {
    $use_login = true
    $elastic_username = $::cirrus_elasticsearch::xpack::users::kibana_username
    $elastic_password = $::cirrus_elasticsearch::xpack::users::kibana_password
  } else {
    $elastic_username   = undef
    $elastic_password   = undef
  }

  # Setup SSL authentication args for use in any type that hits an api
  if $use_ssl {
    validate_string($elastic_username)
    validate_string($elastic_password)
    $protocol = 'https'
    if $validate_ssl {
      $curl_args = "-u '${elastic_username}':'${elastic_password}'"
    } else {
      $curl_args = "-k -u '${elastic_username}':'${elastic_password}'"
    }
  } elsif $use_login {
    validate_string($elastic_username)
    validate_string($elastic_password)
    $protocol = 'http'
    $curl_args = "-u '${elastic_username}':'${elastic_password}'"
  } else {
    $protocol = 'http'
    # lint:ignore:empty_string_assignment
    $curl_args = ''
    # lint:endignore
  }

  if $::elasticsearch_9200_name {
    include ::cirrus_kibana::search
    include ::cirrus_kibana::visualization
    include ::cirrus_kibana::dashboard
  }
}
