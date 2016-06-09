class twc_kibana::install ()
{
  class { '::kibana':
    es_url => "http://${::ipaddress}:9200",
  }
}
