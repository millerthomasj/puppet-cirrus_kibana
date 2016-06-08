class twc_kibana ()
{
  class { 'apache':
    default_vhost => false,
  }

  include kibana3
}
