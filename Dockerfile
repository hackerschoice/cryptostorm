FROM crazymax/alpine-s6:3.18
LABEL maintainer="The Hacker's Choice - Join us at https://t.me/thcorg"

# Data is send every 25 seconds at least. Session is active for 120 seconds
# => After 120 + 25 we should see a new handshake. HEALTCHECK is tried every 30 seconds
# for a total of 3 times before transition to UNHEALTHY.
HEALTHCHECK CMD [ $(( $(wg show wg0 latest-handshakes 2>/dev/null | awk '{print $2}') + 120 )) -ge $(date -u +%s) ] || exit 1

COPY setup.sh /config/ /fs-root/ /
RUN apk add --no-cache -U wireguard-tools bind-tools conntrack-tools fping curl jq redis \
	&& bash /setup.sh \
 	&& rm -rf /tmp/*
