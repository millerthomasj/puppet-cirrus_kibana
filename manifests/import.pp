# == Define: cirrus_kibana::import
#
#  This define allows you to insert, update or delete kibana searches.
#
# === Parameters
#
# [*ensure*]
#   String. Controls if the managed resources shall be <tt>present</tt> or
#   <tt>absent</tt>. If set to <tt>absent</tt>:
#
# [*content*]
#   Contents of the template ( json )
#   Value type is string
#   Default value: undef
#   This variable is optional
#
# [*host*]
#   Host name or IP address of the ES instance to connect to
#   Value type is string
#   Default value: localhost
#   This variable is optional
#
# [*port*]
#   Port number of the ES instance to connect to
#   Value type is number
#   Default value: 9200
#   This variable is optional
#
# [*protocol*]
#   Defines the protocol to use for api calls using curl
#   Default value from main class is: http
#
# [*ssl_args*]
#   SSL arguments for curl commands.
#   Default value from main class is an empty string.
#

define cirrus_kibana::import(
  $ensure    = 'present',
  $content   = undef,
  $host      = 'localhost',
  $port      = 9200,
  $protocol  = $::cirrus_kibana::protocol,
  $curl_args = $::cirrus_kibana::curl_args,
  $type      = undef
) {
  require ::elasticsearch

  # ensure
  if ! ($ensure in [ 'present', 'absent' ]) {
    fail("\"${ensure}\" is not a valid ensure parameter value")
  }

  if ! is_integer($port) {
    fail("\"${port}\" is not an integer")
  }

  if ! ($type in [ 'search', 'visualization', 'dashboard', 'config' ]) {
    fail("\"${type}\" is not a valid type parameter value")
  }

  Exec {
    path      => [ '/bin', '/usr/bin', '/usr/local/bin' ],
    cwd       => '/',
    tries     => 6,
    try_sleep => 10,
  }

  # Build up the url
  $es_url = "${protocol}://${host}:${port}/.kibana/${type}/${name}"

  # Delete the existing item
  exec { "delete_${type}_${name}":
    command => "curl ${curl_args} -s -XDELETE ${es_url}",
    onlyif  => "test $(curl ${curl_args} -s '${es_url}?pretty=true' | grep -c '\"found\" : true') -eq 1",
  }

  if ($ensure == 'absent') {
    # delete the template file on disk and then on the server
    file { "${cirrus_kibana::params::kibana_import_dir}/${type}/${name}.json":
      ensure => 'absent',
      notify => Exec[ "delete_${type}_${name}" ],
    }
  }

  if ($ensure == 'present') {
    # place the template file using content
    file { "${cirrus_kibana::params::kibana_import_dir}/${type}/${name}.json":
      ensure  => file,
      content => template("${module_name}/${type}/${content}"),
    }

    exec { "insert_${type}_${name}":
      command     => "curl ${curl_args} -sL -w \"%{http_code}\\n\" -XPUT ${es_url} -d @${cirrus_kibana::params::kibana_import_dir}/${type}/${name}.json -o /dev/null | egrep \"(200|201)\" > /dev/null",
    }
  }

  File["${cirrus_kibana::params::kibana_import_dir}/${type}/${name}.json"] -> Exec["delete_${type}_${name}"] -> Exec["insert_${type}_${name}"]
}
