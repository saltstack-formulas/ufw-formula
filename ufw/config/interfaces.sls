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

# Interfaces
{%- for interface_name, interface_details in ufw.get('interfaces', {}).items() %}
  {%- set comment = interface_details.get('comment', None) %}

ufw-interface-{{ interface_name }}:
  ufw.allowed:
    - interface: {{ interface_name }}
    {%- if comment is not none %}
    - comment: '"{{ comment }}"'
    {%- endif %}
    - listen_in:
      - cmd: reload-ufw

{%- endfor %}
