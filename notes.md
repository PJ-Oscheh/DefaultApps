#Notes
These are just reminders I wrote down while working on it. Mostly just basic
stuff. Figured I'd leave them here for future reference.

# Adding new window classes:
1. Add UI file and vala code
2. Add to `src/meson.build`



# Setting transience:
1. Call `<class>.set_transience_for` to set the transience
2. Set property `modal` to true in the child window
