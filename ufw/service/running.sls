# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_config_file = tplroot ~ '.config.file' %}
{%- from tplroot ~ "/map.jinja" import ufw with context %}

include:
  - {{ sls_config_file }}

{%- if ufw.get('enabled', False) %}

ufw-service-running-service-running:
  service.running:
    - name: {{ ufw.service.name }}
    - enable: true
    - require:
      - sls: {{ sls_config_file }}

{%- else %}

ufw-service-dead-service-dead:
  service.dead:
    - name: {{ ufw.service.name }}
    - enable: false
    - require:
      - sls: {{ sls_config_file }}

{%- endif %}
