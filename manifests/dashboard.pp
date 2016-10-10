class cirrus_kibana::dashboard
{
  cirrus_kibana::import { 'metrics-loglevel_count_by_time_host_and_source':
    content => 'metrics-loglevel_count_by_time_host_and_source.json.erb',
    type    => 'dashboard',
  }
  cirrus_kibana::import { 'metrics-logstash_performance_per_host':
    content => 'metrics-logstash_performance_per_host.json.erb',
    type    => 'dashboard',
  }
  cirrus_kibana::import { 'security-user_logins-failed_and_successful':
    content => 'security-user_logins-failed_and_successful.json.erb',
    type    => 'dashboard',
  }
}
