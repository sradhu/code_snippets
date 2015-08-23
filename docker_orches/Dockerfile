FROM ruby
RUN apt-get update

RUN apt-get install -qq -y nodejs

# Intall software-properties-common for add-apt-repository
RUN apt-get install -qq -y software-properties-common
#RUN apt-get install -qq -y python-software-properties
# Install Nginx.
#RUN add-apt-repository -y ppa:nginx/stable
RUN echo "deb http://ppa.launchpad.net/nginx/stable/ubuntu lucid main" > /etc/apt/sources.list.d/nginx-stable-lucid.list
#RUN http://nginx.org/packages/debian/ squeeze nginx >> /etc/apt/sources.list
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys C300EE8C

RUN apt-get update
RUN apt-get install -qq -y nginx
RUN echo "\ndaemon off;" >> /etc/nginx/nginx.conf
RUN chown -R www-data:www-data /var/lib/nginx
# Add default nginx config
ADD nginx-sites.conf /etc/nginx/sites-enabled/default

RUN gem install foreman

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev
RUN mkdir /myapp
WORKDIR /myapp

ONBUILD COPY Gemfile /myapp/
ONBUILD COPY Gemfile.lock /myapp/
ONBUILD RUN bundle install
ONBUILD COPY . /myapp
ADD unicorn.rb /myapp/config/unicorn.rb

ADD Procfile /myapp/Procfile

ENV RAILS_ENV developement

CMD bundle exec rake assets:precompile && foreman start -f Procfile

ENTRYPOINT /bin/bash

