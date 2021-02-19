class corp104_codedeploy_agent::install inherits corp104_codedeploy_agent {

  # fix puppetlabs support ruby
  if $facts['os']['name'] == 'Ubuntu' {
    if $facts['os']['release']['major'] == '16.04' {
      class { 'ruby':
        rubygems_package => 'rubygems-integration',
      }
    }
  }
  elsif $facts['os']['name'] == 'CentOS' {
    if $facts['os']['release']['major'] == '5' or '6' {
      if $corp104_codedeploy_agent::http_proxy {
        class { 'corp104_rvm':
          ruby_version => $corp104_codedeploy_agent::ruby_version,
          http_proxy   => $corp104_codedeploy_agent::http_proxy,
        }
      }
      else {
        class { 'corp104_rvm': ruby_version => $corp104_codedeploy_agent::ruby_version }
      }

      # AWS CodeDeploy needs Ruby version 2.0 or above to be installed for root under /usr/bin
      # Please install Ruby 2.x for user root
      exec { 'link-ruby':
        command => "ln -fs /usr/local/rvm/rubies/ruby-${$corp104_codedeploy_agent::ruby_version}/bin/ruby /usr/bin/ruby",
        path    => '/usr/bin:/bin',
        unless  => 'test -f /usr/bin/ruby',
      }
    }
  }
  else {
    include 'ruby'
  }

  if $corp104_codedeploy_agent::codedeployagent_download_url {
    $real_download_url = $corp104_codedeploy_agent::codedeployagent_download_url
  } else {
    $real_download_url = "https://aws-codedeploy-${corp104_codedeploy_agent::region}.s3.amazonaws.com/latest/install"
  }

  exec { 'download_codedeploy-agent':
    provider => 'shell',
    command  => "export https_proxy=${corp104_codedeploy_agent::http_proxy}; wget ${real_download_url} -O ${corp104_codedeploy_agent::install_tmp}",
    path     => '/bin:/usr/bin:/usr/local/bin:/usr/sbin',
    unless   => 'test -f /opt/codedeploy-agent/bin/codedeploy-agent',
  }
  file { $corp104_codedeploy_agent::install_tmp:
    ensure    => file,
    owner     => root,
    group     => root,
    mode      => '0740',
    subscribe => Exec['download_codedeploy-agent'],
    notify    => Exec['install_codedeploy-agent'],
  }

  if $corp104_codedeploy_agent::http_proxy and $corp104_codedeploy_agent::codedeployagent_version {
    $install_cmd = "${corp104_codedeploy_agent::install_tmp} auto --proxy ${corp104_codedeploy_agent::http_proxy} --version releases/${corp104_codedeploy_agent::codedeployagent_version}"
  } elsif $corp104_codedeploy_agent::codedeployagent_version {
    $install_cmd = "${corp104_codedeploy_agent::install_tmp} auto --version releases/${corp104_codedeploy_agent::codedeployagent_version}"
  } elsif $corp104_codedeploy_agent::http_proxy {
    $install_cmd = "${corp104_codedeploy_agent::install_tmp} auto --proxy ${corp104_codedeploy_agent::http_proxy}"
  } else {
    $install_cmd = "${corp104_codedeploy_agent::install_tmp} auto "
  }

  exec { 'install_codedeploy-agent':
    command => $install_cmd,
    path    => '/sbin:/bin:/usr/bin:/usr/local/bin:/usr/local/sbin::/usr/sbin',
    notify  => Service['codedeploy-agent'],
    unless  => 'test -f /opt/codedeploy-agent/bin/codedeploy-agent',
  }

}
