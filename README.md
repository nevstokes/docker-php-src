# PHP Source Docker Images

Fetches, checks and verifies the source archives for building currently supported PHP versions.

Makes use of the other branches in this repository and their associated Docker images:

- [`nevstokes/php-src:fetchdeps`](https://github.com/nevstokes/docker-php-src/tree/fetchdeps) is an Alpine-based image containing [Axel](https://github.com/axel-download-accelerator/axel) and [GnuPG](https://gnupg.org/) with the signatures of the [PHP release managers](https://secure.php.net/gpg-keys.php) already imported
- [`nevstokes/php-src:hashes`](https://github.com/nevstokes/docker-php-src/tree/hashes) contains a file listing of the latest supported PHP version numbers and checksum hashes as per the PHP release [RSS feed](https://secure.php.net/releases/feed.php)
