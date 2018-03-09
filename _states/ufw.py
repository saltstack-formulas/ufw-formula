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
    # let's just see if it starts with a number or a colon, for simplicity
    if re.match(r'^[0-9:]', host):
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


def allowed(name, app=None, interface=None, protocol=None,
            from_addr=None, from_port=None, to_addr=None, to_port=None, comment=None):

    rule = _as_rule("allow", app=app, interface=interface, protocol=protocol,
                   from_addr=from_addr, from_port=from_port, to_addr=to_addr, to_port=to_port, comment=comment)

    try:
        out = __salt__['ufw.add_rule'](rule)
    except (CommandExecutionError, CommandNotFoundError) as e:
        return _error(name, e.message)

    changes = False
    for line in out.split('\n'):
        if line.startswith("Skipping"):
            if __opts__['test']:
                return _unchanged(name, "{0} was already allowed".format(name))
                break
            else:
                continue
        if line.startswith("Rule added") or line.startswith("Rules updated"):
            changes = True
            break
        if __opts__['test']:
            return _test(name, "{0} would have been allowed".format(name))
            break
        return _error(name, line)

    if changes:
        return _changed(name, "{0} allowed".format(name), rule=rule)
    else:
        return _unchanged(name, "{0} was already allowed".format(name))

