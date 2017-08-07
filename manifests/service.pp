class corp104_codedeploy_agent::service inherits corp104_codedeploy_agent {
  service { 'codedeploy-agent':
    ensure    => $corp104_codedeploy_agent::service_ensure,
    enable    => $corp104_codedeploy_agent::service_enable,
    name      => $corp104_codedeploy_agent::service_name,
    subscribe => Exec['install_codedeploy-agent'],
  }
}