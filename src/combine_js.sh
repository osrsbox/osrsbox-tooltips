# This script requires:
# 1) Java (at least JRE)
# 2) YUI Compressor
# YUI compressor as a JAR is available from: https://github.com/yui/yuicompressor/downloads
# Download it, extract ZIP file, open yuicompressor-3.4.7/build
# Copy "yuicompressor-2.4.7.jar" to same folder as this script

# Combine all JS files to temp.css
cat jquery-3.2.1.min.js jquery-ui.js additions.js > temp.js

# Minify the temp.js file using YUI Compressor
java -jar yuicompressor-2.4.7.jar temp.js -o temp2.js

# Remove the temp.js file
rm temp.js

# Append the header to top of final file
echo "/* OSRSBOX Tooltips */\n/* Date: 2017/12/23 */\n/* Author: PH01L */\n/* Website: osrsbox.com */\n/* License: MIT */\n/* Dependencies: JQuery UI CSS (included license below) */" > osrsbox-tooltips.js

# Append minified CSS files
cat temp2.js >> osrsbox-tooltips.js

# Remove the temp2.css file
rm temp2.js

# Move final file to parent directory
mv osrsbox-tooltips.js ../docs/osrsbox-tooltips.js