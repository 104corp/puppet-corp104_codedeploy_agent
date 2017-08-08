class corp104_codedeploy_agent::onpremises (
  String $aws_access_key_id,
  String $aws_secret_access_key,
  String $iam_user_arn,
  String $region,
) inherits corp104_codedeploy_agent {
  File {
    owner   => 'root',
    group   => 'root',
    require => Class['corp104_codedeploy_agent::install'],
  }

  file { $corp104_codedeploy_agent::codedeploy_onpremises_yml:
    ensure  => file,
    content => template("${module_name}/codedeploy.onpremises.yml.erb")
  }
}
