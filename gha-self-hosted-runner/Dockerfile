FROM myoung34/github-runner:latest

# Install MS SQL Sever odbc server 17
# https://learn.microsoft.com/en-us/sql/connect/odbc/linux-mac/installing-the-microsoft-odbc-driver-for-sql-server?view=sql-server-ver16&tabs=ubuntu18-install%2Cubuntu17-install%2Cdebian8-install%2Credhat7-13-install%2Crhel7-offline#17
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
RUN curl https://packages.microsoft.com/config/debian/11/prod.list > /etc/apt/sources.list.d/mssql-release.list
RUN apt -y update
RUN ACCEPT_EULA=Y apt -y install msodbcsql17
RUN echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc
RUN source ~/.bashrc
RUN apt -y install unixodbc-dev

# Install MS SQL Sever odbc server 18
# https://learn.microsoft.com/en-us/sql/connect/odbc/linux-mac/installing-the-microsoft-odbc-driver-for-sql-server?view=sql-server-ver16&tabs=ubuntu18-install%2Cubuntu17-install%2Cdebian8-install%2Credhat7-13-install%2Crhel7-offline#18
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
RUN curl https://packages.microsoft.com/config/debian/11/prod.list > /etc/apt/sources.list.d/mssql-release.list
RUN apt -y update
RUN ACCEPT_EULA=Y apt -y install msodbcsql18
RUN echo 'export PATH="$PATH:/opt/mssql-tools18/bin"' >> ~/.bashrc
RUN source ~/.bashrc
RUN apt -y install unixodbc-dev

# Upgrade OpenSSL
# Resolve error: [Microsoft][ODBC Driver 17 for SQL Server]TCP Provider: Error code 0x2746 (10054)
# Ref: https://github.com/mkleehammer/pyodbc/issues/610
# https://askubuntu.com/questions/1284658/how-to-fix-microsoft-odbc-driver-17-for-sql-server-ssl-provider-ssl-choose-cli/1289910#1289910
# https://stackoverflow.com/questions/75133118/upgrade-openssl-in-docker
RUN apt -y upgrade openssl

# Add the following settings to /etc/ssl/openssl.cnf
## MinProtocol = TLSv1.0
## CipherString = DEFAULT@SECLEVEL=1
RUN chmod +rwx /etc/ssl/openssl.cnf
RUN sed -i 's/TLSv1.2/TLSv1/g' /etc/ssl/openssl.cnf
RUN sed -i 's/SECLEVEL=2/SECLEVEL=1/g' /etc/ssl/openssl.cnf