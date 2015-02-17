# == Class: tcpwrappers
#
# Full description of class tcpwrappers here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if it
#   has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should not be used in preference to class parameters  as of
#   Puppet 2.6.)
#
# === Examples
#
#  class { tcpwrappers:
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ]
#  }
#
# === Authors
#
# Simon Fraser University - Research Computing Group <research-support@sfu.ca>
#
# === Copyright
#
# Copyright 2015 Simon Fraser University Research Computing Group
#
class tcpwrappers
(
	$defaultAllowAll = false,
	$defaultDenyAll  = false
) {
	include tcpwrappers::params

	# Set up the concat objects
        concat { $tcpwrappers::params::allowPath:
                owner   => 'root',
                group   => 'root',
                mode    => '0644',
        }

        concat { $tcpwrappers::params::denyPath:
                owner   => 'root',
                group   => 'root',
                mode    => '0644',
        }

	# Drop in a message stating how the files are managed, so that folks
	# don't get surprised when the file changes out from under them.
	concat::fragment { 'tcpwrappers_default_allow_msg':
		target	=> $tcpwrappers::params::allowPath,
		order	=> 01,
		content	=> $tcpwrappers::params::allowMessage,
	}
	concat::fragment { 'tcpwrappers_default_deny_msg':
		target	=> $tcpwrappers::params::denyPath,
		order	=> 01,
		content	=> $tcpwrappers::params::denyMessage,
	}

	# Make sure the package is installed
	package { '$tcpwrappers::params::packageName':
		ensure	=> present,
		before	=> Concat[ $tcpwrappers::params::allowPath, $tcpwrappers::params::denyPath ],
	}

	# Set a default 'allow everything' file.
	if ( $defaultAllowAll ) {
		tcpwrappers::all { 'default_allow_all':
			service	=> 'ALL',
			address	=> 'ALL',
		}
	}

	# Set a default 'deny everything' file.
	if ( $defaultDenyAll ) {
		tcpwrappers::deny { 'default_deny_all':
			service	=> 'ALL',
			address	=> 'ALL',
		}
	}
}
