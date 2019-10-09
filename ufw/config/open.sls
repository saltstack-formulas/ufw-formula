# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_package_install = tplroot ~ '.package.install' %}
{%- set sls_enable_service  = tplroot ~ '.service.enable' %}
{%- set sls_reload_service  = tplroot ~ '.service.reload' %}
{%- from tplroot ~ "/map.jinja" import ufw with context %}

include:
  - {{ sls_package_install }}
  - {{ sls_enable_service }}
  - {{ sls_reload_service }}

# Open
{%- for open_addr, open_details in ufw.get('open', {}).items() %}
  {%- set comment = open_details.get('comment', None) %}

ufw-open-{{ open_addr }}:
  ufw.allowed:
    - from_addr: {{ open_addr }}
    {%- if comment is not none %}
    - comment: '"{{ comment }}"'
    {%- endif %}
    - listen_in:
      - cmd: reload-ufw

{%- endfor %}
