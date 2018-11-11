# This script requires:
# 1) Java (at least JRE)
# 2) YUI Compressor
# YUI compressor as a JAR is available from: https://github.com/yui/yuicompressor/downloads
# Download it, extract ZIP file, open yuicompressor-3.4.7/build
# Copy "yuicompressor-2.4.7.jar" to same folder as this script

# Variable for the current project version and date last edited
$current_version = "1.0.1"
$current_date = "2018/11/11"

# Combine all CSS files to temp.css
cat jquery-ui.css, additions.css | sc temp.css

# Minify the temp.css file using YUI Compressor
java -jar .\yuicompressor-2.4.7.jar .\temp.css -o .\osrsbox-tooltips.css

# Remove the temp.css file
Remove-Item .\temp.css

# Static header for new CSS file
$header = "/* OSRSBOX Tooltips
*   Version: $current_version
*   Date: $current_date
*   Author: PH01L
*   Website: osrsbox.com
*   License: MIT
*   Dependencies: JQuery UI CSS (included license below)
*/
"

# Read in minified CSS file
$file = Get-Content .\osrsbox-tooltips.css

# Append the header to top of final file
Set-Content .\osrsbox-tooltips.css -value $header, $file

# Get the file hash of osrsbox-tooltips.css
$filePath = "osrsbox-tooltips.css"
$hasher = [System.Security.Cryptography.SHA384]::Create()
$content = Get-Content -Encoding byte $filePath
$hash = [System.Convert]::ToBase64String($hasher.ComputeHash($content))

# Set the output file name with versioning
$output_filename = "osrsbox-tooltips_" + $current_version + ".min.css"

# Document SHA384 hash value in Base64
Write-Output ($output_filename + ": " + "sha386-" + $hash)

# Move final file to parent directory
Move-Item -Path .\osrsbox-tooltips.css -Destination ..\docs\.\$output_filename -force

# Also create a normal file without versioning (for legacy applications)
Copy-Item -Path ..\docs\.\$output_filename -Destination ..\docs\.\osrsbox-tooltips.css -force
