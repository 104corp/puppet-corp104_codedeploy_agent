require 'spec_helper'

describe 'corp104_codedeploy_agent', :type => 'class' do
  context 'with defaults for all parameters' do
    let(:facts) do
      { 
        :os => {
          :family  => 'Debian',
          :name    => 'Ubuntu',
          :release => {
            :major => '16.04',
            :full  => '16.04'
          }
        },
        :lsbdistrelease         => '16.04',
        :lsbdistid              => 'Ubuntu',
        :osfamily               => 'Debian',
        :lsbdistcodename        => 'xenial',
        :operatingsystemrelease => '16.04',
      }
    end
    it do
      should contain_class('corp104_codedeploy_agent')
      should contain_class('corp104_codedeploy_agent::install')
      should contain_class('corp104_codedeploy_agent::config')
      should contain_class('corp104_codedeploy_agent::service')
    end

    it do
      should compile.with_all_deps
    end
  end
end

describe 'corp104_codedeploy_agent::onpremises', :type => 'class' do
  context 'with defaults for all parameters' do
    let(:facts) do
      { 
        :os => {
          :family  => 'Debian',
          :name    => 'Ubuntu',
          :release => {
            :major => '16.04',
            :full  => '16.04'
          }
        },
        :lsbdistrelease         => '16.04',
        :lsbdistid              => 'Ubuntu',
        :osfamily               => 'Debian',
        :lsbdistcodename        => 'xenial',
        :operatingsystemrelease => '16.04',
      }
    end

    let(:params) do
      {
        'aws_access_key_id'     => 'access_key',
        'aws_secret_access_key' => 'secret_key',
        'iam_user_arn'          => 'thisarn',
        'region'                => 'tokyo',
      }
    end

    it { is_expected.to contain_file('/etc/codedeploy-agent/conf/codedeploy.onpremises.yml').without_mode }

    it do
      should compile.with_all_deps
    end
  end
end