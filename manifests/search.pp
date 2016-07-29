class cirrus_kibana::search
{
  cirrus_kibana::import { 'loglevel-critical':
    content => 'loglevel-critical.json.erb',
    type    => 'search',
  }
  cirrus_kibana::import { 'loglevel-warning':
    content => 'loglevel-warning.json.erb',
    type    => 'search',
  }
  cirrus_kibana::import { 'loglevel-warning_or_critical':
    content => 'loglevel-warning_or_critical.json.erb',
    type    => 'search',
  }
  cirrus_kibana::import { 'tenable-system_logins':
    content => 'tenable-system_logins.json.erb',
    type    => 'search',
  }
}