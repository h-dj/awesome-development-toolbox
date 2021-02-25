#!/usr/bin/python
# -*- coding: UTF-8 -*-
import os


def is_port_used():
    """
    检查端口占用
    :return:
    """
    port = input("输入端口：")

    while port != 'exit':
        handler(port)
        port = input("输入端口：")


def handler(port):
    cmd = 'netstat -ano | findstr {} | findstr  LISTENING'.format(port)
    print(cmd)
    result = os.popen(cmd).read()
    print(result)
    pid = None
    kill = None
    if result != '':
        try:
            pid = result.split()[-1]
            result = os.popen('tasklist /FI "PID eq {0}'.format(pid)).read()
            """:type: str """
            print(result)
            position = result.rfind('=====')
            program_name = result[position + 5:].split()[0]
            print("占用的程序是{}".format(program_name))
            result = os.popen('wmic process where name="{0}" get executablepath'.format(program_name)).read()
            result = result.split()
            print("占用的程序所在位置：{}".format(result[1]))
            kill = input("是否终止程序：Y/n")
        except Exception:
            import traceback
            traceback.print_exc()
        finally:
            if kill == 'Y':
                if not pid:
                    raise Exception("pid is None")
                print(os.popen("taskkill /F /PID {0}".format(pid)).read())  # 结束进程
    else:
        print('{}端口没有被占用'.format(port))



if __name__ == '__main__':
    is_port_used()
