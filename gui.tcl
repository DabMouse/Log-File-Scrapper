package require Tk

# GUI window title
wm title . "Vivado Log File Parser"

# Create UI elements
label .lbl -text "Select Log File:"
entry .file_entry -width 50
button .browse_btn -text "Browse" -command {
    set filename [tk_getOpenFile -filetypes {{"Log Files" "*.txt"}}]
    .file_entry delete 0 end
    .file_entry insert 0 $filename
}
button .generate_btn -text "Generate Report" -command {
    set logfile_path [.file_entry get]
    
    if {$logfile_path ne ""} {
        set output [catch {exec perl "C:/Users/sharv/OneDrive/Desktop/PerlProject/logscrapper.pl" $logfile_path} result]
        
        if {$output != 0} {
            tk_messageBox -message "Error: $result" -icon error -type ok
        } else {
            tk_messageBox -message "✅ Report Generated Successfully!" -icon info -type ok
            exec xdg-open "C:/Users/sharv/OneDrive/Desktop/PerlProject/vivado_report.html"
        }
    } else {
        tk_messageBox -message "⚠ Please select a log file first!" -icon warning -type ok
    }
}

# Layout UI elements
grid .lbl -row 0 -column 0
grid .file_entry -row 0 -column 1
grid .browse_btn -row 0 -column 2
grid .generate_btn -row 1 -column 1