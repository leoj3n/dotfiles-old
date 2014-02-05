import sublime, sublime_plugin

class ReloadChromeExtensionsOnSave( sublime_plugin.EventListener ):

  def on_post_save( self, view ):
    # print 'ReloadChromeExtensionsOnSave: on_post_save'

    should_reload = view.settings().get('reload_chrome_extensions_on_save')

    if should_reload == 1:
      view.window().run_command( 'exec', {
        'cmd'   : ['open -a "Google Chrome Canary.app" http://reload.extensions -g'],
        'shell' : 'zsh'
      })
    # else:
      # print 'ReloadChromeExtensionsOnSave: Try setting reload_chrome_extensions_on_save in project settings'
