require 'spec_helper'

describe 'nservicebusservicepulse' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      context 'with defaults' do
        # Compilation
        it { is_expected.to compile.with_all_deps }
        # Classes
        it { is_expected.to contain_class('nservicebusservicepulse::install') }
        it { is_expected.to contain_class('nservicebusservicepulse::config') }
        it { is_expected.to contain_class('nservicebusservicepulse::service') }
        # Relationships
        it { is_expected.to contain_class('nservicebusservicepulse::config').that_requires('Class[nservicebusservicepulse::install]').that_comes_before('Class[nservicebusservicepulse::service]') }
        it { is_expected.to contain_class('nservicebusservicepulse::config').that_notifies('Class[nservicebusservicepulse::service]') }
        # Parameters
        it {
          is_expected.to contain_class('nservicebusservicepulse')
            .only_with(
              package_manage: true,
              package_ensure: 'present',
              package_source: nil,
              package_provider: 'chocolatey',
              service_manage: true,
              service_ensure: 'running',
              service_enable: true,
              port: 9090,
              service_control_url: 'http://localhost:33333/api/',
              monitoring_url: 'http://localhost:33633/',
              show_pending_retry: false,
            )
        }
      end
    end
  end
end
