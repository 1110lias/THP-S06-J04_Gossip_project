class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :update]

  # GET /comments or /comments.json
  def index
    @comments = Comment.all
  end

  # GET /comments/1 or /comments/1.json
  def show
  end

  # GET /comments/new
  def new
    @gossip = Gossip.find(params[:gossip_id])
    @comment = Comment.new
  end

  # GET /comments/1/edit
  def edit
    @comment = Comment.find(params[:id])
  end

  # POST /comments or /comments.json
  def create
    @gossip = Gossip.find(params[:gossip_id])
    @comment = @gossip.comments.new(comment_params)
    if @comment.save
      redirect_to gossips_path, notice: 'Gossip créé avec succès!'
      flash[:success] = "C'EST UN SUCCES!BRAVO!" #pour afficher le bandeau alerte (Voir html new)
    else
      render :new
      flash[:danger] = "C'EST FOIRE" #pour afficher le bandeau alerte (Voir html index)
    end
  end
    
  

  # PATCH/PUT /comments/1 or /comments/1.json
  def update
    @comment= Comment.find(params[:id])
    @comment.user_id = session[:user_id]
    if @comment.update(comment_params)
      flash[:success] = "C'EST UN SUCCES!BRAVO!" #pour afficher le bandeau alerte (Voir html new)
      redirect_to gossips_path, notice: 'Comment updated successfully!'
    else
      render :edit
      flash[:danger] = "C'EST FOIRE" #pour afficher le bandeau alerte (Voir html index)
    end
  end

  # DELETE /comments/1 or /comments/1.json
  def destroy
    @comment.destroy!

    respond_to do |format|
      format.html { redirect_to comments_url, notice: "Comment was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def comment_params
      params.require(:comment).permit(:gossip_id, :user_id, :content)
    end
end
