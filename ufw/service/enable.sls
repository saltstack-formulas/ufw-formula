# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import ufw with context %}

{%- if ufw.get('enabled', False) %}
{%- set loglevel = ufw.get('settings:loglevel', 'low') %}

enable-ufw:
  ufw.enabled

set-logging:
  cmd.run:
    - name: ufw logging {{ loglevel }}
    - unless: "grep 'LOGLEVEL={{ loglevel }}' /etc/ufw/ufw.conf"
{%- endif %}
