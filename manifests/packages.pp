class dynamicroute53::packages {

  if ! defined(Package['python-pip']) {
    package { 'python-pip':
      ensure => installed,
    }
  }

  if ($::operatingsystem == 'CentOS') {
    file { '/usr/bin/pip-python':
      ensure   => link,
      require  => Package['python-pip'],
      target   => '/usr/bin/pip',
    }
  }

  $requirements = $::operatingsystem ? {
    'CentOS' => [ Package['python-pip'], File['/usr/bin/pip-python'] ],
    default  => Package['python-pip'],
  }

  package { 'awscli':
    ensure   => installed,
    provider => pip,
    require  => $requirements,
  }

  package { 'cloud-utils':
    ensure => installed
  }

}
