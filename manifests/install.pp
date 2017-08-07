class corp104_codedeploy_agent::install inherits corp104_codedeploy_agent {

  # fix puppetlabs support Ubuntu 16.04
  case $facts['os']['release']['major'] {
    '16.04': {
      class { 'ruby':
        rubygems_package => 'rubygems-integration',
      }
    }
    default: {
      include 'ruby'
    }
  }

  exec { 'download_codedeploy-agent':
    command => "/bin/bash -c export https_proxy=${corp104_codedeploy_agent::http_proxy}; wget https://aws-codedeploy-${corp104_codedeploy_agent::region}.s3.amazonaws.com/latest/install -O ${corp104_codedeploy_agent::install_tmp}",
    path    => '/bin:/usr/bin:/usr/local/bin:/usr/sbin',
    unless  => 'test -f /opt/codedeploy-agent/bin/codedeploy-agent',
  }
  file { $corp104_codedeploy_agent::install_tmp:
    ensure    => file,
    owner     => root,
    group     => root,
    mode      => '0740',
    subscribe => Exec['download_codedeploy-agent'],
    notify    => Exec['install_codedeploy-agent'],
  }

  if $corp104_codedeploy_agent::http_proxy {
    exec { 'install_codedeploy-agent':
      command => "${corp104_codedeploy_agent::install_tmp} auto --proxy ${corp104_codedeploy_agent::http_proxy}",
      path    => '/sbin:/bin:/usr/bin:/usr/local/bin:/usr/local/sbin::/usr/sbin',
      notify  => Service['codedeploy-agent'],
      unless  => 'test -f /opt/codedeploy-agent/bin/codedeploy-agent',
    }
  }
  else {
    exec { 'install_codedeploy-agent':
      command => "${corp104_codedeploy_agent::install_tmp} auto ",
      path    => '/sbin:/bin:/usr/bin:/usr/local/bin:/usr/local/sbin::/usr/sbin',
      notify  => Service['codedeploy-agent'],
      unless  => 'test -f /opt/codedeploy-agent/bin/codedeploy-agent',
    }
  }
}