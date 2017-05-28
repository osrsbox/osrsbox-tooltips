# This script requires:
# 1) Java (at least JRE)
# 2) YUI Compressor
# YUI compressor as a JAR is available from: https://github.com/yui/yuicompressor/downloads
# Download it, extract ZIP file, open yuicompressor-3.4.7/build
# Copy "yuicompressor-2.4.7.jar" to same folder as this script

# Combine all CSS files to temp.css
cat jquery-ui.css, additions.css | sc temp.css

# Minify the temp.css file using YUI Compressor
java -jar .\yuicompressor-2.4.7.jar .\temp.css -o .\osrsbox-tooltips.css

# Remove the temp.css file
Remove-Item .\temp.css

# Static header for new CSS file
$header = "/*! OSRSBOX Tooltips
*   Date: 27/05/2017
*   Author: PH01L
*   Website: osrsbox.com
*   License: MIT
*   Dependencies: JQuery UI CSS (included license below)
*/
"

# Read in minified CSS file
$file = Get-Content .\osrsbox-tooltips.css

# Append the header to top of final file
Set-Content .\osrsbox-tooltips.css –value $header, $file

# Move final file to parent directory
Move-Item -Path .\osrsbox-tooltips.css -Destination ..\docs\.\osrsbox-tooltips.css -force