class ntp {

  package { 'ntp':
    ensure => installed,
  }

  file { '/etc/ntp.conf':
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => '0644',
    # just use ubuntu default
    #content => template('ntp/ntp.conf.erb'),
    require => Package['ntp'],
  }

  service { 'ntp':
    ensure    => running,
    enable    => true,
    subscribe => File['/etc/ntp.conf'],
    require   => Package['ntp'],
  }

  # nagios::nrpe::service {
  #   'check_ntp_time':
  #     check_command  => "/usr/lib/nagios/plugins/check_ntp_time -H \'${ntpserver}\' -w 0.5 -c 1",
  #   }
}
