#coding=utf-8
'''
Gedit Support for Ren'Py 6.14 Launcher

How to use:
    Put this file under:
        .../renpy-sdk/launcher/
    and restart the Ren'Py launcher.



Copyright (c) 2012 Civa Lin 林雪凡 <larina.wf@gmail.com>
My blog: http://wfst.blogspot.com

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
'''

import renpy
import os
import sys
import subprocess

def which(program):
    '''測試指定的程式是否存在，如果存在，回傳完整程式路徑

        範例：
            >>> which('hg')

        program - 可以是完整路徑，也可以只含檔名。
                  只含檔名時，會去系統 PATH 列表中尋找實際位置。

        return ==> 指定程式不存在回傳 None，否則回傳完整程式路徑。
        '''
    def is_exe(filename):
        return os.path.isfile(filename) and os.access(filename, os.X_OK)
    dirname = os.path.dirname(program)
    if dirname: # 如果執行檔前面存在路徑，將輸入的 program 當成絕對路徑來測試
        if is_exe(program):
            return program
    else: # 如果執行檔前面沒有路徑，則從 PATH 中讀取可能路徑，依序確認
        for path in os.environ['PATH'].split(os.pathsep):
            exe_filename = os.path.join(path, program) # 完整測試路徑
            if is_exe(exe_filename):
                return exe_filename
            # windows下的執行檔 x 通常以 .exe 結尾。
            # 所以若當前平台為 windows，則還要追加測試……
            elif sys.platform.startswith('win'): # windows
                if is_exe(exe_filename + '.exe'):
                    return exe_filename + '.exe' # 回傳 x.exe 的路徑
    return None # 全部測試不過，回傳 None


class Editor(renpy.editor.Editor):
    '''Gedit Editor'''

    def begin(self, new_window=False, **kwargs):
        '''Collect variable'''
        self.var = {'new_window': new_window}
        self.gedit = which('gedit')
        self.env = dict(os.environ)

    def end(self, **kwargs):
        '''Recycle Data'''
        pass

    def open(self, filename, line=None, **kwargs):
        '''Open'''
        # cmd init
        cmd = [self.gedit, '-b']
        # New Window
        if self.var['new_window']:
            cmd.append('--new-window')
        # Line
        if line:
            cmd.extend((filename, '+{}'.format(line)))
        else:
            cmd.append(filename)
        # Start!
        subprocess.Popen(cmd, env = self.env)
