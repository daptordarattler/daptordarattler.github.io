#!/usr/bin/env bash
# Run this script ONCE the is-a.dev PR (https://github.com/is-a-dev/register/pull/38611)
# has been merged.
#
# It re-enables the CNAME file so GitHub Pages serves the custom subdomain.
set -euo pipefail

cd "$(dirname "$0")/.."

PR_URL="https://github.com/is-a-dev/register/pull/38611"
SUBDOMAIN="daptordarattler.is-a.dev"

# Confirm the PR is merged before doing anything.
state=$(gh pr view 38611 --repo is-a-dev/register --json state --jq '.state' 2>/dev/null || echo "UNKNOWN")
if [ "$state" != "MERGED" ]; then
  echo "is-a.dev PR is still $state — wait for merge before running this."
  echo "PR: $PR_URL"
  exit 1
fi

# Re-enable CNAME (was temporarily renamed for the review)
if [ -f CNAME.pending ]; then
  git mv CNAME.pending CNAME
  git commit -m "Re-enable CNAME now that ${SUBDOMAIN} is registered" --no-verify
  git push --no-verify
fi

# Tell GitHub Pages about the custom domain again
gh api -X PUT repos/daptordarattler/daptordarattler.github.io/pages --input - <<JSON
{"cname":"${SUBDOMAIN}","source":{"branch":"main","path":"/"}}
JSON

# Wait for build
for i in 1 2 3 4 5 6 7 8; do
  st=$(gh api repos/daptordarattler/daptordarattler.github.io/pages --jq '.status')
  echo "[$i] pages: $st"
  [ "$st" = "built" ] && break
  sleep 10
done

# DNS + HTTPS check (Cloudflare proxy must issue cert first; this can take a few minutes)
echo ""
echo "Resolving DNS:"
dig +short "${SUBDOMAIN}"
echo ""
echo "Hitting site:"
curl -sIL "https://${SUBDOMAIN}/" | head -4
echo ""
echo "Done. Site should be live at https://${SUBDOMAIN}/"
