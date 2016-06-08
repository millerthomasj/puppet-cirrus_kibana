class twc_kibana::install ()
{
  class { 'apache':
    default_vhost => false,
  }

#  class { '::kibana4':
#    manage_git => false,
#    manage_git_repository => false,
#  }
  include kibana4
}
