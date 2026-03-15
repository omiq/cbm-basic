10 REM Shell-scripting style example: arguments, SYSTEM(), EXEC$()
20 REM Run: ./basic examples/scripting.bas [args...]
30 REM Or:  ./basic examples/scripting.bas "hello world"
40 PRINT "Program: "; ARG$(0)
50 PRINT "Arguments: "; ARGC()
60 FOR I = 1 TO ARGC()
70   PRINT "  "; I; ": "; ARG$(I)
80 NEXT I
90 IF ARGC() < 1 THEN PRINT "Usage: basic scripting.bas [name]": END
100 PRINT
110 PRINT "Hello, "; ARG$(1); "!"
120 PRINT
130 REM Run a command and get exit code
140 E = SYSTEM("date")
150 PRINT "Exit code of date: "; E
160 REM Run a command and capture output
170 O$ = EXEC$("whoami")
180 PRINT "User: "; O$
190 O$ = EXEC$("echo OK")
200 PRINT "Echo says: "; O$
210 END
