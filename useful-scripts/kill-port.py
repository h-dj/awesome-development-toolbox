# -*- coding: UTF-8 -*-
import os


def is_port_used(port=8009, kill=False):
    """
    检查端口占用
    :param port:  端口
    :param kill: 是否终止端口
    :return:
    """
    cmd = 'netstat -ano | findstr {} | findstr  LISTENING'.format(port)
    print(cmd)
    result = os.popen(cmd).read()
    print(result)
    pid = None
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
        except Exception:
            import traceback
            traceback.print_exc()
        finally:
            if kill:
                if not pid:
                    raise Exception("pid is None")
                print(os.popen("taskkill /F /PID {0}".format(pid)).read())  # 结束进程
    else:
        print('{}端口没有被占用'.format(port))


if __name__ == '__main__':
    port = input("请求输入被占用端口：")
    kill = input("是否结束进程：")
    if port is not None and kill is not None:
        is_port_used(port, kill)
    else:
        is_port_used()
