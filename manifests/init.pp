# @summary Installs and configures Particular's Service Pulse Monitoring Tool.
#
# @param package_ensure
#   Whether to install the ServicePulse package.
#
# @param package_manage
#   Whether to manage the ServicePulse package.
#
# @param package_source
#   Where to find the package file.
#
# @param package_provider
#   The package provider that should be used.
#
# @param service_manage
#   Specifies whether or not to manage the desired state of the windows service.
#
# @param service_ensure
#   Specifies the state of the service.
#
# @param service_enable
#   Whether to enable the service.
#
# @param port
#   Specify the port number to listen on. 9090 is recommended if no conflicts exist.
#
# @param service_control_url
#   Specify the url for the servicecontrol instance api.
#
# @param monitoring_url
#   Specify the url for the servicecontrol monitoring instance api.
#
# @param show_pending_retry
#   Whether to show retries that are currently in pending in servicepulse.
class nservicebusservicepulse(
  String $package_ensure                             = $nservicebusservicepulse::params::package_ensure,
  Boolean $package_manage                            = $nservicebusservicepulse::params::package_manage,
  Optional[String] $package_source                   = $nservicebusservicepulse::params::package_source,
  String $package_provider                           = $nservicebusservicepulse::params::package_provider,
  Boolean $service_manage                            = $nservicebusservicepulse::params::service_manage,
  Enum['running', 'stopped'] $service_ensure         = $nservicebusservicepulse::params::service_ensure,
  Variant[ Boolean, Enum['manual'] ] $service_enable = $nservicebusservicepulse::params::service_enable,
  Stdlib::Port $port                                 = $nservicebusservicepulse::params::port,
  Stdlib::Httpurl $service_control_url               = $nservicebusservicepulse::params::service_control_url,
  Stdlib::Httpurl $monitoring_url                    = $nservicebusservicepulse::params::monitoring_url,
  Boolean $show_pending_retry                        = $nservicebusservicepulse::params::show_pending_retry,
) inherits nservicebusservicepulse::params {

  contain nservicebusservicepulse::install
  contain nservicebusservicepulse::config
  contain nservicebusservicepulse::service

  Class['nservicebusservicepulse::install']
  -> Class['nservicebusservicepulse::config']
  ~> Class['nservicebusservicepulse::service']
}
