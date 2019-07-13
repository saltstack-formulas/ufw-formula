ufw:
  enabled: True
  settings:
    loglevel: 'low'
  applications:
    MySQL:
      comment: Allow MySQL
    Postgresql:
      limit: True
      comment: Limit Postgresql
    SSH223:
      deny: True
      comment: Deny Webscale SSH
    '*':
      deny: True
      from_addr: 10.0.0.0/8
  services:
    '*':
      deny: True
      from_addr:
        - 10.0.0.1
        - 10.0.0.2
    '22':
      protocol: tcp
      limit: True
      comment: Limit SSH
    '80':
      protocol: tcp
      deny: True
      comment: Deny HTTP
    '443':
      protocol: tcp
      comment: Allow HTTPS
