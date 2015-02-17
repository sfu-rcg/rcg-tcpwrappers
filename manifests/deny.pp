define tcpwrappers::deny
(
	$service,
	$address,
) {

  $output = join( [ $service, $address ], " : " )
  concat::fragment{ "tcpwrappers_deny_$name":
    target  => $tcpwrappers::params::denyPath,
    order   => 10,
    content => "$output\n",
  }

}
