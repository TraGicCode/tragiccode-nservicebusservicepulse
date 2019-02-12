require 'spec_helper'

describe 'nservicebusservicepulse::service' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      it { is_expected.to compile.with_all_deps }

      context 'with defaults' do
        it {
          is_expected.to contain_service('Particular.ServicePulse')
            .only_with(
              ensure: 'running',
              enable: true,
            )
        }
      end

      context 'with service_manage set to true' do
        let(:params) { { service_manage: true } }

        it { is_expected.to contain_service('Particular.ServicePulse') }
      end
      context 'with service_manage set to false' do
        let(:params) { { service_manage: false } }

        it { is_expected.not_to contain_service('Particular.ServicePulse') }
      end
    end
  end
end
