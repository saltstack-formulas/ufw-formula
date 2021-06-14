from salt.exceptions import CommandExecutionError, CommandNotFoundError
import re
import socket


def _unchanged(name, msg):
    return {'name': name, 'result': True, 'comment': msg, 'changes': {}}


def _test(name, msg):
    return {'name': name, 'result': None, 'comment': msg, 'changes': {}}


def _error(name, msg):
    return {'name': name, 'result': False, 'comment': msg, 'changes': {}}


def _changed(name, msg, **changes):
    return {'name': name, 'result': True, 'comment': msg, 'changes': changes}


def _resolve(host):
    # pure IP address / netmask IPv4?
    if re.match(r'^([0-9\.])+(/[0-9]+)?$', host):
        return host

    # pure IPv6 address / netmask?
    if re.match(r'^([0-9a-f:]+)(/[0-9]+)?$', host):
        return host

    return socket.gethostbyname(host)


def _as_rule(method, app, interface, protocol, from_addr, from_port, to_addr, to_port, comment):
    cmd = [method]
    if app is not None:
      cmd.append("from")
      if from_addr is not None:
          cmd.append(from_addr)
      else:
          cmd.append("any")

      cmd.append("to")
      if to_addr is not None:
          cmd.append(to_addr)
      else:
          cmd.append("any")

      cmd.append("app")
      cmd.append(app)
    elif interface is not None:
        cmd.append("in")
        cmd.append("on")
        cmd.append(interface)
    else:
        if protocol is not None:
            cmd.append("proto")
            cmd.append(protocol)

        cmd.append("from")
        if from_addr is not None:
            cmd.append(_resolve(from_addr))
        else:
            cmd.append("any")

        if from_port is not None:
            cmd.append("port")
            cmd.append(_resolve(from_port))

        cmd.append("to")
        if to_addr is not None:
            cmd.append(to_addr)
        else:
            cmd.append("any")

        if to_port is not None:
            cmd.append("port")
            cmd.append(to_port)

    if comment is not None:
        cmd.append("comment")
        cmd.append(comment)
    real_cmd = ' '.join(cmd)
    return real_cmd


def _add_rule(method, name, app=None, interface=None, protocol=None,
              from_addr=None, from_port=None, to_addr=None, to_port=None, comment=None):

    if app and app.strip('"\' ') == '*':
        app = None
    if to_port and to_port.strip('"\' ') == '*':
        to_port = None

    rule = _as_rule(method, app=app, interface=interface, protocol=protocol,
                    from_addr=from_addr, from_port=from_port, to_addr=to_addr, to_port=to_port, comment=comment)

    try:
        out = __salt__['ufw.add_rule'](rule)
    except (CommandExecutionError, CommandNotFoundError) as e:
        if method.startswith('insert 1 deny') and "Invalid position '1'" in e.message:
            # This is probably the first rule to be added, so try again without "insert 1"
            return _add_rule('deny', name, app, interface, protocol, from_addr, from_port, to_addr, to_port, comment)
        return _error(name, e.message)

    adds = False
    inserts = False
    updates = False
    for line in out.split('\n'):
        if re.match('^Skipping', line):
            return _unchanged(name, "{0} is already configured".format(name))
            break
        if re.match('^Rule(s)? added', line):
            adds = True
            break
        if re.match('^Rule(s)? inserted', line):
            inserts = True
            break
        if re.match('^Rule(s)? updated', line):
            updates = True
            break
        if __opts__['test']:
            return _test(name, "{0} would have been configured".format(name))
            break

        if method.startswith('insert 1 deny') and "Invalid position '1'" in line:
            # This is probably the first rule to be added, so try again without "insert 1"
            return _add_rule('deny', name, app, interface, protocol, from_addr, from_port, to_addr, to_port, comment)
        return _error(name, line)

    if adds:
        return _changed(name, "{0} added".format(name), rule=rule)
    elif inserts:
        return _changed(name, "{0} inserted".format(name), rule=rule)
    elif updates:
        return _changed(name, "{0} updated".format(name), rule=rule)
    else:
        return _unchanged(name, "{0} was already configured".format(name))


def enabled(name, **kwargs):
    if __salt__['ufw.is_enabled']():
        return _unchanged(name, "UFW is already enabled")

    try:
        __salt__['ufw.set_enabled'](True)
    except (CommandExecutionError, CommandNotFoundError) as e:
        return _error(name, e.message)

    if __opts__['test']:
        return _test(name, "UFW would have been enabled")
    else:
        return _changed(name, "UFW is enabled", enabled=True)


def default_incoming(name, default):
    rule = "default {0} incoming".format(default)
    if __opts__['test']:
        return _test(name, "{0}: {1}".format(name, rule))

    current = __salt__['ufw.get_default_incoming']()

    if default != current:
        try:
            out = __salt__['ufw.add_rule'](rule)
        except (CommandExecutionError, CommandNotFoundError) as e:
            return _error(name, e.message)

        for line in out.split('\n'):
            if line.startswith("Default incoming policy changed to"):
                return _changed(name, "{0} set to {1}".format(name, default), rule=rule)
            return _error(name, line)

    return _unchanged(name, "{0} was already set to {1}".format(name, default))


def default_outgoing(name, default):
    rule = "default {0} outgoing".format(default)
    if __opts__['test']:
        return _test(name, "{0}: {1}".format(name, rule))

    current = __salt__['ufw.get_default_outgoing']()

    if default != current:
        try:
            out = __salt__['ufw.add_rule'](rule)
        except (CommandExecutionError, CommandNotFoundError) as e:
            return _error(name, e.message)

        for line in out.split('\n'):
            if line.startswith("Default outgoing policy changed to"):
                return _changed(name, "{0} set to {1}".format(name, default), rule=rule)
            return _error(name, line)

    return _unchanged(name, "{0} was already set to {1}".format(name, default))


def deny(name, app=None, interface=None, protocol=None,
         from_addr=None, from_port=None, to_addr=None, to_port=None, comment=None):

    return _add_rule('insert 1 deny', name, app, interface, protocol, from_addr, from_port, to_addr, to_port, comment)


def limit(name, app=None, interface=None, protocol=None,
          from_addr=None, from_port=None, to_addr=None, to_port=None, comment=None):

    return _add_rule('limit', name, app, interface, protocol, from_addr, from_port, to_addr, to_port, comment)


def allow(name, app=None, interface=None, protocol=None,
          from_addr=None, from_port=None, to_addr=None, to_port=None, comment=None):

    return _add_rule('allow', name, app, interface, protocol, from_addr, from_port, to_addr, to_port, comment)


def allowed(name, app=None, interface=None, protocol=None,
            from_addr=None, from_port=None, to_addr=None, to_port=None, comment=None):

    """
    allow() is aliased to allowed() to maintain backwards compatibility.
    """
    return allow(name, app, interface, protocol, from_addr, from_port, to_addr, to_port, comment)
