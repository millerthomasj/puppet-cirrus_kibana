class cirrus_kibana::search
{
  Cirrus_kibana::Import {
    type    => 'search',
  }
  cirrus_kibana::import { 'failed-system-logins_connection-closed-by-peer': }
  cirrus_kibana::import { 'failed-system-logins_connection-closed-by-peer_OR_invalid-user': }
  cirrus_kibana::import { 'failed-system-logins_invalid-user': }
  cirrus_kibana::import { 'loglevel-star': }
  cirrus_kibana::import { 'message-KeyError_openstack_logs': }
  cirrus_kibana::import { 'tenable-system_logins': }
  cirrus_kibana::import { 'user-logins_non-service-accounts': }
  # Used for SSHD Logins Dashboard
  cirrus_kibana::import { 'sshd-failed_or_invalid_logins': }
}
