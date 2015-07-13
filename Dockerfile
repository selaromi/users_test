FROM ruby:2.2.2
RUN apt-get update -qq && apt-get install -y build-essential
ENV APP_HOME /opt/application
WORKDIR $APP_HOME

# Add Gemfile stuff first as a build optimization
# This way the `bundle install` is only run when either Gemfile or Gemfile.lock is changed
# This is because `bundle install` can take a long time
# Without this optimization `bundle install` would run if _any_ file is changed within the project, no bueno
ADD Gemfile* $APP_HOME/
RUN bundle install

# This will now install anything in Gemfile.tip
# This way you can add new gems without rebuilding _everything_ to add 1 gem
# Anything that was already installed from the main Gemfile will be re-used
ADD Gemfile.tip $APP_HOME/
RUN bundle install

# Add rake and its dependencies
ADD config $APP_HOME/config
ADD Rakefile $APP_HOME/

ADD . $APP_HOME

ENV PATH $APP_HOME/bin:$PATH
ENTRYPOINT ["$APP_HOME/bin/rails"]
CMD ["server","-b","0.0.0.0"]
