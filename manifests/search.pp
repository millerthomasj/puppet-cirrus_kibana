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
  cirrus_kibana::import { 'loglevel-not-info':
    content => 'loglevel-not-info.json.erb',
    type    => 'search',
  }
  cirrus_kibana::import { 'tenable-system_logins':
    content => 'tenable-system_logins.json.erb',
    type    => 'search',
  }
  cirrus_kibana::import { 'message-KeyError_openstack_logs':
    content => 'message-KeyError_openstack_logs.json.erb',
    type    => 'search',
  }
  cirrus_kibana::import { 'loglevel-star':
    content => 'loglevel-star.json.erb',
    type    => 'search',
  }
}
