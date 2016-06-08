class twc_kibana::install ()
{
  class { 'apache':
    default_vhost => false,
  }

  include kibana3
}
