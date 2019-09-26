# mapetor
Helps to create overview area maps

### Test results

Branches  | Linux | Windows | Test coverage | Security analysis
----------|-------|---------|---------------| -----------------
Master:   | [![Build Status](https://travis-ci.org/m7b/mapetor.svg?branch=master)](https://travis-ci.org/m7b/mapetor) | [![Build status](https://ci.appveyor.com/api/projects/status/pr971qdw0m8dwmrt?svg=true)](https://ci.appveyor.com/project/m7b/mapetor) | [![Coverage Status](https://coveralls.io/repos/github/m7b/mapetor/badge.svg?branch=master)](https://coveralls.io/github/m7b/mapetor?branch=master) | [![Total alerts](https://img.shields.io/lgtm/alerts/g/m7b/mapetor.svg?logo=lgtm&logoWidth=18)](https://lgtm.com/projects/g/m7b/mapetor/alerts/)

### About

mapetor is a program to create area maps with cutom overlays.

### Build instructions

```bash
mkdir build
cd build
cmake  ..
make
```

### Dependency

To compile this application it requires ...
 - boost
 - wxWidgets
 - Doxygen
 - graphviz
 - UPX
 - gettext
 - Pandoc