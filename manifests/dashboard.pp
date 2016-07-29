class cirrus_kibana::dashboard
{
  cirrus_kibana::import { 'all_errors':
    content => 'all_errors.json.erb',
    type    => 'dashboard',
  }
  cirrus_kibana::import { 'all_warnings':
    content => 'all_warnings.json.erb',
    type    => 'dashboard',
  }
}