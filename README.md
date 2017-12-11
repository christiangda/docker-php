# apache-php7-fpm

Usage
```
docker pull christiangda/php

docker run -d --name php7 \
  --publish 80:80 \
  christiangda/php:latest
```

build with default arguments
```
docker build --rm --tag christiangda/php:latest .
```

build with arguments
```
docker build --rm \
  --build-arg ALPINE_VERSION=3.7 \
  --build-arg PHP_VERSION=7.1.12-r0 \
  --tag christiangda/php:apache2-fpm-alpine-7.1.12-r0 \
  --tag christiangda/php:7.1.12-r0 \
  --tag christiangda/php:latest .

```

run interactive
```
docker run --tty --interactive --rm --name php7 \
  --publish 80:80 \
  christiangda/php:latest
```

look inside the container
```
docker run --tty --interactive --rm --name php7 \
  christiangda/php:latest bash
```
