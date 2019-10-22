title "Check web app pasion por los bits"

control 'azurerm_webapp' do
    title "Test webapp settings"
    desc "Test settings of pasionporlosbits webapp"
    describe azurerm_webapp(resource_group: 'madriddotnet-rg-staging', name: 'pplbits-staging') do
        it { should exist }
        its('properties.httpsOnly') { should cmp true }
        its('properties.enabledHostNames') { should include "staging.pasionporlosbits.com" }
        its('auth_settings.properties') { should have_attributes(enabled: false) }
        its('configuration.properties') { should have_attributes(http20Enabled: false) }
        its('configuration.properties') { should have_attributes(minTlsVersion: "1.2")}
      end
end