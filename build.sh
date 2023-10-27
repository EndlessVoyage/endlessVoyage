#!/usr/bin/env bash

set -e

rm -rf dist/
mkdir -p dist/web
mkdir -p dist/linux
mkdir -p dist/windows

echo 'Building for web ...'
godot --no-window --export-release "HTML5" dist/web/index.html
echo 'done.'

echo 'Building for linux ...'
godot --no-window --export-release 'Linux/X11' dist/linux/rootedJourney.x86_64
chmod a+x dist/linux/rootedJourney.x86_64
echo 'done.'

echo 'Building for Windows ...'
godot --no-window --export-release 'Windows Desktop' dist/windows/rootedJourney.exe
echo 'done.'

