class cirrus_kibana::visualization
{
  cirrus_kibana::import { 'count-all_docs':
    content => 'count-all_docs.json.erb',
    type    => 'visualization',
  }
  cirrus_kibana::import { 'datehisto-failed_system_logins-connection_closed_by_peer':
    content => 'datehisto-failed_system_logins-connection_closed_by_peer.json.erb',
    type    => 'visualization',
  }
  cirrus_kibana::import { 'datehisto-failed_system_logins-invalid_user':
    content => 'datehisto-failed_system_logins-invalid_user.json.erb',
    type    => 'visualization',
  }
  cirrus_kibana::import { 'datehisto-logstash_count_per_host':
    content => 'datehisto-logstash_count_per_host.json.erb',
    type    => 'visualization',
  }
  cirrus_kibana::import { 'datehisto-logstash_lag_per_host':
    content => 'datehisto-logstash_lag_per_host.json.erb',
    type    => 'visualization',
  }
  cirrus_kibana::import { 'datehisto-loglevel_count':
    content => 'datehisto-loglevel_count.json.erb',
    type    => 'visualization',
  }
  cirrus_kibana::import { 'datehisto-metrics_logstash_lag':
    content => 'datehisto-metrics_logstash_lag.json.erb',
    type    => 'visualization',
  }
  cirrus_kibana::import { 'datehisto-tenable_system_logins':
    content => 'datehisto-tenable_system_logins.json.erb',
    type    => 'visualization',
  }
  cirrus_kibana::import { 'datehisto-user_logins-non_service_accounts':
    content => 'datehisto-user_logins-non_service_accounts.json.erb',
    type    => 'visualization',
  }
  cirrus_kibana::import { 'markdown-security_dashboard-system_logins':
    content => 'markdown-security_dashboard-system_logins.json.erb',
    type    => 'visualization',
  }
  cirrus_kibana::import { 'pie-log_count_per_logstash_host':
    content => 'pie-log_count_per_logstash_host.json.erb',
    type    => 'visualization',
  }
  cirrus_kibana::import { 'pie-loglevel_per_host':
    content => 'pie-loglevel_per_host.json.erb',
    type    => 'visualization',
  }
  cirrus_kibana::import { 'pie-non_service_user_logins_per_host':
    content => 'pie-non_service_user_logins_per_host.json.erb',
    type    => 'visualization',
  }
}
