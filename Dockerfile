FROM ubuntu:20.04

#Beign interactive build failing adding ENV for make it noninteractive
ENV DEBIAN_FRONTEND noninteractive

# Set SQL environment variables
ENV MYSQL_DATABASE=mydatabase \
    MYSQL_USER=myuser \
    MYSQL_PASSWORD=mypassword \
    MYSQL_ROOT_PASSWORD=myrootpassword

# Install required packages

# Getting error while install mysql-server:5.6 using latest version.
RUN apt-get update && \
    apt-get install -y \
        nginx \
        php7.4 \
        php7.4-fpm \
        php7.4-mysql \
        mysql-server \ 
        && \
    rm -rf /var/lib/apt/lists/*


# Create directory for application code
RUN mkdir -p /var/www/html

# Copy Nginx configuration
COPY ./nginx.conf /etc/nginx/sites-available/default

# Copy application code to the container
COPY ./app /var/www/html

# Expose port 80 for Nginx
EXPOSE 80

# Start services
CMD service mysql start && service php7.4-fpm start && nginx -g "daemon off;"
