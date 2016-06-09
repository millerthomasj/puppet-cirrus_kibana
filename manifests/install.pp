class twc_kibana::install ()
{
  class { 'apache':
    default_vhost => false,
  }

  class { '::kibana':
    bind => $::ipaddress,
  }
}
