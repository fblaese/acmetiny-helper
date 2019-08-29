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

The __acme user__ (which executes the renewal script) has to be able to __reload nginx__ via systemd using sudo!
```
acme    ALL=(root) NOPASSWD: /bin/systemctl reload nginx
```

## TLS Key, CSR, Certificate
```
openssl genrsa 4096 > /etc/ssl/private/example.com.pem

# For single domain
openssl req -new -sha256 -key /etc/ssl/private/example.com.pem -subj "/CN=example.com" > /var/lib/acme-tiny/csr/example.com.csr
```

Run script.

## Cron
```/var/lib/acme-tiny/renew.sh 2>> /var/log/acme_tiny.log```
