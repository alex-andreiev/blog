# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let!(:user) { create(:user) }
  let!(:posts) { create_list(:post, 10, user: user) }
  let(:post_id) { posts.first.id }
  let(:post_params) { attributes_for(:post, user_id: user.id) }

  describe 'GET #index' do
    subject { get :index }

    it { is_expected.to render_template 'index' }
    it { is_expected.to have_http_status 200 }
    it 'when assigns posts' do
      subject
      expect(assigns(:posts).length).to eq 10
    end
  end

  describe 'GET #show' do
    subject { get :show, params: params }

    let(:params) { { id: post_id } }

    it { is_expected.to render_template 'show' }
    it { is_expected.to have_http_status 200 }
    it 'when assigns post' do
      subject
      expect(assigns(:post)).not_to be_nil
    end
  end

  describe 'GET #new' do
    subject { get :new }

    before do
      allow_any_instance_of(described_class).to receive(:current_user) { user }
      sign_in user
    end

    it { is_expected.to render_template 'new' }
    it { is_expected.to have_http_status 200 }
    it 'when assigns post' do
      subject
      expect(assigns(:post)).not_to be_nil
    end
  end

  describe 'POST #create' do
    subject { post :create, params: params }

    before do
      allow_any_instance_of(described_class).to receive(:current_user) { user }
      sign_in user
    end

    let(:params) { { post: post_params } }

    it { is_expected.to redirect_to post_path(Post.last.id) }
    it { expect { subject }.to change(Post, :count).by(1) }

    describe 'with invalid params' do
      let(:post_params) { attributes_for(:post, title: nil, user_id: user.id) }

      it { is_expected.to render_template 'new' }
    end
  end

  describe 'GET #edit' do
    before do
      allow_any_instance_of(described_class).to receive(:current_user) { user }
      sign_in user
    end

    let(:params) { { id: post_id } }

    before { get :edit, params: params }

    it { is_expected.to render_template 'edit' }
    it 'when assigns post' do
      subject
      expect(assigns(:post).id).to eq post_id
    end
  end

  describe 'PUT #update' do
    subject { put :update, params: params }

    before do
      allow_any_instance_of(described_class).to receive(:current_user) { user }
      sign_in user
    end

    let(:post) { posts.first }
    let(:title) { Faker::Lorem.sentence }
    let(:params) { { id: post_id, post: { title: title } } }

    it { is_expected.to redirect_to post_path(post_id) }
    it 'when post updatet' do
      expect { subject }.to change { post.reload.title }
        .from(post.title).to(title)
    end

    describe 'with invalid params' do
      let(:title) { nil }

      it { is_expected.to render_template 'edit' }
    end
  end
end
