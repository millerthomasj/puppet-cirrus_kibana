class twc_kibana::install ()
{
  class { 'apache':
    default_vhost => false,
  }

  class { '::kibana3':
    manage_git => false,
    manage_git_repository => false,
  }
}
