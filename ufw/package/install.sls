# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import ufw with context %}

ufw-package-install-pkg-installed:
  pkg.installed:
    - name: {{ ufw.package }}

{%- for pkg in ufw.packages %}
ufw-package-{{ pkg }}-install-pkg-installed:
  pkg.installed:
    - name: {{ pkg }}
{%- endfor %}
