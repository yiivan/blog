require 'rails_helper'

RSpec.describe Post, type: :model do

  describe "validations" do
    it "requires a post title" do
      p = Post.new(body: "Body.")
      p.valid?
      expect(p.errors).to have_key(:title)
    end

    it "requires the post title to have a minimum length of 7 characters" do
      p = Post.new(title: "Title", body: "Body." )
      p.valid?
      expect(p.errors).to have_key(:title)
    end

    it "requires a post body" do
      p = Post.new(title: "Post title")
      p.valid?
      expect(p.errors).to have_key(:body)
    end
  end

  describe ".body_snippet" do
    it "returns a maximum of a 100 characters with '...' of the body if it's more than a 100 characters long" do
      p = Post.new(title: "Post title", body: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.")
      result = p.body_snippet
      expect(result).to eq("Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore...")
    end

    it "returns the body if it's 100 characters or less" do
      p = Post.new(title: "Post title", body: "Lorem ipsum")
      expect(p.body_snippet).to eq("Lorem ipsum")
    end
  end

end
