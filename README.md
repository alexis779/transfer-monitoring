### Fetch dependencies ###

```
  bundle install --deployment
```

### Setup MySQL ##

The MySQL user/password is `alexis`/`Kr0KAYwhquG0`. It can be configured in `config/database.yml`.

```
  $ mysql -uroot
  CREATE DATABASE monitoring_test;
  CREATE DATABASE monitoring_dev;
  CREATE USER 'alexis'@'localhost' IDENTIFIED BY 'Kr0KAYwhquG0';
  GRANT ALL ON monitoring_test.* TO 'alexis'@'localhost';
  GRANT ALL ON monitoring_dev.* TO 'alexis'@'localhost';
```


### Run tests ###

```
  RAILS_ENV=test bundle exec rake db:migrate
  RAILS_ENV=test bundle exec rake test
```


### Load dataset ###

```
  RAILS_ENV=development bundle exec rake db:migrate
```

Import the dataset located at `./pings.json` into the `pings` table:

```
  RAILS_ENV=development bundle exec rake ping:inserts[./pings.json] | mysql -ualexis -pKr0KAYwhquG0 monitoring_dev
```


Execute SQL query to initialize the `ping_aggregates` table:

```
  insert into ping_aggregates(origin, hourly, transfer_time_sum, transfer_time_count, transfer_time_avg) select origin, left(created_at, 13), sum(total_time_ms), count(total_time_ms), sum(total_time_ms) / count(total_time_ms) from pings group by origin, left(created_at, 13)
```


### Run the app ###

Start Rails server

```
  RAILS_ENV=development bundle exec rails s
```

Then go to the [splash page](http://localhost:3000).


### Data Model ###

See `db/schema.rb` for the table definitions.

An new `Ping` updates or inserts a `PingAggregate`.
