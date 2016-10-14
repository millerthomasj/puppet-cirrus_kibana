# == Class: kibana4::ssl
#
# Default parameters
#

class cirrus_kibana::ssl(
  $ssl_cert_path,
  $ssl_cert,
  $ssl_key,
)
{
  file { $ssl_cert_path:
    ensure  => 'directory',
    owner   => 'kibana',
    group   => 'kibana',
    mode    => '0755',
    require => Class['kibana4'],
  }

  file { "${ssl_cert_path}/keys":
    ensure  => 'directory',
    owner   => 'kibana',
    group   => 'kibana',
    mode    => '0750',
    require => Class['kibana4'],
  }

  if $ssl_cert {
    file { "${ssl_cert_path}/${::fqdn}.pem":
      ensure  => 'file',
      content => $ssl_cert,
      owner   => 'kibana',
      group   => 'kibana',
      mode    => '0644',
      require => File[$ssl_cert_path],
    }

    file { "${ssl_cert_path}/keys/${::fqdn}.pem":
      ensure  => 'file',
      content => $ssl_key,
      owner   => 'kibana',
      group   => 'kibana',
      mode    => '0640',
      require => File["${ssl_cert_path}/keys"],
    }
  } else {
      exec {'create_self_signed_sslcert':
      command => "openssl req -newkey rsa:2048 -nodes -keyout ${ssl_cert_path}/keys/${::fqdn}.pem  -x509 -days 365 -out ${ssl_cert_path}/${::fqdn}.pem -subj '/CN=${::fqdn}'",
      cwd     => $ssl_cert_path,
      creates => [ "${ssl_cert_path}/keys/${::fqdn}.pem", "${ssl_cert_path}/${::fqdn}.pem", ],
      path    => ['/usr/bin', '/usr/sbin'],
      require => [ File[$ssl_cert_path], File["${ssl_cert_path}/keys"] ],
    }
  }
}
