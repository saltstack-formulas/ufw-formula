# UFW management module
{%- set ufw = pillar.get('ufw', {}) %}
{%- if ufw.get('enabled', False) %}
{% from "ufw/map.jinja" import ufwmap with context %}
{% set default_template = ufw.get('default_template', 'salt://ufw/templates/default.jinja') -%}
{% set sysctl_template = ufw.get('sysctl_template', 'salt://ufw/templates/sysctl.jinja') -%}

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

    {%- for from_addr in service_details.get('from_addr', [None]) %}

      {%- set protocol  = service_details.get('protocol', None) %}
      {%- set from_port = service_details.get('from_port', None) %}
      {%- set to_addr   = service_details.get('to_addr', None) %}
      {%- set comment   = service_details.get('comment', None) %}

ufw-svc-{{service_name}}-{{from_addr}}:
  ufw.allowed:
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
    
    {%- for from_addr in app_details.get('from_addr', [None]) %}
      {%- set to_addr = app_details.get('to_addr', None) %}
      {%- set comment = app_details.get('comment', None) %}

{%- if from_addr != None%}
ufw-app-{{app_name}}-{{from_addr}}:
{%- else %}
ufw-app-{{app_name}}:
{%- endif %}
  ufw.allowed:
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

disable-logging:
  cmd.run:
    - name: ufw logging off
    - unless: "grep 'LOGLEVEL=off' /etc/ufw/ufw.conf"


{% else %}
  #ufw:
    #ufw:
      #- disabled
{% endif %}
