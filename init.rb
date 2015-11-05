require 'redmine_shady'

Redmine::Plugin.register :redmine_shady do
  name "Redmine Shady"
  author "Ralph Gutkowski"
  description "Temporarily disable sending notifications triggered by user."
  version '0.5.0'
  url 'https://github.com/rgtk/redmine_shady'
  author_url 'https://github.com/rgtk'

  permission :use_shady_mode, { shady: [:create, :destroy] }

  menu :account_menu, :shady_mode, { controller: 'shady', action: 'create'},
       after: :my_account, html: { 'data-method' => 'post' },
       if: proc { User.current.allowed_to?(:use_shady_mode, nil, global: true) \
                  && User.current.pref[:shady].nil? }
end

RedmineShady.install
