# -*- encoding: utf-8 -*-

# import path
import sys
if sys.version_info.major >= 3:
    paths = [
        '/usr/local/lib/python3.2',
        '/usr/local/lib/python3.2/plat-linux2',
        '/usr/local/lib64/python3.2/lib-dynload',
        '/usr/local/lib/python3.2/site-packages',
        ]
    for p in paths:
        sys.path.append(p)
else:
    paths = [
        '/usr/local/lib/python2.7',
        '/usr/local/lib/python2.7/plat-linux2',
        '/usr/local/lib64/python2.7/lib-dynload',
        '/usr/local/lib/python2.7/site-packages',
        ]
    for p in paths:
        sys.path.append(p)
del sys, paths, p


import atexit
import os
import readline
import rlcompleter

# history
histfile = os.path.join(os.environ['HOME'], '.pyhistory')
readline.set_history_length(1000)
atexit.register(readline.write_history_file, histfile)
if os.path.exists(histfile):
    readline.read_history_file(histfile)

# <Tab> completion
readline.parse_and_bind('tab: complete')

del atexit, readline, rlcompleter, os
del histfile

