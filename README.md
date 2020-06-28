# apache-hosts

This little command make easier creating virtual domains for apache.
Command ask next params:
1) domain name - it's name of future domain, by this name you will have access to website locally
2) folder - it's sub folder for projects, folder project name will be equal to domain name
3) public folder - it's folder of project that will be available from web, miss this param if is root folder


Example: param1=test.loc, param2=my_projects, param3=web, script will create /var/www/my_projects/test.loc folder and local domain of this project will be test.loc

Usage
------------

* Script work correctly only with sudo.
* To run command execute next command in project folder: 
  `sudo ./create-domain.sh`

Global installation
-------------

* To set up command globally use next command: 
  `sudo mv create-domain.sh /usr/local/bin/create-domain`
* Usage after globally set up: 
  `sudo create-domain`

