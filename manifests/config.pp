# @summary
#   This class handles the configuration of servicepulse.
#
# @api private
#
class nservicebusservicepulse::config(
  String $package_ensure               = $nservicebusservicepulse::params::package_ensure,
  Boolean $package_manage              = $nservicebusservicepulse::params::package_manage,
  Boolean $service_manage              = $nservicebusservicepulse::params::service_manage,
  Stdlib::Port $port                   = $nservicebusservicepulse::params::port,
  Stdlib::Httpurl $service_control_url = $nservicebusservicepulse::params::service_control_url,
  Stdlib::Httpurl $monitoring_url      = $nservicebusservicepulse::params::monitoring_url,
  Boolean $show_pending_retry          = $nservicebusservicepulse::params::show_pending_retry,
) inherits nservicebusservicepulse::params {

  if $service_manage {
    $imagepath_ensure = $package_ensure ? {
      'absent' => 'absent',
      default  => 'present',
    }

    registry_value { 'HKLM\System\CurrentControlSet\Services\Particular.ServicePulse\ImagePath':
      ensure => $imagepath_ensure,
      type   => expand,
      data   =>  "\"C:\\Program Files (x86)\\Particular Software\\ServicePulse\\ServicePulse.Host.exe\" --url=\"http://localhost:${port}\"",
    }
  }

  if $package_manage and $package_ensure != 'absent' {
    $file_line_defaults = {
      'ensure' => 'present',
      path     => 'C:\Program Files (x86)\Particular Software\ServicePulse\app\js\app.constants.js',
    }
    file_line { 'app-constants-js-service-control-url':
      *     => $file_line_defaults,
      line  => "\tservice_control_url: '${service_control_url}',",
      match => 'service_control_url: \'(.*)\',',
    }

    file_line { 'app-constants-js-monitoring-urls':
      *     => $file_line_defaults,
      line  => "\tmonitoring_urls: ['${monitoring_url}']",
      match => 'monitoring_urls: [\'(.*)\']',
    }

    file_line { 'app-constants-js-show-pending-retry':
      *     => $file_line_defaults,
      line  => "\t.constant('showPendingRetry', ${show_pending_retry})",
      match => '\.constant\(\'showPendingRetry\', (true|false)\)',
    }
  }
}
