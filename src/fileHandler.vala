public class FileHandler : Object {

    public void openDesktopEntry(string filePath, string protocol) {
        int result = openDesktopEntryHandler(filePath, protocol);
        if (result != 0) {print("Failed to open file.\n"); }
        }

    private int openDesktopEntryHandler(string filePath, string protocol) {
        // 1. Open the File
        // 2. Read name and icon
        // 3. Try to find MimeType=. If found, append mimetype + ;
        // 3a. Not found? Append the whole pizza (MimeType=blahblahblah)
        // 4. If opened from /usr/... , save to ~/.local/share/applications
        // 4a. Append NoDisplay=true ^
        // 4b. If opened from ~/.local/..., just save.

        // I should be selected from the file selector!
        // Based on https://wiki.gnome.org/Projects/Vala/GIOSamples
        var file = File.new_for_path(filePath);

        // Check if file exists.
        if (!file.query_exists()) {
            stderr.printf("File %s doesn't exist.\n",file.get_path());
            return 1;
            }

        // Let's try to read it!
        try {
            var dis = new DataInputStream(file.read());
            string line;

            while ((line = dis.read_line(null)) != null) {
                print("%s\n", line);
                }
            }
        catch (Error e) {
            error ("Well this blows: %s", e.message);
            }

        return 0;
    }
}
