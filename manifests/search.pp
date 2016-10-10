class cirrus_kibana::search
{
  cirrus_kibana::import { 'failed-system-logins_connection-closed-by-peer':
    content => 'failed-system-logins_connection-closed-by-peer.json.erb',
    type    => 'search',
  }
  cirrus_kibana::import { 'failed-system-logins_connection-closed-by-peer_OR_invalid-user':
    content => 'failed-system-logins_connection-closed-by-peer_OR_invalid-user.json.erb',
    type    => 'search',
  }
  cirrus_kibana::import { 'failed-system-logins_invalid-user':
    content => 'failed-system-logins_invalid-user.json.erb',
    type    => 'search',
  }
  cirrus_kibana::import { 'loglevel-star':
    content => 'loglevel-star.json.erb',
    type    => 'search',
  }
  cirrus_kibana::import { 'message-KeyError_openstack_logs':
    content => 'message-KeyError_openstack_logs.json.erb',
    type    => 'search',
  }
  cirrus_kibana::import { 'tenable-system_logins':
    content => 'tenable-system_logins.json.erb',
    type    => 'search',
  }
  cirrus_kibana::import { 'user-logins_non-service-accounts':
    content => 'user-logins_non-service-accounts.json.erb',
    type    => 'search',
  }
}
