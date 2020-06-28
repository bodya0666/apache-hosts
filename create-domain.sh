echo -n "$ Type domain name: \n"
read domain

echo -n "$ Type folder name: \n"
read folder

echo -n "$ Type public folder name: \n"
read pub_folder

file="/etc/apache2/sites-available/$domain.conf"

/bin/cat <<EOM >$file
<VirtualHost *:80>
	# The ServerName directive sets the request scheme, hostname and port that
	# the server uses to identify itself. This is used when creating
	# redirection URLs. In the context of virtual hosts, the ServerName
	# specifies what hostname must appear in the request's Host: header to
	# match this virtual host. For the default virtual host (this file) this
	# value is not decisive as it is used as a last resort host regardless.
	# However, you must set it for any further virtual host explicitly.

    ServerAdmin webmaster@$domain
    ServerName $domain
    ServerAlias www.$domain
    DocumentRoot /var/www/$folder/$domain/$pub_folder

	# Available loglevels: trace8, ..., trace1, debug, info, notice, warn,
	# error, crit, alert, emerg.
	# It is also possible to configure the loglevel for particular
	# modules, e.g.
	#LogLevel info ssl:warn

	ErrorLog ${APACHE_LOG_DIR}/error.log
	CustomLog ${APACHE_LOG_DIR}/access.log combined

	# For most configuration files from conf-available/, which are
	# enabled or disabled at a global level, it is possible to
	# include a line for only one particular virtual host. For example the
	# following line enables the CGI configuration for this host only
	# after it has been globally disabled with "a2disconf".
	#Include conf-available/serve-cgi-bin.conf
</VirtualHost>

# vim: syntax=apache ts=4 sw=4 sts=4 sr noet
EOM

if ! -d "/var/www/$folder"
then
	mkdir /var/www/$folder
fi

if ! -d "/var/www/$folder/$domain"
then
	mkdir /var/www/$folder/$domain
fi

sudo chmod 777 -R /var/www/$folder/$domain

a2ensite $domain

systemctl restart apache2

if ! grep -q "\n127.0.0.1 $domain" /etc/hosts; 
then
  echo "\n127.0.0.1 $domain" >> /etc/hosts
fi
