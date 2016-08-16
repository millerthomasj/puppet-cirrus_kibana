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
  $ensure   = 'present',
  $content  = undef,
  $host     = 'localhost',
  $port     = 9200,
  $protocol = $::cirrus_kibana::protocol,
  $ssl_args = $::cirrus_kibana::ssl_args,
  $type     = undef
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

  if ($ensure == 'present') {
    if $content == undef {
      fail("The variable 'content' cannot be empty when inserting or updating a ${type}.")
    } else { # we are good to go. notify to insert in case we deleted
      $insert_notify = Exec[ "insert_${type}_${name}" ]
    }
  } else {
    $insert_notify = undef
  }

  # Delete the existing item
  # First check if it exists of course
  exec { "delete_${type}_${name}":
    command     => "curl ${ssl_args} -s -XDELETE ${es_url}",
    onlyif      => "test $(curl ${ssl_args} -s '${es_url}?pretty=true' | grep -c '\"found\" : true') -eq 1",
    notify      => $insert_notify,
    refreshonly => true,
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
      notify  => Exec[ "delete_${type}_${name}" ],
    }

    exec { "insert_${type}_${name}":
      command     => "curl ${ssl_args} -sL -w \"%{http_code}\\n\" -XPUT ${es_url} -d @${cirrus_kibana::params::kibana_import_dir}/${type}/${name}.json -o /dev/null | egrep \"(200|201)\" > /dev/null",
      unless      => "test $(curl ${ssl_args} -s '${es_url}?pretty=true' | grep -c '\"found\" : true') -eq 1",
      refreshonly => true,
    }
  }
}
