#!/bin/bash
# TECE CRM helper. Usage:  ~/crm restart | ~/crm update | ~/crm status | ~/crm undo
APP=~/exhibition-card-scanner
SRV=$APP/server
ENV=~/nodevenv/exhibition-card-scanner/server/22/bin/activate
URL=https://cards.tece.com.tr

ok()   { echo -e "\e[32m✔ $*\e[0m"; }
bad()  { echo -e "\e[31m✘ $*\e[0m"; exit 1; }
step() { echo -e "\n\e[1m▶ $*\e[0m"; }

restart() {
  mkdir -p $SRV/tmp && touch $SRV/tmp/restart.txt
  ok "Restarted. Open $URL (first load can take 10-20 seconds)."
}

status() {
  step "Status"
  echo "Server version : $(curl -s $URL/api/version)"
  echo "Database update: $(ls $SRV/dist/db/migrations 2>/dev/null | tail -1)"
  echo "Built on       : $(date -r $SRV/dist/index.js '+%d.%m.%Y %H:%M' 2>/dev/null)"
  echo "Backups        : $(ls -d ~/backup-crm-* 2>/dev/null | tr '\n' ' ')"
}

update() {
  SZ=$(ls -t $APP/server-full*.zip ~/server-full*.zip 2>/dev/null | head -1)
  WZ=$(ls -t $APP/web-dist*.zip ~/web-dist*.zip $APP/web/dist/web-dist*.zip 2>/dev/null | head -1)
  [ -z "$SZ" ] && [ -z "$WZ" ] && bad "No zip found. Upload server-full...zip / web-dist...zip into $APP with File Manager."
  echo "Server zip: ${SZ:-none}"
  echo "Web zip   : ${WZ:-none}"

  step "1/4 Backup"
  B=~/backup-crm-$(date +%F-%H%M)
  mkdir -p $B && cp -a $SRV/data $B/data && cp -a $SRV/src $B/src && cp -a $APP/web/dist $B/web-dist || bad "Backup failed - nothing was changed."
  ok "Backup in $B"

  if [ -n "$SZ" ]; then
    step "2/4 Server"
    source $ENV || bad "Node environment not found."
    cd $SRV && unzip -oq "$SZ" || bad "Could not unpack $SZ"
    npm install --include=dev --no-audit --no-fund --loglevel=error || bad "npm install failed. Run: ~/crm undo"
    npm run build --silent || bad "Build failed. Run: ~/crm undo"
    mkdir -p ~/crm-done && mv "$SZ" ~/crm-done/
    ok "Server built"
  fi

  if [ -n "$WZ" ]; then
    step "3/4 Website"
    mkdir -p ~/crm-done && mv "$WZ" ~/crm-done/ && WZ=~/crm-done/$(basename "$WZ")
    cd $APP/web && rm -rf dist && mkdir dist && unzip -q "$WZ" -d dist || bad "Could not unpack the website. Run: ~/crm undo"
    [ -f dist/index.html ] || bad "Website files look wrong. Run: ~/crm undo"
    ok "Website installed"
  fi

  step "4/4 Restart"
  restart
  status
}

undo() {
  B=$(ls -d ~/backup-crm-* 2>/dev/null | sort | tail -1)
  [ -z "$B" ] && bad "No backup found."
  echo "Going back to: $B (code and website only - your data stays as it is)"
  read -p "Type yes to continue: " a; [ "$a" = "yes" ] || exit 0
  rm -rf $SRV/src $APP/web/dist && cp -a $B/src $SRV/src && cp -a $B/web-dist $APP/web/dist
  source $ENV && cd $SRV && npm install --include=dev --no-audit --no-fund --loglevel=error && npm run build --silent || bad "Rebuild failed - send a screenshot."
  restart
}

case "$1" in
  restart) restart ;;
  update)  update ;;
  status)  status ;;
  undo)    undo ;;
  *) echo "Use:  ~/crm update   (install new zips)"
     echo "      ~/crm restart  (restart the app)"
     echo "      ~/crm status   (what is running)"
     echo "      ~/crm undo     (go back to the last backup)" ;;
esac
