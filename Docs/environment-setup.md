# Environment Setup for Active Directory Lab Using VirtualBox

## Project Overview
This comprehensive guide will walk you through creating a robust, scalable Windows networking environment on your personal computer using **VirtualBox**. By setting up this environment, you'll gain hands-on experience with **Active Directory, DNS, DHCP**, and more
## Setup Instructions

### Step 1: Install VirtualBox and Extension Pack
1. Download and install [Oracle VirtualBox](https://www.virtualbox.org/).
2. Download the [VirtualBox Extension Pack](https://www.virtualbox.org/wiki/Downloads).
3. Open VirtualBox, go to `File` > `Preferences` > `Extensions`, and add the downloaded extension pack.

### Step 2: Download Windows ISOs
1. Download the Windows 10 ISO from the [Microsoft website](https://www.microsoft.com/software-download/windows10).
2. Download the Windows Server 2019 ISO from the [Microsoft Evaluation Center](https://www.microsoft.com/en-us/evalcenter/download-windows-server-2019).

### Step 3: Create the Domain Controller VM
1. Open VirtualBox and click `New` to create a new virtual machine.
2. Name the VM `DC` (Domain Controller).
3. Select `Microsoft Windows` as the type and `Windows 2019 (64-bit)` as the version.
4. Allocate at least 2GB of RAM.
5. Create a virtual hard disk with the default settings.
6. Configure the VM settings:
   - Go to `System` > `Processor` and allocate 2 CPUs (or 1 CPUs).
   - Go to `Network` and set up two network adapters:
     - Adapter 1: NAT (for internet access).
     - Adapter 2: Internal Network (for internal communication).

### Step 4: Install Windows Server 2019 on the Domain Controller
1. Start the `DC` VM and select the Windows Server 2019 ISO.
2. Follow the installation steps:
   - Select `Windows Server 2019 Standard (Desktop Experience)`.
   - Accept the license agreement.
   - Choose `Custom` installation and install on the virtual hard drive.
3. Set up the administrator password (e.g., `Password1`).
4. Once Windows Server 2019 is running, click on `Devices` in the VirtualBox menu and select `Insert Guest Additions CD image...`.
5. Open `File Explorer` in the VM, navigate to the CD drive, and run `VBoxWindowsAdditions-amd64.exe`.
6. Follow the prompts to install the Guest Additions and reboot the VM when prompted.

### Step 5: Configure Network Adapters
1. Open the `Network and Sharing Center`:
   - Right-click the network icon in the system tray and select `Open Network & Internet settings`.
   - Click on `Network and Sharing Center`.
2. Change adapter settings:
   - Rename `Ethernet` (connected to NAT) to `_INTERNET_`.
   - Rename `Ethernet 2` (connected to Internal Network) to `X_Internal_X`.
3. Assign static IP addresses:
   - For `_INTERNET_`: Obtain IP automatically.
   - For `X_Internal_X`: Set IP manually (e.g., `172.16.0.1`, subnet mask `255.255.255.0`). DNS Server: `127.0.0.1` loopback address.

### Step 6: Install and Configure the Active Directory Domain Services on Server Manager
1. Rename the server to `DC`:
   - Right-click the Start menu, select `System`, and click `Rename this PC`.
2. Install and configure the **Active Directory**:
   - Open Server Manager, click `Add roles and features`, and select `Role-based or future-based installation`.
   - Select a server `DC`.
   - Select Roles: `Active Directory Domain Services` and select `Add Features`.
   - Then `Next` till install.
   - After installation, click the notification flag and select `Promote this server to a domain controller`.
   - Create a new forest and domain (e.g., `mydomain.com`).
   - Set up the domain password (e.g., `Password1`)
   - Uncheck `Create DNS delegation`, then install
3. Install and configure the Remote Access role (RAS/NAT):
   - Open Server Manager, click `Add roles and features`, and select `Remote Access`.
   - Choose `Routing` and install.
   - Open the Routing and Remote Access console (in Tools), right-click on server `DC` then `Configure and Enable Routing and Remote Access`, choose `NAT`.
   - Select the external network adapter (`_INTERNET_`)
4. Install and configure DHCP and set up DNS:
   - Open Server Manager, click `Add roles and features`, and select `DHCP Server`.
   - Configure a new DHCP scope (in Tools).
   - Right-Clicked `IPv4`, then `New Scope` name as `172.16.0.100-200`. ![IP Address Range](/Assets/IPRange.png)
   - IP Address Range: `172.16.0.100 to 172.16.0.200`, and Length as `24`.
   - Router (Default Gateway): enter DC IP Address `172.16.0.1` (NAT Configured), then finish
   - Right-Clicked `Server Option` to configure `003 Router`
     - IP Address: `172.16.0.1`
   - Right-Clicked `dc.mydomain.com` to `authorize`, then `refresh`, and `IPv4` will turn green

### Step 7: Create the Client VM
1. Open VirtualBox and click `New` to create a new virtual machine.
2. Name the VM `Client1`.
3. Select `Microsoft Windows` as the type and `Windows 10 (64-bit)` as the version.
4. Allocate at least 2GB of RAM.
5. Create a virtual hard disk with the default settings.
6. Configure the VM settings:
   - Go to `Network` and set up the network adapter:
     - Adapter 1: Internal Network (for internal communication).

### Step 8: Install Windows 10 on the Client VM
1. Start the `Client1` VM and select the Windows 10 ISO.
2. Follow the installation steps:
   - Choose `Custom` installation and install on the virtual hard drive.
   - Choose `Windows 10 Pro` version
   - Create a local user (e.g., `user`).

### Step 9: Join the Client to the Domain
1. Log in to the `Client1` VM and check for connection
   
![Client Connection](/Assets/client_network.png)

2. Open System settings, click `Rename this PC (Advanced)`, and choose `Change` in `To rename this computer or change its domain or workgroup, click Change`.
   - Computer Name: `CLIENT1`
   - Member of Domain: `mydomain.com`
   - Using Admin Account for permission

![IP Address Range](/Assets/client_domain.png)

**Successfully Connect to mydomain.com domain**

![IP Address Range](/Assets/client_domain_complete.png)

3. Restart the VM and log in with a domain account.

## Troubleshooting
- **No Internet Access on Client**: Ensure the NAT and DHCP configurations are correct.
- **Cannot Join Domain**: Verify the network settings and domain name.

For more details on configuring Active Directory and using PowerShell to create users, please refer to the main [README.md](README.md).
