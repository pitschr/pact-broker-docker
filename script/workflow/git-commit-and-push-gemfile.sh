#!/bin/sh

set -euo

git add pact_broker/Gemfile.lock

if [ -n "${RELEASED_GEM_NAME}" ] && [ -n "${RELEASED_GEM_VERSION}" ]; then
  git commit -m "feat(deps): update ${RELEASED_GEM_NAME} gem to version ${RELEASED_GEM_VERSION}"
else
  updated_gems=$(git diff --staged pact_broker/Gemfile.lock | grep '^+' | grep '(' | sed -e "s/+ *//" | paste -sd "," - | sed -e 's/,/, /g')
  git commit -m "feat(deps): update to ${updated_gems}"
fi

git push