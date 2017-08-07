require 'spec_helper_acceptance'

describe 'install corp104_codedeploy_agent' do
  context 'default parameters' do
    it 'should install package' do
      pp = "class { 'corp104_codedeploy_agent': }"

      # Run it twice and test for idempotency
      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes => true)
    end
  end

  context 'on premises' do
    it 'should setting on premises yaml' do
      pp = <<-EOS
        class { 'corp104_codedeploy_agent': }
        class { 'corp104_codedeploy_agent::onpremises':
          aws_access_key_id     => 'access_key',
          aws_secret_access_key => 'secret_key',
          iam_user_arn          => 'thisarn',
          region                => 'tokyo',
        }
      EOS
      # Run it twice and test for idempotency
      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes => true)
    end
  end
end