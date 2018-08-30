Attribute VB_Name = "ModuloXML"
Sub From_XML_To_XL()

    Dim xWb As Workbook
    Dim xSWb As Workbook
    Dim xStrPath As String
    Dim xFileDialog As FileDialog
    Dim xFile As String
    Dim xCount As Long
    
    On Error GoTo ErrHandler
    Set xFileDialog = Application.FileDialog(msoFileDialogFolderPicker)
    xFileDialog.AllowMultiSelect = False
    xFileDialog.Title = "Select a folder [Seleccione una carpeta con archivos XML]"
    
    If xFileDialog.Show = -1 Then
        xStrPath = xFileDialog.SelectedItems(1)
    End If
    
    If xStrPath = "" Then Exit Sub
    Application.ScreenUpdating = False
    Set xSWb = ThisWorkbook
    xCount = 1
    xFile = Dir(xStrPath & "\*.xml")
    
    Do While xFile <> ""
        Set xWb = Workbooks.OpenXML(xStrPath & "\" & xFile)
        xWb.Sheets(1).UsedRange.Copy xSWb.Sheets(1).Cells(xCount, 1)
        xWb.Close False
        xCount = xSWb.Sheets(1).UsedRange.Rows.Count + 2
        xFile = Dir()
    Loop
    
    Application.ScreenUpdating = True
    xSWb.Save
    Exit Sub
ErrHandler:
    MsgBox "No hay archivos XML", , "J. Alfonso Mosco H."
End Sub

Sub LimpiaFormato()
    Sheets.Select
    Cells.Select
    Selection.ClearContents
    Selection.Delete Shift:=xlUp
    Range("A1").Select
End Sub
