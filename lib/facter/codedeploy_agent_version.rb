# Make codedeploy-agent version available as a fact

Facter.add(:codedeploy_agent_version) do
  confine { Facter.value(:kernel) != 'windows' }
  confine { Facter.value(:operatingsystem) != 'nexus' }
  setcode do
    if File.exists?('/opt/codedeploy-agent/.version')
      Facter::Core::Execution.exec("cat /opt/codedeploy-agent/.version | sed 's/^.*OFFICIAL_//'|sed 's/_.*//' 2>&1")
    end
  end
end
