# UFW management module
{%- set ufw = pillar.get('ufw', {}) %}
{%- if ufw.get('enabled', False) %}

ufw:
  pkg:
    - installed
  service.running:
    - enable: True

  {%- if ufw.get('defaults', {}).get('incoming', False) %}

ufw-default-incoming:
  ufw.default_incoming:
    - default: {{ufw.get('defaults', {}).get('incoming', 'allow')}}
    - require:
      - pkg: ufw

  {% endif %}

  {%- if ufw.get('defaults', {}).get('outgoing', False) %}

ufw-default-outgoing:
  ufw.default_outgoing:
    - default: {{ufw.get('defaults', {}).get('outgoing', 'deny')}}
    - require:
      - pkg: ufw

  {% endif %}

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
  {%- for app_name in ufw.get('applications', []) %}

ufw-app-{{app_name}}:
  ufw.allowed:
    - app: {{app_name}}
    - require:
      - pkg: ufw

  {%- endfor %}
  
  # Interfaces
  {%- for interface in ufw.get('interfaces', []) %}

ufw-interface-{{interface}}:
  ufw.allowed:
    - interface: {{interface}}
    - require:
      - pkg: ufw

  {%- endfor %}

  # Open
  {%- for from_addr in ufw.get('open', {}).get('from_addr', []) %}

ufw-open-{{from_addr}}:
  ufw.allowed:
    - from_addr: {{from_addr}}
    - require:
      - pkg: ufw

  {%- endfor %}

enable-ufw:
  ufw.enabled:
    - require:
      - pkg: ufw

{% else %}
  #ufw:
    #ufw:
      #- disabled
{% endif %}
