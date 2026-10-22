#!/bin/sh
# Builds Talishar-FE (mounted at /app) into /dist for Caddy, used by docker-compose.pi.yml.
# Skips the build when /dist already holds the current Talishar-FE commit, so a reboot
# does not rebuild for minutes. Set FORCE_FRONTEND_BUILD=1 to rebuild anyway
# (e.g. after uncommitted changes in Talishar-FE).
set -e

commit=$(git -c safe.directory=/app -C /app rev-parse HEAD 2>/dev/null || echo unknown)
if [ "$FORCE_FRONTEND_BUILD" != "1" ] && [ "$commit" != "unknown" ] \
  && [ -f /dist/index.html ] && [ "$(cat /dist/.talishar-fe-commit 2>/dev/null)" = "$commit" ]; then
  echo "Frontend already built for Talishar-FE $commit, skipping."
  exit 0
fi

npm install
npm run build -- --outDir /dist --emptyOutDir
echo "$commit" > /dist/.talishar-fe-commit
echo "Frontend built for Talishar-FE $commit."
