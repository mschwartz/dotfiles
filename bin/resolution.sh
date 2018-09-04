#!/bin/bash

xdpyinfo | awk '/dimensions/{print $2}'
