FROM ruby:3.0-alpine

#RUN apt-get update -qq && apt-get install -y build-essential

ENV APP_HOME /app
ENV RACK_ENV production
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

ADD Gemfile* $APP_HOME/
ADD *gemspec $APP_HOME/
ADD config.yml.example config.ru $APP_HOME/
ADD lib $APP_HOME/lib/

RUN bundle install --without development

EXPOSE 9292/tcp
CMD ["bundle", "exec", "rackup"]
