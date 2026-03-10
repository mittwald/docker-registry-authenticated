FROM registry:3

RUN apk add -U apache2-utils

COPY auth-entrypoint.sh /auth-entrypoint.sh

ENTRYPOINT ["/auth-entrypoint.sh"]
CMD [ "/etc/distribution/config.yml" ]