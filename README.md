# Active Directory Lab Using VirtualBox

## Project Overview
Welcome to the Active Directory Lab! This project is guided you through setting up and configuring an Active Directory environment using VirtualBox. You will not only set up the infrastructure but also dive into using PowerShell scripts to automate user creation. This setup is perfect for IT professionals, students, and enthusiasts looking to deepen their understanding of Active Directory and Windows networking in a hands-on, practical way.

## Prerequisites
Before you proceed, ensure you have completed the environment setup as described in the [Environment Setup Guide](environment-setup.md).
1. **Oracle VirtualBox**: [Download here](https://www.virtualbox.org/)
2. **Windows 10 ISO**: [Download here](https://www.microsoft.com/software-download/windows10)
3. **Windows Server 2019 ISO**: [Download here](https://www.microsoft.com/en-us/evalcenter/evaluate-windows-server-2019)
4. **VirtualBox Extension Pack**: [Download here](https://www.virtualbox.org/wiki/Downloads)

## Network Diagram

<p align="center">
  <img src="/Assets/Network_Diagram.png" alt="Network Diagram" width="500"/>
</p>

## Implementing Active Directory

### Step 1: Creating Organizational Units and Users
1. Open Active Directory Users and Computers on the Domain Controller.
2. Create Organizational Units (OUs) as needed for your structure (e.g., `Users`, `Admins`).
3. Manually create users or use the provided PowerShell script to automate user creation.

## Using PowerShell to Create Users

### Step 2: Prepare and Run PowerShell Scripts
1. Copy the following files to the Domain Controller:
   - `1_CREATE_USERS.ps1`
   - `Generate-Names-Create-Users.ps1`
   - `names.txt`
2. Open PowerShell as an Administrator on the Domain Controller.
3. Navigate to the directory where the scripts are located.
4. Allow script execution:
   ```powershell
   Set-ExecutionPolicy Unrestricted -Scope Process

