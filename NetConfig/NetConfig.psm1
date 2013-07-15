Function Get-TargetResource {
    param
    (
    [ValidateSet("Present", "Absent")]
    [string]$Ensure = "Present",

    [ValidateNotNullOrEmpty()]
    [string]$Adapter,

    [ValidateSet("Manual", "DHCP")]
    [string]$Type = "DHCP",

    [array]$IPAddress,

    [array]$DNSServers,

    [string]$Gateway,

    [boolean]$RegisterDNS
    )

    $getTargetResourceResult = $null;
    
    $NetworkInformation = @(
        Get-NetIPConfiguration -InterfaceAlias $Adapter
        Get-DNSClient -InterfaceAlias $Adapter
        Get-NetIPAddress -InterfaceAlias $Adapter -AddressFamily IPv4
        )
    
    $getTargetResourceResult = @{
        Ensure = $Ensure
        Adapter = $Adapter
        Type = ($NetworkInformation.SuffixOrigin | Where-Object {$_ -ne $null})
        IPAddress = ($NetworkInformation.IPAddress | Where-Object {$_ -ne $null})
        DNSServers = ($NetworkInformation.DNSServer.ServerAddresses | Where-Object {$_ -ne $null})
        Gateway = $NetworkInformation.IPv4DefaultGateway.NextHop
        RegisterDNS = ($NetworkInformation.RegisterThisConnectionsAddress | Where-Object {$_ -ne $null})
        }

    $getTargetResourceResult;

}
