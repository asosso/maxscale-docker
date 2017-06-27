maxscale-docker
===============

This project is a Docker container for MaxScale. 

[![](https://images.microbadger.com/badges/image/andromedarabbit/maxscale.svg)](https://microbadger.com/images/andromedarabbit/maxscale "Get your own image badge on microbadger.com")
[![](https://images.microbadger.com/badges/license/andromedarabbit/maxscale.svg)](https://microbadger.com/images/andromedarabbit/maxscale "Get your own license badge on microbadger.com")


Base [docker image](http://www.docker.io) to run a [MaxScale](https://mariadb.com/products/mariadb-maxscale) server

    MariaDB MaxScale is an open-source, database-centric proxy that works with MariaDB Enterprise, MariaDB Enterprise Cluster, MariaDB 5.5, MariaDB 10 and Oracle MySQL®. 
    It’s pluggable architecture is designed to increase flexibility and aid customization. Built upon a lightweight, high-speed networking core designed to facilitate throughput.
    MariaDB MaxScale runs between the client application and the database cluster offering connection and statement-based load balancing. 
    MariaDB MaxScale allows scaling of an organization's database infrastructure while keeping the needs of DBAs, Developers and Data Architects in mind.

## Getting the container

The container is very small and available on the Docker Index:

    docker pull andromedarabbit/maxscale

## Using the container

Just trying out MaxScale.

If you just want to run a single instance of MaxScale server to try out its functionality:

    docker run -d andromedarabbit/maxscale

## Build the container

To create the image `andromedarabbit/maxscale`, execute the following command on the maxscale-docker folder:

    docker build -t andromedarabbit/maxscale .

## Thanks

* [MaxScale](https://github.com/mariadb-corporation/MaxScale) - for its MySQL Proxy
* [@MassimilianoPinto](https://github.com/MassimilianoPinto) - for his collaboration

## Contribute

Contributions are welcome.

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License

Copyright 2015 Andrea Sosso
Licensed under the MIT License