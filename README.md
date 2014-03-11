CCPixel
=======

CCPixel is a CCTray driver for [BlinkStick](http://blinkstick.com/)

Installation
------------

Install `Bundler`:

    $ gem install bundler

Install all of the required gems:

    $ bundle install

Usage
-----

Configure `config.yml`:

    url: "http://example.com/cctray.xml"
    sleep: 10

Run the main file:

    $ bundle exec ruby src/cc_runner.rb

Testing
-------

To run the tests:

    $ bundle exec rspec


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
