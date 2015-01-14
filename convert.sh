#!/bin/bash
find music | grep "mp3$" | xargs -I repl lame --decode -b 16 -m m "repl" "repl.wav"
