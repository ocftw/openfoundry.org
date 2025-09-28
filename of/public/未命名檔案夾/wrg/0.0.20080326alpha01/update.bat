IF NOT EXIST game goto DOWNLOAD
:UPDATE
cd game
"C:\Program Files\Subversion\bin\svn.exe" up
goto END
:DOWNLOAD
"C:\Program Files\Subversion\bin\svn.exe" co http://svn.openfoundry.org/wrg/trunk/game
goto END
:END
