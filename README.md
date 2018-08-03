# Grafana Matrix

A Grafana webhook ingress for sending Matrix notifications

Working:
- Simple notifications

TODO:
- Authenticated requests
- Proper styling

## Installation

Until a more proper release is done;  
Download the git repo, instantiate the bundle, create a proper configuration file, and launch the server

```sh
git clone https://github.com/ananace/ruby-grafana-matrix
cd ruby-grafana-matrix
bundle install --path=vendor
cp config.yml.example config.yml
vi config.yml
# Edit the configuration to suit your requirements

bundle exec bin/server
```

## Usage

TODO

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ananace/ruby-grafana-matrix

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
