FROM crystallang/crystal

# Add folder for app:
ENV APP_HOME /myapp
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

# Add Dependencies (Shards):
# ADD ./shard.yml $APP_HOME/shard.yml
# ADD ./shard.lock $APP_HOME/shard.lock
ADD ./shard.* $APP_HOME/
RUN crystal -v
RUN crystal deps

# Add app:
ADD . $APP_HOME
