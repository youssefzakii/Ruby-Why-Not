class PostsController < ApplicationController
  before_action :find_post, only: %i[ show edit update destroy ]
  before_action :verify_ownership!, only: [:edit, :update, :destroy]
  # skip_before_action :authenticate_user!, only: %i[index]

  # GET /posts or /posts.json
  def index
    @posts = Post.where(hidden: false)
  end

  # GET /posts/1 or /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts or /posts.json
  def create
    @post = current_user.posts.build(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: "Post was successfully published." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: "Post was successfully modified." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy!

    respond_to do |format|
      format.html { redirect_to posts_path, status: :see_other, notice: "Post was successfully removed." }
      format.json { head :no_content }
    end
  end

  def flag!
    increment!(:flag_count)
    hide! if flag_count >= 3
  end

  def flag
    post = Post.find(params[:id])
    post.flag!
    redirect_to posts_path, notice: "Post has been flagged for review."
  end

  private
    def find_post
      @post = Post.find(params.expect(:id))
    end

    def post_params
      params.expect(post: [ :body ])
      params.require(:post).permit(:title, :body, :image)
    end

    def verify_ownership!
      redirect_to posts_path, alert: "Access denied" unless @post.user == current_user
    end

    def hide!
      update!(hidden: true)
    end
end
