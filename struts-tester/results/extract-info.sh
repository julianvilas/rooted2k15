#!/bin/bash
find . -name "*debug.txt" -print -exec sh -c 'grep "\-\-" {} | sed -e s/-//g | sort -u | tee info/{}.dbg' \; > info/classes.txt
find . -name "struts2-*.txt" ! -name "*debug*" -print -exec sh -c 'cat {} | rev | cut -f1 -d "." | rev | sort -u | tee info/{}.dbg' \; > info/setmethods.txt
