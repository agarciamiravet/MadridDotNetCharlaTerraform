title "Check database pasionporlosbits"

control 'azurerm_sql_database' do
    title "Test database settings"
    desc "Test settings of pasionporlosbits database staging"
    describe azurerm_sql_database(resource_group: 'madriddotnet-rg-staging', server_name: 'pplbitsstagingdbserver', database_name: 'pplbitsstagingdatabase') do
        it            { should exist }
        its('name')   { should eq "pplbitsstagingdatabase"}
        its('location') { should eq "westeurope"}
        its('sku.name') { should eq "Basic"}
        its('properties.collation') { should eq "SQL_Latin1_General_CP1_CI_AS"}
      end
end