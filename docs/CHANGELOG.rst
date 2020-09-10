
Changelog
=========

`0.5.7 <https://github.com/saltstack-formulas/ufw-formula/compare/v0.5.6...v0.5.7>`_ (2020-09-10)
-----------------------------------------------------------------------------------------------------

Styles
^^^^^^


* **rubocop:** fix Rubocop offenses (\ `86126c0 <https://github.com/saltstack-formulas/ufw-formula/commit/86126c02f602006c19171f2282cbf1c26b0e2f08>`_\ )

`0.5.6 <https://github.com/saltstack-formulas/ufw-formula/compare/v0.5.5...v0.5.6>`_ (2020-09-10)
-----------------------------------------------------------------------------------------------------

Bug Fixes
^^^^^^^^^


* **state:** restart service when configuration has changed (\ `6de4e9a <https://github.com/saltstack-formulas/ufw-formula/commit/6de4e9ab7b015ae75ed21218adb9b8b2ba3986bb>`_\ )

`0.5.5 <https://github.com/saltstack-formulas/ufw-formula/compare/v0.5.4...v0.5.5>`_ (2020-07-20)
-----------------------------------------------------------------------------------------------------

Bug Fixes
^^^^^^^^^


* **service:** don't reload ufw service if service is disabled (\ `c953630 <https://github.com/saltstack-formulas/ufw-formula/commit/c953630e5f53f15d873981325a5f9b52f5f812e0>`_\ )

Continuous Integration
^^^^^^^^^^^^^^^^^^^^^^


* **kitchen:** use ``saltimages`` Docker Hub where available [skip ci] (\ `ffeed19 <https://github.com/saltstack-formulas/ufw-formula/commit/ffeed19c39447ba825fcc8d42ed70f673ae3a098>`_\ )

Styles
^^^^^^


* **libtofs.jinja:** use Black-inspired Jinja formatting [skip ci] (\ `830b8fe <https://github.com/saltstack-formulas/ufw-formula/commit/830b8fe0591bb51332920c8a39ed5ba1dd27a10c>`_\ )

`0.5.4 <https://github.com/saltstack-formulas/ufw-formula/compare/v0.5.3...v0.5.4>`_ (2020-05-30)
-----------------------------------------------------------------------------------------------------

Bug Fixes
^^^^^^^^^


* **debian:** avoid ``python-ufw`` installation (\ ``py2``\ -only) (\ `a636ee5 <https://github.com/saltstack-formulas/ufw-formula/commit/a636ee5406d51f106e49e8022b44c5ce997d9aec>`_\ ), closes `#19 <https://github.com/saltstack-formulas/ufw-formula/issues/19>`_
* **install:** use EPEL repo for ``amazonlinux-2`` (\ `481c897 <https://github.com/saltstack-formulas/ufw-formula/commit/481c8973f79947e074455dc5caf1d752eb11fdfc>`_\ )
* **libtofs:** “files_switch” mess up the variable exported by “map.jinja” [skip ci] (\ `f4fcf99 <https://github.com/saltstack-formulas/ufw-formula/commit/f4fcf992748566ab509e41514572ecdfc2b7a62e>`_\ )
* **release.config.js:** use full commit hash in commit link [skip ci] (\ `54ad9df <https://github.com/saltstack-formulas/ufw-formula/commit/54ad9dfe58923fc7578cfd9131e84d2e5b7846ae>`_\ )

Continuous Integration
^^^^^^^^^^^^^^^^^^^^^^


