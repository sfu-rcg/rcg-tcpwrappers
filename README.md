# rcg-tcpwrappers
This is a simple tcpwrappers module manage allow/deny rules.

Examples
--------

Just include the module:

  include tcpwrappers

Include the module, and create "allow all" or "deny all" defaults:
(Note: these rules will not be removed if you define other allow or deny rules.)

  class { 'tcpwrappers':
    defaultDenyAll  => true
  }

Allow a service from an address/range (if not using defaultAllowAll):

  tcpwrappers::allow { 'local_sshd':
    service => 'sshd',
    address => '192.168.1.0/24',
  }

Deny a service from an address/range (if not using defaultAllowAll):

  tcpwrappers::deny { 'local_ftp':
    service => 'ftpd',
    address => '192.168.2.0/255.255.255.0',
  }

Contact
-------

research-support@sfu.ca
