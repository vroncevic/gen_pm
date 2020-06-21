GEN_PM
-------

.. toctree::
 :hidden:

 self

**gen_pm** is shell tool for generating Perl package.

Developed in `bash <https://en.wikipedia.org/wiki/Bash_(Unix_shell)>`_ code: **100%**.

The README is used to introduce the tool and provide instructions on
how to install the tool, any machine dependencies it may have and any
other information that should be provided before the tool is installed.

|GitHub issues| |Documentation Status| |GitHub contributors|

.. |GitHub issues| image:: https://img.shields.io/github/issues/vroncevic/gen_pm.svg
   :target: https://github.com/vroncevic/gen_pm/issues

.. |GitHub contributors| image:: https://img.shields.io/github/contributors/vroncevic/gen_pm.svg
   :target: https://github.com/vroncevic/gen_pm/graphs/contributors

.. |Documentation Status| image:: https://readthedocs.org/projects/gen_pm/badge/?version=latest
   :target: https://gen_pm.readthedocs.io/projects/gen_pm/en/latest/?badge=latest

INSTALLATION
-------------

Navigate to release `page`_ download and extract release archive.

.. _page: https://github.com/vroncevic/gen_pm/releases

To install **gen_pm** type the following:

.. code-block:: bash

   tar xvzf gen_pm-x.y.z.tar.gz
   cd gen_pm-x.y.z
   cp -R ~/sh_tool/bin/   /root/scripts/gen_pm/ver.1.0/
   cp -R ~/sh_tool/conf/  /root/scripts/gen_pm/ver.1.0/
   cp -R ~/sh_tool/log/   /root/scripts/gen_pm/ver.1.0/

DEPENDENCIES
-------------

**gen_pm** requires next modules and libraries:
    sh_util `https://github.com/vroncevic/sh_util <https://github.com/vroncevic/sh_util>`_

SHELL TOOL STRUCTURE
---------------------

**gen_pm** is based on MOP.

Code structure:

.. code-block:: bash

   .
   ├── bin/
   │   └── gen_pm.sh
   ├── conf/
   │   ├── gen_pm.cfg
   │   └── gen_pm_util.cfg
   └── log/
       └── gen_pm.log

COPYRIGHT AND LICENCE
----------------------

|License: GPL v3| |License: Apache 2.0|

.. |License: GPL v3| image:: https://img.shields.io/badge/License-GPLv3-blue.svg
   :target: https://www.gnu.org/licenses/gpl-3.0

.. |License: Apache 2.0| image:: https://img.shields.io/badge/License-Apache%202.0-blue.svg
   :target: https://opensource.org/licenses/Apache-2.0

Copyright (C) 2016 by `vroncevic.github.io/gen_pm <https://vroncevic.github.io/gen_pm>`_

This tool is free software; you can redistribute it and/or modify it
under the same terms as Bash itself, either Bash version 4.2.47 or,
at your option, any later version of Bash 4 you may have available.

