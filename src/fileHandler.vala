public class FileHandler : Object {

    string errReturn = "THERE_WAS_AN_ERROR_OH_NO";

    public void openDesktopEntry(string filePath, string protocol) {
        bool result = openDesktopEntryHandler(filePath, protocol);
        if (result == false) {print("Failed to open file.\n"); }
        }

    private bool openDesktopEntryHandler(string filePath, string protocol) {
        // 1. Open the File
        // 2. Read name and icon
        // 3. Try to find MimeType=. If found, append mimetype + ;
        // 3a. Not found? Append the whole pizza (MimeType=blahblahblah)
        // 4. If opened from /usr/... , save to ~/.local/share/applications
        // 4a. Append NoDisplay=true ^
        // 4b. If opened from ~/.local/..., just save.

        string fileText = readFile(filePath);
        string newText = findAndAppend(fileText, makeProtocol(protocol));
        bool result = writeFile(filePath, newText.strip());
        if (result == false) {
            print("There was an error writing the file\n");
            return false;
        }

        return true;
    }

    private string readFile(string filePath) {
            string text = "";
            // Based on https://wiki.gnome.org/Projects/Vala/GIOSamples
            var file = File.new_for_path(filePath);

            // Check if file exists.
            if (!file.query_exists()) {
                stderr.printf("File %s doesn't exist.\n",file.get_path());
                }

            // Let's try to read it!
            try {
                var dis = new DataInputStream(file.read());
                string line;

                while ((line = dis.read_line(null)) != null) {
                    text = text + "\n" + line;
                    }
                return text;
                }
            catch (Error e) {
                error ("Well this blows: %s", e.message);
                }

        return errReturn;
        }

    private bool writeFile(string filePath, string text) {
        try {
            var file = File.new_for_path(filePath);
            // Delete file if it's there
            if (file.query_exists()) {
                file.delete();
                }

            var dos = new DataOutputStream(file.create(FileCreateFlags.REPLACE_DESTINATION));
            dos.put_string(text);
            return true;
            }
        catch (Error e) {
            stderr.printf("%s\n", e.message);
            }

        return false;
        }

    private string makeProtocol(string protocol) {
        return "x-scheme-handler/"+protocol;
        }

    enum Strat {
            ADD_PROTOCOL,
            ADD_MIME_AND_PROTOCOL
            }

    private string findAndAppend(string text, string protocol) {
        string newText = text;
        Strat stratToUse;
        // Is "MimeType=" already in the text?
        if (text.contains("MimeType=") == true) {
            stratToUse = Strat.ADD_PROTOCOL;
            }
        else {
            stratToUse = Strat.ADD_MIME_AND_PROTOCOL;
            }

        switch(stratToUse) {
            case ADD_PROTOCOL: {
                string line;
                int start=0;
                int mimeTypeStart=0;
                // Find the MimeType= line and save offset to mimeTypeStart
                mimeTypeStart = newText.index_of("MimeType=",0);

                // Find end and tack on the new protocol
                string half1 = "";
                string half2 = "";
                for (int i=mimeTypeStart;i<newText.length;i++) {
                    if (newText[i] == '\n') {
                        half1 = newText.substring(0, i);
                        half2 = newText.substring(i, newText.length - i);
                        break;
                    }
                }

                half1 = half1+protocol+";";

                newText = half1+half2;
                return newText;
                }

            case ADD_MIME_AND_PROTOCOL: {
                newText = newText + @"\nMimeType=$protocol;";
                return newText;
            }

            default: return errReturn;

        }

    }
}
