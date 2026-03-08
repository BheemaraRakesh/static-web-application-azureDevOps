# Microsoft PowerShell Concepts

## Overview
PowerShell is a cross-platform task automation and configuration management framework from Microsoft. It consists of a command-line shell and scripting language built on .NET, designed for system administration and automation.

## Key Concepts

### 1. Cmdlets

#### Structure
Verb-Noun format for consistency.

**Common Verbs:**
- **Get:** Retrieve data
- **Set:** Modify data
- **New:** Create new items
- **Remove:** Delete items
- **Start/Stop:** Control processes

**Examples:**
```powershell
# Get services
Get-Service

# Stop a service
Stop-Service -Name "wuauserv"

# Create new directory
New-Item -ItemType Directory -Path "C:\MyFolder"

# Get running processes
Get-Process
```

### 2. Pipeline

#### Concept
Pass output from one cmdlet as input to another.

**Example:**
```powershell
# Get services, filter running ones, format output
Get-Service | Where-Object {$_.Status -eq "Running"} | Format-Table Name, Status

# Get files, sort by size, show top 10
Get-ChildItem -Path C:\ -Recurse | Sort-Object Length -Descending | Select-Object -First 10
```

### 3. Variables and Data Types

#### Variable Declaration
```powershell
# String variable
$name = "John"

# Array
$array = @("item1", "item2", "item3")

# Hash table
$hash = @{
    Name = "John"
    Age = 30
    City = "New York"
}

# Access variables
Write-Host "Hello, $name"
Write-Host "First item: $($array[0])"
Write-Host "Name: $($hash.Name)"
```

#### Automatic Variables
Predefined variables.

**Common Ones:**
- **$PSVersionTable:** PowerShell version info
- **$PWD:** Current directory
- **$HOME:** User home directory
- **$?:** Last command success status
- **$args:** Script parameters

### 4. Control Structures

#### Conditional Statements
```powershell
# If statement
if ($age -gt 18) {
    Write-Host "Adult"
} elseif ($age -eq 18) {
    Write-Host "Just turned 18"
} else {
    Write-Host "Minor"
}

# Switch statement
switch ($day) {
    "Monday" { Write-Host "Start of work week" }
    "Friday" { Write-Host "TGIF" }
    "Saturday" { Write-Host "Weekend!" }
    "Sunday" { Write-Host "Weekend!" }
    default { Write-Host "Regular day" }
}
```

#### Loops
```powershell
# For loop
for ($i = 1; $i -le 5; $i++) {
    Write-Host "Count: $i"
}

# Foreach loop
foreach ($item in $array) {
    Write-Host "Item: $item"
}

# While loop
$counter = 1
while ($counter -le 5) {
    Write-Host "Counter: $counter"
    $counter++
}

# Do-While loop
do {
    Write-Host "This runs at least once"
} while ($false)
```

### 5. Functions

#### Function Definition
```powershell
function Get-Greeting {
    param(
        [string]$Name,
        [int]$Age = 25
    )
    
    $message = "Hello, $Name! You are $Age years old."
    return $message
}

# Call function
Get-Greeting -Name "Alice" -Age 30
Get-Greeting "Bob"  # Positional parameters
```

#### Advanced Functions
```powershell
function Get-SystemInfo {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [string]$ComputerName,
        
        [Parameter(Mandatory=$false)]
        [switch]$IncludeDiskInfo
    )
    
    $os = Get-WmiObject -Class Win32_OperatingSystem -ComputerName $ComputerName
    $result = @{
        ComputerName = $ComputerName
        OSVersion = $os.Version
        LastBootTime = $os.LastBootUpTime
    }
    
    if ($IncludeDiskInfo) {
        $disks = Get-WmiObject -Class Win32_LogicalDisk -ComputerName $ComputerName
        $result.Disks = $disks | Select-Object DeviceID, Size, FreeSpace
    }
    
    return $result
}
```

### 6. Modules

#### Module Types
- **Script Modules:** .psm1 files
- **Binary Modules:** Compiled DLLs
- **Manifest Modules:** .psd1 files

#### Creating a Module
```powershell
# MyModule.psm1
function Get-MyData {
    # Function code
}

Export-ModuleMember -Function Get-MyData
```

#### Using Modules
```powershell
# Import module
Import-Module MyModule

# List available modules
Get-Module -ListAvailable

# Install module from PSGallery
Install-Module -Name Az -Repository PSGallery
```

### 7. Error Handling

#### Try-Catch-Finally
```powershell
try {
    $result = 10 / 0
    Write-Host "Result: $result"
}
catch {
    Write-Host "Error occurred: $($_.Exception.Message)"
}
finally {
    Write-Host "Cleanup code here"
}
```

#### Error Action Preference
```powershell
# Stop on all errors
$ErrorActionPreference = "Stop"

# Continue on errors
$ErrorActionPreference = "Continue"

# Silently continue
$ErrorActionPreference = "SilentlyContinue"
```

