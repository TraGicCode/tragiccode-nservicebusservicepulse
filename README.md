# nservicebusservicepulse

[![Puppet Forge Version](http://img.shields.io/puppetforge/v/tragiccode/nservicebusservicepulse.svg)](https://forge.puppetlabs.com/tragiccode/nservicebusservicepulse)
[![Puppet Forge Downloads](https://img.shields.io/puppetforge/dt/tragiccode/nservicebusservicepulse.svg)](https://forge.puppetlabs.com/tragiccode/nservicebusservicepulse)
[![Puppet Forge Pdk Version](http://img.shields.io/puppetforge/pdk-version/tragiccode/nservicebusservicepulse.svg)](https://forge.puppetlabs.com/tragiccode/nservicebusservicepulse)

#### Table of Contents

1. [Description](#description)
1. [Setup requirements](#setup-requirements)
    * [Beginning with nservicebusservicepulse](#beginning-with-nservicebusservicepulse)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
1. [Limitations - OS compatibility, etc.](#limitations)
1. [Contributing](#contributing)

## Description

The nservicebusservicepulse module installs and manages Service Pulse.

ServicePulse is a web application aimed mainly at administrators. It gives a clear, near real-time, high-level overview of how a system is functioning.

### Setup Requirements

The nservicebusservicepulse module requires the following:

* Puppet Agent 4.7.1 or later.
* Access to the internet.
* Chocolatey installed.
* A Running instance of Service Control.
* Windows Server 2012/2012R2/2016.

### Beginning with nservicebusservicepulse

To get started with the nservicebusservicepulse module simply include the following in your manifest:

```puppet
class { 'nservicebusservicepulse':
  package_ensure      => 'present',
  service_control_url => 'http://servicecontrol.tragiccode.com:33333/api/',
}
```

This example downloads, installs, and configures the latest version of servicepulse and points it to an instance of service control on a remote machine.  After running this you should be able to access servicepulse from http://localhost:9090.

**NOTE: By default this module pulls the package from chocolatey (https://chocolatey.org/packages/servicepulse)**

## Usage

All parameters for the nservicebusservicepulse module are contained within the main `nservicebusservicepulse` class, so for any function of the module, set the options you want. See the common usages below for examples.

### Install a specific version of service pulse from chocolatey

```puppet
class { 'nservicebusservicepulse':
  package_ensure      => '1.16.0',
  service_control_url => 'http://localhost:33333/api/',
}
```

**NOTE: We recommend always specifying a specific version so that it's easily viewable and explicit in code.  The default value is present which just grabs whatever version happens to be the latest at the time your first puppet run happened with this code**

### Change Service Pulse Port

The Default port for servicepulse is 9090 but can be customized as shown below if needed.

```puppet
class { 'nservicebusservicepulse':
  package_ensure => 'present',
  port           => 9091,
}
```

### Display of Real-time Monitoring

In order to consume real-time monitoring of logical endpoints by displaying various key metrics ( Critical Time, Processing Time, Throughput, Queue Length, etc.. ) simply point servicepulse to the url of your service control monitoring instance.

```puppet
class { 'nservicebusservicepulse':
  package_ensure      => 'present',
  service_control_url => 'http://servicecontrol.tragiccode.com:33333/api/',
  monitoring_url      => 'http://servicecontrol.tragiccode.com:33633/',
}
```

### Enable pending retries view

```puppet
class { 'nservicebusservicepulse':
  package_ensure     => 'present',
  show_pending_retry => true,
}
```

**NOTE: Failed messages that are currently in the pending status can be retried, however this feature should be used with care. Retrying pending messages can cause the same message to be processed multiple times. Do not retry a message if it has been processed by the endpoint. In this context "processed" includes both the successful handling of the message and the failure state of it being sent to the error queue**

## Reference

See [REFERENCE.md](REFERENCE.md)

## Limitations

### IIS Hosting Currently not implemented

Currently hosting service pulse within IIS is currently not implemented and the only supported configuration is hosting via a Windows Service.

This also means that the ability to have multiple instances of servicepulse on a single machine is also not possible.

## Contributing

1. Fork it ( https://github.com/tragiccode/tragiccode-nservicebusservicepulse/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
