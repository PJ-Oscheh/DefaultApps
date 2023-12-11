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
    [GtkTemplate (ui = "/io/github/pjoscheh/DefaultApps/window.ui")]
    public class Window : Adw.ApplicationWindow {

        // Widgets
        [GtkChild]
        private unowned Gtk.ListBox lsBoxApps;

        [GtkChild]
        private unowned Gtk.Button btnCreate;

        [GtkChild]
        private unowned Gtk.Label lblMyApps;

        [GtkChild]
        private unowned Adw.StatusPage sp;

        WindowListener wl = new WindowListener();

        // Callbacks
        [GtkCallback]
        public void testButton(Gtk.Button source) {
            handleTestButton(source);
        }

        public Window (Gtk.Application app) {
            Object (application: app);
            initialize();
        }

        private void initialize() {
            wl.itemAdded.connect(this.itemAdded);
            checkEmptyContent();
        }

        private void checkEmptyContent() {
            if (isGtkListBoxEmpty(lsBoxApps)) {
                sp.show();
                lblMyApps.hide();
                lsBoxApps.hide();
                }
            else {
                sp.hide();
                lblMyApps.show();
                lsBoxApps.show();
                }
            }

        // Handlers
        private void handleTestButton(Gtk.Button source) {
            Adw.ActionRow ar = createActionRow();
            openAddApp(ar);
        }

        private void itemAdded() {
            checkEmptyContent();
            }

        // Helper methods
        private Adw.ActionRow createActionRow() {
            Adw.ActionRow newActionRow = new Adw.ActionRow();
            newActionRow.title = "Waiting for app information...";
            lsBoxApps.insert(newActionRow, 0);
            return newActionRow;
        }

        private void openAddApp(Adw.ActionRow ar) {
            Adw.ApplicationWindow addAppWin = new AddApp(this.application, lsBoxApps, ar, wl);
            addAppWin.set_transient_for(this);
            addAppWin.show();
        }

        private bool isGtkListBoxEmpty(Gtk.ListBox lb) {
            if (lb.get_row_at_index(0).get_name() == null) {
                return true;
                }
            else {
                return false;
                }
            }

    }
}
