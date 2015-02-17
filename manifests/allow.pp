define tcpwrappers::allow
(
	$service,
	$address,
) {

  $output = join( [ $service, $address ], " : " )

  concat::fragment{ "tcpwrappers_allow_$name":
    target  => $tcpwrappers::params::allowPath,
    order   => 10,
    content => "$output\n",
  }

}
