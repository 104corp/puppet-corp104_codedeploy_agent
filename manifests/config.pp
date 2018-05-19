class corp104_codedeploy_agent::config inherits corp104_codedeploy_agent {
  File {
    owner   => 'root',
    group   => 'root',
    require => Class['corp104_codedeploy_agent::install'],
    notify  => Class['corp104_codedeploy_agent::service']
  }

  file { $corp104_codedeploy_agent::codedeployagent_yml:
    ensure  => file,
    content => template("${module_name}/codedeployagent.yml.erb")
  }

  file { '/etc/cron.d': ensure => directory }

  file { $corp104_codedeploy_agent::codedeploy_agent_update_yml:
    ensure  => file,
    content => template("${module_name}/codedeploy-agent-update.yml.erb"),
    require => File['/etc/cron.d']
  }
}
