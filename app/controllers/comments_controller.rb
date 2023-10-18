# frozen_string_literal: true

class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def index
    @comments = Comment.all
  end

  def create; end
end
