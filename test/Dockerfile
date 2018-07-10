FROM node:8.11.2-stretch

ADD https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh /bin/wait-for-it

RUN chmod +x /bin/wait-for-it

ADD https://github.com/yarnpkg/yarn/releases/download/v1.7.0/yarn-v1.7.0.tar.gz /opt/yarn.tgz

WORKDIR /test
COPY package.json /test
RUN cd /opt \
    && tar xf yarn.tgz \
    && ln -s yarn-1.7.0/bin/yarn /bin/yarn \
    && cd /test \
    && yarn install --modules-folder /node_modules \
    && mkdir -p /node_modules/.bin \
    && for f in node_modules/.bin/*; do ln -sf "$(echo $(readlink $f) | sed -e 's|../../../node_modules/|../|g')" "/node_modules/.bin/$(basename $f)"; done \
    && rm -rf node_modules

ENV PATH="/node_modules/.bin:${PATH}"

ENTRYPOINT ["wait-for-it", "backend:8888", "-t", "0", "--", \
            "wait-for-it", "frontend:8000", "-t", "0", "--", \
            "yarn", "run", "test"]

