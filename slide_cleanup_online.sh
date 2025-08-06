#!/bin/bash

set -e  # Exit on any error

echo "Starting file reorganization with GitHub shared-libs references..."

# GitHub raw URL base for the shared-libs folder
GITHUB_RAW_BASE="https://raw.githubusercontent.com/ethanweed/LaCoBra/main/slides/shared-libs"

# Find all slides/export/libs directories and remove them
export_libs_dirs=$(find . -path "*/slides/export/libs" -type d)

if [ -n "$export_libs_dirs" ]; then
    # Count and remove local libs folders
    libs_count=$(echo "$export_libs_dirs" | wc -l)
    echo "Found $libs_count local slides/export/libs folders"
    echo "Removing local libs folders (will use GitHub shared-libs instead)..."

    echo "$export_libs_dirs" | while read -r libs_dir; do
        if [ -d "$libs_dir" ]; then
            rm -rf "$libs_dir"
            echo "Removed: $libs_dir"
        fi
    done
else
    echo "No local slides/export/libs folders found"
fi

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

        # Update HTML references to use GitHub raw URLs
        if [[ "$OSTYPE" == "darwin"* ]]; then
            # macOS version
            sed -i "" "s|libs/|${GITHUB_RAW_BASE}/|g" "$html_file"
        else
            # Linux version
            sed -i "s|libs/|${GITHUB_RAW_BASE}/|g" "$html_file"
        fi

        # Extract title from HTML file
        title=$(grep -i '<title>' "$html_file" | sed 's/<[^>]*>//g' | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')

        if [ -z "$title" ]; then
            echo "Warning: No title found in $html_file, using 'presentation' as default"
            title="presentation"
        fi

        # Sanitize title for filename (replace spaces with hyphens, remove special chars)
        sanitized_title=$(echo "$title" | sed 's/[[:space:]]\+/-/g' | sed 's/[^a-zA-Z0-9._-]//g' | sed 's/^-\+\|-\+$//g')

        # Ensure we have a valid filename
        if [ -z "$sanitized_title" ]; then
            sanitized_title="presentation"
        fi

        # Create new filename with .html extension
        new_filename="${sanitized_title}.html"
        new_filepath="${slides_dir}/${new_filename}"

        # Handle filename conflicts
        counter=1
        original_new_filepath="$new_filepath"
        while [ -f "$new_filepath" ]; do
            new_filename="${sanitized_title}-${counter}.html"
            new_filepath="${slides_dir}/${new_filename}"
            counter=$((counter + 1))
        done

        # Move and rename the file
        mv "$html_file" "$new_filepath"
        echo "Renamed and moved: $html_file -> $new_filepath"

        # Delete the export folder if it's empty
        if [ -d "$html_dir" ]; then
            # Check if export directory is empty
            if [ -z "$(ls -A "$html_dir" 2>/dev/null)" ]; then
                rmdir "$html_dir"
                echo "Removed empty export folder: $html_dir"
            else
                echo "Warning: Export folder not empty, skipping deletion: $html_dir"
                echo "Contents: $(ls -la "$html_dir")"
            fi
        fi
    done
else
    echo "Warning: No index.html files found in slides/export folders"
fi

echo ""
echo "✅ Reorganization complete!"
echo "🌐 HTML files now reference shared-libs directly from GitHub"
echo "🔗 GitHub shared-libs URL: $GITHUB_RAW_BASE"
echo "📁 HTML files renamed and moved to slides directories"
echo "🗑️  Local libs folders and empty export folders removed"
echo ""
echo "Your presentations will now load resources directly from:"
echo "  $GITHUB_RAW_BASE"
echo ""
echo "Benefits:"
echo "  ✅ Always uses the latest shared-libs version"
echo "  ✅ No local storage needed for libs"
echo "  ✅ Presentations work online without additional setup"
echo "  ⚠️  Requires internet connection to load presentations"
