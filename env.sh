#!/bin/bash

# common
export LOG_LEVEL=info
export pdsFQDN=web5.xjdao.xyz
export plcFQDN=plc.xjdao.xyz
export bskyFQDN=bsky.xjdao.xyz
export ozoneFQDN=ozone.xjdao.xyz

export POSTGRES_USER=postgres
export POSTGRES_PASSWORD=postgres

# plc
export PLC_PORT=32582

# pds
export PDS_PORT=32583
export PDS_ADMIN_PASSWORD=$(openssl rand --hex 16)
export PDS_JWT_SECRET=$(openssl rand --hex 16)
export PDS_PLC_ROTATION_KEY_K256_PRIVATE_KEY_HEX=$(openssl rand --hex 32)

# bsky
export BSKY_PORT=32584
export BSKY_HOSTNAME=bsky.xjdao.xyz
export BSKY_ADMIN_PASSWORDS=$(openssl rand --hex 16)
export BSKY_LABELS_FROM_ISSUER_DIDS=did:web:${pdsFQDN},did:web:${plcFQDN},did:web:${bskyFQDN},did:web:${ozoneFQDN}
export BSKY_SERVICE_SIGNING_KEY=$(openssl rand --hex 32)
