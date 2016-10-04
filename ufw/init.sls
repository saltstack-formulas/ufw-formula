# UFW management module
{%- set ufw = pillar.get('ufw', {}) %}
{%- if ufw.get('enabled', False) %}
{% set default_template = ufw.get('default_template', 'salt://ufw/templates/default.jinja') -%}
{% set sysctl_template = ufw.get('sysctl_template', 'salt://ufw/templates/sysctl.jinja') -%}

ufw:
  pkg.installed:
    - name: ufw
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
    - to_port: "{{service_name}}"
    - require:
      - pkg: ufw

    {%- endfor %}

  {%- endfor %}

  # Applications
  {%- for app_name, app_details in ufw.get('applications', {}).items() %}
    
    {%- for from_addr in app_details.get('from_addr', [None]) %}
      {%- set to_addr = app_details.get('to_addr', None) %}

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
    - require:
      - pkg: ufw
    - listen_in:
      - cmd: reload-ufw

    {%- endfor %}
  {%- endfor %}
  
  # Interfaces
  {%- for interface in ufw.get('interfaces', []) %}

ufw-interface-{{interface}}:
  ufw.allowed:
    - interface: {{interface}}
    - require:
      - pkg: ufw
    - listen_in:
      - cmd: reload-ufw

  {%- endfor %}

  # Open
  {%- for from_addr in ufw.get('open', {}).get('from_addr', []) %}

ufw-open-{{from_addr}}:
  ufw.allowed:
    - from_addr: {{from_addr}}
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
