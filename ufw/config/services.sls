# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_package_install = tplroot ~ '.package.install' %}
{%- set sls_enable_service  = tplroot ~ '.service.enable' %}
{%- set sls_reload_service  = tplroot ~ '.service.reload' %}
{%- from tplroot ~ "/map.jinja" import ufw with context %}

{%- set enabled = ufw.get('enabled', False) %}

include:
  - {{ sls_package_install }}
  - {{ sls_enable_service }}
  - {{ sls_reload_service }}

# Services
{%- for service_name, service_details in ufw.get('services', {}).items() %}

  {%- set from_addr_raw = service_details.get('from_addr', [None]) %}
  {%- set from_addrs = [from_addr_raw] if from_addr_raw is string else from_addr_raw %}

  {%- for from_addr in from_addrs %}
    {%- set protocol    = service_details.get('protocol', None) %}
    {%- set deny        = service_details.get('deny', None) %}
    {%- set force_first = service_details.get('force_first', None) %}
    {%- set limit       = service_details.get('limit', None) %}
    {%- set method      = 'deny' if deny else ('limit' if limit else 'allow') %}
    {%- set from_port   = service_details.get('from_port', None) %}
    {%- set to_addr     = service_details.get('to_addr', None) %}
    {%- set to_port     = service_details.get('to_port', service_name) %}
    {%- set comment     = service_details.get('comment', None) %}

ufw-svc-{{ method }}-{{ service_name }}-{{ from_addr }}:
  ufw.{{ method }}:
    {%- if protocol is not none %}
    - protocol: {{ protocol }}
    {%- endif %}
    {%- if force_first is not none %}
    - force_first: {{ force_first }}
    {%- endif %}
    {%- if from_addr is not none %}
    - from_addr: {{ from_addr }}
    {%- endif %}
    {%- if from_port is not none %}
    - from_port: "{{ from_port }}"
    {%- endif %}
    {%- if to_addr is not none %}
    - to_addr: {{ to_addr }}
    {%- endif %}
    # Debian Jessie doesn't implement the **comment** directive
    # CentOS-6 throws an UTF-8 error
    {%- if comment is not none and salt['grains.get']('osfinger') != 'Debian-8' and salt['grains.get']('osfinger') != 'CentOS-6' %}
    - comment: '"{{ comment }}"'
    {%- endif %}
    - to_port: "{{ to_port }}"
    {%- if enabled %}
    - listen_in:
      - cmd: reload-ufw
    {%- endif %}
  {%- endfor %}
{%- endfor %}
