class cirrus_kibana::visualization
{
  Cirrus_kibana::Import {
    type    => 'visualization',
  }
  cirrus_kibana::import { 'count-all_docs': }
  cirrus_kibana::import { 'datehisto-failed_system_logins-connection_closed_by_peer': }
  cirrus_kibana::import { 'datehisto-failed_system_logins-invalid_user': }
  cirrus_kibana::import { 'datehisto-logstash_count_per_host': }
  cirrus_kibana::import { 'datehisto-logstash_lag_per_host': }
  cirrus_kibana::import { 'datehisto-loglevel_count': }
  cirrus_kibana::import { 'datehisto-metrics_logstash_lag': }
  cirrus_kibana::import { 'datehisto-tenable_system_logins': }
  cirrus_kibana::import { 'datehisto-user_logins-non_service_accounts': }
  cirrus_kibana::import { 'markdown-security_dashboard-system_logins': }
  cirrus_kibana::import { 'pie-log_count_per_logstash_host': }
  cirrus_kibana::import { 'pie-loglevel_per_host': }
  cirrus_kibana::import { 'pie-non_service_user_logins_per_host': }
  # Used for SSHD Logins Dashboard
  cirrus_kibana::import { 'pie-invalid_or_failed_logins-sshd': }
}
