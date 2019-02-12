# @summary
#   This class handles the default parameters servicepulse class.
#
# @api private
#
class nservicebusservicepulse::params {
  $package_manage      = true
  $package_ensure      = 'present'
  $package_source      = undef
  $package_provider    = 'chocolatey'
  $service_manage      = true
  $service_ensure      = 'running'
  $service_enable      = true
  $port                = 9090
  $service_control_url = 'http://localhost:33333/api/'
  $monitoring_url      = 'http://localhost:33633/'
  $show_pending_retry  = false
}
