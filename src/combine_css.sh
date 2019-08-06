# This script requires:
# 1) Java (at least JRE)
# 2) YUI Compressor
# YUI compressor as a JAR is available from: https://github.com/yui/yuicompressor/downloads
# Download it, extract ZIP file, open yuicompressor-3.4.8/build
# Copy "yuicompressor-2.4.8.jar" to same folder as this script

# Variable for the current project version and date last edited
current_version="1.0.4"
current_date="2019/08/07"

# Combine all CSS files to temp.css
cat jquery-ui.css additions.css > temp.css

# Minify the temp.css file using YUI Compressor
java -jar yuicompressor-2.4.8.jar temp.css -o osrsbox-tooltips.css

# Remove the temp.css file
rm temp.css

# Static header for new CSS file
header="/* OSRSBOX Tooltips\n \
*   Version: $current_version\n \
*   Date: $current_date\n \
*   Author: PH01L\n \
*   Website: osrsbox.com\n \
*   License: MIT\n \
*   Dependencies: JQuery UI (included license below)\n \
*/\n \
"

# Set the output file name with versioning
output_filename="osrsbox-tooltips_$current_version.min.css"

echo -e "$header" > $output_filename
cat osrsbox-tooltips.css >> $output_filename

rm osrsbox-tooltips.css

# Get the file hash of osrsbox-tooltips.css
hash=$(openssl dgst -sha384 -binary $output_filename | openssl base64 -A)

# Document SHA384 hash value in Base64
echo "$output_filename: sha384-$hash"

# Move final file to parent directory
cp $output_filename ../docs/$output_filename

# Also create a normal file without versioning (for legacy applications)
cp $output_filename ../docs/osrsbox-tooltips.css

rm $output_filename