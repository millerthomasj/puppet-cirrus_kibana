class cirrus_kibana::dashboard
{
  Cirrus_kibana::Import {
    type    => 'dashboard',
  }
  cirrus_kibana::import { 'metrics-loglevel_count_by_time_host_and_source': }
  cirrus_kibana::import { 'metrics-logstash_performance_per_host': }
  cirrus_kibana::import { 'security-user_logins-failed_and_successful': }
  # Used for SSHD Logins Dashboard
  cirrus_kibana::import { 'security-invalid_or_failed_logins-sshd': }
}
