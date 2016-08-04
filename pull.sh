#!/bin/sh

git pull
git submdule sync
git submodule update --init --recursive

