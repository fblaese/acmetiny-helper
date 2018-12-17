#!/bin/sh

ACCOUNTKEY="/var/lib/acme-tiny/letsencrypt/account.key"
CSRDIR="/var/lib/acme-tiny/csr"
ACMEDIR="/var/www/.well-known/acme-challenge"
CERTDIR="/var/lib/acme-tiny/certificate"
INTERMEDIATE="/var/lib/acme-tiny/lets-encrypt-x3-cross-signed.pem"

alias acme-tiny="acme-tiny --account-key "$ACCOUNTKEY" --acme-dir "$ACMEDIR""


wget --quiet -O "$INTERMEDIATE" https://letsencrypt.org/certs/lets-encrypt-x3-cross-signed.pem || exit 1

EXITSTATUS=0
for csr in ${CSRDIR}/*.csr; do
	name="$(basename -s '.csr' "$csr")"

	if ! acme-tiny --csr "$CSRDIR"/"$name".csr > "$CERTDIR"/"$name".pem.tmp; then
		EXITSTATUS=1
		continue
	fi
	cat "$CERTDIR"/"$name".pem.tmp "$INTERMEDIATE" > "$CERTDIR"/"$name".pem
	rm "$CERTDIR"/"$name".pem.tmp
done

sudo systemctl reload nginx || EXITSTATUS=1
exit "$EXITSTATUS"
