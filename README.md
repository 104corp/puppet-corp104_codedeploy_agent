# puppet module corp104_codedeploy_agent
[![Build Status](https://travis-ci.org/104corp/puppet-corp104_codedeploy_agent.svg?branch=master)](https://travis-ci.org/104corp/puppet-corp104_codedeploy_agent)


#### Table of Contents

1. [Description](#description)
1. [Setup - The basics of getting started with corp104_codedeploy_agent](#setup)
    * [Beginning with corp104_codedeploy_agent](#beginning-with-corp104_codedeploy_agent)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
1. [Limitations - OS compatibility, etc.](#limitations)
1. [Development - Guide for contributing to the module](#development)

## Description

The corp104_codedeploy_agent module installs, configures, and manages the corp104_codedeploy_agent service across a range of operating systems and distributions.

## Setup

### Beginning with corp104_codedeploy_agent

`include '::corp104_codedeploy_agent'` is enough to get you up and running.

## Usage

All parameters for the ntp module are contained within the main `::corp104_codedeploy_agent` class, so for any function of the module, set the options you want. See the common usages below for examples.

### Install and enable corp104_codedeploy_agent

```puppet
include '::corp104_codedeploy_agent'
```

### Download repository package to Use a Proxy

```puppet
class { 'corp104_codedeploy_agent':
  http_proxy => 'http://change.proxy.com:3128',
}
```

### Configure codedeploy.onpremises.yml
```puppet
class { 'corp104_codedeploy_agent': }
class { 'corp104_codedeploy_agent::onpremises': 
  aws_access_key_id     => 'you-aws-access-key',
  aws_secret_access_key => 'you-aws-secret-key',
  iam_user_arn          => 'you-iam-user-arn',
  region                => 'you-aws-region'
}
```

## Reference

### Classes

#### Public classes

* corp104_codedeploy_agent: Main class, includes all other classes.

#### Private classes

* corp104_codedeploy_agent::install: Handles the packages.
* corp104_codedeploy_agent::config: Handles the config.
* corp104_codedeploy_agent::service: Handles the service.
* corp104_codedeploy_agent::onpremises: Handles the on-premises config.

## Limitations

This module cannot guarantee installation of corp104_codedeploy_agent versions that are not available on  platform repositories.

This module is officially [supported](https://forge.puppetlabs.com/supported) for the following Java versions and platforms:

## Development

Puppet modules on the Puppet Forge are open projects, and community contributions are essential for keeping them great. Please follow our guidelines when contributing changes.

For more information, see our [module contribution guide.](https://docs.puppetlabs.com/forge/contributing.html)

### Contributors

To see who's already involved, see the [list of contributors.](https://github.com/104corp/puppet-corp104_codedeploy_agent/graphs/contributors)
