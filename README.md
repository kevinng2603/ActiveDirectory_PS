# Setup a Basic Home Lab Running Active Directory (Oracle VirtualBox) | Add Users w/PowerShell

## Project Overview
Welcome to the Active Directory Lab! This project is guided you through setting up and configuring an **Active Directory** environment using VirtualBox. You will not only set up the infrastructure but also dive into using **PowerShell** scripts to automate user creation. This setup is perfect for IT professionals, students, and enthusiasts looking to deepen their understanding of **Active Directory** and **Windows networking** in a hands-on, practical way.

## Prerequisites
Before you proceed, ensure you have completed the environment setup as described in the [Environment Setup Guide](/Docs/environment-setup.md).
1. **Oracle VirtualBox**: [Download here](https://www.virtualbox.org/)
2. **Windows 10 ISO**: [Download here](https://www.microsoft.com/software-download/windows10)
3. **Windows Server 2019 ISO**: [Download here](https://www.microsoft.com/en-us/evalcenter/evaluate-windows-server-2019)
4. **VirtualBox Extension Pack**: [Download here](https://www.virtualbox.org/wiki/Downloads)

## Network Diagram

<p align="center">
  <img src="/Assets/Network_Diagram.png" alt="Network Diagram" width="600"/>
</p>

## Implementing Active Directory on VM

### Step 1: Creating Organizational Units and Users
1. Open Active Directory Users and Computers on the Domain Controller.
2. Create Organizational Units (OUs) as needed for your structure (e.g., `_USERS`, `_ADMINS`).

### Step 2: Create a Domain Admin User (Manually)
1. Open Active Directory Users and Computers (Windows Administrative Tools) on the Domain Controller.
2. Right-click the `_ADMINS` container (or your custom OU), select `New`, and then `User`.
3. Enter the details for the new user (e.g., First name: `Kevin`, Last name: `Nguyen`, User logon name: `a-kevinnguyen`).
4. Set a strong password and ensure `Password never expires` is checked.
5. Right-click the new user, select `Add to a group`, and add the user to the `Domain Admins` group.

## Using PowerShell to Create Users

### Step 2: PowerShell Scripts to Bulk User Creation (Automation)
1. Download all the scripts in a zip file from the following link:
   - [https://github.com/kevinng2603/ActiveDirectory_PS/releases/download/ad_scripts/scripts.zip](https://github.com/kevinng2603/ActiveDirectory_PS/releases/download/ad_scripts/scripts.zip)
2. Extract the zip file on the Domain Controller.
3. Open PowerShell ISE as an Administrator on the Domain Controller.
4. Navigate to `open` the directory where the scripts are located.
5. Enable execution of all scripts on this service in command-line:
   ```powershell
   Set-ExecutionPolicy Unrestricted
   ```
6. Change Directory to the `scripts` folder:
   ```powershell
   cd C:\Users\a-kevinnguyen\Desktop\AD_PS-master
   ```
7. Run Script (F5) or using command-line:
   ```powershell
   C:\Users\a-kevinnguyen\Desktop\AD_PS-master\1_CREATE_USERS.ps1
   ```
![Execution](/Assets/create_users.png)
8. To get detailed information about the New-ADUser cmdlet, including all parameters, you can use the following command:
   ```powershell
   Get-Help New-ADUser -Detailed
   ```
9. If you seen this error message during the execution, it just mean we have some duplicated name in the names.txt
    - $\color{red}{\textsf{New-AdUser : The specified account already exists}}$

### Step 3: Verify the Successful Deployment of Users

After running the PowerShell script, you can verify the successful deployment of 1000 users in Active Directory by following these steps:

**Open Active Directory Users and Computers**:
   - Go to your Domain Controller.
   - Open **Active Directory Users and Computers** from the **Administrative Tools** menu.
   - Navigate to the `_USERS` Organizational Unit where the users were created.
   - You should see all 1000 users listed under the `_USERS` OU.
Here is a screenshot showing a portion of the successfully deployed users:

![User Deployment Success](/Assets/users.png)

**Admin and User Account**

![User Deployment Success](/Assets/admin_users.png)

### Step 4: Verify the Client Computer Joined to the Domain
After successfully joining the client computer to the domain, you can verify this by checking the Address Leases and the presence of the client computer in Active Directory Users and Computers. Follow these steps:

1. **Check the Address Leases in DHCP**:
   - Open **DHCP** from the **Administrative Tools** menu on the Domain Controller.
   - Navigate to your DHCP server and expand the node.
   - Select **Address Leases** under the relevant scope.
   - Verify that the `CLIENT1` computer appears in the list with an assigned IP address.

Here is a screenshot showing `CLIENT1` in the Address Leases:

![Client Computer Verification](/Assets/dc_client_dhcp.png)

2. **Check in Active Directory Users and Computers**:
   - Open **Active Directory Users and Computers** from the **Administrative Tools** menu.
   - Expand the domain node.
   - Navigate to the **Computers** container or the Organizational Unit where you expect the client computer to be.
   - Verify that `CLIENT1` appears in the list of computers.

Here is a screenshot showing `CLIENT1` in the Active Directory Users and Computers:

![Client Computer Verification](/Assets/dc_client_ad.png)

# Step 15: Log In to CLIENT1 Using a Domain Account

After successfully joining the CLIENT1 computer to the domain, you can log in using one of the user accounts created with the PowerShell script. Follow these steps:

**Log In Using a Domain Account**:
   - Enter any domain credentials for one of the users created with the PowerShell script.
     - Username: `sbeater`
     - Password: The password you specified in the PowerShell script `Password1`.

<p align="left">
  <img src="/Assets/client_login.png" alt="Login Verification" width="600"/>
</p>

3. **Verify Successful Login**:
   - After entering the credentials, press Enter.
   - Ensure that you successfully log in to the CLIENT1 VM using the domain account.

Here is a screenshot showing the successful login using a domain account:

![Login Verification](/Assets/client_complete.png)

## Conclusion
- By following these steps, you will have a fully functional Active Directory lab environment. This setup provides a valuable opportunity to gain hands-on experience with Windows networking and Active Directory. Additionally, by leveraging PowerShell script automation to add bulk users, you can efficiently manage and streamline the process of user creation in Active Directory, making it an essential skill for IT professionals and system administrators.
