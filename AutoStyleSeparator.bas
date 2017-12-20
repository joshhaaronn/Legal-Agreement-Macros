Option Explicit

Public InsertionCount As Long

Sub AutomaticStyleSepForm()
'This Sub simply allows the Form to be called from the Macros Menu. 
    StyleSeparatorForm1.Show
End Sub

Sub AutomaticStyleSeparatorOptions()

'This sub passes an variable, As String, to RunHeadingAutoStyleSep based on the options selected in the StyleSeparatorForm1.

    If StyleSeparatorForm1.Heading1.Value = True Then    
        RunHeadingAutoStyleSep "Heading 1"
    End If

    If StyleSeparatorForm1.Heading2.Value = True Then
        RunHeadingAutoStyleSep "Heading 2"
    End If

    If StyleSeparatorForm1.Heading3.Value = True Then
        RunHeadingAutoStyleSep "Heading 3"
    End If

    If StyleSeparatorForm1.Heading4.Value = True Then
        RunHeadingAutoStyleSep "Heading 4"
    End If

    If StyleSeparatorForm1.Heading5.Value = True Then
        RunHeadingAutoStyleSep "Heading 5"
    End If

End Sub

Sub RunHeadingAutoStyleSep(strFind As String)
'This Sub accepts the String, which specifies the Heading level(s), as an arguement.
'It then automatically inserts the style separators to the specific headings based on the arguements passed.

Dim rng As Range
Dim rng1 As Range
Dim rngAll As Range
Dim rngParagraph As Range

    Set rngAll = ActiveDocument.Content
    Set rng = rngAll.Duplicate
    With rng.Find
        .ClearFormatting
        .Forward = True
        .Style = strFind
        Do While .Execute()
            rng.Select
           If Not rng.Paragraphs(1).IsStyleSeparator Then
                rng.MoveStartUntil Cset=.
                rng.Collapse
                rng.Select
                insertStyleSep
                InsertionCount = InsertionCount + 1
                Selection.Move Unit=wdCharacter, count=1
            Else
                rng.Collapse wdCollapseEnd
            End If
        Loop
    End With
End Sub

Sub insertStyleSep()
Dim rgSel As Range
Dim rgNew As Range

    Set rgSel = Selection.Range
    
    rgSel.InsertParagraph
    Set rgNew = rgSel.Duplicate
    
    rgNew.Move wdParagraph, 1
    rgNew.Select
    
    rgNew.Style = ActiveDocument.Styles(BodyText 1)
    
    rgSel.Select
    Selection.InsertStyleSeparator
    
    rgSel.Collapse wdCollapseEnd
    rgSel.Delete
            
End Sub