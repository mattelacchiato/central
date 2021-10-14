CONFIG_PATH=${ENKETO_SRC_DIR}/config/config.json
echo "generating enketo configuration.."
/bin/bash -c "envsubst '\$DOMAIN:\$ENKETO_SECRET:\$ENKETO_LESS_SECRET:\$ENKETO_API_KEY:\$SUPPORT_EMAIL' < ${CONFIG_PATH}.template > $CONFIG_PATH"

echo "starting pm2/enketo.."
pm2 start --no-daemon app.js -n enketo

