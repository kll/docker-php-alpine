# PHP image based on Alpine Linux

This repository contains an Alpine Linux image with PHP that is setup to run as
a non-root user.

## Why

The reason for using this image as a base is to avoid having permission issues
when using Docker Volumes. The main use-case for volumes is persisting data
between container runs since the container itself is ephemeral. This is useful
for data directories when running things like databases in a container but also
for sharing code folders for development actions like CI/CD pipelines or even
just wrapping up utility apps in a container so they can run from anywhere.

There are two main problems with how things run by default:

  1. If you write to the volume you won't be able to access the files that the
     container has written because the process in the container usually runs
     as root.
  2. You shouldn't run the process inside your containers as root for general
     security reasons but even if you run as some other hard-coded user it
     still won't match your local user account.

The problem is very apparent in development and testing environments because
at some point you want to remove or overwrite files that the process in the
container has created but you can't without using `sudo` because the files
are owned either by UID 0 (root) or by some other UID that was hard coded in
the Dockerfile.

## Usage

Create a Dockerfile that that uses this image as a base.

```dockerfile
FROM gslime/php-alpine
RUN apk add --no-cache some-package
CMD [ "some-command" ]
```

Run your image setting the `LOCAL_USER_ID` environment variable to your UID.

```console
docker run --rm -it -e LOCAL_USER_ID=`id -u $USER` your-image
```

If you do not set `LOCAL_USER_ID` then the the container will default to 9001
which is unlikely to conflict with any other users in the container.

## Inspiration

The general technique was inspired by and lots of wording in this readme was
taken from [this blog post](https://denibertovic.com/posts/handling-permissions-with-docker-volumes/).

## License

The code in this repository, unless otherwise noted, is MIT licensed. See the [LICENSE](LICENSE) file in this repository.
