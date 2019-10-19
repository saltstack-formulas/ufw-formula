
Changelog
=========

`0.5.3 <https://github.com/saltstack-formulas/ufw-formula/compare/v0.5.2...v0.5.3>`_ (2019-10-19)
-----------------------------------------------------------------------------------------------------

Continuous Integration
^^^^^^^^^^^^^^^^^^^^^^


* **travis:** remove ``PyYAML`` workaround since fixed in ``salt-lint`` v0.0.9 (\ ` <https://github.com/saltstack-formulas/ufw-formula/commit/698dad8>`_\ )

Documentation
^^^^^^^^^^^^^


* **contributing:** remove to use org-level file instead [skip ci] (\ ` <https://github.com/saltstack-formulas/ufw-formula/commit/7dd4dc2>`_\ )
* **readme:** update link to ``CONTRIBUTING`` [skip ci] (\ ` <https://github.com/saltstack-formulas/ufw-formula/commit/374f48a>`_\ )

`0.5.2 <https://github.com/saltstack-formulas/ufw-formula/compare/v0.5.1...v0.5.2>`_ (2019-10-10)
-----------------------------------------------------------------------------------------------------

Bug Fixes
^^^^^^^^^


* **applications.sls:** fix ``salt-lint`` errors (\ ` <https://github.com/saltstack-formulas/ufw-formula/commit/71eed47>`_\ )
* **interfaces.sls:** fix ``salt-lint`` errors (\ ` <https://github.com/saltstack-formulas/ufw-formula/commit/0c9440e>`_\ )
* **open.sls:** fix ``salt-lint`` errors (\ ` <https://github.com/saltstack-formulas/ufw-formula/commit/c8b314b>`_\ )
* **services.sls:** fix ``salt-lint`` errors (\ ` <https://github.com/saltstack-formulas/ufw-formula/commit/afddcf6>`_\ )

Continuous Integration
^^^^^^^^^^^^^^^^^^^^^^


* **kitchen:** change ``log_level`` to ``debug`` instead of ``info`` (\ ` <https://github.com/saltstack-formulas/ufw-formula/commit/6559317>`_\ )
* **kitchen:** install required packages to bootstrapped ``opensuse`` [skip ci] (\ ` <https://github.com/saltstack-formulas/ufw-formula/commit/6359ebf>`_\ )
* **kitchen:** use bootstrapped ``opensuse`` images until ``2019.2.2`` [skip ci] (\ ` <https://github.com/saltstack-formulas/ufw-formula/commit/b057510>`_\ )
* **kitchen+travis:** apply ``opensuse-leap-15`` SCP error workaround (\ ` <https://github.com/saltstack-formulas/ufw-formula/commit/693b3c0>`_\ )
* **kitchen+travis:** replace EOL pre-salted images (\ ` <https://github.com/saltstack-formulas/ufw-formula/commit/5871288>`_\ )
* **platform:** add ``arch-base-latest`` (\ ` <https://github.com/saltstack-formulas/ufw-formula/commit/56f8336>`_\ )
* **yamllint:** add rule ``empty-values`` & use new ``yaml-files`` setting (\ ` <https://github.com/saltstack-formulas/ufw-formula/commit/bd53ce3>`_\ )
* merge travis matrix, add ``salt-lint`` & ``rubocop`` to ``lint`` job (\ ` <https://github.com/saltstack-formulas/ufw-formula/commit/7b1b3c9>`_\ )

`0.5.1 <https://github.com/saltstack-formulas/ufw-formula/compare/v0.5.0...v0.5.1>`_ (2019-08-25)
-----------------------------------------------------------------------------------------------------

Documentation
^^^^^^^^^^^^^


* **readme:** update testing section (\ `80a3734 <https://github.com/saltstack-formulas/ufw-formula/commit/80a3734>`_\ )

`0.5.0 <https://github.com/saltstack-formulas/ufw-formula/compare/v0.4.1...v0.5.0>`_ (2019-08-17)
-----------------------------------------------------------------------------------------------------

Features
^^^^^^^^


* **yamllint:** include for this repo and apply rules throughout (\ `38eb4dc <https://github.com/saltstack-formulas/ufw-formula/commit/38eb4dc>`_\ )

`0.4.1 <https://github.com/saltstack-formulas/ufw-formula/compare/v0.4.0...v0.4.1>`_ (2019-07-13)
-----------------------------------------------------------------------------------------------------

Code Refactoring
^^^^^^^^^^^^^^^^


* **kitchen+inspec:** move inline pillar to file (\ `0005375 <https://github.com/saltstack-formulas/ufw-formula/commit/0005375>`_\ )

Continuous Integration
^^^^^^^^^^^^^^^^^^^^^^


* **kitchen+travis:** modify matrix to include ``develop`` platform (\ `8699e9d <https://github.com/saltstack-formulas/ufw-formula/commit/8699e9d>`_\ )

`0.4.0 <https://github.com/saltstack-formulas/ufw-formula/compare/v0.3.0...v0.4.0>`_ (2019-05-21)
-----------------------------------------------------------------------------------------------------

Continuous Integration
^^^^^^^^^^^^^^^^^^^^^^


* **kitchen+travis:** test with pre-salted Docker images (\ `f27ec2e <https://github.com/saltstack-formulas/ufw-formula/commit/f27ec2e>`_\ )

Features
^^^^^^^^


* **tofs:** switch to tofs (\ `c05019a <https://github.com/saltstack-formulas/ufw-formula/commit/c05019a>`_\ )

`0.3.0 <https://github.com/saltstack-formulas/ufw-formula/compare/v0.2.0...v0.3.0>`_ (2019-05-14)
-----------------------------------------------------------------------------------------------------

Continuous Integration
^^^^^^^^^^^^^^^^^^^^^^


* **kitchen:** rename Kitchen config file (\ `2e59df4 <https://github.com/saltstack-formulas/ufw-formula/commit/2e59df4>`_\ )

Features
^^^^^^^^


* **semantic-release:** implement an automated changelog (\ `f25b404 <https://github.com/saltstack-formulas/ufw-formula/commit/f25b404>`_\ )