* **gemfile:** restrict ``train`` gem version until upstream fix [skip ci] (\ `a6151e9 <https://github.com/saltstack-formulas/ufw-formula/commit/a6151e96ee51329a478a431319fc73628d3c4f1a>`_\ )
* **gemfile.lock:** add to repo with updated ``Gemfile`` [skip ci] (\ `95f6515 <https://github.com/saltstack-formulas/ufw-formula/commit/95f651535e2c15a02bd584d4a38ba6b232c1fbb4>`_\ )
* **kitchen:** avoid using bootstrap for ``master`` instances [skip ci] (\ `caf6a71 <https://github.com/saltstack-formulas/ufw-formula/commit/caf6a713ccb6719f3e41b518b86fee90c15d7fde>`_\ )
* **kitchen:** use ``debian-10-master-py3`` instead of ``develop`` [skip ci] (\ `207b8b8 <https://github.com/saltstack-formulas/ufw-formula/commit/207b8b806e2018ed8ed7f3894982b8d403ac2d5d>`_\ )
* **kitchen:** use ``develop`` image until ``master`` is ready (\ ``amazonlinux``\ ) [skip ci] (\ `f37a77c <https://github.com/saltstack-formulas/ufw-formula/commit/f37a77c70659d43a904faf6652af23d38da4ac74>`_\ )
* **kitchen+travis:** remove ``master-py2-arch-base-latest`` [skip ci] (\ `9ae4f31 <https://github.com/saltstack-formulas/ufw-formula/commit/9ae4f31b8860c3fbe4c3f9ab22402682e5abda43>`_\ )
* **kitchen+travis:** upgrade matrix after ``2019.2.2`` release [skip ci] (\ `2f912e2 <https://github.com/saltstack-formulas/ufw-formula/commit/2f912e201c58f13c428c77a654e95bde898c2ef3>`_\ )
* **kitchen+travis:** use latest pre-salted images (\ `0df4fe4 <https://github.com/saltstack-formulas/ufw-formula/commit/0df4fe4cfbb9521d08a56b004bf706b5cedfd905>`_\ )
* **travis:** add notifications => zulip [skip ci] (\ `d47a1b7 <https://github.com/saltstack-formulas/ufw-formula/commit/d47a1b7f71fb6bd0e12b11c1d9b0fea42f404d25>`_\ )
* **travis:** apply changes from build config validation [skip ci] (\ `1276ce2 <https://github.com/saltstack-formulas/ufw-formula/commit/1276ce2411fbdd823b5334cb9d1a780b37d3232f>`_\ )
* **travis:** opt-in to ``dpl v2`` to complete build config validation [skip ci] (\ `106d528 <https://github.com/saltstack-formulas/ufw-formula/commit/106d5283f256488dfe465e21d8a1b3c8fa0469d7>`_\ )
* **travis:** quote pathspecs used with ``git ls-files`` [skip ci] (\ `0b8193f <https://github.com/saltstack-formulas/ufw-formula/commit/0b8193fd5a9f85f7c12ba8f887ff160cdda986b6>`_\ )
* **travis:** run ``shellcheck`` during lint job [skip ci] (\ `b998454 <https://github.com/saltstack-formulas/ufw-formula/commit/b998454cc401ce4758b8a8c9ab6f57d51b64eadf>`_\ )
* **travis:** update ``salt-lint`` config for ``v0.0.10`` [skip ci] (\ `95e8baa <https://github.com/saltstack-formulas/ufw-formula/commit/95e8baa9db5865076ab27eb876a42d310af67427>`_\ )
* **travis:** use ``major.minor`` for ``semantic-release`` version [skip ci] (\ `d83a85b <https://github.com/saltstack-formulas/ufw-formula/commit/d83a85be9580be5753ffcee656b328f5e580edf1>`_\ )
* **travis:** use build config validation (beta) [skip ci] (\ `9cf6cf3 <https://github.com/saltstack-formulas/ufw-formula/commit/9cf6cf350ed4362a69419ba191ce658c56ca6744>`_\ )
* **workflows/commitlint:** add to repo [skip ci] (\ `6341977 <https://github.com/saltstack-formulas/ufw-formula/commit/63419772eb7055d838a9ee3bf55c54d009b7fcc5>`_\ )

Performance Improvements
^^^^^^^^^^^^^^^^^^^^^^^^


* **travis:** improve ``salt-lint`` invocation [skip ci] (\ `510b016 <https://github.com/saltstack-formulas/ufw-formula/commit/510b0169da4c673130708f22c9a143cb4c86da70>`_\ )

Tests
^^^^^


* **without-ipv6:** add test pillar for suite (\ `6047fbf <https://github.com/saltstack-formulas/ufw-formula/commit/6047fbfc4c77eddd31c8507e0505e5d0b62fe67b>`_\ )

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
