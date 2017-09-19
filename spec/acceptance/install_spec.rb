require 'spec_helper_acceptance'

describe 'install corp104_codedeploy_agent' do
  context 'default parameters with OpenJDK 1.8' do
    it 'should install package' do
      pp = "class { 'corp104_codedeploy_agent': }"

      # Run it twice and test for idempotency
      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes => true)
    end
  end
end
