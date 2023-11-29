Attribute VB_Name = "Module1"
Sub Button1_Click()
'Assignment for Multiple_year_stock_data

'Sub stock_ticker()

'Create the loop through all sheets
   Dim WS As Worksheet
    For Each WS In ActiveWorkbook.Worksheets
    WS.Activate
    
 'Last Row
    LastRow = WS.Cells(Rows.Count, 1).End(xlUp).Row
    Dim Ticker_Name As String
    Dim Open_Price As Double
    Dim Close_Price As Double
    Dim Yearly_Change As Double
    Dim Percent_Change As Double
    Dim Volume As Double
    Volume = 0
    Dim Row As Double
    Row = 2
    Dim Column As Integer
    Column = 1
    Dim i As Long
    
    Cells(1, "I").Value = "Ticker"
    Cells(1, "J").Value = "Yearly Change"
    Cells(1, "K").Value = "Percent Change"
    Cells(1, "L").Value = "Total Stock Volume"
    
'Initial Open Price
    Open_Price = Cells(2, Column + 2).Value
    
'Set loop for Ticker
   For i = 2 To LastRow
    If Cells(i + 1, Column).Value <> Cells(i, Column).Value Then
    
    
'Ticker name
    Ticker_Name = Cells(i, Column).Value
    Cells(Row, Column + 8).Value = Ticker_Name
        
'Close Price
    Close_Price = Cells(i, Column + 5).Value
    
'Yearly Change
    Yearly_Change = Close_Price - Open_Price
    Cells(Row, Column + 9).Value = Yearly_Change
        
       
    If (Open_Price = 0 And Close_Price = 0) Then
        Percent_Change = 0
    ElseIf (Open_Price = 0 And Close_Price <> 0) Then
        Percent_Change = 1
    Else
        Percent_Change = Yearly_Change / Open_Price
        Cells(Row, Column + 10).Value = Percent_Change
        Cells(Row, Column + 10).NumberFormat = "0.00%"
        
    End If
    
    'Calculating Total Volume
        Volume = Volume + Cells(i, Column + 6).Value
        Cells(Row, Column + 11).Value = Volume
        
        Row = Row + 1
        
        Open_Price = Cells(i + 1, Column + 2)
        
        Volume = 0
        
        Else
            Volume = Volume + Cells(i, Column + 6).Value
        End If
        
        Next i
        
        'calculating the Last Row of Yearly Change on every Worksheets
            CLastRow = WS.Cells(Rows.Count, Column + 8).End(xlUp).Row
            
            For f = 2 To CLastRow
            If (Cells(f, Column + 9).Value > 0 Or Cells(f, Column + 9).Value = 0) Then
                Cells(f, Column + 9).Interior.ColorIndex = 10
            ElseIf Cells(f, Column + 9).Value < 0 Then
                Cells(f, Column + 9).Interior.ColorIndex = 3
                
            End If
            
        Next f
        
'part 2 challange
'Finding the Greatest % Increase, % Decrease,greatest value with Ticker

    Cells(2, Column + 14).Value = "Greatest % Increase"
    Cells(3, Column + 14).Value = "Greatest % Decrease"
    Cells(4, Column + 14).Value = "Greatest Total Volume"
    Cells(1, Column + 15).Value = "Ticker"
    Cells(1, Column + 16).Value = "Value"
    

    For X = 2 To CLastRow
        If Cells(X, Column + 10).Value = Application.WorksheetFunction.Max(WS.Range("K2:K" & CLastRow)) Then
            Cells(2, Column + 15).Value = Cells(X, Column + 8).Value
            Cells(2, Column + 16).Value = Cells(X, Column + 10).Value
            Cells(2, Column + 16).NumberFormat = "0.00%"
        ElseIf Cells(X, Column + 10).Value = Application.WorksheetFunction.Min(WS.Range("K2:K" & CLastRow)) Then
            Cells(3, Column + 15).Value = Cells(X, Column + 8).Value
            Cells(3, Column + 16).Value = Cells(X, Column + 10).Value
            Cells(3, Column + 16).NumberFormat = "0.00%"
        ElseIf Cells(X, Column + 11).Value = Application.WorksheetFunction.Max(WS.Range("L2:L" & CLastRow)) Then
            Cells(4, Column + 15).Value = Cells(X, Column + 8).Value
            Cells(4, Column + 16).Value = Cells(X, Column + 11).Value
        End If
        
    Next X
        
        
 Next WS

    

End Sub
