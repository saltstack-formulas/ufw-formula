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
    cmd = 'ufw --force enable' if enabled else 'ufw disable'
    __salt__['cmd.run'](cmd)


def add_rule(rule):
    cmd = "ufw " + rule
    out = __salt__['cmd.run'](cmd, python_shell=True)
    # __salt__['cmd.run']("ufw reload") # why reload after adding a rule? :/
    return out
