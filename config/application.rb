# initialize observer

config.after_initialize do

        if config.action_controller.perform_caching

                ActiveRecord::Base.observers = ActiveRecord::Base.observers << GitHostingObserver

                ActiveRecord::Base.observers = ActiveRecord::Base.observers << GitHostingSettingsObserver



                ActionController::Dispatcher.to_prepare(:git_hosting_observer_reload) do

                        GitHostingObserver.instance.reload_this_observer

                end

                ActionController::Dispatcher.to_prepare(:git_hosting_settings_observer_reload) do

                        GitHostingSettingsObserver.instance.reload_this_observer

                end

        end

end
