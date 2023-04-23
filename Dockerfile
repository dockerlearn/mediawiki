FROM centos:centos7
#remi-release package required for php 7.4
RUN yum install -y epel-release http://rpms.remirepo.net/enterprise/remi-release-7.rpm \
    && yum-config-manager --enable remi-php74 \
    && yum -y update && yum install -y centos-release-scl \
    && yum install -y httpd httpd-tools php php-mcrypt php-cli php-gd php-curl php-mysql php-ldap php-zip php-process php-ldap php-mbstring php-intl php-xml net-tools wget \
    && yum clean all 

WORKDIR /var/www/html

RUN wget https://releases.wikimedia.org/mediawiki/1.39/mediawiki-1.39.3.tar.gz; \
    wget https://releases.wikimedia.org/mediawiki/1.39/mediawiki-1.39.3.tar.gz.sig; \
    gpg --verify mediawiki-1.39.3.tar.gz.sig mediawiki-1.39.3.tar.gz; \
    tar -zxf mediawiki-1.39.3.tar.gz && mv mediawiki-1.39.3 mediawiki && rm -f mediawiki-1.39.3.tar.gz

RUN sed -i -e 's|^DocumentRoot "/var/www/html"|DocumentRoot "/var/www/html/mediawiki"|' -e 's|    DirectoryIndex index.html|    DirectoryIndex index.html index.html.var index.php|' -e 's|^<Directory "/var/www/html">|<Directory "/var/www/html/mediawiki">|' /etc/httpd/conf/httpd.conf

RUN chown -R apache:apache /var/www/html/mediawiki \
    && chmod 755 /var/www/html/mediawiki/

RUN sed -i 's|^LoadModule http2_module modules/mod_http2.so|#LoadModule http2_module modules/mod_http2.so|' /etc/httpd/conf.modules.d/00-base.conf

CMD /usr/sbin/apachectl -DFOREGROUND