### 8. Remoting

#### PowerShell Remoting
Execute commands on remote computers.

**Enable Remoting:**
```powershell
# Enable PS Remoting
Enable-PSRemoting -Force

# Create session
$session = New-PSSession -ComputerName "Server01"

# Execute command remotely
Invoke-Command -Session $session -ScriptBlock { Get-Service }

# Enter interactive session
Enter-PSSession -ComputerName "Server01"
```

#### WS-Management
Modern remoting protocol.

### 9. Desired State Configuration (DSC)

#### Configuration Definition
```powershell
Configuration WebServerConfig {
    Node "WebServer01" {
        WindowsFeature IIS {
            Ensure = "Present"
            Name = "Web-Server"
        }
        
        File WebsiteContent {
            Ensure = "Present"
            SourcePath = "\\Server\Share\Website"
            DestinationPath = "C:\inetpub\wwwroot"
            Recurse = $true
            DependsOn = "[WindowsFeature]IIS"
        }
    }
}

# Generate MOF file
WebServerConfig

# Apply configuration
Start-DSCConfiguration -Path .\WebServerConfig -Wait -Verbose
```

### 10. Azure Integration

#### Azure PowerShell Module
```powershell
# Install Azure module
Install-Module -Name Az -AllowClobber

# Connect to Azure
Connect-AzAccount

# Get subscriptions
Get-AzSubscription

# Set context
Set-AzContext -Subscription "My Subscription"

# Create resource group
New-AzResourceGroup -Name "MyRG" -Location "EastUS"

# Create VM
New-AzVM -ResourceGroupName "MyRG" -Name "MyVM" -Image "Ubuntu2204" -Size "Standard_DS1_v2"
```

## Real Project Examples

### System Administration Script
```powershell
# System health check script
param(
    [string]$ComputerName = $env:COMPUTERNAME
)

Write-Host "=== System Health Check for $ComputerName ==="

# Check OS version
$os = Get-WmiObject -Class Win32_OperatingSystem -ComputerName $ComputerName
Write-Host "OS Version: $($os.Caption) $($os.Version)"

# Check CPU usage
$cpu = Get-WmiObject -Class Win32_Processor -ComputerName $ComputerName
Write-Host "CPU: $($cpu.Name)"
Write-Host "CPU Cores: $($cpu.NumberOfCores)"

# Check memory
$memory = Get-WmiObject -Class Win32_ComputerSystem -ComputerName $ComputerName
$totalMemory = [math]::Round($memory.TotalPhysicalMemory / 1GB, 2)
Write-Host "Total Memory: ${totalMemory}GB"

# Check disk space
$disks = Get-WmiObject -Class Win32_LogicalDisk -ComputerName $ComputerName -Filter "DriveType=3"
foreach ($disk in $disks) {
    $freeSpace = [math]::Round($disk.FreeSpace / 1GB, 2)
    $totalSpace = [math]::Round($disk.Size / 1GB, 2)
    $usedPercent = [math]::Round((1 - ($disk.FreeSpace / $disk.Size)) * 100, 2)
    
    Write-Host "Drive $($disk.DeviceID): ${freeSpace}GB free of ${totalSpace}GB (${usedPercent}% used)"
}

# Check running services
$services = Get-Service -ComputerName $ComputerName | Where-Object { $_.Status -eq "Running" }
Write-Host "Running Services: $($services.Count)"

# Check event logs for errors
$events = Get-EventLog -ComputerName $ComputerName -LogName System -EntryType Error -After (Get-Date).AddHours(-24)
if ($events) {
    Write-Host "Recent System Errors: $($events.Count)"
    foreach ($event in $events | Select-Object -First 5) {
        Write-Host "  $($event.TimeGenerated): $($event.Message)"
    }
} else {
    Write-Host "No recent system errors"
}
```

