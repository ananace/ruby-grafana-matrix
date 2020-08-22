# Grafana Matrix

A Grafana webhook ingress for sending Matrix notifications

Working:
- Simple notifications
- Authenticated requests

TODO:
- Proper styling

## Installation / Usage

Until a more proper release is done;  
Download the git repo, instantiate the bundle, create a proper configuration file, and launch the server

```sh
git clone https://github.com/ananace/ruby-grafana-matrix
cd ruby-grafana-matrix
bundle install --path=vendor
cp config.yml.example config.yml
vi config.yml
# Edit the configuration to suit your requirements

bundle exec rackup
```

You would then add the ingester as a Grafana webhook channel like so;
![Grafana config](https://i.imgur.com/Cu4m8Ew.png)

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ananace/ruby-grafana-matrix

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
