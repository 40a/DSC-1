NIC Teaming DSC Provider
==

####Installation Guide:

Copy folder to C:\Windows\System32\WindowsPowerShell\v1.0\Modules\PSDesiredStateConfiguration\PSProviders and run:

        $MOF = Get-Content C:\Windows\System32\WindowsPowerShell\v1.0\Modules\PSDesiredStateConfiguration\PSProviders\NICTeaming\NICTeaming.schema.mof
        $MOF | Out-FIle -Encoding ascii -filepath C:\Windows\System32\WindowsPowerShell\v1.0\Modules\PSDesiredStateConfiguration\PSProviders\NICTeaming\NICTeaming.schema.mof -Force

This will turn the UTF-8 encode file into ASCII, which will fix parsing issues with DSC

####Example:

        Configuration Team
        {
        # A Configuration block can have zero or more Node blocks
        Node TestNode
          {
          Teaming Test
            {
              Ensure = "Present"
              Name = "Test"
              NICs = "Ethernet", "Ethernet 2" 
            }
          }
        }
        Team
        Start-DscConfiguration -Wait -Verbose -Path .\Team
