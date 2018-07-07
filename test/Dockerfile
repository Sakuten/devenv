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
    && yarn install --modules-folder /node_modules

ENTRYPOINT ["yarn", "run", "test"]
