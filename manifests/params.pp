class tcpwrappers::params {

  case $::operatingsystem {
    'RedHat', 'CentOS', 'Scientific', 'OracleLinux', 'OEL': {
      $packageName	= "setup"
    }
    default: {
      fail('$::operatingsystem is not supported')
    }
  }

  $configPath	= "/etc"
  $allowPath	= "${configPath}/hosts.allow"
  $denyPath	= "${configPath}/hosts.deny"
  $allowMessage	= "# Managed by Puppet. Changes will be lost!\n"
  $denyMessage	= "# Managed by Puppet. Changes will be lost!\n"

}
