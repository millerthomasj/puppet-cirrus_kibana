class cirrus_kibana::search
{
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
