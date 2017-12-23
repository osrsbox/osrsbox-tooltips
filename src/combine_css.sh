# This script requires:
# 1) Java (at least JRE)
# 2) YUI Compressor
# YUI compressor as a JAR is available from: https://github.com/yui/yuicompressor/downloads
# Download it, extract ZIP file, open yuicompressor-3.4.7/build
# Copy "yuicompressor-2.4.7.jar" to same folder as this script

# Combine all CSS files to temp.css
cat additions.css jquery-ui.css > temp.css

# Minify the temp.css file using YUI Compressor
java -jar yuicompressor-2.4.7.jar temp.css -o temp2.css

# Remove the temp.css file
rm temp.css

# Append the header to top of final file
echo "/* OSRSBOX Tooltips */\n/* Date: 2017/12/23 */\n/* Author: PH01L */\n/* Website: osrsbox.com */\n/* License: MIT */\n/* Dependencies: JQuery UI CSS (included license below) */" > osrsbox-tooltips.css

# Append minified CSS files
cat temp2.css >> osrsbox-tooltips.css

# Remove the temp2.css file
rm temp2.css

# Move final file to parent directory
mv osrsbox-tooltips.css ../docs/osrsbox-tooltips.css