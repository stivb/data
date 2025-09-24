setwd("c:/Users/oilca/Documents/Work/25-26/7COM1079/data/data/")
df <- read.csv("datasets2.csv", header = TRUE, stringsAsFactors = FALSE)

cat('<!DOCTYPE html>\n<html>\n<head>\n<title>Datasets List</title>\n')
cat('<script>
function copyToClipboard(id) {
    var copyText = document.getElementById(id);
    copyText.select();
    copyText.setSelectionRange(0, 99999);
    document.execCommand("copy");
}
</script>\n')
cat('<style>
.divbox { border:1px solid #ccc; padding:10px; margin:10px 0; }
.label { display:inline-block; width:120px; font-weight:bold; }
.inputbox { width:300px; }
.copybtn { margin-left:5px; }
</style>\n')
cat('</head>\n<body>\n')

for (i in 1:nrow(df)) {
    dataset_id <- df[i, "DatasetID"]
    dataset_name <- df[i, "DatasetName"]
    file_name <- df[i, "FileName"]
    url <- df[i, "URL"]
    subject <- df[i, "SubjectArea"]
    file_input_id <- paste0("file_input_", i)
    url_input_id <- paste0("url_input_", i)
    
    cat('<div class="divbox">\n')
    cat(sprintf('<span class="label">%s</span> ', dataset_id))
    cat(sprintf('<span class="label">%s</span> ', dataset_name))
    cat(sprintf('<span class="label">(%s)</span>', subject))
    cat('<br>\n')
    cat(sprintf('<input type="text" class="inputbox" id="%s" value="%s" readonly>', file_input_id, file_name))
    cat(sprintf('<button class="copybtn" onclick="copyToClipboard(\'%s\')">Copy</button><br>\n', file_input_id))
    cat(sprintf('<input type="text" class="inputbox" id="%s" value="%s" readonly>', url_input_id, url))
    cat(sprintf('<button class="copybtn" onclick="copyToClipboard(\'%s\')">Copy</button>\n', url_input_id))
    cat('</div>\n')
}

cat('</body>\n</html>\n')