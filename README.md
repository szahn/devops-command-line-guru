
# Command Line Basics

> "The command line is a simple text interface for interacting with your computer. At first, using a command line interface can be intimidating, but as you get more comfortable with it, you'll find that it becomes a powerful tool. &mdash; https://devops-bootcamp.liatr.io/#/1/1.3-unix-basics?id=command-line-navigation


What's the difference between Cmd, Powershell, and Bash?


# Concepts

## Unix Philsophy

> When Unix was first implemented in the late 1960’s and early 1970’s, one of the core tenets was that (wherever possible) everything should be abstracted as a file stream. One of the key goals was to simplify the code required to access devices and peripherals: If all devices presented themselves to the OS as file-systems, then existing code could access those devices more easily. This philosophy runs deep: One can even navigate and interrogate a great deal of a *NIX-based OS & machine configuration by navigating pseudo/virtual file-systems which expose what appear to be “files” and folders, but actually represent machine configuration, and hardware. For example, in Linux, one can explore a machine’s processors’ properties by examining the contents of the /proc/cpuinfo pseudo-file. &mdash;https://devblogs.microsoft.com/commandline/windows-command-line-inside-the-windows-console/


# Command Lines

## Sh, Bash, Zsh

Everything is text. Pipelines. great for writing shell scripts that use command line interface (CLI) utilities, utilizing output from one command to another (piping), and executing simple tasks (up to 100 lines of code)

Usually located in `/bin/bash`

## Cmd

[DOS-based](https://github.com/microsoft/ms-dos).

### WSL (Windows/Linux Sybsystem)

## Powershell

> PowerShell is an *object-oriented* Shell, unlike the file/stream-based shells typically found in the *NIX world: Rather than handling streams of text, PowerShell processes streams of objects, giving PowerShell script writers the ability to directly access and manipulate objects and their properties, rather than having to write and maintain a lot of script to parse and manipulate text (e.g. via sed/grep/awk/lex/etc.) &mdash; https://devblogs.microsoft.com/commandline/windows-command-line-the-evolution-of-the-windows-command-line/

Uses Verb-Noun pattern (`Get-Item`)


## Powershell Core

"A tool that was powerful enough to handle cross-platform administration while allowing advanced customization" &ndash;[PowerShell Core for Linux Admins](https://linuxacademy.com/cp/modules/view/id/135)



Download: [Powershell Core on Github](https://github.com/PowerShell/PowerShell).

Based on .Net Core, cross platform object oriented scripting.

Can be used as default shell in Docker

```
FROM mcr.microsoft.com/dotnet/core/sdk:3.0
RUN pwsh -c Get-Date
RUN pwsh -c "Get-Module -ListAvailable | Select-Object -Property Name, Path"
``` 
&mdash; [Installing PowerShell with one line as a .NET Core global tool](https://www.hanselman.com/blog/InstallingPowerShellWithOneLineAsANETCoreGlobalTool.aspx)

# Basics


| Function | Cmd | Bash | Powershell |
|-|-|----|------------|
|Print|echo|echo|Write-Host|
|List Files||dir|ls|Get-ChildItem|
|Transform string||[Sed](https://www.tldp.org/LDP/abs/html/x23170.html)|-replace|
|Print Working Directory|`dir`|`cwd`|`Get-Location`
|Download URL|``|`wget`|`Invoke-WebRequest`|
|Search||grep|select-string|

[PowerShell equivalents for common Linux/bash commands](https://mathieubuisson.github.io/powershell-linux-bash/)

[Bash -> PS PowerShell Beginner’s Guide](https://github.com/PowerShell/PowerShell/blob/master/docs/learning-powershell/powershell-beginners-guide.md)

# Essential Tools

## Get Help

Command help: `man bash`

Get list of commands: `Get-Command`

## SSH

Generate an SSH Key

```bash
ssh-keygen -f ./id_rsa -t rsa -b 4096 -q
chmod 400 ./id_rsa # Only the current user has read access
ssh -i "demo.pem" ec2-user@ec2-3-85-62-168.compute-1.amazonaws.com
```

### Network Troubleshooting

Show port usage with `netstat`

Check host resolution with `ping bing.com`

Display network device addresses with `ipconfig` or `ifconfig`

Get hostname with `hostname`

Trace IP hops with `traceroute`

```bash
tracert http://bing.com
curl -v http://bing.com 
```

## Archives

```
Compress-Archive -Path ./ compressed.zip
zip -r compressed.zip ./
```

## IO

Check if a file exists: `Test-Path`

Search files: `Select-String –path ./* –pattern white`

### Package Management

Install net tools with `sudo apt install inetutils-traceroute`

## IP Introspection

```bash
curl -s -4 icanhazip.com
```

## Logs

```bash
tail -f /var/log/syslog
```

## Deploying Infastructure (IaC)

> Ideally, you don't want to write complex scripts in bash. Python is an excellent replacement. If you’ve got more than about 50 lines of bash you should probably be doing python. Has better debugging tools and utilities than Bash, which makes it a great language for developing complex software applications involving many lines of code

### Python Scripting

Avoid Python 2.7 as [official support ends 2020](https://www.python.org/dev/peps/pep-0373/#id2). Use Python 3+. You can use [`boto3`](https://boto3.amazonaws.com/v1/documentation/api/latest/index.html?id=docs_gateway) python library to replace complex Bash scripts in AWS automation.

```bash
./scripts/python.py
```

### Ansible

Ansible is about automating client/server management. Execute scripts on remote servers without having to RDP into them.

#### Install Ansible

```
sudo apt-get install ansible sshpass
```

#### Copy a file to a Linux host

- Setup a `hosts` file
- Create an [ssh key](https://linuxize.com/post/how-to-set-up-ssh-keys-on-ubuntu-1804/)
- On the remote host, [add a user](https://linuxize.com/post/how-to-add-and-delete-users-on-ubuntu-18-04/) and ssh key
- Run the playbook

```
sudo ./hosts
ansible all -i hosts -m ping
ansible-playbook -i hosts -u demo --private-key=./keys/id_rsa ./ansible/copy-file.yml
```


- See [YAML Format](https://docs.ansible.com/ansible/latest/reference_appendices/YAMLSyntax.html)


# Resources

- [A Unix Person's Guide to PowerShell](https://leanpub.com/aunixpersonsguidetopowershell/read#leanpub-auto-whoami)
