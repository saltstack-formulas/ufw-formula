# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import ufw with context %}

{%- if ufw.get('enabled', False) %}

reload-ufw:
  cmd.wait:
    - name: ufw reload

{%- endif %}
