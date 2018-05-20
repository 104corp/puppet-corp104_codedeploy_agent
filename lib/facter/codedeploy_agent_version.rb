# Make codedeploy-agent version available as a fact

Facter.add(:codedeploy_agent_version) do
  confine { Facter.value(:kernel) != 'windows' }
  confine { Facter.value(:operatingsystem) != 'nexus' }
  setcode do
    if Facter::Util::Resolution.exec('test -e /opt/codedeploy-agent/.version')
      Facter::Core::Execution.exec('cat /opt/codedeploy-agent/.version 2>&1').match(/^agent_version:\ OFFICIAL_(\d+\.\d+\-\d+\.\d+).*$/)[1]
    end
  end
end