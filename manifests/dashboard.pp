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
  cirrus_kibana::import { 'metrics-logstash_performance_per_host':
    content => 'metrics-logstash_performance_per_host.json.erb',
    type    => 'dashboard',
  }
  cirrus_kibana::import { 'metrics-loglevel_count_by_time_host_and_source':
    content => 'metrics-loglevel_count_by_time_host_and_source.json.erb',
    type    => 'dashboard',
  }
}
