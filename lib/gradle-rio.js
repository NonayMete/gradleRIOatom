'use babel'

import GradleRioView from './gradle-rio-view'
import { CompositeDisposable } from 'atom'
import request from 'request'
export default {

  gradleRioView: null,
  modalPanel: null,
  subscriptions: null,

  activate (state) {
    this.gradleRioView = new GradleRioView(state.gradleRioViewState)
    this.modalPanel = atom.workspace.addModalPanel({
      item: this.gradleRioView.getElement(),
      visible: false
    })

    // Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    this.subscriptions = new CompositeDisposable()

    // Register command that toggles this view
    this.subscriptions.add(atom.commands.add('atom-workspace', {
      'gradle-rio:toggle': () => this.toggle()
    }))
  },

  deactivate () {
    this.modalPanel.destroy()
    this.subscriptions.dispose()
    this.gradleRioView.destroy()
  },

  serialize () {
    return {
      gradleRioViewState: this.gradleRioView.serialize()
    }
  },

  toggle () {
    console.log('Running File')
    require('child_process').exec('cmd /c start "" cmd /c start gradleRIO.bat', function () {})
    // cmd /c start "" cmd /c "C:\Users\jakel\Desktop\test.bat"
    // return (
    //   this.modalPanel.isVisible() ? this.modalPanel.hide() : this.modalPanel.show()
    // )
  }

}
