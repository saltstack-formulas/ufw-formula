.. _readme:

ufw-formula
===========

|img_travis| |img_sr|

.. |img_travis| image:: https://travis-ci.com/saltstack-formulas/ufw-formula.svg?branch=master
   :alt: Travis CI Build Status
   :scale: 100%
   :target: https://travis-ci.com/saltstack-formulas/ufw-formula
.. |img_sr| image:: https://img.shields.io/badge/%20%20%F0%9F%93%A6%F0%9F%9A%80-semantic--release-e10079.svg
   :alt: Semantic Release
   :scale: 100%
   :target: https://github.com/semantic-release/semantic-release

Formula to set up and configure ufw

.. contents:: **Table of Contents**

General notes
-------------

See the full `SaltStack Formulas installation and usage instructions
<https://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html>`_.

If you are interested in writing or contributing to formulas, please pay attention to the `Writing Formula Section
<https://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html#writing-formulas>`_.

If you want to use this formula, please pay attention to the ``FORMULA`` file and/or ``git tag``,
which contains the currently released version. This formula is versioned according to `Semantic Versioning <http://semver.org/>`_.

See `Formula Versioning Section <https://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html#versioning>`_ for more details.

Contributing to this repo
-------------------------

**Commit message formatting is significant!!**

Please see `How to contribute <https://github.com/saltstack-formulas/.github/blob/master/CONTRIBUTING.rst>`_ for more details.

Available states
----------------

.. contents::
    :local:

``ufw``
^^^^^^^
Installs and configures the ufw package.

``ufw.package``
^^^^^^^^^^^^^^^
Installs the ufw package.

``ufw.config``
^^^^^^^^^^^^^^
This state manages the file ``ufw.conf`` under ``/etc/ufw`` (template found in "ufw/files"). The configuration is populated by values in "ufw/map.jinja" based on the package's default values (and RedHat, Debian, Suse and Arch family distribution specific values), which can then be overridden by values of the same name in pillar.


Usage
-----

All the configuration for the firewall is done via pillar (pillar.example).

Enable firewall, applying default configuration:

.. code-block:: javascript

   ufw:
     enabled: True

Allow 80/tcp (http) traffic from only two remote addresses:

.. code-block::

   ufw:
     services:
       http:
         protocol: tcp
         from_addr:
           - 10.0.2.15
           - 10.0.2.16

Allow 443/tcp (https) traffic from network 10.0.0.0/8 to an specific local ip:

.. code-block::

   ufw:
     services:
       https:
         protocol: tcp
         from_addr:
           - 10.0.0.0/8
         to_addr: 10.0.2.1

Allow from a service port:

.. code-block::

   ufw:
     services:
       smtp:
         protocol: tcp

Allow from an specific port, by number:

.. code-block::

   ufw:
     services:
       139:
         protocol: tcp

Allow from a range of ports, udp:

.. code-block::

   ufw:
     services:
       "10000:20000":
         protocol: udp

Allow from a range of ports, tcp and udp

.. code-block::

   ufw:
     services:
       "10000:20000/tcp":
         to_port: "10000:20000"
         protocol: tcp
       "10000:20000/udp":
         to_port: "10000:20000"
         protocol: udp

Allow from two specific ports, udp:

.. code-block::

   ufw:
     services:
       "30000,40000":
         protocol: udp

Allow an application defined at /etc/ufw/applications.d/:

.. code-block::

   ufw:
     applications:
       - OpenSSH

Allow generic traffic on ens7, and allow 1 ip to access port 22 and explicitly block all others:

.. code-block::

   ufw:
     interfaces:
       ens7:
     services:
       22:
         protocol: tcp
         to_port: 22
         from_addr:
           - 192.168.1.1
       22/deny:
         protocol: tcp
         to_port: 22
         deny: true
         force_first: false

Testing
-------

Linux testing is done with ``kitchen-salt``.

Requirements
^^^^^^^^^^^^

* Ruby
* Docker

.. code-block:: bash

   $ gem install bundler
   $ bundle install
   $ bin/kitchen test [platform]

Where ``[platform]`` is the platform name defined in ``kitchen.yml``,
e.g. ``debian-9-2019-2-py3``.

``bin/kitchen converge``
^^^^^^^^^^^^^^^^^^^^^^^^

Creates the docker instance and runs the ``ufw`` main state, ready for testing.

``bin/kitchen verify``
^^^^^^^^^^^^^^^^^^^^^^

Runs the ``inspec`` tests on the actual instance.

``bin/kitchen destroy``
^^^^^^^^^^^^^^^^^^^^^^^

Removes the docker instance.

``bin/kitchen test``
^^^^^^^^^^^^^^^^^^^^

Runs all of the stages above in one go: i.e. ``destroy`` + ``converge`` + ``verify`` + ``destroy``.

``bin/kitchen login``
^^^^^^^^^^^^^^^^^^^^^

Gives you SSH access to the instance for manual testing.
