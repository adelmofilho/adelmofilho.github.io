---
layout: post
title: "Montando sua infraestrutura de ciência de dados [parte 2]"
subtitle: "Segurança do Servidor"
bigimg: /img/hs.gif
tags: [r, rstudio, infra, hadoop, spark]
comments: true
draft: true
output:
  html_document:
    keep_md: true
---

Lembro do momento exato que tive meu primeiro servidor hackeado.

Descobri o que era bitcoin naquele dia, pois o preço para recuperar meus bancos de dados era de 0,5 BTC.

Preferia eles só vazando mensagem do telegram.

No fim, a culpa foi toda minha - firewall, ssh... nem sabia que essas coisas existiam.

A boa noticia é que algumas poucas configurações podem ajudar muito na segurança de seu servidor!

## Neste post...

- Vamos configurar um firewall com o `ufw`;
- Impedir invasões ao seu servidor com o uso do `fail2ban`;
- Configurar o protocolo SSH para tornar o acesso mais seguro.

## O que você já deve ter!

- Acesso root a um servidor linux Ubuntu 18 (post em breve);
- Par de chaves SSH associadas ao root.

## Vamos lá!




## Criar um usuário e adicioná-lo ao grupo `sudo`

adduser {$USER}
usermod -aG sudo {$USER}

## Copiar chaves SSH gerados no puttygen pro usuário

rsync --archive --chown={$USER}:{$USER} ~/.ssh /home/{$USER}

## Atualizando sistema

sudo apt update
sudo apt upgrade

## Trocar senha do root

passwd

## Impedir acesso via root e alterar porta ssh

sudo nano /etc/ssh/sshd_config

	PermitRootLogin no
	PubkeyAuthentication yes
	PasswordAuthentication no
	
sudo systemctl reload sshd


## Configurar o Fail2Ban

sudo apt-get install  fail2ban

sudo cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local

sudo nano /etc/fail2ban/jail.local

	Bantime = 100000m
	findtime = 30m
	maxretry = 2

	[sshd]
	enabled = true

	destemail = {$PERSONAL-EMAIL}
	sender = Fail2BanAlerts
	mta = sendmail
	action = %(action_mwl)s


sudo service fail2ban start

sudo service fail2ban restart

sudo fail2ban-client status

sudo fail2ban-client status sshd

## Ativando o firewall

sudo ufw app list
sudo ufw allow OpenSSH
sudo ufw allow 3838
sudo ufw allow  8787
sudo ufw allow 25
sudo ufw allow 80
sudo ufw enable
sudo ufw status

sudo fail2ban-client set sshd addignoreip {$IP-LOCAL-MACHINE}



## Em todas as máquinas

```
sudo apt-get install openjdk-8-jdk
sudo update-java-alternatives --list
sudo update-alternatives --config java
sudo update-alternatives --config javac
update-alternatives --display java


sudo adduser hadoop
```


# em todos

```
sudo apt-get install -y r-base

wget http://apache.claz.org/hadoop/common/hadoop-3.2.0/hadoop-3.2.0.tar.gz

tar -xzvf hadoop-3.2.0.tar.gz

sudo mkdir /stage

sudo mv hadoop-3.2.0 /stage/hadoop

sudo nano /etc/environment

PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/hadoop/bin:/usr/local/hadoop/sbin"
JAVA_HOME="/usr/lib/jvm/java-8-openjdk-amd64/jre/"

sudo usermod -aG hadoop hadoop
sudo chown hadoop:root -R /usr/local/hadoop
sudo chmod g+rwx -R /usr/local/hadoop
```

## em todos
```
sudo nano /etc/hosts

#127.0.1.1 GipsyDanger GipsyDanger

127.0.0.1 localhost
209.97.129.90 master Bloodwing-Saint-Jiao-Dragon
165.22.211.81 slave1 Snow-Wind-Great-Ape
165.22.220.242 slave2 Black-Scaled-Earth-Dragon

``` 

# no master

