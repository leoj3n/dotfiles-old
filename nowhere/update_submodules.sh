#!/bin/bash

echo
echo 'Updating Submodules...'
echo

cd .. && git submodule foreach git pull

echo
echo 'Building YouTubeCenter...'
echo

cd submodules/chrome/YouTubeCenter && ant copy-chrome

echo
echo 'Unzip Octotree...'
echo

cd ../octotree/dist && rm -rf chrome && unzip chrome.zip -d chrome

echo
echo 'Finished updating submodules.'
echo


