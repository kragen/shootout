' The Computer Language Shootout
' http://shootout.alioth.debian.org/
' contributed by Isaac Gouy

Imports System

Public Module Harmonic
   Sub Main(ByVal cmdArgs() As String)
      Dim n As Integer = Int32.Parse(cmdArgs(0)) 
      Dim partialSum As Double = 0.0
      For i As Integer = 1 To n 
         partialSum += 1.0/i
      Next
      Console.WriteLine("{0:f9}", partialSum)
   End Sub
End Module
