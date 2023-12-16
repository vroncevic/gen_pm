<img align="right" src="https://raw.githubusercontent.com/vroncevic/gen_pm/dev/docs/gen_pm_logo.png" width="25%">

# Generating Perl Package Module

**gen_pm** is shell tool for generating Perl package.

Developed in **[bash](https://en.wikipedia.org/wiki/Bash_(Unix_shell))** code: **100%**.

[![gen_pm_shell_checker](https://github.com/vroncevic/gen_pm/actions/workflows/gen_pm_shell_checker.yml/badge.svg)](https://github.com/vroncevic/gen_pm/actions/workflows/gen_pm_shell_checker.yml)

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

![Debian Linux OS](https://raw.githubusercontent.com/vroncevic/gen_pm/dev/docs/debtux.png)

Navigate to release **[page](https://github.com/vroncevic/gen_pm/releases)** download and extract release archive.

To install **gen_pm** type the following:

```
tar xvzf gen_pm-x.y.tar.gz
cd gen_pm-x.y
cp -R ~/sh_tool/bin/   /root/scripts/gen_pm/ver.x.y/
cp -R ~/sh_tool/conf/  /root/scripts/gen_pm/ver.x.y/
cp -R ~/sh_tool/log/   /root/scripts/gen_pm/ver.x.y/
```

Self generated setup script and execution
```
./gen_pm_setup.sh 

[setup] installing App/Tool/Script gen_pm
	Sun 05 Dec 2021 04:51:29 AM CET
[setup] copy App/Tool/Script structure
[setup] remove github editor configuration files
[setup] set App/Tool/Script permission
[setup] create symbolic link of App/Tool/Script
[setup] done

/root/scripts/gen_pm/ver.2.0/
├── bin/
│   ├── center.sh
│   ├── display_logo.sh
│   └── gen_pm.sh
├── conf/
│   ├── gen_pm.cfg
│   ├── gen_pm.logo
│   └── gen_pm_util.cfg
└── log/
    └── gen_pm.log

3 directories, 7 files
lrwxrwxrwx 1 root root 42 Dec  5 04:51 /root/bin/gen_pm -> /root/scripts/gen_pm/ver.2.0/bin/gen_pm.sh
```

Or You can use docker to create image/container.

### Usage

```
# Create symlink for shell tool
ln -s /root/scripts/gen_pm/ver.x.y/bin/gen_pm.sh /root/bin/gen_pm

# Setting PATH
export PATH=${PATH}:/root/bin/

# Generating Perl package
gen_pm FileCheck

gen_pm ver.2.0
Sun 05 Dec 2021 04:54:08 AM CET

[check_root] Check permission for current session? [ok]
[check_root] Done

                                                       
                                                       
    █████   █████  ███████        ██████  ██████████   
   ██░░░██ ██░░░██░░██░░░██      ░██░░░██░░██░░██░░██  
  ░██  ░██░███████ ░██  ░██      ░██  ░██ ░██ ░██ ░██  
  ░░██████░██░░░░  ░██  ░██      ░██████  ░██ ░██ ░██  
   ░░░░░██░░██████ ███  ░██ █████░██░░░   ███ ░██ ░██  
    █████  ░░░░░░ ░░░   ░░ ░░░░░ ░██     ░░░  ░░  ░░   
   ░░░░░                         ░░                    
                                                        
	                                    
		Info   github.io/gen_pm ver.2.0 
		Issue  github.io/issue
		Author vroncevic.github.io

[gen_pm] Loading basic and util configuration!
100% [================================================]

[load_conf] Loading App/Tool/Script configuration!
[check_cfg] Checking configuration file [/root/scripts/gen_pm/ver.2.0/conf/gen_pm.cfg] [ok]
[check_cfg] Done

[load_conf] Done

[load_util_conf] Load module configuration!
[check_cfg] Checking configuration file [/root/scripts/gen_pm/ver.2.0/conf/gen_pm_util.cfg] [ok]
[check_cfg] Done

[load_util_conf] Done

[check_tool] Checking tool [/usr/bin/h2xs]? [ok]
[check_tool] Done

[gen_pm] Generating module [FileCheck]
Defaulting to backwards compatibility with perl 5.30.0
If you intend this module to be compatible with earlier perl versions, please
specify a minimum perl version with the -b option.

Writing FileCheck/lib/FileCheck.pm
Writing FileCheck/Makefile.PL
Writing FileCheck/README
Writing FileCheck/t/FileCheck.t
Writing FileCheck/Changes
Writing FileCheck/MANIFEST
[gen_pm] Set owner!
[gen_pm] Set permission!
[gen_pm] Done

[logging] Checking directory [/root/scripts/gen_pm/ver.2.0/log/]? [ok]
[logging] Write info log!
[logging] Done

[check_tool] Checking tool [/usr/bin/tree]? [ok]
[check_tool] Done

FileCheck/
├── Changes
├── lib/
│   └── FileCheck.pm
├── Makefile.PL
├── MANIFEST
├── README
└── t/
    └── FileCheck.t

2 directories, 6 files
```

### Dependencies

**gen_pm** requires next modules and libraries
* sh_util [https://github.com/vroncevic/sh_util](https://github.com/vroncevic/sh_util)

### Shell tool structure

**gen_pm** is based on MOP.

Shell tool structure
```
sh_tool/
├── bin/
│   ├── center.sh
│   ├── display_logo.sh
│   └── gen_pm.sh
├── conf/
│   ├── gen_pm.cfg
│   ├── gen_pm.logo
│   └── gen_pm_util.cfg
└── log/
    └── gen_pm.log
```

### Docs

[![Documentation Status](https://readthedocs.org/projects/gen_pm/badge/?version=latest)](https://gen-pm.readthedocs.io/projects/gen_pm/en/latest/?badge=latest)

More documentation and info at
* [https://gen_pm.readthedocs.io/en/latest/](https://gen-pm.readthedocs.io/en/latest/)
* [https://www.gnu.org/software/bash/manual/](https://www.gnu.org/software/bash/manual/)

### Copyright and licence

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0) [![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

Copyright (C) 2016 - 2024 by [vroncevic.github.io/gen_pm](https://vroncevic.github.io/gen_pm)

**gen_pm** is free software; you can redistribute it and/or modify
it under the same terms as Bash itself, either Bash version 4.2.47 or,
at your option, any later version of Bash 4 you may have available.

Lets help and support FSF.

[![Free Software Foundation](https://raw.githubusercontent.com/vroncevic/gen_pm/dev/docs/fsf-logo_1.png)](https://my.fsf.org/)

[![Donate](https://www.paypalobjects.com/en_US/i/btn/btn_donateCC_LG.gif)](https://my.fsf.org/donate/)
