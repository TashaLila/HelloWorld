'This is a program to make it snow.
'First we need to set a graphics mode
screen 20

dim running as integer
running = 1


'set up our master loop
while running = 1
'    print "hello"
    pset(200,200),15 'our first snowflake, it doesn't fall yet
wend
