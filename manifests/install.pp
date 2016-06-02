class twc-kibana ()
{
  class { 'apache':
    default_vhost => false,
  }

  include kibana3
  include twc-elasticsearch::client
}
