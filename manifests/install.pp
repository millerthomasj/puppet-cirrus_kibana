class cirrus_kibana::install ()
{
  class { '::kibana':
    version => '4.5.1',
    es_url  => "http://${::ipaddress}:9200",
  }
}
