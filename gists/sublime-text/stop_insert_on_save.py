import sublime, sublime_plugin
import os.path

class StopInsertOnSave(sublime_plugin.EventListener):
    def on_post_save(self, view):
        if view.file_name() and not view.settings().get('command_mode'):
            view.run_command('exit_insert_mode')
