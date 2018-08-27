#!/bin/bash

echo -n " * OS: "
uname -a

echo -n " * Sakuten/devenv@"
git rev-parse HEAD

echo -n " * Sakuten/frontend@"
cd frontend
git rev-parse HEAD
cd ..

cd backend
echo -n " * Sakuten/backend@"
git rev-parse HEAD
cd ..
