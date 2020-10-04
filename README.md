# Generating Perl Package Module

**gen_pm** is shell tool for generating Perl package.

Developed in **[bash](https://en.wikipedia.org/wiki/Bash_(Unix_shell))** code: **100%**.

[![gen_pm shell checker](https://github.com/vroncevic/gen_pm/workflows/gen_pm%20shell%20checker/badge.svg)](https://github.com/vroncevic/gen_pm/actions?query=workflow%3A%22gen_pm+shell+checker%22)

The README is used to introduce the tool and provide instructions on
how to install the tool, any machine dependencies it may have and any
other information that should be provided before the tool is installed.

[![GitHub issues open](https://img.shields.io/github/issues/vroncevic/gen_pm.svg)](https://github.com/vroncevic/gen_pm/issues) [![GitHub contributors](https://img.shields.io/github/contributors/vroncevic/gen_pm.svg)](https://github.com/vroncevic/gen_pm/graphs/contributors)

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**

- [Installation](#installation)
- [Usage](#usage)
- [Dependencies](#dependencies)
- [Shell tool structure](#shell-tool-structure)
- [Docs](#docs)
- [Copyright and licence](#copyright-and-licence)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

### Installation

Navigate to release [page](https://github.com/vroncevic/gen_pm/releases) download and extract release archive.

To install modules type the following:

```
tar xvzf gen_pm-x.y.z.tar.gz
cd gen_pm-x.y.z
cp -R ~/sh_tool/bin/   /root/scripts/gen_pm/ver.1.0/
cp -R ~/sh_tool/conf/  /root/scripts/gen_pm/ver.1.0/
cp -R ~/sh_tool/log/   /root/scripts/gen_pm/ver.1.0/
```

![alt tag](https://raw.githubusercontent.com/vroncevic/gen_pm/dev/docs/setup_tree.png)

Or You can use docker to create image/container.

[![gen_pm docker checker](https://github.com/vroncevic/gen_pm/workflows/gen_pm%20docker%20checker/badge.svg)](https://github.com/vroncevic/gen_pm/actions?query=workflow%3A%22gen_pm+docker+checker%22)

### Usage

```
# Create symlink for shell tool
ln -s /root/scripts/gen_pm/ver.1.0/bin/gen_pm.sh /root/bin/gen_pm

# Setting PATH
export PATH=${PATH}:/root/bin/

# Generating Perl package
gen_pm SimplePlTool
```

### Dependencies

**gen_pm** requires next modules and libraries:
* sh_util [https://github.com/vroncevic/sh_util](https://github.com/vroncevic/sh_util)

### Shell tool structure

**gen_pm** is based on MOP.

Code structure:
```
.
├── bin/
│   └── gen_pm.sh
├── conf/
│   ├── gen_pm.cfg
│   └── gen_pm_util.cfg
└── log/
    └── gen_pm.log
```

### Docs

[![Documentation Status](https://readthedocs.org/projects/gen_pm/badge/?version=latest)](https://gen_pm.readthedocs.io/projects/gen_pm/en/latest/?badge=latest)

More documentation and info at:
* [https://gen_pm.readthedocs.io/en/latest/](https://gen_pm.readthedocs.io/en/latest/)
* [https://www.gnu.org/software/bash/manual/](https://www.gnu.org/software/bash/manual/)

### Copyright and licence

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0) [![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

Copyright (C) 2016 by [vroncevic.github.io/gen_pm](https://vroncevic.github.io/gen_pm)

**gen_pm** is free software; you can redistribute it and/or modify
it under the same terms as Bash itself, either Bash version 4.2.47 or,
at your option, any later version of Bash 4 you may have available.

