#!/bin/bash

echo -n " * OS: "
uname -a

echo -n " * devenv: "
git rev-parse HEAD

echo -n " * frontend: "
cd frontend
git rev-parse HEAD
cd ..

cd backend
echo -n " * backend: "
git rev-parse HEAD
cd ..
