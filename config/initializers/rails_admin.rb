RailsAdmin.config do |config|
  config.parent_controller = '::ApplicationController'
  config.authenticate_with do
    warden.authenticate! scope: :user
  end
  config.authorize_with :pundit
  config.current_user_method(&:current_user)

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app
    nestable
  end

  config.model Category do
    field :name
    field :parent_id, :enum do
      enum_method do
        :parent_enum
      end
    end
  end

  config.model Category do
    nestable_tree({
      max_depth: 2
    })
    nestable_list true
  end

  if defined?(WillPaginate)
    module WillPaginate
      module ActiveRecord
        module RelationMethods
          def per(value = nil) per_page(value) end
          def total_count() count end
        end
      end
      module CollectionMethods
        alias_method :num_pages, :total_pages
      end
    end
  end
end

module RailsAdmin
  module Extensions
    module Pundit
      class AuthorizationAdapter
        def authorize(action, abstract_model = nil, model_object = nil)
          record = model_object || abstract_model && abstract_model.model
          if action && !policy(record).send(*action_for_pundit(action))
            raise ::Pundit::NotAuthorizedError.new("not allowed to #{action} this #{record}")
          end
          @controller.instance_variable_set(:@_pundit_policy_authorized, true)
        end

        def authorized?(action, abstract_model = nil, model_object = nil)
          record = model_object || abstract_model && abstract_model.model
          policy(record).send(*action_for_pundit(action)) if action
        end

        def action_for_pundit(action)
          [:rails_admin?, action]
        end
      end
    end
  end
end

module RailsAdmin
  class ApplicationController
    rescue_from ::Pundit::NotAuthorizedError, with: :user_not_authorized

    private

    def user_not_authorized(exception)
      flash[:alert] = 'You are not authorized to perform this action.'
      redirect_to '/'
    end
  end
end
