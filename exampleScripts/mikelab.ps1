Configuration MrHyperV_VM { 
    param (
        [Parameter(Mandatory)] 
        [string]$VMName,

        [Parameter(Mandatory)] 
        [string]$baseVhdPath,
 
        [Parameter(Mandatory)] 
        [string]$ParentPath,
 
        [Parameter(Mandatory)] 
        [string]$VMSwitchName
    ) 
 
    Import-DscResource -module xHyper-V
 
    xVMSwitch switch { 
        Name = $VMSwitchName
        Ensure = 'Present'         
        Type = 'Internal' 
    }
 
    xVHD DiffVHD { 
        Ensure = 'Present' 
        Name = $VMName 
        Path = $baseVhdPath
        ParentPath = $ParentPath
        Generation = 'vhdx' 
    } 
 
    xVMHyperV CreateVM { 
        Name = $VMName 
        SwitchName = $VMSwitchName
        VhdPath = Join-Path -Path $baseVhdPath -ChildPath "$VMName.vhdx" 
        ProcessorCount = 1
        MaximumMemory = 2GB
        MinimumMemory = 512MB
        RestartIfNeeded = $True 
        DependsOn = '[xVHD]DiffVHD', '[xVMSwitch]switch' 
        State = 'Running'
        Generation = 'vhdx'
    } 
}
