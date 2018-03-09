"""
Execution module for UFW.
"""

import re

def is_enabled():
    cmd = 'ufw status | grep "Status: active"'
    out = __salt__['cmd.run'](cmd, python_shell=True)
    return True if out else False

def get_default_incoming():
    cmd = 'ufw status verbose | grep "Default:"'
    out = __salt__['cmd.run'](cmd, python_shell=True)
    policy = re.search('(\w+) \(incoming\)', out).group(1)
    return policy

def get_default_outgoing():
    cmd = 'ufw status verbose | grep "Default:"'
    out = __salt__['cmd.run'](cmd, python_shell=True)
    policy = re.search('(\w+) \(outgoing\)', out).group(1)
    return policy

def set_enabled(enabled):
    if __opts__['test']:
        cmd = "ufw --dry-run "
    else:
        cmd = "ufw "
    cmd += '--force enable' if enabled else 'disable'
    __salt__['cmd.run'](cmd)

def add_rule(rule):
    if __opts__['test']:
        cmd = "ufw --dry-run "
    else:
        cmd = "ufw "
    cmd += rule
    out = __salt__['cmd.run'](cmd, python_shell=True)
    return out