```
su - hadoop
ssh-keygen -b 4096

cat /home/hadoop/.ssh/id_rsa.pub

criar em cada usuario hadoop nos slaves e mastero arquivo .ssh/authorized_keys e colar a chve publica do amster


sudo systemctl restart sshd
```

do master

scp  /usr/local/hadoop/etc/hadoop/* slave1:/usr/local/hadoop/etc/hadoop/
scp  /usr/local/hadoop/etc/hadoop/* slave2:/usr/local/hadoop/etc/hadoop/

em todo mundo
su - aadelmo
source /etc/environment


Configurando o Yarn

Em todos os servidores

su - stacker

export HADOOP_HOME="/usr/local/hadoop"
export HADOOP_COMMON_HOME=$HADOOP_HOME
export HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop
export HADOOP_HDFS_HO/E=$HADOOP_HOME
export HADOOP_MAPRED_HOME=$HADOOP_HOME
export HADOOP_YARN_HOME=$HADOOP_HOME

Nos servidores slaves

su - hadoop

nano /usr/local/hadoop/etc/hadoop/yarn-site.xml

	<property>
	    <name>yarn.resourcemanager.hostname</name>
	    <value>master</value>
	 </property>

No master

su - hadoop

/usr/local/hadoop/sbin/start-yarn.sh

/usr/local/hadoop/bin/yarn node -list

/usr/local/hadoop/bin/yarn jar /usr/local/hadoop/share/hadoop/mapreduce/hadoop-mapreduce-examples-3.2.0.jar pi 2 100



export PATH=$PATH:/usr/local/hadoop/bin/



/usr/local/hadoop/bin/hdfs dfs –chmod –R 755 /user


--------


Começa a putaria aqui

sudo apt-get -y update
sudo apt-get -y upgrade

adduser aadelmo
adduser hadoop

sudo groupadd usuarios

usermod -aG sudo aadelmo
usermod -aG usuarios aadelmo
usermod -aG usuarios hadoop

## Copiar chaves SSH gerados no puttygen pro usuário

rsync --archive --chown=aadelmo:aadelmo ~/.ssh /home/aadelmo

## Trocar senha do root

passwd


##
su - aadelmo

sudo nano /etc/ssh/sshd_config

	PermitRootLogin no
	PubkeyAuthentication yes
	PasswordAuthentication no
	
sudo systemctl reload sshd


## Configurar o Fail2Ban

sudo apt-get install -y fail2ban

sudo cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local

sudo nano /etc/fail2ban/jail.local

	Bantime = 100000m
	findtime = 30m
	maxretry = 2

	[sshd]
	enabled = true

	destemail = {$PERSONAL-EMAIL}
	sender = Fail2BanAlerts
	mta = sendmail
	action = %(action_mwl)s


sudo service fail2ban start

sudo service fail2ban restart

sudo fail2ban-client status

sudo fail2ban-client status sshd

## Ativando o firewall

sudo ufw app list
sudo ufw allow OpenSSH
#sudo ufw allow 3838
#sudo ufw allow 8787
#sudo ufw allow 25
#sudo ufw allow 80
sudo ufw enable
sudo ufw status

sudo fail2ban-client set sshd addignoreip {$IP-LOCAL-MACHINE}

sudo /bin/dd if=/dev/zero of=/var/swap.1 bs=1M count=4096
sudo /sbin/mkswap /var/swap.1
sudo /sbin/swapon /var/swap.1
sudo sh -c 'echo "/var/swap.1 swap swap defaults 0 0 " >> /etc/fstab'

sudo nano /etc/sysctl.conf
	# Add this at the end
	    vm.swappiness=10



## Em todas as máquinas

```
sudo apt-get install openjdk-8-jdk
sudo update-java-alternatives --list
sudo update-alternatives --config java
sudo update-alternatives --config javac
update-alternatives --display java



sudo apt-get install -y r-base

wget http://apache.claz.org/hadoop/common/hadoop-3.2.0/hadoop-3.2.0.tar.gz

tar -xzvf hadoop-3.2.0.tar.gz

sudo mkdir /stage

sudo mv hadoop-3.2.0 /stage/hadoop

sudo nano /etc/environment

	PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/stage/hadoop/bin:/stage/hadoop/sbin"
	JAVA_HOME="/usr/lib/jvm/java-8-openjdk-amd64/jre/"

source /etc/environment

sudo chown :usuarios -R /stage/hadoop
sudo chmod g+rwx -R /stage/hadoop

## em todos
```
sudo nano /etc/hosts

#127.0.1.1 GipsyDanger GipsyDanger

127.0.0.1 localhost
134.209.151.133 master Divine-Scarlet-Thunderbird
134.209.157.234 slave1 Snow-Wind-Great-Ape
134.209.155.90 slave2 Black-Scaled-Earth-Dragon

``` 
em todos
su - hadoop
ssh-keygen -b 4096

# do master

```
cat /home/hadoop/.ssh/id_rsa.pub

em tudo

vim .ssh/master.pub
criar em cada usuario hadoop nos slaves e mastero arquivo .ssh/authorized_keys e colar a chve publica do amster

cat ~/.ssh/master.pub >> ~/.ssh/authorized_keys

em todos
sudo systemctl restart sshd
```

Configurando o Master

su - hadoop

nano /stage/hadoop/etc/hadoop/core-site.xml

<configuration>
	<property>
	<name>fs.default.name</name>
	<value>hdfs://master:9000</value>
	</property>
</configuration>

nano  /stage/hadoop/etc/hadoop/hdfs-site.xml

<configuration>
	<property>
	<name>dfs.namenode.name.dir</name>
	<value>/stage/hadoop/data/nameNode</value>
	</property>
	<property>
	<name>dfs.datanode.data.dir</name>
	<value>/stage/hadoop/data/dataNode</value>
	</property>
	<property>
	<name>dfs.replication</name>
	<value>2</value>
	</property>
	<property>
        <name>dfs.namenode.rpc-bind-host</name>
        <value>0.0.0.0</value>
        </property>
</configuration>

nano  /stage/hadoop/etc/hadoop/workers

slave1
slave2
	
nano  /stage/hadoop/etc/hadoop/mapred-site.xml

<configuration>
	<property>
	<name>yarn.app.mapreduce.am.job.client.port-range</name>
	<value>32000-33000</value>
	</property>
</configuration>


Replicando alterações para as slaves

scp  /stage/hadoop/etc/hadoop/* slave1:/stage/hadoop/etc/hadoop/
scp  /stage/hadoop/etc/hadoop/* slave2:/stage/hadoop/etc/hadoop/

su - aadelmo

sudo ufw allow from 10.136.239.240 to any port 9000, 9870
 9871
 9864
 9865
 9866 
 9867 
 9868
 9869
 8485
 8480
 8481
 50200
 10020
 19888
 19890
 10033
 8088
 8080
 8032
 8030
 8090
 8031
 8033
 8040
 8048
 10200
 8042
 8044
 8188
 8190
 8047
 8788
 8046
 8045
 8049
 8089
 8091
 32000:33000/tcp

sudo ufw allow from 10.136.239.240 to any port 8000:60000 proto tcp
sudo ufw allow from 10.136.240.46 to any port 8000:60000 proto tcp
sudo ufw allow from 10.136.241.22 to any port 8000:60000 proto tcp

sudo ufw enable
sudo ufw status

no master

su - hadoop

hdfs namenode -format
start-dfs.sh
 hdfs dfsadmin -report

em todo mundo e users

su - aadelmo

export HADOOP_HOME="/stage/hadoop"
export HADOOP_COMMON_HOME=$HADOOP_HOME
export HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop
export HADOOP_HDFS_HOME=$HADOOP_HOME
export HADOOP_MAPRED_HOME=$HADOOP_HOME
export HADOOP_YARN_HOME=$HADOOP_HOME

Nos servidores slaves
em todos
su - hadoop

nano /stage/hadoop/etc/hadoop/yarn-site.xml

<property>
	<name>yarn.resourcemanager.hostname</name>
	<value>master</value>
</property>

<property>
    <name>yarn.resourcemanager.webapp.address</name>
    <value>master:8088</value>
 </property>


no master 

su - hadoop

start-yarn.sh

yarn node -list

/stage/hadoop/bin/yarn jar /stage/hadoop/share/hadoop/mapreduce/hadoop-mapreduce-examples-3.2.0.jar pi 2 100

sudo chown :usuarios -R /stage/hadoop/logs/*

no master

su - aadelmo

wget http://ftp.unicamp.br/pub/apache/spark/spark-2.4.3/spark-2.4.3-bin-hadoop2.7.tgz

tar -xzvf spark-2.4.3-bin-hadoop2.7.tgz

sudo mv spark-2.4.3-bin-hadoop2.7 /stage/spark

sudo chown :usuarios -R /stage/spark
sudo chmod g+rwx -R /stage/spark

sudo nano /etc/environment

	add no path + /stage/spark/bin:/stage/spark/sbin"
	

source /etc/environment

export HADOOP_CONF_DIR=/stage/hadoop/etc/hadoop
export SPARK_HOME=/stage/spark
export LD_LIBRARY_PATH=/stage/hadoop/lib/native/:$LD_LIBRARY_PATH

sudo mv $SPARK_HOME/conf/spark-defaults.conf.template $SPARK_HOME/conf/spark-defaults.conf

sudo nano $SPARK_HOME/conf/spark-defaults.conf

spark.master    yarn
spark.driver.memory    512m
spark.yarn.am.memory    512m
spark.executor.memory    512m


sudo ufw allow 4040
sudo ufw allow 18080

sudo ufw enable
sudo ufw status

nano $SPARK_HOME/conf/spark-defaults.conf

spark.eventLog.enabled  true
spark.eventLog.dir hdfs://master:9000/spark-logs
spark.history.provider            org.apache.spark.deploy.history.FsHistoryProvider
spark.history.fs.logDirectory     hdfs://master:9000/spark-logs
spark.history.fs.update.interval  10s
spark.history.ui.port             18080
	
su - hadoop

hadoop fs -chown -R :usuarios /user
hadoop fs -chmod -R g+rwx /user

/stage/hadoop/bin/hdfs dfs -mkdir /spark-logs


hadoop fs -chown -R :usuarios /spark-logs
hadoop fs -chmod -R g+rwx /spark-logs

/usr/local/hadoop/spark/sbin/start-history-server.sh

sudo ufw allow 8088
sudo ufw allow 9870
sudo ufw enable
sudo ufw status


su - hadoop

hadoop fs -chown -R :usuarios /
hadoop fs -chmod -R g+rwx /

export HADOOP_CONF_DIR=/stage/hadoop/etc/hadoop
export SPARK_HOME=/stage/spark
export LD_LIBRARY_PATH=/stage/hadoop/lib/native/:$LD_LIBRARY_PATH


spark-submit --deploy-mode client --class org.apache.spark.examples.SparkPi /stage/spark/examples/jars/spark-examples_2.11-2.4.3.jar 10

sudo ufw allow 8787



sudo apt-get install r-base
sudo apt-get -y install gdebi-core  libcurl4-openssl-dev  libssl-dev  libxml2-dev
wget https://download2.rstudio.org/rstudio-server-1.1.463-amd64.deb
sudo gdebi rstudio-server-1.1.463-amd64.deb

sudo su - -c "R -e \"install.packages('sparklyr', repos='http://cran.rstudio.com/')\""



wget https://archive.apache.org/dist/hive/hive-3.1.1/apache-hive-3.1.1-bin.tar.gz
sudo mkdir /stage/hive

sudo tar -xvzf apache-hive-3.1.1-bin.tar.gz --directory=/stage/hive/ --strip 1


wget http://central.maven.org/maven2/mysql/mysql-connector-java/5.1.28/mysql-connector-java-5.1.28.jar
sudo cp mysql-connector-java-5.1.28.jar /stage/hive/lib

adicionar bin ao path

sudo nano /stage/hive/conf/hive-site.xml