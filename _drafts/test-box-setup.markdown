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

### Create an installed and updated parent virtual disk






True
-----
