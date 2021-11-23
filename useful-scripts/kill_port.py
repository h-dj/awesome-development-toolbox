#!/usr/bin/python
# -*- coding: UTF-8 -*-
import os
import platform

"""
查找端口占用程序
netstat -tunlp | grep {0}
netstat -ano | findstr {0} | findstr  LISTENING


终止端口占用程序
taskkill /F /PID {0}
kill -9 {0}

"""


def get_os():
    return platform.system()


def is_windown():
    return get_os() == 'Windows'


def is_linux():
    return get_os() == 'Linux'


def find_port_programming_cmd(port):
    if is_windown():
        return 'netstat -ano | findstr {} | findstr  LISTENING'.format(port)
    if is_linux():
        return 'netstat -tunlp | grep {}'.format(port)

def get_pid(result):
    if is_windown():
        return result.split()[-1]
    if is_linux():
        result = result.split()[-1]
        return result[0:result.index('/')]

def kill_programming_cmd(pid):
    if is_windown():
        return 'taskkill /F /PID {0}'.format(pid)
    if is_linux():
        return 'kill -9 {0}'.format(pid)

def is_port_used():
    """
    检查端口占用
    :return:
    """
    port = input("输入端口<exit 退出>：")
    if(port != 'exit'):
        handler(port)
        is_port_used()


def handler(port):
    cmd = find_port_programming_cmd(port)
    print(cmd)
    result = os.popen(cmd).read()
    print(result)
    pid = None
    kill = None
    if result != '':
        try:
            pid = get_pid(result)
            kill = input("是否终止程序：Y/n")
        except Exception:
            import traceback
            traceback.print_exc()
        finally:
            if kill == 'Y':
                if not pid:
                    raise Exception("pid is None")
                # 结束进程)
                kill_cmd = kill_programming_cmd(pid)
                print(os.popen(kill_cmd).read())
    else:
        print('{}端口没有被占用'.format(port))


if __name__ == '__main__':
    is_port_used()
