# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PagesController, type: :controller do
  describe 'GET #show' do
    let(:valid_page) { 'home' }
    let(:invalid_page) { 'not_exists_page' }
    let(:valid_params) { { page: valid_page } }
    let(:invalid_params) { { page: invalid_page } }

    context 'when page is exists' do
      subject { get :show, params: valid_params }

      it { is_expected.to render_template "pages/#{valid_page}" }
    end

    context 'when page is not exists' do
      subject { get :show, params: invalid_params }

      it { is_expected.to render_template(file: "#{Rails.root}/public/404.html") }
      it { is_expected.to have_http_status :not_found }
    end
  end
end
