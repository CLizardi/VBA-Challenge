Attribute VB_Name = "Module1"
Sub stock_analysis():

    ' Declare all my variables
    Dim lastRow As Long
    Dim totalVolume As LongLong
    Dim openPrice As Double
    Dim closePrice As Double
    Dim ticker As String
    Dim dollarsChange As Double
    Dim percentChange As Double
    Dim summaryRow As Integer
    
    ' Set variables for bonus
    Dim biggestGain As Double
    Dim biggestGainTicker As String
    Dim biggestLoss As Double
    Dim biggestLossTicker As String
    Dim mostVolume As Double
    Dim mostVolumeTicker As String
    
    ' for each worksheet, do alllllll of the below
    For Each ws In Worksheets
        ws.Activate
        ' Set inital values for variables if necessary
        summaryRow = 2
        lastRow = Cells(Rows.Count, 1).End(xlUp).Row
        openPrice = Cells(2, 3).Value
        totalVolume = 0
        
        ' Set initial values for bonus variables
        biggestGain = 0
        biggestLoss = 0
        mostVolume = 0
        
        ' Set column headers for summary table
        Range("I1").Value = "Ticker"
        Range("J1").Value = "Yearly Change"
        Range("K1").Value = "Percent Change"
        Range("L1").Value = "Total Volume"
        Range("O2").Value = "Greatest % Increase"
        Range("O3").Value = "Greatest % Decrease"
        Range("O4").Value = "Greatest Total Volume"
        Range("P1").Value = "Ticker"
        Range("Q1").Value = "Value"
        
        ' Loop through every row with data
        For currentRow = 2 To lastRow
            ' Calculate totalVolume
            totalVolume = totalVolume + Cells(currentRow, 7)
            
            ' Check if next row and current have different tickers
            If Cells(currentRow + 1, 1).Value <> Cells(currentRow, 1).Value Then
            
                ' Set the values for current ticker
                ticker = Cells(currentRow, 1).Value
                closePrice = Cells(currentRow, 6).Value
                dollarsChange = closePrice - openPrice
                percentChange = dollarsChange / openPrice
                
                ' Write ticker values into summary table
                Cells(summaryRow, 9).Value = ticker
                Cells(summaryRow, 10).Value = dollarsChange
                Cells(summaryRow, 11).Value = percentChange
                Cells(summaryRow, 12).Value = totalVolume
                
                ' Set summary of yearly change to red or green
                If dollarsChange >= 0 Then
                    Cells(summaryRow, 10).Interior.ColorIndex = 4
                Else
                    Cells(summaryRow, 10).Interior.ColorIndex = 3
                End If
                
                ' Check bonus values
                If percentChange > biggestGain Then
                    biggestGain = percentChange
                    biggestGainTicker = ticker
                End If
                
                If percentChange < biggestLoss Then
                    biggestLoss = percentChange
                    biggestLossTicker = ticker
                End If
                
                If totalVolume > mostVolume Then
                    mostVolume = totalVolume
                    mostVolumeTicker = ticker
                End If
                
                ' Increment summaryRow
                summaryRow = summaryRow + 1
                
                ' Set openPrice for next ticker
                openPrice = Cells(currentRow + 1, 3).Value
                
                ' Reset totalVolume to 0
                totalVolume = 0
            End If
        Next currentRow
        
        ' Set column I to percentage
        Range("K2:K" & summaryRow).Style = "Percent"
        
        ' set bonus cells
        Range("P2").Value = biggestGainTicker
        Range("Q2").Value = biggestGain
        Range("P3").Value = biggestLossTicker
        Range("Q3").Value = biggestLoss
        Range("P4").Value = mostVolumeTicker
        Range("Q4").Value = mostVolume
        
        
    ' Go to the next worksheet
    Next ws
End Sub
