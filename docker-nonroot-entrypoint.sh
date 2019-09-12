#!/usr/bin/env sh

set -e

# Add a local user with the LOCAL_USER_ID if passed in at runtime or fallback
# to an extremely unlikely to conflict default ID.
USER_ID=${LOCAL_USER_ID:-9001}

adduser -D -u $USER_ID user
export HOME=/home/user

exec su-exec user ${@}
