# == Class: kibana4::params
#
# Default parameters
#

class cirrus_kibana::params
{
  $kibana_version = '4.5.4'
  $kibana_manage_repo = false
  $kibana_proxy = true
  $kibana_proxy_agent = apache
  $kibana_import_dir = '/opt/kibana/importJSON'
}
