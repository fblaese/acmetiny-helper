# acmetiny-helper

This repository contains the basic structure, nginx snippet and a renewal script for my acme-tiny setup.

## Account Key
```
openssl genrsa 4096 > /var/lib/acme-tiny/letsencrypt/account.key
```

## Permissions
__Remember__ to set __secure__ file permissions.
- domain private keys accessible to root only.
- acme account key accessible to acme user only.

The __acme user__ (which executes the renewal script) has to be able to __reload nginx__ via systemd!

## Cron
```/var/lib/acme-tiny/renew.sh 2>> /var/log/acme_tiny.log```
