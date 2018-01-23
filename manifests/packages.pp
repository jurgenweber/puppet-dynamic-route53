class dynamicroute53::packages {

  if ! defined(Package['python-pip']) {
    package { 'python-pip':
      ensure => installed,
    }
  }

  if ($::operatingsystem == 'CentOS') {
    file { '/usr/bin/python-pip':
      ensure   => link,
      require  => Package['python-pip'],
      target   => '/usr/bin/pip',
    }
  }

  package { 'awscli':
    ensure   => installed,
    provider => pip,
    require  => [
      Package['python-pip'],
      $::operatingsystem ? { 'CentOS' => File['/usr/bin/python-pip'], default => undef },
    ]
  }

  package { 'cloud-utils':
    ensure => installed
  }

}
