# This script requires:
# 1) Java (at least JRE)
# 2) YUI Compressor
# YUI compressor as a JAR is available from: https://github.com/yui/yuicompressor/downloads
# Download it, extract ZIP file, open yuicompressor-3.4.7/build
# Copy "yuicompressor-2.4.7.jar" to same folder as this script

# Variable for the current project version and date last edited
$current_version = "1.0.1"
$current_date = "2018/11/11"

# Combine all JS files to temp.css
cat jquery-3.2.1.min.js, jquery-ui.js, additions.js | sc temp.js

# Minify the temp.js file using YUI Compressor
java -jar .\yuicompressor-2.4.7.jar .\temp.js -o .\osrsbox-tooltips.js

# Remove the temp.js file
Remove-Item .\temp.js

# Static header for new JS file
$header = "/* OSRSBOX Tooltips
*   Version: $current_version
*   Date: $current_date
*   Author: PH01L
*   Website: osrsbox.com
*   License: MIT
*   Dependencies: JQuery, JQuery UI (included license below)
*/
"

# Read in minified JS file
$file = Get-Content .\osrsbox-tooltips.js

# Append the header to top of final file
Set-Content .\osrsbox-tooltips.js -value $header, $file

# Set the output file name with versioning
$output_filename = "osrsbox-tooltips_" + $current_version + ".min.js"

# Move final file to parent directory
Move-Item -Path .\osrsbox-tooltips.js -Destination ..\docs\.\$output_filename -force

# Also create a normal file without versioning (for legacy applications)
Copy-Item -Path ..\docs\.\$output_filename -Destination ..\docs\.\osrsbox-tooltips.js -force

# Get the file hash of osrsbox-tooltips.js
$filePath = "..\docs\.\$output_filename"
$hasher = [System.Security.Cryptography.SHA384]::Create()
$content = Get-Content -Encoding byte $filePath
$hash = [System.Convert]::ToBase64String($hasher.ComputeHash($content))

# Document SHA384 hash value in Base64
Write-Output ($output_filename + ": " + "sha384-" + $hash)
