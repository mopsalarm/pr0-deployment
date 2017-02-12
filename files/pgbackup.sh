#!/bin/bash -e

function rename {
  if [ -f "$1" ] ; then
    mv "$1" "$2"
  fi
}

# rotate backups
rm -f /backup/pr0gramm.dump.6
rename /backup/pr0gramm.dump.5 /backup/pr0gramm.dump.6
rename /backup/pr0gramm.dump.4 /backup/pr0gramm.dump.5
rename /backup/pr0gramm.dump.3 /backup/pr0gramm.dump.4
rename /backup/pr0gramm.dump.2 /backup/pr0gramm.dump.3
rename /backup/pr0gramm.dump.1 /backup/pr0gramm.dump.2
rename /backup/pr0gramm.dump /backup/pr0gramm.dump.1

# make a new one
docker run --rm -v /backup:/backup postgres:9.6-alpine \
  pg_dump -Fc -f /backup/pr0gramm.dump --dbname "$1"
