Configuration labSetup { 
 
    param ( 
        [Parameter(Mandatory)] 
        [string]$labName,
        
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
        Name = "$labName-dc"
        Path = $baseVhdPath
        ParentPath = $ParentPath
        Generation = 'vhdx' 
    } 
 
    xVMHyperV CreateVM { 
	ensure = 'Present'
        Name = "$labName-dc" 
        SwitchName = $VMSwitchName
        VhdPath = Join-path (Split-Path $baseVhdPath) "$labname-dc.vhdx"
        ProcessorCount = 1
        MaximumMemory = 2GB
        MinimumMemory = 512MB
	RestartIfNeeded = 'True'
        DependsOn = '[xVHD]DiffVHD', '[xVMSwitch]switch' 
        State = 'Running'
        Generation = 2
    } 
}
