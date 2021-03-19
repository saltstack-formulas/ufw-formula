# -*- coding: utf-8 -*-
# vim: ft=yaml
---
ufw:
  enabled: true
  settings:
    loglevel: 'low'
  applications:
    MySQL:
      comment: Allow MySQL
    Postgresql:
      limit: true
      comment: Limit Postgresql
    SSH223:
      deny: true
      comment: Deny Webscale SSH
    '*':
      deny: true
      from_addr: 10.0.0.0/8
  services:
    '*':
      deny: true
      from_addr:
        - 10.0.0.1
        - 10.0.0.2
    '22':
      protocol: tcp
      limit: true
      comment: Limit SSH
    '80':
      protocol: tcp
      deny: true
      comment: Deny HTTP
    '443':
      protocol: tcp
      comment: Allow HTTPS
    '1000':
      protocol: tcp
      deny: true
      force_first: false
      comment: Deny 1000 not as first