### Automated Deployment Script
```powershell
# Application deployment script
param(
    [Parameter(Mandatory=$true)]
    [string]$Environment,
    
    [Parameter(Mandatory=$true)]
    [string]$Version
)

# Configuration based on environment
switch ($Environment.ToLower()) {
    "dev" {
        $server = "dev-web01"
        $appPath = "C:\inetpub\wwwroot\dev"
        $backupPath = "C:\backups\dev"
    }
    "staging" {
        $server = "staging-web01"
        $appPath = "C:\inetpub\wwwroot\staging"
        $backupPath = "C:\backups\staging"
    }
    "prod" {
        $server = "prod-web01"
        $appPath = "C:\inetpub\wwwroot"
        $backupPath = "C:\backups\prod"
    }
    default {
        Write-Error "Invalid environment: $Environment"
        exit 1
    }
}

Write-Host "Deploying version $Version to $Environment environment on $server"

# Create PSSession
$session = New-PSSession -ComputerName $server

try {
    # Stop IIS site
    Invoke-Command -Session $session -ScriptBlock {
        param($appPath)
        Import-Module WebAdministration
        Stop-Website -Name "Default Web Site"
    } -ArgumentList $appPath

    # Backup current version
    Invoke-Command -Session $session -ScriptBlock {
        param($appPath, $backupPath, $version)
        $timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
        $backupName = "backup_$timestamp_$version"
        Copy-Item -Path $appPath -Destination "$backupPath\$backupName" -Recurse
    } -ArgumentList $appPath, $backupPath, $Version

    # Download new version
    Invoke-Command -Session $session -ScriptBlock {
        param($version)
        $url = "https://artifacts.mycompany.com/myapp/$version/myapp.zip"
        $tempPath = "C:\temp\myapp_$version.zip"
        Invoke-WebRequest -Uri $url -OutFile $tempPath
        Expand-Archive -Path $tempPath -DestinationPath "C:\temp\myapp_$version"
    } -ArgumentList $Version

    # Deploy new version
    Invoke-Command -Session $session -ScriptBlock {
        param($appPath, $version)
        $sourcePath = "C:\temp\myapp_$version"
        Get-ChildItem -Path $appPath -Exclude "web.config" | Remove-Item -Recurse -Force
        Copy-Item -Path "$sourcePath\*" -Destination $appPath -Recurse -Force
    } -ArgumentList $appPath, $Version

    # Start IIS site
    Invoke-Command -Session $session -ScriptBlock {
        param($appPath)
        Import-Module WebAdministration
        Start-Website -Name "Default Web Site"
    } -ArgumentList $appPath

    Write-Host "Deployment completed successfully"

} catch {
    Write-Error "Deployment failed: $($_.Exception.Message)"
} finally {
    # Clean up
    Invoke-Command -Session $session -ScriptBlock {
        Remove-Item -Path "C:\temp\myapp_$using:Version" -Recurse -Force -ErrorAction SilentlyContinue
    }
    Remove-PSSession -Session $session
}
```

### Azure Resource Management
```powershell
# Azure infrastructure management script
param(
    [Parameter(Mandatory=$true)]
    [string]$ResourceGroupName,
    
    [Parameter(Mandatory=$true)]
    [string]$Location,
    
    [Parameter(Mandatory=$false)]
    [int]$VmCount = 2
)

# Authenticate to Azure
Connect-AzAccount

# Set subscription context
Set-AzContext -Subscription "My Subscription"

# Create resource group
New-AzResourceGroup -Name $ResourceGroupName -Location $Location

# Create virtual network
$vnet = New-AzVirtualNetwork -ResourceGroupName $ResourceGroupName -Location $Location -Name "vnet01" -AddressPrefix "10.0.0.0/16"

# Create subnet
Add-AzVirtualNetworkSubnetConfig -Name "subnet01" -AddressPrefix "10.0.1.0/24" -VirtualNetwork $vnet
$vnet | Set-AzVirtualNetwork

# Create NSG
$nsg = New-AzNetworkSecurityGroup -ResourceGroupName $ResourceGroupName -Location $Location -Name "nsg01"

# Add RDP rule
$nsg | Add-AzNetworkSecurityRuleConfig -Name "RDP" -Priority 100 -Protocol "Tcp" -Access "Allow" -Direction "Inbound" -SourceAddressPrefix "*" -SourcePortRange "*" -DestinationAddressPrefix "*" -DestinationPortRange "3389"
$nsg | Set-AzNetworkSecurityGroup

# Create VMs
for ($i = 1; $i -le $VmCount; $i++) {
    $vmName = "vm{i:D2}"
    
    # Create NIC
    $nic = New-AzNetworkInterface -ResourceGroupName $ResourceGroupName -Location $Location -Name "$vmName-nic" -SubnetId $vnet.Subnets[0].Id -NetworkSecurityGroupId $nsg.Id
    
    # VM configuration
    $vmConfig = New-AzVMConfig -VMName $vmName -VMSize "Standard_DS1_v2" |
        Set-AzVMOperatingSystem -Windows -ComputerName $vmName -Credential (Get-Credential) |
        Set-AzVMSourceImage -PublisherName "MicrosoftWindowsServer" -Offer "WindowsServer" -Skus "2019-Datacenter" -Version "latest" |
        Add-AzVMNetworkInterface -Id $nic.Id
    
    # Create VM
    New-AzVM -ResourceGroupName $ResourceGroupName -Location $Location -VM $vmConfig
}

Write-Host "Infrastructure deployment completed"
Write-Host "Resource Group: $ResourceGroupName"
Write-Host "VMs Created: $VmCount"
```

## Best Practices
- Use consistent naming conventions
- Implement proper error handling
- Use parameters for script flexibility
- Comment complex logic
- Test scripts in non-production environments
- Use version control for scripts
- Implement logging and verbose output
- Use modules for reusable code
- Follow PowerShell coding guidelines
- Regularly update PowerShell and modules