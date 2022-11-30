[System.Collections.ArrayList]$iptable= @()

az network nic list --resource-group rg-private-endpoints -o table
$nics = az network nic list --resource-group rg-private-endpoints --query "[].name" -o tsv

foreach ($nic in $nics) 
{
    $ip = az network nic ip-config list --resource-group rg-private-endpoints --nic-name $nic --query "[].privateIpAddress" -o tsv
    $entry = [PSCustomObject]@{
        Nic=$nic
        IP=$ip
    }
    $iptable += $entry
}

$iptable


az network nic list --query "[].{Name: name, ipConfigurations: join(',', ipConfigurations[].privateIpAddress), ResourceType: type}"  -o table

az network nic list --query "[].{Name: name, Id: id, ipConfigurations: ipConfigurations[].privateIpAddress, VM: virtualMachine.id, PrivateEndpoint: privateEndpoint.id}"
