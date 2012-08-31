RedmineApp::Application.routes.draw do
	# URL for items of type httpServer/XXX.git.  Some versions of rails has problems with multiple regex expressions, so avoid...
  	# Note that 'http_server_subdir' is either empty (default case) or ends in '/'.
	
	#scope Setting.plugin_redmine_git_hosting['httpServersubdir'], :as=>Setting.plugin_redmine_git_hosting['httpServerSubdir'] do
		match ':project_path/*path' => "git_http#show",:project_path=>/([^\/]+\/)*?[^\/]+\.git/
		# Handle the public keys plugin to my/account.
	        scope "my", :as =>"my" do
			resources :public_keys, :controller=>"gitolite_public_keys" 	
		end
		resources :public_keys
        
	        match 'my/account/public_key/:publid_key_id' =>"my#account" , :constraints=>{:method=>[:get]}
 	        match 'users/:id/edit/public_key/:public_key_id' => "users#edit" , :constraints => {:method=>[:get]}
   		# Handle hooks and mirrors
		match '/githooks' =>"gitolite_hooks#stub"
		match '/githooks/post-receive' => "gitlite_hooks#post_receive"
	        match '/githooks/test' =>"gitolite_hooks#test"
		match '/projects/:project_id/settings/repository/mirrors/new' => 'repository_mirrors#create', :constraints=>{:method=>[:get,:post]}
		match '/projects/:project_id/settings/repository/mirrors/edit/:id' => 'repository_mirrors#edit'
		match '/projects/:project_id/settings/repository/mirrors/push/:id' => 'repository_mirrors#push'
		match '/projects/:project_id/settings/repository/mirrors/update/:id' => 'repository_mirrors#update', :constraints => {:method=>[:post]}
		match '/projects/:project_id/settings/repository/mirrors/delete/:id' => 'repository_mirrors#destroy', :constraints => {:method=>[:get,:delete]}	 
		match '/projects/:project_id/settings/repository/post-receive-urls/new' => 'repository_post_receive_urls#create', :constraints => {:method=>[:get,:post]}
		match '/projects/:project_id/settings/repository/post-receive-urls/edit/:id' => 'repository_post_receive_urls#edit'
		match '/projects/:project_id/settings/repository/post-receive-urls/update/:id' => 'repository_post_receive_urls#update' , :constraints=> {:method=>[:post]}
		match '/projects/:project_id/settings/repository/post-receive-urls/delete/:id' => 'repository_post_reveice_urls#destroy' , :constraints=> {:method=>[:get,:delete]}	
	#end
end

