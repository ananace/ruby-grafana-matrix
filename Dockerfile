FROM ruby:latest

#RUN apt-get update -qq && apt-get install -y build-essential

ENV APP_HOME /app
ENV RACK_ENV production
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

ADD Gemfile* $APP_HOME/
ADD *gemspec $APP_HOME/
ADD bin $APP_HOME/bin/
ADD lib $APP_HOME/lib/

RUN bundle install --without development

CMD ["bundle", "exec", "bin/server"]
