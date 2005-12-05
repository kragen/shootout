' The Computer Language Shootout
' http://shootout.alioth.debian.org/
' contributed by Isaac Gouy

Imports System

Public Module Harmonic
   Sub Main(ByVal CmdArgs() As String)
      Dim N As Integer = Int32.Parse(CmdArgs(0)) 
      Dim PartialSum As Double = 0.0
      For I As Integer = 1 To N 
         PartialSum += 1.0/I
      Next
      Console.WriteLine("{0:f9}", PartialSum)
   End Sub
End Module
