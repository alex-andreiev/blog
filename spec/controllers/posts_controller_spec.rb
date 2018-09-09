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
     it { subject; expect(assigns(:posts).count).to eq 10 }
  end

  describe 'GET #show' do
    let(:params){ { id: post_id } }

    subject { get :show, params: params }

    it { is_expected.to render_template 'show' }
    it { is_expected.to have_http_status 200 }
    it { subject; expect(assigns(:post)).not_to be_nil }
  end

  describe 'GET #new' do
    before do
      allow_any_instance_of(described_class).to receive(:current_user) {user}
      sign_in user
    end

    subject { get :new }

    it { is_expected.to render_template 'new' }
    it { is_expected.to have_http_status 200 }
    it { subject; expect(assigns(:post)).not_to be_nil }
  end

  describe 'POST #create' do
    before do
      allow_any_instance_of(described_class).to receive(:current_user) {user}
      sign_in user
    end

    let(:params) { { post: post_params } }

    subject { post :create, params: params }

    it { is_expected.to redirect_to post_path(Post.last.id) }
    it { expect { subject }.to change(Post, :count).by(1) }

    describe 'with invalid params' do
      let(:post_params) { attributes_for(:post, title: nil, user_id: user.id) }

      it { is_expected.to render_template 'new' }
    end
  end

  describe 'GET #edit' do
    before do
      allow_any_instance_of(described_class).to receive(:current_user) {user}
      sign_in user
    end

    let(:params) { { id: post_id } }

    before { get :edit, params: params }

    it { is_expected.to render_template 'edit' }
    it { subject; expect(assigns(:post).id).to eq post_id  }
  end

  describe 'PUT #update' do
    before do
      allow_any_instance_of(described_class).to receive(:current_user) {user}
      sign_in user
    end

    let(:post) { posts.first }
    let(:title) { Faker::Lorem.sentence }
    let(:params) { { id: post_id, post: { title: title } } }

    subject { put :update, params: params }

    it { is_expected.to redirect_to post_path(post_id) }
    it { expect { subject }.to change { post.reload.title }.from(post.title).to(title) }

    describe 'with invalid params' do
      let(:title) { nil }

      it { is_expected.to render_template 'edit' }
    end
  end
end
