class { 'jenkins':
  config_hash => {
   'JENKINS_PORT' => { 'value' => '8000' },
   'JENKINS_HTTPS_PORT' => { 'value' => '8001' },
   'JENKINS_APJ_PORT' => { 'value' => '8001' },
  }
}
