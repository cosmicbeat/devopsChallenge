# devopsChallenge
Аutomate provisioning of an Application stack

Task description

	1. Create public git repository
	2. Choose a free Cloud Service Provider and register a free account with AWS, Azure, etc. or run VirtualBox/VMware Player locally
	3. Provision an Application stack running Apache Mysql PHP, each of the service must run separately on a node - virtual machine or container
	4. Automate the provisioning with the tools you like to use - bash, puppet, chef, Ansible, etc.
	5. Implement service monitoring either using free Cloud Service provider monitoring or Datadog, Zabbix, Nagios, etc.
	6. Automate service-fail-over, e.g. auto-restart of failing service
	7. Document the steps in git history and commit your code
	8. Send us link for the repository containing the finished solution
	9. Present a working solution, e.g. not a powerpoint presentation, but a working demo

Task solution: 
! Currently Automate service-fail-over and Nagious configuration are not completed. 

	Instructions to deploy
	1. Check-out the .sh file. 
	2. Place it to your server clould, virtual or physical instance 
	3. Review the script and read the commnets in it
	4. Run it as root
	5. Script will install docker with docker compose and run 3 containers with LAMP stack and Nagious

	[root@localhost admin]# docker ps
	CONTAINER ID        IMAGE                       COMMAND                  CREATED              STATUS              PORTS                            NAMES
	f460ac9f276f        jasonrivers/nagios:latest   "/usr/local/bin/st..."   About a minute ago   Up About a minute   80/tcp, 0.0.0.0:8081->8081/tcp   dockerized-lamp_nagios_1
	08f55f93dfb8        php:7.2.1-apache            "docker-php-entryp..."   23 hours ago         Up About a minute   0.0.0.0:80->80/tcp               dockerized-lamp_php-apache_1
	396aae82626e        mariadb:10.1                "docker-entrypoint..."   23 hours ago         Up 3 minutes        3306/tcp                         dockerized-lamp_mariadb_1

Access the demo webpage at "localhost"
Access Nagios at "localhost:8081/nagios"