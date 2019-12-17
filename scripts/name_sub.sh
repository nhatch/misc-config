#!/bin/bash
old="$1"
new="$2"
find . -name \*${old}\* | sed -e 's/\(.*\)'${old}'\(.*\)/"\1'${old}'\2" "\1'${new}'\2"/' | xargs -n2 mv
