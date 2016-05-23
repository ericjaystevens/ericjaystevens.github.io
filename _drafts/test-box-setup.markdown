---
layout: post
title:  "Test Box Setup"
date:   2016-05-01 22:21:16 -0400
categories: "DSC"  
---

Concise
-------


More Words
----------

*** Required: **** 

1. Test Box with 12G of Ram and Windows 10
2. Server 2012R2 Iso and key

### Install Hyper-V ###

Ensure Hardware Virtualization is turned on

```powershell
PS> (GWMI Win32_Processor).VirtualizationFirmwareEnabled
```

Then install Hyper-V

```posh
PS> Enable-WindowsOptionalFeature -online -FeatureName microsoft-hyper-v -all
```

This will require a reboot

### Create a base immage.

Download iso and set name
$serverIso = "en_windows_server_2012_x64_dvd_915478.iso"
$vmLoc = "F:\vms\"

Setup the vms directory
mkdir $vmLoc
mkdir "$vmLoc\isos"

Move your iso file to your newly created iso directory

```posh
new-vm -VHDPath "$vmLoc\gold.vhdx" -MemoryStartupBytes 512MB -Name gold
Set-VMDvdDrive -Path "$vmLoc\isos\$serverIso -VMName gold
start-vm gold
vmconnect.exe localhost gold
```

Complete the installation.


Give it networking

New-VMSwitch -Name "External vSwitch" -NetAdapterName "Ethernet" -AllowManagementOS 1 -Notes "PowerShell example of External vSwitch creation"
Add-VMNetworkAdapter -VMName gold -SwitchName "External vSwitch"


after install type sconfig then choose install udpates.

shut down
Unmount Disk

#### install needed packages from Powershell Gallery

```posh
import-Module PackageManagement
install-package xHypertall-package xHyper-V```

### Setup Dsc To controll your Hyper-v

Mike f Robins shout out here
<http://mikefrobbins.com/2015/01/22/creating-hyper-v-vms-with-desired-state-configuration/>


Create the configuration file

Get the syntex right

```posh
Get-DscResource -Syntax xVMHyperV
````



then dot source the file
. .\labsetup.ps1

```posh
labseetup -labname "simple" -baseVhdPath  F:\server1.vhdx -ParentPath F:\gold.vhdx -switchname "External vSwitch"
```

Start-DscConfiguration -Wait -Path .\labSetup\ The client cannot connect to the destination specified in the request. Verify that the service on the destination is running and is accepting requests. Consult the logs and documentation for the WS-Management service running on the destination, most commonly IIS or WinRM. If the destination is the WinRM service, run the following command on the destination to analyze and configure the WinRM service: "winrm quickconfig".     + CategoryInfo          : ConnectionError: (root/Microsoft/...gurationManager:String) [], CimExcepti    on     + FullyQualifiedErrorId : HRESULT 0x80338012     + PSComputerName        : localhost

This is becouse i ran into this problem

http://www.hurryupandwait.io/blog/fixing-winrm-firewall-exception-rule-not-working-when-internet-connection-type-is-set-to-public







True
-----
