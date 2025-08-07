#!/bin/bash

set -e  # Exit on any error

echo "Starting libs folder consolidation and file reorganization..."

# Create shared libs directory inside slides folder
mkdir -p slides/shared-libs

# Find all slides/export/libs directories
export_libs_dirs=$(find . -path "*/slides/export/libs" -type d)

if [ -z "$export_libs_dirs" ]; then
    echo "Error: No slides/export/libs folders found!"
    echo "Make sure you've exported your presentations first."
    exit 1
fi

# Copy from the first libs folder found
first_libs=$(echo "$export_libs_dirs" | head -1)
echo "Copying libs from: $first_libs"
cp -r "$first_libs"/* slides/shared-libs/

# Count and remove redundant libs folders
libs_count=$(echo "$export_libs_dirs" | wc -l)
echo "Found $libs_count slides/export/libs folders"
echo "Removing redundant libs folders..."

echo "$export_libs_dirs" | while read -r libs_dir; do
    if [ -d "$libs_dir" ]; then
        rm -rf "$libs_dir"
        echo "Removed: $libs_dir"
    fi
done

# Update HTML references and process each index.html file
echo "Processing HTML files..."
html_files=$(find . -name "index.html" -path "*/slides/export/*")

if [ -n "$html_files" ]; then
    html_count=$(echo "$html_files" | wc -l)
    echo "Processing $html_count HTML files..."

    echo "$html_files" | while read -r html_file; do
        echo "Processing: $html_file"

        # Extract the directory containing the HTML file
        html_dir=$(dirname "$html_file")
        slides_dir=$(dirname "$html_dir")  # This should be the slides directory

        # Extract title from HTML file
        title=$(grep -i '<title>' "$html_file" | sed 's/<[^>]*>//g' | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')

        if [ -z "$title" ]; then
            echo "Warning: No title found in $html_file, using 'presentation' as default"
            title="presentation"
        fi

        # Sanitize title for filename
        sanitized_title=$(echo "$title" | sed 's/[[:space:]]\+/-/g' | sed 's/[^a-zA-Z0-9._-]//g' | sed 's/^-\+\|-\+$//g')

        if [ -z "$sanitized_title" ]; then
            sanitized_title="presentation"
        fi

        # Create new filename with .html extension
        new_filename="${sanitized_title}.html"
        new_filepath="${slides_dir}/${new_filename}"

        # Handle filename conflicts
        counter=1
        while [ -f "$new_filepath" ]; do
            new_filename="${sanitized_title}-${counter}.html"
            new_filepath="${slides_dir}/${new_filename}"
            counter=$((counter + 1))
        done

        # Calculate relative path from final location to shared-libs
        # From slides/ to slides/shared-libs/ = shared-libs/
        relative_path="shared-libs/"

        # Update HTML references to use correct relative path
        if [[ "$OSTYPE" == "darwin"* ]]; then
            sed -i "" "s|libs/|${relative_path}|g" "$html_file"
        else
            sed -i "s|libs/|${relative_path}|g" "$html_file"
        fi

        # Move and rename the file
        mv "$html_file" "$new_filepath"
        echo "Renamed and moved: $html_file -> $new_filepath"

        # Always remove the export folder
        if [ -d "$html_dir" ]; then
            rm -rf "$html_dir"
            echo "Removed export folder: $html_dir"
        fi
    done
else
    echo "Warning: No index.html files found in slides/export folders"
fi

echo ""
echo "✅ Consolidation and reorganization complete!"
echo "📁 Shared libs folder: ./slides/shared-libs"
echo "🔗 HTML files renamed and moved to slides directories"
echo "🗑️  All export folders removed"
