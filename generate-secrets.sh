#!/bin/bash
set -e

ROOT="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

source "$ROOT/.env"

if [ -z "$ENKETO_SECRET" ]; then
  export ENKETO_SECRET=$(LC_ALL=C tr -dc '[:alnum:]' < /dev/urandom | head -c64)
fi

if [ -z "$ENKETO_LESS_SECRET" ]; then
  export ENKETO_LESS_SECRET=$(LC_ALL=C tr -dc '[:alnum:]' < /dev/urandom | head -c32)
fi

if [ -z "$ENKETO_API_KEY" ]; then
  export ENKETO_API_KEY=$(LC_ALL=C tr -dc '[:alnum:]' < /dev/urandom | head -c128)
fi

result=$(envsubst < "$ROOT/.env")
echo "$result" > "$ROOT/.env"
