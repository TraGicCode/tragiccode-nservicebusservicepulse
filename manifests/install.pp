# @summary
#   This class handles the management of the servicepulse installer and package.
#
# @api private
#
class nservicebusservicepulse::install (
  String $package_ensure               = $nservicebusservicepulse::params::package_ensure,
  Boolean $package_manage              = $nservicebusservicepulse::params::package_manage,
  Optional[String] $package_source     = $nservicebusservicepulse::params::package_source,
  String $package_provider             = $nservicebusservicepulse::params::package_provider,
  Stdlib::Port $port                   = $nservicebusservicepulse::params::port,
  Stdlib::Httpurl $service_control_url = $nservicebusservicepulse::params::service_control_url,
  Stdlib::Httpurl $monitoring_url      = $nservicebusservicepulse::params::monitoring_url,
) inherits nservicebusservicepulse::params {
  if $package_manage {
    package { 'servicepulse':
      ensure          => $package_ensure,
      source          => $package_source,
      install_options => [
        '-installArgs',
        '"',
        "INST_PORT_PULSE=${port}",
        "INST_URI=${service_control_url}",
        "INST_SC_MONITORING_URI=${monitoring_url}",
        '"',
      ],
      provider        => $package_provider,
    }
  }
}
