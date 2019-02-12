require 'spec_helper'

describe 'nservicebusservicepulse::install' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      it { is_expected.to compile.with_all_deps }

      context 'with defaults' do
        it {
          is_expected.to contain_package('servicepulse')
            .only_with(
              ensure: 'present',
              source: nil,
              provider: 'chocolatey',
              install_options: [
                '-installArgs',
                '"',
                'INST_PORT_PULSE=9090',
                'INST_URI=http://localhost:33333/api/',
                'INST_SC_MONITORING_URI=http://localhost:33633/',
                '"',
              ],
            )
        }
      end

      context 'with package_manage set to true' do
        let(:params) { { package_manage: true } }

        it { is_expected.to contain_package('servicepulse') }
      end
      context 'with package_manage set to false' do
        let(:params) { { package_manage: false } }

        it { is_expected.not_to contain_package('servicepulse') }
      end
    end
  end
end
