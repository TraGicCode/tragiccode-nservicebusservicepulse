# @summary
#   This class handles the service configuration of servicepulse.
#
# @api private
#
class nservicebusservicepulse::service (
  Boolean  $service_manage = $nservicebusservicepulse::params::service_manage,
  Enum['running', 'stopped'] $service_ensure = $nservicebusservicepulse::params::service_ensure,
  Variant[Boolean, Enum['manual']] $service_enable = $nservicebusservicepulse::params::service_enable,
) inherits nservicebusservicepulse::params {
  if $service_manage {
    service { 'Particular.ServicePulse':
      ensure => $service_ensure,
      enable => $service_enable,
    }
  }
}
