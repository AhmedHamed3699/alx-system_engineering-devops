# Expanding the limit of the traffic on Nginx Server.

exec { 'change-limit':
  command => 'sed -i "s/15/3000/" /etc/default/nginx',
  path    => '/bin'
}

exec { 'restart-nginx':
  command => 'service nginx restart',
  path    => '/bin:/sbin',
}
