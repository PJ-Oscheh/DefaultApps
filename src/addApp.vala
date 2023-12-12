/* window.vala
 *
 * Copyright 2023 PJ Oschmann
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

namespace Defaultapps {
    [GtkTemplate (ui = "/io/github/pjoscheh/DefaultApps/addApp.ui")]
    public class AddApp : Adw.ApplicationWindow {

        [GtkChild]
        private unowned Gtk.Button btnCancel;

        [GtkChild]
        private unowned Gtk.Button btnAdd;

        private Gtk.ListBox lsBoxApps;
        private Adw.ActionRow ar;
        private WindowListener wl;

        public AddApp (Gtk.Application app,
                       Gtk.ListBox lsBoxApps,
                       Adw.ActionRow ar,
                       WindowListener wl) {
            Object (application: app);
            this.lsBoxApps = lsBoxApps;
            this.ar = ar;
            this.wl = wl;
        }

        [GtkCallback]
        public void btnCancelCallback(Gtk.Button source) {
            lsBoxApps.remove(ar);
            this.destroy();
        }

        [GtkCallback]
        public void btnAddCallback(Gtk.Button source) {
            print("Add callback\n");
            print ("TESTING FILE HANDLER! BRACE YOURSELVES!!\n");
            FileHandler fh = new FileHandler();
            fh.openDesktopEntry("/home/pj/org.musescore.MuseScore.desktop", "testProto");
            wl.invokeItemAdded();
            this.destroy();
        }

    }
}
