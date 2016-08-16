class cirrus_kibana::visualization
{
  cirrus_kibana::import { 'datehisto-tenable_system_logins':
    content => 'datehisto-tenable_system_logins.json.erb',
    type    => 'visualization',
  }
  cirrus_kibana::import { 'datehisto-top_10_criticals':
    content => 'datehisto-top_10_criticals.json.erb',
    type    => 'visualization',
  }
  cirrus_kibana::import { 'datehisto-top_10_warnings':
    content => 'datehisto-top_10_warnings.json.erb',
    type    => 'visualization',
  }
  cirrus_kibana::import { 'datehisto-metrics_logstash_lag':
    content => 'datehisto-metrics_logstash_lag.json.erb',
    type    => 'visualization',
  }
  cirrus_kibana::import { 'pie-errors_by_host':
    content => 'pie-errors_by_host.json.erb',
    type    => 'visualization',
  }
  cirrus_kibana::import { 'pie-warnings_by_host':
    content => 'pie-warnings_by_host.json.erb',
    type    => 'visualization',
  }
  cirrus_kibana::import { 'count-all_docs':
    content => 'count-all_docs.json.erb',
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
  cirrus_kibana::import { 'pie-log_count_per_logstash_host':
    content => 'pie-log_count_per_logstash_host.json.erb',
    type    => 'visualization',
  }
  cirrus_kibana::import { 'datehisto-loglevel_count':
    content => 'datehisto-loglevel_count.json.erb',
    type    => 'visualization',
  }
  cirrus_kibana::import { 'pie-loglevel_per_host':
    content => 'pie-loglevel_per_host.json.erb',
    type    => 'visualization',
  }
}
