require 'rails_helper'

RSpec.describe PostsController, type: :controller do

  let(:user) { FactoryGirl.create(:user) }
  before { request.session[:user_id] = user.id }

  let(:blog_post) { FactoryGirl.create(:post) }

  describe "#new" do
    before { get :new }

    it "renders the new template" do
      expect(response).to render_template(:new)
    end

    it "assigns a post object" do
      expect(assigns(:post)).to be_a_new(Post)
    end
  end

  describe "#create" do
    describe "with valid attributes" do
      def valid_request
        post :create, post: FactoryGirl.attributes_for(:post)
      end

      it "saves a record to the database" do
        count_before = Post.count
        valid_request
        count_after = Post.count
        expect(count_after).to eq(count_before + 1)
      end

      it "redirects to the post's show page" do
        valid_request
        expect(response).to redirect_to(post_path(Post.last))
      end

      it "sets a flash message" do
        valid_request
        expect(flash[:notice]).to be
      end
    end

    describe "with invalid attributes" do
      def invalid_request
        post :create, post: FactoryGirl.attributes_for(:post).merge(title: nil)
      end

      it "doesn't save a record to the database" do
        count_before = Post.count
        invalid_request
        count_after = Post.count
        expect(count_after).to eq(count_before)
      end

      it "renders the new template" do
        invalid_request
        expect(response).to render_template(:new)
      end

      it "sets an alert message" do
        invalid_request
        expect(flash[:alert]).to be
      end
    end
  end

  describe "#show" do
    before do
      get :show, id: blog_post.id
    end

    it "renders the show template" do
      expect(response).to render_template(:show)
    end

    it "sets a post instance variable" do
      expect(assigns(:post)).to eq(blog_post)
    end
  end

  describe "#index" do
    it "renders the index template" do
      get :index
      expect(response).to render_template(:index)
    end

    it "assigns an instance variable to all posts in the DB" do
      blog_post
      p1  = Post.create FactoryGirl.attributes_for(:post).merge(title: "Hi Rails", body: "Hi Rails!")
      get :index
      expect(assigns(:posts)).to eq([blog_post, p1])
    end
  end

  describe "#edit" do
    it "renders the edit template" do
      get :edit, id: blog_post.id
      expect(response).to render_template(:edit)
    end
    it "sets an instance variable with the passed id" do
      get :edit, id: blog_post.id
      expect(assigns(:post)).to eq(blog_post)
    end
  end

  describe "#update" do
    describe "with valid params" do
      before do
        patch :update, id: blog_post.id, post: {title: "Hello Ruby"}
      end

      it "updates the record whose id is passed" do
        expect(blog_post.reload.title).to eq("Hello Ruby")
      end

      it "redirects to the show page" do
        expect(response).to redirect_to(post_path(blog_post))
      end

      it "sets a flash notice message" do
        expect(flash[:notice]).to be
      end

    end
    describe "with invalid params" do
      before do
        patch :update, id: blog_post.id, post: {title: ""}
      end
      it "doesnt update the record whose is passed" do
        expect(blog_post.title).to eq(blog_post.reload.title)
      end
      it "renders the edit template" do
        expect(response).to render_template(:edit)
      end
      it "sets an alert message" do
        expect(flash[:alert]).to be
      end
    end
  end

  describe "#destroy" do
    it "removes the post from the database" do
      blog_post
      count_before = Post.count
      delete :destroy, id: blog_post.id
      count_after  = Post.count
      expect(count_after).to eq(count_before - 1)
    end

    it "redirects to the index page" do
      delete :destroy, id: blog_post.id
      expect(response).to redirect_to(posts_path)
    end

    it "sets a flash message" do
      delete :destroy, id: blog_post.id
      expect(flash[:notice]).to be
    end

  end

end
