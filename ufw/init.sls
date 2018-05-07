# UFW management module
{%- set ufw = pillar.get('ufw', {}) %}
{%- if ufw.get('enabled', False) %}
{% from "ufw/map.jinja" import ufwmap with context %}
{% set default_template = ufw.get('default_template', 'salt://ufw/templates/default.jinja') -%}
{% set sysctl_template = ufw.get('sysctl_template', 'salt://ufw/templates/sysctl.jinja') -%}
{% set settings_cfg = ufw.get('settings', {}) -%}
{% set loglevel = settings_cfg.get('loglevel', 'low') -%}

ufw:
  pkg.installed:
    - name: {{ ufwmap.pkg }}
  service.running:
    - enable: True
    - watch:
      - file: /etc/default/ufw
      - file: /etc/ufw/sysctl.conf

/etc/default/ufw:
  file.managed:
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - source: {{ default_template }}

/etc/ufw/sysctl.conf:
  file.managed:
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - source: {{ sysctl_template }}

/etc/ufw/applications.d:
  file.recurse:
    - user: root
    - group: root
    - file_mode: 644
    - clean: False
    - source: salt://ufw/files/applications.d

  # services
  {%- for service_name, service_details in ufw.get('services', {}).items() %}

    {%- set from_addr_raw = service_details.get('from_addr', [None]) -%}
    {%- set from_addrs = [from_addr_raw] if from_addr_raw is string else from_addr_raw -%}

    {%- for from_addr in from_addrs %}
      {%- set protocol  = service_details.get('protocol', None) %}
      {%- set deny      = service_details.get('deny', None) %}
      {%- set limit     = service_details.get('limit', None) %}
      {%- set method    = 'deny' if deny else ('limit' if limit else 'allow') -%}
      {%- set from_port = service_details.get('from_port', None) %}
      {%- set to_addr   = service_details.get('to_addr', None) %}
      {%- set comment   = service_details.get('comment', None) %}

ufw-svc-{{method}}-{{service_name}}-{{from_addr}}:
  ufw.{{method}}:
    {%- if protocol != None %}
    - protocol: {{protocol}}
    {%- endif %}
    {%- if from_addr != None %}
    - from_addr: {{from_addr}}
    {%- endif %}
    {%- if from_port != None %}
    - from_port: "{{from_port}}"
    {%- endif %}
    {%- if to_addr != None %}
    - to_addr: {{to_addr}}
    {%- endif %}
    {%- if comment != None %}
    - comment: '"{{comment}}"'
    {%- endif %}
    - to_port: "{{service_name}}"
    - require:
      - pkg: ufw
    - listen_in:
      - cmd: reload-ufw

    {%- endfor %}

  {%- endfor %}

  # Applications
  {%- for app_name, app_details in ufw.get('applications', {}).items() %}

    {%- set from_addr_raw = app_details.get('from_addr', [None]) -%}
    {%- set from_addrs = [from_addr_raw] if from_addr_raw is string else from_addr_raw -%}

    {%- for from_addr in from_addrs %}
      {%- set deny    = app_details.get('deny', None) %}
      {%- set limit   = app_details.get('limit', None) %}
      {%- set method  = 'deny' if deny else ('limit' if limit else 'allow') -%}
      {%- set to_addr = app_details.get('to_addr', None) %}
      {%- set comment = app_details.get('comment', None) %}

{%- if from_addr != None%}
ufw-app-{{method}}-{{app_name}}-{{from_addr}}:
{%- else %}
ufw-app-{{method}}-{{app_name}}:
{%- endif %}
  ufw.{{method}}:
    - app: '"{{app_name}}"'
    {%- if from_addr != None %}
    - from_addr: {{from_addr}}
    {%- endif %}
    {%- if to_addr != None %}
    - to_addr: {{to_addr}}
    {%- endif %}
    {%- if comment != None %}
    - comment: '"{{comment}}"'
    {%- endif %}
    - require:
      - pkg: ufw
    - listen_in:
      - cmd: reload-ufw

    {%- endfor %}
  {%- endfor %}

  # Interfaces
  {%- for interface_name, interface_details in ufw.get('interfaces', {}).items() %}
    {%- set comment = interface_details.get('comment', None) %}

ufw-interface-{{interface_name}}:
  ufw.allowed:
    - interface: {{interface_name}}
    {%- if comment != None %}
    - comment: '"{{comment}}"'
    {%- endif %}
    - require:
      - pkg: ufw
    - listen_in:
      - cmd: reload-ufw

  {%- endfor %}

  # Open
  {%- for open_addr, open_details in ufw.get('open', {}).items() %}
    {%- set comment = open_details.get('comment', None) %}

ufw-open-{{open_addr}}:
  ufw.allowed:
    - from_addr: {{open_addr}}
    {%- if comment != None %}
    - comment: '"{{comment}}"'
    {%- endif %}
    - require:
      - pkg: ufw
    - listen_in:
      - cmd: reload-ufw

  {%- endfor %}

enable-ufw:
  ufw.enabled:
    - require:
      - pkg: ufw

reload-ufw:
  cmd.wait:
    - name: ufw reload

set-logging:
  cmd.run:
    - name: ufw logging {{ loglevel }}
    - unless: "grep 'LOGLEVEL={{ loglevel }}' /etc/ufw/ufw.conf"

{% else %}
  #ufw:
    #ufw:
      #- disabled
{% endif %}
