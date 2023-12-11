defaultapps_sources = [
  'main.vala',
  'application.vala',
  'window.vala',
  'addApp.vala',
  'windowListener.vala',
]

defaultapps_deps = [
  dependency('gtk4'),
  dependency('libadwaita-1', version: '>= 1.4'),
]

defaultapps_sources += gnome.compile_resources('defaultapps-resources',
  'defaultapps.gresource.xml',
  c_name: 'defaultapps'
)

executable('defaultapps', defaultapps_sources,
  dependencies: defaultapps_deps,
       install: true,
)
