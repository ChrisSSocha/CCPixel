CCPixel
=======

CCPixel is a `cc.xml` (build monitor) driver for [BlinkStick](http://blinkstick.com/)

Installation
------------

Install `Bundler`:

    $ gem install bundler

Install all of the required gems:

    $ bundle install

Note: We use a `libusb` ruby binding, that has some prerequisites. Please see [documentation](https://github.com/larskanis/libusb#prerequisites)

Usage
-----

Configure `config.yml`:

    url: "http://example.com/cctray.xml"
    sleep: 10
    auth:
      enabled: true
      username: "user"
      password: "pass"

Run the main file:

    $ bundle exec rake run
    
TODO
-------

* Add option to only monitor certain pipelines to `config.yml`
* Better testing of Error scenarios

Testing
-------

To run the tests:

    $ bundle exec rake test


Contributing
------------

1. Fork it.
2. Create a branch (`git checkout -b my_markup`)
3. Commit your changes (`git commit -am "Added Snarkdown"`)
4. Push to the branch (`git push origin my_markup`)
5. Open a [Pull Request][1]
6. Enjoy a refreshing Diet Coke and wait

License
-------

Unless otherwise stated, this software is licensed under `The MIT License` (Please see `./LICENSE`).

The licences of all dependencies can be seen in `./doc/license_dependencies`.

[1]: http://github.com/github/markup/pulls
