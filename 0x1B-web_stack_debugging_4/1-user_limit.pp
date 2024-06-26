# Enable logging in with user holberton by increasing limits.

exec { 'fix-limit-hard':
  command => 'sed -i "/holberton hard/s/5/10000/" /etc/security/limits.conf',
  path    => '/bin'
}

exec { 'fix-limit-soft':
  command => 'sed -i "/holberton soft/s/4/10000/" /etc/security/limits.conf',
  path    => '/bin'
}
