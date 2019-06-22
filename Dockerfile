FROM ruby:2.5.1

ENV LANG C.UFF-8

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - \
&&  apt-get update && apt-get install -y  \
    --no-install-recommends \
    build-essential \
    nodejs \
    vim \
&&  apt-get clean \
&&  rm -rf /var/lib/apt/lists/*

WORKDIR /myapp

COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock

RUN mkdir -p tmp/sockets

RUN bundle install
COPY . /myapp

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]
