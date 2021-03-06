# frozen_string_literal: true

require 'grape-swagger'

module API
  module V1
    class Base < Grape::API
      mount API::V1::Posts

      add_swagger_documentation(
        api_version: 'v1',
        hide_documentation_path: true,
        mount_path: '/api/swagger_doc',
        hide_format: true
      )
    end
  end
end
