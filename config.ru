require 'bundler'
Bundler.require

$:.unshift File.expand_path("./../lib", __FILE__) #prendre en compte tous les fichiers dans le dossier lib
require 'controller'
run ApplicationController #lancer le serveur via la gem shotgun (cmd $ shotgun -p 4567 dans le terminal), surcouche à Rackup qui recharge automatiquement l'application en cas de modification (et donc relance automatiquement son serveur)