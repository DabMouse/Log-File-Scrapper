## 🔍 Log File Scraper – GUI-Based HTML Report Generator

In VLSI design workflows, interpreting simulation output logs for timing and power analysis is both critical and time-consuming. This project proposes an automated log file analysis system tailored for Vivado-generated TCL logs. Using custom-built Perl and TCL scripts, the tool extracts essential performance metrics such as setup/hold violations, slack values, and dynamic/leakage power figures. The parsed data is structured into a clean, interactive HTML table, enabling designers to quickly visualize and interpret key results without manual inspection. This approach not only accelerates the verification loop but also reduces human error, making it especially valuable for iterative SoC and FPGA development. The project demonstrates how lightweight scripting can enhance productivity in digital design analysis.

---

## 🛠 Requirements

- [TCL Interpreter](https://www.activestate.com/products/tcl/)
- [Perl](https://www.perl.org/get.html)

---

## 🚀 How to Use

1. Open a terminal and run the GUI:

```bash
tclsh gui.tcl 
```
2. Use the file dialog to select your log file.
3. The script will call the Perl parser and generate an HTML report.

---

## 📌 Important

Ensure the path to logscrapper.pl is correctly set in gui.tcl.
Look for a line like this in the script:
```
set perlScriptPath "C:/Users/sharv/OneDrive/Desktop/PerlProject/logscrapper.pl"
```
Update it to match the actual location of your Perl script.

---

## 🧪 Output

After execution, the HTML report will be generated at:
```
C:/Users/sharv/OneDrive/Desktop/PerlProject/vivado_report.html
```
You can change this output path inside logscrapper.pl.

---

Feel free to customize and expand!!
