# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import ufw with context %}

ufw-package-install-pkg-installed:
  {%- if grains.get('osfinger', '') == 'Amazon Linux-2' %}
  pkgrepo.managed:
    - name: epel
    - humanname: Extra Packages for Enterprise Linux 7 - $basearch
    - mirrorlist: https://mirrors.fedoraproject.org/metalink?repo=epel-7&arch=$basearch
    - enabled: 1
    - gpgcheck: 1
    - gpgkey: https://dl.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-7
    - failovermethod: priority
    - require_in:
      - pkg: ufw-package-install-pkg-installed
  {%- endif %}
  pkg.installed:
    - name: {{ ufw.package }}

{%- for pkg in ufw.packages %}
ufw-package-{{ pkg }}-install-pkg-installed:
  pkg.installed:
    - name: {{ pkg }}
{%- endfor %}
