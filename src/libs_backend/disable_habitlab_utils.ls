{cfy, yfy} = require 'cfy'

{
  get_active_tab_id
  disable_interventions_in_all_tabs
} = require 'libs_backend/background_common'

{
  gexport
  gexport_module
} = require 'libs_common/gexport'

if chrome?tabs?query?
  chrome_tabs_query = yfy(chrome.tabs.query)

export disable_habitlab = cfy ->*
  localStorage.setItem 'habitlab_disabled', 'true'
  #yield disable_interventions_in_active_tab()
  #tabId = yield get_active_tab_id()
  #chrome.browserAction.setIcon {tabId: tabId, path: chrome.extension.getURL('icons/icon_disabled.svg')}
  yield disable_interventions_in_all_tabs()
  tabs = yield chrome_tabs_query {}
  for tab in tabs
    chrome.browserAction.setIcon {tabId: tab.id, path: chrome.extension.getURL('icons/icon_disabled.svg')}

export enable_habitlab = cfy ->*
  localStorage.removeItem 'habitlab_disabled'
  tabs = yield chrome_tabs_query {}
  for tab in tabs
    chrome.browserAction.setIcon {tabId: tab.id, path: chrome.extension.getURL('icons/icon.svg')}
  #tabId = yield get_active_tab_id()
  #chrome.browserAction.setIcon {tabId: tabId, path: chrome.extension.getURL('icons/icon.svg')}
  #chrome.browserAction.setIcon {path: chrome.extension.getURL('icons/icon.svg')}

export is_habitlab_enabled = cfy ->*
  return is_habitlab_enabled_sync()

export is_habitlab_enabled_sync = ->
  return localStorage.getItem('habitlab_disabled') != 'true'

gexport_module 'disable_habitlab_utils', -> eval(it)