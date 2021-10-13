echo "running migrations.."
node -e 'const { withDatabase, migrate } = require("./lib/model/migrate"); withDatabase(require("config").get("default.database"))(migrate);'

echo "starting cron.."
cron -f &

MEMTOT=$(vmstat -s | grep 'total memory' | awk '{ print $1 }')
if [ "$MEMTOT" -gt "1100000" ]
then
  WORKER_COUNT=4
else
  WORKER_COUNT=1
fi
echo "using $WORKER_COUNT worker(s) based on available memory ($MEMTOT).."

echo "starting server."
pm2-runtime ./pm2.config.js --instances $WORKER_COUNT

