require 'spec_helper'

describe 'nservicebusservicepulse::config' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      it { is_expected.to compile.with_all_deps }

      context 'with defaults' do
        it {
          is_expected.to contain_registry_value('HKLM\System\CurrentControlSet\Services\Particular.ServicePulse\ImagePath')
            .only_with(
              ensure: 'present',
              type: 'expand',
              data: '"C:\Program Files (x86)\Particular Software\ServicePulse\ServicePulse.Host.exe" --url="http://localhost:9090"',
            )
        }
      end

      context 'with service_manage set to true' do
        let(:params) { { service_manage: true } }

        it { is_expected.to contain_registry_value('HKLM\System\CurrentControlSet\Services\Particular.ServicePulse\ImagePath') }
      end
      context 'with service_manage set to false' do
        let(:params) { { service_manage: false } }

        it { is_expected.not_to contain_registry_value('HKLM\System\CurrentControlSet\Services\Particular.ServicePulse\ImagePath') }
      end
    end
  end
end
