'This program makes it snow :)



Type WorldSettings
  As double GravY, GravX
  As integer WorldW, WorldH
End Type
Type Ball
    
  Public:
    as WorldSettings ptr Glob '' Global World Settings
    as Integer X, Y           '' Ball Position
    as integer Colour
  
  Declare Sub BoundsCheck()   '' Basic inside-box checking.
  Declare Sub Update()        '' Update ball position.
  Declare Property GravX() as Double
  Declare Property GravY() as Double
End Type

Property Ball.GravX() as Double

    Return This.Glob->GravX
  
End Property

Property Ball.GravY() as Double

    Return This.Glob->GravY
  
End Property

Sub Ball.BoundsCheck()

    '' Basic inside-box checking.
      '' Min
'  If This.X < 0 then This.X = 0
'  If This.Y < 0 then This.Y = 0
  
      '' Max
      
  
  If This.X > This.Glob->WorldW - 1 then This.X = (This.Glob->WorldW - 1)
  If This.Y > This.Glob->WorldH - 1 then This.Y = (This.Glob->WorldH - 1)

End Sub

Sub Ball.Update()

    '' We're actually calling the GET property of the ball
      '' to figure out whether we should use the ball's gravity,
      '' or the world's gravity!
  This.X += This.GravX
  This.Y += This.GravY

End Sub






Dim as WorldSettings Global

  '' Set our world variables which we will give to the balls.
Global.GravY = 1
Global.GravX = 0
Global.WorldW = 1024
Global.WorldH = 768
Screenres Global.WorldW, Global.WorldH, 32, 2

Dim myLila As Any Ptr = ImageCreate( 96, 182 )
Dim myWoods As Any Ptr = ImageCreate( 1024, 768 )
Dim mySnow As Any Ptr = ImageCreate( 7, 7 )
Dim myTree As Any Ptr = ImageCreate( 183, 272 )
Bload exepath() & "/gfx/lilatrans.bmp", myLila
Bload exepath() & "/gfx/painting.bmp", myWoods
Bload exepath() & "/gfx/snowdroptrans.bmp", mySnow
Bload exepath() & "/gfx/Tree.bmp", myTree
Dim as Ball Round(9000)

for dovar AS integer = 0 to 9000
    Round(dovar).X = Rnd*Global.WorldW
    Round(dovar).Y = Rnd*-10000
    Round(dovar).Colour = rgb(255, 255, 255)
    Round(dovar).Glob = @Global
next

'
  '' Lock our page buffer.
screenlock

Dim LilaY AS single
LilaY = 585
Dim TreeToggle AS Integer

TreeToggle = 1


    


Do  
    if multikey(&h1c) then
        if (TreeToggle = 1) then
            TreeToggle = 0
        else 
            TreeToggle = 1
        End if
    end if
    Put (0,0), myWoods
    if (TreeToggle = 1) then Put (270,250), myTree, trans
'    Put (450,LilaY), myLila, trans
'LilaY -= .1
    '' Update and draw all of our objects.
  for dovar as integer = lbound(Round) to ubound(Round)
      'if (point(Round(dovar).x,(Round(dovar).y + 1)) <> rgb(0, 0, 0) AND point(Round(dovar).x,(Round(dovar).y + 1)) <> -1) then print "obstructed"; point(Round(dovar).x,(Round(dovar).y + 1))
    if (point(Round(dovar).x,(Round(dovar).y + 1)) = rgb(0, 0, 0) OR point(Round(dovar).x,(Round(dovar).y + 1)) = -1 OR point(Round(dovar).x,(Round(dovar).y + 1)) = 0)then Round(dovar).Update()
    Round(dovar).BoundsCheck()

    put (Round(dovar).x -3,Round(dovar).y -3), mySnow, trans
    'circle (Round(Dovar).X, Round(Dovar).Y), 2, rgb(255, 255, 255),,,,f
    'pset (Round(dovar).x,Round(dovar).y),Round(dovar).Colour
  next
    if (TreeToggle = 1) then Put (270,250), myTree, trans  
    '' Flip the page.
  Screenunlock
    Sleep 8, 1
  Screenlock
  CLS

Loop until multikey(&h01)

  '' Unlock the screen buffer
Screenunlock