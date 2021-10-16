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

You would then add the ingester as a Grafana webhook channel like so - albeit with port 9292 unless changed;
![Grafana config](https://i.imgur.com/Cu4m8Ew.png)

## Docker

Build the image:

`docker build -t ruby-grafana-matrix:latest .`

Create a proper configuration file:

```sh
cp config.yml.example config.yml
vi config.yml
```
Run the resulting container, and mount your `config.yml` inside of it:

`docker run -v $PWD/config.yml:/app/config.yml --name ruby-grafana-matrix ruby-grafana-matrix:latest`

If running the container on the same host as Grafana, you can attach it to the same Docker network and use the container name in the Grafana webhook URL.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ananace/ruby-grafana-matrix

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
