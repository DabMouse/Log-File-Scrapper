use strict;
use warnings;

# Check if log file path is provided
die "Usage: perl logscrapper.pl <logfile>\n" unless @ARGV;
my $file = $ARGV[0];

# Read the log file
open(my $fh, '<', $file) or die "Could not open file '$file': $!";

# Variables to store extracted data
my ($design_name, $clock_name, $setup_time, $hold_time, $clock_delay, $slack, $max_freq);
my ($path_delay, $data_arrival, $data_required);
my ($total_dynamic, $total_static, $leakage, $switching, $internal, $vdd, $current);
my ($luts_used, $flipflops_used, $bram_used, $dsp_used, $routing_util);

while (<$fh>) {
    chomp;

    # Extract Timing Report
    $design_name = $1 if /Design Name:\s*(.+)/;
    $clock_name = $1 if /Clock Name:\s*(.+)/;
    $setup_time = $1 if /Setup Time:\s*([\d.]+) ns/;
    $hold_time = $1 if /Hold Time:\s*([\d.]+) ns/;
    $clock_delay = $1 if /Clock Delay:\s*([\d.]+) ns/;
    $slack = $1 if /Slack:\s*([\d.]+) ns/;
    $max_freq = $1 if /Max Frequency:\s*([\d.]+) MHz/;
    $path_delay = $1 if /Path Delay:\s*([\d.]+) ns/;
    $data_arrival = $1 if /Data Arrival Time:\s*([\d.]+) ns/;
    $data_required = $1 if /Data Required Time:\s*([\d.]+) ns/;

    # Extract Power Report
    $total_dynamic = $1 if /Total Dynamic Power:\s*([\d.]+) mW/;
    $total_static = $1 if /Total Static Power:\s*([\d.]+) mW/;
    $leakage = $1 if /Leakage Power:\s*([\d.]+) mW/;
    $switching = $1 if /Switching Power:\s*([\d.]+) mW/;
    $internal = $1 if /Internal Power:\s*([\d.]+) mW/;
    $vdd = $1 if /VDD Supply:\s*([\d.]+)V/;
    $current = $1 if /Current Drawn:\s*([\d.]+) mA/;

    # Extract Utilization Report
    $luts_used = $1 if /LUTs Used:\s*([\d,]+) \/ [\d,]+ \(([\d.]+)%\)/;
    $flipflops_used = $1 if /Flip-Flops Used:\s*([\d,]+) \/ [\d,]+ \(([\d.]+)%\)/;
    $bram_used = $1 if /BRAM Blocks Used:\s*([\d,]+) \/ [\d,]+ \(([\d.]+)%\)/;
    $dsp_used = $1 if /DSP Blocks Used:\s*([\d,]+) \/ [\d,]+ \(([\d.]+)%\)/;
    $routing_util = $1 if /Routing Utilization:\s*([\d.]+)%/;
}

close($fh);

# Create HTML report
my $html_file = "C:/Users/sharv/OneDrive/Desktop/PerlProject/vivado_report.html";
open(my $out, '>', $html_file) or die "Could not open '$html_file': $!";

print $out <<"HTML";
<!DOCTYPE html>
<html>
<head>
    <title>Vivado Simulation Report</title>
    <style>
        body { font-family: Arial, sans-serif; }
        h2 { color: #333366; }
        table { width: 60%; border-collapse: collapse; margin: 20px 0; }
        th, td { border: 1px solid #dddddd; text-align: left; padding: 8px; }
        th { background-color: #f2f2f2; }
    </style>
</head>
<body>
    <h2>Vivado Simulation Report</h2>

    <h3>Timing Report</h3>
    <table>
        <tr><th>Design Name</th><td>$design_name</td></tr>
        <tr><th>Clock Name</th><td>$clock_name</td></tr>
        <tr><th>Setup Time</th><td>$setup_time ns</td></tr>
        <tr><th>Hold Time</th><td>$hold_time ns</td></tr>
        <tr><th>Clock Delay</th><td>$clock_delay ns</td></tr>
        <tr><th>Slack</th><td>$slack ns</td></tr>
        <tr><th>Max Frequency</th><td>$max_freq MHz</td></tr>
        <tr><th>Path Delay</th><td>$path_delay ns</td></tr>
        <tr><th>Data Arrival Time</th><td>$data_arrival ns</td></tr>
        <tr><th>Data Required Time</th><td>$data_required ns</td></tr>
    </table>

    <h3>Power Report</h3>
    <table>
        <tr><th>Total Dynamic Power</th><td>$total_dynamic mW</td></tr>
        <tr><th>Total Static Power</th><td>$total_static mW</td></tr>
        <tr><th>Leakage Power</th><td>$leakage mW</td></tr>
        <tr><th>Switching Power</th><td>$switching mW</td></tr>
        <tr><th>Internal Power</th><td>$internal mW</td></tr>
        <tr><th>VDD Supply</th><td>$vdd V</td></tr>
        <tr><th>Current Drawn</th><td>$current mA</td></tr>
    </table>

    <h3>Utilization Report</h3>
    <table>
        <tr><th>LUTs Used</th><td>$luts_used</td></tr>
        <tr><th>Flip-Flops Used</th><td>$flipflops_used</td></tr>
        <tr><th>BRAM Blocks Used</th><td>$bram_used</td></tr>
        <tr><th>DSP Blocks Used</th><td>$dsp_used</td></tr>
        <tr><th>Routing Utilization</th><td>$routing_util%</td></tr>
    </table>

</body>
</html>
HTML


close($out);
print "✅ HTML report generated: $html_file\n";